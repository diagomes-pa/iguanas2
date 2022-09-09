function bs = txtFile_num_to_bs(file_name, bpn, cod_bits)
  % Gera uum bitstream a partir dos números em um arquivo txt.
  % file_name: nome do arquivo com os números que serão convertidos para bits.
  % bpn: bits por número.
  % cod_bits: a codificação utilizada para mapear as amostras para bits. Pode receber
  % configurado como: 'natural' para uma conversão decimal binário, ou 'gray' para
  % utilização de código Gray.

  num = load(file_name);

  switch cod_bits
    case 'natural'
      b = dec2bin(num, bpn);
    case 'gray'
      %b = dec2bin(num, bpn);
  endswitch

  bs = reshape(b, size(b, 1)*size(b, 2), 1);

endfunction
