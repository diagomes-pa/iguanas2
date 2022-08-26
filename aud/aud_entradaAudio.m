function aud = aud_entradaAudio()

  global v;

  aud_obj = audiorecorder(v.Fs_aud, v.b_aud, 1, 1)
  record(aud_obj, v.T)
  aud = getaudiodata(aud_obj)

endfunction
