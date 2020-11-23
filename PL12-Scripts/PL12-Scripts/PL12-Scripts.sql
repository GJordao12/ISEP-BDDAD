--5. Criar um script com comandos SQL para efetuarem, sobre a BD, as seguintes consultas:
    --1) Mostrar o nome dos médicos que receitaram mais de três medicamentos em cada uma das suas
    --consultas (Figura 2). Considerar apenas médicos que tenham mais do que uma consulta. O resultado
    --deve ser apresentado por ordem alfabética do nome dos médicos.
SELECT
    medico.nome
FROM
         consulta c1
    INNER JOIN medico ON medico.idmedico = c1.idmedico
WHERE
    (
        SELECT
            COUNT(idmedico)
        FROM
            consulta c2
        WHERE
            c2.idmedico = medico.idmedico
    ) = (
        SELECT
            COUNT(c3.idconsulta)
        FROM
            consulta c3
        WHERE
                medico.idmedico = c3.idmedico
            AND (
                SELECT
                    COUNT(m2.idconsulta)
                FROM
                    medicamentoreceitado m2
                WHERE
                    c3.idconsulta = m2.idconsulta
            ) > 3
    )
GROUP BY
    c1.idmedico,
    medico.nome
HAVING
    COUNT(*) > 1;
    
    --2) Mostrar o nome dos médicos, que receitaram sempre o mesmo número de medicamentos em todas
    --as suas consultas, juntamente com esse número (Figura 3). O resultado deve ser apresentado por
    --ordem alfabética do nome dos médicos.
    
    SELECT
    medico.nome,
    medicamentoreceitado.idconsulta,
    COUNT(*)
FROM
         consulta c1
    INNER JOIN medico ON medico.idmedico = c1.idmedico
    INNER JOIN medicamentoreceitado ON medicamentoreceitado.idconsulta = c1.idconsulta
GROUP BY
    c1.idmedico,
    medico.nome,
    medicamentoreceitado.idconsulta
ORDER BY
    medico.nome;

SELECT
    nome,
    COUNT(DISTINCT contador) AS medicamentos_contador
FROM
    (
        SELECT
            medico.nome,
            medicamentoreceitado.idconsulta,
            consulta.idmedico,
            COUNT(*) AS contador
        FROM
                 consulta
            INNER JOIN medico ON medico.idmedico = consulta.idmedico
            INNER JOIN medicamentoreceitado ON medicamentoreceitado.idconsulta = consulta.idconsulta
        GROUP BY
            consulta.idmedico,
            medico.nome,
            medicamentoreceitado.idconsulta
        ORDER BY
            medico.nome
    ) tabela
WHERE
    nome = tabela.nome
GROUP BY
    nome;