CREATE TABLE pessoa(
  nom_pessoa varchar(50),
  seq_pessoa serial,
  PRIMARY KEY (seq_pessoa)
);

CREATE TABLE formacao_complementar(
  seq_formacao_comp serial,
  carga_horaria integer,
  dsc_formacao_comp varchar(50),
  dat_inicio date,
  dat_fim date,
  seq_inst integer,
  PRIMARY KEY (seq_formacao_comp),
  FOREIGN KEY (seq_inst) REFERENCES instituicao (seq_inst) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CHECK carga_horaria >= 0
);

CREATE TABLE formacao(
  seq_formacao serial,
  dsc_formacao varchar(50),
  dat_inicio date,
  dat_fim date,
  seq_assoc_titulacao integer,
  seq_pessoa integer,
  seq_pesquisa integer,
  PRIMARY KEY (seq_formacao),
  FOREIGN KEY (seq_assoc_titulacao) REFERENCES assoc_titulacao_conceito (seq_assoc_titulacao) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_pessoa) REFERENCES pessoa (seq_pessoa) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_pesquisa) REFERENCES programa_pesquisa (seq_pesquisa) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE tipo(
  seq_tipo serial,
  dsc_tipo varchar(50),
  PRIMARY KEY (seq_tipo)
);

CREATE TABLE assoc_curso_instituicao(
  seq_assoc_curso serial,
  seq_curso integer,
  seq_inst integer,
  PRIMARY KEY (seq_assoc_curso,seq_curso,seq_inst),
  FOREIGN KEY (seq_curso) REFERENCES curso (seq_curso) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_inst) REFERENCES instituicao (seq_inst) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_periodo_sanduiche(
  seq_formacao integer,
  seq_inst integer,
  seq_pessoa integer,
  PRIMARY KEY (seq_formacao,seq_inst,seq_pessoa),
  FOREIGN KEY (seq_formacao) REFERENCES formacao (seq_formacao) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_inst) REFERENCES instituicao (seq_inst) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_pessoa) REFERENCES pessoa (seq_pessoa) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_titulacao_conceito(
  conceito integer,
  seq_assoc_titulacao serial,
  seq_tipo integer,
  seq_assoc_curso_instituicao integer,
  PRIMARY KEY (seq_assoc_titulacao,seq_tipo,seq_assoc_curso_instituicao),
  FOREIGN KEY (seq_tipo) REFERENCES tipo (seq_tipo) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_assoc_curso_instituicao) REFERENCES assoc_curso_instituicao (seq_assoc_curso) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE programa_pesquisa(
  seq_pesquisa serial,
  dsc_programa varchar(50),
  PRIMARY KEY (seq_pesquisa)
);

CREATE TABLE assoc_programa_pesquisa_formacao(
  seq_programa_pesquisa integer,
  seq_formacao integer,
  PRIMARY KEY (seq_programa_pesquisa,seq_formacao),
  FOREIGN KEY (seq_programa_pesquisa) REFERENCES programa_pesquisa (seq_pesquisa) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_formacao) REFERENCES formacao (seq_formacao) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE grande_area(
  seq_grande_area serial,
  dsc_grande_area varchar(50),
  PRIMARY KEY (seq_grande_area)
);

CREATE TABLE area(
  seq_area serial,
  dsc_area varchar(50),
  seq_grande_area integer,
  PRIMARY KEY (seq_area),
  FOREIGN KEY (seq_grande_area) REFERENCES grande_area (seq_grande_area) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE subarea(
  seq_subarea serial,
  dsc_subarea varchar(50),
  seq_area integer,
  PRIMARY KEY (seq_subarea),
  FOREIGN KEY (seq_area) REFERENCES area (seq_area) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE especialidade(
  seq_especialidade serial,
  dsc_especialidade varchar(50),
  seq_subarea integer,
  PRIMARY KEY (seq_especialidade),
  FOREIGN KEY (seq_subarea) REFERENCES subarea (seq_subarea) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_especialidade_formacao(
  seq_especialidade integer,
  seq_formacao integer,
  PRIMARY KEY (seq_especialidade,seq_formacao),
  FOREIGN KEY (seq_especialidade) REFERENCES especialidade (seq_especialidade) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_formacao) REFERENCES formacao (seq_formacao) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_subarea_formacao(
  seq_subarea integer,
  seq_formacao integer,
  PRIMARY KEY (seq_subarea,seq_formacao),
  FOREIGN KEY (seq_subarea) REFERENCES subarea (seq_subarea) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_formacao) REFERENCES formacao (seq_formacao) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_area_formacao(
  seq_area integer,
  seq_formacao integer,
  PRIMARY KEY (seq_area,seq_formacao),
  FOREIGN KEY (seq_area) REFERENCES area (seq_area) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_formacao) REFERENCES formacao (seq_formacao) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_grande_area_formacao(
  seq_grande_area integer,
  seq_formacao integer,
  PRIMARY KEY (seq_grande_area,seq_formacao),
  FOREIGN KEY (seq_grande_area) REFERENCES grande_areas (seq_grande_area) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_formacao) REFERENCES formacao (seq_formacao) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE palavra_chave(
  seq_palavra integer,
  dsc_palavra varchar(50),
  PRIMARY KEY (seq_palavra)
);

CREATE TABLE assoc_palavra_chave_formacao(
  seq_palavra_chave integer,
  seq_formacao integer,
  PRIMARY KEY (seq_palavra_chave,seq_formacao),
  FOREIGN KEY (seq_palavra_chave) REFERENCES palavra_chave (seq_palavra_chave) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_formacao) REFERENCES formacao (seq_formacao) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_formacao_curriculo(
  seq_curriculo integer,
  seq_formacao integer,
  PRIMARY KEY (seq_curriculo,seq_formacao),
  FOREIGN KEY (seq_curriculo) REFERENCES curriculo (id_lattes) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_formacao) REFERENCES formacao (seq_formacao) ON UPDATE RESTRICT ON DELETE RESTRICT
);