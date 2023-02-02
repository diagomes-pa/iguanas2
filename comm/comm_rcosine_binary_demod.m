function bs = comm_rcosine_binary_demod(r, code, n_symb)
  % r: sinal recebido, em que o sinal piloto foi removido.
  % code: 'onoff', 'polar' ou 'bipolar'.
  % n_symb: o número de símbolos adjacentes que o pulso se espalha.

  global v;

  simbolos_recebidos = zeros(v.n_Tx_bits, 1);

  for simb = 1:v.n_Tx_bits

    simbolos_recebidos(simb, :) = r((simb-1)*v.L+1);

  endfor

  pulse_shape = rcosfir(r, [-n_symb n_symb], v.L);

  switch code
    case 'onoff'
      bs = demod_onoff(simbolos_recebidos, pulse_shape);
    case 'polar'
      bs = demod_polar(simbolos_recebidos, pulse_shape);
    case 'bipolar'
      bs = [];
  endswitch

endfunction


function bs = demod_onoff(simbolos_recebidos, pulse_shape)

  global v;

  A = 1;
  gamma = 0.5*A;

  bs = cell(v.n_Tx_bits,1);

  for simb = 1:v.n_Tx_bits

     z = simbolos_recebidos(simb);
     if(z <= gamma)
        bs(simb) = '0';
      else
        bs(simb) = '1';
     endif
  endfor

  bs = cell2mat(bs);

endfunction


function bs = demod_polar(simbolos_recebidos, pulse_shape)

  global v;

  gamma = 0; % Limiar de detecção de acordo como definido no Sklar para sinalização polar.

  bs = cell(v.n_Tx_bits,1);

  for simb = 1:v.n_Tx_bits

     z = simbolos_recebidos(simb);

     if(z <= gamma)
        bs(simb) = '0';
      else
        bs(simb) = '1';
     endif
  endfor

  bs = cell2mat(bs);

endfunction

