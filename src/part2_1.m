function part2_1
    chart_size=[10 10 800 600];
    T = [-1500, -1000, -300, -50, -1, 1, 20, 50, 200, 400, 1000, 2000];
    H = [178, 176, 168, 161, 160, 160, 160.2, 161, 165, 168, 174, 179];

    pi = 1:1:5;
    approxE = zeros(length(pi), 1);

    for i=1:length(pi)
        approxE(i) = approxError(T, H, pi(i));
    end

    writematrix(approxE,'../assets/part2/approx-error.csv');

    p = find(approxE==min(approxE));
    ti = -1500:1:2000;
    approxY = zeros(length(ti), 1);
    splineY = zeros(length(ti), 1);

    for j=1:length(ti)
        approxY(j) = approx(T, H, p, ti(j));
        splineY(j) = spline(T, H, ti(j));
    end

    fig=figure('Renderer', 'painters', 'Position', chart_size);
    plot(T, H, 'o', ti, approxY, ti, splineY);
    title('Przebieg wspolczynnika przewodnictwa cieplnego h');
    xlabel(['\Delta T [' char(176) 'C]']);
    ylabel('h [W \cdot m^{-2}]');
    legend('h pomiarowe', 'h aproksymowane', 'h interpolowane');
    saveas(fig,'../assets/part2/przewodnictwo-cieplne-h', 'png');
end
