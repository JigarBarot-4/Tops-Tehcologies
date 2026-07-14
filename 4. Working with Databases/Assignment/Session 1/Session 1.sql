create database assigment;
use assigment;
CREATE DATABASE music_streaming_app;
SHOW DATABASES;
USE music_streaming_app;
CREATE TABLE playlists (
    playlist_id INT PRIMARY KEY,
    name VARCHAR(255),
    created_by VARCHAR(255)
);
INSERT INTO playlists (playlist_id, name, created_by)
VALUES 
(1, 'Bollywood Hits', 'Aarav'),
(2, 'Chill Vibes', 'Meera'),
(3, 'Workout Mix', 'Rohan');
SELECT *
FROM playlists
WHERE created_by = 'Amit';

#Table
# A table is like a container that stores related data in structured form.

# Column
# A column represents a specific type of information in the table. It defines the structure.

# Row
# A row represents a single record in the table. It contains actual data for one entry.

