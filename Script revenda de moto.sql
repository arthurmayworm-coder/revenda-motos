CREATE DATABASE db_revenda_Arthur;

CREATE TABLE Clientes (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    telefone VARCHAR(15) NOT NULL,
    email VARCHAR(100) UNIQUE,
    endereco VARCHAR(200) NOT NULL
);

CREATE TABLE Motos (
    id_moto SERIAL PRIMARY KEY,
    modelo VARCHAR(100) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    ano INT NOT NULL CHECK (ano >= 2000),
    preco NUMERIC(10,2) NOT NULL CHECK (preco > 0),
    estoque INT NOT NULL DEFAULT 0 CHECK (estoque >= 0)
);

CREATE TABLE Funcionarios (
    id_funcionario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    cargo VARCHAR(50) NOT NULL,
    salario NUMERIC(10,2) NOT NULL CHECK (salario > 0),
    telefone VARCHAR(15) NOT NULL
);

CREATE TABLE Vendas (
    id_venda SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL REFERENCES Clientes(id_cliente) ON DELETE CASCADE,
    id_funcionario INT NOT NULL REFERENCES Funcionarios(id_funcionario) ON DELETE SET NULL,
    data_venda DATE NOT NULL DEFAULT CURRENT_DATE,
    valor_total NUMERIC(10,2) NOT NULL CHECK (valor_total > 0)
);

CREATE TABLE Moto_Acessorios (
    id_acessorio SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao VARCHAR(200) NOT NULL,
    preco NUMERIC(10,2) NOT NULL CHECK (preco > 0),
    estoque INT NOT NULL DEFAULT 0 CHECK (estoque >= 0)
);

CREATE TABLE Venda_Motos (
    id_venda INT NOT NULL REFERENCES Vendas(id_venda) ON DELETE CASCADE,
    id_moto INT NOT NULL REFERENCES Motos(id_moto) ON DELETE CASCADE,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    PRIMARY KEY (id_venda, id_moto)
);

CREATE VIEW vw_vendas_completo AS
SELECT 
    v.id_venda, 
    c.nome AS cliente, 
    f.nome AS funcionario, 
    v.data_venda, 
    v.valor_total
FROM Vendas v
JOIN Clientes c ON v.id_cliente = c.id_cliente
LEFT JOIN Funcionarios f ON v.id_funcionario = f.id_funcionario;

CREATE VIEW vw_motos_estoque AS
SELECT modelo, marca, ano, preco, estoque
FROM Motos
WHERE estoque > 0;

INSERT INTO Clientes (nome, cpf, telefone, email, endereco) VALUES
('João Silva', '12345678901', '11999999999', 'joao@gmail.com', 'Rua A, 123'),
('Maria Souza', '23456789012', '11988888888', 'maria@gmail.com', 'Rua B, 456'),
('Pedro Santos', '34567890123', '11977777777', 'pedro@gmail.com', 'Rua C, 789'),
('Ana Lima', '45678901234', '11966666666', 'ana@gmail.com', 'Rua D, 101'),
('Lucas Oliveira', '56789012345', '11955555555', 'lucas@gmail.com', 'Rua E, 202'),
('Fernanda Costa', '67890123456', '11944444444', 'fernanda@gmail.com', 'Rua F, 303'),
('Rafael Gomes', '78901234567', '11933333333', 'rafael@gmail.com', 'Rua G, 404'),
('Patrícia Alves', '89012345678', '11922222222', 'patricia@gmail.com', 'Rua H, 505'),
('Carlos Pereira', '90123456789', '11911111111', 'carlos@gmail.com', 'Rua I, 606'),
('Beatriz Rocha', '01234567890', '11900000000', 'beatriz@gmail.com', 'Rua J, 707');

INSERT INTO Motos (modelo, marca, ano, preco, estoque) VALUES
('Africa Twin', 'Honda', 2023, 85000.00, 4),
('XJ6', 'Yamaha', 2022, 32000.00, 6),
('Hornet', 'Honda', 2021, 27000.00, 5),
('XRE 300', 'Honda', 2023, 15000.00, 8),
('CB 1000', 'Honda', 2022, 55000.00, 3),
('CBR 1000 Repsol', 'Honda', 2023, 65000.00, 2),
('GS 1250', 'BMW', 2023, 90000.00, 3),
('Tiger 660 Sport', 'Triumph', 2023, 43000.00, 4),
('Tiger 800', 'Triumph', 2021, 40000.00, 5),
('Ducati V4', 'Ducati', 2023, 120000.00, 2);

INSERT INTO Funcionarios (nome, cpf, cargo, salario, telefone) VALUES
('Marcos Silva', '11223344556', 'Vendedor', 2500.00, '11999998888'),
('Sofia Pereira', '22334455667', 'Gerente', 4500.00, '11988887777'),
('Carlos Lima', '33445566778', 'Vendedor', 2600.00, '11977776666'),
('Fernanda Alves', '44556677889', 'Caixa', 2000.00, '11966665555'),
('Lucas Rocha', '55667788990', 'Vendedor', 2400.00, '11955554444'),
('Paula Martins', '66778899001', 'Gerente', 4600.00, '11944443333'),
('Rafael Costa', '77889900112', 'Vendedor', 2550.00, '11933332222'),
('Camila Souza', '88990011223', 'Caixa', 2100.00, '11922221111'),
('Bruno Fernandes', '99001122334', 'Vendedor', 2500.00, '11911110000'),
('Aline Carvalho', '10111213141', 'Gerente', 4700.00, '11900009999');

INSERT INTO Vendas (id_cliente, id_funcionario, data_venda, valor_total) VALUES
(1, 1, '2025-01-10', 85000.00),
(2, 2, '2025-01-11', 32000.00),
(3, 3, '2025-01-12', 27000.00),
(4, 4, '2025-01-13', 15000.00),
(5, 5, '2025-01-14', 55000.00),
(6, 6, '2025-01-15', 65000.00),
(7, 7, '2025-01-16', 90000.00),
(8, 8, '2025-01-17', 43000.00),
(9, 9, '2025-01-18', 40000.00),
(10, 10, '2025-01-19', 120000.00);

INSERT INTO Moto_Acessorios (nome, descricao, preco, estoque) VALUES
('Capacete', 'Capacete Integral', 300.00, 15),
('Luvas', 'Luvas de couro', 50.00, 20),
('Jaqueta', 'Jaqueta de proteção', 500.00, 10),
('Botas', 'Botas para motoqueiro', 200.00, 12),
('Protetor de coluna', 'Proteção para coluna', 150.00, 8),
('Óculos', 'Óculos de proteção', 100.00, 25),
('Alarme', 'Alarme para motos', 350.00, 5),
('Trava de roda', 'Trava contra furtos', 250.00, 10),
('Bagageiro', 'Suporte para bagagem', 400.00, 7),
('Par de espelhos', 'Espelhos retrovisores', 120.00, 14);

INSERT INTO Venda_Motos (id_venda, id_moto, quantidade) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 1),
(7, 7, 1),
(8, 8, 1),
(9, 9, 1),
(10, 10, 1);

SELECT * FROM vw_vendas_completo;

SELECT * FROM vw_motos_estoque;
