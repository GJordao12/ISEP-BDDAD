--6)
--1) Mostrar a quantidade de CD comprados em cada um dos locais de compra registados, de acordo com a Figura 2.
SELECT
    nvl(localcompra, 'desconhecido')      AS localcompra,
    COUNT(*)                              AS quantidade_cd
FROM
    cd
GROUP BY
    localcompra,
    nvl(localcompra, 'desconhecido');

--2) Copiar e alterar o comando da al�nea anterior, de forma a mostrar o resultado por ordem decrescente da quantidade de CD comprados.
SELECT
    nvl(localcompra, 'desconhecido')      AS localcompra,
    COUNT(*)                              AS quantidade_cd
FROM
    cd
GROUP BY
    localcompra,
    nvl(localcompra, 'desconhecido')
ORDER BY
    quantidade_cd DESC;

--3) Mostrar a quantidade de editoras diferentes que produziram os CD comprados, em cada um dos locais de compra. O resultado apresentado deve estar de acordo com a Figura 4.

SELECT
    nvl(localcompra, 'desconhecido')      AS localcompra,
    COUNT(DISTINCT ideditora)             AS quantidade_editoras
FROM
    cd
GROUP BY
    localcompra,
    nvl(localcompra, 'desconhecido')
ORDER BY
    quantidade_editoras ASC;

--4) Copiar e alterar o comando da al�nea 2, de forma a mostrar tamb�m, para cada local de compra conhecido,
--o valor total pago e o maior valor pago. O resultado apresentado deve estar de acordo com a Figura 5.

SELECT
    localcompra        AS localcompra,
    COUNT(*)           AS quantidade_cd,
    SUM(valorpago)     AS total,
    MAX(valorpago)     AS maior
FROM
    cd
WHERE
    localcompra IS NOT NULL
GROUP BY
    localcompra
ORDER BY
    quantidade_cd DESC;

--5) Mostrar, para cada CD e respetivos int�rpretes, a quantidade de m�sicas do CD em que o int�rprete participa. Al�m da quantidade referida, 
--tamb�m deve ser apresentado o c�digo do CD e o int�rprete, de acordo com a Figura 6.

SELECT
    codcd        AS cod_cd,
    interprete,
    COUNT(*)     AS quantidade_cd
FROM
    musica
GROUP BY
    interprete,
    codcd
ORDER BY
    codcd ASC;

--6) Copiar o comando da al�nea 1 e alterar de modo a mostrar apenas os locais de compra com a quantidade superior a 2
SELECT DISTINCT
    nvl(localcompra, 'desconhecido')      AS localcompra,
    COUNT(*)                              AS quantidade_cd
FROM
    cd
GROUP BY
    localcompra,
    nvl(localcompra, 'desconhecido')
HAVING
    COUNT(*) > 2
ORDER BY
    localcompra DESC;

--7) Mostrar os locais de compra, cuja m�dia do valor pago por CD � inferior a 10, juntamente com o respetivo total do valor pago.
SELECT
    localcompra        AS localcompra,
    SUM(valorpago)     AS total
FROM
    cd
GROUP BY
    localcompra
HAVING
    AVG(valorpago) < 10;
    
--8) Mostrar o valor total pago nos locais de compra, cuja quantidade de CD comprados s�o superior a 2. O local 
--de compra tamb�m deve ser visualizado.
SELECT
    localcompra        AS localcompra,
    SUM(valorpago)     AS total
FROM
    cd
GROUP BY
    localcompra
HAVING
    COUNT(*) > 2;

--9) Copiar o comando da al�nea 5 e alterar de modo a mostrar apenas o interprete e o c�digo do CD em que
--o interprete participa apenas em 1 m�sica. O resultado deve ser apresentado por ordem crescente do
--c�digo do CD e, em caso de igualdade, por ordem alfab�tica do interprete.
SELECT
    codcd AS cod_cd,
    interprete
FROM
    musica
GROUP BY
    interprete,
    codcd
HAVING
    COUNT(*) = 1
ORDER BY
    codcd ASC;
    
--10) Copiar o comando da al�nea anterior e alterar de modo a mostrar apenas os int�rpretes come�ados por E
--ou L (letras mai�sculas ou min�sculas)

SELECT DISTINCT
    interprete
FROM
    (
        SELECT
            codcd AS cod_cd,
            interprete
        FROM
            musica
        GROUP BY
            interprete,
            codcd
        HAVING COUNT(*) = 1
               AND ( interprete LIKE ( 'E%' )
                     OR interprete LIKE ( 'L%' ) )
        ORDER BY
            codcd ASC
    )
ORDER BY
    interprete;
    
--11) Mostrar os dias de semana e a respetiva quantidade de CD comprados em locais conhecidos, de acordo
--com a Figura 12.

SELECT
    to_char(datacompra, 'day')      AS dia_semana,
    COUNT(codcd)                    AS qtd_cd_comprados
FROM
    cd
WHERE
    localcompra IS NOT NULL
GROUP BY
    to_char(datacompra, 'day')
HAVING
    COUNT(codcd) >= 2
ORDER BY
    dia_semana ASC;
    
--12) Mostrar, para cada CD, o t�tulo e a quantidade de m�sicas.

