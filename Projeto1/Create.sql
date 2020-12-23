-- ** eliminar tabelas se existentes **
-- CASCADE CONSTRAINTS para eliminar as restri??es de integridade das chaves prim?rias e chaves ?nicas
-- PURGE elimina a tabela da base de dados e da "reciclagem"
DROP TABLE cliente CASCADE CONSTRAINTS PURGE;

DROP TABLE conta CASCADE CONSTRAINTS PURGE;

DROP TABLE restauracao CASCADE CONSTRAINTS PURGE;

DROP TABLE limpeza CASCADE CONSTRAINTS PURGE;

DROP TABLE manutencao CASCADE CONSTRAINTS PURGE;

DROP TABLE item CASCADE CONSTRAINTS PURGE;

DROP TABLE quarto CASCADE CONSTRAINTS PURGE;

DROP TABLE tipoquarto CASCADE CONSTRAINTS PURGE;

DROP TABLE intervencao CASCADE CONSTRAINTS PURGE;

DROP TABLE camareira CASCADE CONSTRAINTS PURGE;

DROP TABLE rececao CASCADE CONSTRAINTS PURGE;

DROP TABLE empregado CASCADE CONSTRAINTS PURGE;

DROP TABLE tipopagamento CASCADE CONSTRAINTS PURGE;

DROP TABLE andar CASCADE CONSTRAINTS PURGE;

DROP TABLE reserva CASCADE CONSTRAINTS PURGE;

DROP TABLE epoca CASCADE CONSTRAINTS PURGE;

DROP TABLE fatura CASCADE CONSTRAINTS PURGE;

DROP TABLE pagamentofatura CASCADE CONSTRAINTS PURGE;

DROP TABLE produtoscomprados CASCADE CONSTRAINTS PURGE;

DROP TABLE empregadomanutencao CASCADE CONSTRAINTS PURGE;

CREATE TABLE tipopagamento (
    designacao VARCHAR(30)
        CONSTRAINT pktipopagamentodesignacao PRIMARY KEY
);

CREATE TABLE andar (
    nrandar  INTEGER
        CONSTRAINT pkandarnrandar PRIMARY KEY,
    nome     VARCHAR(30)
        CONSTRAINT nnandarnome NOT NULL
);

CREATE TABLE conta (
    nrconta       INTEGER
        CONSTRAINT pkncconta PRIMARY KEY,
    dataabertura  DATE,
    codres        INTEGER
);

CREATE TABLE epoca (
    epocadesignacao  VARCHAR(30)
        CONSTRAINT pkepocaepocadesignacao PRIMARY KEY,
    datainicio       DATE
        CONSTRAINT nnepocadatainicio NOT NULL,
    datafim          DATE
        CONSTRAINT nnepocadatafim NOT NULL,
    valor            INTEGER
        CONSTRAINT nnepocavalor NOT NULL
);

CREATE TABLE reserva (
    datareserva      DATE
        CONSTRAINT nndatareserva NOT NULL,
    codres           INTEGER
        CONSTRAINT pkresevacodres PRIMARY KEY,
    nrpessoas        INTEGER
        CONSTRAINT nnreservanrpessoas NOT NULL,
    dataentrada      DATE
        CONSTRAINT nnreservadataentrada NOT NULL,
    datasaida        DATE
        CONSTRAINT nnreservadatafim NOT NULL,
    estado           VARCHAR(30)
        CONSTRAINT nnreservaestado NOT NULL
    CHECK ( estado LIKE ( 'reservado' )
            OR estado LIKE ( 'ativa' )
            OR estado LIKE ( 'cancelada' )
            OR estado LIKE ( 'finalizada' ) ),
    nrquarto         INTEGER,
    nrandar          INTEGER,
    nifcliente       INTEGER
        CONSTRAINT pkreservanifclientemenornovee CHECK ( REGEXP_LIKE ( nifcliente,
                                                                       '^\d{9}$' ) ),
    epocadesignacao  VARCHAR(30)
);

CREATE TABLE fatura (
    codres   INTEGER,
    nrconta  INTEGER,
    CONSTRAINT pkfaturacodresnrconta PRIMARY KEY ( codres )
);

CREATE TABLE pagamentofatura (
    designacao          VARCHAR(30),
    codres              INTEGER,
    valortipopagamento  INTEGER
        CONSTRAINT nnvalortipopagamentopagamentofatura NOT NULL,
    CONSTRAINT pkpagamentofaturadesignacaocodres PRIMARY KEY ( designacao,
                                                               codres )
);

