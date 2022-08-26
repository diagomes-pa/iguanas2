function [b, a] = selecionador_canal(ch_model, ch_par, show_plot)
  % show_plot: 1, mostra os gráficos de espectro e resposta ao impulso.

  global v;

  switch ch_model
    case 'id'
      [b, a] = ch_identity();
    case 'lpf'
      filt_order = ch_par(1);
      f_cut_norm = ch_par(2)/(v.Fs/2);
      [b, a] = butter(filt_order, f_cut_norm);
    case 'tp'
      [b, a] = ch_twisted_pair(ch_par(1));
  endswitch

  if(show_plot)

    [h, w] = freqz(b, a, 512, v.Fs);
    [g, w_g] = grpdelay(b, a, 512, v.Fs);
    plot(w, abs(h), "LineWidth", 1,  w, unwrap(angle(h)), "LineWidth", 1, w_g, g*v.Ts, "LineWidth", 1);
    xlabel("Frequência");
    legend({'Magnitude', 'Fase', 'Atraso Grupo'});
    h=get(gcf, "currentaxes");
    set(h, "fontsize", 16);
    grid

    imp_resp = impz(b, a);
    figure, plot(imp_resp, "LineWidth", 1);
    xlabel("Amostras");
    legend({'Resposta ao Impulso do Canal'});
    h=get(gcf, "currentaxes");
    set(h, "fontsize", 16);
    grid

  endif

endfunction
