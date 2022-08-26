function [a, b] = digproc_lowPassFilter(M, f_cut)
% Implementa um filtro FIR com janela de Hamming.
% M: ordem do filtro.
% f_cut: frequência de corte

global v;

Fs = 1/v.Ts;

Omc = (2*pi*f_cut)/Fs; % Mapeia de frequência analógica para digital

b = zeros(v.N, 1);

for n = 1 : M
  b(n) = Omc/pi*(sinc(Omc/pi*(n-ceil(M/2))))*(0.54-0.46*cos(2*pi*n/M));
end

a = 1;

endfunction
