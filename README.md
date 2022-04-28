# ISI_F2
fase2 ISI
Entrega intermédia (Fase 2): **17 de Dezembro de 2021**

## Objectivos de aprendizagem
No final da segunda fase do trabalho, os alunos devem ser capazes de:

* Utilizar correctamente a álgebra relacional, com os seus vários operadores, para expressar interrogações sobre um modelo relacional:
  * operadores relacionais unários: select, project e rename;
  * operadores relacionais binários: division;
  * operadores sobre conjuntos: difference, intersect e union;
  * operadores de junção: theta join, equijoin e natural join;
  * operador de agregação;

* Utilizar correctamente SQL/DDL para criar as tabelas num sistema de gestão de bases de dados (SGDB);
* Garantir as restrições de integridade identificadas enumerando aquelas que têm de ser garantidas pelas aplicações;
* Inserir dados em lote através da cláusula SQL INSERT, garantindo que as restrições de integridade são cumpridas;
* Garantir a atomicidade de instruções, utilizando processamento transaccional;
* Utilizar correctamente as cláusulas INNER JOIN e OUTER JOIN;
* Utilizar correctamente sub-interrogações correlacionadas;
* Utilizar correctamente funções de agregação;
* Utilizar correctamente a cláusula HAVING;
* Utilizar correctamente a cláusula ORDER BY;
* Utilizar correctamente o termo DISTINCT;
* Utilizar correctamente os predicados IN e EXISTS.


Após a realização da 1ª fase do trabalho segue-se a implementação do modelo físico do sistema, i.e. deverá ser construído em PostgreSQL contemplando todas as restrições que consigam garantir na forma declarativa.
**Nota**: Deverão preencher a base de dados com informação necessária que permita em seguida realizar interrogações que apresentem resultados pertinentes. Na etapa de preenchimento da base de dados, os alunos deverão ter particular atenção ao cumprimento das restrições de integridade, utilizando de forma adequada o controlo transaccional (a atomicidade).

### Resultados pretendidos
Tendo em conta os objectivos de aprendizagem, deverão ser produzidos os seguintes resultados:

1. Construção do modelo físico do sistema, contemplando todas as restrições de integridade passíveis de ser garantidas declarativamente, assim como a atomicidade nas operações.
  O código PostgreSQL que permite:
  
  (a) Criar o modelo físico (1 script autónomo): "createTable.sql";
  
  (b) Remover o modelo físico (1 script autónomo): "removeTable.sql";
  
  (c) Preenchimento inicial da base de dados (1 script autónomo): "insertTable.sql";
  
  (d) Apagar todos os dados existentes nas tabelas (1 script autónomo): "deleteTable.sql".
  
  Os dados introduzidos devem permitir validar todas as interrogações pedidas nesta fase do trabalho.

2. Considerando o esquema relacional obtido anteriormente e fornecido no final deste documento ("Adenda"), apresente as expressões em álgebra relacional (AR) que respondam às seguintes alíneas. Por forma a recorrer a todos os operadores, sugere-se que (sempre que possível) apresente 2 soluções alternativas para a mesma questão.

  (a) Pretende-se o registo de todos as activos (nome, modelo, marca e localização) que se encontram em funcionamento.
  
  (b) Liste todas as pessoas (nome, email e profissão) agrupadas por competência.
  
  (c) Apresente a lista de empresas (nome, nipc e url) juntamente com o número total de empregados registados.
  
  (d) Liste as pessoas que estão a realizar a intervenção na "válvula de ar condicionado" ou que gere esse activo.
  
  (e) Pretende-se saber o nome de todos os activos que o "Manuel Fernandes" geriu ou fez intervenção.
  
  (f) Apresente o numero de elementos de uma equipa por intervenção.

3. Conceba, na linguagem PostgreSQL, as interrogações que produzam os resultados a seguir indicados, utilizando apenas uma instrução PostgreSQL. Guarde num script autónomo de nome "queries.sql". Para cada instrução deve ser também apresentada a descrição do raciocínio seguido.

  (a) Implemente em PostgreSQL as interrogações pedidas na alínea 2 (Pode escolher uma das soluções que apresentou acima, deste que nesta fase consiga fazer uso de todos os operadores).
  
  (b) Apresente o nome de todos os activos por tipo, deve apresentar a lista dos nomes por ordem alfabética (em primeiro lugar) e a data de aquisição.
  
  (c) Identifique todos os responsáveis de equipa que são (ou foram) gestores de pelo menos um activo. O resultado deve apresentar o nome, um n. de telefone (móvel ou fixo) e a profissão.
  
  (d) Liste todas as intervenções programadas para daqui a um mês (faça uso das funções temporais). O resultado deve identificar o activo (id e nome) e a descrição de intervenção a realizar.
  
  (e) Crie uma vista que permita obter informação sobre as equipas que realizaram intervenções no ano passado (deve fazer uso de uma função de datetime e não fixar o valor 2021) e seus elementos (nome e profissão). Identifique as intervenções por periódicas e não periódicas.
  
  (f) Crie uma vista que permita obter informação sobre o custo total em intervenções por activo e o valor comercial deste à data. A vista deve conter o identificador, o nome do activo, a data actual, o valor comercial e o valor total de intervenções realizadas.

