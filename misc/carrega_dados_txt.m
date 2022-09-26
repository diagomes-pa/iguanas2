function dados = carrega_dados_txt(file_name)
  % Carrega os dados contidos em arquivo .txt.
  % file_name: nome do arquivo com os dados que serão lidos.

  dados_ = load(file_name);
  campo = fieldnames(dados_);
  dados = getfield(dados_, campo{1});

endfunction
