function s = comm_sinc_binary_mod(bs, code, n_symb)
  % bs: bitstream.
  % code: 'onoff', 'polar' ou 'bipolar'.
  % n_symb: o número de símbolos adjacentes que o pulso se espalha.

  global v;

  s = zeros(v.N, 1);

  switch code
    case 'onoff'
      ak = [0, 1];
    case 'polar'
      ak = [-1, 1];
    case 'bipolar'
      ak = [];
  endswitch

  pulse_shape = gera_sinc(v.Tsym, n_symb);

  x = map_bit_real(bs, ak, code);
  s_ = conv(x, pulse_shape);
  s_ = s_(3*v.L + 1:end);
  s(1:length(s_)) = s_;

endfunction

function x = map_bit_real(bs, ak, code)

  global v;

  Nsym = length(bs);
  x = zeros(Nsym*v.L, 1);

  if(strcmp(code, 'bipolar'))

    last_one = -1;
    for k = 1 : Nsym
      if(bs(k) == '0')
        x((k-1)*v.L + 1) = 0;
      else
        x((k-1)*v.L + 1) = -last_one;
        last_one = -last_one;
      endif
    endfor

  else

    for k = 1 : Nsym
      if(bs(k) == '0')
        x((k-1)*v.L + 1) = ak(1);
      else
        x((k-1)*v.L + 1) = ak(2);
      endif
    endfor

  endif

endfunction
