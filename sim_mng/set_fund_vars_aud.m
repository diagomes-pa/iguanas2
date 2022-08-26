function v = set_fund_vars_aud(Fs_aud, Ts, T, b_aud)
  # Configures the fundamental variables.
  % b_aud: número de bits por amostra no sinal de áudio.

   v.Fs_aud = Fs_aud;
   v.Ts_aud = 1/v.Fs_aud;
   v.Ts = Ts;
   v.Fs = 1/Ts;
   v.T = T;
   t_tmp = 0 : v.Ts : v.T - v.Ts;
   v.t = transpose(t_tmp); % Time axis
   v.b_aud = b_aud;

endfunction
