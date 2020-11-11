function part1
     y = [ 1200
           25 ];
     step = 0.1;
     x = 0:step:5;
     conduct(1:length(x)) = 160; % [J / s * m^2]

    ye = euler(x, y, step, conduct);
    yie = improvedEuler(x, y, step, conduct);

    plot(x, ye(1, :), x, ye(2, :), x, yie(1, :), x, yie(2, :));
end

function yie = euler(t, y, step, conduct)
    for i = 1:length(t)-1
        y(:, i+1) = y(:, i) + step * tempModel(y(:,i), conduct(i));
    end
    yie = y;
end
