function v = set_fund_vars_aud_rt(Fs_aud, T, b_aud)
  # Configures the fundamental variables.
  % b_aud: número de bits por amostra no sinal de áudio.

   v.Fs_aud = Fs_aud;
   v.Ts_aud = 1/v.Fs_aud;
   v.T = T;
   t_tmp = 0 : v.Ts_aud : v.T - v.Ts_aud;
   v.t = transpose(t_tmp); % Time axis
   v.b_aud = b_aud;
   v.N = length(v.t);

endfunction
