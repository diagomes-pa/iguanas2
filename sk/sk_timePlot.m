function sk_timePlot(sig, leg, time_gran)
  % sig: um vetor, que contém os sinais que serão exibidos.
  % leg: um vetor de células que contém as legendas dos sinais.
  % time_gran: representa a granularidade do tempo, se é contí­nuo, discreto ou texto.
  % Recebe um vetor células com string: 'c', 'd', ou 't', para sinais de tempo contí­nuo,
  % discreto, ou texto respectivament, respectivamente. Exemplo: para dois sinais,
  % em que o o primeiro Ã© contÃ­nuo e o   % segundo discreto, deve-se fornecer {'c', 'd'}.
  % Observação: se houver dados do tipo texto para serem exibidos, é importante
  % que estes não sejam os primeiros a serem informados, a fim de que possam ser exibidos
  % adequadamente.

  global v;

  n_sig = size(sig, 2);

  max_val = -inf;
  min_val = inf;

  figure();

  for p = 1 : n_sig
    if(time_gran{p} == 'c') % Para sinais de tempo contínuo.
      if(max(sig{p}) > max_val) max_val = max(sig{p}); end
      if(min(sig{p}) < min_val) min_val = min(sig{p}); end
      plot(v.t, sig{p}, "LineWidth", 2);
    elseif(time_gran{p} == 'd') % Para sinais de tempo discreto.
      if(max(sig{p}) > max_val) max_val = max(sig{p}); end
      if(min(sig{p}) < min_val) min_val = min(sig{p}); end
      stem(v.t(1:int32(v.N/length(sig{p})):end), sig{p}, "LineWidth", 2);
    elseif(time_gran{p} == 't') % Para exibição de texto.
      text(v.t(1:v.L:length(sig{p})*v.L), (max_val+0.1)*ones(length(sig{p}),1), sig{p}, 'fontsize', 16);
    endif
    hold on
  endfor
  hold off

  y_range = max_val - min_val;
  axis([v.t(1) v.t(end) (min_val-0.25*y_range) (max_val+0.25*y_range)])
  xlabel("Tempo");
  h=get(gcf, "currentaxes");
  set(h, "fontsize", 18);
  l = legend(leg);
  set(l, "fontsize", 14)
  grid

end
