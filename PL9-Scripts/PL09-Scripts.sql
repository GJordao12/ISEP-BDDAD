--6)
--1) Mostrar a quantidade de CD comprados em cada um dos locais de compra registados, de acordo com a Figura 2.
SELECT
    nvl(cd.localcompra, 'desconhecido')        AS localcompra,
    COUNT(*)                                   AS quantidade_cd
FROM
    cd
GROUP BY
    cd.localcompra
HAVING
    COUNT(*) > 0
ORDER BY
    localcompra DESC;

--2) Copiar e alterar o comando da alï¿½nea anterior, de forma a mostrar o resultado por ordem decrescente da quantidade de CD comprados.
SELECT
    nvl(cd.localcompra, 'desconhecido')        AS localcompra,
    COUNT(*)                                   AS quantidade_cd
FROM
    cd
GROUP BY
    cd.localcompra
HAVING
    COUNT(*) > 0
ORDER BY
    quantidade_cd DESC;

--3) Mostrar a quantidade de editoras diferentes que produziram os CD comprados, em cada um dos locais de compra. O resultado apresentado deve estar de acordo com a Figura 4.
WITH c2 AS (
    SELECT
        nvl(localcompra, 'desconhecido') AS localcompra,
        ideditora
    FROM
        cd
)
SELECT DISTINCT
    nvl(cd.localcompra, 'desconhecido')        AS localcompra,
    (
        SELECT
            COUNT(DISTINCT c2.ideditora)
        FROM
            c2
        WHERE
            nvl(cd.localcompra, 'desconhecido') = c2.localcompra
    )                                          quantidade_editorias
FROM
    cd
ORDER BY
    quantidade_editorias ASC;

--4) Copiar e alterar o comando da alï¿½nea 2, de forma a mostrar tambï¿½m, para cada local de compra conhecido,
--o valor total pago e o maior valor pago. O resultado apresentado deve estar de acordo com a Figura 5.
WITH c2 AS (
    SELECT
        localcompra,
        valorpago
    FROM
        cd
)
SELECT DISTINCT
    cd.localcompra    AS localcompra,
    (
        SELECT
            COUNT(c2.localcompra)
        FROM
            c2
        WHERE
            cd.localcompra = c2.localcompra
    )                 quantidade_cd,
    (
        SELECT
            SUM(c2.valorpago)
        FROM
            c2
        WHERE
            cd.localcompra = c2.localcompra
    )                 AS total,
    (
        SELECT
            MAX(c2.valorpago)
        FROM
            c2
        WHERE
            cd.localcompra = c2.localcompra
    )                 AS maior
FROM
    cd
WHERE
    cd.localcompra IS NOT NULL
ORDER BY
    quantidade_cd DESC;

--5) Mostrar, para cada CD e respetivos intï¿½rpretes, a quantidade de mï¿½sicas do CD em que o intï¿½rprete participa. Alï¿½m da quantidade referida, 
--tambï¿½m deve ser apresentado o cï¿½digo do CD e o intï¿½rprete, de acordo com a Figura 6.
WITH interpretes AS (
    SELECT
        interprete,
        codcd
    FROM
        musica
)
SELECT DISTINCT
    musica.codcd,
    musica.interprete,
    (
        SELECT
            COUNT(interpretes.interprete)
        FROM
            interpretes
        WHERE
                musica.interprete = interpretes.interprete
            AND interpretes.codcd = musica.codcd
    ) AS quantidade_musicas
FROM
    musica
ORDER BY
    musica.codcd;

--6) Copiar o comando da alï¿½nea 1 e alterar de modo a mostrar apenas os locais de compra com a quantidade superior a 2
SELECT DISTINCT
    nvl(cd.localcompra, 'desconhecido')        AS localcompra,
    COUNT(*)                                   AS quantidade_cd
FROM
    cd
GROUP BY
    cd.localcompra
HAVING
    COUNT(*) > 2
ORDER BY
    localcompra DESC;

--7) Mostrar os locais de compra, cuja mï¿½dia do valor pago por CD é inferior a 10, juntamente com o respetivo total do valor pago.
WITH c2 AS (
    SELECT
        localcompra,
        valorpago
    FROM
        cd
)
SELECT DISTINCT
    cd.localcompra    AS localcompra,
    (
        SELECT
            SUM(c2.valorpago)
        FROM
            c2
        WHERE
            cd.localcompra = c2.localcompra
    )                 AS total
FROM
    cd
WHERE
    cd.localcompra IS NOT NULL
    AND (
        SELECT
            AVG(c2.valorpago)
        FROM
            c2
        WHERE
            cd.localcompra = c2.localcompra
    ) < 10;

