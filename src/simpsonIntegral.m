function si = simpsonIntegral(xp, yp, m, p)
    a = xp(1);
    b = xp(end);
    h = (b - a) / m;
    si = 0;
    for i=a:h:b
        for k=0:m-2
                x0 = getIntegralX(a, h, k);
                x1 = getIntegralX(a, h, k+1);
                x2 = getIntegralX(a, h, k+2);
                f0 = absFactorDiff(xp, yp, p, x0);
                f1 = absFactorDiff(xp, yp, p, x1);
                f2 = absFactorDiff(xp, yp, p, x2);
                si = si + (h/3 * (f0 + (4 * f1) + f2));
        end
    end
end

function x = getIntegralX(a, h, k)
    x = a + (k * h);
end

function y = absFactorDiff(xp, yp, p, x)
    a = approx(xp, yp, p, x);
    b = spline(xp, yp, x);
    y = abs(a - b);
end
