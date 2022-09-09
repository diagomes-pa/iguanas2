function out = src_sinusoid_T(A, f0, ph, T)
  % Gera uma senoide com dura��o de T segundos.
  % A: amplitude.
  % f0: frequ�ncia funcamental.
  % ph: fase.
  % T: dura��o da sen�ide.

  global v;

  t = 0 : v.Ts : T - v.Ts;

  out = A*cos(2*pi*f0*t + ph);

endfunction
