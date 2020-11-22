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
