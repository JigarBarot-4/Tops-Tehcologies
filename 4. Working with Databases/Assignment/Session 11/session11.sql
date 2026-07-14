SELECT *
FROM Restaurants r
WHERE rating > (
    SELECT AVG(r2.rating)
    FROM Restaurants r2
    WHERE r2.location = r.location
);
SELECT
    u.user_id,
    u.username,

    (
        SELECT COUNT(*)
        FROM Orders o
        WHERE o.user_id = u.user_id
    ) AS total_orders

FROM Users u;
SELECT *
FROM Movies
WHERE movie_id IN (
    SELECT movie_id
    FROM Reviews
    WHERE rating = 5
);

SELECT s.seller_id, s.seller_name
FROM Sellers s
WHERE NOT EXISTS (

    SELECT c.category_id
    FROM Categories c

    WHERE NOT EXISTS (
        SELECT 1
        FROM Sales sa
        WHERE sa.seller_id = s.seller_id
          AND sa.category_id = c.category_id
    )

);
