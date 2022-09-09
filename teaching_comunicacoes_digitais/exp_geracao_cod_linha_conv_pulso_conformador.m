%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Experimento avulso.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
close
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Funções de apoio
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function x = map_bit_real(bs, ak, code)

  global v;

  Nsym = length(bs);
  x = zeros(Nsym*int64(v.L), 1);

  if(strcmp(code, 'bipolar'))

    last_one = -1;
    for k = 1 : Nsym
      if(bs(k) == '0')
        x((k-1)*int64(v.L) + 1) = 0;
      else
        x((k-1)*int64(v.L) + 1) = -last_one;
        last_one = -last_one;
      endif
    endfor

  else

    for k = 1 : Nsym
      if(bs(k) == '0')
        x((k-1)*int64(v.L) + 1) = ak(1);
      else
        x((k-1)*int64(v.L) + 1) = ak(2);
      endif
    endfor

  endif

endfunction


function pulse_shape = nrz_pulse_shape()

  global v;

  pulse_shape = ones(int64(v.L), 1);

endfunction


function pulse_shape = rz_pulse_shape()

  global v;

  pulse_shape = [ones(floor(int64(v.L)/2), 1); zeros(ceil(int64(v.L)/2), 1)];

endfunction

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Variáveis da simulação
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global v;

Ts = 0.0001; % Período de amostragem
T = 0.2; % Tempo total da simulação
Tsym = 0.01; % Período de símbolo
v = set_fund_vars_digital(Ts, T, Tsym);

cod_linha = 'rz-polar';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Implementação do experimento
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bs = txtFile_num_to_bs('data_sample/random_numbers_2.txt', 8, 'natural');

s = zeros(v.N, 1);

cod_type_split = strsplit(cod_linha, '-');

switch cod_type_split{1}
  case 'nrz'
    pulse_shape = nrz_pulse_shape();
  case 'rz'
    pulse_shape = rz_pulse_shape();
endswitch

switch cod_type_split{2}
  case 'onoff'
    ak = [0, 1];
  case 'polar'
    ak = [-1, 1];
  case 'bipolar'
    ak = [];
endswitch

x = map_bit_real(bs, ak, cod_type_split{2});
s_ = conv(x, pulse_shape);
s(1:length(s_)) = s_;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Saída de Resultados e Gráficos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sk_timePlot({s, bs}, {'s', 'bs'}, {'c', 't'});
