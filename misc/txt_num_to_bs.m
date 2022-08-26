function bs = txt_num_to_bs(file_name, bpn)
  %bpn: bits por número.

  num = load(file_name);
  b = dec2bin(num, bpn);

  bs = reshape(b, size(b, 1)*size(b, 2), 1);

endfunction
