function y = spline(xp, yp, x)
    if x < xp(1)
        y = yp(1);
        return;
    end
    if x > xp(end)
        y = yp(end);
        return;
    end
    for i=1:length(xp)-1
        if x >= xp(i) && x <= xp(i+1)
            break;
        end
    end
     A = [1 xp(i)
          1 xp(i+1)
        ];
     B = [yp(i)
          yp(i+1)
        ];
     a = A\B;
     y = a(1) + a(2) * x;
end
