create table tipo_projeto (
    seq_tipo_projeto serial,
    dsc_tipo_projeto varchar(50),
    primary key (seq_tipo_projeto)
);

create table situacao (
    seq_situacao serial,
    dsc_situacao varchar(50),
    primary key (seq_situacao)
);

create table projeto (
    seq_projeto serial,
    dat_inicio date,
    dat_fim date,
    dsc_projeto varchar(50),
    num_envolvidos_grad integer,
    num_envolvidos_mest integer,
    num_envolvidos_dout integer,
    flg_inovacao boolean,
    nom_titulo varchar(20),
    num_orientacoes integer,
    num_producoes integer,
    seq_tipo_projeto integer,
    seq_situacao integer,
    primary key (seq_projeto),
    foreign key (seq_tipo_projeto) references tipo_projeto (seq_tipo_projeto),
    foreign key (seq_situacao) references situacao (seq_situacao)
)

create table papel (
    seq_papel serial,
    dsc_papel varchar(50),
    primary key (seq_papel)
);

create table assoc_pessoa_papel_projeto (
    seq_papel integer,
    seq_projeto integer,
    seq_pessoa integer,
    primary key (seq_papel, seq_projeto, seq_pessoa)
);

create table tipo_financiamento (
    seq_tipo_fin serial,
    dsc_tipo_fin varchar(50),
    primary key (seq_tipo_fin)
);

create table assoc_financiamento (
    seq_assoc_financiamento serial,
    seq_inst integer,
    seq_tipo_fin integer,
    seq_projeto integer,
    primary key (seq_assoc_financiamento, seq_inst, seq_tipo_fin, seq_projeto),
    foreign key (seq_tipo_fin) references tipo_financiamento (seq_tipo_fin),
    foreign key (seq_projeto) references projeto (seq_projeto),
    foreign key (seq_inst) references instituicao (seq_inst)
);

create table edital (
    seq_edital serial,
    dsc_edital varchar(50)
    primary key (seq_edital)
);

create table moeda (
    seq_moeda serial,
    cod_moeda varchar(20),
    primary key (seq_moeda)
);

create table assoc_financiamento_edital (
    seq_assoc_financiamento integer,
    seq_edital integer,
    processo varchar(20)
    primary key (seq_assoc_financiamento, seq_edital),
    foreign key (seq_assoc_financiamento) references assoc_financiamento (seq_assoc_financiamento),
    foreign key (seq_edital) references edital (seq_edital)
);

create table assoc_financiamento_moeda (
    seq_assoc_financiamento integer,
    seq_moeda integer,
    valor decimal,
    primary key (seq_assoc_financiamento, seq_moeda)
);
