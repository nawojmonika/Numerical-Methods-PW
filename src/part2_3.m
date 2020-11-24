function part2_3
    chart_size=[10 10 800 600];
    T = [-1500, -1000, -300, -50, -1, 1, 20, 50, 200, 400, 1000, 2000]; % [C]
    H = [178, 176, 168, 161, 160, 160, 160.2, 161, 165, 168, 174, 179]; % [J / s * m^2]
    Tb = [1200, 800, 1100, 1200, 800, 1100, 1100, 1100, 1100, 1100]; % [C]
    Tw = [25, 25, 70, 25, 25, 70, 70, 70, 70, 70]; % [C]
    Tbt = [107.7, 79.1, 142.1, 105.7, 78.2, 150.1, 116.6, 99.1, 141.2, 140.9]; % [C]
    Twt = [105.1, 78.0, 139.1, 105.5, 78.1, 138.2, 105.1, 88.1, 139.8, 140.1]; % [C]
    t = [3, 3, 3, 5, 5, 2, 2, 2, 4, 5];
    mw = [2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 5, 10, 2.5, 2.5]; % [kg]
    A = 0.0109; % [m^2]
    mb = 0.2; % [kg]
    cb = 3.85; % [J / kg * K]
    cw = 4.1813; % [J /kg * K]
    step = 0.1;
    p = 4;

    if exist('../assets/part2/wyniki.csv', 'file')==2
       delete('../assets/part2/wyniki.csv');
    end

    for j=1:length(Tb)
        y = [ Tb(j)
             Tw(j)];
        x = 0:step:t(j);
        xStep = abs(T(end) - T(1)) / length(x);
        ti = T(1):xStep:T(end); % [C]
        approxh = zeros(length(ti), 1);

        for i=1:length(ti)
            approxh(i) = approx(T, H, p, ti(i));
        end

        h(1:length(x)) = 160; % [J / s * m^2]
        yie = improvedEuler(x, y, step, h, A, mb, mw(j), cb, cw);
        approxYie = improvedEuler(x, y, step, approxh, A, mb, mw(j), cb, cw);

        fig=figure('Renderer', 'painters', 'Position', chart_size);
        plot(x, yie(1, :), x, yie(2, :), x, approxYie(1, :), x, approxYie(2, :));
        title({'Przebiegi czasowe temperatury preta oraz oleju chlodzacego', 'dla aproksymowanego wspolczynnika przewodnictwa cieplnego h'});
        xlabel('t [s]');
        ylabel(['T [' char(176) 'C]']);
        legend('T_b ze stalym h', 'T_w ze stalym h', 'T_b z aproksymowanym h','T_w z aproksymowanym h');
        saveas(fig,sprintf('../assets/part2/zmienny-h-%d', j), 'png');
        close;

        Tbtyie = round(approxYie(1, end), 4);
        TbtyieRE = round(relativeError(Tbt(j), Tbtyie), 4);
        Twtyie = round(approxYie(2, end), 4);
        TwtyieRE = round(relativeError(Twt(j), Twtyie), 4);

        end_values_improved_Euler = [Tbt(j), Twt(j), Tbtyie, TbtyieRE, Twtyie, TwtyieRE];
        writematrix(end_values_improved_Euler,'../assets/part2/wyniki.csv','WriteMode','append');
    end
end
