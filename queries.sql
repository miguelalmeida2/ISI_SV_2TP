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