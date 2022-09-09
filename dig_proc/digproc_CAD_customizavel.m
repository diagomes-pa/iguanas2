function bs = digproc_CAD_customizavel(sig, cad_Ts, b, cod_bits)
  % Conversor anal�gico digital, que recebe um sinal "cont�nuo" sig, e ent�o retorna
  % um stream de bits.
  % sig: o sinal que ser� convertido para digital.
  % cad_Ts: o per�odo de amostragem que ser� usado no CAD.
  % b: resolu��o do CAD.
  % cod_bits: a codifica��o utilizada para mapear as amostras para bits. Pode receber
  % configurado como: 'natural' para uma convers�o decimal bin�rio, ou 'gray' para
  % utiliza��o de c�digo Gray.

  global v;

  [sig_d, D] = digproc_amostrador(sig, cad_Ts);
  [sig_q, integer_codeword, levels]= digproc_quantizer(sig_d, b);
  bs = num_to_bs(integer_codeword, b, cod_bits);

endfunction
