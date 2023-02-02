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
ch_gain = 0.5; % Ganho do canal.
ch_model = 'lpf';
ch_par = [4, 100];
ch_n_power = 1e-1;

modificacao_canal = 4; % 0: canal ideal.
                       % 1: atenua��o.
                       % 2: distor��o.
                       % 3: ru�do.
                       % 4: atenua��o, distor��o e ru�do.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Transmissor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m = fonte_sinal(fonte_fileName);
s = modulador(m);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Canal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch(modificacao_canal)
  case 0
    r = s;
   case 1
    r = ch_gain*s;
   case 2
    r = channel(s, ch_model, ch_par);
   case 3
    n = src_noise(ch_n_power);
    r = s + n;
   case 4
    n = src_noise(ch_n_power);
    r = ch_gain*channel(s, ch_model, ch_par) + n;
endswitch


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Receptor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y = demodulador(r);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sa�da de Resultados e Gr�ficos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sk_timeSubPlot({s, r}, {'s', 'r'}, {'c', 'c'});
