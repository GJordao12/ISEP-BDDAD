
-- ** tabela Empregado **

INSERT INTO empregado (nome, dataNascimento, nrIdentificacaoCivil, nif) VALUES ('Belmiro Cunha', TO_DATE('1985-01-13','yyyy-mm-dd'), 1111111, 111111111); 
INSERT INTO empregado (nome, dataNascimento, nrIdentificacaoCivil, nif) VALUES ('Luisa Coelho',  TO_DATE('1980-05-03','yyyy-mm-dd'), 2222222, 222222222); 
INSERT INTO empregado (nome, dataNascimento, nrIdentificacaoCivil, nif) VALUES ('João Pereira',  TO_DATE('1970-09-05','yyyy-mm-dd'), 3333333, 333333333); 
INSERT INTO empregado (nome, dataNascimento, nrIdentificacaoCivil, nif) VALUES ('Carlos Silva',  TO_DATE('1983-02-10','yyyy-mm-dd'), 4444444, 444444444); 
INSERT INTO empregado (nome, dataNascimento, nrIdentificacaoCivil, nif) VALUES ('Anibal Dias',   TO_DATE('1982-10-12','yyyy-mm-dd'), 5555555, 555555555); 
INSERT INTO empregado (nome, dataNascimento, nrIdentificacaoCivil, nif) VALUES ('Anibal Dias',   TO_DATE('1983-04-22','yyyy-mm-dd'), 6666666, 666666666); 
INSERT INTO empregado (nome, dataNascimento, nrIdentificacaoCivil, nif) VALUES ('Joana Freitas', TO_DATE('1995-03-15','yyyy-mm-dd'), 7777777, 777777777); 

-- ** tabela Falta **

INSERT INTO falta (idEmpregado, dataInicio, dataFim, justificacao) VALUES (2, TO_DATE('2015-05-15','yyyy-mm-dd'), TO_DATE('2015-05-20','yyyy-mm-dd'), 'gripe'); 
INSERT INTO falta (idEmpregado, dataInicio, dataFim, justificacao) VALUES (3, TO_DATE('2018-11-05','yyyy-mm-dd'), TO_DATE('2018-11-15','yyyy-mm-dd'), 'apoio a familiares'); 
INSERT INTO falta (idEmpregado, dataInicio, dataFim, justificacao) VALUES (5, TO_DATE('2018-08-15','yyyy-mm-dd'), TO_DATE('2018-08-31','yyyy-mm-dd'), 'fratura'); 
INSERT INTO falta (idEmpregado, dataInicio, dataFim, justificacao) VALUES (6, TO_DATE('2020-09-25','yyyy-mm-dd'), TO_DATE('2020-09-28','yyyy-mm-dd'), 'gripe'); 

-- ** tabela EmpregadoEfetivo **

INSERT INTO empregadoEfetivo (idEmpregado, salarioMensalBase) VALUES (1,1500); 
INSERT INTO empregadoEfetivo (idEmpregado, salarioMensalBase) VALUES (2,700);
INSERT INTO empregadoEfetivo (idEmpregado, salarioMensalBase) VALUES (3,1000);
INSERT INTO empregadoEfetivo (idEmpregado, salarioMensalBase) VALUES (4,1000);

-- ** tabela EmpregadoTemporario **

INSERT INTO empregadoTemporario (idEmpregado, salarioHora) VALUES (5,7); 
INSERT INTO empregadoTemporario (idEmpregado, salarioHora) VALUES (6,7);
INSERT INTO empregadoTemporario (idEmpregado, salarioHora) VALUES (7,5);

-- ** tabela Departamento **
INSERT INTO departamento (idDepartamento, idDepartamentoSuperior, designacao) VALUES ('DIR', NULL, 'Direção'); 
INSERT INTO departamento (idDepartamento, idDepartamentoSuperior, designacao) VALUES ('DRH', 'DIR', 'Departamento de Recursos Humanos'); 
INSERT INTO departamento (idDepartamento, idDepartamentoSuperior, designacao) VALUES ('DSI', 'DIR', 'Departamento de Sistemas Informáticos'); 
INSERT INTO departamento (idDepartamento, idDepartamentoSuperior, designacao) VALUES ('DAU', 'DSI', 'Departamento de Apoio ao Utilizador'); 
INSERT INTO departamento (idDepartamento, idDepartamentoSuperior, designacao) VALUES ('DMI', 'DSI', 'Departamento de Manutenção Informática'); 

-- ** tabela EmpregadoDepartamento **

