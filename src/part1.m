function part1
    chart_size=[10 10 800 600];
    Tb = [1200, 800, 1100, 1200, 800, 1100, 1100, 1100, 1100, 1100]; % [C]
    Tw = [25, 25, 70, 25, 25, 70, 70, 70, 70, 70]; % [C]
    Tbt = [107.7, 79.1, 142.1, 105.7, 78.2, 150.1, 116.6, 99.1, 141.2, 140.9]; % [C]
    Twt = [105.1, 78.0, 139.1, 105.5, 78.1, 138.2, 105.1, 88.1, 139.8, 140.1]; % [C]
    mw = [2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 5, 10, 2.5, 2.5]; % [kg]
    t = [3, 3, 3, 5, 5, 2, 2, 2, 4, 5];
    A = 0.0109; % [m^2]
    mb = 0.2; % [kg]
    cb = 3.85; % [J / kg * K]
    cw = 4.1813; % [J /kg * K]
    stepH = [0.001, 0.01, 0.1, 1];

    for i=1:length(stepH)
        y = [ Tb(1)
            Tw(1) ]; % [C]
        x = 0:stepH((i)):t(1);
        h(1:length(x)) = 160; % [J / s * m^2]
        ye = myEuler(x, y, stepH(i), h, A, mb, mw(1), cb, cw);
        yie = improvedEuler(x, y, stepH(i), h, A, mb, mw(1), cb, cw);

        fig=figure('Renderer', 'painters', 'Position', chart_size);

        plot(x, ye(1, :), x, ye(2, :), x, yie(1, :), x, yie(2, :));
        title('Przebiegi czasowe temperatury preta oraz oleju chlodzacego');
        xlabel('t [s]');
        ylabel(['T [' char(176) 'C]']);
        legend('T_b przyblizona metoda Eulera', 'T_w przyblizona metoda Eulera', 'T_b obliczona  ulepszona funkcja Eulera','T_w obliczona ulepszona funkcja Eulera');

        saveas(fig,sprintf('../assets/part1/krok-h-%d', i), 'png');
        close;
    end

    if exist('../assets/part1/euler-wyniki.csv', 'file')==2
      delete('../assets/part1/euler-wyniki.csv');
    end

    if exist('../assets/part1/ulepszony-euler-wyniki.csv', 'file')==2
      delete('../assets/part1/ulepszony-euler-wyniki.csv');
    end

    for j=1:length(Tb)
        step = 0.1;
        y = [ Tb(j)
               Tw(j) ]; % [C]
        x = 0:step:t(j);
        h(1:length(x)) = 160; % [J / s * m^2]
        ye = myEuler(x, y, step, h, A, mb, mw(j), cb, cw);
        yie = improvedEuler(x, y, step, h, A, mb, mw(j), cb, cw);

        fig=figure('Renderer', 'painters', 'Position', chart_size);

        plot(x, ye(1, :), x, ye(2, :), x, yie(1, :), x, yie(2, :));
        title('Przebiegi czasowe temperatury preta oraz oleju chlodzacego');
        xlabel('t [s]');
        ylabel(['T [' char(176) 'C]']);
        legend('T_b przyblizona metoda Eulera', 'T_w przyblizona metoda Eulera', 'T_b przyblizona ulepszona metoda Eulera','T_w przyblizona ulepszona metoda Eulera');

        saveas(fig,sprintf('../assets/part1/przebieg-czasowy-%d', j), 'png');
        close;

        Tbtye = round(ye(1, end), 4);
        TbtyeRE = round(relativeError(Tbt(j), Tbtye), 4);
        Twtye = round(ye(2, end), 4);
        TwtyeRE = round(relativeError(Twt(j), Twtye), 4);

        end_values_Euler = [Tbt(j), Twt(j), Tbtye, TbtyeRE, Twtye, TwtyeRE];
        writematrix(end_values_Euler,'../assets/part1/euler-wyniki.csv','WriteMode','append');

        Tbtyie = round(yie(1, end), 4);
        TbtyieRE = round(relativeError(Tbt(j), Tbtyie), 4);
        Twtyie = round(yie(2, end), 4);
        TwtyieRE = round(relativeError(Twt(j), Twtyie), 4);

        end_values_improved_Euler = [Tbt(j), Twt(j), Tbtyie, TbtyieRE, Twtyie, TwtyieRE];
        writematrix(end_values_improved_Euler,'../assets/part1/ulepszony-euler-wyniki.csv','WriteMode','append');
    end
end
