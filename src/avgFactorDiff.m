function eavg = avgFactorDiff(xp, yp, p)
    i = simpsonIntegral(xp, yp, 100, p);
    n = abs(xp(1)) + abs(xp(end));
    eavg = (1/n) * i;
end


