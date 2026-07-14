CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_name VARCHAR(100),
    total_amount DECIMAL(10,2),
    order_date DATE
);
INSERT INTO Orders (order_id, user_name, total_amount, order_date)
VALUES
(6, 'Amit', 1200.50, '2026-06-20'),
(7, 'Neha', 850.00, '2026-06-21'),
(8, 'Rahul', NULL, '2026-06-22'),
(9, 'Sneha', 2300.75, '2026-06-23'),
(10, 'Vikram', 1500.00, '2026-06-24');
SELECT *
FROM Orders
WHERE total_amount IS NULL;

SELECT 
    user_name,
    COUNT(order_id) AS order_count
FROM Orders
GROUP BY user_name;

SELECT AVG(total_amount) AS average_order_amount
FROM Orders;

SELECT
    MAX(total_amount) AS highest_order_amount,
    MIN(total_amount) AS lowest_order_amount
FROM Orders;

SELECT SUM(total_amount) AS total_sales
FROM Orders
WHERE total_amount IS NOT NULL;
