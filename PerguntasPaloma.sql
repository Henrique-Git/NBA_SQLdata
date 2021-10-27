-- 7) Top 7 de jogos com maiores pontuações nas temp > 2018

SELECT
jogos.id AS id,
jogos.data AS data_jogo,
timesA.apelido AS Time_Casa,
timesB.apelido AS Time_visitante,
SUM(jogos.PTS_casa + jogos.PTS_visitante) AS Total,
CASE
WHEN jogos.temporada = '2018' THEN '2018 - 2019'
WHEN jogos.temporada = '2019' THEN '2019 - 2020'
END AS Temporada
FROM
t8grupo1.jogos AS jogos
INNER JOIN
t8grupo1.times AS timesA ON timesA.id = jogos.time_casa_id
INNER JOIN
t8grupo1.times AS timesB ON timesB.id = jogos.time_visitante_id
WHERE
jogos.temporada > 2018
GROUP BY id
ORDER BY Total DESC
LIMIT 7

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

