SELECT * FROM clientes;
-- Verificar o desempenho, menos de 1 milisegundo
DESCRIBE clientes;
-- Descrever a estrutura da tabela
-- Identificamos a chave primária (cliente_id)
-- Buscas por nome
SELECT * FROM clientes WHERE nome = 'Adelcio Biazi';
SELECT * FROM clientes WHERE nome LIKE 'Adelcio';
SELECT * FROM clientes WHERE nome LIKE '%Ana%';
SELECT * FROM clientes WHERE nome LIKE 'Ana%';
-- Criado o índice no campo Nome
CREATE INDEX i_nome on clientes(nome);
-- Verificado se o índice foi criado
DESCRIBE clientes;
-- O campo nome agora aparece marcado com a chave MUL (key MUL)
-- Testando com uma nova busca
SELECT * FROM clientes WHERE nome LIKE 'Ana%';
-- A partir de agora o desempenho de consultas pela coluna nome irá melhorar
-- Como são poucos clientes não há diferença em milisegundos na resposta,
-- na verdade para poucos clientes o desempenho pode piorar,
-- irá surtir efeito para milhões de linhas
-- Ponto fraco: índices melhoram o desempenho na consulta, porém pioram no cadastro. 