INSERT INTO empregadoDepartamento (idDepartamento, idEmpregado, dataInicio, dataFim) VALUES ('DIR', 1, TO_DATE('2010-09-15','yyyy-mm-dd'), NULL); 
INSERT INTO empregadoDepartamento (idDepartamento, idEmpregado, dataInicio, dataFim) VALUES ('DRH', 2, TO_DATE('2010-10-26','yyyy-mm-dd'), NULL); 
INSERT INTO empregadoDepartamento (idDepartamento, idEmpregado, dataInicio, dataFim) VALUES ('DAU', 3, TO_DATE('2015-03-07','yyyy-mm-dd'), TO_DATE('2019-09-09','yyyy-mm-dd')); 
INSERT INTO empregadoDepartamento (idDepartamento, idEmpregado, dataInicio, dataFim) VALUES ('DMI', 3, TO_DATE('2019-09-10','yyyy-mm-dd'), NULL); 
INSERT INTO empregadoDepartamento (idDepartamento, idEmpregado, dataInicio, dataFim) VALUES ('DAU', 4, TO_DATE('2018-04-12','yyyy-mm-dd'), NULL); 
INSERT INTO empregadoDepartamento (idDepartamento, idEmpregado, dataInicio, dataFim) VALUES ('DAU', 5, TO_DATE('2018-08-01','yyyy-mm-dd'), TO_DATE('2018-08-31','yyyy-mm-dd')); 
INSERT INTO empregadoDepartamento (idDepartamento, idEmpregado, dataInicio, dataFim) VALUES ('DMI', 6, TO_DATE('2020-09-20','yyyy-mm-dd'), TO_DATE('2020-09-30','yyyy-mm-dd')); 
INSERT INTO empregadoDepartamento (idDepartamento, idEmpregado, dataInicio, dataFim) VALUES ('DRH', 7, TO_DATE('2019-11-15','yyyy-mm-dd'), TO_DATE('2019-12-31','yyyy-mm-dd')); 
INSERT INTO empregadoDepartamento (idDepartamento, idEmpregado, dataInicio, dataFim) VALUES ('DRH', 7, TO_DATE('2020-03-15','yyyy-mm-dd'), TO_DATE('2020-04-15','yyyy-mm-dd')); 

-- ** tabela Avaliacao **

INSERT INTO avaliacao (idAvaliacao, descricao) VALUES ('MB', 'MUITO BOM'); 
INSERT INTO avaliacao (idAvaliacao, descricao) VALUES ('B', 'BOM');
INSERT INTO avaliacao (idAvaliacao, descricao) VALUES ('S', 'SUFICIENTE');
INSERT INTO avaliacao (idAvaliacao, descricao) VALUES ('I', 'INSUFICIENTE');

-- ** tabela AvaliacaoTemporario **

INSERT INTO avaliacaoTemporario (idDepartamento, idEmpregado, dataInicio, idAvaliacao) VALUES ('DAU', 5, TO_DATE('2018-08-01','yyyy-mm-dd'), 'S');
INSERT INTO avaliacaoTemporario (idDepartamento, idEmpregado, dataInicio, idAvaliacao) VALUES ('DMI', 6, TO_DATE('2020-09-20','yyyy-mm-dd'), 'S');
INSERT INTO avaliacaoTemporario (idDepartamento, idEmpregado, dataInicio, idAvaliacao) VALUES ('DRH', 7, TO_DATE('2019-11-15','yyyy-mm-dd'), 'MB');
INSERT INTO avaliacaoTemporario (idDepartamento, idEmpregado, dataInicio, idAvaliacao) VALUES ('DRH', 7, TO_DATE('2020-03-15','yyyy-mm-dd'), 'MB');

-- ** tabela AvaliacaoEfetivo **

INSERT INTO avaliacaoEfetivo (idEmpregado, ano, idAvaliacao) VALUES (1, 2015, 'MB'); 
INSERT INTO avaliacaoEfetivo (idEmpregado, ano, idAvaliacao) VALUES (1, 2016, 'MB'); 
INSERT INTO avaliacaoEfetivo (idEmpregado, ano, idAvaliacao) VALUES (1, 2017, 'MB'); 
INSERT INTO avaliacaoEfetivo (idEmpregado, ano, idAvaliacao) VALUES (1, 2018, 'MB'); 
INSERT INTO avaliacaoEfetivo (idEmpregado, ano, idAvaliacao) VALUES (1, 2019, 'MB');

INSERT INTO avaliacaoEfetivo (idEmpregado, ano, idAvaliacao) VALUES (2, 2015, 'MB'); 
INSERT INTO avaliacaoEfetivo (idEmpregado, ano, idAvaliacao) VALUES (2, 2016, 'B'); 
INSERT INTO avaliacaoEfetivo (idEmpregado, ano, idAvaliacao) VALUES (2, 2017, 'MB'); 
INSERT INTO avaliacaoEfetivo (idEmpregado, ano, idAvaliacao) VALUES (2, 2018, 'MB'); 
INSERT INTO avaliacaoEfetivo (idEmpregado, ano, idAvaliacao) VALUES (2, 2019, 'MB');

