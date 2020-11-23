
-- 1) Mostrar todos os dados da tabela CD;
    SELECT * FROM CD;

-- 2) Mostrar todos os dados da tabela Musica.
    SELECT * FROM MUSICA;

--#### A.Projeção ####################################################################################################################

-- 1) Mostrar o título e a data de compra de todos os CD;
    SELECT TITULO, DATACOMPRA FROM CD;

-- 2) Mostrar a data de compra de todos os CD;
    SELECT DATACOMPRA FROM CD;

-- 3) Mostrar o resultado da alínea anterior, mas sem registos repetidos;
    SELECT DISTINCT DATACOMPRA FROM CD;

-- 4) Mostrar o código dos CD e os respetivos intérpretes, sem registos repetidos;
    SELECT DISTINCT CODCD, INTERPRETE FROM MUSICA;

-- 5) Mostrar o resultado anterior com a primeira coluna intitulada "Código do CD"; 
    SELECT DISTINCT CODCD AS "Código do CD" , INTERPRETE FROM MUSICA;

-- 6) Mostrar o título, o valor pago e o respetivo valor do IVA de todos os CD. O valor do IVA é calculado de acordo com a 
--    seguinte fórmula: valor do IVA = (valor pago * 0.23)/1.23.   
    SELECT TITULO , VALORPAGO, ROUND((VALORPAGO*0.23)/1.23,2) IVAPAGO FROM CD;


--#### B.Seleção #####################################################################################################################

--1) Mostrar todos os dados das músicas do CD com o código 2;
    SELECT * FROM MUSICA WHERE CODCD=2;

--2) Mostrar todos os dados das músicas que não pertencem ao CD com o código 2;
    SELECT * FROM MUSICA WHERE CODCD!=2;

--3) Mostrar todos os dados das músicas do CD com o código 2 cuja duração seja superior a 5;
    SELECT * FROM MUSICA WHERE CODCD=2 AND DURACAO>5;

--4) Mostrar todos os dados das músicas do CD com o código 2 cuja duração pertença ao intervalo [4,6];
    SELECT * FROM MUSICA WHERE CODCD=2 AND DURACAO BETWEEN 4 AND 6;

--5) Mostrar todos os dados das músicas do CD com o código 2 cuja duração seja inferior a 4 ou superior a 6;
    SELECT * FROM MUSICA WHERE CODCD=2 AND DURACAO<4 OR DURACAO>6;

--6) Mostrar todos os dados das músicas com o número: 1, 3, 5 ou 6;
    SELECT * FROM MUSICA WHERE NRMUSICA IN (1,3,5,6);

--7) Mostrar todos os dados das músicas com o número diferente de 1, 3, 5 e 6;
    SELECT * FROM MUSICA WHERE NRMUSICA NOT IN (1,3,5,6);

--8) Mostrar todos os dados das músicas cujo intérprete é uma orquestra;
    SELECT * FROM MUSICA WHERE UPPER(INTERPRETE) LIKE ('%ORQUESTRA%');

--9) Mostrar todos os dados das músicas cujo nome do intérprete tem a letra Y;
    SELECT * FROM MUSICA WHERE UPPER(INTERPRETE) LIKE ('%Y%');

--10) Mostrar todos os dados das músicas cujo nome termina com DAL?, sendo ? qualquer caráter;
    SELECT * FROM MUSICA WHERE UPPER(TITULO) LIKE ('%DAL%');

--11) Mostrar todos os dados das músicas cujo título tem o caráter %;
    SELECT * FROM MUSICA WHERE UPPER(TITULO) LIKE '%\%%' ESCAPE '\';

--12) Mostrar todos os dados das músicas cujo título é iniciado pela letra B, D ou H;
    SELECT * FROM MUSICA WHERE TITULO LIKE ('B%') OR TITULO LIKE ('D%') OR TITULO LIKE ('H%');

