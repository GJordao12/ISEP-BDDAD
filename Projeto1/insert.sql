--DONE5 registos de reservas por época do ano;
--DONE o 5 registos de camareiras; 
--DONEo 10 registos de bebidas e 7 registos de snacks no mini-bar;
-- 10 registos de quartos de cada tipo em cada andar;
--DONE  3 registos de clientes por zona do país;
--DONE 20 registos de clientes que consumiram nos últimos 6 meses e 
--DONE 5 registos de clientes que consumiram fora desses 6 meses.

--tipo quarto
insert into tipoQuarto values('single',1);
insert into tipoQuarto values('twin', 2);
insert into tipoQuarto values('superior', 3);
insert into tipoQuarto values('suite' , 4);
--andar
insert into andar values (1, 'concha');
insert into andar values (2, 'palmeira');
insert into andar values (3, 'oceano');
-- Quartos
-- 1º Andar
INSERT INTO QUARTO VALUES (1,1,1,'suite');
INSERT INTO QUARTO VALUES (2,1,1,'suite');
INSERT INTO QUARTO VALUES (3,1,2,'suite');
INSERT INTO QUARTO VALUES (4,1,1,'suite');
INSERT INTO QUARTO VALUES (5,1,1,'suite');
INSERT INTO QUARTO VALUES (6,1,2,'suite');
INSERT INTO QUARTO VALUES (7,1,2,'suite');
INSERT INTO QUARTO VALUES (8,1,2,'suite');
INSERT INTO QUARTO VALUES (9,1,1,'suite');
INSERT INTO QUARTO VALUES (10,1,1,'suite');
INSERT INTO QUARTO VALUES (11,1,2,'twin');
INSERT INTO QUARTO VALUES (12,1,2,'twin');
INSERT INTO QUARTO VALUES (13,1,2,'twin');
INSERT INTO QUARTO VALUES (14,1,2,'twin');
INSERT INTO QUARTO VALUES (15,1,2,'twin');
INSERT INTO QUARTO VALUES (16,1,2,'twin');
INSERT INTO QUARTO VALUES (17,1,2,'twin');
INSERT INTO QUARTO VALUES (18,1,2,'twin');
INSERT INTO QUARTO VALUES (19,1,2,'twin');
INSERT INTO QUARTO VALUES (20,1,2,'twin');
INSERT INTO QUARTO VALUES (21,1,2,'single');
INSERT INTO QUARTO VALUES (22,1,1,'single');
INSERT INTO QUARTO VALUES (23,1,1,'single');
INSERT INTO QUARTO VALUES (24,1,1,'single');
INSERT INTO QUARTO VALUES (25,1,1,'single');
INSERT INTO QUARTO VALUES (26,1,1,'single');
INSERT INTO QUARTO VALUES (27,1,1,'single');
INSERT INTO QUARTO VALUES (28,1,1,'single');
INSERT INTO QUARTO VALUES (29,1,1,'single');
INSERT INTO QUARTO VALUES (30,1,1,'single');
INSERT INTO QUARTO VALUES (31,1,4,'superior');
INSERT INTO QUARTO VALUES (32,1,3,'superior');
INSERT INTO QUARTO VALUES (33,1,4,'superior');
INSERT INTO QUARTO VALUES (34,1,3,'superior');
INSERT INTO QUARTO VALUES (35,1,3,'superior');
INSERT INTO QUARTO VALUES (36,1,3,'superior');
INSERT INTO QUARTO VALUES (37,1,4,'superior');
INSERT INTO QUARTO VALUES (38,1,4,'superior');
INSERT INTO QUARTO VALUES (39,1,3,'superior');
INSERT INTO QUARTO VALUES (40,1,3,'superior');

-- 2º Andar
INSERT INTO QUARTO VALUES (1,2,2,'suite');
INSERT INTO QUARTO VALUES (2,2,1,'suite');
INSERT INTO QUARTO VALUES (3,2,2,'suite');
INSERT INTO QUARTO VALUES (4,2,1,'suite');
INSERT INTO QUARTO VALUES (5,2,2,'suite');
INSERT INTO QUARTO VALUES (6,2,1,'suite');
INSERT INTO QUARTO VALUES (7,2,1,'suite');
INSERT INTO QUARTO VALUES (8,2,2,'suite');
INSERT INTO QUARTO VALUES (9,2,1,'suite');
INSERT INTO QUARTO VALUES (10,2,1,'suite');

