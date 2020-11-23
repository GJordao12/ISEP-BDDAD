-- ** eliminar tabelas se existentes **
-- CASCADE CONSTRAINTS para eliminar as restri��es de integridade das chaves prim�rias e chaves �nicas
-- PURGE elimina a tabela da base de dados e da "reciclagem"
DROP TABLE revisao           CASCADE CONSTRAINTS PURGE;
DROP TABLE automovelCliente  CASCADE CONSTRAINTS PURGE;
DROP TABLE cliente           CASCADE CONSTRAINTS PURGE;
DROP TABLE automovel         CASCADE CONSTRAINTS PURGE;

-- ** criar tabelas **
-- ## tabela Automovel ##
CREATE TABLE automovel (
    matricula   CHAR(8)         CONSTRAINT pkAutomovelMatricula     PRIMARY KEY,                            
    marca       VARCHAR(40)     CONSTRAINT nnAutomovelMarca         NOT NULL,
    cilindrada  INTEGER         CONSTRAINT nnAutomovelCilindrada    NOT NULL
                                CONSTRAINT ckAutomovelCilindrada    CHECK(cilindrada BETWEEN 1000 AND 6000),
    anoFabrico  INTEGER         CONSTRAINT nnAutomovelAnoFabrico    NOT NULL 
                                CONSTRAINT ckAutomovelAnoFabrico    CHECK (anoFabrico >= 2000 AND anoFabrico <= 2020),
    precoVenda  NUMERIC(10,2)   CONSTRAINT nnAutomovelPrecoVenda    NOT NULL 
                                CONSTRAINT ckAutomovelPrecoVenda    CHECK (precoVenda > 0),
                           
    CONSTRAINT ckAutomovelMatricula CHECK (REGEXP_LIKE(matricula, '^\d{2}-[A-Z]{2}-\d{2}$|^\d{2}-\d{2}-[A-Z]{2}$|^[A-Z]{2}-\d{2}-\d{2}$'))
    --alternativa
--    CONSTRAINT ckAutomovelMatricula CHECK (REGEXP_LIKE(matricula, '[0-9]{2}-[A-Z]{2}-[0-9]{2}|[0-9]{2}-[0-9]{2}-[A-Z]{2}|[A-Z]{2}-[0-9]{2}-[0-9]{2}'))
);

-- ## tabela Cliente ##
CREATE TABLE cliente (
    idCliente               INTEGER GENERATED AS IDENTITY   CONSTRAINT pkClienteIdCliente               PRIMARY KEY,
    nome                    VARCHAR(40)                     CONSTRAINT nnClienteNome                    NOT NULL,
    nrIdentificacaoCivil    INTEGER                         CONSTRAINT ckClienteNrIdentificacaoCivil    CHECK(REGEXP_LIKE(nrIdentificacaoCivil, '^\d{6,}$'))
                                                            CONSTRAINT ukClienteNrIdentificacaoCivil    UNIQUE,
    nif                     INTEGER                         CONSTRAINT nnClienteNif                     NOT NULL
                                                            CONSTRAINT ckClienteNif                     CHECK(REGEXP_LIKE(nif, '^\d{9}$'))
                                                            CONSTRAINT ukClienteNif                     UNIQUE,
    dataNascimento          DATE                            CONSTRAINT nnClienteDataNascimento          NOT NULL
);

-- ## tabela AutomovelCliente ##
CREATE TABLE automovelCliente (
    matricula  CHAR(8),
    idCliente  INTEGER,
    
    CONSTRAINT pkAutomovelClienteMatriculaIdCliente   PRIMARY KEY (matricula, idCliente)
);

-- ** alterar tabelas para defini��o de chaves estrangeiras **
-- ## tabela AutomovelCliente ##
ALTER TABLE automovelCliente ADD CONSTRAINT fkAutomovelClienteMatricula FOREIGN KEY (matricula) REFERENCES automovel (matricula);
ALTER TABLE automovelCliente ADD CONSTRAINT fkAutomovelClienteIdCliente FOREIGN KEY (idCliente) REFERENCES cliente (idCliente);

CREATE TABLE revisao (
    matricula CHAR(8),
    dataHoraMarcacao DATE,
    efetuada CHAR(1) DEFAULT 'N' CONSTRAINT ckRevisaoEfetuada NOT NULL CHECK(REGEXP_LIKE(efetuada,'S') OR REGEXP_LIKE(efetuada, 'N') OR REGEXP_LIKE(efetuada,'s') OR REGEXP_LIKE(efetuada, 'n')),
                                 
    CONSTRAINT pkRevisaoMatriculaDataHoraMarcacao PRIMARY KEY (matricula, dataHoraMarcacao)
);

ALTER TABLE revisao ADD CONSTRAINT fkRevisaoMatricula FOREIGN KEY (matricula) REFERENCES automovel (matricula);

--se necess�rio por causa de problemas com o  REGEXP_LIKE
--ALTER SESSION SET NLS_SORT=BINARY;

-- ** guardar em DEFINITIVO as altera��es na base de dados, se a op��o Autocommit do SQL Developer n�o estiver ativada **
-- COMMIT; 

