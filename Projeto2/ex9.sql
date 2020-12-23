CREATE OR REPLACE TRIGGER trgatualizacliente
    BEFORE INSERT
    ON RESERVA
    FOR EACH ROW
DECLARE

    vIdCliente       INTEGER := :new.ID_CLIENTE;
    vNomeCliente     VARCHAR2(150);
    vEmailCliente    VARCHAR2(150);
    vTelefoneCliente VARCHAR2(150);
    vNifCliente      VARCHAR2(150);


BEGIN

    SELECT c.nome, c.nif, c.telefone, c.email
    INTO vNomeCliente,vNifCliente,vTelefoneCliente,vEmailCliente
    FROM cliente c
    WHERE c.id = vIdCliente;

    :new.email := vEmailCliente;
    :new.nome := vNomeCliente;
    :new.nif := vNifCliente;
    :new.telefone := vTelefoneCliente;


END trgatualizacliente;
/

INSERT INTO reserva (id, id_cliente, nome, nif, email, telefone, id_tipo_quarto, data, data_entrada, data_saida,
                     nr_pessoas, preco, id_estado_reserva, custo_cancelamento, custo_extra)
VALUES (seq_reserva.NEXTVAL, 47, NULL, NULL, NULL, NULL, 1, TO_DATE('2020-12-10', 'yyyy-mm-dd'),
        TO_DATE('2020-12-20', 'yyyy-mm-dd'), TO_DATE('2020-12-29', 'yyyy-mm-dd'), 2, NULL, NULL, NULL, NULL);