INSERT INTO QUARTO VALUES (11,2,1,'single');
INSERT INTO QUARTO VALUES (12,2,1,'single');
INSERT INTO QUARTO VALUES (13,2,1,'single');
INSERT INTO QUARTO VALUES (14,2,1,'single');
INSERT INTO QUARTO VALUES (15,2,1,'single');
INSERT INTO QUARTO VALUES (16,2,1,'single');
INSERT INTO QUARTO VALUES (17,2,1,'single');
INSERT INTO QUARTO VALUES (18,2,1,'single');
INSERT INTO QUARTO VALUES (19,2,1,'single');
INSERT INTO QUARTO VALUES (20,2,1,'single');

INSERT INTO QUARTO VALUES (21,2,4,'superior');
INSERT INTO QUARTO VALUES (22,2,2,'superior');
INSERT INTO QUARTO VALUES (23,2,3,'superior');
INSERT INTO QUARTO VALUES (24,2,2,'superior');
INSERT INTO QUARTO VALUES (25,2,3,'superior');
INSERT INTO QUARTO VALUES (26,2,1,'superior');
INSERT INTO QUARTO VALUES (27,2,2,'superior');
INSERT INTO QUARTO VALUES (28,2,4,'superior');
INSERT INTO QUARTO VALUES (29,2,2,'superior');
INSERT INTO QUARTO VALUES (30,2,3,'superior');

INSERT INTO QUARTO VALUES (31,2,2,'twin');
INSERT INTO QUARTO VALUES (32,2,2,'twin');
INSERT INTO QUARTO VALUES (33,2,2,'twin');
INSERT INTO QUARTO VALUES (34,2,2,'twin');
INSERT INTO QUARTO VALUES (35,2,2,'twin');
INSERT INTO QUARTO VALUES (36,2,2,'twin');
INSERT INTO QUARTO VALUES (37,2,2,'twin');
INSERT INTO QUARTO VALUES (38,2,2,'twin');
INSERT INTO QUARTO VALUES (39,2,2,'twin');
INSERT INTO QUARTO VALUES (40,2,2,'twin');



-- 3º Andar
INSERT INTO QUARTO VALUES (1,3,2,'suite');
INSERT INTO QUARTO VALUES (2,3,2,'suite');
INSERT INTO QUARTO VALUES (3,3,2,'twin');
INSERT INTO QUARTO VALUES (4,3,2,'suite');
INSERT INTO QUARTO VALUES (5,3,2,'suite');
INSERT INTO QUARTO VALUES (6,3,2,'suite');
INSERT INTO QUARTO VALUES (7,3,2,'suite');
INSERT INTO QUARTO VALUES (8,3,1,'single');
INSERT INTO QUARTO VALUES (9,3,1,'single');
INSERT INTO QUARTO VALUES (10,3,2,'suite');
INSERT INTO QUARTO VALUES (11,3,2,'suite');
INSERT INTO QUARTO VALUES (12,3,2,'suite');
INSERT INTO QUARTO VALUES (13,3,2,'twin');
INSERT INTO QUARTO VALUES (14,3,2,'twin');
INSERT INTO QUARTO VALUES (15,3,2,'suite');
INSERT INTO QUARTO VALUES (16,3,2,'suite');
INSERT INTO QUARTO VALUES (17,3,4,'superior');
INSERT INTO QUARTO VALUES (18,3,2,'twin');
INSERT INTO QUARTO VALUES (19,3,2,'twin');
INSERT INTO QUARTO VALUES (20,3,2,'twin');
INSERT INTO QUARTO VALUES (21,3,2,'twin');
INSERT INTO QUARTO VALUES (22,3,4,'superior');
INSERT INTO QUARTO VALUES (23,3,2,'twin');
INSERT INTO QUARTO VALUES (24,3,4,'superior');
INSERT INTO QUARTO VALUES (25,3,4,'superior');
INSERT INTO QUARTO VALUES (26,3,4,'superior');
INSERT INTO QUARTO VALUES (27,3,4,'superior');
INSERT INTO QUARTO VALUES (28,3,2,'twin');
INSERT INTO QUARTO VALUES (29,3,1,'single');
INSERT INTO QUARTO VALUES (30,3,1,'single');
INSERT INTO QUARTO VALUES (31,3,4,'superior');
INSERT INTO QUARTO VALUES (32,3,4,'superior');
INSERT INTO QUARTO VALUES (33,3,1,'single');
INSERT INTO QUARTO VALUES (34,3,1,'single');
INSERT INTO QUARTO VALUES (35,3,4,'superior');
INSERT INTO QUARTO VALUES (36,3,4,'superior');
INSERT INTO QUARTO VALUES (37,3,1,'single');
INSERT INTO QUARTO VALUES (38,3,1,'single');
INSERT INTO QUARTO VALUES (39,3,1,'single');
INSERT INTO QUARTO VALUES (40,3,1,'single');
--                    tipo pagamento
insert into tipopagamento values('CartaoDebito');
insert into tipopagamento values('CartaoCredito');
insert into tipopagamento values('Cheque');

