function [b, a, delay] = selecionador_canal(ch_model, ch_par, delay_est)
  % ch_model: modelo do canal.
  % ch_par: parâmetros de configuração do canal de acordo com o tipo escolhido.
  % delay_est: método de estimação do atraso do canal. grd: atraso de grupo; irp: pico da rspoasta ao impulso.

  pkg load signal;

  global v;

  switch ch_model
    case 'id' % Canal do tipo identidade.
      [b, a] = ch_identidade();
    case 'ideal' % Canal do tipo ideal.
      [b, a] = ch_ideal(ch_par(1), ch_par(2));
    case 'fase_aleat' % Canal com fase aleatoria.
      [b, a] = ch_fase_aleatoria();
    case 'lpf' % Canal do tipo filtro passa-baixa.
      filt_order = ch_par(1);
      f_cut_norm = ch_par(2)/(v.F_Nyquist);
      [b, a] = butter(filt_order, f_cut_norm);
    case 'tp' % Modelo de canal de par trançado
      [b, a] = ch_twisted_pair(ch_par(1));
  endswitch

  %%%%%%%%% Computa o delay do canal
  switch delay_est
    case 'grd'
      [g, w_g] = grpdelay(b, a, [], v.Fs);
      delay = round(mean(g));
    case 'irp'
      imp_resp = impz(b, a);
      [pks idx] = findpeaks(imp_resp, 'DoubleSided');
      pico = max(pks);
      delay = find(imp_resp==pico);
  endswitch


  % DEBUG
  if(v.debug)

    Max_freq = v.F_Nyquist;

    [h, w] = freqz(b, a, [], v.Fs);

    figure
    subplot(3, 1, 1);
    plot(w, 10*log10(abs(h)), 'LineWidth', 1.5);
    xticks([0, Max_freq]);
    xlabel('Frequência');
    ylabel('Amplitude (dB)');
    title('Ganho do Canal');
    grid

    subplot(3, 1, 2);
    plot(w, unwrap(angle(h)), 'LineWidth', 1.5);
    xticks([0, Max_freq]);
    xlabel('Frequência');
    ylabel('Ângulo (rad)');
    title('Fase do Canal');
    grid

    [g, w_g] = grpdelay(b, a, [], v.Fs);
    subplot(3, 1, 3);
    plot(w_g, g*v.Ts, 'LineWidth', 1.5);
    xticks([0, Max_freq]);
    xlabel('Frequência');
    ylabel('Tempo (s)');
    title('Atraso de Grupo do Canal');
    grid

    imp_resp = impz(b, a);
    figure, plot(imp_resp, 'LineWidth', 1.5);
    xlabel('Amostras');
    ylabel('Magnitude');
    legend({'Resposta ao Impulso do Canal'});
    h=get(gcf, "currentaxes");
    set(h, "fontsize", 16);
    grid

  endif

endfunction
