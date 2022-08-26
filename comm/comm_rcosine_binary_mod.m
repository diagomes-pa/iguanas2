function s = comm_rcosine_binary_mod(bs, r)

  global v;

  s = zeros(v.N, 1);

  ak = [-1, 1];
  pulse_shape = rcosfir(r, [-3 3], v.L);

  x = map_bit_real(bs, ak);
  s_ = conv(x, pulse_shape);
  s_ = s_(3*v.L + 1:end);
  s(1:length(s_)) = s_;

endfunction

function x = map_bit_real(bs, ak)

  global v;

  Nsym = length(bs);
  x = zeros(Nsym*v.L, 1);

  for k = 1 : Nsym

    if(bs(k) == '0')
      x((k-1)*v.L + 1) = ak(1);
    else
      x((k-1)*v.L + 1) = ak(2);
    endif
  endfor

endfunction
