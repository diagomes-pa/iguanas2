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

Ts = 0.0001; % Per�odo de amostragem
T = 0.02; % Tempo total da simula��o
Tsym = 0.001; % Per�odo de s�mbolo
v = set_fund_vars_digital(Ts, T, Tsym);

B_T = v.Rsym/2;
t_nulo = 1/(2*B_T);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Implementa��o do experimento
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[h, t_sinc] = gera_sinc(t_nulo, 3);
gr_delay = ceil(length(h)/2);

g = src_filtNoise(1, 100);
[gn, D] = digproc_sinalDiscretoDeContinuo(g, Tsym);

y = conv(h,gn);
y(1:gr_delay-1) = [];
y(end-(gr_delay-2):end) = [];

if(mod(length(h),2) == 0)
  y(end) = [];
end

y_d = digproc_sinalDiscretoDeContinuo(y, Tsym);

e_symb = gn - y_d; % Erro no sinal na sa�da do canal.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sa�da de Resultados e Gr�ficos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sk_timePlot({y, gn, g}, {'y', 'gn', 'g'}, {'c', 'd', 'c'});
sk_freqSubPlot({g}, {'g'}, {v.F_Nyquist})

snr = computeSNR(gn, e_symb)
