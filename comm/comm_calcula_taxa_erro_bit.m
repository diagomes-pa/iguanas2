function taxa_erro_bit = comm_calcula_taxa_erro_bit(bs, bs_demod)
  %bs: bitstream.
  %bs_demod: bitstream demodulado.

  bits_incorretos = sum(bs != bs_demod);
  taxa_erro_bit = bits_incorretos/length(bs);

  endfunction
