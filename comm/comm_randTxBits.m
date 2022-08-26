function out = comm_randTxBits(b)
  
  global v;
  
  n_symb = floor(v.T/v.Tsymb); 
  
  out = randi([0 1], n_symb*b, 1);
  
endfunction