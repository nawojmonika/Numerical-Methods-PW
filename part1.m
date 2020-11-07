function part1
     y = [ 1200
           25 ];
     h = 1e-5;
     t = 0:h:5;
     
     for i = 1:length(t)-1
        yp = y(:, i) + h/2 * f(t(i), y(:, i));
        y(:, i+1) = y(:, i) + h * f(h/2, yp);
     end
     
     hold on
     plot(t, y(1, :), t, y(2, :));
end

function dy = f(y)
    Tb = y(1);
    Tw = y(2);
    h = 160; % [J / s * m^2]
    A = 0.0109; % [m^2]
    mb = 0.2; % [kg]
    mw = 2.5; % [kg]
    cb = 3.85; % [J / kg * K]
    cw = 4.1813; % [J /kg * K]
    dy = [
        ((Tw - Tb) * (h * A)) / (mb * cb )
        ((Tb - Tw) * (h * A)) / (mw * cw)
    ];

end