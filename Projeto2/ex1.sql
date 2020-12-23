--Aluno A do Grupo -> Gon�alo Jord�o 1190633

--1. Implementar uma fun��o designada fncGetQuartoReserva que, dado o ID de uma
--reserva, retorne o quarto a alocar. Havendo mais que um quarto, pretende-se o que
--estiver no andar mais baixo e, depois, que tenha tido menos dias de ocupa��p no �ltimo
--ano (para promover a distribui��o da utiliza��o pelos diversos quartos). No caso de o
--par�metro ser inv�lido ou n�o haver quarto dispon�vel, a fun��o deve retornar o valor
--NULL atrav�s do mecanismo de exce��es. O par�metro � iinv�lido quando: a) � null, b)
--n�o existe, c) a reserva j� tem um quarto associado, d) o estado da reserva n�o � o
--adequado (e.g. est� fechada). A fun��o tem que tirar o m�ximo proveito do c�digo SQL.
--Testar adequadamente a fun��o implementada, atrav�s de blocos an�nimos.

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION fncgetquartoreserva (
    idreserva reserva.id%TYPE
) RETURN quarto%rowtype IS

    qdisponivel  quarto%rowtype;
    contador     INTEGER;
    estado       INTEGER;
    valor_null EXCEPTION;
    quarto_associado EXCEPTION;
    invalido_estado EXCEPTION;
    sem_quarto_disponivel EXCEPTION;
    CURSOR c_quartos IS
    SELECT
        id,
        id_andar,
        nr_quarto,
        id_tipo_quarto,
        lotacao_maxima
    FROM
        quarto
    WHERE
        --verificar se o quarto n�o est� na lista de quartos indisponiveis
        quarto.id NOT IN (
            --buscar os quartos indisponiveis
            SELECT DISTINCT
                id_quarto
            FROM
                     checkin
                INNER JOIN reserva ON reserva.id = checkin.id_reserva
            WHERE
                ( reserva.data_entrada BETWEEN (
                    SELECT
                        data_entrada
                    FROM
                        reserva
                    WHERE
                        reserva.id = idreserva
                ) AND (
                    SELECT
                        data_saida
                    FROM
                        reserva
                    WHERE
                        reserva.id = idreserva
                ) )
                OR ( reserva.data_saida BETWEEN (
                    SELECT
                        data_entrada
                    FROM
                        reserva
                    WHERE
                        reserva.id = idreserva
                ) AND (
                    SELECT
                        data_saida
                    FROM
                        reserva
                    WHERE
                        reserva.id = idreserva
                ) )
                OR ( ( reserva.data_entrada < (
                    SELECT
                        data_entrada
                    FROM
                        reserva
                    WHERE
                        reserva.id = idreserva
                ) )
                     AND ( reserva.data_saida > (
                    SELECT
                        data_saida
                    FROM
                        reserva
                    WHERE
                        reserva.id = idreserva
                ) ) )
        )
        --verificar se o tipo de quarto � correspondente ao tipo de quarto da reserva
        AND quarto.id_tipo_quarto = (
            SELECT
                id_tipo_quarto
            FROM
                reserva
            WHERE
                reserva.id = idreserva
        )
    ORDER BY
        quarto.id_andar ASC,
        --ocupa��o em dias no �ltimo ano
        (
            SELECT
                SUM(reserva.data_saida - reserva.data_entrada)
            FROM
                     reserva
                INNER JOIN checkin ON checkin.id_reserva = reserva.id
            WHERE
                reserva.data_entrada BETWEEN add_months(sysdate, - 12) AND sysdate
                AND reserva.data_saida BETWEEN add_months(sysdate, - 12) AND sysdate
                AND checkin.id_quarto = quarto.id
        ) ASC
    --ficar s� com o primeiro da lista
    FETCH FIRST 1 ROWS ONLY;

BEGIN
    --verifica��o de par�metro null
    IF idreserva IS NULL THEN
        RAISE valor_null;
    END IF;

    --verifica��o de quarto j� associado
    SELECT
        COUNT(*)
    INTO contador
    FROM
        checkin
    WHERE
        id_reserva = idreserva;

    IF ( contador != 0 ) THEN
        RAISE quarto_associado;
    END IF;

    --verifica��o de estado de reserva adequado
    SELECT
        id_estado_reserva
    INTO estado
    FROM
        reserva
    WHERE
        id = idreserva;

    IF ( estado != 1 ) THEN
        RAISE invalido_estado;
    END IF;

    --ver o conteudo do cursor
    OPEN c_quartos;
    LOOP
        FETCH c_quartos INTO qdisponivel;
        EXIT WHEN c_quartos%notfound;
        RETURN qdisponivel;
    END LOOP;
    CLOSE c_quartos;

    --caso o cursor esteja vazio, chamar a exce��o sem_quarto_disponivel
    RAISE sem_quarto_disponivel;
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('ERROR: A reserva n�o existe!');
        RETURN NULL;
    WHEN valor_null THEN
        dbms_output.put_line('ERROR: Par�metro NULL!');
        RETURN NULL;
    WHEN quarto_associado THEN
        dbms_output.put_line('ERROR: A reserva j� tem um quarto associado!');
        RETURN NULL;
    WHEN invalido_estado THEN
        dbms_output.put_line('ERROR: A reserva n�o est� aberta!');
        RETURN NULL;
    WHEN sem_quarto_disponivel THEN
        dbms_output.put_line('ERROR: N�o existe um quarto dispon�vel!');
        RETURN NULL;
END;
/

DECLARE
    PROCEDURE prcteste1 (
        idreserva reserva.id%TYPE
    ) IS
        vquarto quarto%rowtype;
    BEGIN
        dbms_output.put_line('==============================================');
        dbms_output.put_line('ID da reserva: ' || idreserva);
        dbms_output.put_line('==============================================');
        vquarto := fncgetquartoreserva(idreserva);
        IF vquarto.id IS NOT NULL THEN
            dbms_output.put_line('ID do quarto: ' || vquarto.id);
            dbms_output.put_line('ID do andar: ' || vquarto.id_andar);
            dbms_output.put_line('N�mero do quarto: ' || vquarto.nr_quarto);
            dbms_output.put_line('ID do tipo do quarto: ' || vquarto.id_tipo_quarto);
            dbms_output.put_line('Lota��o M�xima: ' || vquarto.lotacao_maxima);
        END IF;

        dbms_output.put_line('==============================================');
        dbms_output.put_line('');
        dbms_output.put_line('');
    END;

BEGIN
    --teste para par�metro null
    prcteste1(NULL);

    --teste para uma reserva que n�o existe
    prcteste1(500000);

    --teste para uma reserva que j� tem um quarto associado
    prcteste1(100);

    --teste para uma reserva que n�o tem um quarto dispon�vel
    prcteste1(131);

    --teste para uma reserva que tem quarto dispon�vel
    prcteste1(3174);
END;
/