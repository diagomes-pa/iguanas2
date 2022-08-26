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

pkg load signal

Ts = 0.001; % Período de amostragem
T = 1; % Tempo total da simulação
v = set_fund_vars(Ts, T);

P = 1;
f_cut = 300;
b = 3;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Implementação do experimento
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%s = src_filtNoise(P, f_cut);
s = src_sinusoid(1, 2, 0);
[s_q,integer_codeword,levels] = digproc_quantizer(s,b);
e_q = s - s_q;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Saída de Resultados e Gráficos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sk_timePlot([e_q, s, s_q], {"e", "s", "s_q"}, {"d", "d", "d"});
P_e = mean(e_q.^2)
P_e_est = 1/(3*(2^b)^2)

