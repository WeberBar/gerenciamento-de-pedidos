-- Criação do banco de dados e uso do mesmo
create database gerenciamento_pedidos;
use gerenciamento_pedidos;

-- Criação da tabela "clientes"
create table clientes (
    idCliente int primary key auto_increment,
    nome varchar (80) not null,
    email varchar (100) not null,
    telefone varchar (11),
    endereco varchar (200) not null,
    totalPedidos decimal (10,2) default 0
);

-- Criação da tabela "pedidos"
create table pedidos (
    idPedido int primary key auto_increment,
    idClientePedido int references clientes (idCliente),
    descricao varchar (200) not null,
    valorTotal decimal (10,2) not null,
    dataPedido date
);

-- Inserção de dados na tabela "clientes"
INSERT INTO Clientes (nome, email, telefone, endereco)
VALUES 
('João Silva', 'joao.silva@dominio.com', '11999999999', 'Rua das Flores, 123 - Bairro, Cidade - SP'),
('Ana Maria', 'ana.maria@dominio.com', '11999999998', 'Avenida Principal, 456 - Bairro, Cidade - SP'),
('Pedro Souza', 'pedro.souza@dominio.com', '11999999997', 'Rua do Comércio, 789 - Bairro, Cidade - SP'),
('Carlos Lima', 'carlos.lima@dominio.com', '11999999996', 'Travessa dos Artistas, 1010 - Bairro, Cidade - SP');

-- Inserção de dados na tabela "pedidos"
INSERT INTO Pedidos (idClientePedido, descricao, valorTotal, dataPedido)
VALUES (1, '1 toalha de mesa bordada e 1 jogo americano', 145.50, '2023-03-14'),
(1, '2 toalhas de mesa bordadas', 60, '2023-07-07'), (2, '5 toalhas de mesa bordadas', 150, '2023-08-02'),
(3, '1 boneco de pelúcia', 120, '2023-09-23'), (3, '1 porta-copos de feltro e 1 toalha de mesa bordada', 37.50, '2023-11-06');

-- Atualização do total de pedidos para alguns clientes
update clientes set totalPedidos = 205.5 where idCliente = 1;
update clientes set totalPedidos = 150 where idCliente = 2;
update clientes set totalPedidos = 157.50 where idCliente = 3;

-- Exibição dos dados das tabelas "clientes" e "pedidos"
select * from clientes;
select * from pedidos;

-- Criação da stored procedure "InserirPedido"
delimiter $$
create procedure InserirPedido (
    in cliente int,
    in descricaoPedido varchar (200),
    in valorPedido decimal (10,2),
    in data_pedido date
)
begin
    insert into pedidos (idClientePedido, descricao, valorTotal, dataPedido)
    values (cliente, descricaoPedido, valorPedido, data_pedido);
end $$
delimiter ;

-- Chamada da stored procedure para inserir um novo pedido
call InserirPedido (4, '1 carrinho de controle', 115, now());

-- Exibição dos dados da tabela "pedidos" após a inserção do novo pedido
select * from pedidos;

-- Criação do trigger "AtualizarTotalPedidos"
delimiter $$
create trigger AtualizarTotalPedidos
after insert on pedidos
for each row
begin
    update clientes set totalPedidos = totalPedidos + NEW.valorTotal
    WHERE idCliente = NEW.idClientePedido;
end $$
delimiter ;

-- Chamada da stored procedure para inserir outro novo pedido
call InserirPedido (4, '3 panos de prato bordados', 45, now());

-- Exibição dos dados da tabela "clientes" após a inserção do segundo novo pedido
select * from clientes;

-- Criação da view "PedidosClientes"
create view PedidosClientes as
select p.idPedido, c.nome, p.descricao, p.valorTotal, p.dataPedido
from pedidos p inner join clientes c on p.idClientePedido = c.idCliente
order by c.nome;

-- Exibição dos dados da view "PedidosClientes"
select * from PedidosClientes;

-- Exibição dos dados da tabela "Pedidos" com o nome do cliente e o total de pedidos
select p.*, c.nome, c.totalPedidos from Pedidos p
inner join clientes c on p.idClientePedido = c.idCliente;
