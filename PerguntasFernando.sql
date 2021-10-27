--  05 Top 15 Maiores Pontuações Jogando Fora de Casa (2019)

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
LIMIT 15;

--  06 top 5 Temporadas com Maiores Pontuações

SELECT 
    jogos.temporada,
    SUM(jogos.PTS_casa) as Total_pontos_casa,
    SUM(jogos.PTS_visitante) as Total_pontos_Visitantes,
    SUM(jogos.PTS_visitante + jogos.PTS_casa) as Total_pontos 
FROM
    t8grupo1.jogos AS jogos	

    group by jogos.temporada order by sum(jogos.PTS_casa + jogos.PTS_visitante) desc
LIMIT 5;

--- 04 Top 15 Maiores Pontuações Jogando em Casa (2019)

SELECT 
    times.id,
    times.apelido,
    times.time_abrev,
    jogos.temporada,
    SUM(jogos.PTS_casa)
FROM
    t8grupo1.jogos AS jogos
        INNER JOIN
    t8grupo1.times AS times ON times.id = jogos.time_casa_id
WHERE
    jogos.temporada = '2019'
    group by times.id, times.apelido order by sum(jogos.PTS_casa) desc
LIMIT 15