--                    epoca 
insert into epoca values('baixa',TO_Date('2020-01-01','YYYY-MM-DD'),To_Date('2020-04-29','YYYY-MM-DD'),50);
insert into epoca values('media',TO_Date('2020-05-01','YYYY-MM-DD'),TO_Date('2020-08-31','YYYY-MM-DD'),70);
insert into epoca values('alta',TO_Date('2020-09-01','YYYY-MM-DD'),TO_Date('2020-12-31','YYYY-MM-DD'),100);
--                    reserva baixa
insert into reserva values(TO_Date('2020-01-01 01:00:00','YYYY-MM-DD HH:MI:SS'),1,2,TO_Date('2020-01-15','YYYY-MM-DD'),TO_Date('2020-01-18','YYYY-MM-DD'),'finalizada',01,01,123456789,'baixa');
insert into reserva values(TO_Date('2020-01-01 01:00:00','YYYY-MM-DD HH:MI:SS'),2,4,TO_Date('2020-02-03','YYYY-MM-DD'),TO_Date('2020-02-06','YYYY-MM-DD'),'cancelada',02,01,761275207,'baixa');
insert into reserva values(TO_Date('2020-01-01 01:00:00','YYYY-MM-DD HH:MI:SS'),3,3,TO_Date('2020-03-15','YYYY-MM-DD'),TO_Date('2020-03-18','YYYY-MM-DD'),'finalizada',03,01,520146331,'baixa');
insert into reserva values(TO_Date('2020-04-01 01:00:00','YYYY-MM-DD HH:MI:SS'),4,3,TO_Date('2020-04-03','YYYY-MM-DD'),TO_Date('2020-04-06','YYYY-MM-DD'),'finalizada',04,01,926199221,'baixa');
insert into reserva values(TO_Date('2020-04-01 01:00:00','YYYY-MM-DD HH:MI:SS'),5,1,TO_Date('2020-04-24','YYYY-MM-DD'),TO_Date('2020-04-27','YYYY-MM-DD'),'finalizada',05,01,154789658,'baixa');
--                    reserva media
insert into reserva values(TO_Date('2020-01-01 01:00:00','YYYY-MM-DD HH:MI:SS'),6,4,TO_Date('2020-05-10','YYYY-MM-DD'),TO_Date('2020-05-12','YYYY-MM-DD'),'finalizada',01,02,520146331,'media');
insert into reserva values(TO_Date('2020-01-01 01:00:00','YYYY-MM-DD HH:MI:SS'),16,4,TO_Date('2020-05-25','YYYY-MM-DD'),TO_Date('2020-05-28','YYYY-MM-DD'),'finalizada',01,02,520146331,'media');
insert into reserva values(TO_Date('2020-06-01 01:00:00','YYYY-MM-DD HH:MI:SS'),7,1,TO_Date('2020-06-15','YYYY-MM-DD'),TO_Date('2020-06-18','YYYY-MM-DD'),'cancelada',02,02,125486325,'media');
insert into reserva values(TO_Date('2020-01-01 01:00:00','YYYY-MM-DD HH:MI:SS'),8,3,TO_Date('2020-07-20','YYYY-MM-DD'),TO_Date('2020-07-23','YYYY-MM-DD'),'finalizada',03,02,520146331,'media');
insert into reserva values(TO_Date('2020-01-01 01:00:00','YYYY-MM-DD HH:MI:SS'),9,2,TO_Date('2020-08-04','YYYY-MM-DD'),TO_Date('2020-08-07','YYYY-MM-DD'),'cancelada',03,02,968547235,'media');
insert into reserva values(TO_Date('2020-01-01 01:00:00','YYYY-MM-DD HH:MI:SS'),10,1,TO_Date('2020-08-06','YYYY-MM-DD'),TO_Date('2020-08-09','YYYY-MM-DD'),'finalizada',03,02,154783586,'media');
--                    reserva alta
insert into reserva values(TO_Date('2020-01-01 01:00:00','YYYY-MM-DD HH:MI:SS'),11,3,TO_Date('2020-09-24','YYYY-MM-DD'),TO_Date('2020-09-27','YYYY-MM-DD'),'finalizada',01,03,157621483,'alta');
insert into reserva values(TO_Date('2020-01-01 01:00:00','YYYY-MM-DD HH:MI:SS'),12,1,TO_Date('2020-10-22','YYYY-MM-DD'),TO_Date('2020-10-25','YYYY-MM-DD'),'finalizada',02,03,111145896,'alta');
insert into reserva values(TO_Date('2020-01-01 01:00:00','YYYY-MM-DD HH:MI:SS'),13,2,TO_Date('2020-11-20','YYYY-MM-DD'),TO_Date('2020-11-23','YYYY-MM-DD'),'reservado',03,01,124795475,'alta');
insert into reserva values(TO_Date('2020-01-01 01:00:00','YYYY-MM-DD HH:MI:SS'),14,3,TO_Date('2020-12-24','YYYY-MM-DD'),TO_Date('2020-12-27','YYYY-MM-DD'),'reservado',04,03,653255558,'alta');
insert into reserva values(TO_Date('2019-06-01 01:00:00','YYYY-MM-DD HH:MI:SS'),15,2,TO_Date('2020-05-28','YYYY-MM-DD'),TO_Date('2020-12-31','YYYY-MM-DD'),'reservado',05,03,365298745,'alta');
insert into reserva values(TO_Date('2019-06-01 01:00:00','YYYY-MM-DD HH:MI:SS'),17,2,TO_Date('2019-05-28','YYYY-MM-DD'),TO_Date('2019-12-31','YYYY-MM-DD'),'finalizada',02,03,125486325,'alta');



