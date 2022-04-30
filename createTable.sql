BEGIN transaction;

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
	id 				integer NOT NULL,
	email 			varchar(60) NOT NULL CHECK (email SIMILAR TO '_%@_%'), --Constraint admin_email UNIQUE (email),
	nome 			varchar(150) NOT NULL,
	perfil 			varchar(15) CHECK (perfil = 'admistrador' or perfil = 'supervisor' or perfil = 'operador'),
	casa_apostas 	INTEGER NOT NULL,
	PRIMARY KEY 	(id)	
);

--APOSTA(transacao, tipo, odd, descricao)
create table if not exists aposta(
	transacao 		integer NOT NULL,
	tipo 			varchar(15) CHECK (tipo = 'simples' or tipo = 'múltipla'),
	odd 			integer CHECK (odd > 1),
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
	id 				integer NOT null,
	email 			varchar(60) NOT NULL CHECK (email SIMILAR TO '_%@_%'), --Constraint jog_email UNIQUE (email) ,
	nome 			varchar(150) NOT NULL,
	nickname 		varchar(20) NOT null, --Constraint player_name UNIQUE (nickname),
	estado 			varchar(15) DEFAULT 'activo' check(estado = 'activo' or estado = 'suspenso' or estado = 'autoexcluido'),
	data_nascimento date CHECK ( DATEDIFF (YEAR, data_nascimento, getdate()) > 18) ,
    data_registo     date CHECK ( (DATEDIFF (year, data_registo ,data_nascimento) > 18) and data_registo < CURRENT_DATE) ,
	morada 			varchar(150) NOT NULL,
	codigo_posta	integer	NOT NULL CHECK (codpostal > 999999 AND codpostal < 10000000),
	localidade 		varchar(50) NOT NULL,
	casa_apostas 	integer NOT NULL,
	PRIMARY KEY 	(id)	
	constraint ageAbove18 check ((data_nascimento + '18 years'::interval)::date <= current_date)
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
	ADD CONSTRAINT	casa_apostasFK FOREIGN key 	(casa_apostas) REFERENCES casa_apostas (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE resolucao 
	ADD CONSTRAINT	transacaoNumFk FOREIGN KEY 	(aposta) REFERENCES TRANSACAO (numero) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE transacao 
	ADD CONSTRAINT casa_apostasFK FOREIGN KEY 	(casa_apostas) REFERENCES CASA_APOSTAS (id)ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE transacao 
	ADD CONSTRAINT jogadorIdFk FOREIGN KEY  	(jogador) REFERENCES JOGADOR (id) ON DELETE CASCADE ON UPDATE CASCADE;
	
COMMIT transaction;