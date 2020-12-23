--sequences
--select * from user_sequences;
declare
  v_cmd varchar(2000);
begin
  for r in (select sequence_name from user_sequences)
  loop
    v_cmd := 'drop sequence ' || r.sequence_name;
    execute immediate(v_cmd);
  end loop;
  --
  for r in (select table_name from user_tables)
  loop
    v_cmd := 'create sequence seq_' || r.table_name;
    execute immediate(v_cmd);
  end loop;
end;
/

--Países
declare
  v_count int := 3;
  v_label varchar(50) := 'País';
begin
  for i in 1..v_count loop
    insert into pais(id, nome) values(seq_pais.nextval, v_label || ' ' || i);
  end loop;
end;
/

--Distritos
declare
  v_count int := 5;
  v_label varchar(50) := 'Distrito';
begin
  for r in (select id, nome from pais) loop
    for i in 1..v_count loop
      insert into distrito(id, id_pais, nome) values(seq_distrito.nextval, r.id, v_label || ' ' || i || ' ' || r.nome);
    end loop;
  end loop;
end;
/

--Concelhos
declare
  v_count int := 5;
  v_label varchar(50) := 'Concelho';
begin
  for r in (select id, nome from distrito) loop
    for i in 1..v_count loop
      insert into concelho(id, id_distrito, nome) values(seq_concelho.nextval, r.id, v_label || ' ' || i || ' ' || r.nome);
    end loop;
  end loop;
end;
/

--Localidades
declare
  v_count int := 5;
  v_label varchar(50) := 'Localidade';
begin
  for r in (select id, nome from concelho) loop
    for i in 1..v_count loop
      insert into localidade(id, id_concelho, nome) values(seq_localidade.nextval, r.id, v_label || ' ' || i || ' ' || r.nome);
    end loop;
  end loop;
end;
/

--Códigos postais
declare
  v_count int := 5;
  v_label varchar(20) := 'Código Postal';
begin
  for r in (select id, nome from localidade) loop
    for i in 1..v_count loop
      insert into codigo_postal(id, id_localidade, designacao_postal) values(seq_codigo_postal.nextval, r.id, v_label || ' ' || i || ' ' || r.nome);
    end loop;
  end loop;
end;
/

--Andares
declare
  v_count int := 3;
  v_label varchar(50) := 'Andar';
begin
  for i in 1..v_count loop
    insert into andar(id, nr_andar, nome) values(seq_andar.nextval, i, v_label || ' ' || i);
  end loop;
end;
/

--Tipos de quarto
declare
  v_count int := 3;
  v_label varchar(50) := 'Tipo quarto';
begin
  for i in 1..v_count loop
    insert into tipo_quarto(id, nome) values(seq_tipo_quarto.nextval, v_label || ' ' || i);
  end loop;
end;
/

--Quartos
declare
  v_count int := 7;
  v_label varchar(20) := 'Quarto';
  cursor c_tq is select id from tipo_quarto order by 1;
  r_tq c_tq%rowtype;
  v_id_tipo_quarto tipo_quarto.id%type;
  v_lotacao int;
begin
  for r in (select id, nome from andar) loop
    for i in 1..v_count loop
      if not c_tq%isopen then
        open c_tq;
      end if;
      fetch c_tq into r_tq;
      if c_tq%found then
        v_id_tipo_quarto := r_tq.id;
      else
        close c_tq;
        open c_tq;
        fetch c_tq into r_tq;
        v_id_tipo_quarto := r_tq.id;
      end if;
      --
      v_lotacao := mod(r.id * i, 3) + 2;
      insert into quarto(id, id_andar, nr_quarto, id_tipo_quarto, lotacao_maxima)
      values(seq_quarto.nextval, r.id, i, v_id_tipo_quarto, v_lotacao);
    end loop;
  end loop;
end;
/

--Clientes
declare
  v_count int := 500;
  v_label varchar(50) := 'Cliente';
  cursor c is select id from localidade order by 1;
  r c%rowtype;
begin
  for i in 1..v_count loop
    if not c%isopen then
      open c;
    end if;
    fetch c into r;
    if not c%found then
      close c;
      open c;
      fetch c into r;
    end if;
    --
    insert into cliente(id, nome, nif, id_localidade, email, telefone)
    values(seq_cliente.nextval, v_label || ' ' || i, i, r.id, null, null);
  end loop;
end;
/

--Tipos de funcionários
insert into tipo_funcionario(id, nome) values(1, 'Manutenção');
insert into tipo_funcionario(id, nome) values(2, 'Camareira');
insert into tipo_funcionario(id, nome) values(3, 'Bar');
insert into tipo_funcionario(id, nome) values(4, 'Receção');

--Funcionários
declare
  v_count int := 10;
  v_label varchar(50) := 'Funcionário';
begin
  for r in (select * from tipo_funcionario order by 1) loop
    for i in 1..v_count loop
      insert into funcionario(id, nif, nome, id_tipo_funcionario) values(seq_funcionario.nextval, seq_funcionario.currval, r.nome || ' ' || i, r.id);
    end loop;
  end loop;
