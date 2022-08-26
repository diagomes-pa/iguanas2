function out = aud_audioNoise(P)

  global v;

  out = sqrt(P)*randn(v.Fs_audio*v.T, 1);


endfunction
