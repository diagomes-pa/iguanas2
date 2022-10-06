function r_sincronizado = comm_sincronizador_piloto(r, id_piloto,debug)
  % r: sinal recebido.
  % id_piloto: identifica��o do piloto que ser� anexado.
  % debug: usada para verificar os par�metros da sincroniza��o. 1 - mostra os par�metros;
  % 0 - n�o mostra.

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