end;
/

--Funcionários de manutenção.
declare
  v_id_responsavel funcionario.id%type;
begin
  for r in (select * from funcionario where id_tipo_funcionario = 1) loop
    insert into funcionario_manutencao(id, id_responsavel, telefone) values(r.id, v_id_responsavel, r.id);
    v_id_responsavel := r.id;
  end loop;
end;
/

--Camareiras.
begin
  for r in (select * from funcionario where id_tipo_funcionario = 2) loop
    insert into camareira(id) values(r.id);
  end loop;
end;
/

--Artigos de consumo
declare
  v_count int := 30;
  v_label varchar(50) := 'Artigo consumo';
  v_preco number;
begin
  for i in 1..v_count loop
    insert into artigo_consumo(id, nome, preco) values(seq_artigo_consumo.nextval, v_label || ' ' || i, mod(v_count, i)+1);
  end loop;
end;
/

--Modos de pagamento
insert into modo_pagamento(id, nome) values(1, 'Numerário');
insert into modo_pagamento(id, nome) values(2, 'Cheque');
insert into modo_pagamento(id, nome) values(3, 'Cartão de crédito');
insert into modo_pagamento(id, nome) values(4, 'Cartão de débito');

--Estados reserva
insert into estado_reserva(id, nome) values(1, 'Aberta');
insert into estado_reserva(id, nome) values(2, 'Check-in');
insert into estado_reserva(id, nome) values(3, 'Check-out');
insert into estado_reserva(id, nome) values(4, 'Cancelada');
insert into estado_reserva(id, nome) values(5, 'Finalizada');

declare
  v_count int := 30;
  v_label varchar(50) := 'Artigo consumo';
  v_preco number;
begin
  for i in 1..v_count loop
    insert into artigo_consumo(id, nome, preco) values(seq_artigo_consumo.nextval, v_label || ' ' || i, mod(v_count, i)+1);
  end loop;
end;
/

--Épocas
insert into epoca(id, nome, data_ini, data_fim) values(1, 'Época 1', to_date('2020-01-01', 'yyyy-mm-dd'), to_date('2020-03-31', 'yyyy-mm-dd'));
insert into epoca(id, nome, data_ini, data_fim) values(2, 'Época 2', to_date('2020-04-01', 'yyyy-mm-dd'), to_date('2020-06-30', 'yyyy-mm-dd'));
insert into epoca(id, nome, data_ini, data_fim) values(3, 'Época 3', to_date('2020-07-01', 'yyyy-mm-dd'), to_date('2020-09-30', 'yyyy-mm-dd'));
insert into epoca(id, nome, data_ini, data_fim) values(4, 'Época 4', to_date('2020-09-01', 'yyyy-mm-dd'), to_date('2020-12-31', 'yyyy-mm-dd'));

insert into epoca(id, nome, data_ini, data_fim) values(5, 'Época 1', to_date('2021-01-01', 'yyyy-mm-dd'), to_date('2021-03-31', 'yyyy-mm-dd'));
insert into epoca(id, nome, data_ini, data_fim) values(6, 'Época 2', to_date('2021-04-01', 'yyyy-mm-dd'), to_date('2021-06-30', 'yyyy-mm-dd'));
insert into epoca(id, nome, data_ini, data_fim) values(7, 'Época 3', to_date('2021-07-01', 'yyyy-mm-dd'), to_date('2021-09-30', 'yyyy-mm-dd'));
insert into epoca(id, nome, data_ini, data_fim) values(8, 'Época 4', to_date('2021-09-01', 'yyyy-mm-dd'), to_date('2021-12-31', 'yyyy-mm-dd'));

--Preços por época e tipo de quarto
declare
  v_preco number;
begin
  for r1 in (select * from epoca) loop
    for r2 in (select * from tipo_quarto) loop
      v_preco := mod(r1.id*r2.id*10, 20)+30;
      insert into preco_epoca_tipo_quarto(id_epoca, id_tipo_quarto, preco) values(r1.id, r2.id, v_preco);
    end loop;
  end loop;
end;
/

insert into tipo_intervencao(id, nome) values(1, 'Limpeza');
insert into tipo_intervencao(id, nome) values(2, 'Manutenção');

--reservas (N por cada dia, de 1-1-2020 até 31-12-2020)
declare
  k_count int := 10;
  v_count int;
  v_label varchar(50) := 'Reserva';
  v_di date;
  v_df date;
  v_d date;
  v_id_cliente cliente.id%type;
  v_step int := 7; --de K em K reservas escolho efetivamente um cliente.
  v_id_reserva int;
  v_nr_pessoas int;
  v_id_tipo_quarto int;
  v_dias int;
  v_lag_dias int;
  v_preco number;
