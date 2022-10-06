function r_sincronizado = comm_sincronizador_piloto(r, id_piloto,debug)
  % r: sinal recebido.
  % id_piloto: identificação do piloto que será anexado.
  % debug: usada para verificar os parâmetros da sincronização. 1 - mostra os parâmetros;
  % 0 - não mostra.

  global v;

  indice_inicio_sinal = comm_localiza_piloto(r, id_piloto);
  r_sincronizado = r(indice_inicio_sinal:end);
  r_sincronizado = [r_sincronizado; zeros(indice_inicio_sinal-1, 1)];

  if(v.debug)

    disp(strcat('O inicio do sinal modulado foi lozalizado no indice: ', num2str(indice_inicio_sinal)));
    disp('');

    sk_timeSubPlot({r, r_sincronizado}, {'Sinal Recebido', 'Sinal Recebido Sincronizado'}, {'c', 'c'});

  endif

endfunction
