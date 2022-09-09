%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Experimento avulso.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
close
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vari�veis da simula��o
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global v;

Ts = 0.0001; % Per�odo de amostragem
T = 2; % Tempo total da simula��o
v = set_fund_vars(Ts, T);

sig_type = 5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Implementa��o do experimento
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch(sig_type)
  case 1
    x = src_sinusoid(1, 500, 0);
  case 2
    x = src_noise(1);
  case 3
    x = src_filtNoise(1, 300);
  case 4
    m = src_filtNoise(1, 300);
    x = comm_dsbscMod(m, 2000);
  case 5
    m = src_filtNoise(1, 300);
    x = comm_AMMod(m, 1, 2000);
endswitch

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sa�da de Resultados e Gr�ficos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sk_psdSubPlot({x}, {'x'}, {v.F_Nyquist});
