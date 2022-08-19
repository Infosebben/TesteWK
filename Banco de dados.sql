create database WK;

use wk;

Create table cliente(
codigo int(4) PRIMARY KEY auto_increment,
nome varchar(150)not null,
cidade varchar(150),
UF char(2)) ENGINE=INNODB;

insert into cliente(nome,cidade,uf) values
('Adriano','Alvorada','RS'),
('Bruna','Alvorada','RS'),
('João','Porto Alegre','RS'),
('Lucas','Alvorada','RS'),
('Morgana','Canoas','RS'),
('Miguel','Porto Alegre','RS'),
('Felipe','Boa Vista','RO'),
('Paulo','Goiania','GO'),
('Eduardo','Goiania','GO'),
('Bruno','Querência','MT'),
('Ewellin','Cachoeirinha','RS'),
('Sandra','Viamão','RS'),
('Jorge','Porto Alegre','RS'),
('Jessica','São Paulo','SP'),
('Aline','Canoas','RS'),
('Adriana','Porto Alegre','RS'),
('Geraldo','Boa Vista','RO'),
('Regina','Goiania','GO'),
('Everton','Goiania','GO'),
('Alice','Querência','MT');

create table produto(
codigo int(4) PRIMARY KEY auto_increment,
Descricao varchar(150) not null,
preco float not null) ENGINE=INNODB;

insert into produto(descricao,preco) values
('Arroz 5kg',12.90),
('Feijão 1 kg',8.90),
('Farinha 1 kg',3.50),
('Farofa 1kg',1.30),
('Banana kg',3.50),
('Laranja kg',2.90),
('Desinfetante',6.30),
('Amaciante 2L',14.90),
('Sabão em pó 5L',45.80),
('Papel Higiênico',16.90),
('Detergente Liquido',1.90),
('Sabonete',2.30),
('Creme Dental',6.80),
('Fio Dental',11.50),
('Melao kg',5),
('Melância kg',0.90),
('Adoçante',7.65),
('Peito de frango kg',22.60),
('Salsicha kg',8.90),
('Bife de alcatra kg',49.80);

create table pedido(
numero_pedido int(4) PRIMARY KEY auto_increment,
data_emissao datetime not null,
codigo_cliente int(4) not null,
valor_total float,
Foreign key(codigo_cliente) references cliente(codigo)on delete restrict on update cascade) ENGINE=INNODB;

create table pedido_produtos(
autoincrem int(4),
numero_pedido int(4) not null,
codigo_produto int(4) not null,
quantidade int(4) not null,
valor_unit float not null,
valor_total float not null,
foreign key(numero_pedido) references pedido(numero_pedido) on update cascade on delete cascade,
foreign key(codigo_produto) references produto(codigo) on update cascade on delete cascade) ENGINE=INNODB;