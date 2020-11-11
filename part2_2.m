function part2_2
    T = [-1500, -1000, -300, -50, -1, 1, 20, 50, 200, 400, 1000, 2000];
    H = [178, 176, 168, 161, 160, 160, 160.2, 161, 165, 168, 174, 179];

    p = 4;
    ti = -1500:1:2000;
    approxY = zeros(length(ti), 1);
    splineY = zeros(length(ti), 1);

    for j=1:length(ti)
        approxY(j) = approx(T, H, p, ti(j));
        splineY(j) = spline(T, H, ti(j));
    end

     eavg = avgFactorDiff(T, H, p);

    shade(ti,approxY, ti, splineY, 'FillType', [1, 2; 2, 1]);
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
