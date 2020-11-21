CREATE TABLE agencia_de_fomento (
  seq_agencia serial,
  dsc_agencia varchar(50),
  PRIMARY KEY (seq_agencia)
);

CREATE TABLE periodico (
  seq_periodico serial,
  dsc_periodico varchar(50),
  PRIMARY KEY (seq_periodico)
);

CREATE TABLE revisor_periodico (
  seq_revisor_periodico serial,
  dat_inicio date,
  dat_fim date,
  seq_periodico integer,
  PRIMARY KEY (seq_revisor_periodico),
  FOREIGN KEY (seq_periodico) REFERENCES periodico (seq_periodico) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE revisor_projeto_de_fomento (
  seq_revisor_fomento serial,
  dat_inicio date,
  dat_fim date,
  seq_agencia integer,
  PRIMARY KEY (seq_revisor_fomento),
  FOREIGN KEY (seq_agencia) REFERENCES agencia_de_fomento (seq_agencia) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_curriculo_revisor_periodico (
  seq_revisor_periodico integer,
  id_lattes biginteger,
  PRIMARY KEY (seq_revisor_periodico, id_lattes),
  FOREIGN KEY (seq_revisor_periodico) REFERENCES revisor_periodico (seq_revisor_periodico) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (id_lattes) REFERENCES curriculo (id_lattes) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_curriculo_revisor_fomento (
  seq_revisor_fomento integer,
  id_lattes biginteger,
  PRIMARY KEY (seq_revisor_fomento, id_lattes),
  FOREIGN KEY (seq_revisor_fomento) REFERENCES revisor_projeto_de_fomento (seq_revisor_fomento) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (id_lattes) REFERENCES curriculo (id_lattes) ON UPDATE RESTRICT ON DELETE RESTRICT
)