--Aluno A do Grupo -> Gonçalo Jordão 1190633

--3. Implementar um trigger designado trgEpocasNaoSobrepostas que garanta que a
--inserção/alteração de uma época não conduz a sobreposição entre épocas. Testar
--adequadamente o trigger implementado.

SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER trgepocasnaosobrepostas FOR
INSERT OR UPDATE ON epoca
COMPOUND TRIGGER
    TYPE epocat IS
        TABLE OF epoca%rowtype INDEX BY SIMPLE_INTEGER;
    arrepoca  epocat;
    i         VARCHAR2(64);
    BEFORE STATEMENT IS BEGIN
        SELECT
            *
        BULK COLLECT
        INTO arrepoca
        FROM
            epoca;

    END BEFORE STATEMENT;
    BEFORE EACH ROW IS BEGIN
        i := arrepoca.first;
        WHILE i IS NOT NULL LOOP
            IF ( arrepoca(i).id != :new.id ) THEN
                 --verificar se há sobreposição de datas
                IF ( ((:new.data_ini) BETWEEN arrEpoca(i).DATA_INI AND arrEpoca(i).DATA_FIM)
                OR   ((:new.data_fim) BETWEEN arrEpoca(i).DATA_INI AND arrEpoca(i).DATA_FIM)
                OR ( ((:new.data_ini) < arrEpoca(i).DATA_INI) AND ((:new.data_fim) > arrEpoca(i).DATA_FIM) ) )
                THEN raise_application_error(-20001, 'ERROR: A inserção/alteração vai fazer com que exista sobreposição entre épocas!');
                END IF;
            END IF;
            i := arrepoca.next(i);
        END LOOP;

    END BEFORE EACH ROW;
END;
/

--NOTA: Correr os scripts em separado devido ao raise_application_error
BEGIN
    --teste para uma época inválida
    INSERT INTO epoca VALUES (
        21,
        'Época 21',
        TO_DATE('2020-01-02', 'yyyy-mm-dd'),
        TO_DATE('2020-01-04', 'yyyy-mm-dd')
    );

    --teste para uma época válida
    INSERT INTO epoca VALUES (
        21,
        'Época 21',
        TO_DATE('2019-01-02', 'yyyy-mm-dd'),
        TO_DATE('2019-01-04', 'yyyy-mm-dd')
    );

    --teste para update inválido
    UPDATE epoca
    SET
        data_ini = TO_DATE('2020-07-05', 'yyyy-mm-dd')
    WHERE
        epoca.id = 3;

    --teste para update válido
    UPDATE epoca
    SET
        data_ini = TO_DATE('2019-12-01', 'yyyy-mm-dd')
    WHERE
        epoca.id = 1;
END;
/