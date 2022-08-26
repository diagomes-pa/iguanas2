function sk_freqSubPlot(sig, tit, F_nyquist)

  # F_nyquist: se 1, mostra o valor da frequência de Nyquist. Se 0, mostra Fs/2.

  global v;
  global fi;

  collor_order = {'b', 'r', 'k', 'g', 'm', 'y', 'c'};

  %Max_freq = v.Fs/2;
  %freq = linspace(-Max_freq, Max_freq, v.N);

  n_sig = size(sig, 2);

  figure
  for p = 1 : n_sig
    if(n_sig==4)
      subplot(2, 2, p);
    else
      subplot(min(n_sig, 3), ceil(n_sig/3), p);
    endif

    Max_freq = F_nyquist{p};
    freq = linspace(-Max_freq, Max_freq, length(sig{p}));

    tmp_spec = 10*log10(abs(fftshift(fft(sig{p}) + 1e-15)));
    plot(freq, tmp_spec, collor_order{p}, "LineWidth", 1);

    xticks([-Max_freq, Max_freq]);

    %if(F_nyquist)
    %  xticks([-Max_freq, Max_freq]);
    %else
    %  xticks([-Max_freq Max_freq]);
    %  xticklabels({"-Fs/2", "Fs/2"})
    %endif

    xlabel("Frequência")
    title(tit{p});

    h=get(gcf, "currentaxes");
    set(h, "fontsize", 18);
    grid

  endfor

end
