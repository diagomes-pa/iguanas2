# Simulação estática, em que a simulação executa uma vez e então para.

function staticSim(runSim, startVal)
  
  %% Configura as variáveis fundamentais
  global v;
  
  global fi;
  fi = figure();
  
  global disp;
  disp = 1;
  
  uicontrol(fi, "string", "Fechar", "callback", {@closePlot}, ...
           "position", [450 2 100 20]);
  
  runSim(startVal);  
 
end

function closePlot()
 
  global fi;
  close(fi);   
end