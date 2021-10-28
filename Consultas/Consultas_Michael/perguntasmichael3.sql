-- 3) Top 5 jogadores “azarados” com menor índice Plus-Minus

SELECT
jogos.temporada,
detalhes.jogador_nome,
detalhes.PLUS_MINUS AS Saldo
FROM
t8grupo1.detalhes_jogos AS detalhes
INNER JOIN
t8grupo1.jogos AS jogos ON detalhes.jogo_id = jogos.id
WHERE
jogos.temporada = '2019'
having Saldo !='null'
order by Saldo asc
LIMIT 10