function [b, a] = ch_fase_aleatoria()
  % Modelo de canal com ganho unitário e fase aleatória.

  global v;

  comp_canal = min([1000 v.N]); % Utilizamos um canal com comprimento menor que o
                               % da simulação para que a filtragem não seja tão
                               % custosa computacionalemente.
  if(mod(comp_canal, 2) == 0)
    metade_espec = ceil(comp_canal/2) + 1;
  else
    comp_canal = comp_canal - 1;
    metade_espec = ceil(comp_canal/2) + 1;
  endif

  h = zeros(comp_canal, 1);
  h(1) = 1;

  H = fft(h);
  ABS_H_DIST = abs(H)%ganho do canal distorcivo

  ANG_H_DIST = zeros(comp_canal, 1);
  ANG_H_DIST(1:metade_espec) = (2*pi/10)*randi(10, metade_espec, 1) - pi;
  ANG_H_DIST(1) = 0;
  ANG_H_DIST(metade_espec) = 0;
  ANG_H_DIST(metade_espec+1:end) = -flipud(ANG_H_DIST(2:metade_espec-1));
  H_DIST = ABS_H_DIST.*(e.^(i*ANG_H_DIST));

  b = abs(ifft(H_DIST));

  a = 1;

endfunction
