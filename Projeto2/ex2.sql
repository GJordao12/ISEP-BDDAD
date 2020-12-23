--Aluno A do Grupo -> Gonçalo Jordão 1190633

--2. Implementar um procedimento designado prcCheckOut para efetuar o check-out de um
--quarto, incluindo a geração da fatura. O procedimento deve receber por parâmetro a
--linha da tabela reserva correspondente à reserva do quarto. Se o parâmetro fornecido for
--inválido, o procedimento deve levantar uma exceção com uma mensagem apropriada. O
--procedimento tem que tirar o máximo proveito do código SQL. Testar adequadamente o
--procedimento implementado, através de blocos anónimos.

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE prccheckout (
    linhareserva reserva%rowtype
) IS

    reserva_escolhida  reserva%rowtype;
    contador           INTEGER;
    idfatura           INTEGER;
    reserva_null EXCEPTION;
    reserva_nao_existe EXCEPTION;
    reserva_sem_checkin EXCEPTION;
    reserva_ja_tem_checkout EXCEPTION;
BEGIN
    --verficação de parâmetro null
    IF ( linhareserva.id IS NULL ) THEN
        RAISE reserva_null;
    END IF;

    --verficação de existência de reserva
    SELECT
        COUNT(*)
    INTO contador
    FROM
        reserva
    WHERE
        reserva.id = linhareserva.id;

    IF ( contador = 0 ) THEN
        RAISE reserva_nao_existe;
    END IF;

    --verficação de existência de checkin
    SELECT
        COUNT(*)
    INTO contador
    FROM
        checkin
    WHERE
        checkin.id_reserva = linhareserva.id;

    IF ( contador = 0 ) THEN
        RAISE reserva_sem_checkin;
    END IF;

     --verficação de existência de checkout
    SELECT
        COUNT(*)
    INTO contador
    FROM
        checkout
    WHERE
        checkout.id_reserva = linhareserva.id;

    IF ( contador != 0 ) THEN
        RAISE reserva_ja_tem_checkout;
    END IF;

    --insert de valores no checkout
    INSERT INTO checkout VALUES (
        linhareserva.id,
        sysdate,
        'observações',
        linhareserva.custo_extra
    );

    --próximo id de fatura sequencial
    idfatura := seq_fatura.nextval;

    --verificar o consumo existente
    FOR l IN (
        SELECT
            *
        FROM
                 linha_conta_consumo
            INNER JOIN conta_consumo ON linha_conta_consumo.id_conta_consumo = conta_consumo.id
        WHERE
            conta_consumo.id_reserva = linhareserva.id
    ) LOOP
        contador := ( l.preco_unitario * l.quantidade );

        --insert dos valores na linha_fatura
        INSERT INTO linha_fatura VALUES (
            idfatura,
            seq_linha_fatura.NEXTVAL,
            l.id_conta_consumo,
            l.linha,
            contador
        );

    END LOOP;

    --somar o consumo existente
    SELECT
        SUM(valor_consumo)
    INTO contador
    FROM
        linha_fatura
    WHERE
        linha_fatura.id_fatura = idfatura;

    --insert dos valores na fatura
    INSERT INTO fatura VALUES (
        idfatura,
        idfatura,
        sysdate,
        linhareserva.id_cliente,
        linhareserva.id,
        linhareserva.preco,
        contador
    );

    dbms_output.put_line('SUCCESS: Checkout realizado com sucesso e fatura gerada com sucesso!');
EXCEPTION
    WHEN reserva_nao_existe THEN
        dbms_output.put_line('ERROR: A reserva não existe!');
    WHEN reserva_null THEN
        dbms_output.put_line('ERROR: Parâmetro NULL!');
    WHEN reserva_sem_checkin THEN
        dbms_output.put_line('ERROR: A reserva não tem checkin, logo não se pode realizar o checkout!');
    WHEN reserva_ja_tem_checkout THEN
        dbms_output.put_line('ERROR: A reserva já possui checkout!');
END;
/

DECLARE
    PROCEDURE prcteste2 (
        linhareserva reserva%rowtype
    ) IS
    BEGIN
        dbms_output.put_line('=======================================================================');
        dbms_output.put_line('ID da reserva: ' || linhareserva.id);
        dbms_output.put_line('=======================================================================');
        prccheckout(linhareserva);
        dbms_output.put_line('=======================================================================');
        dbms_output.put_line('');
        dbms_output.put_line('');
    END;

BEGIN
    --teste para parâmetro null
    prcteste2(NULL);

    --teste para uma reserva que não existe
    DECLARE
        linhareserva reserva%rowtype;
    BEGIN
        SELECT
            500000,
            NULL,
            'Cliente reserva 250',
            NULL,
            NULL,
            NULL,
            2,
            TO_DATE('2020-01-25', 'yyyy-mm-dd'),
            TO_DATE('2020-02-04', 'yyyy-mm-dd'),
            TO_DATE('2020-02-06', 'yyyy-mm-dd'),
            3,
            60,
            1,
            NULL,
            NULL
        INTO linhareserva
        FROM
            dual;

        prcteste2(linhareserva);
    END;

    --teste para uma reserva que não tem checkin
    DECLARE
        linhareserva reserva%rowtype;
    BEGIN
        SELECT
            3332,
            NULL,
            'Cliente reserva 250',
            NULL,
            NULL,
            NULL,
            2,
            TO_DATE('2020-01-25', 'yyyy-mm-dd'),
            TO_DATE('2020-02-04', 'yyyy-mm-dd'),
            TO_DATE('2020-02-06', 'yyyy-mm-dd'),
            3,
            60,
            1,
            NULL,
            NULL
        INTO linhareserva
        FROM
            dual;

        prcteste2(linhareserva);
    END;

    --teste para uma reserva que já tem checkout
    DECLARE
        linhareserva reserva%rowtype;
    BEGIN
        SELECT
            311,
            NULL,
            'Cliente reserva 250',
            NULL,
            NULL,
            NULL,
            2,
            TO_DATE('2020-01-25', 'yyyy-mm-dd'),
            TO_DATE('2020-02-04', 'yyyy-mm-dd'),
            TO_DATE('2020-02-06', 'yyyy-mm-dd'),
            3,
            60,
            1,
            NULL,
            NULL
        INTO linhareserva
        FROM
            dual;

        prcteste2(linhareserva);
    END;

    --teste para uma reserva que nao tem checkout mas tem checkin (NOTA: É preciso fazer um insert do checkin, visto que
    --nos ficheiros dados não existia nenhuma reserva com checkin com checkout ainda por realizar)
    INSERT INTO checkin VALUES (
        3331,
        sysdate,
        2
    );

    DECLARE
        linhareserva reserva%rowtype;
    BEGIN
        SELECT
            3331,
            169,
            'Cliente reserva 3031',
            NULL,
            NULL,
            NULL,
            2,
            TO_DATE('2020-10-30', 'yyyy-mm-dd'),
            TO_DATE('2020-10-31', 'yyyy-mm-dd'),
            TO_DATE('2020-11-02', 'yyyy-mm-dd'),
            4,
            60,
            1,
            NULL,
            NULL
        INTO linhareserva
        FROM
            dual;

        prcteste2(linhareserva);
    END;

END;
/
