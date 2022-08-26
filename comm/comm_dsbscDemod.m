function y = comm_dsbscDemod(r, fc, f_cut)

  global v;

  f_cut_norm = f_cut/(v.Fs/2);

  carr = src_sinusoid(1, fc, 0);
  r_demod = r.*carr;


  %[a,b] = digproc_lowPassFilter(10, f_cut);
  [b, a] = butter(10, f_cut_norm);

  y = filtfilt(b, a, r_demod);

endfunction
