function out = comm_AMMod(m, A, fc)

  carr = src_sinusoid(1, fc, 0);

  out = (A + m).*carr;
endfunction
