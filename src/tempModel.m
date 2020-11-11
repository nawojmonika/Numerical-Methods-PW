function dy = tempModel(y, h, A, mb, mw, cb, cw)
    Tb = y(1);
    Tw = y(2);

    dy = [
        ((Tw - Tb) * (h * A)) / (mb * cb )
        ((Tb - Tw) * (h * A)) / (mw * cw)
    ];
end
