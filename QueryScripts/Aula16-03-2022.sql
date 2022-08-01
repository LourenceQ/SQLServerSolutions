SELECT * FROM estudante

SELECT(CONVERT(VARCHAR(10), nascimento, 23))  FROM estudante


SELECT(CONVERT(VARCHAR(10), nascimento, 23))  FROM estudante

SELECT id, nome, nascimento, DATEDIFF(YEAR,nascimento, GETDATE()) AS ANOS 
FROM estudante

ALTER TABLE estudante ADD created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

CASE WHEN DATEPART(quarter,[Date]) >= 3 THEN 2 ELSE 1 END as [Semester],
DATEPART(quarter,[Date]) as [Quarter]

/*selecionar primeiro ou segundo semestre*/
select 
    CASE WHEN month([nascimento]) < 7 then  'Primeiro semestre'
    else 'Segundo semestre'
    end as Semestre
FROM estudante
WHERE YEAR(nascimento) = '2000'

/*------------------------------------------------*/
/*visualizar padrao de data*/
SELECT	nascimento,
FORMAT(nascimento, 'd/M/yyyy') 
FROM estudante;

/*------------------------------------------------*/

/*Contagem*/

SELECT COUNT(*) AS total FROM estudante;

/*------------------------------------------------*/
/*agregate*/
SELECT COUNT (*) FROM estudante WHERE YEAR(nascimento) = '2000'

SELECT MAX(id) FROM estudante;

SELECT MIN(id) FROM estudante;

exec sp_help estudante

/*Group by (agrupar por)*/

SELECT id, nome
from (select id, nome from estudante 
group by nascimento) estudante

select	year(nascimento), count(id), avg(nota) as quantidade from estudante group by year(nascimento)


select	year(nascimento), count(id), avg(nota) as quantidade from estudante group by year(nascimento)
having count (id) > 1;




