INSERT INTO Orderes_1 (order_id, user_id, payment_method, amount)
VALUES
(9, 1, 'UPI', 1200.00),
(10, 2, 'Card', 850.50),
(11, 3, 'COD', 499.00),
(12, 1, 'Wallet', 1500.00),
(13, 4, 'UPI', 2300.75),
(14, 5, 'Card', 999.99),
(15, 6, 'COD', 450.00),
(16, 2, 'UPI', 1750.25);

SELECT 
    payment_method,
    COUNT(*) AS order_count
FROM Orders
GROUP BY payment_method;

SELECT 
    user_id,
    SUM(amount) AS total_spent
FROM Orderes_1
GROUP BY user_id;

SELECT 
    payment_method,
    AVG(amount) AS avg_amount
FROM orderes_1
GROUP BY payment_method
HAVING AVG(amount) > 300;

SELECT *
FROM orderes_1
WHERE amount > 500;

SELECT 
    payment_method,
    SUM(amount) AS total_sales
FROM orderes_1
GROUP BY payment_method
HAVING SUM(amount) > 2000;