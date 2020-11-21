CREATE TABLE curriculo(
  id_lattes serial,
  id_orcid integer,
  txt_autor varchar(50),
  num_telefone integer,
  link_homepage varchar(50),
  PRIMARY KEY (id_lattes)
  );

CREATE TABLE instituicao(
  seq_inst serial,
  dsc_ins varchar(50),
  cod_inst integer,
  PRIMARY KEY (seq_inst)
  );

CREATE TABLE vinculo_instituicional(
  seq_vinculo serial,
  dsc_vinculo varchar(50),
  num_carga_horaria integer,
  dat_inicio date,
  dat_fim date,
  outras_informacoes varchar(50),
  seq_inst integer,
  id_lattes integer,
  PRIMARY KEY (seq_vinculo),
  FOREIGN KEY (seq_inst) REFERENCES instituicao (seq_inst) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (id_lattes) REFERENCES curriculo (id_lattes) ON UPDATE RESTRICT ON DELETE RESTRICT
  );

CREATE TABLE regime(
  seq_regime serial,
  dsc_regime varchar(50),
  PRIMARY KEY (seq_regime)
  );

CREATE TABLE assoc_regime_vinculo(
  seq_vinculo integer,
  seq_regime integer,
  PRIMARY KEY (seq_vinculo),
  FOREIGN KEY (seq_vinculo) REFERENCES vinculo_instituicional (seq_vinculo) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_regime) REFERENCES regime (seq_regime) ON UPDATE RESTRICT ON DELETE RESTRICT
  );

CREATE TABLE enquadramento(
  seq_enquadramento serial,
  dsc_enquadramento varchar(50),
  PRIMARY KEY (seq_enquadramento),
  );

CREATE TABLE assoc_enquadramento_vinculo(
  seq_vinculo integer,
  seq_enquadramento integer,
  PRIMARY KEY (seq_vinculo),
  FOREIGN KEY (seq_vinculo) REFERENCES vinculo_instituicional (seq_vinculo) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_enquadramento) REFERENCES enquadramento (seq_enquadramento) ON UPDATE RESTRICT ON DELETE RESTRICT
  );

CREATE TABLE pesquisa(
  dat_fim date,
  dat_inicio date,
  dsc_local varchar(50),
  seq_atividade_pesquisa serial,
  seq_inst integer,
  id_lattes integer,
  PRIMARY KEY (seq_atividade_pesquisa),
  FOREIGN KEY (seq_inst) REFERENCES instituicao (seq_inst) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (id_lattes) REFERENCES curriculo (id_lattes) ON UPDATE RESTRICT ON DELETE RESTRICT
  );

CREATE TABLE linha_pesquisa(
  seq_linha_pesquisa serial,
  dsc_linha_pesquisa varchar(50),
  PRIMARY KEY (seq_linha_pesquisa)
  );

CREATE TABLE assoc_pesquisa_linha_pesquisa(
  seq_atividade_pesquisa integer,
  seq_linha_pesquisa integer,
  PRIMARY KEY (seq_atividade_pesquisa,seq_linha_pesquisa),
  FOREIGN KEY (seq_atividade_pesquisa) REFERENCES pesquisa (seq_atividade_pesquisa) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_linha_pesquisa) REFERENCES linha_pesquisa (seq_linha_pesquisa) ON UPDATE RESTRICT ON DELETE RESTRICT
  );

CREATE TABLE curso(
  seq_curso serial,
  dsc_curso varchar(50),
  PRIMARY KEY (seq_curso)
  );

CREATE TABLE nivel_ensino(
  seq_nivel serial,
  dsc_nivel varchar(50),
  PRIMARY KEY (seq_nivel)
  );

CREATE TABLE ensino(
  dat_fim date,
  dat_inicio date,
  seq_atividade_ensino serial,
  seq_inst integer,
  id_lattes integer,
  seq_nivel_ensino integer,
  seq_curso integer,  
  PRIMARY KEY (seq_atividade_ensino),
  FOREIGN KEY (seq_inst) REFERENCES instituicao (seq_inst) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (id_lattes) REFERENCES curriculo (id_lattes) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_nivel_ensino) REFERENCES nivel_ensino (seq_nivel_ensino) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_curso) REFERENCES curso (seq_curso) ON UPDATE RESTRICT ON DELETE RESTRICT
  );

CREATE TABLE disciplina(
  seq_disciplina serial,
  dsc_disciplina varchar(50),
  cod_disciplina integer,
  PRIMARY KEY (seq_disciplina)
  );

CREATE TABLE assoc_disciplina_ensino(
  seq_atividade_ensino integer,
  seq_disciplina integer,
  PRIMARY KEY (seq_atividade_ensino,seq_disciplina),
  FOREIGN KEY (seq_atividade_ensino) REFERENCES ensino (seq_atividade_ensino) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_disciplina) REFERENCES disciplina (seq_disciplina) ON UPDATE RESTRICT ON DELETE RESTRICT
  );


CREATE TABLE administracao(
  dat_fim date,
  dat_inicio date,
  dsc_setor varchar(50),
  dsc_local varchar(50),
  seq_atividade_administracao serial,
  seq_inst integer,
  id_lattes integer,  
  PRIMARY KEY (seq_atividade_administracao),
  FOREIGN KEY (seq_inst) REFERENCES instituicao (seq_inst) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (id_lattes) REFERENCES curriculo (id_lattes) ON UPDATE RESTRICT ON DELETE RESTRICT
  );

CREATE TABLE cargo(
  seq_cargo serial,
  dsc_cargo varchar(50),
  PRIMARY KEY (seq_cargo)
  );

CREATE TABLE assoc_cargo_administracao(
  seq_atividade_administracao integer,
  seq_cargo integer,
  PRIMARY KEY (seq_atividade_administracao,seq_cargo),
  FOREIGN KEY (seq_atividade_administracao) REFERENCES administracao (seq_atividade_administracao) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_cargo) REFERENCES cargo (seq_cargo) ON UPDATE RESTRICT ON DELETE RESTRICT
  );

CREATE TABLE servico(
  seq_servico serial,
  dsc_servico varchar(50),
  PRIMARY KEY (seq_servico)
  );

CREATE TABLE servico_tecnico(
  dat_fim date,
  dat_inicio date,
  dsc_local varchar(50),
  flg_empresa_privada boolean,
  seq_atividade_servico serial,
  seq_inst integer,
  id_lattes integer,
  seq_servico integer,  
  PRIMARY KEY (seq_atividade_servico),
  FOREIGN KEY (seq_inst) REFERENCES instituicao (seq_inst) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (id_lattes) REFERENCES curriculo (id_lattes) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_servico) REFERENCES servico (seq_servico) ON UPDATE RESTRICT ON DELETE RESTRICT
  );