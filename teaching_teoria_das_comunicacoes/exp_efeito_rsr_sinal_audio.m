%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Experimento avulso.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
close all
clc
warning('off', 'all');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Variáveis da simulação
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global v;

Fs_aud = 8000; % Frequência de amostragem áudio
T = 10; % Tempo da aquisição
b_aud = 8; % Número de bits por amostra
debug = 0; % Determina se a simulação vai mostrar as infomrmações internas de algumas etapas.
v = set_fund_vars_aud_rt(Fs_aud, T, b_aud, debug);

aud_file = '../data/no_meio_do_pitiu.wav';
ch_n_power = 1e0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Implementação do experimento
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

aud_sig = aud_audioRead(aud_file, T);
ruido = src_ch_noise(ch_n_power, length(aud_sig));
aud_mais_ruido = aud_sig + ruido;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Saída de Resultados e Gráficos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aud_audioPlay(aud_mais_ruido, 1);
snr = computeSNR(aud_sig, ruido)
