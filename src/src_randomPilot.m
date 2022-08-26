function out = src_randomPilot(Nsymb)
  # Nsymb: the duration of the pilot in number of symbols.

  global v;
  
  n_samp_symb = floor(v.Tsymb/v.Ts); # Número de amostras por símbolo.
  
  out = randn(n_samp_symb*Nsymb, 1);
  
endfunction