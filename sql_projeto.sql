CREATE TABLE tipo_projeto (
    seq_tipo_projeto serial,
    dsc_tipo_projeto varchar(50),
    PRIMARY KEY (seq_tipo_projeto)
);

CREATE TABLE situacao (
    seq_situacao serial,
    dsc_situacao varchar(50),
    PRIMARY KEY (seq_situacao)
);

CREATE TABLE projeto (
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
    PRIMARY KEY (seq_projeto),
    FOREIGN KEY (seq_tipo_projeto) REFERENCES tipo_projeto (seq_tipo_projeto) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (seq_situacao) REFERENCES situacao (seq_situacao) ON UPDATE RESTRICT ON DELETE RESTRICT
)

CREATE TABLE papel (
    seq_papel serial,
    dsc_papel varchar(50),
    PRIMARY KEY (seq_papel) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_pessoa_papel_projeto (
    seq_papel integer,
    seq_projeto integer,
    seq_pessoa integer,
    PRIMARY KEY (seq_papel, seq_projeto, seq_pessoa) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE tipo_financiamento (
    seq_tipo_fin serial,
    dsc_tipo_fin varchar(50),
    PRIMARY KEY (seq_tipo_fin) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_financiamento (
    seq_assoc_financiamento serial,
    seq_inst integer,
    seq_tipo_fin integer,
    seq_projeto integer,
    PRIMARY KEY (seq_assoc_financiamento, seq_inst, seq_tipo_fin, seq_projeto),
    FOREIGN KEY (seq_tipo_fin) REFERENCES tipo_financiamento (seq_tipo_fin) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (seq_projeto) REFERENCES projeto (seq_projeto) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (seq_inst) REFERENCES instituicao (seq_inst) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE edital (
    seq_edital serial,
    dsc_edital varchar(50)
    PRIMARY KEY (seq_edital)
);

CREATE TABLE moeda (
    seq_moeda serial,
    cod_moeda varchar(20),
    PRIMARY KEY (seq_moeda)
);

CREATE TABLE assoc_financiamento_edital (
    seq_assoc_financiamento integer,
    seq_edital integer,
    processo varchar(20)
    PRIMARY KEY (seq_assoc_financiamento, seq_edital),
    FOREIGN KEY (seq_assoc_financiamento) REFERENCES assoc_financiamento (seq_assoc_financiamento) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (seq_edital) REFERENCES edital (seq_edital) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_financiamento_moeda (
    seq_assoc_financiamento integer,
    seq_moeda integer,
    valor decimal,
    PRIMARY KEY (seq_assoc_financiamento)
);
