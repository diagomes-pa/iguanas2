function [h, t_sinc] = gera_sinc(t_lob, n_lob)
  % Gera um sinal do tipo sinc.
  % t_lob: per�odo do l�bulo princial em segundos.
  % n_lob: n�mero de l�bulos.

  global v;

  t_sinc = -n_lob*t_lob : v.Ts : n_lob*t_lob;
  h = sinc(t_sinc/t_lob);

endfunction
