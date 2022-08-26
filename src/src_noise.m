function out = src_noise(n_power)
  
  global v;
  
  out = sqrt(n_power)*randn(v.N, 1);    
    
endfunction