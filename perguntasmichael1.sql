-- 1) Top 5 jogadores que fizeram mais pontos na temporada 2019

SELECT
detalhes.jogador_nome, SUM(detalhes.PTS) AS soma_pontos
FROM
t8grupo1.detalhes_jogos AS detalhes
INNER JOIN
t8grupo1.jogos AS jogos ON detalhes.jogo_id = jogos.id
WHERE
jogos.temporada = '2019'
GROUP BY detalhes.jogador_nome
ORDER BY soma_pontos DESC
LIMIT 15