SELECT
    cd.titulo,
    (
        SELECT
            COUNT(musica.codcd)
        FROM
            musica
        WHERE
            musica.codcd = cd.codcd
    ) AS quantidade_musicas
FROM
    cd
ORDER BY
    quantidade_musicas DESC;
 
        
--13) Mostrar, para cada CD, o c�digo, o t�tulo e a quantidade de m�sicas.
SELECT
    cd.codcd,
    cd.titulo,
    (
        SELECT
            COUNT(musica.codcd)
        FROM
            musica
        WHERE
            musica.codcd = cd.codcd
    ) AS quantidade_musicas
FROM
    cd
ORDER BY
    quantidade_musicas DESC;
    
--14) Mostrar, para cada CD, o c�digo, o t�tulo e a quantidade de m�sicas cuja dura��o � superior a 5.
SELECT
    codcd,
    titulo,
    quantidade_musicas
FROM
    (
        SELECT
            codcd,
            titulo,
            (
                SELECT
                    COUNT(musica.codcd)
                FROM
                    musica
                WHERE
                        musica.codcd = cd.codcd
                    AND musica.duracao > 5
            ) AS quantidade_musicas
        FROM
            cd
        ORDER BY
            quantidade_musicas DESC
    )
WHERE
    quantidade_musicas > 0;
    
--15) Mostrar, para cada CD com menos de 6 m�sicas, o c�digo, o t�tulo e a quantidade de m�sicas do CD.

SELECT
    codcd,
    titulo,
    quantidade_musicas
FROM
    (
        SELECT
            codcd,
            titulo,
            (
                SELECT
                    COUNT(musica.codcd)
                FROM
                    musica
                WHERE
                    musica.codcd = cd.codcd
            ) AS quantidade_musicas
        FROM
            cd
    )
WHERE
    quantidade_musicas < 6
ORDER BY
    quantidade_musicas DESC;
    
--16) Mostrar, para cada CD cujas m�sicas t�m uma dura��o m�dia superior a 4, o c�digo, o t�tulo e a quantidade de m�sicas do CD.
SELECT
    cd.codcd,
    cd.titulo,
    COUNT(*) AS quantidade_musica
FROM
         cd
    INNER JOIN musica mus ON cd.codcd = mus.codcd
GROUP BY
    cd.titulo,
    cd.codcd
HAVING
    AVG(mus.duracao) > 4
ORDER BY
    quantidade_musica DESC;
    
--17) Mostrar, numa coluna, o t�tulo de cada uma das m�sicas e o t�tulo de cada CD que tem pelo menos 3
--interpretes. O resultado apresentado deve estar de acordo com a Figura 18.
SELECT
    titulo
FROM
    (
        SELECT
            titulo,
            codcd
        FROM
            cd
        GROUP BY
            titulo,
            codcd
        HAVING
            (
                SELECT
                    COUNT(DISTINCT interprete)
                FROM
                    musica
                WHERE
                    cd.codcd = codcd
            ) > 2
        UNION
        SELECT
            titulo,
            codcd
        FROM
            musica
        GROUP BY
            titulo,
            codcd
        HAVING
            (
                SELECT
                    COUNT(DISTINCT interprete)
                FROM
                    musica
                WHERE
                    musica.codcd = codcd
            ) > 2
    );
    
--18) Copiar e alterar o comando da al�nea anterior, de modo a n�o mostrar os registos repetidos
SELECT DISTINCT
    titulo
FROM
    (
        SELECT
            titulo,
            codcd
        FROM
            cd
        GROUP BY
            titulo,
            codcd
        HAVING
            (
                SELECT
                    COUNT(DISTINCT interprete)
                FROM
                    musica
                WHERE
                    cd.codcd = codcd
            ) > 2
        UNION
        SELECT
            titulo,
            codcd
        FROM
            musica
        GROUP BY
            titulo,
            codcd
        HAVING
            (
                SELECT
                    COUNT(DISTINCT interprete)
                FROM
                    musica
                WHERE
                    musica.codcd = codcd
            ) > 2
    );


--19) Copiar e alterar o comando da al�nea anterior, de modo a apresentar tamb�m o comprimento de cada
--t�tulo e por ordem decrescente.
SELECT DISTINCT
    titulo,
    length(titulo) AS comprimento
FROM
    (
        SELECT
            titulo,
            codcd
        FROM
            cd
        GROUP BY
            titulo,
            codcd
        HAVING
            (
                SELECT
                    COUNT(DISTINCT interprete)
                FROM
                    musica
                WHERE
                    cd.codcd = codcd
            ) > 2
        UNION
        SELECT
            titulo,
            codcd
        FROM
            musica
        GROUP BY
            titulo,
            codcd
        HAVING
            (
                SELECT
                    COUNT(DISTINCT interprete)
                FROM
                    musica
                WHERE
                    musica.codcd = codcd
            ) > 2
    )
ORDER BY
    comprimento DESC;

--20) Mostrar os t�tulos de m�sicas que s�o iguais a t�tulos de CD e cuja maior dura��o da m�sica com maior
--dura��o � superior a 5. A solu��o n�o deve recorrer ao uso de subqueries.