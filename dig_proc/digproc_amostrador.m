function [sig_d, D] = digproc_amostrador(sig, cad_Ts)
  % Gera amostras a partir de um sinal "contínuo" sig.
  % s: sinal que será amostrado.
  % cad_Ts: período de amostragem utilizado pelo amostrador.


  global v;

  D = cad_Ts/v.Ts; % Fator de decimação, ou a quantidade de amostras da simulação
                   % entre as amostras do sinal discreto.
  sig_d = sig(1:int32(D):end); % Sinal discreto

endfunction