insert into reserva values(TO_Date('2020-01-01 01:00:00','YYYY-MM-DD HH:MI:SS'),18,4,TO_Date('2020-05-10','YYYY-MM-DD'),TO_Date('2020-05-11','YYYY-MM-DD'),'finalizada',03,03,520146331,'media');
insert into reserva values(TO_Date('2020-01-01 01:00:00','YYYY-MM-DD HH:MI:SS'),19,4,TO_Date('2020-05-10','YYYY-MM-DD'),TO_Date('2020-05-12','YYYY-MM-DD'),'finalizada',31,02,520146331,'media');

insert into reserva values(TO_Date('2020-01-01 01:00:00','YYYY-MM-DD HH:MI:SS'),20,4,TO_Date('2020-05-01','YYYY-MM-DD'),TO_Date('2020-05-03','YYYY-MM-DD'),'finalizada',31,02,520146331,'media');
insert into reserva values(TO_Date('2020-01-01 01:00:00','YYYY-MM-DD HH:MI:SS'),21,4,TO_Date('2020-05-04','YYYY-MM-DD'),TO_Date('2020-05-06','YYYY-MM-DD'),'finalizada',31,02,520146331,'media');



insert into reserva values(TO_Date('2020-06-01 01:00:00','YYYY-MM-DD HH:MI:SS'),22,1,TO_Date('2020-06-19','YYYY-MM-DD'),TO_Date('2020-06-20','YYYY-MM-DD'),'cancelada',02,02,125486325,'media');
insert into reserva values(TO_Date('2020-01-01 01:00:00','YYYY-MM-DD HH:MI:SS'),23,3,TO_Date('2020-07-24','YYYY-MM-DD'),TO_Date('2020-07-25','YYYY-MM-DD'),'finalizada',03,02,520146331,'media');
insert into reserva values(TO_Date('2020-01-01 01:00:00','YYYY-MM-DD HH:MI:SS'),24,2,TO_Date('2020-08-10','YYYY-MM-DD'),TO_Date('2020-08-11','YYYY-MM-DD'),'cancelada',03,02,968547235,'media');
insert into reserva values(TO_Date('2020-01-01 01:00:00','YYYY-MM-DD HH:MI:SS'),25,1,TO_Date('2020-08-12','YYYY-MM-DD'),TO_Date('2020-08-13','YYYY-MM-DD'),'finalizada',03,02,154783586,'media');

--Conta
insert into conta values(1,to_date('2020-01-15','YYYY-MM-DD'),1);
insert into conta values(2,to_date('2020-02-03','YYYY-MM-DD'),2);
insert into conta values(3,to_date('2020-03-15','YYYY-MM-DD'),3);
insert into conta values(4,to_date('2020-04-24','YYYY-MM-DD'),5);

