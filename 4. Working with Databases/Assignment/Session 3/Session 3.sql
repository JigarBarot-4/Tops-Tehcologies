CREATE TABLE Playlist (
    id INT PRIMARY KEY,
    song_name VARCHAR(255),
    artist VARCHAR(255),
    duration INT
);
INSERT INTO Playlist (id, song_name, artist, duration)
VALUES (1, 'Blinding Lights', 'The Weeknd', 200);
INSERT INTO Playlist (id, song_name, artist, duration)
VALUES 
(4, 'Calm Down', 'Rema & Selena Gomez', 239),
(5, 'Kesariya', 'Arijit Singh', 268),
(6, 'Shape of You', 'Ed Sheeran', 233);
UPDATE Playlist
SET artist = 'Arijit Singh'
WHERE artist = 'Arjit Singh';
DELETE FROM Playlist
WHERE duration < 120;
SELECT * FROM Playlist;
UPDATE Playlist
SET song_name = CONCAT(song_name, ' (Remix)')
WHERE artist = 'AP Dhillon'
AND duration > 180;