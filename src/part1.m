function part1
    chart_size=[10 10 800 600];
    Tb = [1200, 800, 1100, 1200, 800, 1100, 1100, 1100, 1100, 1100];
    Tw = [25, 25, 70, 25, 25, 70, 70, 70, 70, 70];
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
            ye = euler(x, y, stepH(i), h, A, mb, mw(1), cb, cw);
            yie = improvedEuler(x, y, stepH(i), h, A, mb, mw(1), cb, cw);

            fig=figure('Renderer', 'painters', 'Position', chart_size);
            plot(x, ye(1, :), x, ye(2, :), x, yie(1, :), x, yie(2, :));
            title('Przebiegi czasowe temperatury preta oraz oleju chlodzacego');
            xlabel('t [s]');
            ylabel(['T [' char(176) 'C]']);
            legend('T_b obliczona funkcja Eulera', 'T_w obliczona funkcja Eulera', 'T_b obliczona  ulepszona funkcja Eulera','T_w obliczona ulepszona funkcja Eulera');
            saveas(fig,sprintf('../assets/part1/krok-h-%d', i), 'png');
            close;
    end

    for j=1:length(Tb)
        step = 0.1;
        y = [ Tb(j)
               Tw(j) ]; % [C]
        x = 0:step:t(j);
        h(1:length(x)) = 160; % [J / s * m^2]
        ye = euler(x, y, step, h, A, mb, mw(j), cb, cw);
        yie = improvedEuler(x, y, step, h, A, mb, mw(j), cb, cw);

        fig=figure('Renderer', 'painters', 'Position', chart_size);
        plot(x, ye(1, :), x, ye(2, :), x, yie(1, :), x, yie(2, :));
        title('Przebiegi czasowe temperatury preta oraz oleju chlodzacego');
        xlabel('t [s]');
        ylabel(['T [' char(176) 'C]']);
        legend('T_b obliczona funkcja Eulera', 'T_w obliczona funkcja Eulera', 'T_b obliczona  ulepszona funkcja Eulera','T_w obliczona ulepszona funkcja Eulera');
        saveas(fig,sprintf('../assets/part1/przebieg-czasowy-%d', j), 'png');
        end_values = [ye(1, end), ye(2, end), yie(1, end), yie(2, end)];
        writematrix(end_values,'../assets/part1/przebieg-czasowy.txt','WriteMode','append')
        close;
    end
end

function yie = euler(t, y, step, conduct, A, mb, mw, cb, cw)
    for i = 1:length(t)-1
        y(:, i+1) = y(:, i) + step * tempModel(y(:,i), conduct(i), A, mb, mw, cb, cw);
    end
    yie = y;
end
