SET SERVEROUTPUT ON;
create or replace procedure prcAtualizarBonusCamareiras(fMes NUMBER, fAno NUMBER := (EXTRACT(YEAR FROM SYSDATE))) is
    vCursorInformacao SYS_REFCURSOR;
    vCamareiraId      varchar(80);
    vCamareiraNome    VARCHAR(30);
    vSoma             INTEGER;
    vDataMaxima       DATE;
    vDataMinima       DATE;
    vDiasSemContar    INTEGER;
    vBonus            NUMBER;
BEGIN
    VCursorInformacao := fncObterRegistoMensalCamareira(fMes, fAno);
    vBonus := 0;
    LOOP
        FETCH VCursorInformacao into vCamareiraId,vCamareiraNome,vSoma,vDataMaxima,vDataMinima,vDiasSemContar;
        EXIT WHEN VCursorInformacao%NOTFOUND;
        vBonus :=0;
        if (vSoma > 1000)
        then
            vBonus := 0.15* vSoma;
        else
            if (vSoma > 499)
            then
                vBonus := 0.10* vSoma;
            else
                if (vSoma > 100)
                then
                    vBonus := 0.05* vSoma;

                end if;
            end if;
        end IF;
        update CAMAREIRA set BONUS = vBonus where ID = vCamareiraId ;
    end loop;

end;

begin
    prcAtualizarBonusCamareiras(9, 2019);
    commit;
end;

select * from camareira;

begin
    prcAtualizarBonusCamareiras(1);
    commit;
end;

select * from camareira;

begin
    prcAtualizarBonusCamareiras(7);
    commit;
end;

select * from camareira;
