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

Ts = 1/44100; % Período de amostragem
T = 0.035; % Tempo total da simulação
Tsym = 20*Ts; % Período de símbolo
v = set_fund_vars_digital(Ts, T, Tsym);

bs = '1';
code = 'onoff';
n_symb = 20;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Implementação do experimento
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pulse_0 = comm_sinc_binary_mod(bs, code, n_symb);
pulse_20 = comm_rcosine_binary_mod(bs, 0.2, code, n_symb);
pulse_50 = comm_rcosine_binary_mod(bs, 0.5, code, n_symb);
pulse_100 = comm_rcosine_binary_mod(bs, 1, code, n_symb);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Saída de Resultados e Gráficos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sk_timePlot({pulse_0, pulse_20, pulse_50, pulse_100}, {'0', '20', '50', '100'}, {'c', 'c', 'c', 'c'});
sk_freqPlot({pulse_0, pulse_20, pulse_50, pulse_100}, {'0', '20', '50', '100'});
