INNER JOIN = somente correspondências.

LEFT JOIN = tudo da esquerda.

RIGHT JOIN = tudo da direita.

FULL OUTER JOIN = tudo dos dois lados.

LEFT JOIN + IS NULL = registros da esquerda sem correspondência.

EXISTS = verifica se existe correspondência.

NOT EXISTS = verifica se não existe correspondência.

SELECT: define quais informações serão mostradas.

FROM: indica a tabela principal.

INNER JOIN: combina as tabelas.

ON: define como as tabelas se relacionam.

WHERE: filtra os resultados.
============================================================================================================================================================================================================== 

------ Atividades------

A) SELECT COUNT(*) AS quantidade_tabelas
FROM information_schema.tables
WHERE table_schema = 'Pizzaria';

-> resposta: 5

B)SELECT COUNT(*) AS quantidade_clientes
FROM Clientes;

-> resposta: 105

C) SELECT COUNT(*) AS quantidade_pizzas
FROM Pizzas;

-> resposta: 41

D) SELECT SUM(quantidade) AS total_pizzas
FROM Itens_Pedido
WHERE pedido_id = 3;

-> resposta: 21

E)SELECT Clientes.nome FROM Clientes WHERE cliente_id = 3;

-> resposta: Alison Linhares de Carvalho

F) SELECT pi.nome AS nome_pizza
FROM Itens_Pedido ip
INNER JOIN Pizzas pi
    ON ip.pizza_id = pi.pizza_id
WHERE ip.pedido_id = 3;

-> resposta: Bauru, atum, caipira, calabresa, aliche, camponesa, firense

(c e p: são apelidos para as tabelas Clientes e Pedidos )
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------------------------------------------------------------
----acrescentando cliente----
INSERT INTO Clientes (nome, logradouro, numero, bairro, referencia)
VALUES (
    'Gaspar Oliveira',
    'Rua Lizandro Silva',
    21,
    'São Dimas',
    'Ao lado da igrejinha'
);

--cadastrando o pedido do cliente--
INSERT INTO Pedidos (cliente_id, data, hora)
VALUES (
    (SELECT cliente_id FROM Clientes WHERE nome = 'Gaspar Oliveira'),
    CURDATE(),
    CURTIME()
);

INSERT INTO Itens_Pedido (pedido_id, pizza_id, quantidade, valor)
VALUES
(
    (SELECT MAX(pedido_id) FROM Pedidos),
    (SELECT pizza_id FROM Pizzas WHERE nome = 'Margherita'),
    1,
    (SELECT valor FROM Pizzas WHERE nome = 'Margherita')
),
(
    (SELECT MAX(pedido_id) FROM Pedidos),
    (SELECT pizza_id FROM Pizzas WHERE nome = 'Napolitana'),
    2,
    (SELECT valor FROM Pizzas WHERE nome = 'Napolitana')
);

--cadastrando pizza a moda do chef--
use pizzaria;

INSERT INTO Pizzas(nome, descricao, valor),
VALUES (
    "A moda do chef",
    "Molho de tomate, palmito macio em rodelas, coberto com catupiry, frango desfiado, ovos, carne seca, oregano e azeitonas",
    41.90
);

-- Cadastrar novo pedido para Gaspar--
INSERT INTO Pedidos (cliente_id, data, hora)
SELECT Cliente_id, CURDATE(), CURTIME()
FROM Clientes
WHERE nome = 'Gaspar Oliveira';

-- Inserir 2 pizzas A moda do chef no pedido--
INSERT INTO Itens_Pedido (pedido_id, pizza_id, quantidade, valor)
SELECT
    (SELECT MAX(pedido_id) FROM Pedidos),
    pizza_id,
    2,
    valor
FROM Pizzas
WHERE nome = 'A moda do chef';

-- Atualizar valor total do pedido--
UPDATE Pedidos
SET valor = (
    SELECT SUM(quantidade * valor)
    FROM Itens_Pedido
    WHERE pedido_id = (SELECT MAX(pedido_id) FROM Pedidos)
)
WHERE pedido_id = (SELECT MAX(pedido_id) FROM Pedidos);

INSERT INTO Itens_Pedido (pedido_id, pizza_id, quantidade, valor)
SELECT
    (SELECT MAX(pedido_id) FROM Pedidos),
    pizza_id,
    3,
    valor
FROM Pizzas
WHERE nome = 'A moda do chef';