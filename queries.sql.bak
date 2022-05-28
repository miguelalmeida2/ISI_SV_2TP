--3.a)
--2.a)
SELECT casa_apostas, email, nome, nickname
FROM jogador as j
WHERE j.estado = 'activo'

--2.b)
select email, nome, perfil
FROM administrador
GROUP BY perfil, nome, email
--order by perfil, nome, email;

--2.c)
SELECT ca.id, ca.nome, ca.NIPC , COUNT(j)
FROM casa_apostas as ca 
		JOIN jogador as j ON (ca.id = j.casa_apostas)
GROUP BY ca.id, ca.nome, ca.NIPC

--2.d)
SELECT j.nome, COUNT(documento)
FROM documento 
	JOIN jogador as j ON (documento.jogador =  j.id)
GROUP BY j.nome

--2.e)
SELECT t.numero as Aposta_Num,tipo, odd, descricao
FROM aposta as a
	JOIN transacao as t ON (a.transacao = t.numero)
WHERE t.jogador IN(
	SELECT id
	FROM jogador j
	WHERE j.nome = 'Manuel Fernandes')
GROUP BY t.numero, a.tipo, a .odd, a.descricao

--3.b) 
SELECT nome 
FROM administrador
GROUP BY perfil, nome 
ORDER BY nome ASC

--3.c)
SELECT nome, email, nickname
FROM jogador as j
	JOIN transacao as t ON (t.jogador = j.id)
    JOIN bancaria as b ON (b.transacao =  t.numero)
WHERE b.operacao = 'depósito' 
GROUP BY nome, email, nickname 
HAVING COUNT(b.operacao = 'depósito') > 0

--3.d)
SELECT t.casa_apostas, j.email, a.transacao, r.data_resolucao, a.tipo, a.descricao -- r.data_resolucao para confirmar se está certo
FROM aposta as a
	JOIN transacao as t ON (t.numero =  a.transacao)
    left JOIN resolucao as r ON (r.aposta = t.numero)
    JOIN jogador as j ON (j.id = t.jogador)
WHERE r.data_resolucao IS null

--3.e)
CREATE VIEW apostas_lastyear
AS 
SELECT a.transacao as aposta_num, a.tipo, a.odd, a.descricao, r.data_resolucao
FROM aposta as a 
     JOIN transacao as t ON (a.transacao = t.numero)
	 JOIN resolucao as r ON (r.aposta = t.numero)		
WHERE (EXTRACT( YEAR FROM data_transacao) = (EXTRACT(YEAR FROM current_date) -1)) -- Se for no ano passdo YYYY-1


--2 opçao mais eficiente mas n sei como adicionar o dt_resolucao		 
SELECT *
FROM aposta as a
WHERE a.transacao IN(
	SELECT t.numero
	FROM transacao as t 
	WHERE ((EXTRACT( YEAR FROM data_transacao) = (EXTRACT(YEAR FROM current_date) -1)) --Assumindo que é no ano passado YYYY-1
		AND t.numero IN(
		SELECT aposta
		FROM resolucao
		)
	)
)--and  ?? Nâo funciona
--SELECT data_resolucao
--FROM resolucao
--WHERE aposta IN(
--	SELECT numero
--	FROM transacao as t
---	WHERE ((EXTRACT( YEAR FROM data_transacao) = (EXTRACT(YEAR FROM current_date) -1))
--		AND t.numero IN(
--			SELECT transacao 
--			FROM aposta
--		)	 
--	)	
--) 

--3.f)
--??? Falta esta

create view profit
as
(select gain, loss, gain - loss as profit 
from (select
	(select sum(salary) from employee e where dno = 4) as gain,
	(select sum(salary) from empolyee e where dno = 5) as loss) as tb1);

CREATE VIEW Saldo 
as
(SELECT    (deposito-levantamento-aposta+resolucao) as saldo, deposito, levantamento, aposta, resolucao 
FROM( SELECT
		(SELECT j.nome 	   FROM transacao t JOIN jogador j ON (j.id = 2))  ,
		(SELECT SUM(valor) FROM transacao t JOIN bancaria b ON (t.numero = b.transacao) WHERE b.operacao = 'levantamento') as levantamento,
		(SELECT SUM(valor) FROM transacao t JOIN bancaria b ON (t.numero = b.transacao) WHERE b.operacao = 'depósito') as deposito,
		(SELECT SUM(valor) FROM transacao t JOIN aposta a ON (t.numero = a.transacao))  as aposta,
		(SELECT SUM(r.valor) FROM transacao t JOIN resolucao r ON (t.numero = r.aposta and r.resultado = 'vitória')) as resolucao) as tb1);
		
-------
SELECT    (deposito-levantamento-aposta+resolucao) as saldo, deposito, levantamento, aposta, resolucao 
FROM( SELECT
		(SELECT j.nome 	   FROM transacao t JOIN jogador j ON (j.id = 2))  ,
		(SELECT SUM(valor) FROM transacao t JOIN bancaria b ON (t.numero = b.transacao) WHERE b.operacao = 'levantamento' group by t.jogador order by t.jogador asc) as levantamento,
		(SELECT SUM(valor) FROM transacao t JOIN bancaria b ON (t.numero = b.transacao) WHERE b.operacao = 'depósito' group by t.jogador order by t.jogador asc) as deposito,
		(SELECT SUM(valor) FROM transacao t JOIN aposta a ON (t.numero = a.transacao) group by t.jogador order by t.jogador asc)  as aposta,
		(SELECT SUM(r.valor) FROM transacao t JOIN resolucao r ON (t.numero = r.aposta and r.resultado = 'vitória') group by t.jogador order by t.jogador asc) as resolucao) as tb1;		

--4)
BEGIN transaction; 	
INSERT INTO transacao(numero, valor, data_transacao, casa_apostas, jogador)
VALUES((SELECT numero
  FROM transacao 
  ORDER BY numero DESC LIMIT 1)+1, 10, current_date, 1, 2);  
  
INSERT INTO aposta(transacao,tipo,odd,descricao)
VALUES((
  SELECT numero
  FROM transacao 
  ORDER BY numero DESC LIMIT 1), 'simples', 1.2, 'FCP vs SLB - Empate');


COMMIT TRANSACTION; --SE NAO OCORREU NENHUM ERRO
ROLLBACK TRANSACTION;