%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simulação do tipo transmissão.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
close
clc
warning('off', 'all');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configura o fonte de sinal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function m = fonte_sinal(fonte_fileName, eq_N)

  global v;

  m = txtFile_num_to_bs(fonte_fileName, 8, 'natural');

  % Sinal piloto usado para treinar o equalizador.
  eq_piloto = [];
  for eq_p = 1 : 4*eq_N + 1
    if(eq_p == 2*eq_N+1)
      eq_piloto = [eq_piloto; '1'];
    else
      eq_piloto = [eq_piloto; '0'];
    endif
  endfor

  m = [eq_piloto; m];
  v.n_Tx_bits = length(m); % Para informar o receptor quantos bits devem ser decodificados

endfunction

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configura o modulador
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function x = modulador(m, code, rolloff, id_piloto, pot_piloto)

  global v;

  n_symb = 3;

  s = comm_rcosine_binary_mod(m, rolloff, code, n_symb);
  x =  comm_anexa_piloto(s, id_piloto, pot_piloto);

endfunction

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configura o canal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function r = channel(s, ch_model, ch_par)

  global v;

  [b, a] = selecionador_canal(ch_model, ch_par);
  r = filter(b, a, s);

endfunction

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configura o demodulador
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function bs = demodulador(r, code, id_piloto, eq_tipo, eq_N, eq_K)

  global v;

  n_symb = 3;

  r_sincronizado = comm_sincronizador_piloto(r, id_piloto);
  r_equalizado = comm_equalizador(r_sincronizado, eq_tipo, eq_N, eq_K);
  bs = comm_rcosine_binary_demod(r_equalizado, code, n_symb);

endfunction

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Variáveis da simulação
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global v;
Ts = 1/44100; % Período de amostragem
T = 1; % Tempo total da simulação
Tsym = 40*Ts; % Período de símbolo
debug = 0; % Determina se a simulação vai mostrar as infomrmações internas de algumas etapas.
v = set_fund_vars_digital(Ts, T, Tsym, debug);

fonte_fileName = 'data_sample/random_numbers_100.txt';
code = 'onoff';
rolloff = 0.5;
id_piloto = '50';
pot_piloto = 5;
ch_n_power = 0;
ch_model = 'lpf';
ch_par = [4, 250];
eq_tipo = 'mmse';
eq_N = 9; % Ordem do equalizador
eq_K = 11;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Transmissor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m = fonte_sinal(fonte_fileName, eq_N);
s = modulador(m, code, rolloff, id_piloto, pot_piloto);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Canal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = src_ch_noise(ch_n_power, length(s));
r = channel(s, ch_model, ch_par) + n;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Receptor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bs_demod = demodulador(r, code, id_piloto, eq_tipo, eq_N, eq_K);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Saída de Resultados e Gráficos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sk_timePlot({s, r}, {'s', 'r'}, {'c', 'c'});
taxa_erro_bit = comm_calcula_taxa_erro_bit(m, bs_demod);
