function part2
%      y = [ 1200
%            25 ];
%      h = 0.1;
%      t = 0:h:5;
%      
%      for i = 1:length(t)-1
%         yp = y(:, i) + h/2 * f(y(:, i));
%         y(:, i+1) = y(:, i) + h * f(yp);
%      end
    T = [-1500, -1000, -300, -50, -1, 1, 20, 50, 200, 400, 1000, 2000];
    h = [178, 176, 168, 161, 160, 160, 160.2, 161, 165, 168, 174, 179];
    
    ti = -1500:1:2000;
    hi = zeros(length(ti), 1);
    
    ah = fa(T, h, 3);
    
    for i=1:length(ti)
        hi(i) = fh(T, h, ah, ti(i));
    end
  

    plot(T, h, 'o', ti, hi);
     % hold on
     % plot(t, y(1, :),'o', t, y(2, :));
end

function a=fa(xp, yp, stopien_wielomianu)
    ilosc_wartosci=length(xp)
    
    M=ones(ilosc_wartosci, stopien_wielomianu + 1);
    b=zeros(length(yp), 1)
    
    for indeks_wiersza=1:ilosc_wartosci
        for indeks_wspolczynnika=1:stopien_wielomianu
            M(indeks_wiersza, indeks_wspolczynnika + 1)=xp(indeks_wiersza)^indeks_wspolczynnika;
        end
        b(indeks_wiersza, 1)=yp(indeks_wiersza);
    end
    
    a = (transpose(M)*M) \ (transpose(M)*b);
end

function vh = fh(T, h, ah, iT)
    if iT < min(T)
        vh = h(1);
        return;
    end
    if iT > max(T)
        vh = h(length(h));
        return;
    end
    vh = 0;
    for i=1:length(ah)
        vh = vh + ah(i) * iT^(i -1);
    end
end