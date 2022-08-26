function [b, a] = ch_twisted_pair(d)
  % Modelo de canal de par trançado, baseado em https://www.eit.lth.se/fileadmin/eit/courses/eit140/ofdm_channels.pdf
  % Permite a geração de uma resposta ao impulso de um canal de acordo com o
  % comprimento do cabo.


  global v;

  d0 = 1000;
  % Parâmetros de k para um cabo com fios de diâmetro 0,5 mm.
  k1 = 3.8*10e-3;
  k2 = -0.541*10e-8;
  k3 = 4.883*10e-5;

  H = zeros(round(10*v.L),1);
  f = transpose(linspace(0, v.Fs/2, ceil(length(H)/2)+1));

  if(mod(length(H),2) == 0)
    H_right = exp(-(d/d0)*(k1*sqrt(f) + k2*f)).*exp(-i*(d/d0)*k3*f);
    H_left = flipud(conj(H_right(2:end-1)));
    H = [H_right; H_left];
    h = real(ifft(H));
  else
    H_right = exp(-(d/d0)*(k1*sqrt(f) + k2*f)).*exp(-i*(d/d0)*k3*f);
    H_left = flipud(conj(H_right(2:end)));
    H = [H_right; H_left];
    h = real(ifft(H));
  endif

  b = h(1:ceil(length(h)/2));

  a = 1;

endfunction
