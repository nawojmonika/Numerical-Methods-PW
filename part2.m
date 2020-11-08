function part2
    T = [-1500, -1000, -300, -50, -1, 1, 20, 50, 200, 400, 1000, 2000];
    h = [178, 176, 168, 161, 160, 160, 160.2, 161, 165, 168, 174, 179];
    
    ti = -1500:1:2000;
    hi = zeros(length(ti), 1);
    
    ah = fa(T, h, 3);
    
    for i=1:length(ti)
        hi(i) = fh(T, h, ah, ti(i));
    end
  

    plot(T, h, 'o', ti, hi);
end

function ah=fa(xT, yh, p)
    rows = length(xT);
    
    M = ones(rows, p + 1);
    Y = transpose(yh);
    
    for i=1:rows
        for j=1:p
            M(i, j+1) = xT(i)^j;
        end
    end
    
    ah = (transpose(M)*M) \ (transpose(M)*Y);
end

function vh = fh(T, h, ah, iT)
    if iT < min(T)
        vh = h(1);
        return;
    end
    if iT > max(T)
        vh = h(length(h));
        return;
    end
    vh = 0;
    for i=1:length(ah)
        vh = vh + ah(i) * iT^(i -1);
    end
end