4. Apresente o(s) comando(s) que permitem inserir na BD a seguinte informação: Substituição de uma válvula de um ar condicionado, localizado no gabinete da direcção do Complexo de Piscinas. O valor dessa intervenção é de 150 euros. Afectem essa intervenção a uma pessoa já registada na BD.

5. Apresente o(s) comando(s) que permitem a substituição de um elemento numa equipa existente na BD, cuja a intervenção não tenha sido concluída.
Todas as simplicações e optimizações realizadas ao modelo devem ser indicadas e justificadas.

**PS.1** Sugere-se que consulte o manual do SGDB para obter informação sobre as funções de manipulação de datas.
Data limite para entrega: 17 de Dezembro de 2021 até às 23:59.
A entrega deve incluir um documento com as respostas de AR e o código PostgreSQL, enviados de forma electrónica através do Moodle. O documento é entregue em formato PDF.
**Nota**: Deve ser possível aferir cada um dos objectivos de aprendizagem no material que entregar.

## Modelo

Todos os atributos são obrigatórios nas relações, excepto quando indicado o contrário. As relações são apresentadas por ordem alfabética. 

**Nota**: Poderão não estar representadas todas as restrições de integridade, uma vez que esta componente também é avaliada. Mais, as restrições que não conseguiremos implementar no modelo físico serão asseguradas, posteriormente, na API que irão desenvolver na 3ª parte.



**ACTIVO**

ACTIVO(*id*, nome, estado, dtaquisicao, marca, modelo, localizacao, idactivotopo, tipo, empresa, pessoa).

| Atributo     | Tipo          | Restrições Integridade                                       |
| ------------ | ------------- | ------------------------------------------------------------ |
| id           | varchar(5)    | O primeiro caracter corresponde a uma letra seguida de dígitos. |
| nome         | varchar(50)   |                                                              |
| estado       | bit           | “0” corresponde a desactivado e “1” a operacional.           |
| dtaquisicao  | date          | Tem o formato “dd-mm-aaaa”.                                  |
| modelo       | varchar(100)  |                                                              |
| marca        | varchar(75)   |                                                              |
| localizacao  | varchar(50)   |                                                              |
| idactivotopo | varchar(5)    | FK referência de ACTIVO.{id}.                                |
| tipo         | int           | FK referência de ACTIVOTIPO.{id}. O tipo de activo de topo da hierarquia deve ser igual aos “filhos”. |
| empresa      | int           | FK referência de EMPRESA.{id}.                               |
| pessoa       | int           | FK referência de PESSOA.{id}. Pessoa que gere o activo não pode fazer parte da equipa de manutenção deste. |

Todos os campos são obrigatórios com excepção de modelo e marca.

**ACTIVOTIPO**

ACTIVOTIPO(*id*, descricao).

| Atributo  | Tipo         | Restrições Integridade |
| --------- | ------------ | ---------------------- |
| id        | int          |                        |
| descrição | varchar(50)  |                        |

**COMPETENCIA**

COMPETENCIA(*id*, descricao).

| Atributo  | Tipo         | Restrições Integridade |
| --------- | ------------ | ---------------------- |
| codigo    | int          |                        |
| descricao | varchar(50)  |                        |

**COMP PESSOA**

COMP PESSOA(*pessoa, competencia*).

| Atributo    | Tipo | Restrições Integridade             |
| ----------- | ---- | ---------------------------------- |
| pessoa      | int  | FK referência de PESSOA.{id}.      |
| competencia | int  | FK referência de COMPETENCIA.{id}. |

**EMPRESA**

EMPRESA(*id*, url, nipc, nome, morada, codpostal, localidade).

| Atributo   | Tipo          | Restrições Integridade                                       |
| ---------- | ------------- | ------------------------------------------------------------ |
| id         | int           | Foi adicionado este atributo como identificador de EMPRESA por questões de simplificação. |
| url        | varchar(50)   | O valor contém “www.{C}.pt” ou “www.{C}.eu” ou “www.{C}.com”, onde C representa um conjunto de caracteres. |
| nipc       | int           | Corresponde ao Número de Identificação de Pessoa Colectiva.  |
| nome       | varchar(100)  |                                                              |
| morada     | varchar(150)  |                                                              |
| codpostal  | int           | Valor que contém 7 dígitos, que compõem o código<br/>postal sem hífen |
| localidade | varchar(150)  |                                                              |

