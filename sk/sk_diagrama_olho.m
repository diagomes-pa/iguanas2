function sk_diagrama_olho(sig, n_symbols, t_offset)
  % t_offset = offset de tempo, em amostras, para compensar o atraso do canal.

  global v;

  eyediagram(sig(t_offset:end), n_symbols*v.L);

  h=get(gcf, "currentaxes");
  set(h, "fontsize", 14);

  grid

end
