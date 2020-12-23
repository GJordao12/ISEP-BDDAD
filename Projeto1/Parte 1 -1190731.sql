--(a) Apresentar todos os pedidos de intervenção em aberto (intervenção ainda não
--registada)
--alocados a funcionários de manutenção que não fizeram nenhuma
--intervenção (registo) nas últimas 48 hora;

SELECT
    m.codinter,
    m.estado,
    i.nrandar,
    i.nrquarto,
    i.nifempre,
    i.datainter
FROM
         manutencao m
    INNER JOIN intervencao i ON m.codinter = i.codinter
WHERE
    ( i.datainter <= sysdate )
    AND i.nifempre NOT IN (
        SELECT DISTINCT
            nifempre
        FROM
            intervencao ii
        WHERE
                ii.datainter >= ( sysdate - ( 72 / 24 ) )
            AND estado LIKE ( 'aberto' )
            AND ( ii.datainter <= sysdate )
    )
ORDER BY
    i.datainter,
    i.codinter;

--(b) Apresentar a data, a hora e o nome dos clientes que reservaram quartos
--somente durante o mês de Abril e Junho deste ano. 
--No caso de algum cliente ter reservado um quarto do tipo suite, deverá apresentar a localidade desse cliente
--numa coluna intitulada “Zona do País”. O resultado deverá ser apresentado por
--ordem alfabética do nome de cliente e por ordem descendente da data e hora da
--reserva.

SELECT
    cliente.nome,
    to_char(reserva.datareserva, 'HH24:MI:SS')        AS hora,
    reserva.dataentrada,
    CASE
        WHEN ( quarto.tipoquarto LIKE ( 'suite' ) ) THEN
            cliente.morada
        ELSE
            ' '
    END                                               AS zona_pais
FROM
         cliente
    INNER JOIN reserva ON reserva.nifcliente = cliente.nifcliente
    INNER JOIN quarto ON ( reserva.nrquarto = quarto.nrquarto
                           AND reserva.nrandar = quarto.nrandar )
WHERE
    (EXTRACT(MONTH FROM reserva.datareserva) = 4 AND EXTRACT(YEAR FROM reserva.datareserva)= EXTRACT(YEAR FROM sysdate))or
    (EXTRACT(MONTH FROM reserva.datareserva) = 6 AND EXTRACT(YEAR FROM reserva.datareserva)= EXTRACT(YEAR FROM sysdate))
ORDER BY
    cliente.nome ASC,
    reserva.datareserva DESC;