**EQUIPA**

EQUIPA(*codigo*, localizacao, responsavel).

| Atributo    | Tipo         | Restrições Integridade        |
| ----------- | ------------ | ----------------------------- |
| codigo      | int          |                               |
| localizacao | varchar(50)  |                               |
| responsavel | int          | FK referência de PESSOA.{id}. |

**INTERVENCAO**

INTERVENCAO(*no*, descricao, estado, dtinicio, dtfim, valcusto, activo, atrdisc).

| Atributo  | Tipo         | Restrições Integridade                                       |
| --------- | ------------ | ------------------------------------------------------------ |
| no        | int          | Valor sequencial.                                            |
| descricao | varchar(75)  | Pode tomar como valores “rutura”, “inspecção” ou similar.    |
| estado    | varchar(50)  | Toma os valores “em análise”, “em execução” ou “concluído”.  |
| dtinicio  | date         | Tem o formato “dd-mm-aaaa”. Valor deve ser superior à data de aquisição do activo (dtaquisicao). O atributo estado não pode ter como valor “concluído”. |
| dtfim     | date         | Tem o formato “dd-mm-aaaa”. Valor superior a dtinicio. O atributo estado deve passar a “concluído”. |
| valcusto  | decimal(6,2) | Valor em euros.                                              |
| activo    | varchar(5)   | FK referência de ACTIVO.{id}.                                |
| atrdisc   | char(2)      | Atributo discriminante que contém “P” para representar as intervenções periódicas e “NP” as não periódicas |

**INTER EQUIPA**

INTER EQUIPA(*intervencao, equipa*).

| Atributo    | Tipo | Restrições Integridade             |
| ----------- | ---- | ---------------------------------- |
| intervencao | int  | FK referência de INTERVENCAO.{no}. |
| equipa      | int  | FK referência de EQUIPA.{codigo}.  |

**INTER PERIODICA**

INTER PERIODICA(*intervencao, periodicidade*).

| Atributo      | Tipo | Restrições Integridade             |
| ------------- | ---- | ---------------------------------- |
| intervencao   | int  | FK referência de INTERVENCAO.{no}. |
| periodicidade | int  | Valor corresponde ao n. de meses.  |

**PESSOA**

PESSOA(*id*, email, nome, dtnascimento, noident, morada, codpostal, localidade, profissao, equipa, empresa).

| Atributo     | Tipo          | Restrições Integridade                                       |
| ------------ | ------------- | ------------------------------------------------------------ |
| id           | int           | Foi adicionado este atributo como identificador de PESSOA por questões de simplificação. |
| email        | varchar(60)   | O valor é do tipo“{C}@{C}”, onde C representa caracter.      |
| nome         | varchar(150)  |                                                              |
| dtnascimento | date          | A pessoa deve ter no mínimo 18 anos de idade à data actual.  |
| noident      | char(10)      | número de identificação (cartão de cidadão ou NIF). Por questões de simplificação, optou-se por considerar apenas um dos números para identificação. |
| morada       | varchar(150)  |                                                              |
| codpostal    | int           | Valor que contém 7 dígitos, que compõem o código postal sem hífen |
| localidade   | varchar(150)  |                                                              |
| profissao    | varchar(100)  |                                                              |
| equipa       | int           | FK referência de EQUIPA.{codigo}                             |
| empresa      | int           | FK referência de EMPRESA.{id}.                               |

**TEL EMPRESA**

TEL EMPRESA(*empresa, telefone*).

| Atributo | Tipo        | Restrições Integridade                                    |
| -------- | ----------- | --------------------------------------------------------- |
| empresa  | int         | FK referência de EMPRESA.{id}.                            |
| telefone | varchar(10) | Representa o número de telefone fixo ou móvel da empresa. |

**TEL PESSOA**

TEL PESSOA(*pessoa, telefone*).

| Atributo | Tipo        | Restrições Integridade                                   |
| -------- | ----------- | -------------------------------------------------------- |
| pessoa   | int         | FK referência de PESSOA.{id}.                            |
| telefone | varchar(10) | Representa o número de telefone fixo ou móvel de pessoa. |

**VCOMERCIAL**

VCOMERCIAL(*dtvcomercial, activo*, valor).

| Atributo     | Tipo         | Restrições Integridade                                       |
| ------------ | ------------ | ------------------------------------------------------------ |
| dtvcomercial | date         | Tem o formato “dd-mm-aaaa”.Valor deve ser igual ou superior à data de aquisição do activo (dtaquisicao). |
| activo       | varchar(5)   | FK referência de ACTIVO.{id}.                                |
| valor        | decimal(6,2) | Valor em euros.                                              |

