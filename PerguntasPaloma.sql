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

Atividade