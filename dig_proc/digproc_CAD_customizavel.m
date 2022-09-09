function bs = digproc_CAD_customizavel(sig, cad_Ts, b, cod_bits)
  % Conversor analógico digital, que recebe um sinal "contínuo" sig, e então retorna
  % um stream de bits.
  % sig: o sinal que será convertido para digital.
  % cad_Ts: o período de amostragem que será usado no CAD.
  % b: resolução do CAD.
  % cod_bits: a codificação utilizada para mapear as amostras para bits. Pode receber
  % configurado como: 'natural' para uma conversão decimal binário, ou 'gray' para
  % utilização de código Gray.

  global v;

  [sig_d, D] = digproc_amostrador(sig, cad_Ts);
  [sig_q, integer_codeword, levels]= digproc_quantizer(sig_d, b);
  bs = num_to_bs(integer_codeword, b, cod_bits);

endfunction
