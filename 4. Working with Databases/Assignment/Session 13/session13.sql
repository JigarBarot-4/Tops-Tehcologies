CREATE TABLE Playlists (
    id INT,
    user_id INT,
    playlist_name VARCHAR(100),
    total_likes INT
);

INSERT INTO Playlists VALUES
(1, 101, 'Bollywood Hits', 500),
(2, 101, 'Chill Vibes', 800),
(3, 101, 'Workout Mix', 650),

(4, 102, 'Party Songs', 900),
(5, 102, 'Romantic Songs', 700),

(6, 103, 'LoFi Beats', 1200),
(7, 103, 'Focus Music', 1100),

(8, 104, 'Punjabi Hits', 950);

SELECT
    id,
    user_id,
    playlist_name,
    total_likes,

    ROW_NUMBER() OVER (
        ORDER BY total_likes DESC
    ) AS row_num

FROM Playlists;

SELECT
    playlist_name,
    user_id,
    total_likes,

    RANK() OVER (
        ORDER BY total_likes DESC
    ) AS rank_position

FROM Playlists;

SELECT
    playlist_name,
    user_id,
    total_likes,

    DENSE_RANK() OVER (
        PARTITION BY user_id
        ORDER BY total_likes DESC
    ) AS dense_rank_position

FROM Playlists;

SELECT *
FROM (
    SELECT
        id,
        user_id,
        playlist_name,
        total_likes,

        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY total_likes DESC
        ) AS rn

    FROM Playlists
) ranked
WHERE rn <= 2;