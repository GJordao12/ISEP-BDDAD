-- Ex 5
CREATE or REPLACE FUNCTION fncTotalClients RETURN INTEGER IS
    numClients int;
BEGIN
    SELECT COUNT(*) INTO numClients
        FROM cliente;
    RETURN numClients;
END;


set SERVEROUTPUT ON;

DECLARE
    ex_NoClient exception;
    numClients int;
BEGIN
    numClients :=  fncTotalClients();
    IF numClients>0 THEN
        dbms_output.put_line('Total of clients is ' || to_CHAR(numClients));
    ELSE
        raise ex_NoClient;
    END IF;

exception
    when ex_NoClient THEN
        raise_application_error(-20001, 'No clients registred');

END;

-- Ex 6
CREATE or REPLACE FUNCTION fncHasBooksPublisher(publisher Editora.idEditora%type) RETURN boolean IS
    numBooks int;
    auxPublisher Editora.idEditora%type;
BEGIN
    SELECT editora.idEditora into auxPublisher from editora WHERE editora.idEditora = publisher;
    SELECT COUNT(*) INTO numBooks
        FROM Editora, EdicaoLivro WHERE EdicaoLivro.idEditora = Editora.idEditora 
            AND Editora.idEditora = publisher AND EdicaoLivro.stock>0;
    RETURN numBooks>0;
exception
  when no_data_found then
    return null;
END;


-- alternative
CREATE or REPLACE FUNCTION fncHasBooksPublisher(publisher Editora.idEditora%type) RETURN boolean IS
    numBooks int;
    auxPublisher int;
BEGIN
    SELECT count(*) into auxPublisher from editora WHERE editora.idEditora = publisher;
    if auxPublisher = 0 THEN
        return NULL;
    end if;
    SELECT COUNT(*) INTO numBooks
        FROM Editora, EdicaoLivro WHERE EdicaoLivro.idEditora = Editora.idEditora 
            AND Editora.idEditora = publisher AND EdicaoLivro.stock>0;
    RETURN numBooks>0;
END;

-- Test
set SERVEROUTPUT ON;

DECLARE
    ex_NoPublisher exception;
    hasBooks boolean;
    publisher int;
BEGIN
    publisher := 1400;
    hasBooks := fncHasBooksPublisher(publisher);
    IF hasBooks is null THEN
        raise ex_NoPublisher;
    ELSE
        if hasBooks then
            dbms_output.put_line('There are books from publisher ' || to_char(publisher));
        ELSE
            dbms_output.put_line('There are no books from publisher ' || to_char(publisher));
        end if;        
    END IF;

exception
    when ex_NoPublisher THEN
        raise_application_error(-20001, 'No such publisher');
END;

--
-- Ex 7
--
CREATE or REPLACE FUNCTION fncClientInfo(cid Cliente.nifCliente%type) RETURN sys_refcursor IS
    rfCur  sys_refcursor;
BEGIN
    open rfCur for
        SELECT c.nome, c.morada, c.codPostal, cp.localidade FROM  Cliente c INNER JOIN CodigoPostal cp
            ON c.codPostal = cp.codPostal
            WHERE c.nifCliente = cid;
    RETURN rfCur;
END;

--
-- Teste
--
SET SERVEROUTPUT ON

DECLARE
    rfc SYS_REFCURSOR;
    cNIF int;
    cName Cliente.nome%TYPE;
    cMorada Cliente.morada%TYPE;
    cCodPostal Cliente.codPostal%TYPE;
    cLocalidade CodigoPostal.localidade%TYPE;
BEGIN
    cNIF := 90080010;
    rfc := fncClientInfo(cNIF);

    
    FETCH rfc INTO
            cName, cMorada, cCodPostal, cLocalidade;
    IF NOT rfc%NOTFOUND THEN
        dbms_output.put_line(cNIF || ' - ' || cName);
    ELSE
        RAISE NO_DATA_FOUND;
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No such client ' || cNIF);
END;

--
-- Ex 8
--
CREATE or REPLACE FUNCTION fncStockYearPublisher(pubid Editora.idEditora%type, 
                            targetYear int DEFAULT EXTRACT(year from SYSDATE())) 
                            RETURN sys_refcursor IS
    rfStock  sys_refcursor;
    dummy int;
BEGIN
    SELECT count(*) INTO dummy FROM Editora WHERE idEditora = pubid;
    if dummy = 0 then
        RAISE NO_DATA_FOUND;
    end if;
    IF targetYear > EXTRACT(year from SYSDATE()) OR targetYear <2000 THEN
        RAISE INVALID_NUMBER;
    END IF;
    open rfStock for
        SELECT ed.isbn, lv.titulo, ed.stock FROM  EdicaoLivro ed INNER JOIN Livro lv
            ON ed.idLivro = lv.idLivro
            WHERE ed.idEditora = pubid and ed.anoEdicao = targetYear;
    RETURN rfStock;
END;

-- Test
SET SERVEROUTPUT ON

DECLARE
    rfc SYS_REFCURSOR;
    edID INT;
    lISBN EdicaoLivro.isbn%type;
    lTitulo Livro.titulo%TYPE;
    lStock EdicaoLivro.stock%TYPE;

BEGIN
    edID := 1900;
    rfc := fncStockYearPublisher(edID, 2020);
    
    IF rfc is not NULL THEN
    LOOP
        FETCH rfc INTO lISBN, lTitulo, lStock;
        EXIT WHEN rfc%NOTFOUND;    
        dbms_output.put_line(lISBN || ' - ' || lTitulo || ' - ' || lStock);
    END LOOP;
    ELSE
        dbms_output.put_line('No such publisher or year ');
    end if;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No such publisher ');
    WHEN INVALID_NUMBER THEN    
        dbms_output.put_line('Not a valid year ');
END;