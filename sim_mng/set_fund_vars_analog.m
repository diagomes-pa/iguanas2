function v = set_fund_vars_analog(Ts_, T_, debug)
  # Configures the fundamental variables.

   v.Ts = Ts_; % Time sampling
   v.Fs = 1/Ts_; % Frequency sampling
   v.F_Nyquist = v.Fs/2; % Frequ�ncia de Nyquist
   v.T = T_; % Simulation time
   t_tmp = 0 : Ts_ : T_ - Ts_;
   v.t = transpose(t_tmp); % Time axis
   v.N = length(v.t); % Number of samples
   v.debug = debug;

endfunction
