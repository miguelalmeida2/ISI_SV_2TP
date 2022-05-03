INSERT INTO casa_apostas(id,nome, NIPC, aposta_minima)
VALUES (1, 'Betclic', '600016234', 0.05);

INSERT INTO administrador(id,email,nome,perfil,casa_apostas)
VALUES (1, 'jorge@betclic.pt', 'Jorge Mendes', 'administrador',1);

INSERT INTO administrador(id,email,nome,perfil,casa_apostas)
VALUES (2, 'franciscoR@betclic.pt', 'Francisco Rodrigues', 'operador',1);

INSERT INTO administrador(id,email,nome,perfil,casa_apostas)
VALUES (3, 'catarinaB@betclic.pt', 'Catarina Bacalhau', 'operador',1);

INSERT INTO administrador(id,email,nome,perfil,casa_apostas)
VALUES (4, 'miguelL@betclic.pt', 'Miguel Londers', 'supervisor',1);

INSERT INTO administrador(id,email,nome,perfil,casa_apostas)
VALUES (5, 'ruiM@betclic.pt', 'Rui Machado', 'administrador',1);

INSERT INTO administrador(id,email,nome,perfil,casa_apostas)
VALUES (6, 'saraB@betclic.pt', 'Sara Barradas', 'administrador',1);

INSERT INTO jogador(id, email, nome, nickname, estado, data_nascimento, data_registo, morada, codigo_postal, localidade, casa_apostas)
VALUES	(1, 'luis_serrano@gmail.com', 'Luís Serrano', 'lserras', 'activo', '20000817', '20180917', 'Avenida Almirante Reis 38b', 1100300, 'Lisboa',1);

INSERT INTO jogador(id, email, nome, nickname, estado, data_nascimento, data_registo, morada, codigo_postal, localidade, casa_apostas)
VALUES	(2, 'carlosRosa@gmail.com', 'Carlos Rosa', 'carlRosa', 'activo', '20000228', '20200215', 'Avenida Gago Coutinho 39b', 1100500,'Lisboa',1);

INSERT INTO transacao(numero, valor, data_transacao, casa_apostas, jogador)
VALUES (1, 30, '20220315', 1, 1);

INSERT INTO transacao(numero, valor, data_transacao, casa_apostas, jogador)
VALUES (2, 50, '20220130', 1, 2);

INSERT INTO aposta(transacao,tipo,odd,descricao)
VALUES (1, 'múltipla', 2.43, 'Oposta múltiupla na bundesliga');

INSERT INTO bancaria(transacao,operacao)
VALUES (2, 'depósito');
--DOC jog.id=1
INSERT INTO documento(jogador,numero, descricao, estado, data_submissao)
VALUES (1, 1, 'Documentos do jogador id = 1', 'aceite', '20220414');

INSERT INTO documento(jogador,numero, descricao, estado, data_submissao)
VALUES (1, 2, 'Documentos do jogador id = 1', 'pendente', '20220218');

--DOC jog.id=2
INSERT INTO documento(jogador,numero, descricao, estado, data_submissao)
VALUES (2, 3, 'Documentos do jogador id = 2', 'recusado', '20220119');

INSERT INTO resolucao(id, valor, resultado, data_resolucao, aposta)
VALUES ( 1, 10, 'vitória', '20220428', 1);
