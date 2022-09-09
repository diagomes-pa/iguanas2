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
T = 0.1; % Tempo total da simulação
v = set_fund_vars(Ts, T);

cad_Fs = 200;
cad_Ts = 1/cad_Fs; % Período entre as amostras do sinal discreto
f_cut_filt= cad_Fs/2;
t_nulo = 1/(2*f_cut_filt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Implementação do experimento
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

e_rest = g - y; % Erro na restauração do sinal contínuo a partir do discreto.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Saída de Resultados e Gráficos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sk_timePlot({y, gn, g}, {'y', 'gn', 'g'}, {'c', 'd', 'c'});
sk_freqSubPlot({g, y}, {'g', 'y'}, {v.F_Nyquist, v.F_Nyquist})

snr = computeSNR(g, e_rest)

