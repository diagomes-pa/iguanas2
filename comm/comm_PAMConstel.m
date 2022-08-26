function constel = comm_PAMConstel(b)
  # b: número de bits por símbolo.
  
  M = 2^b;
  
  constel = transpose(-(M-1) : 2 : (M-1)); # Constelação com energia média maior que 1.
  
  E_aver = sum(constel.^2)/M;
  constel = 1/sqrt(E_aver)*constel; # Faz com que a constelação tenha energia
                                    # média 1.
  
endfunction
