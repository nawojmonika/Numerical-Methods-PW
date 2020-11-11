function part2_1
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

    plot(T, H, 'o', ti, approxY, ti, splineY);
end

function e = approxError(xp, yp, p)
    n = length(xp);
    sum = 0;
    for i=1:length(n)
        sum = sum + (yp(i) - approx(xp, yp, p, xp(i)))^2;
    end
    e = sqrt(sum/(n+1));
end
