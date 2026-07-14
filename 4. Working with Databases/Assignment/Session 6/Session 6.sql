SELECT *
FROM products
ORDER BY price ASC;
SELECT *
FROM products
ORDER BY price DESC
LIMIT 5;
SELECT *
FROM movies
ORDER BY release_year DESC, rating DESC;
SELECT *
FROM restaurants
ORDER BY name ASC
LIMIT 10;
SELECT *
FROM songs
ORDER BY play_count DESC, created_at DESC
LIMIT 3;