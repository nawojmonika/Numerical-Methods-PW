function ye = improvedEuler(t, y, step, conduct, A, mb, mw, cb, cw)
    for i = 1:length(t)-1
        yp = y(:, i) + step/2 * tempModel(y(:, i), conduct(i), A, mb, mw, cb, cw);
        y(:, i+1) = y(:, i) + step * tempModel(yp, conduct(i), A, mb, mw, cb, cw);
     end
    ye = y;
end
