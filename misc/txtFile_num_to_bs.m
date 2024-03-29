function bs = txtFile_num_to_bs(file_name, bpn, cod_bits)
  % Gera uum bitstream a partir dos n�meros em um arquivo txt.
  % file_name: nome do arquivo com os n�meros que ser�o convertidos para bits.
  % bpn: bits por n�mero.
  % cod_bits: a codifica��o utilizada para mapear as amostras para bits. Pode receber
  % configurado como: 'natural' para uma convers�o decimal bin�rio, ou 'gray' para
  % utiliza��o de c�digo Gray.

  num = load(file_name);

  switch cod_bits
    case 'natural'
      b = dec2bin(num, bpn);
    case 'gray'
      %b = dec2bin(num, bpn);
  endswitch

  bs = reshape(b, size(b, 1)*size(b, 2), 1);

endfunction
