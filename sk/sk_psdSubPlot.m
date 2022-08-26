function sk_psdSubPlot(sig, tit, F_nyquist)

  # F_nyquist: se 1, mostra o valor da frequência de Nyquist. Se 0, mostra Fs/2.

  global v;

  collor_order = {'b', 'r', 'k', 'g', 'm', 'y', 'c'};

  Max_freq = v.Fs/2;
  freq = linspace(-Max_freq, Max_freq, v.N);

  n_sig = size(sig, 2);

  figure
  for p = 1 : n_sig
    if(n_sig==4)
      subplot(2, 2, p);
    else
      subplot(min(n_sig, 3), ceil(n_sig/3), p);
    endif

    wind = hamming(1024);
    [spectra, freq] = pwelch(sig{p}, [], [], [], v.Fs, 'shift', 'db', 'none', []);
    plot(freq, spectra, collor_order{p}, "LineWidth", 1);

    if(F_nyquist)
      xticks([-Max_freq, Max_freq]);
    else
      xticks([-Max_freq Max_freq]);
      xticklabels({"-Fs/2", "Fs/2"})
    endif

    xlabel("Frequência");
    ylabel('PSD (dB)');
    title(tit{p});

    h=get(gcf, "currentaxes");
    set(h, "fontsize", 18);
    grid

  endfor

end
