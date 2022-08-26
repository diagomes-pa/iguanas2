function out = src_sqrWav(f0)
  
  global v;
  
  Fs = v.Fs; % Frequency sampling
  n_samp_cicle = ceil(Fs/f0);
  
  cicle = [ones(floor(n_samp_cicle/2), 1); zeros(ceil(n_samp_cicle/2), 1)];
  
  n_cicles = floor(v.N/n_samp_cicle);
  n_samp_last_cicle = mod(v.N, n_samp_cicle);
  
  out = [];
  
  for c = 1 : n_cicles
    out = [out; cicle];
  endfor
  
  out = [out; cicle(1 : n_samp_last_cicle)];

endfunction
