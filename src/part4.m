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
    Tw_max = 100;

    a = 10;
    b = station_num;
    cost = [];
    stations = [];

    while true
        if length(cost) >= 2 && abs(cost(end) - cost(end -1)) > 100
            break;
        end
        station_x = round((a+b)/2);
        bars = round(bar_num / station_x);
        
        oil_change_num = bars / 2000;
        oil_change_t = oil_change_num * container_change_t; % [s]
        max_t = time - (oil_change_t +  container_change_t + (bars * bar_change_t)); % [s]
        bar_t = max_t / bars;

        step = 0.01;
        x = 0:step:bar_t; % [s]
        p = 4;
        xStep = abs(T(end) - T(1)) / length(x);
        ti = T(1):xStep:T(end); % [C]
        approxH = zeros(length(ti), 1);

        for i=1:length(ti)
            approxH(i) = approx(T, H, p, ti(i));
        end

        initial_mw = getMinMw(Tb_0, Tw_0, cool_Temp, step, x, approxH);
        initial_cool_t = getCoolingTime(initial_mw); % [s]
        initial_con_num = getContainerNum(bars, Tw_0, Tw_max, Tb_0, initial_mw, bar_t, initial_cool_t, step, x, approxH);
        initial_kw = getOilCost(initial_mw, bars, initial_con_num);
        initial_kc = getContainerCost(initial_mw);
        initial_cost = getCost(initial_kw, initial_kc, initial_con_num);

        max_mw = getMinMw(Tb_0, Tw_max, cool_Temp, step, x, approxH);

        mw_step = 0.1;
        x_mw = initial_mw:mw_step:max_mw;
        y_cost(1:length(x_mw)) = initial_cost;
        y_con(1:length(x_mw)) = initial_con_num;
        k=2;

        for mw = initial_mw + mw_step : mw_step:max_mw
            cool_t = getCoolingTime(mw); % [s]
            con_num = getContainerNum(bars, Tw_0, Tw_max, Tb_0, mw, bar_t, cool_t, step, x, approxH);
            kw = getOilCost(mw, bars, con_num);
            kc = getContainerCost(mw);
            cost = getCost(kw, kc, con_num);
            y_cost(k) = cost;
            y_con(k) = con_num;
            k = k + 1;
        end

        fig=figure('Renderer', 'painters', 'Position', chart_size);
        plot(x_mw, y_con);
        title(sprintf('Przebieg ilosci zbiornikow wzgledem masy m_w przy ilosci pretow: %d', bars));
        xlabel('Masa plynu chlodzacego m_w [kg]');
        ylabel('Ilosc zbiornikow');
        saveas(fig,sprintf('../assets/part4/ilosc-zbiornikow-%d', station_x), 'png');
        close;

        stations(end + 1) = station_x;
        cost(length(stations)) = min(y_cost);
        a = station_x;
    end
    fig=figure('Renderer', 'painters', 'Position', chart_size);
    plot(stations, cost);
    title('Stosunek kosztu pojedynczej stacji do liczby stacji chlodzacych');
    xlabel('Liczba stacji chlodzacych');
    ylabel('Koszt [PLN]');
    saveas(fig, '../assets/part4/koszt', 'png');
    close;
end

