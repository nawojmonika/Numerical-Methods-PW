function yie = myEuler(t, y, step, conduct, A, mb, mw, cb, cw)
    for i = 1:length(t)-1
        y(:, i+1) = y(:, i) + step * tempModel(y(:,i), conduct(i), A, mb, mw, cb, cw);
    end
    yie = y;
end
