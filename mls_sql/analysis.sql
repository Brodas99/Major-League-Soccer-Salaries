/*alter base_salary column datatype to float */

ALTER TABLE mls_salaries
ALTER COLUMN base_salary TYPE float
USING base_salary::double precision;


/*alter total_compensation column datatype to float*/
ALTER TABLE mls_salaries
ALTER COLUMN total_compensation TYPE float
USING total_compensation::double precision;

/* #updating values in position column to match across the board */

UPDATE mls_salaries
SET position = 'M'
WHERE position = 'M-F'or position = 'M-D' or position = 'M/F' or position = 'M/D'or position = 'MF';


UPDATE mls_salaries
SET position = 'D'
WHERE position = 'D/M'or position = 'D/F' or position = 'D-M' or position = 'D-F';

UPDATE mls_salaries
SET position = 'F'
WHERE position = 'F-M'or position = 'F-D' or position = 'F/M';


/* #MLS Total base-salary per year */
SELECT 
	season, 
	ROUND(SUM(base_salary)) 

FROM mls_salaries
GROUP BY season
ORDER BY season DESC;

/*#Total base_salary per season and per club*/
SELECT 
	season, 
	club, 
	ROUND(SUM(base_salary)) 
FROM mls_salaries
GROUP BY season, club
order by season, club;

/* #subquery to obtain player with the highest paid base salary in MLS history*/
SELECT 
	season,
	club,
	position,
	CONCAT(first_name,' ',last_name)
FROM mls_salaries
WHERE base_salary = 
(SELECT 
	MAX(base_salary) 
FROM mls_salaries);

/*#Average base_salary per club & per position within the club*/
SELECT 
	season, 
	club, 
	position,
	ROUND(AVG(base_salary)) as avg_salary
FROM mls_salaries
GROUP BY season, club, position
ORDER BY club, season DESC;



/*Count how many players each club has per positon and per season */
SELECT season, club,
       COUNT(CASE WHEN position = 'GK' THEN 1 ELSE NULL END) AS GK_count,
       COUNT(CASE WHEN position = 'D' THEN 1 ELSE NULL END) AS D_count,
       COUNT(CASE WHEN position = 'M' THEN 1 ELSE NULL END) AS M_count,
       COUNT(CASE WHEN position = 'F' THEN 1 ELSE NULL END) AS F_count,
       COUNT(1) AS total_players
  FROM mls_salaries
 GROUP BY season, club
 ORDER BY club, season DESC;

/*Counting and displaying the players who have been in the MLS for long than 5 seasons  */
SELECT  
	CONCAT(first_name, ' ', last_name) as full_name, 
	COUNT(1) as mls_years
 FROM mls_salaries
 GROUP BY full_name 
 HAVING COUNT(1) > 5
 ORDER BY COUNT(1) DESC;

/* similar to the jupyter notebook, I joined/merged the mls salaries  with their respective games logs*/
 SELECT 
	 sub.base_salary, g.*
FROM mls_games g
JOIN
(SELECT 
	season, 
	club, 
	ROUND(SUM(base_salary)) as base_salary
FROM mls_salaries 
GROUP BY season, club
order by season, club) sub
ON g.season = sub.season and g.club = sub.club
ORDER BY g.season, g.club;