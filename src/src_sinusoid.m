function out = src_sinusoid(A, f0, ph)
  
  global v;
  
  out = A*cos(2*pi*f0*v.t + ph);
  
endfunction
