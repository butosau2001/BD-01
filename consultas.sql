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