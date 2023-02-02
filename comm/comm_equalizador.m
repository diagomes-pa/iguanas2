function r_equalizado = comm_equalizador(r, eq_tipo, eq_N, eq_K)
  % Realiza a equalização de acordo com o definido no livo do Lathi.
  % r: sinal recebido.
  % eq_tipo: tipo de qualizador utilizado. zf: zero forcing; mmse: mínimo erro quadrático médio.
  % eq_N: ordem do equalizador.
  % eq_K: tamanho da janela para o equalizador MMSE.

  global v;

  simbolos_recebidos = zeros(v.n_Tx_bits, 1);
  for simb = 1:v.n_Tx_bits
    simbolos_recebidos(simb) = r((simb-1)*v.L+1);
  endfor

  switch eq_tipo
    case 'zf'
      po = zeros(2*eq_N+1, 1);
      po(eq_N+1) = 1;

      pr = simbolos_recebidos(1:4*eq_N+1);
      Pr = zeros(2*eq_N+1, 2*eq_N+1);
      for k = 1 : 2*eq_N+1
        Pr(k, :) = transpose(flipud(pr(k:k+2*eq_N)));
      endfor

      c = inv(Pr)*po;
      # Insere zeros entre os coeficientes para que possamos convoluir com o sinal no tempo, antes de extrair os instante de decisão.
      c_L = zeros(2*eq_N+1, v.L);
      c_L(:,1) = c;
      c_L = transpose(c_L);
      c_L = c_L(:);

    case 'mmse'
      filt_len = (eq_N + eq_K) - (eq_N - eq_K) + 1;
      po = zeros(filt_len, 1);
      po(floor(filt_len/2)+1) = 1;

      pr = simbolos_recebidos(1:4*eq_N+1);
      pr = transpose(pr);
      Pr = convmtx(fliplr(pr), filt_len)
      n_cols = size(Pr)(2)
      extra_cols = n_cols - (2*eq_N+1)
      Pr(:, 1:int32(extra_cols/2)) = [];
      Pr(:, (end - int32(extra_cols/2)) + 1: end) = []

      c = pinv(Pr)*po
      # Insere zeros entre os coeficientes para que possamos convoluir com o sinal no tempo, antes de extrair os instante de decisão.
      c_L = zeros(2*eq_N+1, v.L);
      c_L(:,1) = c;
      c_L = transpose(c_L);
      c_L = c_L(:);

  endswitch

  r_equalizado = filter(c_L, 1, r);

  % Remove o atraso de grupo do equalizador
  %[g, w_g] = grpdelay(b, a, [], v.Fs);
  %grd = round(mean(g));
  % Determina o atraso de grupo pelo pico da resposta ao impulso.
  imp_resp = c_L;
  [pks idx] = findpeaks(imp_resp, 'DoubleSided');
  pico = max(pks);
  grd = find(imp_resp==pico);

  r_equalizado(1:grd-1) = [];
  r_equalizado = [r_equalizado; zeros(grd-1, 1)];

  if(v.debug)

    disp('Coeficientes do equalizador:');
    disp(num2str(c));

    pr_t = r(1 : (4*eq_N + 1)*v.L);
    figure;
    plot(v.t(1 : (4*eq_N + 1)*v.L), pr_t, "LineWidth", 2);
    xlabel("Tempo");
    ylabel('Amplitude');
    title('Piloto Recebido de Treino do Equalizador');
    h=get(gcf, "currentaxes");
    set(h, "fontsize", 14);
    grid

  endif

endfunction
