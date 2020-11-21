CREATE TABLE tipo_banca(
  seq_tipo_banca serial,
  dsc_tipo_banca varchar(50), 
  PRIMARY KEY (seq_tipo_banca),
  );

CREATE TABLE tipo_trabalho(
  seq_tipo_trabalho serial,
  dsc_tipo_trabalho varchar(50), 
  PRIMARY KEY (seq_tipo_trabalho),
  );

CREATE TABLE banca_trabalho(
  seq_banca_trabalho serial,
  dat_inicio date,
  dat_banca date,
  seq_tipo_banca integer,
  seq_dono_banca integer,
  seq_orientador integer,
  seq_tipo_trabalho integer,
  seq_situacao integer,
  seq_assoc_titulacao integer, 
  PRIMARY KEY (seq_banca_trabalho),
  FOREIGN KEY (seq_tipo_banca) REFERENCES tipo_banca (seq_tipo_banca) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_dono_banca) REFERENCES pessoa (seq_pessoa) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_orientador) REFERENCES pessoa (seq_pessoa) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_tipo_trabalho) REFERENCES tipo_trabalho (seq_tipo_trabalho) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_situacao) REFERENCES situacao (seq_situacao) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_assoc_titulacao) REFERENCES assoc_titulacao_conceito (seq_assoc_titulacao) ON UPDATE RESTRICT ON DELETE RESTRICT
  );

CREATE TABLE banca_julgadora(
  seq_banca_julgadora serial,
  dat_banca date,
  dsc_banca_julgadora varchar(50),
  seq_tipo_banca integer,
  seq_inst integer,
  PRIMARY KEY (seq_banca_julgadora),
  FOREIGN KEY (seq_tipo_banca) REFERENCES tipo_banca (seq_tipo_banca) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_inst) REFERENCES instituicao (seq_inst) ON UPDATE RESTRICT ON DELETE RESTRICT
  );


CREATE TABLE assoc_participante_banca_trabalho(
  seq_pessoa integer,
  seq_banca_trabalho integer,
  PRIMARY KEY (seq_pessoa,seq_banca_trabalho),
  FOREIGN KEY (seq_pessoa) REFERENCES pessoa (seq_pessoa) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_banca_trabalho) REFERENCES banca_trabalho (seq_banca_trabalho) ON UPDATE RESTRICT ON DELETE RESTRICT
  );

CREATE TABLE assoc_participante_banca_julgadora(
  seq_pessoa integer,
  seq_banca_julgadora integer,
  PRIMARY KEY (seq_pessoa,seq_banca_trabalho),
  FOREIGN KEY (seq_pessoa) REFERENCES pessoa (seq_pessoa) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_banca_julgadora) REFERENCES banca_julgadora (seq_banca_julgadora) ON UPDATE RESTRICT ON DELETE RESTRICT
  );

CREATE TABLE assoc_autor_trabalho(
  seq_banca_trabalho integer,
  seq_autor integer,
  PRIMARY KEY (seq_banca_trabalho,seq_autor),
  FOREIGN KEY (seq_autor) REFERENCES pessoa (seq_pessoa) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_banca_trabalho) REFERENCES banca_trabalho (seq_banca_trabalho) ON UPDATE RESTRICT ON DELETE RESTRICT
  );

CREATE TABLE assoc_coorientador_trabalho(
  seq_banca_trabalho integer,
  seq_coorientador integer,
  PRIMARY KEY (seq_banca_trabalho,seq_coorientador),
  FOREIGN KEY (seq_coorientador) REFERENCES pessoa (seq_pessoa) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_banca_trabalho) REFERENCES banca_trabalho (seq_banca_trabalho) ON UPDATE RESTRICT ON DELETE RESTRICT
  );