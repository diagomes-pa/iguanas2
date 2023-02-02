function sk_timePlot(sig, leg, time_gran)
  % sig: um vetor, que cont�m os sinais que ser�o exibidos.
  % leg: um vetor de c�lulas que cont�m as legendas dos sinais.
  % time_gran: representa a granularidade do tempo, se � cont�nuo, discreto ou texto.
  % Recebe um vetor c�lulas com string: 'c', 'd', ou 't', para sinais de tempo cont�nuo,
  % discreto, ou texto respectivament, respectivamente. Exemplo: para dois sinais,
  % em que o o primeiro é contínuo e o   % segundo discreto, deve-se fornecer {'c', 'd'}.
  % Observa��o: se houver dados do tipo texto para serem exibidos, � importante
  % que estes n�o sejam os primeiros a serem informados, a fim de que possam ser exibidos
  % adequadamente.

  global v;

  n_sig = size(sig, 2);

  max_val = -inf;
  min_val = inf;

  figure();

  for p = 1 : n_sig
    if(time_gran{p} == 'c') % Para sinais de tempo cont�nuo.
      if(max(sig{p}) > max_val) max_val = max(sig{p}); end
      if(min(sig{p}) < min_val) min_val = min(sig{p}); end
      plot(v.t, sig{p}, "LineWidth", 2);
    elseif(time_gran{p} == 'd') % Para sinais de tempo discreto.
      if(max(sig{p}) > max_val) max_val = max(sig{p}); end
      if(min(sig{p}) < min_val) min_val = min(sig{p}); end
      stem(v.t(1:int32(v.N/length(sig{p})):end), sig{p}, "LineWidth", 2);
    elseif(time_gran{p} == 't') % Para exibi��o de texto.
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
