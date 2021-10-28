-- 7) Top 10 Times com Maior Total de Pontos na Temporada 2019

SELECT 
    t.time_abrev, t.apelido, SUM(d.PTS) AS Soma_Pontos
FROM
    detalhes_jogos AS d
        INNER JOIN
    times t ON d.time_vencedor_id = t.id

GROUP BY t.time_abrev, t.apelido
ORDER BY Soma_Pontos DESC
limit 10

-- 8) Top 10 jogadores que mais fizeram cestas de 3 jogando em casa
SELECT
a.jogo_id,
a.time_vencedor_abrev,
a.time_vencedor_id,
a.jogador_nome,
a.FG3M,
a.Temporada
FROM
(SELECT
jogo_id,
detalhes.time_vencedor_abrev,
detalhes.time_vencedor_id,
detalhes.jogador_nome,
detalhes.FG3M,
CASE
WHEN jogos.temporada = '2016' THEN '2016 - 2017'
WHEN jogos.temporada = '2017' THEN '2017 - 2018'
WHEN jogos.temporada = '2018' THEN '2018 - 2019'
WHEN jogos.temporada = '2019' THEN '2019 - 2020'
END AS Temporada
FROM
t8grupo1.detalhes_jogos AS detalhes
INNER JOIN t8grupo1.jogos AS jogos ON detalhes.jogo_id = jogos.id) AS a
INNER JOIN
t8grupo1.jogos AS jogocasa ON jogocasa.id = a.jogo_id
WHERE
a.time_vencedor_id = jogocasa.time_casa_id
ORDER BY a.FG3M DESC
LIMIT 10

-- 9) Times com maiores derrotas nas últimas 3 temp

SELECT
ranking.time_nome AS Time_Nome,
MAX(num_derrotas) AS Número_Derrotas,
CASE
WHEN ranking.temporada_id = '12017' THEN '2017-2018'
WHEN ranking.temporada_id = '22017' THEN '2017-2018'
WHEN ranking.temporada_id = '12018' THEN '2018-2019'
WHEN ranking.temporada_id = '22018' THEN '2018-2019'
WHEN ranking.temporada_id = '12019' THEN '2019-2020'
WHEN ranking.temporada_id = '22019' THEN '2019-2020'
END AS Temporada
FROM
ranking
GROUP BY ranking.time_nome, ranking.temporada_id
ORDER BY MAX(num_derrotas) DESC
LIMIT 15