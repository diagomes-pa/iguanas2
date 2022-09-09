function [sig_q, integer_codeword, levels]= digproc_quantizer(sig_d, b)
  % Quantiza o sinal "discreto" sig_d.
  % sig: o sinal que será quantizado.
  % b: a resolução do quantizador.

  max_sig = max(sig_d);
  min_sig = min(sig_d);
  Vpp = max_sig - min_sig;

  L = 2^b;
  Delta = Vpp/L;

  above_max = find(sig_d > max_sig-(Delta/2));
  below_min = find(sig_d < min_sig+(Delta/2));
  sig_d(above_max) = max_sig - (Delta/2);
  sig_d(below_min) = min_sig + (Delta/2);

  if(min_sig < 0)
    sig_up = sig_d + abs(min_sig + Delta/2);
    sig_norm = sig_up/(Vpp-Delta);
  else
    sig_up = sig_d - abs(min_sig + Delta/2);
    sig_norm = sig_up/(Vpp-Delta);
  endif

  integer_codeword = round(sig_norm/Delta*(Vpp-Delta));
  sig_q = integer_codeword*Delta + abs(min_sig + Delta/2);

  levels = min_sig+(Delta/2):Delta:max_sig-(Delta/2);

endfunction
