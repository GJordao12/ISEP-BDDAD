-- ** eliminar tabelas se existentes **
-- CASCADE CONSTRAINTS para eliminar as restrições de integridade das chaves primárias e chaves únicas
-- PURGE elimina a tabela da base de dados e da "reciclagem"
DROP TABLE cliente              CASCADE CONSTRAINTS PURGE;
DROP TABLE codigoPostal         CASCADE CONSTRAINTS PURGE;
DROP TABLE cartaoCliente        CASCADE CONSTRAINTS PURGE;
DROP TABLE venda                CASCADE CONSTRAINTS PURGE;
DROP TABLE livro                CASCADE CONSTRAINTS PURGE;
DROP TABLE categoria            CASCADE CONSTRAINTS PURGE;
DROP TABLE edicaoLivro          CASCADE CONSTRAINTS PURGE;
DROP TABLE idioma               CASCADE CONSTRAINTS PURGE;
DROP TABLE autor                CASCADE CONSTRAINTS PURGE;
DROP TABLE autorEdicaoLivro     CASCADE CONSTRAINTS PURGE;
DROP TABLE nacionalidadeAutor   CASCADE CONSTRAINTS PURGE;
DROP TABLE pais                 CASCADE CONSTRAINTS PURGE;
DROP TABLE editora              CASCADE CONSTRAINTS PURGE;
DROP TABLE precoEdicaoLivro     CASCADE CONSTRAINTS PURGE;

-- ## tabela cliente ##
CREATE TABLE cliente (
    nifCliente      NUMERIC(9)  CONSTRAINT pkClienteNifCliente PRIMARY KEY,
    codPostal       CHAR(8)     CONSTRAINT nnClientesCodPostal NOT NULL,    
    nome            VARCHAR(60) CONSTRAINT nnClienteNome NOT NULL,
    dataNascimento  DATE,
    morada          VARCHAR(50) CONSTRAINT nnClienteMorada NOT NULL,
    nrTelemovel     NUMERIC(9)  CONSTRAINT ckClienteNrTelemovel CHECK(REGEXP_LIKE(nrTelemovel, '^\d{9}$'))
);

-- ## tabela codigoPostal ##
CREATE TABLE codigoPostal (
    codPostal   CHAR(8)      CONSTRAINT pkCodigoPostalCodPostal PRIMARY KEY,
    localidade  VARCHAR(25)  CONSTRAINT nnCodigoPostalLocalidade NOT NULL,
    
    CONSTRAINT ckCodigoPostalCodPostal CHECK(REGEXP_LIKE(codPostal, '^\d{4}-\d{3}$'))
);

-- ## tabela cartaoCliente ##
CREATE TABLE cartaoCliente (
    nrCartao       INTEGER          CONSTRAINT pkCartaoClienteNrCartao PRIMARY KEY,
    nifCliente     NUMERIC(9)       CONSTRAINT nnCartaoClientesNif NOT NULL
                                    CONSTRAINT ckCartaoClienteNif CHECK(REGEXP_LIKE(nifCliente, '^\d{9}$'))
                                    CONSTRAINT ukCartaoCliente UNIQUE,
    dataAdesao     DATE             CONSTRAINT nnCartaoClienteDataAdesao NOT NULL,
    saldoAtual     NUMERIC(5,2),
    saldoAcumulado NUMERIC(10,2)
);

-- ## tabela venda ##
CREATE TABLE venda (
    nrVenda     INTEGER     CONSTRAINT pkVendaNrVenda PRIMARY KEY,
    nifCliente  INTEGER     CONSTRAINT nnVendaNifCliente NOT NULL,
    isbn        CHAR(14)    CONSTRAINT nnVendaIsbn NOT NULL,
    dataHora    DATE        CONSTRAINT nnVendaDataHora NOT NULL,
    quantidade  INTEGER     CONSTRAINT nnVendaQuantidade NOT NULL
);

-- ## tabela livro ##
CREATE TABLE livro (
    idLivro      INTEGER     CONSTRAINT pkLivroIdLivro PRIMARY KEY,
    idCategoria  INTEGER     CONSTRAINT nnLivroIdCategoria NOT NULL,
    titulo       VARCHAR(50) CONSTRAINT nnLivroTitulo NOT NULL
);

-- ## tabela categoria ##
CREATE TABLE categoria (
    idCategoria   INTEGER     CONSTRAINT pkCategoriaIdCategoria PRIMARY KEY,
    designacao    VARCHAR(20) CONSTRAINT nnCategoriaDesignacao NOT NULL
);

-- ## tabela edicaoLivro ##
CREATE TABLE edicaoLivro (
    isbn        CHAR(14)            CONSTRAINT pkEdicaoLivroIsbn PRIMARY KEY,
    idLivro     INTEGER             CONSTRAINT nnEdicaoLivroIdLivro NOT NULL,
    idEditora   INTEGER             CONSTRAINT nnEdicaoLivroIdEditora NOT NULL,
    nrEdicao    INTEGER             CONSTRAINT nnEdicaoLivroNrEdicao NOT NULL,
    codIdioma   CHAR(2)             CONSTRAINT nnEdicaoLivroCodIdioma NOT NULL,
    mesEdicao   NUMERIC(2)          CONSTRAINT nnEdicaoLivroMesEdicao NOT NULL
                                    CONSTRAINT ckEdicaoLivroMesEdicao CHECK(mesEdicao BETWEEN 1 AND 12),
    anoEdicao   NUMERIC(4)          CONSTRAINT nnEdicaoLivroAnoEdicao NOT NULL,
    stockMin    INTEGER DEFAULT 10  CONSTRAINT nnEdicaoLivroStockMin NOT NULL,
    stock       INTEGER             CONSTRAINT nnEdicaoLivroStock NOT NULL,
    
    CONSTRAINT ckEdicaoLivroIsbn CHECK(REGEXP_LIKE(isbn, '^\d{3}-\d{10}$'))
);

