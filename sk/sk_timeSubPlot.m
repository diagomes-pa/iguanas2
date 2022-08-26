function sk_timeSubPlot(sig, tit, time_gran)

  # time_gran: representa a granularidade do tempo, se é contínuo ou discreto.
  # recebe um vetor que strings, c ou d, para sinais de tempo contínuo ou discreto,
  # respectivamente. Exemplo: para dois sinais, em que o o primeiro é contínuo e o
  # segundo discreto, deve-se fornecer o vetor ["c", "d"].

  global v;

  collor_order = {'b', 'r', 'k', 'g', 'm', 'y', 'c'};

  n_sig = size(sig, 2);

  figure
  for p = 1 : n_sig
    if(n_sig==4)
      subplot(2, 2, p);
    else
      subplot(min(n_sig, 3), ceil(n_sig/3), p);
    endif

    if(time_gran{p} == 'c')
      plot(v.t, sig{p}, collor_order{p}, "LineWidth", 1);
    elseif(time_gran{p} == 'd')
      stem(v.t(1:int32(v.N/length(sig{p})):end), sig{p}, collor_order{p}, "LineWidth", 1);
    endif

    y_range = max(sig{p}) - min(sig{p});
    axis([v.t(1) v.t(end) (min(sig{p})-0.1*y_range) (max(sig{p})+0.1*y_range)])
    xlabel("Tempo")
    title(tit{p})
    h=get(gcf, "currentaxes");
    set(h, "fontsize", 14);
    grid

  endfor

end
