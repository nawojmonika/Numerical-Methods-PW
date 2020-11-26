function y = calcDerivative(xp, yp, p, x, step)
    y = (approx(xp, yp, p, x - step) - approx(xp, yp, p, x) ) / step;
end
