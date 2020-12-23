SET SERVEROUTPUT ON;


create or replace function fncObterRegistoMensalCamareira(fMes NUMBER,
                                                          fAno NUMBER := (EXTRACT(YEAR FROM SYSDATE)) - 1)
    return
        sys_refcursor IS
    c_valorAReturnar sys_refcursor;
    fDiasDoMes       number := fncDiasDoMes(fMes, fAno);
begin
    open c_valorAReturnar for
        SELECT I.ID_CAMAREIRA,
               F.NOME,
               (select sum(L.PRECO_UNITARIO)
                FROM LINHA_CONTA_CONSUMO L
                WHERE L.ID_CAMAREIRA = I.ID_CAMAREIRA
                  AND EXTRACT(MONTH FROM L.DATA_REGISTO) = fMes
                  AND EXTRACT(YEAR FROM L.DATA_REGISTO) = fAno)
                ,
               (SELECT MAX(I1.DATA_REGISTO)
                FROM LINHA_CONTA_CONSUMO I1
                WHERE I1.ID_CAMAREIRA = I.ID_CAMAREIRA
                  AND EXTRACT(MONTH FROM I1.DATA_REGISTO) = fMes
                  AND EXTRACT(YEAR FROM I1.DATA_REGISTO) = fAno
               ),
               (SELECT MIN(I1.DATA_REGISTO)
                FROM LINHA_CONTA_CONSUMO I1
                WHERE I1.ID_CAMAREIRA = I.ID_CAMAREIRA
                  AND EXTRACT(MONTH FROM I1.DATA_REGISTO) = fMes
                  AND EXTRACT(YEAR FROM I1.DATA_REGISTO) = fAno
               ),
               fDiasDoMes -
               (SELECT Count(DISTINCT L1.DATA_REGISTO)
                FROM LINHA_CONTA_CONSUMO L1
                WHERE L1.ID_CAMAREIRA = I.ID_CAMAREIRA
                  AND EXTRACT(MONTH FROM L1.DATA_REGISTO) = fMes
                  AND EXTRACT(YEAR FROM L1.DATA_REGISTO) = fAno
               )
        FROM CAMAREIRA C
                 INNER JOIN FUNCIONARIO F on C.ID = F.ID
                 INNER JOIN LINHA_CONTA_CONSUMO I on F.ID = I.ID_CAMAREIRA

        where EXTRACT(MONTH FROM I.DATA_REGISTO) = fMes
          and EXTRACT(YEAR FROM I.DATA_REGISTO) = fAno

        GROUP BY I.ID_CAMAREIRA, F.NOME
        ORDER BY I.ID_CAMAREIRA;

    return c_valorAReturnar;
end;

create or replace function fncDiasDoMes(fMes NUMBER, fAno NUMBER)

    return
        number is
    fDiasNoMes      number;
    fAnoBisextoFlag number := 0;
    fResto          number := remainder(fAno, 4);
begin
    if (fResto = 0)
    then
        fAnoBisextoFlag := 1;
    end if;
    if (fMes = 1 or fMes = 3 or fMes = 5 or fMes = 7 or fMes = 8 or fMes = 10 or fMes = 12)
    then
        fDiasNoMes := 31;
    else
        if (fMes = 4 or fMes = 6 or fMes = 9 or fMes = 11)
        then
            fDiasNoMes := 30;
        else
            fDiasNoMes := 28 + fAnoBisextoFlag;
        end if;
    end if;

    return fDiasNoMes;
end;



DECLARE
    vEmp_refcur_local SYS_REFCURSOR;
    vEmpno            varchar(80);
    vName             VARCHAR(30);
    vSoma             INTEGER;
    vData1            DATE;
    vData2            DATE;
    vValor            INTEGER;
BEGIN
    --Calling the function using parameters
    vEmp_refcur_local := fncObterRegistoMensalCamareira(9);
    LOOP
        FETCH vEmp_refcur_local into vEmpno,vName,vSoma ,vData1,vData2,vValor;
        EXIT WHEN vEmp_refcur_local%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(
                    'ID: ' || vEmpno || '/ NOME: ' || vName || ' SOMA: ' || vSoma || ' DATA MAXIMA ' || vData1 ||
                    ' DATA MINIMA ' || vData2 || ' DIAS SEM COSNUMO REGISTADO ' || vValor);
    END LOOP;
END;



DECLARE
    vEmp_refcur_local SYS_REFCURSOR;
    vEmpno            varchar(80);
    vName             VARCHAR(30);
    vSoma             INTEGER;
    vData1            DATE;
    vData2            DATE;
    vValor            INTEGER;
BEGIN
    --Calling the function using parameters
    vEmp_refcur_local := fncObterRegistoMensalCamareira(1, 2020);
    LOOP
        FETCH vEmp_refcur_local into vEmpno ,vName,vSoma ,vData1 ,vData2,vValor;
        EXIT WHEN vEmp_refcur_local%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(
                    'ID: ' || vEmpno || '/ NOME: ' || vName || ' SOMA: ' || vSoma || ' DATA MAXIMA ' || vData1 ||
                    ' DATA MINIMA ' || vData2 || ' DIAS SEM NADA ' || vValor);
    END LOOP;
END;

DECLARE
    vEmp_refcur_local SYS_REFCURSOR;
    vEmpno            varchar(80);
    vName             VARCHAR(30);
    vSoma             INTEGER;
    vData1            DATE;
    vData2            DATE;
    vValor            INTEGER;
BEGIN
    --Calling the function using parameters
    vEmp_refcur_local := fncObterRegistoMensalCamareira(7, 2020);
    LOOP
        FETCH vEmp_refcur_local into vEmpno ,vName ,vSoma ,vData1,vData2,vValor;
        EXIT WHEN vEmp_refcur_local%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(
                    'ID: ' || vEmpno || '/ NOME: ' || vName || ' SOMA: ' || vSoma || ' DATA MAXIMA ' || vData1 ||
                    ' DATA MINIMA ' || vData2 || ' DIAS SEM NADA ' || vValor);
    END LOOP;
END;