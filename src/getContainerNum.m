function cn = getContainerNum(bar_num, Tw_0, Tw_max, Tb_0, mw, bar_t, con_cool_t, step, x, approxH)
     A = 0.0109; % [m^2]
     mb = 0.25; % [kg]
     cb = 0.29; % [J / kg * K]
     cw = 4.1813; % [J /kg * K]

    conNum = 1;
    Tw = Tw_0; % [C]
    coolingConts = [];

    for i=1:bar_num
        if Tw > Tw_max
            canReuse = false;
            if isempty(coolingConts) == 0
                for j=1:length(coolingConts)
                    if (i - coolingConts(j)) * bar_t >= con_cool_t
                        coolingConts(j) = [];
                        canReuse = true;
                        break;
                    end
                end
            end
            if canReuse == false
                conNum = conNum + 1;
            end
            coolingConts(length(coolingConts) + 1) = i;
            Tw = Tw_0;
       end
       y = [ Tb_0
               Tw]; % [C]
       ieTemp = improvedEuler(x, y, step, approxH, A, mb, mw, cb, cw);
       Tw = ieTemp(2, end);
    end

    cn = conNum;
end
