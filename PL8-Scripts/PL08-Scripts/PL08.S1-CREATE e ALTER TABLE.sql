-- ** eliminar tabelas se existentes **
-- CASCADE CONSTRAINTS para eliminar as restrições de integridade das chaves primárias e chaves únicas
-- PURGE elimina a tabela da base de dados e da "reciclagem"

DROP TABLE empregado                CASCADE CONSTRAINTS PURGE;
DROP TABLE empregadoEfetivo         CASCADE CONSTRAINTS PURGE;
DROP TABLE empregadoTemporario      CASCADE CONSTRAINTS PURGE;
DROP TABLE falta                    CASCADE CONSTRAINTS PURGE;
DROP TABLE ferias                   CASCADE CONSTRAINTS PURGE;
DROP TABLE avaliacao                CASCADE CONSTRAINTS PURGE;
DROP TABLE avaliacaoTemporario      CASCADE CONSTRAINTS PURGE;
DROP TABLE avaliacaoEfetivo         CASCADE CONSTRAINTS PURGE;
DROP TABLE departamento             CASCADE CONSTRAINTS PURGE;
DROP TABLE empregadoDepartamento    CASCADE CONSTRAINTS PURGE;

-- ** criação de tabelas **

CREATE TABLE empregado (
    idEmpregado             INTEGER GENERATED AS IDENTITY   CONSTRAINT pkEmpregadoIdEmpregado           PRIMARY KEY,
    nome                    VARCHAR(40)                     CONSTRAINT nnEmpregadoNome                  NOT NULL,
    dataNascimento          DATE                            CONSTRAINT nnEmpregadoDataNascimento        NOT NULL,
    nrIdentificacaoCivil    INTEGER                         CONSTRAINT ckEmpregadoNrIdentificacaoCivil  CHECK(REGEXP_LIKE(nrIdentificacaoCivil, '^\d{6,}$'))
                                                            CONSTRAINT ukEmpregadoNrIdentificacaoCivil  UNIQUE,
    nif                     INTEGER                         CONSTRAINT nnEmpregadoNif                   NOT NULL
                                                            CONSTRAINT ckEmpregadoNif                   CHECK(REGEXP_LIKE(nif, '^\d{9}$'))
                                                            CONSTRAINT ukEmpregadoNif                   UNIQUE
);

CREATE TABLE empregadoEfetivo (
    idEmpregado         INTEGER         CONSTRAINT pkEmpregadoEfetivoIdEmpregado   PRIMARY KEY,
    salarioMensalBase   NUMERIC(10,2)   CONSTRAINT nnEmpregadoEfetivoSalarioMensalBase   NOT NULL
                                        CONSTRAINT ckEmpregadoEfetivoSalarioMensalBase   CHECK (salarioMensalBase >= 500)
);

CREATE TABLE empregadoTemporario (
    idEmpregado INTEGER         CONSTRAINT pkEmpregadoTemporarioIdEmpregado PRIMARY KEY,
    salarioHora NUMERIC(4,2)    CONSTRAINT nnEmpregadoTemporarioSalarioHora NOT NULL
);

CREATE TABLE falta (
    idEmpregado     INTEGER,
    dataInicio      DATE,
    dataFim         DATE,
    justificacao    VARCHAR(50),
                            
    CONSTRAINT pkFaltaIdEmpregadoDataInicio PRIMARY KEY (idEmpregado, dataInicio),
    CONSTRAINT ckFaltaDataInicioDataFim     CHECK (dataFim>=dataInicio)
);

CREATE TABLE ferias (
    idEmpregado     INTEGER,
    dataInicio      DATE,
    dataFim         DATE        CONSTRAINT nnFeriasDataFim   NOT NULL,
    
    CONSTRAINT pkFeriasIdEmpregadoDataInicio    PRIMARY KEY (idEmpregado, dataInicio),
    CONSTRAINT ckFeriasDataInicioDataFim        CHECK(dataFim>=dataInicio)
);

CREATE TABLE avaliacao (
    idAvaliacao VARCHAR(3)  CONSTRAINT pkAvaliacaoIdAvaliacao   PRIMARY KEY,
    descricao   VARCHAR(15) CONSTRAINT nnAvaliacaoDescricao     NOT NULL
);

CREATE TABLE avaliacaoTemporario (
    idDepartamento  VARCHAR(5),
    idEmpregado     INTEGER,
    dataInicio      DATE,
    idAvaliacao     VARCHAR(3),
    
    CONSTRAINT pkAvaliacaoTemporarioIdEmpregadoDataInicio   PRIMARY KEY (idDepartamento, idEmpregado, dataInicio)
);

