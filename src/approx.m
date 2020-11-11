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