insert into conta values(5,to_date('2020-04-24','YYYY-MM-DD'),6);
insert into conta values(6,to_date('2020-06-15','YYYY-MM-DD'),7);
insert into conta values(7,to_date('2020-08-04','YYYY-MM-DD'),9);
insert into conta values(8,to_date('2020-08-02','YYYY-MM-DD'),10);

insert into conta values(9,to_date('2020-09-24','YYYY-MM-DD'),11);
insert into conta values(10,to_date('2020-10-22','YYYY-MM-DD'),12);
insert into conta values(11,to_date('2020-11-20','YYYY-MM-DD'),13);
insert into conta values(12,to_date('2020-12-01','YYYY-MM-DD'),15);
insert into conta values(13,to_date('2019-12-01','YYYY-MM-DD'),17);
--Item
insert into item values (1,'coca-cola',1.20);
insert into item values (2,'fanta',1.20);
insert into item values (3,'agua',1.00);
insert into item values (4,'cerveja',1.30);
insert into item values (5,'coca-cola zero',1.20);

insert into item values (6,'cafe',0.80);
insert into item values (7,'coca-cola',1.20);
insert into item values (8,'sumo natural',1.60);
insert into item values (9,'sumo fresco',1.60);
insert into item values (10,'agua fresca',1.00);

insert into item values (11,'iogurte',1.40);
insert into item values (12,'bolo',2.10);
insert into item values (13,'gelado',3.00);
insert into item values (14,'pao',1.50);
insert into item values (15,'gelado',3.00);
insert into item values (16,'kitkat',1.50);
insert into item values (17,'bolachas',1.50);

-- empregados
insert into empregado values (333333333,'Ricardo Freitas Gonï¿½alves','Rua de Bandeiras 245','rfg3333@hotel.pt',912888678);

insert into empregado values (444444444,'Alfredo Maximus Harrington Jorge da Cunha Sr.', 'Rua dos Pescadores 345','amhjc@hotel.pt',935551087);

insert into empregado values (222222222,'Maria Adelaide dos Santos Bandeira','Travessa das Sardinhas 61 3ï¿½Andar D','masb2222@hotel.pt',912554678);
insert into empregado values (555555555,'Maria Julia de Jesus Céus', 'Avenida da Republica 14 5ï¿½Andar Direito','mjjc5555@hotel.pt',919898774);
insert into empregado values (777777777,'Vanessa dos Alves Maia', 'Avenida da beira-mar 32','vam7777@hotel.pt',931145878);
insert into empregado values (888888888,'Manuel Ribeiro Céus','Avenida da Republica 14 5ï¿½Andar Direito','mrc8888@hotel.pt',934555221);
insert into empregado values (999999999,'Luis Ramos Pereira','Rua 25 de abril 333','lrp@hotel.pt',911224556);

insert into empregado values (111111111,'José Manuel Alves Dias','Rua da Cruz 123 2ïº Andar Direito','jmad1111@hotel.pt',934509782);
insert into empregado values (666666666,'Jorge Silva Paiva','Praça dos Estudantes 88 1ï¿½Andar','jsp6666@hotel.pt',922225666);

insert into camareira values (222222222);
insert into camareira values (555555555);
insert into camareira values (777777777);
insert into camareira values (888888888);
insert into camareira values (999999999);

insert into rececao values (444444444);

insert into restauracao values (333333333);

insert into empregadoManutencao values (111111111);
insert into empregadoManutencao values (666666666);

--Clientes  Norte, Centro, Lisboa/Tejo, Alentejo, Algarve
insert into cliente values(123456789,'José Fernandes','cliente1@gmail.com',968547215,'Porto','VilaDoConde','Rua da albergaria, 77');
insert into cliente values(761275207,'Mário Leitão','cliente2@gmail.com',921458978,'Braga','Guimaraes','Rua da maria, 147');
insert into cliente values(520146331,'José Silva','cliente3@gmail.com',936548217,'Vila Real','Vila Real','Rua Vasco da Gama, 7237');

insert into cliente values(926199221,'Duarte Veiga','cliente4@gmail.com',915867278,'Coimbra','Coimbra','Rua da restauracao, 6');
insert into cliente values(154789658,'Madalena Pinto','cliente5@gmail.com',936457817,'Aveiro','Ovar','Rua 5 de outubro, 56');
insert into cliente values(154784523,'Roberto Pereira','cliente6@gmail.com',968751243,'Leiria','Leiria','Rua da na?ao, 89');

