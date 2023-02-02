function sk_magFaseSubPlot(sig, tit, F_nyquist)

  # F_nyquist: se 1, mostra o valor da frequência de Nyquist. Se 0, mostra Fs/2.

  global v;
  global fi;

  collor_order = {'b', 'r', 'k', 'g', 'm', 'y', 'c'};

  n_sig = size(sig, 2);

  figure
  for p = 1 : n_sig

    if(2*n_sig==4)

      Max_freq = F_nyquist{p};
      freq = linspace(-Max_freq, Max_freq, 512);
      [h, w] = freqz(sig{p}, 1, [], 'whole', v.Fs);
      h = fftshift(h);

      subplot(2, 2, 2*(p-1)+1);
      plot(freq, 10*log10(abs(h)), collor_order{p}, "LineWidth", 1);
      xticks([-Max_freq, Max_freq]);
      xlabel("Frequência")
      title(['Magnitude de ' tit{p}]);
      h=get(gcf, "currentaxes");
      set(h, "fontsize", 18);
      grid

      subplot(2, 2, 2*(p-1)+2);
      fase = angle(fftshift(fft(sig{p})));
      plot(freq, unwrap(angle(h)), collor_order{p}, "LineWidth", 1);
      xticks([-Max_freq, Max_freq]);
      xlabel("Frequência")
      title(['Fase de ' tit{p}]);
      h=get(gcf, "currentaxes");
      set(h, "fontsize", 18);
      grid

    else

      Max_freq = v.F_Nyquist;
      freq = linspace(-Max_freq, Max_freq, 512);
      [h, w] = freqz(sig{p}, 1, [], 'whole', v.Fs);
      h = fftshift(h);

      subplot(min(n_sig, 3), ceil(n_sig/3), 2*(p-1)+1);
      plot(freq, 10*log10(abs(h)), collor_order{p}, "LineWidth", 1);
      xticks([-Max_freq, Max_freq]);
      xlabel("Frequência")
      title(['Magnitude de ' tit{p}]);
      h=get(gcf, "currentaxes");
      set(h, "fontsize", 18);
      grid

      subplot(min(n_sig, 3), ceil(n_sig/3), 2*(p-1)+2);
      plot(freq, unwrap(angle(h)), collor_order{p}, "LineWidth", 1);
      xticks([-Max_freq, Max_freq]);
      xlabel("Frequência")
      title(['Fase de ' tit{p}]);
      h=get(gcf, "currentaxes");
      set(h, "fontsize", 18);
      grid

    endif
  endfor

end
