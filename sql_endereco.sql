CREATE TABLE pais(
  seq_pais serial,
  dsc_pais varchar(50),
  PRIMARY KEY (seq_pais)
);
  
CREATE TABLE estado(
  seq_estado serial,
  dsc_estado varchar(50),
  seq_pais integer,
  PRIMARY KEY (seq_estado),
  FOREIGN KEY (seq_pais) REFERENCES pais (seq_pais) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE cidade(
  seq_cidade serial,
  dsc_cidade varchar(50),
  seq_estado integer,
  PRIMARY KEY (seq_cidade),
  FOREIGN KEY (seq_estado) REFERENCES estado (seq_estado) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE bairro(
  seq_bairro serial,
  dsc_bairro varchar(50),
  seq_cidade integer,
  PRIMARY KEY (seq_bairro),
  FOREIGN KEY (seq_cidade) REFERENCES cidade (seq_cidade) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE tipo_logradouro(
  seq_tipo_logradouro serial,
  dsc_tipo_logradouro varchar(50),
  PRIMARY KEY (seq_tipo_logradouro)
);

CREATE TABLE logradouro(
  dsc_logradouro varchar(50),
  cep integer,
  seq_logradouro serial,
  seq_bairro integer,
  seq_tipo_logradouro integer,   
  PRIMARY KEY (seq_logradouro),
  FOREIGN KEY (seq_bairro) REFERENCES bairro (seq_bairro) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_tipo_logradouro) REFERENCES tipo_logradouro (seq_tipo_logradouro) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE instituicao(
  seq_inst serial,
  dsc_inst varchar(50),
  cod_inst integer,
  seq_logradouro integer,
  PRIMARY KEY (seq_inst),
  FOREIGN KEY (seq_logradouro) REFERENCES logradouro (seq_logradouro) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE departamento(
  seq_departamento serial,
  dsc_departamento varchar(50),
  cod_departamento integer,
  seq_inst integer,
  PRIMARY KEY (seq_departamento),
  FOREIGN KEY (seq_inst) REFERENCES instituicao (seq_instituicao) ON UPDATE RESTRICT ON DELETE RESTRICT
);
