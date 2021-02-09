/*Nome: João Victor Sousa Santos
Turma A
RA: 21906881*/

/*Criação do database:*/
/*Tema: Animais de zoológico*/

create database zoologico;
use zoologico;

/*Criação de tabela:*/

create table animal(
id_animal int not null auto_increment unique,
qntd_especie int (2) not null,
especie varchar (30) not null,
raça varchar (30) not null,
peso decimal (5,2) not null,
altura decimal (5,2) not null,
idade date,
dta_entrada date not null,
ala_animal int (2) not null,
primary key (id_animal)
)default charset = utf8;

create table cuidador(
id_cuidador int not null auto_increment unique,
cpf int not null unique,
nome varchar (30) not null,
nascimento date,
telefone int (8),
genero char(1),
primary key (id_cuidador)
)default charset = utf8;

/*Inserimento dos dados:*/

insert into animal
(qntd_especie,especie,raça,peso,altura,idade,dta_entrada,ala_animal)
values
('6','capivara','chiquitano','50.00','100.00','2018-05-10','2019-02-01','01'),
('4','gorila','gorila da montanha','150.00','180.00',NULL,'2015-10-16','02'),
('3','leão','leão branco','200.00','170.00','2010-06-30','2010-10-07','03'),
('5','giraffa','masai','500.00','410.00',NULL,'2017-09-15','04'),
('7','águia','rabalva','05.00','40.00','2016-12-18','2017-01-03','05'),
('8','arara','escarlate','01.40','25.00',NULL,'2020-04-11','06'),
('10','babuíno','hamadrias','18.00','90.00','2012-11-27','2014-10-08','07'),
('2','canguru','bennett','15.50','140.00','2017-09-24','2017-09-29','08'),
('2','elefante','africano','900.00','300.00',NULL,'2013-04-24','09'),
('4','golfinho','roaz','400.00','110.00',NULL,'2019-12-26','10'),
('5','hipopótamo','pigmeu','270.00','190.00','2015-03-14','2018-04-05','11'),
('1','lince','euroasiático','28.00','80.00','2020-01-10','2020-01-28','12'),
('3','rinoceronte','branco','190.00','210.00','2014-03-04','2016-06-13','08'),
('4','esquilo','tricolor','03.00','10.00',NULL,'2018-12-25','7'),
('2','leopardo','persa','165.00','170.00','2002-09-02','2002-09-02','03'),
('6','lobo','negro','45.00','130.00',NULL,'2010-08-20','18'),
('2','tigre','de bengala','180.00','90.00','2020-02-28','2020-05-20','03');

insert into cuidador
(cpf,nome,nascimento,telefone,genero)
values
('12345678','ana','1990-03-04',NULL,'F'),
('12345679','nelson','1998-08-11','85608182','M'),
('12345670','felipe','2000-12-06','97012345','M'),
('12345676','joao','1988-07-24','12345678','M'),
('12345567','italo','1992-11-29','98765432','M'),
('90863718','eric','2003-01-09','16380168','M'),
('12684910','lucas','2001-06-06',NULL,'M'),
('74910253','maria','1980-05-30','96046178','F'),
('90648291','isabel','1997-09-04','90659103','F'),
('26381930','nathan','1996-11-10',NULL,'M'),
('16492046','luciana','1999-03-22','95027185','F'),
('06584920','fabiana','1995-12-18','74960162','F'),
('75938473','barbara','1999-08-28','43629081','F'),
('38758102','fernando','2000-10-23','23468690','M'),
('10246798','gabriel','2000-10-05',NULL,'M');

/*1- Operador in:*/
/*Os cuidadores da ala 8 e ala 11 necessitam fazer uma consulta dos animais que pesam mais que 100 kg, 
e deixar os registros de id e espécie desses animais em ordem crescente.*/

SELECT 
    *
FROM
    animal
WHERE
    ala_animal IN ('08' , '11')
        AND peso > '100'
ORDER BY id_animal , especie;

/*2- Between:*/
 /*Um cuidador necessita selecionar os animais das alas 5 e 7 para fazer uma pesquisa de quais deles pesam entre de
 0 a 10 kg, e ainda fazer o registro desses animais em ordem decrescente pela sua espécie e raça. Use between. */

SELECT 
    *
FROM
    animal
