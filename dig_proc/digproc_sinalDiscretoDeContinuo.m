function [sig_d, D] = digproc_sinalDiscretoDeContinuo(sig, cad_Ts)
  % Gera um sinal discreto sig_g a partir de um "cont�nuo" sig, e com o mesmo comprimento.
  % sig: sinal que ser� amostrado.
  % cad_Ts: per�odo de amostragem utilizado pelo amostrador.


  global v;

  D = cad_Ts/v.Ts; % Fator de decima��o, ou a quantidade de amostras da simula��o
                   % entre as amostras do sinal discreto.

  sig_d = zeros(length(sig),1);
  sig_d(1:int32(D):end) = sig(1:int32(D):end); % Sinal discreto

endfunction
