CREATE OR replace FUNCTION fncdisponibilidadereserva(pTipoQuarto TIPO_QUARTO.nome%TYPE,
                                                     pData DATE,
                                                     pDias INT,
                                                     pNnrPessoas INT) RETURN BOOLEAN AS


    vIdTipoQuarto    NUMBER;
    vMaxNrPessoas      NUMBER;
    vQuantidadeVagas   NUMBER;
    vQuantidadeQuartos NUMBER;

    --Exceçoes
    exDataInvalida EXCEPTION;
    exNrPessoasInvalido EXCEPTION;
    exDiasInvalidos EXCEPTION;

BEGIN
    --validar o tipo de quarto . raises no_data_found se nao existir
    SELECT id
    INTO vIdTipoQuarto
    FROM tipo_quarto
    WHERE nome = pTipoQuarto;

    -- determina a quantidade maxima de pessoas que podem ficar num certo tipo de quarto
    SELECT MAX(q.LOTACAO_MAXIMA)
    INTO vMaxNrPessoas
    FROM QUARTO q
             INNER JOIN TIPO_QUARTO TQ on TQ.ID = q.ID_TIPO_QUARTO
    WHERE TQ.NOME = pTipoQuarto;

    -- número de dias tem de ser pelo menos 1
    IF (pDias <= 0) THEN
        RAISE exDiasInvalidos;
    END IF;
    -- se a data for passada nao pode fazer uma reserva
    IF pData < (sysdate) THEN
        RAISE exDataInvalida;
    END IF;
    -- o numero de pessoas tem de ser maior que 0 e estar dentro do limite para o tipo de quarto
    IF ((pNnrPessoas <= 0) OR (pNnrPessoas >= vMaxNrPessoas)) THEN
        RAISE exNrPessoasInvalido;
    END IF;
    --valida a existencia de reservas livres. nr de quartos livres para aquele tipo de quarto nas datas
    SELECT COUNT (r.ID)
    INTO vQuantidadeVagas
    FROM reserva r
    WHERE r.ID_TIPO_QUARTO = vIdTipoQuarto AND pData <= r.DATA_SAIDA AND pData + pdias >= r.DATA_ENTRADA;

    -- quartos totais disponiveis
    SELECT
        COUNT(*)
    INTO vQuantidadeQuartos
    FROM
        quarto        q
    WHERE q.id_tipo_quarto = vIdTipoQuarto;

    --verifica se ha lugar para a reserva na "lista" de vagas
    IF vQuantidadeVagas >= vQuantidadeQuartos THEN
        RETURN false;
    ELSE
        RETURN true;
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Tipo de quarto inválido');
        RETURN NULL;
    WHEN exDataInvalida THEN
        dbms_output.put_line('Data inválida');
        RETURN NULL;
    WHEN exNrPessoasInvalido THEN
        dbms_output.put_line('Número de pessoas inválido');
        RETURN NULL;
    WHEN exDiasInvalidos THEN
        dbms_output.put_line('Número de dias inválido');
        RETURN NULL;
END;
/

CREATE OR REPLACE FUNCTION ToPrint(b IN BOOLEAN)
    RETURN VARCHAR IS
BEGIN
    RETURN
        CASE b
            WHEN TRUE THEN 'TRUE'
            WHEN FALSE THEN 'FALSE'
            ELSE 'NULL'
            END;
END;

DECLARE
    b Boolean;
BEGIN
    b := fncdisponibilidadereserva('Tipo quarto 7', to_date('2020-12-19', 'YYYY-MM-DD'), 2, 1);
    DBMS_OUTPUT.PUT_LINE(ToPrint(b));

    b := fncdisponibilidadereserva('Tipo quarto 1', to_date('2020-11-19', 'YYYY-MM-DD'), 2, 1);
    DBMS_OUTPUT.PUT_LINE(ToPrint(b));

    b := fncdisponibilidadereserva('Tipo quarto 1', to_date('2021-12-12', 'YYYY-MM-DD'), 2, 1);
    DBMS_OUTPUT.PUT_LINE(ToPrint(b));

    b := fncdisponibilidadereserva('Tipo quarto 1', to_date('2020-12-25', 'YYYY-MM-DD'), 3, 1);
    DBMS_OUTPUT.PUT_LINE(ToPrint(b));

     b := fncdisponibilidadereserva('Tipo quarto 1', to_date('2020-12-26', 'YYYY-MM-DD'), 3, 10);
    DBMS_OUTPUT.PUT_LINE(ToPrint(b));
END;
/

--SET SERVEROUTPUT on;

/*insert into epoca(id, nome, data_ini, data_fim) values(5, 'Época 1', to_date('2021-01-01', 'yyyy-mm-dd'), to_date('2021-03-31', 'yyyy-mm-dd'));
insert into epoca(id, nome, data_ini, data_fim) values(6, 'Época 2', to_date('2021-04-01', 'yyyy-mm-dd'), to_date('2021-06-30', 'yyyy-mm-dd'));
insert into epoca(id, nome, data_ini, data_fim) values(7, 'Época 3', to_date('2021-07-01', 'yyyy-mm-dd'), to_date('2021-09-30', 'yyyy-mm-dd'));
insert into epoca(id, nome, data_ini, data_fim) values(8, 'Época 4', to_date('2021-09-01', 'yyyy-mm-dd'), to_date('2021-12-31', 'yyyy-mm-dd'));*/

