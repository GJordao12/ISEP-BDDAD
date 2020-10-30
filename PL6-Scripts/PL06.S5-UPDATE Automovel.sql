-- ** atualizar tabelas **

-- ## Tabela Automovel ##

--1)    Reduzir 20% o pre�o de venda do autom�vel da marca Kia; 
UPDATE automovel SET precoVenda = precoVenda * 0.8 WHERE UPPER(marca) LIKE 'KIA';

--2)    Verificar a atualiza��o do registo da marca Kia;
SELECT * FROM automovel;

--3)    Reduzir 10% o pre�o de venda dos autom�veis com ano de fabrico posterior a 2009; 
UPDATE automovel SET precoVenda = precoVenda * 0.9 WHERE UPPER(anoFabrico) > 2009;

--4)    Verificar a atualiza��o de v�rios registos da tabela automovel;
SELECT * FROM automovel;


-- ** guardar em DEFINITIVO as altera��es na base de dados, se a op��o Autocommit do SQL Developer n�o estiver ativada **
-- COMMIT;
