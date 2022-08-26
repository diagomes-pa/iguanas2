function out = src_exponential(C, a)
  
  global v;
  
  out = C*exp(a*v.t);
  
endfunction