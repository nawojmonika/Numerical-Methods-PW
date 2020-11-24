function part3
 chart_size=[10 10 800 600];
 T = [-1500, -1000, -300, -50, -1, 1, 20, 50, 200, 400, 1000, 2000]; % [C]
 H = [178, 176, 168, 161, 160, 160, 160.2, 161, 165, 168, 174, 179]; % [C]
 A = 0.0109; % [m^2]
 mb = 0.25; % [kg]
 cb = 0.29; % [J / kg * K]
 cw = 4.1813; % [J /kg * K]
 step = 0.01;
 x = 0:step:0.7; % [s]
 p = 4;
 ti = -1500:1:2000; % [C]
 approxH = zeros(length(ti), 1);

 for i=1:length(ti)
     approxH(i) = approx(T, H, p, ti(i));
 end

  mw = 0; % [kg]
  y = [ 1200
        25];
  desiredTemp = 125; % [C]
  startTemp = 1200;
  temp = startTemp; % [C]
  i = 1;
  while temp > desiredTemp
    temp = startTemp;
    mw = mw + 0.05;
    ieTemp = improvedEuler(x, y, step, approxH, A, mb, mw, cb, cw);
    temp = ieTemp(1, end)

    fig=figure('Renderer', 'painters', 'Position', chart_size);
    plot(x, ieTemp(1, :));
    title('Przebieg czasowy temperatury preta');
    xlabel('t [s]');
    ylabel(['T [' char(176) 'C]']);
    legend('Temperatura preta T_b');
    saveas(fig,sprintf('../assets/part3/temperatura-preta-%d', i), 'png');
    close;
    i = i + 1;
  end
end
