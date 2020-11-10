function part2
    T = [-1500, -1000, -300, -50, -1, 1, 20, 50, 200, 400, 1000, 2000];
    H = [178, 176, 168, 161, 160, 160, 160.2, 161, 165, 168, 174, 179];

    pi = 1:1:5;
    approxE = zeros(length(pi), 1);

    for i=1:length(pi)
        approxE(i) = approxError(T, H, pi(i));
    end

    p = find(approxE==min(approxE));
    approxY = approx(T, H, p);

    ti = -1500:1:2000;
    approxPolyY = zeros(length(ti), 1);
    for j=1:length(ti)
        approxPolyY(j) = poly(T, H, approxY, ti(j));
    end

    plot(T, H, 'o', ti, approxPolyY);
end

function a = approx(xp, yp, p)
    rows = length(xp);

    M = ones(rows, p + 1);
    Y = transpose(yp);

    for i=1:rows
        for j=1:p
            M(i, j+1) = xp(i)^j;
        end
    end
    a = (transpose(M)*M) \ (transpose(M)*Y);
end

function y = poly(xp, yp, iy, ix)
    if ix < min(xp)
        y = yp(1);
        return;
    end
    if ix > max(xp)
        y = yp(end);
        return;
    end
    y = 0;
    for i=1:length(iy)
        y = y + iy(i) * ix^(i -1);
    end
end

function e = approxError(xp, yp, ia)
    a = approx(xp, yp, ia);
    n = length(xp);
    sum = 0;
    for i=1:length(n)
        sum = sum + (yp(i) - poly(xp, yp, a, xp(i)))^2;
    end
    e = sqrt(sum/(n+1));
end
