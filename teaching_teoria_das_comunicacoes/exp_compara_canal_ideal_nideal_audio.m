%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Experimento avulso.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
close all
clc
warning('off', 'all');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configura o canal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function r = channel(s, ch_model, ch_par)

  global v;

  [b, a, delay] = selecionador_canal(ch_model, ch_par, 'grd');
  r = filter(b, a, s);

endfunction

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Variáveis da simulação
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global v;

Fs_aud = 44100; % Frequência de amostragem áudio
T = 10; % Tempo da aquisição
b_aud = 8; % Número de bits por amostra
debug = 1; % Determina se a simulação vai mostrar as infomrmações internas de algumas etapas.
v = set_fund_vars_aud(Fs_aud, T, b_aud, debug);

aud_file = '../data/no_meio_do_pitiu.wav';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Implementação do experimento
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

aud_sig = aud_audioRead(aud_file, T);
saida_canal_ideal = channel(aud_sig, 'ideal', [1 0.01]);
saida_canal_nao_ideal = channel(aud_sig, 'fase_aleat', []);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Saída de Resultados e Gráficos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aud_audioPlay(saida_canal_ideal, 1);
aud_audioPlay(saida_canal_nao_ideal, 1);
sk_timeSubPlot({saida_canal_ideal, saida_canal_nao_ideal}, {'i', 'ni'}, {'c', 'c'});
