function v = set_fund_vars_digital(Ts_, T_, Tsym_)
  # Configures the fundamental variables.

   v.Ts = Ts_; % Time sampling
   v.Fs = 1/Ts_; % Frequency sampling
   v.F_Nyquist = v.Fs/2; % Frequ�ncia de Nyquist
   v.T = T_; % Simulation time
   t_tmp = 0 : Ts_ : T_ - Ts_;
   v.t = transpose(t_tmp); % Time axis
   v.N = length(v.t); % Number of samples
   v.Tsym = Tsym_; % Per�odo de s�mbolo
   v.Rsym = 1/Tsym_; % Taxa de s�mbolos
   v.L = Tsym_/Ts_; % N�mero de amostras por s�mbolo.

endfunction