WHERE
    (ala_animal = '5' OR ala_animal = '7')
        AND peso BETWEEN 0 AND 10
ORDER BY especie , raça DESC;

/*3- Operador like:*/
/*O administrador do zoológico necessita das informações das espécies que comecem com a letra L e terminem com a letra O e além disso,
 quais dessas espécies possuem de 0 a 5 animais em seu habitat. Ordene em ordem ascendente pelo peso.*/
 
 SELECT 
    *
FROM
    animal
WHERE
    especie LIKE 'l%o'
        AND qntd_especie BETWEEN 0 AND 5
ORDER BY peso;
 
/*4- Função if*/
/*Os cuidadores necessitam de um sistema rápido para identificar a ala dos animais e seu respectivo peso, 
mas dar informações mais abrangentes em relação as alas 2, 5 e 7, informando quais animais destas alas pesam menos que 100 kg.
Ordene em ordem crescente pela ala.*/

 SELECT 
    especie,
    ala_animal,
    IF((ala_animal = '02' OR ala_animal = '05'
            OR ala_animal = '07')
            AND (peso < '100'),
        'Este animal pesa menos que 100 kg e faz parte das alas 2, 5 ou 7',
        peso) AS 'Tabela de pesos:'
FROM
    animal
ORDER BY ala_animal;
 
 /*5- Função ifnull:*/
 /*Um dos cuidadores do estabelecimento está pensando em fazer uma pequena confrartenização de natal,
 mas para isso, precisa dos números do resto dos colegas,e percebeu que alguns não possuem telefone inserido no sistema.
 Ajude-o criando uma lista dos convidados especificando quem não tem número com uma mensagem de aviso como 'sem telefone'.
 Ordene em ordem descrescente por nome e telefone.*/
 
 SELECT 
    nome, IFNULL(telefone, 'Sem telefone!!') AS 'telefones:'
FROM
    cuidador
ORDER BY nome , telefone DESC; 
 
 /*6- Date functions:*/
 /*Um cuidador que padeceu durante a epidemia, passou meses em coma e enfim acordou sem saber em que época do ano estava.
 Faça um exercício para dizer a ele em que dia e mês do ano estamos por extenso, além de o deixar por dentro do trimestre em que se encontra.*/
 
 SELECT 
    DAYNAME('2020-12-07') AS 'Dia:',
    MONTHNAME('2020-12-07') AS 'Mês:',
    QUARTER('2020-12-07') AS 'Semestre:';
 
 /*7- Cálculo com data:*/
 /*O administrador quer comemorar o aniversário de abertura do zoológico, que se deu no dia 18 de dezembro de 2000,
 mas por curiosidade gostaria de saber quanto tempo seu estabelecimento está aberto não em anos, e sim, respectivamente, meses e dias, 
  considerando hoje como dia 18 de dezembro de 2020. Além disso, gostaria de calcular o tempo em que cada animal está no zoo em dias,
  mas em uma resolução separada.Use no minimo duas funções diferentes de data para resolução de cada item pedido, e na última resolução, 
   ordene pelo tempo de cada animal no zoo em ordem decrescente.*/
 
 SELECT 
    TIMESTAMPDIFF(MONTH,
        '2000-12-18',
        '2020-12-18') AS 'Duração do zoo em meses:',
    DATEDIFF('2020-12-18', '2000-12-18') AS 'Duração do zoo em dias:';
 
 SELECT 
    especie AS 'Espécie',
    DATEDIFF('2020-12-18',dta_entrada) AS 'Tempo de cada animal no zoo em dias:'
FROM
    animal
ORDER BY DATEDIFF('2020-12-18',dta_entrada) DESC;
 
 /*Resoluções separadas:*/
 SELECT 
    TIMESTAMPDIFF(MONTH,
        '2000-12-18',
        '2020-12-18') AS 'Duração do zoo em meses:';
 
 SELECT DATEDIFF('2020-12-18', '2000-12-18') AS 'Duração do zoo em dias:';
 
 /*8- Função String:*/
 /*Um cuidador está com dificuldades para salvar o nome completo das espécies dos animais no sistema do zoológico,
 então resolveu usar versões resumidas desses nomes em no máximo quatro letras, mas não sabe como deve fazer. Resolva o problema de duas maneiras e 
 ordene de forma ascendente pela espécie:*/
 
 /*Primeira resolução:*/
 SELECT 
    LEFT(especie, 4) AS 'Nomes simplificados:'
