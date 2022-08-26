function v = set_fund_vars_analog(Ts_, T_)
  # Configures the fundamental variables.

   v.Ts = Ts_; % Time sampling
   v.Fs = 1/Ts_; % Frequency sampling
   v.T = T_; % Simulation time
   t_tmp = 0 : Ts_ : T_ - Ts_;
   v.t = transpose(t_tmp); % Time axis
   v.N = length(v.t); % Number of samples

endfunction
