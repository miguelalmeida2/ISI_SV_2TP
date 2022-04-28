BEGIN transaction;

--ADMINISTRADOR(id, email, nome, perfil, casa_apostas)
create table if not exists administrador(
	id int,
	email varchar(60) primary key,
	nome varchar(150),
	perfil varchar(15),
	casa_apostas int
	);

--APOSTA(transacao, tipo, odd, descricao)
create table if not exists aposta(
	transacao int,
	tipo varchar(15),
	odd int,
	descricao varchar(150)
);


--BANCARIA(transacao, operacao)
create table if not exists bancaria(
	transacao int,
	operacao int
);

--CASA_APOSTAS(id, nome, NIPC, aposta_minima)
create table if not exists casa_apostas(
	id int,
	nome varchar(150),
	NIPC varchar(9),
	aposta_minima real
);

--DOCUMENTO(jogador, numero, descricao, estado, data_registo)
create table if not exists documento(
	jogador int,
	numero int,
	descricao varchar(150),
	estado varchar(15),
	data_submissao date
);

--JOGADOR(id, email, nome, nickname, estado, data_nascimento, data_registo, morada, codigo_postal, localidade, casa_apostas)
create table if not exists jogador(
	id int,
	email varchar(60),
	nome varchar(150),
	nickname varchar(20),
	estado varchar(15),
	data_nascimento date,
	data_registo date,
	morada varchar(150),
	codigo_posta int,
	localidade varchar(50),
	casa_apostas int
);

--RESOLUCAO(id, valor, resultado, data_resolucao, aposta)
create table if not exists resolucao(
	id int,
	valor real,
	resultado varchar(15),
	data_resolucao date,
	aposta int
);

--TRANSACAO(numero, valor, data_transacao, casa_apostas, jogador)
create table if not exists transacao(
	numero int,
	valor real,
	data_transacao date,
	casa_apostas int,
	jogador int
);

COMMIT transaction;
