function part4
    T = [-1500, -1000, -300, -50, -1, 1, 20, 50, 200, 400, 1000, 2000]; % [C]
    H = [178, 176, 168, 161, 160, 160, 160.2, 161, 165, 168, 174, 179]; % [C]
    bar_num = 100000;
    time = 24 * 60 * 60; % [s]
    container_change_t = 30; % [s]
    bar_change_t = 5; % [s]
    m_b = 0.25; % [kg]
    container_cool_t = m_b * 0.15 * 60 * 60; % [s]
    station_num = 100;
    Tb_0 = 1200; % [C]
    Tw_0 = 25; % [C]
    cool_T = 125; % [C]

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

    min_mw = getMinMw(Tb_0, Tw_0, cool_T, bar_t, step, x, approxH);

end
