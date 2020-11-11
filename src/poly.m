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
