function part2_2
    T = [-1500, -1000, -300, -50, -1, 1, 20, 50, 200, 400, 1000, 2000];
    H = [178, 176, 168, 161, 160, 160, 160.2, 161, 165, 168, 174, 179];

    p = 4;
    ti = -1500:1:2000;
    approxY = zeros(length(ti), 1);
    splineY = zeros(length(ti), 1);

    for i=1:length(ti)
        approxY(i) = approx(T, H, p, ti(i));
        splineY(i) = spline(T, H, ti(i));
    end

     eavg = avgFactorDiff(T, H, p);

    shade(ti,approxY, ti, splineY, 'FillType', [1, 2; 2, 1]);
end
