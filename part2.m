function part2
     y = [ 1200
           25 ];
     h = 0.1;
     t = 0:h:5;
     
     for i = 1:length(t)-1
        yp = y(:, i) + h/2 * f(y(:, i));
        y(:, i+1) = y(:, i) + h * f(yp);
     end
     
     hold on
     plot(t, y(1, :),'o', t, y(2, :));
end

function dy = f(y)
    Tb = y(1);
    Tw = y(2);
    h = fh(Tb - Tw); % [W * m^-2]
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

function vh = fh(iT)
    T = [-1500, -1000, -300, -50, -1, 1, 20, 50, 200, 400, 1000, 2000];
    h = [178, 176, 168, 161, 160, 160, 160.2, 161, 165, 168, 174, 179];
    
    if iT < min(T)
        vh = h(1);
        return;
    end
    if iT > max(T)
        vh = h(length(h));
        return;
    end
    L = zeros(length(T));
    R = zeros(length(T), 1);
    
    for i=1:length(T)
        for j=1:length(T)
            L(i, j) = T(i)^(j-1);
        end
        R(i) = h(i);
    end
    x = L\R;
    sum = 0;
    for k=1:length(x)
        sum = sum + x(k) * iT^(k-1);
    end
    vh = sum;
end