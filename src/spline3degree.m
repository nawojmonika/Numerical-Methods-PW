function y = spline3degree(par_x, par_y, alpha, beta, n, h, x)
    M = zeros(length(par_x) - 2, length(par_x));
    for i = 1:(length(par_x) - 2)
        M(i, i) = 1;
        M(i, i+1) = 4;
        M(i, i+2) = 1;
    end

    der_1 = zeros(1,length(M));
    der_1(1) = 4;
    der_1(2) = 2;
    der_2 = zeros(1,length(M));
    der_2(end - 1) = 2;
    der_2(end) = 4;

    dM = [ der_1
            M
            der_2];

    Mb = zeros(1,length(dM));

    Mb(1) = par_y(1) + ((h / 3) * alpha);
    Mb(end) = par_y(end) - ((h / 3) * beta);

    for i=2:length(Mb) - 1
        Mb(i) = par_y(i);
    end

    coefficients = dM \ transpose(Mb);
    coefficients = [coefficients(2) - (h/3) *alpha
            coefficients
            coefficients(end - 1) + (h/3) *beta];

    y = getIntervaly(par_x, coefficients, x, h);
end
