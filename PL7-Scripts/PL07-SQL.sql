
-- 1) Mostrar todos os dados da tabela CD;
    SELECT * FROM CD;

-- 2) Mostrar todos os dados da tabela Musica.
    SELECT * FROM MUSICA;

--#### A.Proje��o ####################################################################################################################

-- 1) Mostrar o t�tulo e a data de compra de todos os CD;
    SELECT TITULO, DATACOMPRA FROM CD;

-- 2) Mostrar a data de compra de todos os CD;
    SELECT DATACOMPRA FROM CD;

-- 3) Mostrar o resultado da al�nea anterior, mas sem registos repetidos;
    SELECT DISTINCT DATACOMPRA FROM CD;

-- 4) Mostrar o c�digo dos CD e os respetivos int�rpretes, sem registos repetidos;
    SELECT DISTINCT CODCD, INTERPRETE FROM MUSICA;

-- 5) Mostrar o resultado anterior com a primeira coluna intitulada "C�digo do CD"; 
    SELECT DISTINCT CODCD AS "C�digo do CD" , INTERPRETE FROM MUSICA;

-- 6) Mostrar o t�tulo, o valor pago e o respetivo valor do IVA de todos os CD. O valor do IVA � calculado de acordo com a 
--    seguinte f�rmula: valor do IVA = (valor pago * 0.23)/1.23.   
    SELECT TITULO , VALORPAGO, ROUND((VALORPAGO*0.23)/1.23,2) IVAPAGO FROM CD;


--#### B.Sele��o #####################################################################################################################

--1) Mostrar todos os dados das m�sicas do CD com o c�digo 2;
    SELECT * FROM MUSICA WHERE CODCD=2;

--2) Mostrar todos os dados das m�sicas que n�o pertencem ao CD com o c�digo 2;
    SELECT * FROM MUSICA WHERE CODCD!=2;

--3) Mostrar todos os dados das m�sicas do CD com o c�digo 2 cuja dura��o seja superior a 5;
    SELECT * FROM MUSICA WHERE CODCD=2 AND DURACAO>5;

--4) Mostrar todos os dados das m�sicas do CD com o c�digo 2 cuja dura��o perten�a ao intervalo [4,6];
    SELECT * FROM MUSICA WHERE CODCD=2 AND DURACAO BETWEEN 4 AND 6;

--5) Mostrar todos os dados das m�sicas do CD com o c�digo 2 cuja dura��o seja inferior a 4 ou superior a 6;
    SELECT * FROM MUSICA WHERE CODCD=2 AND DURACAO<4 OR DURACAO>6;

--6) Mostrar todos os dados das m�sicas com o n�mero: 1, 3, 5 ou 6;
    SELECT * FROM MUSICA WHERE NRMUSICA IN (1,3,5,6);

--7) Mostrar todos os dados das m�sicas com o n�mero diferente de 1, 3, 5 e 6;
    SELECT * FROM MUSICA WHERE NRMUSICA NOT IN (1,3,5,6);

--8) Mostrar todos os dados das m�sicas cujo int�rprete � uma orquestra;
    SELECT * FROM MUSICA WHERE UPPER(INTERPRETE) LIKE ('%ORQUESTRA%');

--9) Mostrar todos os dados das m�sicas cujo nome do int�rprete tem a letra Y;
    SELECT * FROM MUSICA WHERE UPPER(INTERPRETE) LIKE ('%Y%');

--10) Mostrar todos os dados das m�sicas cujo nome termina com DAL?, sendo ? qualquer car�ter;
    SELECT * FROM MUSICA WHERE UPPER(TITULO) LIKE ('%DAL%');

--11) Mostrar todos os dados das m�sicas cujo t�tulo tem o car�ter %;
    SELECT * FROM MUSICA WHERE UPPER(TITULO) LIKE '%\%%' ESCAPE '\';

--12) Mostrar todos os dados das m�sicas cujo t�tulo � iniciado pela letra B, D ou H;
    SELECT * FROM MUSICA WHERE TITULO LIKE ('B%') OR TITULO LIKE ('D%') OR TITULO LIKE ('H%');

