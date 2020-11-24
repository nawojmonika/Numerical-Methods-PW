function mw = getMinMw(Tb, Tw, Tbt, t, step, x, approxH)
    A = 0.0109; % [m^2]
    mb = 0.25; % [kg]
    cb = 0.29; % [J / kg * K]
    cw = 4.1813; % [J /kg * K]

    tempmw = 0; % [kg

    y = [ Tb
           Tw]; % [C]

    while Tb > Tbt
        Tb = y(1);
        tempmw = tempmw + 1;
        ieTemp = improvedEuler(x, y, step, approxH, A, mb, tempmw, cb, cw);
        Tb = ieTemp(1, end);
        plot(x, ieTemp(1, :));
    end

    mw = tempmw

end
