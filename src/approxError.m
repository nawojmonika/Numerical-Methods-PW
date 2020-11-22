function e = approxError(xp, yp, p)
    n = length(xp);
    sum = 0;
    for i=1:length(n)
        sum = sum + (yp(i) - approx(xp, yp, p, xp(i)))^2;
    end
    e = sqrt(sum/(n+1));
end
