SET SERVEROUTPUT ON;
create or replace trigger trgCorrigirAlteracaoBonus
    before
        update of BONUS
    on CAMAREIRA
    for each row
declare
    vOldValue    number := :old.BONUS;
    vNewValue    number := :new.BONUS;
    vDifOfValues float  := vNewValue - vOldValue ;
begin

    if (vDifOfValues < 0)
    then
        :new.BONUS := vOldValue;
        raise_application_error(-20000,'Valor de bónus menor que o atual');
    else
        if (vDifOfValues * 2 > vOldValue)
        then
            :new.BONUS := vOldValue;
            raise_application_error(-20001,'Valor de bónus inválido');
        end if;
    end if;
end;


declare
    vValorToUpdate number := 0;
begin
    update CAMAREIRA set BONUS =vValorToUpdate;
    commit;
end;

select *
from CAMAREIRA;


declare
    vValorToUpdate number := 20;
begin
    update CAMAREIRA set BONUS =vValorToUpdate
    where id=11;
    
    commit;
end;

select *
from CAMAREIRA;

declare
    vValorToUpdate number := 12;
begin
    update CAMAREIRA set BONUS =vValorToUpdate
    where id =11 
    ;
    commit;
end;

select *
from CAMAREIRA;