FROM
    animal
ORDER BY especie;
 
 /*Segunda resolução:*/
 SELECT 
    SUBSTRING(especie, 1, 4) AS 'Nomes simplificados:'
FROM
    animal
ORDER BY especie;
 
 /*9-Expressões regulares - Classe predefinida de caracteres:*/
 /*O administrador do zoo precisa de algumas informações complementares de seus funcionários, incluindo nome, telefone e cpf,
 mas não está pegando informações dos funcionários que estão sem número incluido no sistema.Resolva usando classe predefinida de caracteres
 e ordene de forma ascendente por nome e telefone.*/
  
 SELECT 
    nome, telefone, cpf
FROM
    cuidador
WHERE
    telefone REGEXP '^\\d{8}$'
ORDER BY nome , telefone;

 
 /*10-Funções de agregação:*/
 /*Um dos cuidadores deseja fazer uma pesquisa no zoo referente a algumas informações sobre o peso de seus animais,
 quer saber qual o peso do animal menos pesado e o peso do animal mais pesado do zoológico, além de fazer uma média dos pesos dos animais.
 Use funções agregadas.*/

SELECT 
    MIN(peso) AS 'Menor peso:',
    MAX(peso) AS 'Maior peso:',
    AVG(peso) AS 'Média total dos pesos:'
FROM
    animal;

/*11- Group by:*/
/*O administrador do zoo deseja fazer uma pesquisa sobre o ano de nascimento de seus funcionários que são a partir do ano 2000.
Resolva usando group by e ordene em ordem decrescente por data de nascimento.*/

SELECT 
    nome AS Nome, nascimento AS 'Nascimentos em 2000 ou depois:'
FROM
    cuidador
GROUP BY nascimento
HAVING MIN(nascimento) > '2000-00-00'
ORDER BY nascimento desc;

/*12- Expressões regulares, regexp_like, regexp e rlike:*/
/*O administrador do zoo pretende fazer um sorteio de um pequeno presente de natal para alguns de seus funcionários,
e para isso, decidiu elencar algumas regras, que são elas:
-CPF do ganhador deve conter a sequencia de números '102' em qualquer posição dos dígitos;
-A última letra do nome deve ser 'a' ou 'o'.
Use funções regexp para resolução do exercício, e ordene em ordem decrescente pelo cpf. 
*/
 
 SELECT 
    nome AS 'Ganhadores!', cpf
FROM
    cuidador
WHERE
    cpf REGEXP '(102)'
        AND nome REGEXP '[ao]$'
ORDER BY cpf DESC;
 
 /*13- Operador aritméticos, relacionais e lógicos:*/
 /*Um dos cuidadores está querendo fazer uma pesquisa na ala dos felinos, correspondente a ala 3.
 Quer calcular a taxa IMC de cada um, mas somente daqueles com altura igual ou superior a 100cm. 
 Faça o que se pede usando os 3 tipos de operadores sql, e ordene em ordem ascendente pela espécie e ala animal.*/
 
 SELECT 
    especie,
    ala_animal,
    IF((ala_animal = '03' AND altura >= '100.00'),
        POWER(altura, 2) / peso,
        'Não possui a ala ou peso correspondente') AS 'IMC'
FROM
    animal
ORDER BY especie , ala_animal;

 /*14- Concatenação:*/
/*O administrador decidiu criar uma tabela informativa de seus animais para expor aos visitantes, que informasse o peso,
 altura e a data que cada animal chegou no zoo. Para informar a data, use funções date, e resolva o exercício por meio da concatenação.
 Ordene em ordem decrescente pela espécie.*/
 
SET lc_time_names = 'pt_PT';
SELECT 
    CONCAT('A/O ',
            especie,
            ' está pesando ',
            peso,
            ' ,está com ',
            altura,
            ' cm de altura, e chegou no zoológico no dia ',
            DAYOFMONTH(dta_entrada),
            ' de ',
            MONTHNAME(dta_entrada),
            ' de ',
            YEAR(dta_entrada)) AS 'Tabela Informativa:'
FROM
    animal
ORDER BY especie DESC;


 