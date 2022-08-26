# Simulação dinâmica em que é possível mudar o valor das variáveis, em tempo
# de execução.

function dinamSim(runSim_, startVal, minMaxSlider)
  
  %% Configura as variáveis fundamentais
  global v;
  global runSim;
  runSim = runSim_;
  
  global fi;
  global slider;
  fi = figure();
  
  global disp;
  disp = 1;
  
  slider = uicontrol(fi,"style", "slider", ...
                    "callback", {@changeVarValue}, ...
                    'Min',minMaxSlider(1),'Max', minMaxSlider(2), ...
                    'value', startVal, ...
                    "position", [10 2 200 20]);
  
  uicontrol(fi, "string", "Fechar", "callback", {@closePlot}, ...
           "position", [450 2 100 20]);
  
  runSim(startVal);  
 
end

function changeVarValue()
  
  global v;
  global runSim;
  global disp;
  global slider;
    
  param = get(slider,'Value');
  feval(runSim, param);
  
end

function closePlot()
 
  global fi;
  close(fi);   
end