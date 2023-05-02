USE albums_db; -- 1.

SHOW TABLES;

SHOW CREATE TABLE albums; -- 2a the primary key is the id field
DESCRIBE albums;  -- 2b. two ways to accomplish same task

-- 3.  The name of the album
SELECT * FROM albums; -- from class review
-- 4.  The sales in millions

-- 5. 'The Dark Side of the Moon' and 'The Wall'
SELECT name -- SELECT * from class.
FROM albums
WHERE artist = "Pink Floyd";

-- 6. 1967
SELECT release_date
FROM albums
WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

-- 7. Grunge, Alternative rock
SELECT genre
FROM albums
WHERE name = 'Nevermind';

-- 8. The Bodyguard, Jagged Little Pill, Come On Over, Falling into You, Let's Talk About Love, Dangerous, 
-- The Immaculate Collection, Titanic: Music from the Motion Picture, Metallica, Nevermind and Supernatural
SELECT name, release_date -- just to check and cross reference the exclusive left and inclusive right 
FROM albums
WHERE release_date BETWEEN 1990 AND 1999; -- initially used 1989 for exclusive lower bound but 1990 worked as well 
-- Between statement is inclusive with numbers (int, float, decimals) but NOT datetime

-- 9.  Grease: The Original Sountrack from the Motion Picture, Bad, Sgt. Pepper's Lonely Hearts Club Band, Dirty Dancing, Let's Talk About Love,
-- Dangerous, The Immaculate Collection, Abbey Road, Born in the U.S.A., Brothers in Arms, Titanic: Music from the Motion Picture, Nevermind, The Wall
SELECT name AS low_selling_albums, sales -- sales column just to confirm
FROM albums
WHERE sales < 20;