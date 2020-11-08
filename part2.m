function part2
    T = [-1500, -1000, -300, -50, -1, 1, 20, 50, 200, 400, 1000, 2000];
    H = [178, 176, 168, 161, 160, 160, 160.2, 161, 165, 168, 174, 179];
    
    ti = -1500:1:2000;
    hi = zeros(length(ti), 1);
    pi = 2:1:5;
    ea = zeros(length(pi), 1);
    
    for i=1:length(pi)
        ea(i) = fe(T, H, pi(i));
    end
    
    ea
    p = find(ea==min(ea))
    
    ah = fa(T, H, p);
    
    for j=1:length(ti)
        hi(j) = fh(T, H, ah, ti(j));
    end
  

    plot(T, H, 'o', ti, hi);
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

function ea = fe(T, H, ai)
    a = fa(T, H, ai);
    n = length(T);
    sum = 0;
    for i=1:length(n)
        sum = sum + (H(i) - fh(T, H, a, T(i)))^2;
    end
    ea = sqrt(sum/(n+1))
end