-- ## tabela idioma ##
CREATE TABLE idioma (
    codIdioma   CHAR(2)        CONSTRAINT pkIdiomaCodIdioma PRIMARY KEY,
    designacao  VARCHAR(20)    CONSTRAINT nnIdiomaDesignacao NOT NULL
);   

-- ## tabela autor ##
CREATE TABLE autor (
    idAutor INTEGER     CONSTRAINT pkAutorIdAutor PRIMARY KEY,
    nome    VARCHAR(35) CONSTRAINT nnAutorNome NOT NULL
);

-- ## tabela autorEdicaoLivro ##
CREATE TABLE autorEdicaoLivro (
    isbn    CHAR(14),
    idAutor INTEGER,
    
    CONSTRAINT pkAutorEdicaoLivroIsbnIdAutor PRIMARY KEY (isbn, idAutor)
);

-- ## tabela nacionalidadeAutor ##
CREATE TABLE nacionalidadeAutor (
    idAutor  INTEGER,
    codPais  CHAR(2),
    
    CONSTRAINT pkNacionalidadeAutorIdAutorCodPais PRIMARY KEY(idAutor,codPais)
);

-- ## tabela pais ##
CREATE TABLE pais (
    codPais  CHAR(2)        CONSTRAINT pkPaisCodPais PRIMARY KEY,
    nome     VARCHAR(30)    CONSTRAINT nnPaisNome NOT NULL
);

-- ## tabela editora ##
CREATE TABLE editora ( 
    idEditora   INTEGER     CONSTRAINT pkEditorIdEditora PRIMARY KEY,
    nome        VARCHAR(35) CONSTRAINT nnEditorNome NOT NULL,
    codPais     CHAR(2)     CONSTRAINT nnEditorCodPais NOT NULL
);

-- ## tabela precoEdicaoLivro ##
CREATE TABLE precoEdicaoLivro (
    isbn        CHAR(14),
    dataInicio  DATE            CONSTRAINT nnPrecoEdicaoLivroDataInicio NOT NULL,
    preco       NUMERIC(5,2)    CONSTRAINT nnPrecoEdicaoLivroPreco NOT NULL
                                CONSTRAINT ckPrecoEdicaoLivroPreco CHECK(preco>0),
                                
    CONSTRAINT pkPrecoEdicaoLivroIsbnDataInicio PRIMARY KEY (isbn, dataInicio)
);

-- ** alterar tabelas para definição de chaves estrangeiras **
ALTER TABLE cliente             ADD CONSTRAINT fkClienteCodPostal            FOREIGN KEY (codPostal)    REFERENCES codigoPostal(codPostal);
ALTER TABLE cartaoCliente       ADD CONSTRAINT fkCartaoClienteNifCliente     FOREIGN KEY (nifCliente)   REFERENCES cliente(nifCliente);
ALTER TABLE venda               ADD CONSTRAINT fkVendaNifCliente             FOREIGN KEY (nifCliente)   REFERENCES cliente(nifCliente);
ALTER TABLE venda               ADD CONSTRAINT fkVendaIsbn                   FOREIGN KEY (isbn)         REFERENCES edicaoLivro(isbn);
ALTER TABLE livro               ADD CONSTRAINT fkLivroIdCategoria            FOREIGN KEY (idCategoria) REFERENCES categoria(idCategoria);
ALTER TABLE edicaoLivro         ADD CONSTRAINT fkEdicaoLivroIdLivro          FOREIGN KEY (idLivro)      REFERENCES livro(idLivro);
ALTER TABLE edicaoLivro         ADD CONSTRAINT fkEdicaoLivroCodIdioma        FOREIGN KEY (codIdioma)    REFERENCES idioma(codIdioma);
ALTER TABLE edicaoLivro         ADD CONSTRAINT fkEdicaoLivroIdEditora        FOREIGN KEY (idEditora)    REFERENCES editora(idEditora);
ALTER TABLE autorEdicaoLivro    ADD CONSTRAINT fkAutoresEdicaoLivroIsbn      FOREIGN KEY (isbn)         REFERENCES edicaoLivro(isbn);
ALTER TABLE autorEdicaoLivro    ADD CONSTRAINT fkAutoresEdicaoLivroIdAutor   FOREIGN KEY (idAutor)      REFERENCES autor(idAutor);
ALTER TABLE nacionalidadeAutor  ADD CONSTRAINT fkNacionalidadeAutorIdAutor   FOREIGN KEY (idAutor)      REFERENCES autor(idAutor);
ALTER TABLE nacionalidadeAutor  ADD CONSTRAINT fkNacionalidadeAutorCodPais   FOREIGN KEY (codPais)      REFERENCES pais(codPais);
ALTER TABLE editora             ADD CONSTRAINT fkEditoraCodPais              FOREIGN KEY (codPais)      REFERENCES pais(codPais);
ALTER TABLE precoEdicaoLivro    ADD CONSTRAINT fkPrecoEdicaoLivroIsbn        FOREIGN KEY (isbn)         REFERENCES edicaoLivro(isbn);

-- ** guardar em DEFINITIVO as alterações na base de dados, se a opção Autocommit do SQL Developer não estiver ativada **
-- COMMIT;
