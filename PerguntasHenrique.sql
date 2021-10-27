
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