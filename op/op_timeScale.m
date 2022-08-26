function out = op_timeScale(x, a)
  
  global v;
 
  a = round(a); 
  out = zeros(v.N, 1);
  
  for n = 1 : v.N
    
    if(n*a > 0 && n*a <= v.N)
      out(n) = x(n*a);
    endif
    
  endfor
    
endfunction