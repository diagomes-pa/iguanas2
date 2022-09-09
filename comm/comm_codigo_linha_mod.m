function s = comm_codigo_linha_mod(bs, cod_linha)
  % bs: bitstream.
  % cod_linha: tipo de código de linha que será usado na transmissão.

  global v;

  s = zeros(v.N, 1);

  cod_type_split = strsplit(cod_linha, '-');

  switch cod_type_split{1}
    case 'nrz'
      pulse_shape = nrz_pulse_shape();
    case 'rz'
      pulse_shape = rz_pulse_shape();
  endswitch

  switch cod_type_split{2}
    case 'onoff'
      ak = [0, 1];
    case 'polar'
      ak = [-1, 1];
    case 'bipolar'
      ak = [];
  endswitch

  x = map_bit_real(bs, ak, cod_type_split{2});
  s_ = conv(x, pulse_shape);
  s(1:length(s_)) = s_;

endfunction


function x = map_bit_real(bs, ak, code)

  global v;

  Nsym = length(bs);
  x = zeros(Nsym*int64(v.L), 1);

  if(strcmp(code, 'bipolar'))

    last_one = -1;
    for k = 1 : Nsym
      if(bs(k) == '0')
        x((k-1)*int64(v.L) + 1) = 0;
      else
        x((k-1)*int64(v.L) + 1) = -last_one;
        last_one = -last_one;
      endif
    endfor

  else

    for k = 1 : Nsym
      if(bs(k) == '0')
        x((k-1)*int64(v.L) + 1) = ak(1);
      else
        x((k-1)*int64(v.L) + 1) = ak(2);
      endif
    endfor

  endif

endfunction


function pulse_shape = nrz_pulse_shape()

  global v;

  pulse_shape = ones(int64(v.L), 1);

endfunction


function pulse_shape = rz_pulse_shape()

  global v;

  pulse_shape = [ones(floor(int64(v.L)/2), 1); zeros(ceil(int64(v.L)/2), 1)];

endfunction

