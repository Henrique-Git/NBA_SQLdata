-- 2) Top 5 jogadores com mais cestas de 3

SELECT
jogos.temporada,
detalhes.jogador_nome,
SUM(detalhes.FG3M) AS soma_cestas3
FROM
t8grupo1.detalhes_jogos AS detalhes
INNER JOIN
t8grupo1.jogos AS jogos ON detalhes.jogo_id = jogos.id
WHERE
jogos.temporada = '2019'
GROUP BY detalhes.jogador_nome
ORDER BY soma_cestas3 DESC
LIMIT 15