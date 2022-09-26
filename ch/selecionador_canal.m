function [b, a] = selecionador_canal(ch_model, ch_par)
  % ch_model: modelo do canal.
  % ch_par: parâmetros de configuração do canal de acordo com o tipo escolhido.

  pkg load signal;

  global v;

  switch ch_model
    case 'id' % Canal do tipo identidade.
      [b, a] = ch_identity();
    case 'lpf' % Canal do tipo filtro passa-baixa.
      filt_order = ch_par(1);
      f_cut_norm = ch_par(2)/(v.F_Nyquist);
      [b, a] = butter(filt_order, f_cut_norm);
    case 'tp' % Modelo de canal de par trançado
      [b, a] = ch_twisted_pair(ch_par(1));
  endswitch


  if(v.debug)

    [h, w] = freqz(b, a, [], v.Fs);
    [g, w_g] = grpdelay(b, a, [], v.Fs);
    plot(w, 10*log10(abs(h)), "LineWidth", 1,  w, unwrap(angle(h)), "LineWidth", 1, w_g, g*v.Ts, "LineWidth", 1);
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
