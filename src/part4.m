function part4
    chart_size=[10 10 800 600];
    T = [-1500, -1000, -300, -50, -1, 1, 20, 50, 200, 400, 1000, 2000]; % [C]
    H = [178, 176, 168, 161, 160, 160, 160.2, 161, 165, 168, 174, 179]; % [C]
    bar_num = 100000;
    time = 24 * 60 * 60; % [s]
    container_change_t = 30; % [s]
    bar_change_t = 5; % [s]
    station_num = 100;
    Tb_0 = 1200; % [C]
    Tw_0 = 25; % [C]
    cool_Temp = 125; % [C]

    % Calculations per 1  station:
    bars = bar_num / station_num;
    oil_change_num = bars / 2000;
    oil_change_t = oil_change_num * container_change_t; % [s]
    max_t = time - (oil_change_t +  container_change_t + (bars * bar_change_t)); % [s]
    bar_t = max_t / bars;
    Tw_max = 100;

    step = 0.01;
    x = 0:step:bar_t; % [s]
    p = 4;
    xStep = abs(T(end) - T(1)) / length(x);
    ti = T(1):xStep:T(end); % [C]
    approxH = zeros(length(ti), 1);

    for i=1:length(ti)
        approxH(i) = approx(T, H, p, ti(i));
    end

    % Simulation
    initial_mw = getMinMw(Tb_0, Tw_0, cool_Temp, step, x, approxH);
    initial_cool_t = getCoolingTime(initial_mw); % [s]
    initial_con_num = getContainerNum(bars, Tw_0, Tw_max, Tb_0, initial_mw, bar_t, initial_cool_t, step, x, approxH);
    initial_kw = getOilCost(initial_mw);
    initial_kc = getContainerCost(initial_mw);
    initial_cost = getCost(initial_kw, initial_kc, initial_con_num);

    max_mw = getMinMw(Tb_0, Tw_max, cool_Temp, step, x, approxH);

    mw_step = 0.05;
    x_mw = initial_mw:mw_step:max_mw;
    y_cost(1:length(x_mw)) = initial_cost;
    y_con(1:length(x_mw)) = initial_con_num;
    i=2;

    for mw = initial_mw + mw_step : mw_step:max_mw
        cool_t = getCoolingTime(mw); % [s]
        con_num = getContainerNum(bars, Tw_0, Tw_max, Tb_0, mw, bar_t, cool_t, step, x, approxH);
        kw = getOilCost(mw);
        kc = getContainerCost(mw);
        cost = getCost(kw, kc, con_num);
        y_cost(i) = cost;
        y_con(i) = con_num;
        i = i + 1;
    end
    
    plot(x_mw, y_con);

end

