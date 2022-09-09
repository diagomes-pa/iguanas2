function out = src_sinusoid(A, f0, ph)
  % Gera uma senoide.
  % A: amplitude.
  % f0: frequência funcamental.
  % ph: fase.

  global v;

  out = A*cos(2*pi*f0*v.t + ph);

endfunction
