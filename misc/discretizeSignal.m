function out = discretizeSignal(s, Ts_mult)
  
  global v;
  
  out = zeros(size(s));
  out(1:Ts_mult:end) = s(1:Ts_mult:end);
  
endfunction
