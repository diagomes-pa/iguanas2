function sk_plot(dados, leg_eixos, time_gran)

  # dados: o eixo e o sinal que ser� plotado
  # leg_eixos: a legenda dos eixos.
  # time_gran: representa a granularidade do tempo, se é contínuo ou discreto.
  # recebe um vetor que strings, c ou d, para sinais de tempo contínuo ou discreto,
  # respectivamente. Exemplo: para dois sinais, em que o o primeiro é contínuo e o
  # segundo discreto, deve-se fornecer o vetor ["c", "d"].

  global v;

  figure

  if(time_gran == 'c')
    plot(dados{1}, dados{2}, "LineWidth", 1.5);
  elseif(time_gran == 'd')
    stem(dados{1}, dados{2}, "LineWidth", 1.5);
  endif

  y_range = max(dados{2}) - min(dados{2}) + 1;
  axis([dados{1}(1) dados{1}(end) (min(dados{2})-0.1*y_range) (max(dados{2})+0.1*y_range)])
  xlabel(leg_eixos{1});
  ylabel(leg_eixos{2});
  h=get(gcf, "currentaxes");
  set(h, "fontsize", 18);
  grid

end
