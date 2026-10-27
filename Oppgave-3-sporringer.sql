# 1:
SELECT product_name, category,
       price, stock
FROM products
WHERE price > 750
AND stock >= 10
ORDER BY price DESC;

# 2:
SELECT first_name, last_name, city
FROM customers
WHERE city = 'Oslo' OR city = 'Bergen' OR city = 'Trondheim'
ORDER BY city, last_name;

# 3:
SELECT order_id, order_date, quantity,
       status
FROM orders
WHERE order_date LIKE '%07%';

# 4:
SELECT orders.order_date, orders.status, orders.quantity, customers.first_name, customers.last_name,
       products.product_name, products.price
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
JOIN products ON orders.product_id = products.product_id;

# 5:
SELECT orders.quantity * products.price AS result
FROM orders
JOIN products ON orders.product_id = products.product_id
ORDER BY result DESC;

# 6:
SELECT customers.customer_id, products.product_id, orders.quantity, products.price,
       orders.quantity * products.price AS result
FROM orders
JOIN products ON orders.product_id = products.product_id
JOIN customers ON orders.customer_id = customers.customer_id
WHERE orders.quantity * products.price > 2000
ORDER BY result DESC;

# 7:
SELECT status, COUNT(*) as COUNT
FROM orders
GROUP BY status;

# 8:
SELECT AVG(price) AS average_price,
       category
FROM products
GROUP BY category
ORDER BY average_price DESC;

# 9:
SELECT COUNT(order_id) AS sum_orders,
       customers.customer_id
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customer_id
ORDER BY sum_orders DESC;

# 10:
SELECT COALESCE(SUM(quantity), 0) AS product_count,
       products.product_name, products.product_id
FROM products
LEFT JOIN orders ON orders.product_id = products.product_id
GROUP BY products.product_id
ORDER BY product_count DESC;

# 11:
SELECT COALESCE(SUM(orders.quantity), 0) AS product_count, products.product_name,
       COALESCE(SUM(orders.quantity * products.price), 0) AS result
FROM products
LEFT JOIN orders ON orders.product_id = products.product_id
GROUP BY products.product_id
ORDER BY result DESC;

# 12:
SELECT customers.first_name,
       COUNT(orders.customer_id) AS result
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.first_name
HAVING COUNT(orders.customer_id) > 1
ORDER BY result DESC;

# 13:
SELECT customers.first_name,
       COUNT(orders.customer_id) AS result
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id
HAVING COUNT(orders.customer_id) = 0
ORDER BY result DESC;

# 14:
SELECT products.product_name,
       COUNT(orders.product_id) AS result
FROM products
LEFT JOIN orders ON products.product_id = orders.product_id
GROUP BY products.product_id
HAVING COUNT(orders.product_id) = 0
ORDER BY result DESC;

# 15:
SELECT SUM(orders.quantity * products.price) AS result, customers.customer_id
FROM customers
JOIN orders ON orders.customer_id = customers.customer_id
JOIN products ON orders.product_id = products.product_id
GROUP BY customers.customer_id
ORDER BY result DESC
LIMIT 1;

# Jeg fant ut at jeg må bruke SUM for å gange antallet product med prisen av hvert produkt.
# Slik får jeg summen for hvor mye produktene vil koste.
# Deretter så skjønte jeg at jeg må finne ut samlet verdi av produktene som en kunde har bestilt.
# Så koblet jeg de tabellene sammen for å finne riktig kunde og hvilke produkter de har kjøpt.
# Så tok jeg group by customer_id for å vise kundene, så satte jeg en limit på 1 for å vise bare 1 kunde.
# Med sortering fra høyest til lavest, slik vil kunden med høyest andel vises først.