CREATE TABLE Influencers (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);
CREATE TABLE Collaborations (
    id INT PRIMARY KEY,
    influencer1_id INT,
    influencer2_id INT,
    collab_date DATE
);
SELECT 
    i1.name AS influencer_1,
    i2.name AS influencer_2,
    c.collab_date
FROM Influencers i1
LEFT JOIN Collaborations c
    ON i1.id = c.influencer1_id
LEFT JOIN Influencers i2
    ON i2.id = c.influencer2_id

UNION

SELECT 
    i1.name AS influencer_1,
    i2.name AS influencer_2,
    c.collab_date
FROM Influencers i1
RIGHT JOIN Collaborations c
    ON i1.id = c.influencer1_id
RIGHT JOIN Influencers i2
    ON i2.id = c.influencer2_id;
    
SELECT 
    child.id,
    child.playlist_name AS playlist,
    parent.playlist_name AS parent_playlist
FROM Playlists child
LEFT JOIN Playlists parent
    ON child.parent_playlist_id = parent.id;
    
SELECT 
    u.username,
    o.order_date,
    p.amount
FROM Users u
LEFT JOIN Orders o
    ON u.id = o.user_id
LEFT JOIN Payments p
    ON o.id = p.order_id;
    
SELECT DISTINCT
    r.id,
    r.name,
    r.city
FROM Restaurants r
INNER JOIN Reviews rv
    ON r.id = rv.restaurant_id;
    
SELECT
    r.id,
    r.name,
    r.city
FROM Restaurants r
INNER JOIN Reviews rv
    ON r.id = rv.restaurant_id
GROUP BY r.id, r.name, r.city;

SELECT
    p.product_name,
    c.category_name
FROM Products p
INNER JOIN Categories c
ON p.category_id = c.category_id;