CREATE TABLE cliente (
    nifcliente  INTEGER
        CONSTRAINT pknifclientee PRIMARY KEY
        CONSTRAINT clientenifclientemenornovee CHECK ( REGEXP_LIKE ( nifcliente,
                                                                     '^\d{9}$' ) ),
    nome        VARCHAR(40)
        CONSTRAINT nnnomeclientee NOT NULL,
    email       VARCHAR(40)
        CONSTRAINT emailvalidation CHECK ( NOT REGEXP_LIKE ( email,
                                                             '^[a-zA-Z0-9][a-zA-Z0-9._-]*@[a-zA-Z0-9][a-zA-Z0-9._-]*\\.[a-zA-Z]{2,4}$' ) ),
    telefone    INTEGER
        CONSTRAINT cktelefoneclientee CHECK ( REGEXP_LIKE ( telefone,
                                                            '^\d{9}$' ) ),
   concelho     VARCHAR(40)
        CONSTRAINT nnmoradaclientee NOT NULL,
    localidade  VARCHAR(40)
        CONSTRAINT nnlocalidadeclientee NOT NULL,
    morada    VARCHAR(40)
        CONSTRAINT nnconcelhoclientee NOT NULL
);

CREATE TABLE restauracao (
    nifempre INTEGER
        CONSTRAINT pknifempre PRIMARY KEY
        CONSTRAINT nifclientenifclientemenornovee CHECK ( REGEXP_LIKE ( nifempre,
                                                                        '^\d{9}$' ) )
);

CREATE TABLE limpeza (
    codinter INTEGER
        CONSTRAINT pkcodinter PRIMARY KEY
);

CREATE TABLE manutencao (
    telefoneservico  INTEGER
        CONSTRAINT cktelefoneservicomanutencao CHECK ( REGEXP_LIKE ( telefoneservico,
                                                                     '^\d{9}$' ) ),
    superiornif      INTEGER,
    codinter         INTEGER,
    descricao        VARCHAR(50)
        CONSTRAINT nnmanutencaodescricao NOT NULL,
    estado           VARCHAR(50) DEFAULT 'aberto'
        CONSTRAINT nnmanutencaoestado NOT NULL
);

CREATE TABLE item (
    itemid  INTEGER
        CONSTRAINT pkitemid PRIMARY KEY,
    nome    VARCHAR(40)
        CONSTRAINT nnnome NOT NULL,
    valor   NUMERIC(5, 2)
);

CREATE TABLE produtoscomprados (
    dataa            DATE,
    itemid           INTEGER,
    contanrconta     INTEGER,
    limpezacodinter  INTEGER,
    CONSTRAINT pkprodutoscomprados PRIMARY KEY ( itemid,
                                                 contanrconta,
                                                 dataa )
);

CREATE TABLE quarto (
    nrquarto       INTEGER,
    nrandar        INTEGER,
    lotacaomaxima  INTEGER,
    tipoquarto     VARCHAR(50),
    CONSTRAINT pkquartonrquartonrandar PRIMARY KEY ( nrquarto,
                                                     nrandar )
);

CREATE TABLE tipoquarto (
    designacao  VARCHAR(50)
        CONSTRAINT pktipoquartodesignacao PRIMARY KEY
    CHECK ( designacao LIKE ( 'single' )
            OR designacao LIKE ( 'twin' )
            OR designacao LIKE ( 'superior' )
            OR designacao LIKE ( 'suite' ) ),
    preco       NUMERIC(10, 2)
        CONSTRAINT nntipoquartopreco NOT NULL
        CONSTRAINT cktipoquartopreco CHECK ( preco >= 0 )
);

CREATE TABLE intervencao (
    codinter   INTEGER
        CONSTRAINT pkintervencaocodinter PRIMARY KEY,
    nrquarto   INTEGER
        CONSTRAINT nnintervencaonrquarto NOT NULL,
    nrandar    INTEGER
        CONSTRAINT nnintervencaonrandar NOT NULL,
    nifempre   INTEGER
        CONSTRAINT nnintervencaonifempre NOT NULL,
    datainter  DATE
        CONSTRAINT nnintervencaodatainter NOT NULL
);

CREATE TABLE camareira (
    nifempre INTEGER
        CONSTRAINT pkcamareiranifempre PRIMARY KEY
);

CREATE TABLE rececao (
    nifempre INTEGER
        CONSTRAINT pkrececaonifempre PRIMARY KEY
);

