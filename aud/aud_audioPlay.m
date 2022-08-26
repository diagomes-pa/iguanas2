function aud_audioPlay(m, Fs_aud_frac)
  % Fs_aud_frac: porção da frequência de amostragem original que será usada, na reprodução.
  
  global v;
  
  sound(m, v.Fs_audio*Fs_aud_frac); 
  
endfunction