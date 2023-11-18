## Objetivo: Criar um sistema de gerenciamento de pedidos em um banco de dados utilizando stored procedures, triggers, views e JOINs no MySQL Workbench.

### Etapa 1: Criação de Tabelas e Inserção de Dados

Crie as tabelas "Clientes" e "Pedidos" com campos apropriados. Insira dados de exemplo nas tabelas para simular clientes e pedidos. Certifique-se de incluir uma chave primária em cada tabela.

```mysql
create table clientes (
    idCliente int primary key auto_increment,
    nome varchar (80) not null,
    email varchar (100) not null,
    telefone varchar (11),
    endereco varchar (200) not null,
    totalPedidos decimal (10,2) default 0
);

create table pedidos (
    idPedido int primary key auto_increment,
    idClientePedido int references clientes (idCliente),
    descricao varchar (200) not null,
    valorTotal decimal (10,2) not null,
    dataPedido date
);

```

Etapa 2: Criação de Stored Procedure

Crie uma stored procedure chamada "InserirPedido" que permite inserir um novo pedido na tabela "Pedidos" com as informações apropriadas. A stored procedure deve receber parâmetros como o ID do cliente e os detalhes do pedido. Ao término teste o funcionamento da stored procedure criada inserindo um pedido.

```mysql
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

```
Agora só chamar a stored
```mysql

call InserirPedido (4, '1 carrinho de controle', 115, now());
```