--13) Mostrar todos os dados dos CD sem o local de compra registado;
    SELECT * FROM CD WHERE LOCALCOMPRA IS NULL;

--14) Mostrar todos os dados dos CD com o local de compra registado.
    SELECT * FROM CD WHERE LOCALCOMPRA IS NOT NULL;
	

--#### C.Proje��o e Sele��o ##########################################################################################################

--1) Mostrar os t�tulos dos CD comprados na FNAC;
    SELECT TITULO FROM CD WHERE UPPER(LOCALCOMPRA) LIKE ('FNAC');

--2) Mostrar os t�tulos dos CD que n�o foram comprados na FNAC.
    SELECT TITULO FROM CD WHERE UPPER(LOCALCOMPRA) NOT LIKE ('FNAC') OR LOCALCOMPRA IS NULL;


--#### D.Ordena��o ###################################################################################################################

--1) Mostrar os t�tulos dos CD que n�o foram comprados na FNAC, por ordem alfab�tica inversa; 
    SELECT TITULO FROM CD WHERE UPPER(LOCALCOMPRA) NOT LIKE ('FNAC') OR LOCALCOMPRA IS NULL ORDER BY TITULO DESC;

--2) Mostrar o t�tulo e a data de compra dos CD, por ordem alfab�tica do t�tulo do CD;
    SELECT TITULO, DATACOMPRA FROM CD ORDER BY TITULO ASC;

--3) Mostrar o t�tulo e a data de compra dos CD, por ordem descendente da data de compra do CD;
    SELECT TITULO, DATACOMPRA FROM CD ORDER BY DATACOMPRA DESC;

--4) Mostrar o t�tulo e o local de compra dos CD, por ordem ascendente do local de compra do CD;
    SELECT TITULO, LOCALCOMPRA FROM CD ORDER BY LOCALCOMPRA ASC;

--5) Mostrar o resultado da al�nea anterior, mas por ordem descendente do local de compra do CD;
    SELECT TITULO, LOCALCOMPRA FROM CD ORDER BY LOCALCOMPRA DESC;

--6) Mostrar o t�tulo, o valor pago e o respetivo valor do IVA dos CD, por ordem decrescente do IVA;
    SELECT TITULO, VALORPAGO, ROUND((VALORPAGO*0.23)/1.23,2) IVAPAGO FROM CD ORDER BY IVAPAGO DESC;

--7) Mostrar o t�tulo do CD por ordem descendente da data de compra e, no caso da igualdade de datas, por ordem alfab�tica do t�tulo.
    SELECT TITULO, DATACOMPRA FROM CD ORDER BY DATACOMPRA DESC, TITULO ASC; 


--#### E.Fun��es de Agrega��o #######################################################################################################

--1) Mostrar a quantidade de m�sicas;
    SELECT COUNT(*) AS "QTD DE M�SICAS" FROM MUSICA;

--2) Mostrar a quantidade de locais de compra distintos;
    SELECT COUNT(DISTINCT LOCALCOMPRA) AS "QTD LOCAIS" FROM CD;

--3) Mostrar o total gasto com a compra de todos os CD, o maior e o menor valor pago por um CD;
    SELECT SUM(VALORPAGO) AS "TOTAL FNAC", MAX(VALORPAGO) AS "MAIOR", MIN(VALORPAGO) AS "MENOR" FROM CD;

--4) Mostrar a m�dia da dura��o de todas as m�sicas;
    SELECT ROUND(AVG(DURACAO),2) AS "DURA��O M�DIA" FROM MUSICA;

--5) Mostrar o total do valor pago na FNAC;
    SELECT SUM(VALORPAGO) AS "TOTAL FNAC" FROM CD WHERE UPPER(LOCALCOMPRA) LIKE ('%FNAC%');

--6) Mostrar a diferen�a entre o maior e o menor valor pago na FNAC.
    SELECT MAX(VALORPAGO)-MIN(VALORPAGO) AS "DIFEREN�A FNAC" FROM CD WHERE UPPER(LOCALCOMPRA) LIKE ('%FNAC%');


