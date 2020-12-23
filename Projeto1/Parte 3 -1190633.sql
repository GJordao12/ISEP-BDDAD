--Parte III
--(a) Apresentar por andar, o quarto e o tipo de quarto, que teve o maior número de
--reservas. Deverão ser excluídos todos os quartos em que o número de reservas
--é inferior a 2 e são do tipo “single”. Não incluir reservas canceladas.
SELECT
    reserva.nrandar,
    reserva.nrquarto,
    quarto.tipoquarto
FROM
         reserva
    INNER JOIN quarto ON quarto.nrquarto = reserva.nrquarto
                         AND quarto.nrandar = reserva.nrandar
WHERE
    upper(reserva.estado) NOT LIKE 'CANCELADA'
    AND upper(quarto.tipoquarto) NOT LIKE 'SINGLE'
GROUP BY
    reserva.nrandar,
    reserva.nrquarto,
    quarto.tipoquarto
HAVING COUNT(*) = (
        SELECT
            MAX(COUNT(*))
        FROM
            reserva r
        WHERE
                reserva.nrandar = r.nrandar
            AND upper(r.estado) NOT LIKE 'CANCELADA'
        GROUP BY
            nrandar,
            nrquarto
    )
       AND COUNT(*) >= 2
ORDER BY
    reserva.nrandar,
    reserva.nrquarto;

--(b) Apresentar os clientes que ocuparam quartos do tipo suite na última época alta
--e consumiram os dois produtos com maior consumo nos últimos dois anos. O
--resultado deve ser ordenado por ordem decrescente do valor total do consumo.
SELECT
    cliente.nome,
    (
        SELECT
            SUM(valor)
        FROM
                 item
            INNER JOIN produtoscomprados ON item.itemid = produtoscomprados.itemid
            INNER JOIN conta ON produtoscomprados.contanrconta = conta.nrconta
            INNER JOIN reserva ON conta.codres = reserva.codres
            INNER JOIN cliente c1 ON reserva.nifcliente = c1.nifcliente
        WHERE
            c1.nome = cliente.nome
    ) AS valor_total_consumo
FROM
         cliente
    INNER JOIN reserva ON cliente.nifcliente = reserva.nifcliente
    INNER JOIN quarto ON quarto.nrandar = reserva.nrandar
                         AND quarto.nrquarto = reserva.nrquarto
WHERE
    upper(reserva.epocadesignacao) LIKE 'ALTA'
    AND EXTRACT(YEAR FROM reserva.dataentrada) = (
        SELECT
            MAX(EXTRACT(YEAR FROM dataentrada))
        FROM
            reserva
        WHERE
            upper(epocadesignacao) LIKE 'ALTA'
    )
    AND upper(reserva.estado) LIKE 'FINALIZADA'
    AND upper(quarto.tipoquarto) LIKE 'SUITE'
    AND cliente.nifcliente IN (
        SELECT
            reserva.nifcliente
        FROM
                 reserva
            INNER JOIN conta ON reserva.codres = conta.codres
            INNER JOIN produtoscomprados p1 ON conta.nrconta = p1.contanrconta
        WHERE
            (
                SELECT
                    COUNT(DISTINCT p2.itemid)
                FROM
                    produtoscomprados p2
                WHERE
                        p1.contanrconta = p2.contanrconta
                    AND p2.itemid IN (
                        SELECT
                            p3.itemid
                        FROM
                            produtoscomprados p3
                        WHERE
                            EXTRACT(YEAR FROM dataa) = EXTRACT(YEAR FROM sysdate)
                            OR EXTRACT(YEAR FROM dataa) = ( ( EXTRACT(YEAR FROM sysdate) ) - 1 )
                        GROUP BY
                            p3.itemid
                        ORDER BY
                            COUNT(*) DESC
                        FETCH FIRST 2 ROWS ONLY
                    )
            ) = 2
    )
ORDER BY
    valor_total_consumo DESC;