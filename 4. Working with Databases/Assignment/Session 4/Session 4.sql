CREATE TABLE MusicPlaylist (
    id INT PRIMARY KEY,
    song_name VARCHAR(255),
    artist VARCHAR(255),
    genre VARCHAR(100),
    duration INT
);
INSERT INTO MusicPlaylist (id, song_name, artist, genre, duration)
VALUES
(1, 'Calm Down', 'Rema & Selena Gomez', 'Afrobeats', 239),
(2, 'Kesariya', 'Arijit Singh', 'Bollywood', 268),
(3, 'Shape of You', 'Ed Sheeran', 'Pop', 233),
(4, 'Blinding Lights', 'The Weeknd', 'Pop', 200),
(5, 'Excuses', 'AP Dhillon', 'Punjabi', 175);
SELECT song_name, artist
FROM MusicPlaylist
LIMIT 3;
SELECT DISTINCT restaurant
FROM FoodOrders
ORDER BY restaurant;
SELECT 
    food_item AS Dish,
    order_date AS "Date Ordered"
FROM FoodOrders;
SELECT DISTINCT food_item, restaurant FROM FoodOrders LIMIT 2