insert into cliente values(125486325,'Emanuela Santos','cliente7@gmail.com',912457942,'Lisboa','Lisboa','Rua da vida, 251');
insert into cliente values(138752094,'Dinis Macieira','cliente8@gmail.com',962378171,'Santarem','Santarem','Rua da cidade, 7');
insert into cliente values(968547235,'Jorge Miguel','cliente9@gmail.com',975481217,'Portalegre','Portalegre','Rua da alegria, 2');

insert into cliente values(154783586,'Maria Maia','cliente10@gmail.com',915467218,'Setubal','Setubal','Rua direita, 251');
insert into cliente values(157621483,'Felipe Jesus','cliente11gmail.com',643154927,'Evora','Evora','Rua d, 7');
insert into cliente values(111145896,'Emaneul Santos','cliente12gmail.com',936451872,'Beja','Beja','Rua do Afonso , 2');

insert into cliente values(124795475,'Sara Oliveira','cliente13@gmail.com',915123524,'Faro','Faro','Rua esquerda, 251');
insert into cliente values(653255558,'Fabio Costa','cliente14@gmail.com',965431257,'Faro','MonteGordo','Rua da aventura, 7');
insert into cliente values(365298745,'Jorge Emanuel','cliente15@gmail.com',912762754,'Faro','Portimao','Rua da alegria, 2');
--Produtos comprados
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),1,1,1);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),3,1,2);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),4,1,3);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),4,2,4);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),9,2,5);
insert into produtoscomprados values(TO_Date('2020-01-05','YYYY-MM-DD'),1,2,6);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),2,3,7);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),3,3,8);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),7,3,9);
insert into produtoscomprados values(TO_Date('2020-01-11','YYYY-MM-DD'),3,4,10);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),1,4,11);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),5,4,12);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),2,5,13);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),1,5,14);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),4,5,15);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),1,6,16);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),3,6,17);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),4,6,18);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),4,7,19);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),11,7,20);
insert into produtoscomprados values(TO_Date('2020-02-01','YYYY-MM-DD'),1,7,21);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),12,8,22);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),3,8,24);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),8,9,25);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),9,9,26);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),7,9,27);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),2,10,28);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),1,10,29);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),8,10,30);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),1,11,31);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),3,11,32);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),4,11,33);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),4,12,34);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),9,12,35);
insert into produtoscomprados values(TO_Date('2020-03-01','YYYY-MM-DD'),1,12,36);
insert into produtoscomprados values(TO_Date('2020-03-03','YYYY-MM-DD'),11,12,37);
insert into produtoscomprados values(TO_Date('2020-03-04','YYYY-MM-DD'),4,9,38);
insert into produtoscomprados values(TO_Date('2020-03-05','YYYY-MM-DD'),7,12,39);
insert into produtoscomprados values(TO_Date('2020-04-06','YYYY-MM-DD'),1,9,40);
insert into produtoscomprados values(TO_Date('2020-03-07','YYYY-MM-DD'),5,11,41);
insert into produtoscomprados values(TO_Date('2020-03-08','YYYY-MM-DD'),5,12,42);
insert into produtoscomprados values(TO_Date('2020-03-09','YYYY-MM-DD'),8,12,43);
insert into produtoscomprados values(TO_Date('2020-03-10','YYYY-MM-DD'),11,11,44);
insert into produtoscomprados values(TO_Date('2020-03-01','YYYY-MM-DD'),12,12,45);
insert into produtoscomprados values(TO_Date('2020-01-06','YYYY-MM-DD'),2,9,46);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),13,10,47);
insert into produtoscomprados values(TO_Date('2020-01-01','YYYY-MM-DD'),9,10,48);
insert into produtoscomprados values(TO_Date('2020-01-02','YYYY-MM-DD'),4,10,49);
insert into produtoscomprados values(TO_Date('2020-01-02','YYYY-MM-DD'),1,10,50);
insert into produtoscomprados values(TO_Date('2019-01-02','YYYY-MM-DD'),1,13,51);
insert into produtoscomprados values(TO_Date('2019-01-02','YYYY-MM-DD'),4,13,52);

--PagamentFatura codres desc valor
insert into pagamentofatura values('CartaoDebito',1,50);
insert into pagamentofatura values('CartaoDebito',2,30);
insert into pagamentofatura values('CartaoCredito',3,120);
insert into pagamentofatura values('CartaoDebito',4,350);
insert into pagamentofatura values('CartaoCredito',5,50);

