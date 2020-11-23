-- ** alterar tabelas, adicionando campos **

-- ## Tabela Revisao ##

--1)    Eliminar a restri��o de chave prim�ria natural da tabela Revisao; 
ALTER TABLE revisao DROP CONSTRAINT pkRevisaoMatriculaDataHoraMarcacao;

--2)    Adicionar o novo campo idRevisao para armazenar valores inteiros positivos gerados automaticamente (auto-incrementados); 
ALTER TABLE revisao ADD idRevisao INTEGER GENERATED AS IDENTITY; 

--3)    Especificar o novo campo idRevisao como chave prim�ria artificial;
ALTER TABLE revisao ADD CONSTRAINT pkRevisaoNrRevisao PRIMARY KEY(idRevisao);

--4)    Adicionar um registo com a mesma matricula e a data_hora_marcacao de outro registo;
INSERT INTO revisao(matricula, dataHoraMarcacao)
VALUES('42-90-AS', TO_TIMESTAMP('2018/10/23 10:50:00', 'yyyy/mm/dd hh24:mi:ss'));

--5)    Verificar a presen�a do novo registo na tabela, violando a referida correspond�ncia un�voca entre as chaves prim�rias, 
--      natural e artificial;
SELECT *
FROM revisao
ORDER BY matricula;

--6)    Eliminar o registo adicionado anteriormente.
DELETE FROM revisao WHERE idRevisao='7';

--7)	Resolver o problema indicado na al�nea 5, adicionando uma restri��o que garanta combina��es �nicas dos campos matricula 
--      e dataHoraMarcacao;
ALTER TABLE revisao ADD CONSTRAINT ukRevisaoMatriculaDataHoraMarcacao UNIQUE(matricula, dataHoraMarcacao);

--8)	Testar a nova restri��o imposta, repetindo a al�nea 4;

--9)	Adicionar dois registos, um com valor NULL no campo matricula e outro com valor NULL no campo dataHoraMarcacao;
INSERT INTO revisao(matricula, dataHoraMarcacao)
VALUES(NULL, TO_TIMESTAMP('2018/10/23 10:50:00', 'yyyy/mm/dd hh24:mi:ss'));

INSERT INTO revisao(matricula, dataHoraMarcacao)
VALUES('42-90-AS', NULL);

--10)	Verificar que os dois registos foram adicionados � tabela, violando a chave prim�ria natural;
SELECT *
FROM revisao
ORDER BY matricula;

--11)	Resolver o problema verificado, come�ando por eliminar os dois registos adicionados;
DELETE FROM revisao WHERE matricula IS NULL OR datahoramarcacao IS NULL;


--12)	Alterar novamente a tabela de modo a impedir o valor NULL nos campos matricula e dataHoraMarcacao;
ALTER TABLE revisao MODIFY matricula CONSTRAINT nnRevisaoMatricula NOT NULL;
ALTER TABLE revisao MODIFY datahoramarcacao CONSTRAINT nnRevisaoDataHoraMarcacao NOT NULL; 

--13)	Repetir o passo 9 para verificar a resolu��o do problema com o NULL na chave prim�ria natural.


-- ** guardar em DEFINITIVO as altera��es na base de dados, se a op��o Autocommit do SQL Developer n�o estiver ativada **
-- COMMIT;
