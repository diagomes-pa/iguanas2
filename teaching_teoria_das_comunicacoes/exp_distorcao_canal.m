%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simula��o do tipo Experimento.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
close
clc

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

  [b, a, delay] = selecionador_canal(ch_model, ch_par, 'irp');
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
debug = 0; % Determina se a simula��o vai mostrar as infomrma��es internas de algumas etapas.
v = set_fund_vars_digital(Ts, T, Tsym, debug);

fonte_fileName = 'data_sample/one_number.txt';
ch_model = 'lpf';
ch_par = [4, 100];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Transmissor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m = fonte_sinal(fonte_fileName);
s = modulador(m);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Canal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ch_par = [4, 1000];
r1 = channel(s, ch_model, ch_par);
ch_par = [4, 500];
r2 = channel(s, ch_model, ch_par);
ch_par = [4, 250];
r3 = channel(s, ch_model, ch_par);
ch_par = [4, 100];
r4 = channel(s, ch_model, ch_par);
ch_par = [4, 50];
r5 = channel(s, ch_model, ch_par);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sa�da de Resultados e Gr�ficos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sk_timeSubPlot({s, r1, r2, r3, r4, r5}, {'s', 'r1', 'r2', 'r3', 'r4', 'r5'}, {'c', 'c', 'c', 'c', 'c', 'c'});