insert into pagamentofatura values('CartaoCredito',6,530);
insert into pagamentofatura values('Cheque',7,440);
insert into pagamentofatura values('Cheque',8,230);
insert into pagamentofatura values('CartaoCredito',9,50);
insert into pagamentofatura values('CartaoDebito',10,60);

insert into pagamentofatura values('Cheque',11,70);
insert into pagamentofatura values('Cheque',12,690);
insert into pagamentofatura values('Cheque',13,256);
insert into pagamentofatura values('CartaoCredito',14,445);
insert into pagamentofatura values('CartaoCredito',15,365);

--fatura
insert into fatura values(1,1);
insert into fatura values(2,2);
insert into fatura values(3,3);
insert into fatura values(4,null);
insert into fatura values(5,4);
insert into fatura values(6,5);
insert into fatura values(7,6);
insert into fatura values(8,null);
insert into fatura values(9,7);
insert into fatura values(10,8);
insert into fatura values(11,9);
insert into fatura values(12,10);
insert into fatura values(13,11);
insert into fatura values(14,null);
insert into fatura values(15,12);



insert into intervencao values (1,1,1,111111111,TO_Date('2020-01-14','YYYY-MM-DD'));
insert into intervencao values (2,1,1,111111111,TO_Date('2020-01-15','YYYY-MM-DD'));
insert into intervencao values (3,1,1,111111111,TO_Date('2020-11-17','YYYY-MM-DD'));
insert into intervencao values (4,2,1,222222222,TO_Date('2020-01-17','YYYY-MM-DD'));
insert into intervencao values (5,2,1,555555555,TO_Date('2020-01-18','YYYY-MM-DD'));
insert into intervencao values (6,2,1,888888888,TO_Date('2020-02-04','YYYY-MM-DD'));
insert into intervencao values (7,3,1,999999999,TO_Date('2020-02-05','YYYY-MM-DD'));
insert into intervencao values (8,3,1,888888888,TO_Date('2020-02-06','YYYY-MM-DD'));
insert into intervencao values (9,3,1,222222222,TO_Date('2020-03-16','YYYY-MM-DD'));
insert into intervencao values (10,4,1,222222222,TO_Date('2020-03-17','YYYY-MM-DD'));
insert into intervencao values (11,4,1,888888888,TO_Date('2020-03-18','YYYY-MM-DD'));
insert into intervencao values (12,4,1,888888888,TO_Date('2020-04-06','YYYY-MM-DD'));
insert into intervencao values (13,5,1,222222222,TO_Date('2020-04-25','YYYY-MM-DD'));
insert into intervencao values (14,5,1,222222222,TO_Date('2020-04-26','YYYY-MM-DD'));
insert into intervencao values (15,5,1,777777777,TO_Date('2020-04-27','YYYY-MM-DD'));


insert into intervencao values (16,1,2,888888888,TO_Date('2020-05-26','YYYY-MM-DD'));
insert into intervencao values (17,1,2,999999999,TO_Date('2020-05-27','YYYY-MM-DD'));
insert into intervencao values (18,1,2,999999999,TO_Date('2020-05-28','YYYY-MM-DD'));
insert into intervencao values (19,2,2,222222222,TO_Date('2020-06-16','YYYY-MM-DD'));
insert into intervencao values (20,2,2,888888888,TO_Date('2020-06-17','YYYY-MM-DD'));
insert into intervencao values (21,2,2,777777777,TO_Date('2020-06-18','YYYY-MM-DD'));
insert into intervencao values (22,3,2,777777777,TO_Date('2020-07-21','YYYY-MM-DD'));
insert into intervencao values (23,3,2,222222222,TO_Date('2020-07-22','YYYY-MM-DD'));
insert into intervencao values (24,3,2,777777777,TO_Date('2020-07-23','YYYY-MM-DD'));
insert into intervencao values (25,3,2,888888888,TO_Date('2020-08-05','YYYY-MM-DD'));
insert into intervencao values (26,3,2,999999999,TO_Date('2020-08-06','YYYY-MM-DD'));
insert into intervencao values (27,3,2,888888888,TO_Date('2020-08-07','YYYY-MM-DD'));
insert into intervencao values (28,3,2,777777777,TO_Date('2020-08-07','YYYY-MM-DD'));
insert into intervencao values (29,3,2,222222222,TO_Date('2020-08-08','YYYY-MM-DD'));
insert into intervencao values (30,1,2,222222222,TO_Date('2020-08-09','YYYY-MM-DD'));
insert into intervencao values (31,1,3,777777777,TO_Date('2020-09-25','YYYY-MM-DD'));
insert into intervencao values (32,1,3,888888888,TO_Date('2020-09-26','YYYY-MM-DD'));
insert into intervencao values (33,1,3,999999999,TO_Date('2020-09-27','YYYY-MM-DD'));
insert into intervencao values (34,2,3,888888888,TO_Date('2020-10-23','YYYY-MM-DD'));
insert into intervencao values (35,2,3,222222222,TO_Date('2020-10-24','YYYY-MM-DD'));
insert into intervencao values (36,2,3,777777777,TO_Date('2020-10-25','YYYY-MM-DD'));
insert into intervencao values (37,3,1,777777777,TO_Date('2020-11-21','YYYY-MM-DD'));
insert into intervencao values (38,3,1,222222222,TO_Date('2020-11-22','YYYY-MM-DD'));
insert into intervencao values (39,3,1,999999999,TO_Date('2020-11-23','YYYY-MM-DD'));
insert into intervencao values (40,4,3,888888888,TO_Date('2020-12-25','YYYY-MM-DD'));
insert into intervencao values (41,4,3,777777777,TO_Date('2020-12-26','YYYY-MM-DD'));
insert into intervencao values (42,4,3,222222222,TO_Date('2020-12-27','YYYY-MM-DD'));
insert into intervencao values (43,5,3,222222222,TO_Date('2020-12-29','YYYY-MM-DD'));
insert into intervencao values (44,5,3,666666666,TO_Date('2020-12-30','YYYY-MM-DD'));
insert into intervencao values (45,5,3,111111111,TO_Date('2020-12-31','YYYY-MM-DD'));

