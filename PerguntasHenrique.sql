-- Questão 10: Top 15 maiores percentuais de vitórias dos times por temporada 
SELECT
    ranking.time_nome AS Time_Nome,
    MAX(ranking.vitorias_PCT) AS 'Vitorias%',
    CASE
        WHEN ranking.temporada_id = '12017' THEN '2017'
        WHEN ranking.temporada_id = '22017' THEN '2017 - 2018'
        WHEN ranking.temporada_id = '12018' THEN '2018'
        WHEN ranking.temporada_id = '22018' THEN '2018 - 2019'
        WHEN ranking.temporada_id = '12019' THEN '2019'
        WHEN ranking.temporada_id = '22019' THEN '2019 - 2020'
    END AS Temporada
FROM
    t8grupo1.ranking AS Ranking
GROUP BY
    ranking.id
ORDER BY
    'Vitorias%' DESC
LIMIT
    5 
    
-- Questão 11: Top 7 treinadores com maior número de vitórias na temporada de 2019
SELECT
    t.treinador AS Treinador,
    r.time_nome as Nome_Time,
    MAX(num_vitorias) as Número_Vitórias
FROM
    times AS t
    INNER JOIN ranking AS r ON t.id = r.time_id
WHERE
    r.temporada_id = '22019'
    OR '12019'
GROUP BY
    t.treinador,
    r.time_nome
ORDER BY
    MAX(num_vitorias) DESC
LIMIT
    7