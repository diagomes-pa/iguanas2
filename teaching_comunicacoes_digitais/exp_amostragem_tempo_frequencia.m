%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Experimento avulso.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
close
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Variáveis da simulação
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global v;

Ts = 0.001; % Período de amostragem
T = 1; % Tempo total da simulação

v = set_fund_vars(Ts, T);

exp_Ts = 0.001; % Período de amostragem simulado no experimento
L = int32(exp_Ts/Ts); % Número de amostras originais entre as simuladas

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Implementação do experimento
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s_a = src_filtNoise(1, 100) + src_sinusoid(0.01, 200, 0); % Sinal analógico
s_d = s_a(1:L:end); % Sinal discreto


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Gráficos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sk_timeSubPlot({s_a, s_d}, {'a', 'd'}, {'c', 'd'});
sk_freqSubPlot({s_a, s_d}, {'a', 'd'}, {v.F_Nyquist, v.F_Nyquist/L});
