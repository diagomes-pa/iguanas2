function [b, a] = ch_ideal(ganho, atraso)
  % Modelo de canal ideal.
  % ganho: o fator de escala do canal.
  % atraso: o atraso aplicado pelo canal ao sinal transmitido.

  global v;

  atraso_em_amostras = round(atraso/v.Ts);

  b = zeros(atraso_em_amostras, 1); % Utilizamos um canal com comprimento menor que o
                                    % da simulação para que a filtragem não seja tão
                                    % custosa computacionalemente.
  b(atraso_em_amostras) = 1;
  b = ganho*b;

  a = 1;

endfunction
