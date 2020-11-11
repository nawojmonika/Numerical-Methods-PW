function ye = improvedEuler(t, y, step, conduct)
    for i = 1:length(t)-1
        yp = y(:, i) + step/2 * tempModel(y(:, i), conduct);
        y(:, i+1) = y(:, i) + step * tempModel(yp, conduct);
     end
    ye = y;
end
