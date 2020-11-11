function part2_3
    T = [-1500, -1000, -300, -50, -1, 1, 20, 50, 200, 400, 1000, 2000]; % [C]
    H = [178, 176, 168, 161, 160, 160, 160.2, 161, 165, 168, 174, 179]; % [C]
    A = 0.0109; % [m^2]
    mb = 0.2; % [kg]
    mw = 2.5; % [kg]
    cb = 3.85; % [J / kg * K]
    cw = 4.1813; % [J /kg * K]
    step = 0.1;
    x = 0:step:5;
    p = 4;
    ti = -1500:1:2000; % [C]
    approxY = zeros(length(ti), 1);

    for i=1:length(ti)
        approxY(i) = approx(T, H, p, ti(i));
    end

    for j=1:length(T)
        y = [ T(j)
             H(j)];
        yie = improvedEuler(x, y, step, approxY, A, mb, mw, cb, cw);
        plot(x, yie(1, :), x, yie(2, :));
    end
end
