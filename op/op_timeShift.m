function out = op_timeShift(x, t0)
  
  global v;
  t0_samp = floor(t0*v.Fs);
  
  out = zeros(v.N, 1);
  
  for n = 1 : v.N
    
    if(n - t0_samp > 0 && n - t0_samp <= v.N)
      out(n) = x(n - t0_samp);
    endif
    
  endfor
    
endfunction
