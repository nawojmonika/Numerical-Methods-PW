function mw = getMinMw(Tb, Tw, Tbt, step, x, approxH)
    A = 0.0109; % [m^2]
    mb = 0.25; % [kg]
    cb = 0.29; % [J / kg * K]
    cw = 4.1813; % [J /kg * K]

    tempmw = 0; % [kg

    y = [ Tb
           Tw]; % [C]

    while Tb > Tbt
        tempmw = tempmw + 0.05;
        ieTemp = improvedEuler(x, y, step, approxH, A, mb, tempmw, cb, cw);
        Tb = ieTemp(1, end);
    end

    mw = tempmw;

end
