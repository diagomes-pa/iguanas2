function [sig_d, D] = digproc_amostrador(sig, cad_Ts)
  % Gera amostras a partir de um sinal "cont�nuo" sig.
  % s: sinal que ser� amostrado.
  % cad_Ts: per�odo de amostragem utilizado pelo amostrador.


  global v;

  D = cad_Ts/v.Ts; % Fator de decima��o, ou a quantidade de amostras da simula��o
                   % entre as amostras do sinal discreto.
  sig_d = sig(1:int32(D):end); % Sinal discreto

endfunction
