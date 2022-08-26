function sk_timePlot(sig, leg, time_gran)

  # time_gran: representa a granularidade do tempo, se é contínuo ou discreto.
  # recebe um vetor que strings, c ou d, para sinais de tempo contínuo ou discreto,
  # respectivamente. Exemplo: para dois sinais, em que o o primeiro é contínuo e o
  # segundo discreto, deve-se fornecer o vetor ["c", "d"].

  global v;

  n_sig = size(sig, 2);

  for p = 1 : n_sig
    if(time_gran{p} == 'c')
      plot(v.t, sig(:, p), "LineWidth", 2);
    elseif(time_gran{p} == 'd')
      stem(v.t(1:int32(v.N/length(sig(:, p))):end), sig(:, p), "LineWidth", 2);
    endif
    hold on
  endfor
  hold off

  y_range = max(max(sig)) - min(min(sig));
  axis([v.t(1) v.t(end) (min(min(sig))-0.1*y_range) (max(max(sig))+0.1*y_range)])
  xlabel("Tempo")
  h=get(gcf, "currentaxes");
  set(h, "fontsize", 14);
  l = legend(leg);
  set(l, "fontsize", 14)
  grid

end
