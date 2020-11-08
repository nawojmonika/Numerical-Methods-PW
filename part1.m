function part1
     y = [ 1200
           25 ];
     h = 0.1;
     t = 0:h:5;
     
    ye = getEuler(t, y, h);
    yie = getImprovedEuler(t, y, h);
     
     hold on
     plot(t, ye(1, :), t, ye(2, :), t, yie(1, :), t, yie(2, :));
end

function ye = getEuler(t, y, h)
    for i = 1:length(t)-1
        yp = y(:, i) + h/2 * f(y(:, i));
        y(:, i+1) = y(:, i) + h * f(yp);
     end
    ye = y;
end

function yie = getImprovedEuler(t, y, h)
    for i = 1:length(t)-1
            y(:, i+1) = y(:, i) + h * f(y(:,i));
    end
    yie = y;
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