CREATE TABLE empregado (
    nifempre  INTEGER
        CONSTRAINT pkempregadonifempre PRIMARY KEY
        CONSTRAINT ckempregadonifempre CHECK ( REGEXP_LIKE ( nifempre,
                                                             '^\d{9}$' ) ),
    nome      VARCHAR(50)
        CONSTRAINT nnempregadonome NOT NULL,
    morada    VARCHAR(50)
        CONSTRAINT nnempregadomorada NOT NULL,
    email     VARCHAR(50)
        CONSTRAINT nnempregadoemail NOT NULL
        CONSTRAINT emailvalidationempregado CHECK ( NOT REGEXP_LIKE ( email,
                                                                      '^[a-zA-Z0-9][a-zA-Z0-9._-]*@[a-zA-Z0-9][a-zA-Z0-9._-]*\\.[a-zA-Z]{2,4}$' ) ),
    telefone  INTEGER
        CONSTRAINT ckempregadotelefone CHECK ( REGEXP_LIKE ( telefone,
                                                             '^\d{9}$' ) )
);

CREATE TABLE empregadomanutencao (
    nifempre INTEGER
        CONSTRAINT pkempregadomanutencaonifempre PRIMARY KEY
);



-- ** alterar tabelas para defini??o de chaves estrangeiras **
ALTER TABLE produtoscomprados
    ADD CONSTRAINT fkprodutoscompradositemid FOREIGN KEY ( itemid )
        REFERENCES item ( itemid );

ALTER TABLE produtoscomprados
    ADD CONSTRAINT fkprodutoscompradoscontanrconta FOREIGN KEY ( contanrconta )
        REFERENCES conta ( nrconta );

ALTER TABLE limpeza
    ADD CONSTRAINT fklimpeza FOREIGN KEY ( codinter )
        REFERENCES intervencao ( codinter );

ALTER TABLE restauracao
    ADD CONSTRAINT fkrestauracao FOREIGN KEY ( nifempre )
        REFERENCES empregado ( nifempre );

ALTER TABLE empregadomanutencao
    ADD CONSTRAINT fkempregadomanutencao FOREIGN KEY ( nifempre )
        REFERENCES empregado ( nifempre );

ALTER TABLE manutencao
    ADD CONSTRAINT fkmanutencao FOREIGN KEY ( codinter )
        REFERENCES intervencao ( codinter );

ALTER TABLE quarto
    ADD CONSTRAINT fkquartotipoquarto FOREIGN KEY ( tipoquarto )
        REFERENCES tipoquarto ( designacao );

ALTER TABLE quarto
    ADD CONSTRAINT fkquartoandar FOREIGN KEY ( nrandar )
        REFERENCES andar ( nrandar );

ALTER TABLE intervencao
    ADD CONSTRAINT fkintervencaoquarto FOREIGN KEY ( nrquarto,
                                                     nrandar )
        REFERENCES quarto ( nrquarto,
                            nrandar );

ALTER TABLE intervencao
    ADD CONSTRAINT fkintervencaoempregado FOREIGN KEY ( nifempre )
        REFERENCES empregado ( nifempre );

ALTER TABLE camareira
    ADD CONSTRAINT fkcamareiraempregado FOREIGN KEY ( nifempre )
        REFERENCES empregado ( nifempre );

ALTER TABLE rececao
    ADD CONSTRAINT fkrececao FOREIGN KEY ( nifempre )
        REFERENCES empregado ( nifempre );

ALTER TABLE reserva
    ADD CONSTRAINT fknrquartoandar FOREIGN KEY ( nrquarto,
                                                 nrandar )
        REFERENCES quarto ( nrquarto,
                            nrandar );

ALTER TABLE reserva
    ADD CONSTRAINT fkreservaepocadesignacao FOREIGN KEY ( epocadesignacao )
        REFERENCES epoca ( epocadesignacao );

ALTER TABLE conta
    ADD CONSTRAINT fkcontacodres FOREIGN KEY ( codres )
        REFERENCES reserva ( codres );

ALTER TABLE fatura
    ADD CONSTRAINT fkfaturacodres FOREIGN KEY ( codres )
        REFERENCES reserva ( codres );

ALTER TABLE fatura
    ADD CONSTRAINT fkfaturanrconta FOREIGN KEY ( nrconta )
        REFERENCES conta ( nrconta );

ALTER TABLE pagamentofatura
    ADD CONSTRAINT fkpagamentofaturacodres FOREIGN KEY ( codres )
        REFERENCES reserva ( codres );

ALTER TABLE pagamentofatura
    ADD CONSTRAINT fkpagamentofaturadesignacao FOREIGN KEY ( designacao )
        REFERENCES tipopagamento ( designacao );