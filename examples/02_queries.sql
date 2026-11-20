USE lab;

INSERT INTO customers (name, country) VALUES ('Ada Lovelace', 'GB');
INSERT INTO customers (name, country) VALUES ('Grace Hopper', 'US');
INSERT INTO customers (name, country) VALUES ('Edsger Dijkstra', 'NL');

INSERT INTO orders (customer_id, total)
SELECT id, 120.50 FROM customers WHERE name = 'Ada Lovelace';
INSERT INTO orders (customer_id, total)
SELECT id, 80.00 FROM customers WHERE name = 'Ada Lovelace';
INSERT INTO orders (customer_id, total)
SELECT id, 240.00 FROM customers WHERE name = 'Grace Hopper';

SELECT c.country, COUNT(*) AS orders, SUM(o.total) AS revenue
FROM customers c
JOIN orders o ON o.customer_id = c.id
GROUP BY c.country
ORDER BY revenue DESC;

SHOW RANGES FROM TABLE orders;
EXPLAIN SELECT * FROM orders WHERE customer_id = (SELECT id FROM customers LIMIT 1);
