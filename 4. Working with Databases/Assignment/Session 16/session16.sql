CREATE DATABASE FoodDeliveryDB;

USE FoodDeliveryDB;
CREATE TABLE FoodOrders (
    order_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100),
    customer_name VARCHAR(100),
    order_amount DECIMAL(10,2),
    order_date DATE
);

LOAD DATA INFILE 'C:/Uploads/FoodOrders.csv'
INTO TABLE FoodOrders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id, restaurant_name, customer_name, order_amount, order_date);

CREATE TABLE TopSongs (
    song_id INT PRIMARY KEY,
    song_title VARCHAR(100),
    artist VARCHAR(100),
    streams BIGINT,
    release_date DATE
);

INSERT INTO TopSongs
(song_id, song_title, artist, streams, release_date)
VALUES
(1,'Blinding Lights','The Weeknd',4200000000,'2019-11-29'),
(2,'Shape of You','Ed Sheeran',3900000000,'2017-01-06'),
(3,'Flowers','Miley Cyrus',2100000000,'2023-01-13'),
(4,'Levitating','Dua Lipa',2800000000,'2020-03-27'),
(5,'Perfect','Ed Sheeran',2500000000,'2017-03-03');

SELECT * FROM TopSongs;

SELECT
    customer_name,
    SUM(order_amount) AS total_spent
FROM FoodOrders
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 3;

SELECT
    restaurant_name,
    COUNT(*) AS total_orders,
    SUM(order_amount) AS total_sales
FROM FoodOrders
GROUP BY restaurant_name
ORDER BY total_sales DESC;

SELECT
    'Average Order Amount' AS kpi_name,
    ROUND(AVG(order_amount),2) AS kpi_value
FROM FoodOrders

UNION ALL

SELECT
    'Unique Customers',
    COUNT(DISTINCT customer_name)
FROM FoodOrders;