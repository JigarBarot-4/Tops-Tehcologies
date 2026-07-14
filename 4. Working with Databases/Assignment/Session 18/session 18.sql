SELECT
    artist_name,
    COUNT(song_id) AS total_songs
FROM songs
GROUP BY artist_name
HAVING COUNT(song_id) > 3;

SELECT
    u.username,
    SUM(o.amount) AS total_order_amount
FROM users u
JOIN orders o
ON u.user_id = o.user_id
GROUP BY u.user_id, u.username
ORDER BY total_order_amount DESC;

SELECT
    name,
    rating
FROM restaurants
WHERE rating >
(
    SELECT AVG(rating)
    FROM restaurants
);

SELECT
    user_id,
    transaction_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY user_id
        ORDER BY transaction_date
    ) AS running_total
FROM transactions
ORDER BY user_id, transaction_date;