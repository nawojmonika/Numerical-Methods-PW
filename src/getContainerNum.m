function cn = getContainerNum(bar_num, Tw_0, Tw_max, Tb_0, mw, bar_t, con_cool_t, step, x, approxH)
     A = 0.0109; % [m^2]
     mb = 0.25; % [kg]
     cb = 0.29; % [J / kg * K]
     cw = 4.1813; % [J /kg * K]

    conNum = 1;
    Tw = Tw_0; % [C]
    coolingCon = 0;
    coolingIndex = 0;

    for i=1:bar_num
        if (Tw > Tw_max)
            if (coolingCon > 0 && (i - coolingIndex) * bar_t >= con_cool_t)
                coolingCon = coolingCon - 1;
            else
                conNum = conNum + 1;
            end
            coolingCon = coolingCon + 1;
            Tw = Tw_0;
            coolingIndex = i;
        end
       y = [ Tb_0
               Tw]; % [C]
       ieTemp = improvedEuler(x, y, step, approxH, A, mb, mw, cb, cw);
       Tw = ieTemp(2, end);
    end

    cn = conNum;
end
