function part1
     y = [ 1200
           25 ]; % [C]
     A = 0.0109; % [m^2]
     mb = 0.2; % [kg]
     mw = 2.5; % [kg]
     cb = 3.85; % [J / kg * K]
     cw = 4.1813; % [J /kg * K]
     step = 0.1;
     x = 0:step:5;
     conduct(1:length(x)) = 160; % [J / s * m^2]

    ye = euler(x, y, step, conduct, A, mb, mw, cb, cw);
    yie = improvedEuler(x, y, step, conduct, A, mb, mw, cb, cw);

    plot(x, ye(1, :), x, ye(2, :), x, yie(1, :), x, yie(2, :));
end

function yie = euler(t, y, step, conduct, A, mb, mw, cb, cw)
    for i = 1:length(t)-1
        y(:, i+1) = y(:, i) + step * tempModel(y(:,i), conduct(i), A, mb, mw, cb, cw);
    end
    yie = y;
end
