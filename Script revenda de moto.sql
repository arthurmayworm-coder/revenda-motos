create database db_revenda_arthur;

create table clientes (
    id_cliente serial primary key,
    nome varchar(100) not null,
    cpf char(11) not null unique,
    telefone varchar(15) not null,
    email varchar(100) unique,
    endereco varchar(200) not null
);

create table motos (
    id_moto serial primary key,
    modelo varchar(100) not null,
    marca varchar(50) not null,
    ano int not null check (ano >= 2000),
    preco numeric(10,2) not null check (preco > 0),
    estoque int not null default 0 check (estoque >= 0)
);

create table funcionarios (
    id_funcionario serial primary key,
    nome varchar(100) not null,
    cpf char(11) not null unique,
    cargo varchar(50) not null,
    salario numeric(10,2) not null check (salario > 0),
    telefone varchar(15) not null
);

create table vendas (
    id_venda serial primary key,
    id_cliente int not null references clientes(id_cliente) on delete cascade,
    id_funcionario int not null references funcionarios(id_funcionario) on delete set null,
    data_venda date not null default current_date,
    valor_total numeric(10,2) not null check (valor_total > 0)
);

create table moto_acessorios (
    id_acessorio serial primary key,
    nome varchar(100) not null unique,
    descricao varchar(200) not null,
    preco numeric(10,2) not null check (preco > 0),
    estoque int not null default 0 check (estoque >= 0)
);

create table venda_motos (
    id_venda int not null references vendas(id_venda) on delete cascade,
    id_moto int not null references motos(id_moto) on delete cascade,
    quantidade int not null check (quantidade > 0),
    primary key (id_venda, id_moto)
);

create view vw_vendas_completo as
select v.id_venda, c.nome as cliente, f.nome as funcionario, v.data_venda, v.valor_total
from vendas v
join clientes c on v.id_cliente = c.id_cliente
left join funcionarios f on v.id_funcionario = f.id_funcionario;

create view vw_motos_estoque as
select modelo, marca, ano, preco, estoque
from motos
where estoque > 0;

-- inserts de exemplo
insert into clientes(nome, cpf, telefone, email, endereco) values
('joão silva','12345678901','11999999999','joao@gmail.com','rua a, 123'),
('maria souza','23456789012','11988888888','maria@gmail.com','rua b, 456'),
('pedro santos','34567890123','11977777777','pedro@gmail.com','rua c, 789'),
('ana lima','45678901234','11966666666','ana@gmail.com','rua d, 101'),
('lucas oliveira','56789012345','11955555555','lucas@gmail.com','rua e, 202'),
('fernanda costa','67890123456','11944444444','fernanda@gmail.com','rua f, 303'),
('rafael gomes','78901234567','11933333333','rafael@gmail.com','rua g, 404'),
('patrícia alves','89012345678','11922222222','patricia@gmail.com','rua h, 505'),
('carlos pereira','90123456789','11911111111','carlos@gmail.com','rua i, 606'),
('beatriz rocha','01234567890','11900000000','beatriz@gmail.com','rua j, 707');

insert into motos(modelo, marca, ano, preco, estoque) values
('africa twin','honda',2023,85000.00,4),
('xj6','yamaha',2022,32000.00,6),
('hornet','honda',2021,27000.00,5),
('xre 300','honda',2023,15000.00,8),
('cb 1000','honda',2022,55000.00,3),
('cbr 1000 repsol','honda',2023,65000.00,2),
('gs 1250','bmw',2023,90000.00,3),
('tiger 660 sport','triumph',2023,43000.00,4),
('tiger 800','triumph',2021,40000.00,5),
('ducati v4','ducati',2023,120000.00,2);

insert into funcionarios(nome, cpf, cargo, salario, telefone) values
('marcos silva','11223344556','vendedor',2500.00,'11999998888'),
('sofia pereira','22334455667','gerente',4500.00,'11988887777'),
('carlos lima','33445566778','vendedor',2600.00,'11977776666'),
('fernanda alves','44556677889','caixa',2000.00,'11966665555'),
('lucas rocha','55667788990','vendedor',2400.00,'11955554444'),
('paula martins','66778899001','gerente',4600.00,'11944443333'),
('rafael costa','77889900112','vendedor',2550.00,'11933332222'),
('camila souza','88990011223','caixa',2100.00,'11922221111'),
('bruno fernandes','99001122334','vendedor',2500.00,'11911110000'),
('aline carvalho','10111213141','gerente',4700.00,'11900009999');

