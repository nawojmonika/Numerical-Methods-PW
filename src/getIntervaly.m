function sum = getIntervaly(xp, coefficients, x, h)
     sum = 0;
     splines = [];

     for i = 1:3
        xp = [xp(1) - (h*i), xp, xp(end) + (h * i)];
     end

     for i = 3:length(xp) - 2
         if x >= xp(i - 2) && x <= xp(i -1)
             splines = [splines, (x - xp(i-2))^3];
             continue;
         end
         if x >= xp(i - 1) && x <= xp(i)
             splines = [splines, (x - xp(i-2))^3 - 4*(x - xp(i - 1))^3];
             continue;
         end
         if x >= xp(i) && x <= xp(i + 1)
             splines = [splines, (xp(i+2) - x)^3-4*(xp(i+1) - x)^3];
             continue;
         end
         if x >= xp(i + 1) && x <= xp(i + 2)
             splines = [splines, (xp(i+2) - x)^3];
             continue;
         end
         if x <= xp(i - 2) || x >= xp(i + 2)
            splines = [splines, 0];
            continue;
         end
     end

     for i = 1:length(coefficients)
        sum = sum + (coefficients(i) * splines(i))* 1/(h^3);
     end
end
