-- Selecionar todas as linhas de pesquisa associadas a um curriculo

select LP.dsc_linha_pesquisa from linha_pesquisa LP, pesquisa P 
where LP.seq_linha_pesquisa = P.seq_linha_pesquisa and P.id_lattes = 1

-- π dsc_linha_pesquisa (σ id_lattes = 1 (pesquisa) ⋈ linha_pesquisa)

-- Selecionar a soma de citações de publicações em periódicos separados pelos indices

select I.dsc_indice, SUM(APPIC.citacoes) from
indice I,
assoc_publi_periodico_indice_citacoes APPIC, 
publi_periodico PP, 
assoc_publi_periodico_autor APPA, 
pessoa P
where 
I.seq_indice = APPIC.seq_indice and
APPIC.seq_publi_periodico = PP.seq_publi_periodico and 
APPA.seq_publi_periodico = PP.seq_publi_periodico and 
APPA.seq_pessoa = P.seq_pessoa and 
P.nom_pessoa like 'Bruno'
group by I.dsc_indice

-- S <- σ nom_pessoa = 'Bruno' (publi_periodico ⋈ assoc_publi_periodico_autor ⋈ pessoa)
-- R <- indice ⋈ assoc_publi_periodico_indice_citacoes ⋈ S
-- π dsc_indice, SUM(citacoes) (R)


--selecionar a descricao de todos os departamentos e mostrar a descricao das instituicoes desses departamentos
-- essa consulta serve para saber o nome dos departamentos e em quais instituições eles estão

select dep.dsc_departamento, inst.dsc_inst from instituicao inst, departamento dep where dep.seq_inst = inst.seq_inst
--π dep.dsc_departamento, dsc_inst (departamento ⋈ instituicao)

--selecionar o número de formações com grande área em Ciências Exatas e da Terra.
-- essa consulta serve para saber a quantidade de formações na área de Ciências Exatas e da Terra.

SELECT count(fo.seq_formacao) FROM formacao fo, assoc_grande_area_formacao agaf , grande_area  ga WHERE fo.seq_formacao=agaf.seq_formacao AND agaf.seq_grande_area=ga.seq_grande_area and ga.dsc_grande_area LIKE "Ciências Exatas e da Terra"
--R <- σ dsc_grande_area = "Ciências Exatas e da Terra" (grande_area)
--π count(seq_formacao) (R ⋈ assoc_grande_area_formacao ⋈ formacao)
