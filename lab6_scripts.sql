CREATE TABLE IF NOT EXISTS football_games (
  visitor_name VARCHAR(30),       /* Name of the visiting team                     */
  home_score SMALLINT NOT NULL,   /* Final score of the game for the Buffs         */
  visitor_score SMALLINT NOT NULL,/* Final score of the game for the visiting team */  
  game_date DATE NOT NULL,        /* Date of the game                              */
  players INT[] NOT NULL,         /* This array consists of the football player ids (basically a foreign key to the football_player.id) */
  PRIMARY KEY(visitor_name, game_date) /* A game's unique primary key consists of the visitor_name & the game date (this assumes you can't have multiple games against the same team in a single day) */
);

CREATE TABLE IF NOT EXISTS football_players(
  id SERIAL PRIMARY KEY,       /* Unique identifier for each player (it's possible multiple players have the same name/similiar information) */
  name VARCHAR(50) NOT NULL,   /* The player's first & last name */
  year VARCHAR(3),             /* FSH - Freshman, SPH - Sophomore, JNR - Junior, SNR - Senior */
  major VARCHAR(4),            /* The unique 4 character code used by CU Boulder to identify student majors (ex. CSCI, ATLS) */
  passing_yards SMALLINT,      /* The number of passing yards in the players entire football career  */
  rushing_yards SMALLINT,      /* The number of rushing yards in the players entire football career  */
  receiving_yards SMALLINT,    /* The number of receiving yards in the players entire football career*/
  img_src VARCHAR(200)         /* This is a file path (absolute or relative), that locates the player's profile image */
);

INSERT INTO football_games(visitor_name, home_score, visitor_score, game_date, players)
VALUES('Colorado State', 45, 13, '20180831', ARRAY [1,2,3,4,5]),
('Nebraska', 33, 28, '20180908', ARRAY [2,3,4,5,6]),
('New Hampshire', 45, 14, '20180915', ARRAY [3,4,5,6,7]),
('UCLA', 38, 16, '20180928', ARRAY [4,5,6,7,8]),
('Arizona State', 28, 21, '20181006', ARRAY [5,6,7,8,9]),
('Southern California', 20, 31, '20181013', ARRAY [6,7,8,9,10]),
('Washington', 13, 27, '20181020', ARRAY [7,8,9,10,1]),
('Oregon State', 34, 41, '20181027', ARRAY [8,9,10,1,2]),
('Arizona', 34, 42, '20181102', ARRAY [9,10,1,2,3]),
('Washington State', 7, 31, '20181110', ARRAY [10,1,2,3,4]),
('Utah', 7, 30, '20181117', ARRAY [1,2,3,4,5]),
('California', 21, 33, '20181124', ARRAY [2,3,4,5,6])
;

INSERT INTO football_players(name, year, major, passing_yards, rushing_yards, receiving_yards)
VALUES('Cedric Vega', 'FSH', 'ARTS', 15, 25, 33),
('Myron Walters', 'SPH', 'CSCI', 32, 43, 52),
('Javier Washington', 'JNR', 'MATH', 1, 61, 45),
('Wade Farmer', 'SNR', 'ARTS', 14, 55, 12),
('Doyle Huff', 'FSH', 'CSCI', 23, 44, 92),
('Melba Pope', 'SPH', 'MATH', 13, 22, 45),
('Erick Graves', 'JNR', 'ARTS', 45, 78, 98 ),
('Charles Porter', 'SNR', 'CSCI', 92, 102, 125),
('Rafael Boreous', 'JNR', 'MATH', 102, 111, 105),
('Jared Castillo', 'SNR', 'ARTS', 112, 113, 114);


/* 1 */
CREATE TABLE IF NOT EXISTS university_info(
	university_name TEXT,
	date_established DATE,
	address TEXT,
	student_pop INT,
	accept_rate REAL);

/* 2 */
INSERT INTO university_info(university_name, date_established, address, student_pop, accept_rate)
VALUES ('CU BOULDER',to_date('18760000','yyyymmdd'),'11-- 28th St, Boulder, CO 80303', 35000, .80);

/* 3 */
SELECT name, major
	FROM football_players
	ORDER BY major;

/* 4 */
SELECT name, rushing_yards
	FROM football_players
	WHERE rushing_yards > 100;

/* 5 */
SELECT * FROM football_games
	WHERE visitor_name='Nebraska';

/* 6 */
SELECT * FROM football_games
	WHERE home_score > visitor_score;

/* 7 */
SELECT visitor_name, game_date
	FROM football_games;

/* 8 */
CREATE VIEW winning_games AS
	SELECT COUNT(*) AS "win_total"
	FROM football_games
	WHERE home_score > visitor_score;

/* 9 */
CREATE VIEW total_games AS
	SELECT COUNT(*) AS "game_total"
	FROM football_games;

/* 10 */
SELECT (CAST((SELECT win_total FROM winning_games)AS REAL)/CAST((SELECT game_total FROM total_games)AS REAL))
	AS "win_percent";

/* 11 */
SELECT COUNT(*) FROM football_games
	AS "Cedric's Games"
	WHERE (SELECT id FROM football_players WHERE name='Cedric Vega')=any(players);

/* 12 */
SELECT (CAST((SELECT rushing_yards FROM football_players WHERE name='Cedric Vega')AS REAL)/
	(CAST((SELECT game_total FROM total_games)AS REAL)))
	AS "Avg Rush";