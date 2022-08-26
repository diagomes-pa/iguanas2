function sk_animTimePlot(T_w, sig, tit, leg, time_gran)
  
  # time_gran: representa a granularidade do tempo, se é contínuo ou discreto. 
  # recebe um vetor que strings, c ou d, para sinais de tempo contínuo ou discreto,
  # respectivamente. Exemplo: para dois sinais, em que o o primeiro é contínuo e o
  # segundo discreto, deve-se fornecer o vetor ["c", "d"].
 
  global v;
  
  graphics_toolkit('gnuplot');
  
  n_sig = size(sig, 2);
  n_samp_wind = floor(T_w/v.Ts);
  n_wind = floor(v.N/n_samp_wind);
  
  w = 0;
  while(1)      
    w = w + 1;
    if(w > n_wind)
      w = 1;
    endif       
      
    for p = 1 : n_sig
      if(time_gran(p) == 'c')
        plot(v.t((w-1)*n_samp_wind + 1 : w*n_samp_wind), sig((w-1)*n_samp_wind + 1 : w*n_samp_wind , p), "LineWidth", 2);
      elseif(time_gran(p) == 'd')
        stem(v.t((w-1)*n_samp_wind + 1 : w*n_samp_wind), sig((w-1)*n_samp_wind + 1 : w*n_samp_wind , p), "LineWidth", 2);
      endif
      hold on;
    endfor
    hold off   
    
    y_range = max(max(sig)) - min(min(sig));     
    axis([v.t((w-1)*n_samp_wind + 1) v.t(w*n_samp_wind) (min(min(sig))-0.1*y_range) (max(max(sig))+0.1*y_range)])    
    xlabel("Tempo");
    h=get(gcf, "currentaxes");
    set(h, "fontsize", 14); 
    l = legend(leg);
    set(l, "fontsize", 14);
    grid;       
          
    pause(T_w);       
      
  endwhile
  
endfunction