CREATE TABLE tipo_producao (
  seq_tipo_prod serial,
  dsc_tipo_prod varchar(50),
  PRIMARY KEY (seq_tipo_prod)
);

CREATE TABLE subtipo_producao (
  seq_subtipo_prod serial,
  dsc_tipo_prod varchar(50),
  seq_tipo_prod integer,
  PRIMARY KEY (seq_subtipo_prod),
  FOREIGN KEY (seq_tipo_prod) REFERENCES tipo_producao (seq_tipo_prod) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE categoria_producao (
  seq_categoria_prod serial,
  dsc_categoria_prod varchar,
  seq_subtipo_prod integer,
  PRIMARY KEY (seq_categoria_prod),
  FOREIGN KEY (seq_subtipo_prod) REFERENCES subtipo_producao (seq_subtipo_prod) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE producao (
  seq_producao serial,
  dat_producao date,
  dsc_producao varchar(50),
  seq_subtipo_prod integer,
  PRIMARY KEY (seq_producao),
  FOREIGN KEY (seq_subtipo_prod) REFERENCES subtipo_producao (seq_subtipo_prod) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_producao_autor (
  seq_producao integer,
  seq_autor integer,
  PRIMARY KEY (seq_producao, seq_autor),
  FOREIGN KEY (seq_producao) REFERENCES producao (seq_producao) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_autor) REFERENCES pessoa (seq_pessoa) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_producao_instituicao (
  seq_producao integer,
  seq_inst integer,
  PRIMARY KEY (seq_producao),
  FOREIGN KEY (seq_producao) REFERENCES producao (seq_producao) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_inst) REFERENCES instituicao (seq_inst) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_producao_categoria (
  seq_producao integer,
  seq_categoria_prod integer,
  PRIMARY KEY (seq_producao),
  FOREIGN KEY (seq_producao) REFERENCES producao(seq_producao) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_categoria_prod) REFERENCES categoria_producao (seq_categoria_prod) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE producao_bibliografica (
  seq_producao_bibliografica serial,
  dat_producao date,
  dsc_producao date,
  num_volume integer,
  pg_inicial integer,
  pg_final integer,
  num_edicao integer,
  seq_subtipo_prod integer,
  PRIMARY KEY (seq_producao_bibliografica),
  FOREIGN KEY (seq_subtipo_prod) REFERENCES subtipo_producao (seq_subtipo_prod) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_producao_bibliografica_autor (
  seq_producao_bibliografica integer,
  seq_autor integer,
  PRIMARY KEY (seq_producao, seq_autor),
  FOREIGN KEY (seq_producao_bibliografica) REFERENCES producao_bibliografica (seq_producao_bibliografica) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_autor) REFERENCES pessoa (seq_pessoa) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_producao_bibliografica_instituicao (
  seq_producao_bibliografica integer,
  seq_inst integer,
  PRIMARY KEY (seq_producao_bibliografica),
  FOREIGN KEY (seq_producao_bibliografica) REFERENCES producao_bibliografica (seq_producao_bibliografica) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_inst) REFERENCES instituicao (seq_inst) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_producao_bibliografica_categoria (
  seq_producao_bibliografica integer,
  seq_categoria_prod integer,
  PRIMARY KEY (seq_producao_bibliografica),
  FOREIGN KEY (seq_producao_bibliografica) REFERENCES producao_bibliografica (seq_producao_bibliografica) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_categoria_prod) REFERENCES categoria_producao (seq_categoria_prod) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE anais_congresso (
  seq_anais serial,
  dsc_anais varchar(50),
  seq_evento integer,
  PRIMARY KEY (seq_anais),
  FOREIGN KEY (seq_evento) REFERENCES evento (seq_evento) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE resumo(
  seq_resumo serial,
  dat_producao date,
  dsc_producao date,
  num_volume integer,
  pg_inicial integer,
  pg_final integer,
  num_edicao integer,
  seq_subtipo_prod integer,
  flg_resumo_expandido char,
  seq_anais integer,
  PRIMARY KEY (seq_resumo),
  FOREIGN KEY (seq_subtipo_prod) REFERENCES subtipo_producao (seq_subtipo_prod) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_anais) REFERENCES anais_congresso (seq_anais) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_resumo_autor (
  seq_resumo integer,
  seq_autor integer,
  PRIMARY KEY (seq_resumo, seq_autor),
  FOREIGN KEY (seq_resumo) REFERENCES resumo (seq_resumo) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_autor) REFERENCES pessoa (seq_pessoa) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_resumo_instituicao (
  seq_resumo integer,
  seq_inst integer,
  PRIMARY KEY (seq_resumo),
  FOREIGN KEY (seq_resumo) REFERENCES resumo (seq_resumo) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_inst) REFERENCES instituicao (seq_inst) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_resumo_categoria (
  seq_resumo integer,
  seq_categoria_prod integer,
  PRIMARY KEY (seq_resumo),
  FOREIGN KEY (seq_resumo) REFERENCES resumo (seq_resumo) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_categoria_prod) REFERENCES categoria_producao (seq_categoria_prod) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE trabalho_completo (
  seq_trabalho_completo serial,
  dat_producao date,
  dsc_producao date,
  num_volume integer,
  pg_inicial integer,
  pg_final integer,
  num_edicao integer,
  seq_subtipo_prod integer,
  flg_resumo_expandido char,
  seq_anais integer,
  PRIMARY KEY (seq_trabalho_completo),
  FOREIGN KEY (seq_subtipo_prod) REFERENCES subtipo_producao (seq_subtipo_prod) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_anais) REFERENCES anais_congresso (seq_anais) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_trabalho_completo_autor (
  seq_trabalho_completo integer,
  seq_autor integer,
  PRIMARY KEY (seq_trabalho_completo, seq_autor),
  FOREIGN KEY (seq_trabalho_completo) REFERENCES trabalho_completo (seq_trabalho_completo) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_autor) REFERENCES pessoa (seq_pessoa) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_trabalho_completo_instituicao (
  seq_trabalho_completo integer,
  seq_inst integer,
  PRIMARY KEY (seq_trabalho_completo),
  FOREIGN KEY (seq_trabalho_completo) REFERENCES trabalho_completo (seq_trabalho_completo) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_inst) REFERENCES instituicao (seq_inst) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_trabalho_completo_categoria (
  seq_trabalho_completo integer,
  seq_categoria_prod integer,
  PRIMARY KEY (seq_trabalho_completo),
  FOREIGN KEY (seq_trabalho_completo) REFERENCES trabalho_completo (seq_trabalho_completo) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_categoria_prod) REFERENCES categoria_producao (seq_categoria_prod) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE livro (
  seq_livro serial,
  dat_producao date,
  dsc_producao date,
  num_volume integer,
  pg_inicial integer,
  pg_final integer,
  num_edicao integer,
  seq_subtipo_prod integer,
  PRIMARY KEY (seq_livro),
  FOREIGN KEY (seq_subtipo_prod) REFERENCES subtipo_producao (seq_subtipo_prod) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_livro_autor (
  seq_livro integer,
  seq_autor integer,
  PRIMARY KEY (seq_livro, seq_autor),
  FOREIGN KEY (seq_livro) REFERENCES livro (seq_livro) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_autor) REFERENCES pessoa (seq_pessoa) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_livro_instituicao (
  seq_livro integer,
  seq_inst integer,
  PRIMARY KEY (seq_livro),
  FOREIGN KEY (seq_livro) REFERENCES livro (seq_livro) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_inst) REFERENCES instituicao (seq_inst) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_livro_categoria (
  seq_livro integer,
  seq_categoria_prod integer,
  PRIMARY KEY (seq_livro),
  FOREIGN KEY (seq_livro) REFERENCES livro (seq_livro) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_categoria_prod) REFERENCES categoria_producao (seq_categoria_prod) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE capitulo (
  seq_capitulo serial,
  dat_producao date,
  dsc_producao date,
  num_volume integer,
  pg_inicial integer,
  pg_final integer,
  num_edicao integer,
  seq_subtipo_prod integer,
  seq_livro integer,
  PRIMARY KEY (seq_capitulo),
  FOREIGN KEY (seq_subtipo_prod) REFERENCES subtipo_producao (seq_subtipo_prod) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_livro) REFERENCES livro (seq_livro) ON UPDATE RESTRICT ON DELETE RESTRICT,
);

CREATE TABLE assoc_capitulo_autor (
  seq_capitulo integer,
  seq_autor integer,
  PRIMARY KEY (seq_capitulo, seq_autor),
  FOREIGN KEY (seq_capitulo) REFERENCES capitulo (seq_capitulo) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_autor) REFERENCES pessoa (seq_pessoa) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_capitulo_instituicao (
  seq_capitulo integer,
  seq_inst integer,
  PRIMARY KEY (seq_capitulo),
  FOREIGN KEY (seq_capitulo) REFERENCES capitulo (seq_capitulo) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_inst) REFERENCES instituicao (seq_inst) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_capitulo_categoria (
  seq_capitulo integer,
  seq_categoria_prod integer,
  PRIMARY KEY (seq_capitulo),
  FOREIGN KEY (seq_capitulo) REFERENCES capitulo (seq_capitulo) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_categoria_prod) REFERENCES categoria_producao (seq_categoria_prod) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE revista (
  seq_revista serial,
  dsc_revista varchar(50),
  PRIMARY KEY (seq_revista)
);

CREATE TABLE publi_revista (
  seq_publi_revista serial,
  dat_producao date,
  dsc_producao date,
  num_volume integer,
  pg_inicial integer,
  pg_final integer,
  num_edicao integer,
  seq_subtipo_prod integer,
  seq_revista integer,
  PRIMARY KEY (seq_publi_revista),
  FOREIGN KEY (seq_subtipo_prod) REFERENCES subtipo_producao (seq_subtipo_prod) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_revista) REFERENCES revista (seq_revista) ON UPDATE RESTRICT ON DELETE RESTRICT,
);

CREATE TABLE assoc_publi_revista_autor (
  seq_publi_revista integer,
  seq_autor integer,
  PRIMARY KEY (seq_publi_revista, seq_autor),
  FOREIGN KEY (seq_publi_revista) REFERENCES publi_revista (seq_publi_revista) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_autor) REFERENCES pessoa (seq_pessoa) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_publi_revista_instituicao (
  seq_publi_revista integer,
  seq_inst integer,
  PRIMARY KEY (seq_publi_revista),
  FOREIGN KEY (seq_publi_revista) REFERENCES publi_revista (seq_publi_revista) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_inst) REFERENCES instituicao (seq_inst) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_publi_revista_categoria (
  seq_publi_revista integer,
  seq_categoria_prod integer,
  PRIMARY KEY (seq_publi_revista),
  FOREIGN KEY (seq_publi_revista) REFERENCES publi_revista (seq_publi_revista) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_categoria_prod) REFERENCES categoria_producao (seq_categoria_prod) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE indice (
  seq_indice serial,
  dsc_indice varchar(50)
  PRIMARY KEY (seq_indice)
);

CREATE TABLE publi_periodico (
  seq_publi_periodico serial,
  dat_producao date,
  dsc_producao date,
  num_volume integer,
  pg_inicial integer,
  pg_final integer,
  num_edicao integer,
  seq_subtipo_prod integer,
  seq_periodico integer,
  PRIMARY KEY (seq_publi_periodico),
  FOREIGN KEY (seq_subtipo_prod) REFERENCES subtipo_producao (seq_subtipo_prod) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_periodico) REFERENCES periodico (seq_periodico) ON UPDATE RESTRICT ON DELETE RESTRICT,
);

CREATE TABLE assoc_publi_periodico_autor (
  seq_publi_periodico integer,
  seq_autor integer,
  PRIMARY KEY (seq_publi_periodico, seq_autor),
  FOREIGN KEY (seq_publi_periodico) REFERENCES publi_periodico (seq_publi_periodico) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_autor) REFERENCES pessoa (seq_pessoa) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_publi_periodico_instituicao (
  seq_publi_periodico integer,
  seq_inst integer,
  PRIMARY KEY (seq_publi_periodico),
  FOREIGN KEY (seq_publi_periodico) REFERENCES publi_periodico (seq_publi_periodico) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_inst) REFERENCES instituicao (seq_inst) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_publi_periodico_categoria (
  seq_publi_periodico integer,
  seq_categoria_prod integer,
  PRIMARY KEY (seq_publi_periodico),
  FOREIGN KEY (seq_publi_periodico) REFERENCES publi_periodico (seq_publi_periodico) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_categoria_prod) REFERENCES categoria_producao (seq_categoria_prod) ON UPDATE RESTRICT ON DELETE RESTRICT
);