insert into vendas(id_cliente,id_funcionario,data_venda,valor_total) values
(1,1,'2025-01-10',85000.00),(2,2,'2025-01-11',32000.00),(3,3,'2025-01-12',27000.00),
(4,4,'2025-01-13',15000.00),(5,5,'2025-01-14',55000.00),(6,6,'2025-01-15',65000.00),
(7,7,'2025-01-16',90000.00),(8,8,'2025-01-17',43000.00),(9,9,'2025-01-18',40000.00),(10,10,'2025-01-19',120000.00);

insert into moto_acessorios(nome,descricao,preco,estoque) values
('capacete','capacete integral',300.00,15),('luvas','luvas de couro',50.00,20),('jaqueta','jaqueta de proteção',500.00,10),
('botas','botas para motoqueiro',200.00,12),('protetor de coluna','proteção para coluna',150.00,8),('óculos','óculos de proteção',100.00,25),
('alarme','alarme para motos',350.00,5),('trava de roda','trava contra furtos',250.00,10),('bagageiro','suporte para bagagem',400.00,7),
('par de espelhos','espelhos retrovisores',120.00,14);

insert into venda_motos(id_venda,id_moto,quantidade) values
(1,1,1),(2,2,1),(3,3,1),(4,4,1),(5,5,1),(6,6,1),(7,7,1),(8,8,1),(9,9,1),(10,10,1);

-- atualizar todos para null
update clientes set nome=null, cpf=null, telefone=null, email=null, endereco=null;
update motos set modelo=null, marca=null, ano=null, preco=null, estoque=null;
update funcionarios set nome=null, cpf=null, cargo=null, salario=null, telefone=null;
update vendas set id_cliente=null, id_funcionario=null, data_venda=null, valor_total=null;
update moto_acessorios set nome=null, descricao=null, preco=null, estoque=null;
update venda_motos set id_venda=null, id_moto=null, quantidade=null;

-- criar usuarios
create user mayworm with password 'senha_forte';
grant all privileges on database db_revenda_arthur to mayworm;
grant all privileges on all tables in schema public to mayworm;

create user romeu with password 'senha_romeu';
grant select on all tables in schema public to romeu;

-- 12 consultas
select c.id_cliente, c.nome, v.id_venda, v.valor_total
from clientes c
inner join vendas v on c.id_cliente = v.id_cliente;

select c.id_cliente, c.nome, v.id_venda, v.valor_total
from clientes c
left join vendas v on c.id_cliente = v.id_cliente;

select c.id_cliente, c.nome, v.id_venda, v.valor_total
from clientes c
right join vendas v on c.id_cliente = v.id_cliente;

select f.id_funcionario, f.nome, v.id_venda, v.valor_total
from funcionarios f
inner join vendas v on f.id_funcionario = v.id_funcionario;

select f.id_funcionario, f.nome, v.id_venda, v.valor_total
from funcionarios f
left join vendas v on f.id_funcionario = v.id_funcionario;

select f.id_funcionario, f.nome, v.id_venda, v.valor_total
from funcionarios f
right join vendas v on f.id_funcionario = v.id_funcionario;

select v.id_venda, v.valor_total, vm.id_moto, vm.quantidade
from vendas v
inner join venda_motos vm on v.id_venda = vm.id_venda;

select v.id_venda, v.valor_total, vm.id_moto, vm.quantidade
from vendas v
left join venda_motos vm on v.id_venda = vm.id_venda;

select v.id_venda, v.valor_total, vm.id_moto, vm.quantidade
from vendas v
right join venda_motos vm on v.id_venda = vm.id_venda;

select m.id_moto, m.modelo, vm.id_venda, vm.quantidade
from motos m
inner join venda_motos vm on m.id_moto = vm.id_moto;

select m.id_moto, m.modelo, vm.id_venda, vm.quantidade
from motos m
left join venda_motos vm on m.id_moto = vm.id_moto;

select m.id_moto, m.modelo, vm.id_venda, vm.quantidade
from motos m
right join venda_motos vm on m.id_moto = vm.id_moto;

select * from vw_vendas_completo;
select * from vw_motos_estoque;

<img width="1536" height="1024" alt="896fa5d5-876f-41ab-a3d3-d9a42515498c" src="https://github.com/user-attachments/assets/c078d3ea-cecb-4739-ad90-38fc78cd753d" />

