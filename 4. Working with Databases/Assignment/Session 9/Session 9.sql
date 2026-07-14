CREATE TABLE restaurants_1 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);
CREATE TABLE dishes (
    id INT PRIMARY KEY,
    restaurant_id INT,
    dish_name VARCHAR(100),
    price DECIMAL(10,2),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id)
);
INSERT INTO restaurants_1 (id, name, city)
VALUES
(1, 'The Spice House', 'Ahmedabad'),
(2, 'Pizza Hub', 'Mumbai'),
(3, 'Dragon Wok', 'Delhi');
INSERT INTO dishes (id, restaurant_id, dish_name, price)
VALUES
(7, 3, 'Hakka Noodles', 200.00),
(8, 3, 'Manchurian', 220.00),
(9, 3, 'Spring Rolls', 150.00);
INSERT INTO dishes (id, restaurant_id, dish_name, price)
VALUES
(1, 1, 'Paneer Butter Masala', 250.00),
(2, 1, 'Dal Tadka', 180.00),
(3, 1, 'Naan', 40.00);

SELECT 
    dishes.dish_name,
    dishes.price,
    name AS r_name,
    restaurants.city
FROM dishes
INNER JOIN restaurants_1
ON dishes.restaurant_id = restaurants.id;

SELECT 
    playlists.id AS playlist_id,
    playlists.name AS playlist_name,
    songs.song_name,
    songs.artist
FROM playlists
LEFT JOIN songs
ON playlists.id = songs.playlist_id;