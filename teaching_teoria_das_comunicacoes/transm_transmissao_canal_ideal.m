%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simula��o do tipo transmiss�o.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
close all
clc
warning('off', 'all');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configura o fonte de sinal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function m = fonte_sinal(fonte_fileName)

  global v;

  m = txtFile_num_to_bs(fonte_fileName, 8, 'natural');

endfunction

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configura o modulador
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function s = modulador(m)

  global v;

  cod_type = 'nrz-polar';

  s = comm_codigo_linha_mod(m, cod_type);

endfunction

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configura o canal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function r = channel(s, ch_model, ch_par)

  global v;

  [b, a, delay] = selecionador_canal(ch_model, ch_par, 'grd');
  r = filter(b, a, s);

endfunction

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configura o demodulador
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function y = demodulador(r)

  global v;

  y = r;

endfunction

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vari�veis da simula��o
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global v;
Ts = 0.0001; % Per�odo de amostragem
T = 0.1; % Tempo total da simula��o
Tsym = 0.01; % Per�odo de s�mbolo
debug = 1; % Determina se a simula��o vai mostrar as infomrma��es internas de algumas etapas.
v = set_fund_vars_digital(Ts, T, Tsym, debug);


fonte_fileName = 'data_sample/one_number.txt';
ch_model = 'ideal';
ch_par = [1, 0.01];
ch_n_power = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Transmissor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m = fonte_sinal(fonte_fileName);
s = modulador(m);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Canal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = src_noise(ch_n_power);
r = channel(s, ch_model, ch_par) + n;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Receptor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y = demodulador(r);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sa�da de Resultados e Gr�ficos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sk_timeSubPlot({s, r}, {'s', 'r'}, {'c', 'c'});
sk_psdSubPlot({s}, {'s'}, {v.F_Nyquist});
