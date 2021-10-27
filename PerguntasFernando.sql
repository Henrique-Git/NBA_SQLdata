-- Top 15 Maiores Pontuações Jogando Fora de Casa (2019)

SELECT 
    times.id,
    times.apelido,
    times.time_abrev,
    jogos.temporada,
    sum(jogos.PTS_visitante)
FROM
    t8grupo1.jogos AS jogos
        INNER JOIN
    t8grupo1.times AS times ON times.id = jogos.time_visitante_id
WHERE
    jogos.temporada = '2019'
    group by times.id, times.apelido order by sum(jogos.PTS_visitante) desc
LIMIT 15