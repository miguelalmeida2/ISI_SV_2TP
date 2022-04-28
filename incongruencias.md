NIPC começa com 900 ou 500 e tem 9 dígitos

duplicated constraints

o num de identificação n deve ser do cidadão e não do cc

Pois assim PESSOA.noident ou é um int de 8 dígitos no caso de ser do cc ou int de 9 dígitos no caso de ser o NIF

num telefone consideramos indicador do país?

Se se manter varchar n consigo colocar restrições

Se considerarmos indicador necessitamos de varchar(16) e não varchar(10) em que + é o primeiro char ou 00

Se considerarmos 00 podem ser int e os 00 no inicio não necessitam de ser expressos

ex andorra +34738 ou 0034738

INTERVENCAO.descricao Similar???

INTERVENCAO.estado tem de ser varchar(11)

enunciado diz que date Tem o formato “dd-mm-aaaa” no entanto a documentação do post sql aponta para o formato “dd-mm-aaaa” TESTAR

https://www.postgresql.org/docs/14/functions-datetime.html

nome está em falta em Empresa. é para a empresa ter nome ou apenas url?



