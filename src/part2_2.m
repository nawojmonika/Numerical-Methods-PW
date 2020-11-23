function part2_2
    chart_size=[10 10 800 600];
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
    writematrix([eavg],'../assets/part2/eavg.csv');

    fig=figure('Renderer', 'painters', 'Position', chart_size);
    shade(ti,approxY, ti, splineY, 'FillType', [1, 2; 2, 1]);
    title('Roznica przebiegow krzywej reprezentujacej wspolczynnik przewodnictwa cieplnego h');
    xlabel(['\Delta T [' char(176) 'C]']);
    ylabel('h [W \cdot m^{-2}]');
    legend('h aproksymowane', 'h interpolowane');
    saveas(fig,'../assets/part2/roznica-h', 'png');
end
