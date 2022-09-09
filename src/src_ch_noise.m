function out = src_ch_noise(n_power, N)
  % Gera ru�do de canal, e retorna um vetor do comprimento do vetor do sinal recebido.
  % n_power: pot�ncia do ru�do.
  % N: comprimento do vetor gerado.

  global v;

  out = sqrt(n_power)*randn(N, 1);

endfunction
