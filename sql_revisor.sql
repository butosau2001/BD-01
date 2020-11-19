create table agencia_de_fomento (
  seq_agencia serial,
  dsc_agencia varchar(50),
  primary key (seq_agencia)
);

create table periodico (
  seq_periodico serial,
  dsc_periodico varchar(50),
  primary key (seq_periodico)
);

create table revisor_periodico (
  seq_revisor_periodico serial,
  dat_inicio date,
  dat_fim date,
  seq_periodico integer,
  primary key (seq_revisor_periodico),
  foreign key (seq_periodico) references periodico (seq_periodico)
);

create table revisor_projeto_de_fomento (
  seq_revisor_fomento serial,
  dat_inicio date,
  dat_fim date,
  seq_agencia integer,
  primary key (seq_revisor_fomento),
  foreign key (seq_agencia) references agencia_de_fomento (seq_agencia)
);

create table assoc_curriculo_revisor_periodico (
  seq_revisor_periodico integer,
  id_lattes varchar(20),
  primary key (seq_revisor_periodico, id_lattes),
  foreign key (seq_revisor_periodico) references revisor_periodico (seq_revisor_periodico),
  foreign key (id_lattes) references curriculo (id_lattes)
);

create table assoc_curriculo_revisor_fomento (
  seq_revisor_fomento integer,
  id_lattes varchar(20),
  primary key (seq_revisor_fomento, id_lattes),
  foreign key (seq_revisor_fomento) references revisor_projeto_de_fomento (seq_revisor_fomento),
  foreign key (id_lattes) references curriculo (id_lattes)
)