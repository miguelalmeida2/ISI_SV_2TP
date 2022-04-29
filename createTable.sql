BEGIN transaction;

--CASA_APOSTAS(id, nome, NIPC, aposta_minima)
create table if not exists casa_apostas(
	id 				INTEGER NOT NULL,
	nome 			varchar(150) NOT NULL,
	NIPC 			varchar(9) NOT NULL,
	aposta_minima 	real,
	PRIMARY KEY 	(id)
);

--ADMINISTRADOR(id, email, nome, perfil, casa_apostas)
create table if not exists administrador(
	id 				integer NOT NULL CHECK (id>0),
	email 			varchar(60) Constraint admin_email UNIQUE (email) NOT NULL,
	nome 			varchar(150) NOT NULL,
	perfil 			varchar(15) CHECK (perfil = 'admistrador' or perfil = 'supervisor' or perfil = 'operador'),
	casa_apostas 	INTEGER,
	PRIMARY KEY 	(id),
	FOREIGN key 	(casa_apostas) REFERENCES casa_apostas (id)
	);

--APOSTA(transacao, tipo, odd, descricao)
create table if not exists aposta(
	transacao 		integer NOT NULL,
	tipo 			varchar(15) CHECK (tipo = 'simples' or tipo = 'múltipla',
	odd 			integer CHECK (odd > 1),
	descricao 		varchar(150),
	PRIMARY KEY 	(transacao),
	FOREIGN KEY 	(transacao)REFERENCES TRANSACAO (id)
);


--BANCARIA(transacao, operacao)
create table if not exists bancaria(
	transacao 		INTEGER NOT NULL,
	operacao 		INTEGER CHECK (operacao = 'depósito' or operacao = 'levantamento'),
	PRIMARY KEY 	(transacao),
	FOREIGN KEY 	(transavao) REFERENCES TRANSACAO (numero)


--DOCUMENTO(jogador, numero, descricao, estado, data_registo)
create table if not exists documento(
	jogador 		INTEGER NOT NULL,
	numero 			integer NOT NULL CHECK (numero > 0),
	descricao 		varchar(150) NOT NULL,
	estado 			varchar(15) CHECK(estado = 'pendente' or estado = 'aceite' or estado = 'recusado',
	data_submissao 	date,
	PRIMARY KEY 	(jogador, numero),
	FOREIGN KEY 	(jogador) REFERENCES JOGADOR (id)
);

--JOGADOR(id, email, nome, nickname, estado, data_nascimento, data_registo, morada, codigo_postal, localidade, casa_apostas)
create table if not exists jogador(
	id 				integer NOT NULL,
	email 			varchar(60) Constraint jog_email UNIQUE (email) NOT NULL,
	nome 			varchar(150) NOT NULL,
	nickname 		varchar(20)  Constraint player_name UNIQUE (nickname) NOT NULL,
	estado 			varchar(15) DEFAULT 'activo',
	data_nascimento date CHECK ( getdate - data_nascimento > 18) ,
	data_registo 	date CHECK (data_registo - data_nascimento > 18 and data_registo < getdate())   ,
	morada 			varchar(150) NOT NULL,
	codigo_posta	integer	NOT NULL,
	localidade 		varchar(50) NOT NULL,
	casa_apostas 	integer NOT NULL,
	PRIMARY KEY 	(id)
	FOREIGN key 	(casa_apostas) REFERENCES casa_apostas (id)
	
);

--RESOLUCAO(id, valor, resultado, data_resolucao, aposta)
create table if not exists resolucao(
	id 				integer NOT NULL,
	valor 			real NOT NULL,
	resultado 		varchar(15) CHECK (resultado = 'vitória' or resultado ='derrota' or resultado ='cashout' or resultado ='reembolso')
	data_resolucao 	date,
	aposta 			integer NOT NULL,
	PRIMARY KEY 	(id)
	FOREIGN KEY 	(aposta) REFERENCES TRANSACAO (id)
);

--TRANSACAO(numero, valor, data_transacao, casa_apostas, jogador)
create table if not exists transacao(
	numero 			integer NOT NULL,
	valor 			real,
	data_transacao 	date,
	casa_apostas 	integer NOT NULL,
	jogador			integer NOT NULL,
	PRIMARY KEY  	(numero)
	FOREIGN KEY 	(casa_apostas) REFERENCES CASA_APOSTAS (id),
	FOREIGN KEY  	(jogador) REFERENCES JOGADOR (id)
);

COMMIT transaction;
