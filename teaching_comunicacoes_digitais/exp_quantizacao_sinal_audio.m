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

Fs_aud = 44100; % Frequência de amostragem áudio
T = 1; % Tempo da aquisição
b_aud = 8; % Número de bits por amostra
v = set_fund_vars_aud_rt(Fs_aud, T, b_aud);

b_quant = 2;
aud_file = '../data/conquista.wav';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Implementação do experimento
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aud_sig = aud_audioRead(aud_file, T);
[aud_q,integer_codeword,levels] = digproc_quantizer(aud_sig, b_quant);
e_q = aud_sig - aud_q;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Saída de Resultados e Gráficos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aud_audioPlay(aud_q, 1);
sk_timePlot([aud_sig, aud_q, e_q], {'s', 's_q', 'e_q'}, {"d", "d", "d"});
