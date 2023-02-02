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

Ts = 0.0001; % Período de amostragem
T = 1; % Tempo total da simulação
Tsym = 0.01; % Período de símbolo
debug = 0; % Determina se a simulação vai mostrar as infomrmações internas de algumas etapas.
v = set_fund_vars_digital(Ts, T, Tsym, debug);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Implementação do experimento
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = src_filtNoise(1, 100); % Sinal de sistema analógico

m = txtFile_num_to_bs('data_sample/random_numbers_10.txt',  8, 'natural');
d = comm_codigo_linha_mod(m, 'rz-polar'); % Sinal de sistema digital

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Gráficos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sk_timeSubPlot({a, d}, {'Sinal Analogico', 'Sinal Digital'}, {'c', 'c'});
