CREATE TABLE bolsaNP (
  seq_bolsa serial,
  vlr_bolsa decimal,
  dsc_bolsa varchar(50),
  PRIMARY KEY (seq_bolsa),
  CHECK vlr_bolsa >= 0
);

CREATE TABLE assoc_bolsa_curriculo (
  id_lattes biginteger,
  seq_bolsa integer,
  PRIMARY KEY (id_lattes),
  FOREIGN KEY (id_lattes) REFERENCES curriculo (id_lattes) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_bolsa) REFERENCES bolsaNP (seq_bolsa) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE premio (
  seq_premio integer,
  dsc_premio varchar(50),
  ano_premio integer,
  PRIMARY KEY (seq_premio),
  CHECK ano_premio > 1900
);

CREATE TABLE assoc_premio_curriculo (
  seq_premio integer,
  id_lattes biginteger,
  PRIMARY KEY (seq_premio, id_lattes),
  FOREIGN KEY (seq_premio) REFERENCES premio (seq_premio) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (id_lattes) REFERENCES curriculo (id_lattes) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE nome_em_citacoes (
  seq_citacao serial,
  dsc_citacao varchar(50),
  seq_pessoa integer,
  PRIMARY KEY (seq_citacao),
  FOREIGN KEY (seq_pessoa) REFERENCES pessoa (seq_pessoa) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE evento (
  seq_evento serial,
  dsc_evento varchar(50),
  dat_evento date,
  PRIMARY KEY (seq_evento)
);

CREATE TABLE assoc_organizacao_evento (
  seq_pessoa integer,
  seq_evento integer,
  PRIMARY KEY (seq_pessoa, seq_evento),
  FOREIGN KEY (seq_pessoa) REFERENCES pessoa (seq_pessoa) ON UPDATE RESTRICT ON DELETE RESTRICT
  FOREIGN KEY (seq_evento) REFERENCES evento (seq_evento) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_participacao_evento (
  seq_pessoa integer,
  seq_evento integer,
  titulo_trabalho varchar(50),
  PRIMARY KEY (seq_pessoa, seq_evento),
  FOREIGN KEY (seq_pessoa) REFERENCES pessoa (seq_pessoa) ON UPDATE RESTRICT ON DELETE RESTRICT
  FOREIGN KEY (seq_evento) REFERENCES evento (seq_evento) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE idioma (
  seq_idioma serial
  dsc_idioma varchar(50),
  PRIMARY KEY (seq_idioma)
);

CREATE TABLE nivel (
  seq_nivel serial,
  dsc_nivel varchar(50),
  PRIMARY KEY (seq_nivel)
);

CREATE TABLE assoc_idioma_curriculo (
  seq_assoc_idioma_curriculo serial,
  id_lattes biginteger,
  seq_idioma integer,
  PRIMARY KEY (seq_assoc_idioma_nivel, id_lattes, seq_idioma),
  FOREIGN KEY (id_lattes) REFERENCES curriculo (id_lattes) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_idioma) REFERENCES idioma (seq_idioma) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_fala_idioma_nivel (
  seq_assoc_idioma_curriculo integer, 
  seq_nivel integer,
  PRIMARY KEY (seq_assoc_idioma_curriculo)
  FOREIGN KEY (seq_assoc_idioma_curriculo) REFERENCES assoc_idioma_curriculo (seq_assoc_idioma_curriculo) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_nivel) REFERENCES nivel (seq_nivel) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_leitura_idioma_nivel(  
  seq_assoc_idioma_curriculo integer, 
  seq_nivel integer,
  PRIMARY KEY (seq_assoc_idioma_curriculo)
  FOREIGN KEY (seq_assoc_idioma_curriculo) REFERENCES assoc_idioma_curriculo (seq_assoc_idioma_curriculo) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_nivel) REFERENCES nivel (seq_nivel) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_compreensao_idioma_nivel(  
  seq_assoc_idioma_curriculo integer, 
  seq_nivel integer,
  PRIMARY KEY (seq_assoc_idioma_curriculo)
  FOREIGN KEY (seq_assoc_idioma_curriculo) REFERENCES assoc_idioma_curriculo (seq_assoc_idioma_curriculo) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_nivel) REFERENCES nivel (seq_nivel) ON UPDATE RESTRICT ON DELETE RESTRICT
);