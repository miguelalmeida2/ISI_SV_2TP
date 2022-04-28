--apaga todos os dados existentes nas tabelas
BEGIN transaction;

DELETE FROM administrador;
DELETE FROM aposta;
DELETE FROM bancaria;
DELETE FROM casa_apostas;
DELETE FROM documento;
DELETE FROM jogador;
DELETE FROM resolucao;
DELETE FROM transacao;

COMMIT transaction;


