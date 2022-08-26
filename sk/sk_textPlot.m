function sk_textPlot(tgt_text)
  
  global v;
  global fi;
    
  text(0.1, 0.5, tgt_text, ...
       "horizontalalignment", "center", ...
       "verticalalignment", "middle",...
       'fontsize', 16);  
  drawnow;  
  
end