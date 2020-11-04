--A.1)	Obter o produto cartesiano (i.e. CROSS JOIN) entre as tabelas Empregado e 
--EmpregadoEfetivo, de acordo com a Figura 2. 
    SELECT
    empregado.idempregado           AS "ID_EMPREGADO",
    empregadoefetivo.idempregado    AS "ID_EMPREGADO_EFETIVO"
FROM
         empregado
    CROSS JOIN empregadoefetivo
ORDER BY
    empregado.idempregado ASC,
    empregadoefetivo.idempregado ASC;

--A.2)	Obter toda a informação dos empregados efetivos, por ordem alfabética dos 
--nomes e de acordo com a Figura 3. 
   SELECT
    *
FROM
         empregado
    NATURAL JOIN empregadoefetivo
ORDER BY
    empregado.nome ASC;
   
--A.3)	Obter as faltas dos empregados efetivos, de acordo com a Figura 4.
    SELECT
    empregadoefetivo.idempregado,
    falta.datainicio,
    falta.datafim,
    falta.justificacao
FROM
         empregadoefetivo
    INNER JOIN falta ON falta.idempregado = empregadoefetivo.idempregado;

--A.4)	Obter as faltas dos empregados temporários, de acordo com a Figura 5.
    SELECT
    empregado.nome,
    empregado.nridentificacaocivil,
    empregado.idempregado,
    falta.datainicio,
    falta.datafim,
    falta.justificacao
FROM
         empregado
    INNER JOIN empregadoefetivo ON empregado.idempregado = empregadoefetivo.idempregado
    INNER JOIN falta ON empregado.idempregado = falta.idempregado;

--A.5)	Obter as avaliações dos empregados temporários, de acordo com a Figura 6.
    SELECT
    empregado.nome,
    empregado.nridentificacaocivil,
    empregadodepartamento.iddepartamento,
    empregadodepartamento.datainicio,
    empregadodepartamento.datafim,
    avaliacao.descricao
FROM
         empregadodepartamento
    INNER JOIN empregado ON empregadodepartamento.idempregado = empregado.idempregado
    INNER JOIN avaliacaotemporario ON empregadodepartamento.datainicio = avaliacaotemporario.datainicio
    INNER JOIN avaliacao ON avaliacaotemporario.idavaliacao = avaliacao.idavaliacao
ORDER BY
    empregado.nome ASC;
    
--A.6)	Obter o nome e o número de identificação civil de todos empregados que 
--nunca faltaram, de acordo com a Figura 7.
    SELECT
    empregado.nome,
    empregado.nridentificacaocivil
FROM
    empregado
    LEFT JOIN falta ON empregado.idempregado = falta.idempregado
WHERE
    falta.idempregado IS NULL;
 
--A.7)	Obter o identificador e a designação de todos os departamentos juntamente 
--com a designação do respetivo departamento do nível hierárquico superior. 
--O resultado apresentado deve estar de acordo com a Figura 8. 
    SELECT
    d.iddepartamento,
    d.designacao,
    nvl(dns.designacao, ' ') AS departamento_nivel_superior
FROM
    departamento  d
    FULL OUTER JOIN departamento  dns ON d.iddepartamentosuperior = dns.iddepartamento
WHERE
    d.iddepartamento IS NOT NULL
ORDER BY
    d.designacao DESC;
    
--A.8)	Obter pares de empregados distintos e com idades diferentes, de acordo 
--com a Figura 9. 
    SELECT
    e1.idempregado,
    e1.nome,
    e2.idempregado,
    e2.nome
FROM
         empregado e1
    INNER JOIN empregado e2 ON EXTRACT(YEAR FROM e1.datanascimento) > EXTRACT(YEAR FROM e2.datanascimento)
ORDER BY
    e1.idempregado,
    e2.idempregado ASC 
 
--B.1)	Obter o nome e o número de identificação civil de todos os empregados que 
--tiveram pelo menos uma avaliação "MUITO BOM". O resultado apresentado deve estar de acordo com a Figura 10.
    SELECT DISTINCT 
    empregado.nome,
    empregado.nridentificacaocivil
FROM
         avaliacao
    INNER JOIN avaliacaotemporario ON avaliacaotemporario.idavaliacao = avaliacao.idavaliacao
    INNER JOIN avaliacaoefetivo ON avaliacaoefetivo.idavaliacao = avaliacao.idavaliacao
    INNER JOIN empregado ON avaliacaoefetivo.idempregado = empregado.idempregado OR avaliacaotemporario.idempregado = empregado.idempregado
WHERE
    avaliacao.descricao LIKE ( 'MUITO BOM' )
ORDER BY
    empregado.nridentificacaocivil asc;
 
--B.2)	Obter a descrição das avaliações que são comuns a empregados efetivos e 
--temporários, de acordo com a Figura 11.
    SELECT DISTINCT
    avaliacao.descricao
FROM
         avaliacao
    INNER JOIN avaliacaotemporario ON avaliacao.idavaliacao = avaliacaotemporario.idavaliacao
    INNER JOIN avaliacaoefetivo ON avaliacao.idavaliacao = avaliacaoefetivo.idavaliacao
ORDER BY
    avaliacao.descricao ASC
 
--B.3)	Obter o nome e o número de identificação civil dos empregados efetivos que 
--tiveram sempre classificação “MUITO BOM”, de acordo com a Figura 12.
    SELECT DISTINCT
    empregado.nome,
    empregado.nridentificacaocivil
FROM
         avaliacao
    INNER JOIN avaliacaoefetivo ON avaliacaoefetivo.idavaliacao = avaliacao.idavaliacao
    INNER JOIN empregado ON avaliacaoefetivo.idempregado = empregado.idempregado
WHERE
    ( (
        SELECT
            COUNT(avaliacaoefetivo.idavaliacao)
        FROM
            avaliacaoefetivo
        WHERE
            avaliacaoefetivo.idavaliacao LIKE ( 'MB' )
            AND avaliacaoefetivo.idempregado = empregado.idempregado
    ) = (
        SELECT
            COUNT(avaliacaoefetivo.idempregado)
        FROM
            avaliacaoefetivo
        WHERE
            avaliacaoefetivo.idempregado = empregado.idempregado
    ) )
ORDER BY
    empregado.nridentificacaocivil ASC;    
 
--B.4)	Obter o nome e o número de identificação civil dos empregados efetivos 
--cujas férias têm todas duração superior a 15 dias. 
--O resultado apresentado deve estar de acordo com a Figura 13.
    SELECT DISTINCT
    empregado.nome,
    empregado.nridentificacaocivil
FROM
         ferias
    INNER JOIN empregado ON ferias.idempregado = empregado.idempregado
WHERE
    ( (
        SELECT
            COUNT(ferias.idempregado)
        FROM
            ferias
        WHERE
            ferias.idempregado = empregado.idempregado
    ) = (
        SELECT
            COUNT(ferias.idempregado)
        FROM
            ferias
        WHERE
                ( ferias.datafim - ferias.datainicio ) > 15
            AND ferias.idempregado = empregado.idempregado
    ) )
ORDER BY
    empregado.nome ASC;  