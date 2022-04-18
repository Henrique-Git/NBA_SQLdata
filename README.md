<h1 align= center>:basketball:NBA_SQLdata:basketball:</h1>

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

![screenshot](https://github.com/Henrique-Git/Projeto_Modulo3/blob/main/Gr%C3%A1ficos/Question%201.png)

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

![screenshot](https://github.com/Henrique-Git/Projeto_Modulo3/blob/main/Gr%C3%A1ficos/Question%202.png)

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

![screenshot](https://github.com/Henrique-Git/Projeto_Modulo3/blob/main/Gr%C3%A1ficos/Question%203.png)

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

![screenshot](https://github.com/Henrique-Git/Projeto_Modulo3/blob/main/Gr%C3%A1ficos/Question%204.png)

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

![screenshot](https://github.com/Henrique-Git/Projeto_Modulo3/blob/main/Gr%C3%A1ficos/Question%205.png)

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

![screenshot](https://github.com/Henrique-Git/Projeto_Modulo3/blob/main/Gr%C3%A1ficos/Question%206_Total.png)
![screenshot](https://github.com/Henrique-Git/Projeto_Modulo3/blob/main/Gr%C3%A1ficos/Question%206_Detalhes.png)

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

![screenshot](https://github.com/Henrique-Git/Projeto_Modulo3/blob/main/Gr%C3%A1ficos/Question%207.png)

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

![screenshot](https://github.com/Henrique-Git/Projeto_Modulo3/blob/main/Gr%C3%A1ficos/Question%208.png)

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

<h4 align= center>9: Times com maior número de derrotas nas últimas 3 temporadas.</h4>

![screenshot](https://github.com/Henrique-Git/Projeto_Modulo3/blob/main/Gr%C3%A1ficos/Question%209.png)

```
SELECT
    ranking.time_nome AS Time_Nome,
    MAX(num_derrotas) AS Número_Derrotas,
CASE
    WHEN ranking.temporada_id = '12017' THEN '2017-2018'
    WHEN ranking.temporada_id = '22017' THEN '2017-2018'
    WHEN ranking.temporada_id = '12018' THEN '2018-2019'
    WHEN ranking.temporada_id = '22018' THEN '2018-2019'
    WHEN ranking.temporada_id = '12019' THEN '2019-2020'
    WHEN ranking.temporada_id = '22019' THEN '2019-2020'
END AS Temporada
FROM
    ranking
GROUP BY 
    ranking.time_nome,
    ranking.temporada_id
ORDER BY 
    MAX(num_derrotas) DESC
LIMIT 
    15
```

<h4 align= center>10: Top 15 maiores percentuais de vitórias dos times por temporada.</h4>

![screenshot](https://github.com/Henrique-Git/Projeto_Modulo3/blob/main/Gr%C3%A1ficos/Question%2010.png)

```
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
```

<h4 align= center>11: Top 7 treinadores com maior número de vitórias na temporada de 2019.</h4>

![screenshot](https://github.com/Henrique-Git/Projeto_Modulo3/blob/main/Gr%C3%A1ficos/Question%2011.png)

```
SELECT
    t.treinador AS Treinador,
    r.time_nome as Nome_Time,
    MAX(num_vitorias) as Número_Vitórias
FROM
    times AS t
INNER JOIN
    ranking AS r ON t.id = r.time_id
WHERE
    r.temporada_id = '22019' OR '12019'
GROUP BY
    t.treinador,
    r.time_nome
ORDER BY
    MAX(num_vitorias) DESC
LIMIT
    7 
```

<h4 align= center>12: Top 8 times com maior taxa de lances livres acertados em relação aos lances livres realizados.</h4>

![screenshot](https://github.com/Henrique-Git/Projeto_Modulo3/blob/main/Gr%C3%A1ficos/Question%2012.png)

```
SELECT
    DISTINCT 
    times.apelido AS Time_Nome,
    time_vencedor_abrev AS Abreviação,
    cidade_time AS Cidade,
    SUM(FTM) AS 'Lances livres Acertos',
    SUM(FTA) AS 'Lances livres Totais'
FROM
    detalhes_jogos
INNER JOIN
    times AS times ON times.id = detalhes_jogos.time_vencedor_id
GROUP BY
    times.apelido,
    time_vencedor_abrev,
    cidade_time
ORDER BY
    SUM(FTM) DESC
LIMIT
    8
```

Tecnologias
-------------------

* #### MySQL Workbench
* #### Metabase


Equipe
-------------------

<h4>:octocat:Fernando Agostini</h4>
<a href="https://github.com/FernandoAgostini28" alt="Instagram" target="_blank">
  <img src="https://img.shields.io/badge/-Github-orange?style=static&labelColor=black&logo=github&logoColor=white&link=https://github.com/FernandoAgostini28">
</a>
<h4>:octocat:Henrique Medeiros</h4>
<a href="https://github.com/Henrique-Git" alt="Instagram" target="_blank">
  <img src="https://img.shields.io/badge/-Github-orange?style=static&labelColor=black&logo=github&logoColor=white&link=https://github.com/Henrique-Git">
</a>
<h4>:octocat:João Michael Ferreira</h4>
<a href="https://github.com/Maicon-MK" alt="Instagram" target="_blank">
  <img src="https://img.shields.io/badge/-Github-orange?style=static&labelColor=black&logo=github&logoColor=white&link=https://github.com/Maicon-MK">
</a>
<h4>:octocat:Paloma Carvalho</h4>
<a href="https://github.com/PalomaBarreto" alt="Instagram" target="_blank">
  <img src="https://img.shields.io/badge/-Github-orange?style=static&labelColor=black&logo=github&logoColor=white&link=https://github.com/PalomaBarreto">
</a>
