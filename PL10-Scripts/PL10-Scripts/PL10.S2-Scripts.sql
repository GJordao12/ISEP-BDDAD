--1) Mostrar o id, o nome e a classificação dos marinheiros com a melhor classificação (Figura 2), usando três estratégias diferentes, nomeadamente:
----a) Sem junção de tabelas e com função de agregação;
SELECT
    idmarinheiro,
    nome,
    classificacao
FROM
    marinheiro
WHERE
    classificacao = (
        SELECT
            MAX(classificacao)
        FROM
            marinheiro
    )
ORDER BY
    nome;

----b) Sem junção de tabelas e sem função de agregação;  
SELECT
    idmarinheiro,
    nome,
    classificacao
FROM
    marinheiro
WHERE
    classificacao >= ALL (
        SELECT
            classificacao
        FROM
            marinheiro
    );
   
----c) Com junção de tabelas.
SELECT
    idmarinheiro,
    nome,
    classificacao
FROM
         marinheiro m1
    INNER JOIN (
        SELECT
            MAX(classificacao) maxclassif
        FROM
            marinheiro
    ) m2 ON m1.classificacao = m2.maxclassif;


--2) Mostrar o id, o nome, a classificação dos marinheiros e o comentário “Superior à média” associado apenas aos marinheiros que têm classificação superior à média (Figura 3). Resolver usando três estratégias diferentes, nomeadamente:
----a) Sem junção de tabelas;
SELECT
    idmarinheiro,
    classificacao,
    nome,
    CASE
        WHEN classificacao > (
            SELECT
                AVG(classificacao)
            FROM
                marinheiro
        ) THEN
            'Superior à média'
        ELSE
            ' '
    END obs
FROM
    marinheiro
GROUP BY
    idmarinheiro,
    classificacao,
    nome;

----b) Com junção de tabelas e sem cláusula WITH;
SELECT
    a.idmarinheiro,
    a.classificacao,
    a.nome,
    CASE
        WHEN b.media IS NOT NULL THEN
            'Superior à media'
        ELSE
            ' '
    END obs
FROM
    marinheiro  a
    LEFT JOIN (
        SELECT
            AVG(classificacao) media
        FROM
            marinheiro
    )           b ON ( a.classificacao > b.media );

----c) Com junção de tabelas e com cláusula WITH.
WITH b AS (
    SELECT
        AVG(classificacao) media
    FROM
        marinheiro
)
SELECT
    a.idmarinheiro,
    a.classificacao,
    a.nome,
    CASE
        WHEN b.media IS NOT NULL THEN
            'Superior à media'
        ELSE
            ' '
    END obs
FROM
    marinheiro  a
    LEFT JOIN (
        SELECT
            AVG(classificacao) media
        FROM
            marinheiro
    )           b ON ( a.classificacao > b.media );

--3) Mostrar o id e o nome dos marinheiros que não reservaram barcos (Figura 4), usando quatro estratégias diferentes, nomeadamente:  
----a) Com operador IN;
SELECT
    idmarinheiro,
    nome
FROM
    marinheiro
WHERE
    idmarinheiro NOT IN (
        SELECT
            idmarinheiro
        FROM
            reserva
    )
ORDER BY
    idmarinheiro;
  
----b) Com condição ANY; 
SELECT
    idmarinheiro,
    nome
FROM
    marinheiro
WHERE
    NOT idmarinheiro = ANY (
        SELECT
            idmarinheiro
        FROM
            reserva
    )
ORDER BY
    idmarinheiro;
 
----c) Com operador de conjuntos; 
SELECT
    a.idmarinheiro,
    nome
FROM
         (
        SELECT
            idmarinheiro
        FROM
            marinheiro
        MINUS
        SELECT
            idmarinheiro
        FROM
            reserva
    ) a
    JOIN marinheiro b ON ( a.idmarinheiro = b.idmarinheiro )
ORDER BY
    1;

----d) Sem subqueries.
SELECT DISTINCT
    marinheiro.idmarinheiro,
    marinheiro.nome
FROM
    marinheiro
    LEFT JOIN reserva ON marinheiro.idmarinheiro = reserva.idmarinheiro
WHERE
    reserva.idmarinheiro IS NULL
ORDER BY
    idmarinheiro;
 

--4) Mostrar as datas com mais reservas de barcos (Figura 5).
SELECT
    reserva.data
FROM
    reserva
GROUP BY
    reserva.data
HAVING
    COUNT(*) = (
        SELECT
            MAX(qtd)
        FROM
            (
                SELECT
                    data,
                    COUNT(data) AS qtd
                FROM
                    reserva
                GROUP BY
                    data
            )
    );

--5) Mostrar o número total de marinheiros que reservaram barcos com a cor vermelho e barcos com a cor verde (Figura 6).
SELECT
    COUNT(DISTINCT a.idmarinheiro) AS qtd_marinheiros
FROM
    (
        SELECT
            *
        FROM
                 reserva a
            JOIN barco b ON ( a.idbarco = b.idbarco )
        WHERE
            cor = 'verde'
    )  a,
    (
        SELECT
            *
        FROM
                 reserva a
            JOIN barco b ON ( a.idbarco = b.idbarco )
        WHERE
            cor = 'vermelho'
    )  b
WHERE
    a.idmarinheiro = b.idmarinheiro;