--13) Mostrar todos os dados dos CD sem o local de compra registado;
    SELECT * FROM CD WHERE LOCALCOMPRA IS NULL;

--14) Mostrar todos os dados dos CD com o local de compra registado.
    SELECT * FROM CD WHERE LOCALCOMPRA IS NOT NULL;
	

--#### C.Projeção e Seleção ##########################################################################################################

--1) Mostrar os títulos dos CD comprados na FNAC;
    SELECT TITULO FROM CD WHERE UPPER(LOCALCOMPRA) LIKE ('FNAC');

--2) Mostrar os títulos dos CD que não foram comprados na FNAC.
    SELECT TITULO FROM CD WHERE UPPER(LOCALCOMPRA) NOT LIKE ('FNAC') OR LOCALCOMPRA IS NULL;


--#### D.Ordenação ###################################################################################################################

--1) Mostrar os títulos dos CD que não foram comprados na FNAC, por ordem alfabética inversa; 
    SELECT TITULO FROM CD WHERE UPPER(LOCALCOMPRA) NOT LIKE ('FNAC') OR LOCALCOMPRA IS NULL ORDER BY TITULO DESC;

--2) Mostrar o título e a data de compra dos CD, por ordem alfabética do título do CD;
    SELECT TITULO, DATACOMPRA FROM CD ORDER BY TITULO ASC;

--3) Mostrar o título e a data de compra dos CD, por ordem descendente da data de compra do CD;
    SELECT TITULO, DATACOMPRA FROM CD ORDER BY DATACOMPRA DESC;

--4) Mostrar o título e o local de compra dos CD, por ordem ascendente do local de compra do CD;
    SELECT TITULO, LOCALCOMPRA FROM CD ORDER BY LOCALCOMPRA ASC;

--5) Mostrar o resultado da alínea anterior, mas por ordem descendente do local de compra do CD;
    SELECT TITULO, LOCALCOMPRA FROM CD ORDER BY LOCALCOMPRA DESC;

--6) Mostrar o título, o valor pago e o respetivo valor do IVA dos CD, por ordem decrescente do IVA;
    SELECT TITULO, VALORPAGO, ROUND((VALORPAGO*0.23)/1.23,2) IVAPAGO FROM CD ORDER BY IVAPAGO DESC;

--7) Mostrar o título do CD por ordem descendente da data de compra e, no caso da igualdade de datas, por ordem alfabética do título.
    SELECT TITULO, DATACOMPRA FROM CD ORDER BY DATACOMPRA DESC, TITULO ASC; 


--#### E.Funções de Agregação #######################################################################################################

--1) Mostrar a quantidade de músicas;
    SELECT COUNT(*) AS "QTD DE MÚSICAS" FROM MUSICA;

--2) Mostrar a quantidade de locais de compra distintos;
    SELECT COUNT(DISTINCT LOCALCOMPRA) AS "QTD LOCAIS" FROM CD;

--3) Mostrar o total gasto com a compra de todos os CD, o maior e o menor valor pago por um CD;
    SELECT SUM(VALORPAGO) AS "TOTAL FNAC", MAX(VALORPAGO) AS "MAIOR", MIN(VALORPAGO) AS "MENOR" FROM CD;

--4) Mostrar a média da duração de todas as músicas;
    SELECT ROUND(AVG(DURACAO),2) AS "DURAÇÃO MÉDIA" FROM MUSICA;

--5) Mostrar o total do valor pago na FNAC;
    SELECT SUM(VALORPAGO) AS "TOTAL FNAC" FROM CD WHERE UPPER(LOCALCOMPRA) LIKE ('%FNAC%');

--6) Mostrar a diferença entre o maior e o menor valor pago na FNAC.
    SELECT MAX(VALORPAGO)-MIN(VALORPAGO) AS "DIFERENÇA FNAC" FROM CD WHERE UPPER(LOCALCOMPRA) LIKE ('%FNAC%');


