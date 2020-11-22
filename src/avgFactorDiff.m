function y = absFactorDiff(xp, yp, p, x)
    a = approx(xp, yp, p, x);
    b = spline(xp, yp, x);
    y = abs(a - b);
end


function eavg = avgFactorDiff(xp, yp, p)
    i = simpsonIntegral(xp, yp, 100, p, @absFactorDiff);
    n = abs(xp(1)) + abs(xp(end));
    eavg = (1/n) * i;
end
