function out = wlan_RSSI(so, ta, N, dev)
  
  global v;
 
  out = zeros(N, 1);
  
  if(strcmp(so, 'Ubuntu') == 1)
  
    for n = 1 : N
      command = ['iw dev ' dev ' link | grep signal > rssi_tmp.txt'];
      system(command);
      x = textread('rssi_tmp.txt', '%s');
      out(n) = str2num(x{2});
      pause(ta);
    endfor
    
    system('rm rssi_tmp.txt');
    
  elseif(strcmp(so, 'Windows') == 1)
  
    for n = 1 : N
      command = 'netsh wlan show interface | findstr Sinal > rssi_tmp.txt';
      system(command);
      x = textread('rssi_tmp.txt', '%s');
      out_tmp = x{3};
      out(n) = str2num(out_tmp(1:end-1));
      out(n) = (out(n)/2) - 100;
      pause(ta);
    endfor
    
    system('rm rssi_tmp.txt');
    
  else
    
    printf('SO não disponível');
    
  endif
    
endfunction