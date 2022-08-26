function snr = computeSNR(sig, n)
  
  snr = sum(sig.^2)/sum(n.^2);
endfunction
