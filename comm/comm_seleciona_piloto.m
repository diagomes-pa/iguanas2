function [piloto, n_amostras_piloto] = comm_seleciona_piloto(id_piloto)
  % s: sinal modulado que será transmitido.
  % id_piloto: identificação do piloto que será anexado.

  switch id_piloto
    case '50'
      arquivo_piloto = 'data_sample/piloto_50.txt';
      n_amostras_piloto = 50;
    case '100'
      arquivo_piloto = 'data_sample/piloto_100.txt';
      n_amostras_piloto = 100;
    case '200'
      arquivo_piloto = 'data_sample/piloto_200.txt';
      n_amostras_piloto = 200;
  endswitch

  piloto = load(arquivo_piloto);

  endfunction
