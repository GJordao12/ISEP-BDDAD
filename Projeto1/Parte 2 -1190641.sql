SELECT
    c1.nome,
    c1.localidade,
    c1.concelho
FROM
         cliente c1
    INNER JOIN reserva r1 ON r1.nifcliente = c1.nifcliente
WHERE
    c1.nome NOT LIKE 'José Silva'
    AND ( r1.nrquarto, r1.nrandar ) IN ( (
        SELECT
            r2.nrquarto, r2.nrandar
        FROM
                 reserva r2
            INNER JOIN cliente c2 ON r2.nifcliente = c2.nifcliente
        WHERE
            c2.nome LIKE 'José Silva'
            AND r2.estado = 'finalizada'
    ) );

SELECT
    ( EXTRACT(MONTH FROM r.dataentrada) ) AS mes,
    E.nifempre as nif
    ,e.nome
FROM
         reserva r
    INNER JOIN intervencao  i ON ( r.nrquarto = i.nrquarto
                                  AND r.nrandar = i.nrandar
                                  AND i.datainter BETWEEN r.dataentrada AND r.datasaida )
    INNER JOIN limpeza ON i.codinter = limpeza.codinter
    INNER JOIN EMPREGADO E ON E.NIFEMPRE = I.NIFEMPRE
    INNER JOIN camareira    c ON i.nifempre = c.nifempre
WHERE
    ( EXTRACT(MONTH FROM r.dataentrada) >= ( EXTRACT(MONTH FROM sysdate) - 6 ) )
    AND (
        SELECT
            COUNT(*)
        FROM
                 intervencao i2
            INNER JOIN reserva r2 ON ( r2.nrquarto = i2.nrquarto
                                       AND r2.nrandar = i2.nrandar
                                       AND i2.datainter BETWEEN r2.dataentrada AND r2.datasaida )
        WHERE
                i.nifempre = i2.nifempre
            AND ( r2.codres ) IN (
                SELECT
                    r1.codres
                FROM
                         reserva r1
                    INNER JOIN quarto  q1 ON ( q1.nrandar = r1.nrandar
                                              AND q1.nrquarto = r1.nrquarto )
                    INNER JOIN (
                        SELECT
                            q2.tipoquarto                                tipo,
                            AVG(r2.datasaida - r2.dataentrada)           media,
                            ( EXTRACT(MONTH FROM r2.dataentrada) )       mes
                        FROM
                                 quarto q2
                            INNER JOIN reserva r2 ON ( r2.nrandar = q2.nrandar
                                                       AND r2.nrquarto = q2.nrquarto )
                        GROUP BY
                            q2.tipoquarto,
                            ( EXTRACT(MONTH FROM r2.dataentrada) )
                    )       quer ON ( quer.tipo = q1.tipoquarto
                                AND quer.mes = EXTRACT(MONTH FROM r1.dataentrada) )
                WHERE
                        ( EXTRACT(MONTH FROM r.dataentrada) ) = ( EXTRACT(MONTH FROM r1.dataentrada) )
                    AND ( ( r1.datasaida - r1.dataentrada ) > quer.media )
            )
    ) >= ALL (
        SELECT
            COUNT(i3.codinter)
        FROM
                 intervencao i3
            INNER JOIN reserva  r3 ON i3.nrquarto = r3.nrquarto
                                     AND i3.nrandar = r3.nrandar
            INNER JOIN limpeza  l1 ON i3.codinter = l1.codinter
            INNER JOIN quarto   q3 ON ( q3.nrquarto = r3.nrquarto
                                      AND q3.nrandar = r3.nrandar )
            INNER JOIN (
                SELECT
                    q2.tipoquarto                                tipo,
                    AVG(r2.datasaida - r2.dataentrada)           media,
                    ( EXTRACT(MONTH FROM r2.dataentrada) )       mes
                FROM
                         quarto q2
                    INNER JOIN reserva r2 ON ( r2.nrandar = q2.nrandar
                                               AND r2.nrquarto = q2.nrquarto )
                GROUP BY
                    q2.tipoquarto,
                    ( EXTRACT(MONTH FROM r2.dataentrada) )
            )        quer ON ( quer.tipo = q3.tipoquarto
                        AND quer.mes = EXTRACT(MONTH FROM r3.dataentrada) )
        WHERE
            ( ( r3.datasaida - r3.dataentrada ) > quer.media )
            AND i3.datainter BETWEEN r3.dataentrada AND r3.datasaida
            AND ( EXTRACT(MONTH FROM i3.datainter) ) = ( EXTRACT(MONTH FROM i.datainter) )
        GROUP BY
            i3.nifempre,
            i3.nrquarto,
            i3.nrandar
    )
GROUP BY
    ( EXTRACT(MONTH FROM r.dataentrada) ),
    E.nifempre,E.NOME
ORDER BY
    mes;