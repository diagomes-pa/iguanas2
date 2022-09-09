function out = src_sinusoid_T(A, f0, ph, T)
  % Gera uma senoide com duração de T segundos.
  % A: amplitude.
  % f0: frequência funcamental.
  % ph: fase.
  % T: duração da senóide.

  global v;

  t = 0 : v.Ts : T - v.Ts;

  out = A*cos(2*pi*f0*t + ph);

endfunction
