function snr = computeSNR(sig, n)
  % Calcula a SNR entre os sinais sig e n.

  snr = sum(sig.^2)/sum(n.^2);

endfunction
