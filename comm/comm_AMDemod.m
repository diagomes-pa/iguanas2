function y = comm_AMDemod(r)

  global v;

  y = abs(hilbert(r));

endfunction
