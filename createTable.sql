--CASA_APOSTAS(id, nome, NIPC, aposta_minima)
create table if not exists casa_apostas(
	id 				serial,
	nome 			varchar(150) NOT NULL,
	NIPC 			varchar(9) NOT NULL,
	aposta_minima 	DECIMAL NOT NULL, --CHECK( aposta_minima SIMILAR TO '_%._%,')
	PRIMARY KEY 	(id)
);

--ADMINISTRADOR(id, email, nome, perfil, casa_apostas)
create table if not exists administrador(
	id 				integer NOT NULL, --CHECK (id>0)??,
	email 			varchar(60) NOT NULL CHECK (email SIMILAR TO '_%@_%')  UNIQUE ,
	nome 			varchar(150) NOT NULL,
	perfil 			varchar(15) CHECK (perfil = 'administrador' or perfil = 'supervisor' or perfil = 'operador'),
	casa_apostas 	INTEGER NOT NULL,
	PRIMARY KEY 	(id)
);

--APOSTA(transacao, tipo, odd, descricao)
create table if not exists aposta(
	transacao 		integer NOT NULL,
	tipo 			varchar(15) CHECK (tipo = 'simples' or tipo = 'múltipla'),
	odd 			integer CHECK (odd >= 1),
	descricao 		varchar(150),
	PRIMARY KEY 	(transacao)

);


--BANCARIA(transacao, operacao)
create table if not exists bancaria(
	transacao 		INTEGER NOT NULL,
	operacao 		VARCHAR(15) CHECK (operacao = 'depósito' or operacao = 'levantamento'),
	PRIMARY KEY 	(transacao)
);

--DOCUMENTO(jogador, numero, descricao, estado, data_registo)
create table if not exists documento(
	jogador 		INTEGER NOT NULL,
	numero 			integer NOT NULL CHECK (numero > 0),
	descricao 		varchar(150) NOT NULL,
	estado 			varchar(15) CHECK(estado = 'pendente' or estado = 'aceite' or estado = 'recusado'),
	data_submissao 	date,
	PRIMARY KEY 	(jogador, numero)

);

--JOGADOR(id, email, nome, nickname, estado, data_nascimento, data_registo, morada, codigo_postal, localidade, casa_apostas)
create table if not exists jogador(
	id 				integer NOT NULL,
	email 			varchar(60)  UNIQUE  NOT NULL CHECK (email SIMILAR TO '_%@_%'),
	nome 			varchar(150) NOT NULL,
	nickname 		varchar(20)  UNIQUE  NOT NULL,
	estado 			varchar(15) DEFAULT 'activo',
	data_nascimento date, --CHECK ( DATEDIFF(data, data_nascimento, CURRENT_DATE) >= 18) ,
	data_registo 	date, -- CHECK ( DATEDIFF(year, data_registo ,data_nascimento) > 18) AND data_registo < CURRENT_DATE)  ,
	morada 			varchar(150) NOT NULL,
	codigo_postal	integer	NOT NULL CHECK (codigo_postal > 999999 AND codigo_postal < 10000000),
	localidade 		varchar(50) NOT NULL,
	casa_apostas 	integer NOT NULL,
	PRIMARY KEY 	(id)
);

--RESOLUCAO(id, valor, resultado, data_resolucao, aposta)
create table if not exists resolucao(
	id 				integer NOT NULL,
	valor 			real NOT NULL,
	resultado 		varchar(15) CHECK (resultado = 'vitória' or resultado ='derrota' or resultado ='cashout' or resultado ='reembolso'),
	data_resolucao 	date,
	aposta 			integer NOT NULL,
	PRIMARY KEY 	(id)
);

--TRANSACAO(numero, valor, data_transacao, casa_apostas, jogador)
create table if not exists transacao(
	numero 			integer NOT NULL,
	valor 			real,
	data_transacao 	date,
	casa_apostas 	integer NOT NULL,
	jogador			integer NOT NULL,
	PRIMARY KEY  	(numero)
);

ALTER TABLE administrador
	ADD CONSTRAINT casa_apostasFK FOREIGN key 	(casa_apostas) REFERENCES casa_apostas (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE aposta
	ADD CONSTRAINT transacaoNumFk FOREIGN KEY 	(transacao)REFERENCES TRANSACAO (numero) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE bancaria
	ADD CONSTRAINT transacaoNumFk FOREIGN KEY 	(transacao)REFERENCES TRANSACAO (numero) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE documento
	ADD CONSTRAINT	jogadorIdFk FOREIGN KEY 	(jogador) REFERENCES JOGADOR (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE jogador
	ADD CONSTRAINT casa_apostasFK FOREIGN key 	(casa_apostas) REFERENCES casa_apostas (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE resolucao
	ADD CONSTRAINT	transacaoNumFk FOREIGN KEY 	(aposta) REFERENCES TRANSACAO (numero) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE transacao
	ADD CONSTRAINT casa_apostasFK FOREIGN KEY 	(casa_apostas) REFERENCES CASA_APOSTAS (id)ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE transacao
	ADD CONSTRAINT jogadorIdFk FOREIGN KEY  	(jogador) REFERENCES JOGADOR (id) ON DELETE CASCADE ON UPDATE CASCADE;