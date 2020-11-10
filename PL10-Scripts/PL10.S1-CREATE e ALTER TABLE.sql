-- ** eliminar tabelas se existentes **
-- CASCADE CONSTRAINTS para eliminar as restri��es de integridade das chaves prim�rias e chaves �nicas
-- PURGE elimina a tabela da base de dados e da "reciclagem"
DROP TABLE marinheiro  CASCADE CONSTRAINTS PURGE;
DROP TABLE barco       CASCADE CONSTRAINTS PURGE;
DROP TABLE reserva     CASCADE CONSTRAINTS PURGE;

-- ## tabela Marinheiro ##
CREATE TABLE marinheiro(
  idMarinheiro 	    INTEGER 	CONSTRAINT pkMarinheiroIdMarinheiro     PRIMARY KEY,
  nome 	            VARCHAR(30)	CONSTRAINT nnMarinheiroNome             NOT NULL,
  classificacao 	INTEGER		CONSTRAINT nnMarinheiroClassificacao    NOT NULL,
  dataNascimento    DATE	    CONSTRAINT nnMarinheiroDataNascimento   NOT NULL
);

-- ## tabela Barco ##
CREATE TABLE barco(
  idBarco 	    INTEGER     CONSTRAINT pkBarcoIdBarco       PRIMARY KEY,
  designacao    VARCHAR(20) CONSTRAINT nnBarcoDesignacao    NOT NULL,
  cor           VARCHAR(10) CONSTRAINT nnBarcoCor           NOT NULL
);

-- ## tabela Reserva ##
CREATE TABLE reserva(
  idMarinheiro  INTEGER,
  idBarco 	    INTEGER,
  data 	        DATE        CONSTRAINT nnReservaData  NOT NULL, 
  
  CONSTRAINT pkReservaIdMarinheiroIdBarcoData PRIMARY KEY(idMarinheiro, idBarco, data)
);

-- ** alterar tabelas para defini��o de chaves estrangeiras **
ALTER TABLE reserva ADD CONSTRAINT fkReservaIdMarinheiro FOREIGN KEY (idMarinheiro) REFERENCES marinheiro(idMarinheiro);
ALTER TABLE reserva ADD CONSTRAINT fkReservaIdBarco      FOREIGN KEY (idBarco)      REFERENCES barco(idBarco);

-- ** guardar em DEFINITIVO as altera��es na base de dados, se a op��o Autocommit do SQL Developer n�o estiver ativada **
-- COMMIT;