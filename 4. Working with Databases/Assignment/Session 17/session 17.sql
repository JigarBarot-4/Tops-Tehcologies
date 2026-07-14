SELECT
    cuisine,
    COUNT(*) AS total_restaurants
FROM Restaurant
GROUP BY cuisine
ORDER BY total_restaurants DESC;

SELECT
    r.name,
    r.cuisine,
    ROUND(AVG(rv.rating),2) AS average_review_rating
FROM Restaurant r
JOIN Review rv
ON r.id = rv.restaurant_id
GROUP BY r.id, r.name, r.cuisine
ORDER BY average_review_rating DESC;

SELECT
    r.name,
    r.cuisine,
    ROUND(AVG(rv.rating),2) AS average_rating,

    RANK() OVER(
        PARTITION BY r.cuisine
        ORDER BY AVG(rv.rating) DESC
    ) AS restaurant_rank

FROM Restaurant r

JOIN Review rv
ON r.id = rv.restaurant_id

GROUP BY r.id, r.name, r.cuisine;