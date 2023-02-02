function out = comm_dsbscMod(m, fc)

  carr = src_sinusoid(1, fc, 0);

  out = m.*carr;
endfunction