INSERT INTO avaliacaoEfetivo (idEmpregado, ano, idAvaliacao) VALUES (3, 2016, 'S');
INSERT INTO avaliacaoEfetivo (idEmpregado, ano, idAvaliacao) VALUES (3, 2017, 'S');
INSERT INTO avaliacaoEfetivo (idEmpregado, ano, idAvaliacao) VALUES (3, 2018, 'S');
INSERT INTO avaliacaoEfetivo (idEmpregado, ano, idAvaliacao) VALUES (3, 2019, 'S');

INSERT INTO avaliacaoEfetivo (idEmpregado, ano, idAvaliacao) VALUES (4, 2019, 'MB');

-- ** tabela Ferias **

INSERT INTO ferias (idEmpregado, dataInicio, dataFim) VALUES (1, TO_DATE('2011-08-15','yyyy-mm-dd'), TO_DATE('2011-08-31','yyyy-mm-dd')); 
INSERT INTO ferias (idEmpregado, dataInicio, dataFim) VALUES (1, TO_DATE('2012-08-15','yyyy-mm-dd'), TO_DATE('2012-08-31','yyyy-mm-dd')); 
INSERT INTO ferias (idEmpregado, dataInicio, dataFim) VALUES (1, TO_DATE('2013-08-01','yyyy-mm-dd'), TO_DATE('2013-08-11','yyyy-mm-dd'));
INSERT INTO ferias (idEmpregado, dataInicio, dataFim) VALUES (1, TO_DATE('2014-08-15','yyyy-mm-dd'), TO_DATE('2014-08-31','yyyy-mm-dd'));
INSERT INTO ferias (idEmpregado, dataInicio, dataFim) VALUES (1, TO_DATE('2015-08-15','yyyy-mm-dd'), TO_DATE('2015-08-31','yyyy-mm-dd'));
INSERT INTO ferias (idEmpregado, dataInicio, dataFim) VALUES (1, TO_DATE('2016-08-15','yyyy-mm-dd'), TO_DATE('2016-08-31','yyyy-mm-dd'));
INSERT INTO ferias (idEmpregado, dataInicio, dataFim) VALUES (1, TO_DATE('2017-08-15','yyyy-mm-dd'), TO_DATE('2017-08-31','yyyy-mm-dd'));
INSERT INTO ferias (idEmpregado, dataInicio, dataFim) VALUES (1, TO_DATE('2019-08-01','yyyy-mm-dd'), TO_DATE('2019-08-31','yyyy-mm-dd'));

INSERT INTO ferias (idEmpregado, dataInicio, dataFim) VALUES (2, TO_DATE('2014-03-01','yyyy-mm-dd'), TO_DATE('2014-03-25','yyyy-mm-dd'));
INSERT INTO ferias (idEmpregado, dataInicio, dataFim) VALUES (2, TO_DATE('2015-07-01','yyyy-mm-dd'), TO_DATE('2015-07-20','yyyy-mm-dd'));
INSERT INTO ferias (idEmpregado, dataInicio, dataFim) VALUES (2, TO_DATE('2016-06-01','yyyy-mm-dd'), TO_DATE('2016-06-30','yyyy-mm-dd'));
INSERT INTO ferias (idEmpregado, dataInicio, dataFim) VALUES (2, TO_DATE('2017-07-01','yyyy-mm-dd'), TO_DATE('2017-07-27','yyyy-mm-dd'));
INSERT INTO ferias (idEmpregado, dataInicio, dataFim) VALUES (2, TO_DATE('2018-05-01','yyyy-mm-dd'), TO_DATE('2018-05-31','yyyy-mm-dd'));
INSERT INTO ferias (idEmpregado, dataInicio, dataFim) VALUES (2, TO_DATE('2019-12-10','yyyy-mm-dd'), TO_DATE('2019-12-31','yyyy-mm-dd'));

INSERT INTO ferias (idEmpregado, dataInicio, dataFim) VALUES (3, TO_DATE('2016-06-01','yyyy-mm-dd'), TO_DATE('2016-06-30','yyyy-mm-dd'));
INSERT INTO ferias (idEmpregado, dataInicio, dataFim) VALUES (3, TO_DATE('2017-07-01','yyyy-mm-dd'), TO_DATE('2017-07-11','yyyy-mm-dd'));
INSERT INTO ferias (idEmpregado, dataInicio, dataFim) VALUES (3, TO_DATE('2018-03-01','yyyy-mm-dd'), TO_DATE('2018-03-18','yyyy-mm-dd'));
INSERT INTO ferias (idEmpregado, dataInicio, dataFim) VALUES (3, TO_DATE('2019-05-01','yyyy-mm-dd'), TO_DATE('2019-05-15','yyyy-mm-dd'));

INSERT INTO ferias (idEmpregado, dataInicio, dataFim) VALUES (4, TO_DATE('2019-05-01','yyyy-mm-dd'), TO_DATE('2019-05-31','yyyy-mm-dd'));

-- ** guardar em DEFINITIVO as alterações na base de dados, se a opção Autocommit do SQL Developer não estiver ativada **
-- COMMIT;
