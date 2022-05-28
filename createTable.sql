--CASA_APOSTAS(id, nome, NIPC, aposta_minima)
create table if not exists casa_apostas(
	id 				serial CHECK (id >0),
	nome 			varchar(150) NOT NULL,
	NIPC 			varchar(9) NOT NULL,
	aposta_minima 	DECIMAL NOT NULL, --CHECK( aposta_minima SIMILAR TO '_%._%,')
	PRIMARY KEY 	(id)
);

--ADMINISTRADOR(id, email, nome, perfil, casa_apostas)
create table if not exists administrador(
	id 				serial  NOT NULL CHECK (id>0), 
	email 			varchar(60) NOT NULL CHECK (email SIMILAR TO '_%@_%')  UNIQUE ,
	nome 			varchar(150) NOT NULL,
	perfil 			varchar(15) CHECK (perfil in('administrador','supervisor','operador')),
	casa_apostas 	INTEGER NOT NULL,
	PRIMARY KEY 	(id)
);

--APOSTA(transacao, tipo, odd, descricao)
create table if not exists aposta(
	transacao 		integer NOT NULL CHECK (transacao>0),
	tipo 			varchar(15) CHECK (tipo = 'simples' or tipo = 'múltipla'),
	odd 			real CHECK (odd >= 1),
	descricao 		varchar(150),
	PRIMARY KEY 	(transacao)

);


--BANCARIA(transacao, operacao)
create table if not exists bancaria(
	transacao 		INTEGER NOT NULL CHECK (transacao>0),
	operacao 		VARCHAR(15) CHECK (operacao = 'depósito' or operacao = 'levantamento'),
	PRIMARY KEY 	(transacao)
);

--DOCUMENTO(jogador, numero, descricao, estado, data_registo)
create table if not exists documento(
	jogador 		INTEGER NOT NULL ,
	numero 			integer NOT NULL CHECK (numero > 0),
	descricao 		varchar(150) NOT NULL,
	estado 			varchar(15) CHECK(estado in('pendente','aceite','recusado')),
	data_submissao 	date,
	PRIMARY KEY 	(jogador, numero)

);

--JOGADOR(id, email, nome, nickname, estado, data_nascimento, data_registo, morada, codigo_postal, localidade, casa_apostas)
create table if not exists jogador(
	id 				integer NOT NULL CHECK (id>0),
	email 			varchar(60)  UNIQUE  NOT NULL CHECK (email SIMILAR TO '_%@_%'),
	nome 			varchar(150) NOT NULL,
	nickname 		varchar(20)  UNIQUE  NOT NULL,
	estado 			varchar(15) DEFAULT 'activo',
	data_nascimento date, CHECK ( (data_nascimento between date '1900-01-01' and current_date) and (CURRENT_DATE - data_nascimento) >= 6574),
	data_registo 	date, CHECK (((data_registo - data_nascimento) >= 6574) AND data_registo < CURRENT_DATE) ,
	morada 			varchar(150) NOT NULL,
	codigo_postal	integer	NOT NULL CHECK (codigo_postal < 9999999 AND codigo_postal > 0),
	localidade 		varchar(50) NOT NULL,
	casa_apostas 	integer NOT NULL CHECK (casa_apostas > 0),
	PRIMARY KEY 	(id)
);

--RESOLUCAO(id, valor, resultado, data_resolucao, aposta)
create table if not exists resolucao(
	id 				integer NOT NULL CHECK (id>0),
	valor 			real NOT NULL DEFAULT 0,
	resultado 		varchar(15) CHECK (resultado in( 'vitória','derrota','cashout','reembolso'),
	data_resolucao 	date,
	aposta 			integer NOT NULL,
	PRIMARY KEY 	(id)
);

--TRANSACAO(numero, valor, data_transacao, casa_apostas, jogador)
create table if not exists transacao(
	numero 			integer NOT NULL CHECK (numero>0),
	valor 			real check (valor >= 0),
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