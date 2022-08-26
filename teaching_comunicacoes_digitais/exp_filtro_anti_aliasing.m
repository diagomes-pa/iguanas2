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

Ts = 0.001; % Per�odo de amostragem
T = 20; % Tempo total da simula��o

v = set_fund_vars(Ts, T);

exp_Ts = 0.002; % Per�odo de amostragem simulado no experimento
L = int32(exp_Ts/Ts); % N�mero de amostras originais entre as simuladas

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Implementa��o do experimento
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s_a = src_filtNoise(1, 100) + src_sinusoid(1, 350, 0); % Sinal anal�gico
s_d = s_a(1:L:end); % Sinal discreto

[b, a] = butter(16, 1/L); % Filtro antialiasing
s_a_filt = filter(b, 1, s_a);
s_d_aa = s_a_filt(1:L:end);% Sinal discreto com filtro anti-aliasing

%s_d_aa = decimate(s_a, L);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sa�da de Resultados e Gr�ficos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sk_freqSubPlot({s_a, s_d, s_a_filt, s_d_aa}, {'a', 'd', 'a_filt', 'd_aa'}, {v.F_Nyquist, v.F_Nyquist/L, v.F_Nyquist, v.F_Nyquist/L});