--8) Mostrar o valor total pago nos locais de compra, cuja quantidade de CD comprados são superior a 2. O local 
--de compra também deve ser visualizado.
WITH c2 AS (
    SELECT
        localcompra,
        valorpago
    FROM
        cd
)
SELECT DISTINCT
    nvl(c1.localcompra, 'desconhecido')        AS localcompra,
    (
        SELECT
            SUM(c2.valorpago)
        FROM
            c2
        WHERE
            c1.localcompra = c2.localcompra
    )                                          AS total
FROM
    (
        SELECT DISTINCT
            nvl(cd.localcompra, 'desconhecido') AS localcompra
        FROM
            cd
        GROUP BY
            cd.localcompra
        HAVING
            COUNT(*) > 2
    ) c1
ORDER BY
    localcompra DESC;

--9) Copiar o comando da alínea 5 e alterar de modo a mostrar apenas o interprete e o código do CD em que
--o interprete participa apenas em 1 música. O resultado deve ser apresentado por ordem crescente do
--código do CD e, em caso de igualdade, por ordem alfabética do interprete.
WITH interpretes AS (
    SELECT
        interprete,
        codcd
    FROM
        musica
)
SELECT DISTINCT
    musica.codcd,
    musica.interprete
FROM
    musica
WHERE
    (
        SELECT
            COUNT(interpretes.interprete)
        FROM
            interpretes
        WHERE
                musica.interprete = interpretes.interprete
            AND interpretes.codcd = musica.codcd
    ) = 1
ORDER BY
    musica.codcd ASC,
    musica.interprete ASC;
    
--10) Copiar o comando da alínea anterior e alterar de modo a mostrar apenas os intérpretes começados por E
--ou L (letras maiúsculas ou minúsculas)

WITH interpretes AS (
    SELECT
        interprete,
        codcd
    FROM
        musica
)
SELECT DISTINCT
    musica.interprete
FROM
    musica
WHERE
        (
            SELECT
                COUNT(interpretes.interprete)
            FROM
                interpretes
            WHERE
                    musica.interprete = interpretes.interprete
                AND interpretes.codcd = musica.codcd
        ) = 1
    AND ( musica.interprete LIKE ( 'E%' )
          OR musica.interprete LIKE ( 'L%' ) )
ORDER BY
    musica.interprete ASC;
    
--11) Mostrar os dias de semana e a respetiva quantidade de CD comprados em locais conhecidos, de acordo
--com a Figura 12.

/**
###Mostrar ao stor####
  SELECT
        to_char(cd.datacompra, 'DAY') AS dia_semana
    FROM
        cd
    --WHERE
        --cd.localcompra IS NOT NULL
    --GROUP BY
        --cd.datacompra
*/
        
WITH c2 AS (
    SELECT DISTINCT
        to_char(cd.datacompra, 'DAY') AS dia_semana
    FROM
        cd
    WHERE
        cd.localcompra IS NOT NULL
    GROUP BY
        cd.datacompra
)
SELECT
    c2.dia_semana    AS dia_semana,
    (
        SELECT
            COUNT(to_char(cd.datacompra, 'DAY'))
        FROM
            cd
        WHERE
                to_char(cd.datacompra, 'DAY') = c2.dia_semana
            AND cd.localcompra IS NOT NULL
    )                AS quantidade_cds
FROM
    c2
ORDER BY
    dia_semana;
    
--12) Mostrar, para cada CD, o título e a quantidade de músicas.

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
    
--13) Mostrar, para cada CD, o código, o título e a quantidade de músicas.
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
    
--14) Mostrar, para cada CD, o código, o título e a quantidade de músicas cuja duração é superior a 5.
WITH aux AS (
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
                AND musica.duracao > 5
        ) AS quantidade_musicas
    FROM
        cd
)
SELECT
    aux.codcd,
    aux.titulo,
    aux.quantidade_musicas
FROM
    aux
WHERE
    quantidade_musicas > 0
ORDER BY
    quantidade_musicas DESC;
    
--15) Mostrar, para cada CD com menos de 6 músicas, o código, o título e a quantidade de músicas do CD.
WITH aux AS (
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
)
SELECT
    aux.codcd,
    aux.titulo,
    aux.quantidade_musicas
FROM
    aux
WHERE
    quantidade_musicas < 6
ORDER BY
    quantidade_musicas DESC;

--16) Mostrar, para cada CD cujas músicas têm uma duração média superior a 4, o código, o título e a quantidade de músicas do CD.
WITH aux AS (
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
        )  AS quantidade_musicas,
        (
            SELECT
                AVG(musica.duracao)
            FROM
                musica
            WHERE
                musica.codcd = cd.codcd
        )  AS media_duracao
    FROM
        cd
)
SELECT
    aux.codcd,
    aux.titulo,
    aux.quantidade_musicas
FROM
    aux
WHERE
    media_duracao > 4
ORDER BY
    quantidade_musicas DESC;