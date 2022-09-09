function [h, t_sinc] = gera_sinc(t_lob, n_lob)
  % Gera um sinal do tipo sinc.
  % t_lob: período do lóbulo princial em segundos.
  % n_lob: número de lóbulos.

  global v;

  t_sinc = -n_lob*t_lob : v.Ts : n_lob*t_lob;
  h = sinc(t_sinc/t_lob);

endfunction
