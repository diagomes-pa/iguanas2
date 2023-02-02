function aud = aud_audioRead(audio_file, T)

  global v;

  info = audioinfo(audio_file);
  [aud, Fs_audio] = audioread(audio_file, [1 info.SampleRate*T]);

  aud = aud(:,1);

  v.Fs_audio = Fs_audio;
  v.F_Nyquist = Fs_audio/2;
  v.N = length(aud);

endfunction
