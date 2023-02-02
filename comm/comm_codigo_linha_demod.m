function bs = comm_codigo_linha_demod(r, cod_linha)
  % r: sinal recebido, em que o sinal piloto foi removido.
  % cod_linha: tipo de código de linha que será usado na transmissão.

  global v;

  simbolos_recebidos = zeros(v.n_Tx_bits, v.L);

  for simb = 1:v.n_Tx_bits

    simbolos_recebidos(simb, :) = r((simb-1)*v.L+1 : simb*v.L);

  endfor

  cod_type_split = strsplit(cod_linha, '-');

  switch cod_type_split{1}
    case 'nrz'
      pulse_shape = nrz_pulse_shape();
    case 'rz'
      pulse_shape = rz_pulse_shape();
  endswitch

  switch cod_type_split{2}
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
  gamma = 0.5*A*v.L; % Limiar de detecção de acordo como definido no Sklar para sinalização unipolar.

  bs = cell(v.n_Tx_bits,1);

  for simb = 1:v.n_Tx_bits

     z = dot(simbolos_recebidos(simb, :), pulse_shape);
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

     z_1 = dot(simbolos_recebidos(simb, :), pulse_shape);
     z_2 = dot(simbolos_recebidos(simb, :), -pulse_shape);
     z = z_1 - z_2;

     if(z <= gamma)
        bs(simb) = '0';
      else
        bs(simb) = '1';
     endif
  endfor

  bs = cell2mat(bs);

endfunction


function pulse_shape = nrz_pulse_shape()

  global v;

  pulse_shape = ones(int64(v.L), 1);

endfunction


function pulse_shape = rz_pulse_shape()

  global v;

  pulse_shape = [ones(floor(int64(v.L)/2), 1); zeros(ceil(int64(v.L)/2), 1)];

endfunction
