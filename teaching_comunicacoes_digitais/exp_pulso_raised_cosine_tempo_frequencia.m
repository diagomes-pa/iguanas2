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

Ts = 1/44100; % Per�odo de amostragem
T = 0.035; % Tempo total da simula��o
Tsym = 20*Ts; % Per�odo de s�mbolo
v = set_fund_vars_digital(Ts, T, Tsym);

bs = '1';
code = 'onoff';
n_symb = 20;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Implementa��o do experimento
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pulse_0 = comm_sinc_binary_mod(bs, code, n_symb);
pulse_20 = comm_rcosine_binary_mod(bs, 0.2, code, n_symb);
pulse_50 = comm_rcosine_binary_mod(bs, 0.5, code, n_symb);
pulse_100 = comm_rcosine_binary_mod(bs, 1, code, n_symb);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sa�da de Resultados e Gr�ficos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sk_timePlot({pulse_0, pulse_20, pulse_50, pulse_100}, {'0', '20', '50', '100'}, {'c', 'c', 'c', 'c'});
sk_freqPlot({pulse_0, pulse_20, pulse_50, pulse_100}, {'0', '20', '50', '100'});