CREATE TABLE avaliacaoEfetivo (
    idEmpregado INTEGER,
    ano         INTEGER     CONSTRAINT ckAvaliacaoEfetivoAno            CHECK(ano>=2015)    NOT NULL,
    idAvaliacao VARCHAR(3)  CONSTRAINT nnAvaliacaoEfetivoIdAvaliacao    NOT NULL,
    
    CONSTRAINT pkAvaliacaoEfetivoIdEmpregadoAno PRIMARY KEY (idEmpregado, ano)
);

CREATE TABLE departamento (
    idDepartamento          VARCHAR(5)  CONSTRAINT pkDepartamentoIdDepartamento PRIMARY KEY,
    idDepartamentoSuperior  VARCHAR(5),
    designacao              VARCHAR(50) CONSTRAINT nnDepartamentoIdDesignacao   NOT NULL
);


CREATE TABLE empregadoDepartamento (
    idDepartamento  VARCHAR(5),
    idEmpregado     INTEGER,
    dataInicio      DATE        CONSTRAINT nnEmpregadoDepartamentoDataInicio  NOT NULL,
    dataFim         DATE,
    
    CONSTRAINT pkEmpregadoDepartamentoIdDepartamentoIdEmpregadoDataInicio PRIMARY KEY (idDepartamento, idEmpregado, dataInicio),
    CONSTRAINT ckEmpregadoDepartamentoDataInicioDataFim                   CHECK(dataFim>=dataInicio)
);


-- ** chaves estrangeiras ** 

ALTER TABLE empregadoEfetivo    ADD CONSTRAINT fkEmpregadoEfetivoIdEmpregado                            FOREIGN KEY (idEmpregado)                               REFERENCES empregado (idEmpregado);

ALTER TABLE empregadoTemporario ADD CONSTRAINT fkEmpregadoTemporarioIdEmpregado                         FOREIGN KEY (idEmpregado)                               REFERENCES empregado (idEmpregado);

ALTER TABLE falta               ADD CONSTRAINT fkFaltaIdEmpregado                                       FOREIGN KEY (idEmpregado)                               REFERENCES empregado (idEmpregado);

ALTER TABLE ferias              ADD CONSTRAINT fkFeriasIdEmpregado                                      FOREIGN KEY (idEmpregado)                               REFERENCES empregadoEfetivo (idEmpregado);

ALTER TABLE avaliacaoTemporario ADD CONSTRAINT fkAvaliacaoTemporarioIdEmpregado                         FOREIGN KEY (idEmpregado)                               REFERENCES empregadoTemporario (idEmpregado);
ALTER TABLE avaliacaoTemporario ADD CONSTRAINT fkAvaliacaoTemporarioIdDepartamentoIdEmpregadoDataInicio FOREIGN KEY (idDepartamento, idEmpregado, dataInicio)   REFERENCES empregadoDepartamento (idDepartamento, idEmpregado, dataInicio);
ALTER TABLE avaliacaoTemporario ADD CONSTRAINT fkAvaliacaoTemporarioIdAvaliacao                         FOREIGN KEY (idAvaliacao)                               REFERENCES avaliacao (idAvaliacao);

ALTER TABLE avaliacaoEfetivo    ADD CONSTRAINT fkAvaliacaoEfetivoIdEmpregado                            FOREIGN KEY (idEmpregado)                               REFERENCES empregadoEfetivo (idEmpregado);
ALTER TABLE avaliacaoEfetivo    ADD CONSTRAINT fkAvaliacaoEfetivoIdAvaliacao                            FOREIGN KEY (idAvaliacao)                               REFERENCES avaliacao (idAvaliacao);

ALTER TABLE departamento        ADD CONSTRAINT fkDepartamentoidDepartamentoSuperior                     FOREIGN KEY (idDepartamentoSuperior)                    REFERENCES departamento (idDepartamento);

ALTER TABLE empregadoDepartamento ADD CONSTRAINT fkEmpregadoDepartamentoIdDepartamento                  FOREIGN KEY (idDepartamento)                            REFERENCES departamento (idDepartamento);
ALTER TABLE empregadoDepartamento ADD CONSTRAINT fkEmpregadoDepartamentoIdEmpregado                     FOREIGN KEY (idEmpregado)                               REFERENCES empregado (idEmpregado);

-- ** guardar em DEFINITIVO as alterações na base de dados, se a opção Autocommit do SQL Developer não estiver ativada **
-- COMMIT;
