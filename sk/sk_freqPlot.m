function sk_freqPlot(sig, leg)
  % sig: um vetor, que contém os sinais que serão exibidos.
  % leg: um vetor de células que contém as legendas dos sinais.

  global v;
  global fi;

  collor_order = {'b', 'r', 'k', 'g', 'm', 'y', 'c'};
  Max_freq = v.F_Nyquist;
  n_sig = size(sig, 2);

  figure();

  for p = 1 : n_sig

    freq = linspace(-Max_freq, Max_freq, length(sig{p}));

    tmp_spec = 10*log10(abs(fftshift(fft(sig{p}) + 1e-15)));
    plot(freq, tmp_spec, collor_order{p}, "LineWidth", 1);

    hold on
  endfor
  hold off

  xticks([-Max_freq, Max_freq]);
  xlabel('Frequência')
  h=get(gcf, "currentaxes");
  set(h, "fontsize", 14);
  l = legend(leg);
  set(l, "fontsize", 14)
  grid

end
