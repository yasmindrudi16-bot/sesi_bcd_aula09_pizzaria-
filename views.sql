-- Relatório que mostra todos os pedidos e o nome de cada cliente
SELECT * FROM pedidos;
SELECT p.*, c.nome  FROM pedidos p INNER JOIN clientes c
ON p.cliente_id = c.cliente_id;
-- Salvar a consulta como uma VIEW / Relatório
CREATE VIEW vw_pedidos1 AS
SELECT p.*, c.nome  FROM pedidos p INNER JOIN clientes c
ON p.cliente_id = c.cliente_id;
-- Para ver o resultado
SELECT * FROM vw_pedidos1;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DESAFIO 1--
-- Relatório com todos os pedidos, itens, nomes dos clientes e nomes das pizzas.
SELECT
    Pedidos.pedido_id,
    Pedidos.data,
    Pedidos.hora,
    Clientes.nome AS nome_cliente,
    Pizzas.nome AS nome_pizza,
    Itens_Pedido.quantidade,
    Itens_Pedido.valor AS preco_unitario
FROM Pedidos
INNER JOIN Clientes
    ON Pedidos.cliente_id = Clientes.Cliente_id
INNER JOIN Itens_Pedido
    ON Pedidos.pedido_id = Itens_Pedido.pedido_id
INNER JOIN Pizzas
    ON Itens_Pedido.pizza_id = Pizzas.pizza_id;


-- DESAFIO 2--
-- Mesmo relatório do desafio 1, agora acrescentando a coluna subtotal.
-- O subtotal é o preço unitário multiplicado pela quantidade.
SELECT
    Pedidos.pedido_id,
    Pedidos.data,
    Pedidos.hora,
    Clientes.nome AS nome_cliente,
    Pizzas.nome AS nome_pizza,
    Itens_Pedido.quantidade,
    Itens_Pedido.valor AS preco_unitario,
    (Itens_Pedido.valor * Itens_Pedido.quantidade) AS subtotal
FROM Pedidos
INNER JOIN Clientes
    ON Pedidos.cliente_id = Clientes.Cliente_id
INNER JOIN Itens_Pedido
    ON Pedidos.pedido_id = Itens_Pedido.pedido_id
INNER JOIN Pizzas
    ON Itens_Pedido.pizza_id = Pizzas.pizza_id;


-- DESAFIO 3--
-- Agrupa os itens por pedido e calcula o valor total de cada pedido.
SELECT
    Pedidos.pedido_id,
    Clientes.nome AS nome_cliente,
    SUM(Itens_Pedido.valor * Itens_Pedido.quantidade) AS valor_total
FROM Pedidos
INNER JOIN Clientes
    ON Pedidos.cliente_id = Clientes.Cliente_id
INNER JOIN Itens_Pedido
    ON Pedidos.pedido_id = Itens_Pedido.pedido_id
GROUP BY
    Pedidos.pedido_id,
    Clientes.nome;


-- DESAFIO 4--
-- Agrupa os itens por pedido e soma as quantidades de pizzas de cada pedido.
SELECT
    Pedidos.pedido_id,
    Clientes.nome AS nome_cliente,
    SUM(Itens_Pedido.quantidade) AS quantidade_pizzas
FROM Pedidos
INNER JOIN Clientes
    ON Pedidos.cliente_id = Clientes.Cliente_id
INNER JOIN Itens_Pedido
    ON Pedidos.pedido_id = Itens_Pedido.pedido_id
GROUP BY
    Pedidos.pedido_id,
    Clientes.nome;
