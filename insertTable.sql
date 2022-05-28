BEGIN transaction;
INSERT INTO casa_apostas(id,nome, NIPC, aposta_minima)
VALUES (1, 'Betclic', '600016234', 0.05),(2, 'Betano', '80884442', 0.01);

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

INSERT INTO jogador(id, email, nome, nickname, estado, data_nascimento, data_registo, morada, codigo_postal, localidade, casa_apostas)
VALUES	(3, 'ManuelFernandes@gmail.com', 'Manuel Fernandes', 'FernManuel', 'activo', '19950228', '20200415', 'Rua dos Gambuzinos', 1100700,'Torres Vedras',1);

INSERT INTO jogador(id, email, nome, nickname, estado, data_nascimento, data_registo, morada, codigo_postal, localidade, casa_apostas)
VALUES	(4, 'JoaquimGoncalves@gmail.com', 'Joaquim Goncalves', 'JoaquimGonca', 'activo', '19850228', '20200215', 'Rua dos Esquilos', 1100800,'Torres Vedras',2),
(5, 'JoanaLuis@gmail.com', 'Joana Luis', 'JoanaL', 'activo', '19750228', '20200115', 'Rua do Brasil', 1100900,'Torres Vedras',2),
(6, 'FranciscoMedeiros@gmail.com', 'Francisco Medeiros', 'FranMedeiros', 'activo', '20000817', '20200115', 'Rua da Fonte Nova', 1100700,'Lisboa',1);


INSERT INTO transacao(numero, valor, data_transacao, casa_apostas, jogador)
VALUES (1, 100, '20210315', 1, 1);

INSERT INTO transacao(numero, valor, data_transacao, casa_apostas, jogador)
VALUES (2, 20, '20220130', 1, 2);

INSERT INTO transacao(numero, valor, data_transacao, casa_apostas, jogador)
VALUES (3, 30, '20220315', 1, 1);

INSERT INTO transacao(numero, valor, data_transacao, casa_apostas, jogador)
VALUES (4, 40, '20210130', 1, 2);

INSERT INTO transacao(numero, valor, data_transacao, casa_apostas, jogador)
VALUES (5, 50, '20220315', 1, 1);

INSERT INTO transacao(numero, valor, data_transacao, casa_apostas, jogador)
VALUES (6, 60, '20220315', 1, 2);

INSERT INTO transacao(numero, valor, data_transacao, casa_apostas, jogador)
VALUES (7, 70, '20220315', 1, 1);

INSERT INTO transacao(numero, valor, data_transacao, casa_apostas, jogador)
VALUES (8, 80, '20220315', 1, 1);

INSERT INTO transacao(numero, valor, data_transacao, casa_apostas, jogador)
VALUES (9, 90, '20220415', 1, 3);

INSERT INTO transacao(numero, valor, data_transacao, casa_apostas, jogador)
VALUES (10, 100, '20220515', 1, 3);

INSERT INTO transacao(numero, valor, data_transacao, casa_apostas, jogador)
VALUES (11, 110, '20220315', 1, 3);

INSERT INTO transacao(numero, valor, data_transacao, casa_apostas, jogador)
VALUES (12, 120, '20220115', 1, 6);

INSERT INTO aposta(transacao,tipo,odd,descricao)
VALUES (1, 'múltipla', 1.43, 'Oposta múltiupla  com clubes da bundesliga');

INSERT INTO aposta(transacao,tipo,odd,descricao)
VALUES (2, 'múltipla', 2.43, 'Oposta múltiupla com clubes da laliga e bundesliga');

INSERT INTO aposta(transacao,tipo,odd,descricao)
VALUES (3, 'simples', 3.43, 'Oposta múltiupla  com clubes da ubereats');

INSERT INTO aposta(transacao,tipo,odd,descricao)
VALUES (4, 'múltipla', 4.43, 'Oposta múltiupla  com clubes da serie A');

INSERT INTO aposta(transacao,tipo,odd,descricao)
VALUES (5, 'simples', 5.43, 'Oposta múltiupla  com clubes da liga NOS');

INSERT INTO aposta(transacao,tipo,odd,descricao)
VALUES (8, 'simples', 8.43, 'Oposta múltiupla  com clubes da liga MLS');

INSERT INTO aposta(transacao,tipo,odd,descricao)
VALUES (9, 'múltipla', 9.43, 'Oposta múltiupla  com clubes da laliga');

INSERT INTO aposta(transacao,tipo,odd,descricao)
VALUES (10, 'múltipla', 10.43, 'Oposta múltiupla  com clubes do brasileirão');

INSERT INTO bancaria(transacao,operacao)
VALUES (6, 'depósito');

INSERT INTO bancaria(transacao,operacao)
VALUES (11, 'depósito');

INSERT INTO bancaria(transacao,operacao)
VALUES (7, 'levantamento');

INSERT INTO bancaria(transacao,operacao)
VALUES (12, 'levantamento');



--DOC jog.id=1
INSERT INTO documento(jogador,numero, descricao, estado, data_submissao)
VALUES (1, 1, 'Documentos do jogador id = 1', 'aceite', '20220414');

INSERT INTO documento(jogador,numero, descricao, estado, data_submissao)
VALUES (1, 2, 'Documentos do jogador id = 1', 'pendente', '20220218');

--DOC jog.id=2
INSERT INTO documento(jogador,numero, descricao, estado, data_submissao)
VALUES (2, 3, 'Documentos do jogador id = 2', 'recusado', '20220119');


INSERT INTO resolucao(id, valor, resultado, data_resolucao, aposta)
VALUES ( 1, 143, 'vitória', '20210428', 1);

INSERT INTO resolucao(id, valor, aposta) -- Aposta pendente 
VALUES ( 2, 0, 2);

INSERT INTO resolucao(id, valor, aposta) -- Aposta pendente
VALUES ( 3, 0, 3);

INSERT INTO resolucao(id, valor, resultado, data_resolucao, aposta)
VALUES ( 4, 0, 'derrota', '20220125', 4);

INSERT INTO resolucao(id, valor, resultado, data_resolucao, aposta)
VALUES ( 5, 0, 'derrota', '20220125', 5);
COMMIT TRANSACTION;