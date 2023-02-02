function y = comm_dsbscDemod(r, fc, f_cut)

  global v;

  f_cut_norm = f_cut/(v.F_Nyquist);

  carr = src_sinusoid(1, fc, 0);
  r_demod = r.*carr;

  [b, a] = butter(6, f_cut_norm);

  y = filtfilt(b, a, r_demod);

endfunction
