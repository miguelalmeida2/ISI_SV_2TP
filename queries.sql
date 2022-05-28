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
SELECT ca.id, ca.nome, ca.NIPC , COUNT(j) as num_jog
FROM casa_apostas as ca 
		JOIN jogador as j ON (ca.id = j.casa_apostas)
GROUP BY ca.id, ca.nome, ca.NIPC

--2.d)
SELECT j.nome, COUNT(documento) as num_doc
FROM documento 
	right JOIN jogador as j ON (documento.jogador =  j.id)
GROUP BY j.id,j.nome
order by j.id asc --beautify

--2.e)
select distinct  t.numero as Aposta_Num,tipo, odd, descricao
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
WHERE exists(
		select count(*)
		from bancaria b 
		where t.numero = b.transacao  and b.operacao = 'levantamento'
		group by b.operacao
		HAVING COUNT(*) > 0
)  

--3.d)
SELECT t.casa_apostas, j.email, a.transacao, r.data_resolucao, a.tipo, a.descricao -- r.data_resolucao para confirmar se está certo
FROM aposta as a
	JOIN transacao as t ON (t.numero =  a.transacao)
    left JOIN resolucao as r ON (r.aposta = t.numero)
    JOIN jogador as j ON (j.id = t.jogador)
WHERE r.data_resolucao IS null
order by a.transacao 

--3.e)
CREATE VIEW apostas_lastyear
AS 
SELECT a.transacao as aposta_num, a.tipo, a.odd, a.descricao, r.data_resolucao, r.resultado 
FROM aposta as a 
     JOIN transacao as t ON (a.transacao = t.numero)
	 JOIN resolucao as r ON (r.aposta = t.numero)		
WHERE (EXTRACT( YEAR FROM data_transacao) = (EXTRACT(YEAR FROM current_date) -1)) -- Se for no ano passdo YYYY-1

 

--3.f)
create view saldo
as
SELECT   coalesce(jogador.id,levantamento.jogador, deposito.jogador, aposta.jogador, resultado.jogador) as Jogador_Id,  coalesce(max(deposito.depo), 0.0) - coalesce(max(levantamento.leva), 0.0) - coalesce(max(aposta.apos), 0.0) + coalesce(max(resultado.res), 0.0)  as saldo 
from	(select id from jogador where estado = 'activo') as jogador
		left outer join(
		SELECT t.jogador,SUM(t.valor) as leva FROM transacao t JOIN bancaria b ON (t.numero = b.transacao) WHERE b.operacao = 'levantamento' group by t.jogador order by t.jogador) as levantamento
		on( jogador.id = levantamento.jogador)
		full outer join( 
		SELECT   t.jogador ,SUM(t.valor) as depo FROM transacao t JOIN bancaria b2 ON (t.numero = b2.transacao)  WHERE b2.operacao = 'depósito' group by t.jogador order by t.jogador) as deposito
		on (greatest (jogador.id,levantamento.jogador) = deposito.jogador) 
		full outer join( 
		SELECT  t.jogador,SUM(valor) as apos FROM transacao t JOIN aposta a ON (t.numero = a.transacao) group by t.jogador order by t.jogador)  as aposta
		on ( greatest(levantamento.jogador,jogador.id, deposito.jogador) = aposta.jogador)
		full outer join(
		SELECT  t.jogador, SUM(r.valor) as res FROM transacao t JOIN resolucao r ON (t.numero = r.aposta and r.resultado = 'vitória') group by t.jogador order by t.jogador) as resultado
		on(greatest(jogador.id,deposito.jogador,levantamento.jogador,aposta.jogador) = resultado.jogador)
		group by  jogador.id, levantamento.jogador, deposito.jogador , aposta.jogador, resultado.jogador
		order by  jogador.id, levantamento.jogador, deposito.jogador , aposta.jogador, resultado.jogador asc 

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