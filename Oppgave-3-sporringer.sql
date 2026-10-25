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
