function s = comm_codigo_linha_mod(cod_type, bs)
  % bs: bitstream.

  global v;

  s = zeros(v.N, 1);

  switch cod_type
    case 'nrz-onoff'
      ak = [0, 1];
      pulse_shape = nrz_pulse_shape();
    case 'nrz-polar'
      ak = [-1, 1];
      pulse_shape = nrz_pulse_shape();
    case 'rz-onoff'
      ak = [0, 1];
      pulse_shape = rz_pulse_shape();
    case 'rz-polar'
      ak = [-1, 1];
      pulse_shape = rz_pulse_shape();
  endswitch

  x = map_bit_real(bs, ak);
  s_ = conv(x, pulse_shape);
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

function pulse_shape = nrz_pulse_shape()

  global v;

  pulse_shape = ones(v.L, 1);

endfunction

function pulse_shape = rz_pulse_shape()

  global v;

  pulse_shape = [ones(floor(v.L/2), 1); zeros(ceil(v.L/2), 1)];

endfunction

