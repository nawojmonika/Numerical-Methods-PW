function part2
    T = [-1500, -1000, -300, -50, -1, 1, 20, 50, 200, 400, 1000, 2000];
    H = [178, 176, 168, 161, 160, 160, 160.2, 161, 165, 168, 174, 179];

    pi = 1:1:5;
    approxE = zeros(length(pi), 1);

    for i=1:length(pi)
        approxE(i) = approxError(T, H, pi(i));
    end

    p = find(approxE==min(approxE));
    ti = -1500:1:2000;
    approxY = zeros(length(ti), 1);
    splineY = zeros(length(ti), 1);

    for j=1:length(ti)
        approxY(j) = approx(T, H, p, ti(j));
        splineY(j) = spline(T, H, ti(j));
    end

%     eavg = avgFactorDiff(T, H, p);

%     plot(T, H, 'o', ti, approxY, ti, splineY);
    shade(ti, approxY, ti, splineY, 'FillType', [1, 2; 2, 1]);
end

function a = approx(xp, yp, p, x)
    rows = length(xp);

    M = ones(rows, p + 1);
    Y = transpose(yp);

    for i=1:rows
        for j=1:p
            M(i, j+1) = xp(i)^j;
        end
    end
    iy = (transpose(M)*M) \ (transpose(M)*Y);
    a = poly(xp, yp, iy, x);
end

function y = poly(xp, yp, iy, ix)
    if ix < xp(1)
        y = yp(1);
        return;
    end
    if ix > xp(end)
        y = yp(end);
        return;
    end
    y = 0;
    for i=1:length(iy)
        y = y + iy(i) * ix^(i -1);
    end
end

function e = approxError(xp, yp, p)
    n = length(xp);
    sum = 0;
    for i=1:length(n)
        sum = sum + (yp(i) - approx(xp, yp, p, xp(i)))^2;
    end
    e = sqrt(sum/(n+1));
end

function y = spline(xp, yp, x)
    if x < xp(1)
        y = yp(1);
        return;
    end
    if x > xp(end)
        y = yp(end);
        return;
    end
    for i=1:length(xp)-1
        if x >= xp(i) && x <= xp(i+1)
            break;
        end
    end
     A = [1 xp(i)
          1 xp(i+1)
        ];
     B = [yp(i)
          yp(i+1)
        ];
     a = A\B;
     y = a(1) + a(2) * x;
end

function y = absFactorDiff(xp, yp, p, x)
    a = approx(xp, yp, p, x);
    b = spline(xp, yp, x);
    y = abs(a - b);
end

function i = simpsonIntegral(xp, yp, m, p, f)
    a = xp(1);
    b = xp(end);
    h = (b - a) / m;
    i = 0;
    for k=1:m-2
        x0 = getIntegralX(a, h, k);
        x1 = getIntegralX(a, h, k+1);
        x2 = getIntegralX(a, h, k+2);
        f0 = f(xp, yp, p, x0);
        f1 = f(xp, yp, p, x1);
        f2 = f(xp, yp, p, x2);
        i = i + (h/3 * (f0 + (4 * f1) + f2));
    end
end

function x = getIntegralX(a, h, k)
    x = a + (k * h);
end

function eavg = avgFactorDiff(xp, yp, p)
    i = simpsonIntegral(xp, yp, 100, p, @absFactorDiff);
    n = abs(xp(1)) + abs(xp(end));
    eavg = (1/n) * i;
end
