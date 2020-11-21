-- sql_atuacao

CREATE TABLE curriculo(
  id_lattes bigserial,
  id_orcid integer,
  txt_autor varchar(500),
  num_telefone varchar(20),
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
  id_lattes biginteger,
  PRIMARY KEY (seq_vinculo),
  FOREIGN KEY (seq_inst) REFERENCES instituicao (seq_inst) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (id_lattes) REFERENCES curriculo (id_lattes) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CHECK num_carga_horaria >= 0
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
  id_lattes biginteger,
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
  seq_atividade_ensino serial,
  dat_inicio date,
  dat_fim date,
  seq_inst integer,
  id_lattes biginteger,
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
  seq_atividade_administracao serial,
  dat_inicio date,
  dat_fim date,
  dsc_setor varchar(50),
  dsc_local varchar(50),
  seq_inst integer,
  id_lattes biginteger,  
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
  id_lattes biginteger,
  seq_servico integer,  
  PRIMARY KEY (seq_atividade_servico),
  FOREIGN KEY (seq_inst) REFERENCES instituicao (seq_inst) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (id_lattes) REFERENCES curriculo (id_lattes) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_servico) REFERENCES servico (seq_servico) ON UPDATE RESTRICT ON DELETE RESTRICT
  );

-- sql_banca

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

-- sql_endereco

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

-- sql_formacao

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

-- sql_principal

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

-- sql_revisor

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

-- sql_producao

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
  FOREIGN KEY (seq_subtipo_prod) REFERENCES subtipo_producao (seq_subtipo_prod) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CHECK num_volume > 0,
  CHECK pg_inicial <= pg_final,
  CHECK num_edicao > 0
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
  FOREIGN KEY (seq_anais) REFERENCES anais_congresso (seq_anais) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CHECK num_volume > 0,
  CHECK pg_inicial <= pg_final,
  CHECK num_edicao > 0
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
  FOREIGN KEY (seq_anais) REFERENCES anais_congresso (seq_anais) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CHECK num_volume > 0,
  CHECK pg_inicial <= pg_final,
  CHECK num_edicao > 0
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
  FOREIGN KEY (seq_subtipo_prod) REFERENCES subtipo_producao (seq_subtipo_prod) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CHECK num_volume > 0,
  CHECK pg_inicial <= pg_final,
  CHECK num_edicao > 0
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
  CHECK num_volume > 0,
  CHECK pg_inicial <= pg_final,
  CHECK num_edicao > 0
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
  CHECK num_volume > 0,
  CHECK pg_inicial <= pg_final,
  CHECK num_edicao > 0
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
  CHECK num_volume > 0,
  CHECK pg_inicial <= pg_final,
  CHECK num_edicao > 0
);

CREATE TABLE assoc_publi_periodico_indice_citacoes (
  seq_periodico integer,
  seq_publi_periodico integer,
  num_citacoes integer,
  PRIMARY KEY (seq_periodico, seq_publi_periodico),
  FOREIGN KEY (seq_periodico) REFERENCES periodico (seq_periodico) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_publi_periodico) REFERENCES publi_periodico (seq_publi_periodico) ON UPDATE RESTRICT ON DELETE RESTRICT
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

-- sql_projeto

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
  FOREIGN KEY (seq_situacao) REFERENCES situacao (seq_situacao) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CHECK num_envolvidos_grad >= 0,
  CHECK num_envolvidos_mest >= 0,
  CHECK num_envolvidos_dout >= 0,
  CHECK num_orientacoes >= 0,
  CHECK num_producoes >= 0,
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
  dsc_edital varchar(50),
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
  processo varchar(20),
  PRIMARY KEY (seq_assoc_financiamento, seq_edital),
  FOREIGN KEY (seq_assoc_financiamento) REFERENCES assoc_financiamento (seq_assoc_financiamento) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (seq_edital) REFERENCES edital (seq_edital) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE assoc_financiamento_moeda (
  seq_assoc_financiamento integer,
  seq_moeda integer,
  valor decimal,
  PRIMARY KEY (seq_assoc_financiamento),
  CHECK valor > 0
);

