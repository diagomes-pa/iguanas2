function out = src_filtNoise(P, f_cut)

  global v;

  f_cut_norm = f_cut/(v.Fs/2);

  n = sqrt(P)*randn(v.N, 1);

  %[b, a] = digproc_lowPassFilter(0.1*v.N, f_cut);
  [b, a] = butter(10, f_cut_norm);

  out = filtfilt(b, a, n);

endfunction
