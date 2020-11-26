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

%    Approx coefficients
    ti = T(1):1:T(end);
    p = find(approxE==min(approxE));
    approxY = zeros(length(ti), 1);

%    Interpolation coefficients
    n = 10;
    a = -1499;
    b = 2000;
    h = (b - a) / n;
    par_x = zeros(1, n);
    par_y = zeros(1, n);
    dStep = 0.00000001;
    alpha = abs(calcDerivative(T, H, p, a, dStep));
    beta = abs(calcDerivative(T, H, p, b, dStep));

    for k=0:(n+1)
        x =  a + (k * h);
        par_x(k + 1) = x;
        par_y(k + 1) = spline(T, H, x);
    end

    splineY = zeros(length(ti), 1);
    ti = -1498:0.1:2000;
    for j=1:length(ti)
        approxY(j) = approx(T, H, p, ti(j));
        splineY(j) = spline3degree(par_x, par_y, alpha, beta,n, h, ti(j));
    end
     fig=figure('Renderer', 'painters', 'Position', chart_size);
     plot(par_x, par_y, 'o', ti, splineY);
     title('Przebieg wspolczynnika przewodnictwa cieplnego h');
     xlabel(['\Delta T [' char(176) 'C]']);
     ylabel('h [W \cdot m^{-2}]');
     legend('h interpolowane splajnami 1-stopnia');
     saveas(fig,'../assets/part2/splajny', 'png');

    fig=figure('Renderer', 'painters', 'Position', chart_size);
    plot(T, H, 'o', ti, approxY, ti, splineY);
    title('Przebieg wspolczynnika przewodnictwa cieplnego h');
    xlabel(['\Delta T [' char(176) 'C]']);
    ylabel('h [W \cdot m^{-2}]');
    legend('h pomiarowe', 'h aproksymowane', 'h interpolowane splajnami 3-go stopnia');
    saveas(fig,'../assets/part2/przewodnictwo-cieplne-h', 'png');

end
