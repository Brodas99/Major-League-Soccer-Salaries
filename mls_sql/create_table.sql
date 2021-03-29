CREATE TABLE mls_salaries (season INT,
club VARCHAR(255),
first_name VARCHAR(255),
last_name VARCHAR(255),
position VARCHAR(255),
total_compensation VARCHAR(255),
base_salary VARCHAR(255)
);


\COPY mls_salaries FROM 'C:\Users\brodas\Desktop\mls_salaries.csv' DELIMITER ',' CSV HEADER;


CREATE TABLE mls_games(season INT,
club VARCHAR(255),
games_played VARCHAR(255),
wins INT,
lose INT,
ties INT);

\COPY mls_games FROM 'C:\Users\brodas\Desktop\MLS_Games.csv' DELIMITER ',' CSV HEADER;