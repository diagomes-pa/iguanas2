function test_sampling_signal()
  
  %% Configura as variÃ¡veis fundamentais
  global v;
  v = setFundVars(0.001, 1);
  
  staticSim(@runSim, 2)
 
end

function runSim(curr_val)
  
  global v;
  pkg load signal % Para usar a função decimate
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % CondiguraÃ§Ã£o de VariÃ¡veis
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  dec_factor = 4;  
  P = 1;
  f_cut = 300;
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% Processamento de sinal
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  s = src_filtNoise(P, f_cut);
  s_dec = decimate(s, dec_factor);
  t_dec = 0:v.Ts*dec_factor:v.T - v.Ts*dec_factor;
  s_interp = interp1(t_dec, s_dec, v.t);
  s_interp(isnan(s_interp))=0; % A última amostra estava NA. Talvez porque o método estaria fazendo extrapolação.
  
  S = abs(fft(s));  
  S_DEC = fft(s_dec, v.N);
  S_INTERP = fft(s_interp);
  
  sk_freqSubPlot({S, S_DEC, S_INTERP}, {"S", "S_DEC", "S_INTERP"}, 0);
  %sk_timePlot([s, s_interp], {"s", "s_interp"}, ["c", "c"]);
  
end