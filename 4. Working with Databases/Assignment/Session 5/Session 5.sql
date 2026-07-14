CREATE TABLE Restaurant (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    cuisine VARCHAR(50),
    rating DECIMAL(2,1),
    city VARCHAR(50)
);
INSERT INTO Restaurant (id, name, cuisine, rating, city)
VALUES
(1, 'The Spice House', 'Indian', 4.5, 'Ahmedabad'),
(2, 'Pizza Hub', 'Italian', 4.2, 'Mumbai'),
(3, 'Dragon Wok', 'Chinese', 4.3, 'Delhi'),
(4, 'Green Bowl Cafe', 'Healthy', 4.6, 'Bangalore'),
(5, 'Burger Point', 'Fast Food', 4.1, 'Pune');
SELECT *
FROM Restaurant
WHERE rating > 4.0
AND city IN ('Ahmedabad', 'Surat');

SELECT *
FROM Restaurants
WHERE name LIKE 'Swa%';

SELECT *
FROM Restaurants
WHERE rating BETWEEN 3.5 AND 4.5;

SELECT *
FROM Restaurants
WHERE cuisine IN ('Chinese', 'Italian', 'South Indian');