insert into intervencao values (46,1,2,888888888,TO_Date('2020-05-11','YYYY-MM-DD'));
insert into intervencao values (47,1,2,999999999,TO_Date('2020-05-12','YYYY-MM-DD'));
insert into intervencao values (48,1,2,999999999,TO_Date('2020-05-13','YYYY-MM-DD'));
insert into intervencao values (49,1,2,999999999,TO_Date('2020-05-14','YYYY-MM-DD'));
insert into intervencao values (50,1,2,888888888,TO_Date('2020-05-15','YYYY-MM-DD'));
insert into intervencao values (51,1,2,999999999,TO_Date('2019-05-14','YYYY-MM-DD'));
insert into intervencao values (52,1,2,888888888,TO_Date('2019-05-15','YYYY-MM-DD'));



insert into intervencao values (53,1,2,888888888,TO_Date('2020-05-11','YYYY-MM-DD'));
insert into intervencao values (54,1,2,999999999,TO_Date('2020-05-12','YYYY-MM-DD'));

insert into intervencao values (55,3,3,555555555,TO_Date('2020-05-11','YYYY-MM-DD'));


insert into intervencao values (56,31,2,222222222,TO_Date('2020-05-11','YYYY-MM-DD'));
insert into intervencao values (57,31,2,222222222,TO_Date('2020-05-12','YYYY-MM-DD'));

insert into intervencao values (58,31,2,555555555,TO_Date('2020-05-02','YYYY-MM-DD'));
insert into intervencao values (59,31,2,555555555,TO_Date('2020-05-03','YYYY-MM-DD'));

insert into intervencao values (60,31,2,555555555,TO_Date('2020-05-05','YYYY-MM-DD'));
insert into intervencao values (61,31,2,555555555,TO_Date('2020-05-06','YYYY-MM-DD'));


insert into limpeza values (16);
insert into limpeza values (17);
insert into limpeza values (18);

insert into limpeza values (19);
insert into limpeza values (20);
insert into limpeza values (21);
insert into limpeza values (22);
insert into limpeza values (23);
insert into limpeza values (24);

insert into limpeza values (46);
insert into limpeza values (47);

insert into limpeza values (25);
insert into limpeza values (26);
insert into limpeza values (27);
insert into limpeza values (28);
insert into limpeza values (29);
insert into limpeza values (30);

insert into limpeza values (55);

insert into limpeza values (56);
insert into limpeza values (57);


insert into limpeza values (58);
insert into limpeza values (59);

insert into limpeza values (60);
insert into limpeza values (61);

insert into manutencao values(965874482,195563636,44,'canos','aberto');
insert into manutencao values(968874582,192563636,45,'piscina','aberto')
;
insert into manutencao values(968874582,192563636,1,'piscina','aberto');
insert into manutencao values(968874582,192563636,2,'piscina','aberto');
insert into manutencao values(968874582,192563636,3,'piscina','aberto');





