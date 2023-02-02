function [b, a] = ch_identidade()
  % Modelo de canal identidade: ganho unitário e atraso 0.

    global v;

  b = zeros(v.N, 1);
  b(1) = 1;

  a = 1;

endfunction
