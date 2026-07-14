CREATE TABLE Orders (
    order_id INT,
    user_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
);
INSERT INTO Orders VALUES
(1, 101, '2026-01-01', 500),
(2, 101, '2026-01-03', 700),
(3, 101, '2026-01-06', 300),

(4, 102, '2026-01-02', 900),
(5, 102, '2026-01-05', 400),
(6, 102, '2026-01-08', 600),

(7, 103, '2026-01-04', 800);

SELECT
    order_id,
    user_id,
    order_date,
    total_amount,
    LAG(total_amount) OVER (
        PARTITION BY user_id
        ORDER BY order_date
    ) AS previous_order_amount
FROM Orders
ORDER BY user_id, order_date;

SELECT
    order_id,
    user_id,
    order_date,
    total_amount,
    LEAD(total_amount) OVER (
        PARTITION BY user_id
        ORDER BY order_date
    ) AS next_order_amount
FROM Orders
ORDER BY user_id, order_date;

SELECT
    order_id,
    user_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY user_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM Orders
ORDER BY user_id, order_date;

SELECT
    order_id,
    user_id,
    order_date,
    total_amount,

    AVG(total_amount) OVER (
        PARTITION BY user_id
        ORDER BY order_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg

FROM Orders
ORDER BY user_id, order_date;