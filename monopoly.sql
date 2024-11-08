
-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS PlayerGame;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Player;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS PlayerProperty;
DROP TABLE IF EXISTS Hotel;
DROP TABLE IF EXISTS House;
DROP TABLE IF EXISTS PawnLocation;

-- Create the schema.
CREATE TABLE Game (
	ID integer PRIMARY KEY,
	time timestamp
	);

CREATE TABLE Player (
	ID integer PRIMARY KEY, 
	emailAddress varchar(50) NOT NULL,
	name varchar(50)
	);

CREATE TABLE PawnLocation (
    ID integer PRIMARY KEY
    );

CREATE TABLE PlayerGame (
	gameID integer REFERENCES Game(ID), 
	playerID integer REFERENCES Player(ID),
	score integer,
    cash integer,
    locationID integer REFERENCES PawnLocation(ID)
	);

CREATE TABLE Property (
    ID integer PRIMARY KEY,
    gameID integer REFERENCES Game(ID),
    name varchar(50),
    playerID integer REFERENCES Player(ID)
);

CREATE TABLE PlayerProperty (
    ID integer PRIMARY KEY,
    playerID integer REFERENCES Player(ID),
    propertyID integer REFERENCES Property(ID)
);

CREATE TABLE Hotel (
    playerPropertyID integer REFERENCES PlayerProperty(ID),
    quantity integer
);

CREATE TABLE House (
    playerPropertyID integer REFERENCES PlayerProperty(ID),
    quantity integer
);

-- Allow users to select data from the tables.
GRANT SELECT ON Game TO PUBLIC;
GRANT SELECT ON Player TO PUBLIC;
GRANT SELECT ON PlayerGame TO PUBLIC;
GRANT SELECT ON Property TO PUBLIC;
GRANT SELECT ON PlayerProperty TO PUBLIC;
GRANT SELECT ON Hotel TO PUBLIC;
GRANT SELECT ON House TO PUBLIC;
GRANT SELECT ON PawnLocation TO PUBLIC;

-- Add sample records.
INSERT INTO Game VALUES (1, '2006-06-27 08:00:00');
INSERT INTO Game VALUES (2, '2006-06-28 13:20:00');
INSERT INTO Game VALUES (3, '2006-06-29 18:41:00');

INSERT INTO Player(ID, emailAddress) VALUES (1, 'me@calvin.edu');
INSERT INTO Player VALUES (2, 'king@gmail.edu', 'The King');
INSERT INTO Player VALUES (3, 'dog@gmail.edu', 'Dogbreath');

INSERT INTO PawnLocation VALUES (8);
INSERT INTO PawnLocation VALUES (16);
INSERT INTO PawnLocation VALUES (10);
INSERT INTO PawnLocation VALUES (5);
INSERT INTO PawnLocation VALUES (30);
INSERT INTO PawnLocation VALUES (22);
INSERT INTO PawnLocation VALUES (15);
INSERT INTO PawnLocation VALUES (18);

INSERT INTO PlayerGame VALUES (1, 1, 0.00, 20.00, 8);
INSERT INTO PlayerGame VALUES (1, 2, 0.00, 50.00, 16);
INSERT INTO PlayerGame VALUES (1, 3, 2350.00, 2000.00, 10);
INSERT INTO PlayerGame VALUES (2, 1, 1000.00, 320.00, 5);
INSERT INTO PlayerGame VALUES (2, 2, 0.00, 30.00, 30);
INSERT INTO PlayerGame VALUES (2, 3, 500.00, 579.00, 22);
INSERT INTO PlayerGame VALUES (3, 2, 0.00, 489.00, 15);
INSERT INTO PlayerGame VALUES (3, 3, 5500.00, 38.00, 18);

INSERT INTO Property VALUES (6, 1, 'Connecticut Avenue', 1);
INSERT INTO Property VALUES (24, 1, 'Pacific Avenue', 1);
INSERT INTO Property VALUES (29, 1, 'Boardwalk', 1);
INSERT INTO Property VALUES (15, 1, 'Kentucky Avenue', 2);
INSERT INTO Property VALUES (3, 1, 'Reading Railroad', 2);
INSERT INTO Property VALUES (1, 1, 'Mediterranean Avanue', 3);
INSERT INTO Property VALUES (8, 1, 'Electric Company', 3);

INSERT INTO PlayerProperty VALUES (1, 1, 6);
INSERT INTO PlayerProperty VALUES (2, 1, 24);
INSERT INTO PlayerProperty VALUES (3, 1, 29);
INSERT INTO PlayerProperty VALUES (4, 2, 15);
INSERT INTO PlayerProperty VALUES (5, 2, 3);
INSERT INTO PlayerProperty VALUES (6, 3, 1);
INSERT INTO PlayerProperty VALUES (7, 3, 8);

INSERT INTO Hotel VALUES (1, 1);
INSERT INTO Hotel VALUES (3, 2);
INSERT INTO Hotel VALUES (5, 1);

INSERT INTO House VALUES (2, 3);
INSERT INTO House VALUES (6, 4);
INSERT INTO House VALUES (7, 4);

-- 8.1 questions
SELECT * FROM Game ORDER BY time;
SELECT * FROM Game WHERE time >= NOW()::DATE - 7;
SELECT * FROM Player WHERE name IS NOT null;
SELECT playerID FROM PlayerGame WHERE score > 2000;
SELECT * FROM Player WHERE emailAddress LIKE '%gmail%';

-- 8.2 questions
SELECT score FROM PlayerGame, Player
WHERE Player.name = 'The King'
AND PlayerGame.playerID = 2
ORDER BY score DESC;

SELECT name FROM Player, Game, PlayerGame
WHERE Game.time = '2006-06-28 13:20:00'
AND Player.ID = PlayerGame.playerID
AND Game.ID = PlayerGame.gameID
ORDER BY score DESC
LIMIT 1;

-- c.
-- It prevents duplicates-makes sure that you're not just comparing 
-- the same exact person but rather 2 different people with the same home. 

-- d.
-- If you have a wearhouse with a bunch of products, maybe a specific product will have 
-- multiple entries with the same name but different sizes or colors. In order to take 
-- inventory of that specific product, you'd have to use the self-join. 


