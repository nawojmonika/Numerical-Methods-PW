function kw = getOilCost(mw, bars, con_n)
    kw = (20 * mw) * round(bars/con_n/2000);
end
