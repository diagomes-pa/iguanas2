function s = comm_AMMod(m, A, fc)

  carr = src_sinusoid(1, fc, 0);

  s = (A + m).*carr;
endfunction
