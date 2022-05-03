--3.a)
--2.a)
SELECT casa_apostas, email, nome, nickname
FROM jogador as j
WHERE j.estado = 'activo'

--2.b)
select email, nome, perfil
FROM administrador
GROUP BY perfil, nome, email; --?N está a dar a 100% 

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
SELECT COUNT(transacao) as Aposta_Num,tipo, odd, descricao
FROM aposta as a
	JOIN transacao as t ON (a.transacao = t.numero)
	JOIN jogador as j ON (j.id = t.jogador)
WHERE j.nome = 'Luís Serrano'
GROUP BY a.tipo, a .odd, a.descricao

--3.b) Não está completo. Não sei onde se vai buscar a dt_registo
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
    JOIN resolucao as r ON (r.aposta = t.numero)
    JOIN jogador as j ON (j.id = t.jogador)
--WHERE (r.data_resolucao - current_date > 0)
WHERE r.data_resolucao IS NULL

--3.e)
--CREATE VIEW apostas_lastyear
--AS 
SELECT a.transacao as aposta_num, a.tipo, a.odd, a.descricao, r.data_resolucao
FROM aposta as a 
     JOIN transacao as t ON (a.transacao = t.numero)
	 JOIN resolucao as r ON (r.aposta = t.numero)
WHERE ((current_date-t.data_transacao) > 0 and  (current_date-t.data_transacao) < 365); -- Se for no ultimo ano(365 dias)
WHERE (EXTRACT( YEAR FROM data_transacao) = (EXTRACT(YEAR FROM current_date) -1)) -- Se for no ano passdo YYYY-1


--2 opçao mais eficiente mas n sei como adicionar o dt_resolucao		 
SELECT *
FROM aposta as a
WHERE a.transacao IN(
	SELECT numero
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

 