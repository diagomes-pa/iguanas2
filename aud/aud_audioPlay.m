function aud_audioPlay(m, Fs_aud_frac)
  % Fs_aud_frac: por��o da frequ�ncia de amostragem original que ser� usada, na reprodu��o.
  
  global v;
  
  sound(m, v.Fs_audio*Fs_aud_frac); 
  
endfunction