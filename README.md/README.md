<h1 align= center>:basketball:Projeto_Modulo3:basketball:</h1>

<h4 align= center>Projeto realizado para fins educativos pela equipe: Fernando Agostini, Henrique Medeiros, João Michael Ferreira e Paloma Carvalho. O projeto consiste da representação visual de dados como forma de responder determinadas perguntas sobre o universo da NBA.</h4>

<p align='center'>
<img src="https://img.shields.io/static/v1?label=Status&message=UP&color=orange&style=for-the-badge&logo=ghost"/>
</p>

Sobre
-------------------

#### Projeto desenvolvido como requisito de finalização do módulo 3 do curso de Desenvolvimento FullStack da Resilia Educação! A proposta é a utilização de um banco de dados fornecido pela equipe facilitadora acerca de um determinado tema para a realização de consultas e geração de dashboards com os dados retornados. Foi escolhido pela equipe o banco de dados da NBA por possuir uma grande variedade de informações que possibilitasse a realização das consultas.

Consultas
-------------------

<h4 align= center>1: Top 15 jogadores com maiores pontuações na temporada de 2019.</h4>

```
SELECT
    detalhes.jogador_nome, 
    SUM(detalhes.PTS) AS soma_pontos
FROM
    t8grupo1.detalhes_jogos AS detalhes
INNER JOIN
    t8grupo1.jogos AS jogos ON detalhes.jogo_id = jogos.id
WHERE
    jogos.temporada = '2019'
GROUP BY 
    detalhes.jogador_nome
ORDER BY 
    soma_pontos DESC
LIMIT 
    15
```

<h4 align= center>2: Top 15 jogadores com maior quantidade de cestas de 3 na temporada de 2019.</h4>

```
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
GROUP BY 
    detalhes.jogador_nome
ORDER BY 
    soma_cestas3 DESC
LIMIT 
    15
```

<h4 align= center>3: Top 10 jogadores mais 'azarados' na temporada de 2019 - índice PLUS-MINUS.</h4>

```
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
HAVING 
    Saldo != 'null'
ORDER BY 
    Saldo ASC
LIMIT 
    10
```

<h4 align= center>4: Top 15 maiores pontuações jogando em casa na temporada de 2019.</h4>

```
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
GROUP BY 
    times.id, times.apelido 
ORDER BY
    SUM(jogos.PTS_casa) DESC
LIMIT 
    15
```

<h4 align= center>5: Top 15 maiores pontuações jogando fora de casa na temporada de 2019.</h4>

```
SELECT 
    times.id,
    times.apelido,
    times.time_abrev,
    jogos.temporada,
    SUM(jogos.PTS_visitante)
FROM
    t8grupo1.jogos AS jogos
INNER JOIN
    t8grupo1.times AS times ON times.id = jogos.time_visitante_id
WHERE
    jogos.temporada = '2019'
GROUP BY 
    times.id, times.apelido 
ORDER BY 
    SUM(jogos.PTS_visitante) DESC
LIMIT 
    15
```

<h4 align= center>6: Top 5 temporadas com maiores pontuações totais.</h4>

```
SELECT 
    jogos.temporada,
    SUM(jogos.PTS_casa) as Total_pontos_casa,
    SUM(jogos.PTS_visitante) as Total_pontos_Visitantes,
    SUM(jogos.PTS_visitante + jogos.PTS_casa) AS Total_pontos 
FROM
    t8grupo1.jogos AS jogos	
GROUP BY 
    jogos.temporada
ORDER BY
    SUM(jogos.PTS_casa + jogos.PTS_visitante) DESC
LIMIT 
    5
```

<h4 align= center>7: Top 10 times com maior total de pontos na temporada de 2019.</h4>

```
SELECT 
    t.time_abrev,
    t.apelido,
    SUM(d.PTS) AS Soma_Pontos
FROM
    detalhes_jogos AS d
INNER JOIN
    times t ON d.time_vencedor_id = t.id
GROUP BY 
    t.time_abrev, t.apelido
ORDER BY 
    Soma_Pontos DESC
LIMIT 
    10
```

<h4 align= center>8: Top 5 jogadores que mais fizeram cestas de 3 em um único jogo.</h4>

```
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
ORDER BY 
    a.FG3M DESC
LIMIT 
    10
```
