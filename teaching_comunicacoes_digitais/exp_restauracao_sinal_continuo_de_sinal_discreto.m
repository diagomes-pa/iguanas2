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
T = 0.1; % Tempo total da simula��o
v = set_fund_vars(Ts, T);

cad_Fs = 200;
cad_Ts = 1/cad_Fs; % Per�odo entre as amostras do sinal discreto
f_cut_filt= cad_Fs/2;
t_nulo = 1/(2*f_cut_filt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Implementa��o do experimento
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[h, t_sinc] = gera_sinc(t_nulo, 5); % Resposta ao impulso do filtro restaurador.
gr_delay = ceil(length(h)/2);

g = src_filtNoise(1, 100); % Sinal original.
[gn, D] = digproc_sinalDiscretoDeContinuo(g, cad_Ts); % Sinal discreto.

y = conv(h, gn);
y(1:gr_delay-1) = [];
y(end-(gr_delay-2):end) = [];

if(mod(length(h),2) == 0)
  y(end) = [];
end

e_rest = g - y; % Erro na restaura��o do sinal cont�nuo a partir do discreto.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sa�da de Resultados e Gr�ficos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sk_timePlot({y, gn, g}, {'y', 'gn', 'g'}, {'c', 'd', 'c'});
sk_freqSubPlot({g, y}, {'g', 'y'}, {v.F_Nyquist, v.F_Nyquist})

snr = computeSNR(g, e_rest)

