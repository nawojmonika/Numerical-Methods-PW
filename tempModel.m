function dy = tempModel(y, h)
    Tb = y(1);
    Tw = y(2);
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