begin
  delete from reserva;
  v_di := to_date('2020-01-01', 'yyyy-mm-dd');
  v_df := to_date('2020-12-31', 'yyyy-mm-dd');
  v_d := v_di;
  while v_d < v_df loop
    for i in 1..k_count loop
      v_id_reserva := seq_reserva.nextval;
      --gerar alguns clientes
      select count(0) into v_count from cliente;
      v_id_cliente := mod(v_count, v_id_reserva-(trunc(v_id_reserva/v_count))*v_count);
      if v_id_cliente <= 10 then v_id_cliente := null; end if;
      --tipo de quarto é obtido ciclicamente
      select count(0) into v_count from tipo_quarto;
      v_id_tipo_quarto := mod(v_id_reserva, v_count)+1;
      --Nº de dias da reserva é obtido ciclicamente.
      v_dias := mod(v_id_reserva, 3)+1;
      v_lag_dias := mod(v_id_reserva, 30);
      --Nº de pessoas(1 até 4)
      v_nr_pessoas := mod(v_id_reserva, 4) + 1;
      --Preço
      begin
        select a.preco into v_preco
          from preco_epoca_tipo_quarto a join epoca b on (a.id_epoca = b.id)
         where id_tipo_quarto = v_id_tipo_quarto
           and v_d+v_lag_dias between b.data_ini and b.data_fim; 
      exception
        when others then
          v_preco := 35;
      end;
      --
      insert into reserva(id, id_cliente, nome, id_tipo_quarto, data, data_entrada, data_saida, nr_pessoas, preco, id_estado_reserva)
      values(v_id_reserva, v_id_cliente, 'Cliente reserva '||v_id_reserva, v_id_tipo_quarto, v_d, v_d+v_lag_dias, v_d+v_lag_dias+v_dias, v_nr_pessoas, v_preco*v_dias, 1);
    end loop;
    ----
    v_d := v_d + 1;
  end loop;
end;
/

--Checkins
create or replace function isQuartoIndisponivel(p_id_quarto int, p_data date) return boolean
is
  v_count int;
begin
  select count(*) into v_count
    from checkin a left join checkout b on (a.id_reserva = b.id_reserva)
   where a.id_quarto = p_id_quarto
     and ((a.data >= trunc(p_data) and b.data is null)  --tenho checkin mas n?o tenho checkout
          or
          (a.data <= trunc(p_data) and b.data >= trunc(p_data)));
  return (v_count > 0);
end;
/

declare
  v_data_ref date := to_date('2020-11-30', 'yyyy-mm-dd');
  cursor ca is select * from artigo_consumo order by 1;
  ra ca%rowtype;
  cursor cc is select * from camareira order by 1;
  rc cc%rowtype;
begin
  for r1 in (select * from reserva where data_entrada < v_data_ref and data_saida <= v_data_ref)
  loop
    for r2 in (select * from quarto where id_tipo_quarto = r1.id_tipo_quarto order by id) loop
      if not isQuartoIndisponivel(r2.id, r1.data_entrada) then
        insert into checkin(id_reserva, data, id_quarto) values (r1.id, r1.data_entrada, r2.id);
        insert into checkout(id_reserva, data) values (r1.id, r1.data_saida);
        insert into conta_consumo(id, data_abertura, id_reserva) values(seq_conta_consumo.nextval, r1.data_entrada, r1.id);
        if not ca%isopen then
          open ca;
        end if;
        fetch ca into ra;
        if ca%notfound then
          close ca;
          open ca;
          fetch ca into ra;
        end if;
        if not cc%isopen then
          open cc;
        end if;
        fetch cc into rc;
        if cc%notfound then
          close cc;
          open cc;
          fetch cc into rc;
        end if;
        insert into linha_conta_consumo(id_conta_consumo, linha, id_artigo_consumo, data_registo, quantidade, preco_unitario, id_camareira)
        values(seq_conta_consumo.currval, 1, ra.id, r1.data_entrada, 1, ra.preco, rc.id);
         update reserva set id_estado_reserva = 2 where id = r1.id;
        exit;
      end if;
    end loop;
  end loop;
end;
/

INSERT INTO CONTA_CONSUMO VALUES (30000,to_date('2019-09-06', 'yyyy-mm-dd'),408);
INSERT INTO LINHA_CONTA_CONSUMO VALUES (30000,1,1,to_date('2019-09-06', 'yyyy-mm-dd'),1,4,11);

INSERT INTO LINHA_CONTA_CONSUMO VALUES (30000,2,1,to_date('2019-09-08', 'yyyy-mm-dd'),1,505,11);

INSERT INTO CONTA_CONSUMO VALUES (30001,to_date('2019-09-06', 'yyyy-mm-dd'),408);
INSERT INTO LINHA_CONTA_CONSUMO VALUES (30001,1,1,to_date('2019-09-06', 'yyyy-mm-dd'),1,505,12);

INSERT INTO LINHA_CONTA_CONSUMO VALUES (30001,2,1,to_date('2019-09-08', 'yyyy-mm-dd'),1,505,12);

--
commit;
