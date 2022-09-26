function sinal_com_piloto = comm_anexa_piloto(s, id_piloto)
  % s: sinal modulado que será transmitido.
  % id_piloto: identificação do piloto que será anexado.

  switch id_piloto
    case '50'
      arquivo_piloto = 'data_sample/piloto_50.txt';
    case '100'
      arquivo_piloto = 'data_sample/piloto_100.txt';
    case '200'
      arquivo_piloto = 'data_sample/piloto_200.txt';
  endswitch

  piloto = load(arquivo_piloto);

  sinal_com_piloto = [piloto; s];
  sinal_com_piloto(end-(length(piloto)-1):end) = []; % Remove do fim do sinal a quantidade
                                                     % de amostras que foi adicionada pelo
                                                     % piloto, a fim de que o comprimento
                                                     % do sinal transmitido não ultrapasse
                                                     % o tempo da simulação.

  endfunction
