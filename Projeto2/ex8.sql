create or replace procedure prcRegistarReserva(pTipoQuarto tipo_Quarto.nome%type,
                                               pDataEntrada reserva.data_Entrada%type,
                                               pDataSaida reserva.data_saida%type,
                                               pNPessoas Integer,

                                               pIdCliente Cliente.id%type := null,
                                               pNomeCliente Cliente.nome%type := null,
                                               pNifCliente Cliente.nif%type := null,
                                               pTelefoneCliente Cliente.TELEFONE%type := null,
                                               pEmailCliente Cliente.EMAIL%type := null) is
    exParametrosErrados EXCEPTION;
    vIdTipoQuarto NUMBER;
    vIdEstadoReserva NUMBER;
    vPreco      NUMBER(6,2);
    vEpoca      NUMBER;
    vAdded boolean:=false;

BEGIN
    --verificacao de parametros
    if (pIdCliente IS NOT NULL AND ( pNomeCliente IS NOT NULL  OR  pNifCliente IS NOT NULL OR pTelefoneCliente IS NOT NULL OR pEmailCliente IS NOT NULL )) then
        raise exParametrosErrados;
    end if;

    --verificacao de parametros
    if (pIdCliente IS NULL and pNomeCliente IS NULL) then
        raise exParametrosErrados;
    end if;

    if (pIdCliente IS not NULL and pNomeCliente IS not NULL) then
        raise exParametrosErrados;
    end if;

    --ver a epoca apartir das datas
    select id into vEpoca from EPOCA where DATA_FIM >= pDataSaida AND DATA_INI <= pDataEntrada;

    --calcular o preço para inserir na reserva
    select preco
    into vPreco
    from PRECO_EPOCA_TIPO_QUARTO
         inner join TIPO_QUARTO on PRECO_EPOCA_TIPO_QUARTO.ID_TIPO_QUARTO = TIPO_QUARTO.ID
    where ID_EPOCA = vEpoca
      AND TIPO_QUARTO.NOME = pTipoQuarto;

    --get id_tipo_quarto by nome tipo quarto
    select id into vIdTipoQuarto from Tipo_Quarto tq where tq.NOME like pTipoQuarto;

    --get id estado reserva
    select id into vIdEstadoReserva from ESTADO_RESERVA where nome='Aberta';

    if (FNCDISPONIBILIDADERESERVA(pTipoQuarto, pDataEntrada, pDataSaida - pDataEntrada, pNPessoas)) then
        insert into RESERVA
        values (seq_reserva.nextval, pIdCliente, pNomeCliente, pNifCliente, pEmailCliente,
                pTelefoneCliente, vIdTipoQuarto,
                sysdate, pDataEntrada, pDataSaida, pNPessoas, vPreco, vIdEstadoReserva, null, null);
        vAdded := true;
    end if;

    if (vAdded)then
    dbms_output.put_line('Adicionado!');
    else
        dbms_output.put_line('Falhou!');
    end if;


EXCEPTION
   WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Erro');
    WHEN exParametrosErrados THEN
        dbms_output.put_line('Parametros errados');

end;
/

begin
--prcRegistarReserva('Tipo quarto 1',to_date('2020-12-25', 'YYYY-MM-DD'),to_date('2020-12-28', 'YYYY-MM-DD'),1,null,'Cliente 47',null);
--prcRegistarReserva('Tipo quarto 1',to_date('2021-12-25', 'YYYY-MM-DD'),to_date('2021-12-28', 'YYYY-MM-DD'),1,47);
--prcRegistarReserva('Tipo quarto 1',to_date('2020-12-25', 'YYYY-MM-DD'),to_date('2020-12-28', 'YYYY-MM-DD'),1,47,'Cliente 47',null);

prcregistarreserva('Tipo quarto 1', to_date('2020-12-26', 'YYYY-MM-DD'), to_date('2020-12-29', 'YYYY-MM-DD'), 1, 47,'Cliente 47', 45);
prcregistarreserva('Tipo quarto 1',to_date( '2021-01-01', 'YYYY-MM-DD'), to_date('2021-01-03', 'YYYY-MM-DD'), 1, 47);
prcregistarreserva('Tipo quarto 1',to_date( '2020-12-25', 'YYYY-MM-DD'),to_date( '2020-12-29', 'YYYY-MM-DD'), 1, NULL,'Cliente 47', NULL);
prcregistarreserva('Tipo quarto 1',to_date( '2021-01-02', 'YYYY-MM-DD'), to_date('2021-12-05', 'YYYY-MM-DD'), 1, 47,NULL, 45);
prcregistarreserva('Tipo quarto 1',to_date( '2020-12-25', 'YYYY-MM-DD'), to_date('2020-12-28', 'YYYY-MM-DD'), 1, NULL,NULL, 45);
prcregistarreserva('Tipo quarto 1',to_date( '2021-12-15', 'YYYY-MM-DD'), to_date('2021-12-21', 'YYYY-MM-DD'), 1, 47);


end;
