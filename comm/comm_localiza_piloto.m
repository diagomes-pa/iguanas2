function indice_inicio_sinal = comm_localiza_piloto(r, id_piloto)
  % r: sinal recebido.
  % id_piloto: identificação do piloto que será anexado.

  pkg load signal;

  [piloto, n_amostras_piloto] = comm_seleciona_piloto(id_piloto);
  [correl, lag] = xcorr(r, piloto);

  indice_inicio_piloto_ = find(correl == max(correl));
  indice_inicio_piloto = lag(indice_inicio_piloto_);

  indice_inicio_sinal = indice_inicio_piloto + n_amostras_piloto + 1;

endfunction
