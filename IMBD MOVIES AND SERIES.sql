--SELECT FIELDS THAT WE ARE GOING TO EXPLORE

SELECT	
	ranking,Movie_Name,DIRECTOR,genre,RATING FROM MOVIES

SELECT
	[ranking ],[series name],genre,rating from SERIES

----------------------------------------------------------------------------------------------------------------------------------------------

--USING JOINS TO EXPLORE MOVIES AND SERIES TABLES

SELECT
	M.Movie_Name, M.DIRECTOR,M.[ACTOR 1],M.[ACTOR 2],M.[ACTOR 3],M.[ACTOR 4],
	S.[series name],S.genre,S.[ACTOR 1],S.[ACTOR 2],S.[ACTOR 3],S.[ACTOR 4]
	FROM MOVIES M INNER JOIN SERIES S ON M.[ACTOR 1] = S.[ACTOR 1]

SELECT
	M.Movie_Name, M.DIRECTOR,M.[ACTOR 1],M.[ACTOR 2],M.[ACTOR 3],M.[ACTOR 4],
	S.[series name],S.genre,S.[ACTOR 1],S.[ACTOR 2],S.[ACTOR 3],S.[ACTOR 4]
	FROM MOVIES M RIGHT JOIN SERIES S ON M.[ACTOR 1] = S.[ACTOR 1]

SELECT
	M.Movie_Name, M.DIRECTOR,M.[ACTOR 1],M.[ACTOR 2],M.[ACTOR 3],M.[ACTOR 4],
	S.[series name],S.genre,S.[ACTOR 1],S.[ACTOR 2],S.[ACTOR 3],S.[ACTOR 4]
	FROM MOVIES M LEFT JOIN SERIES S ON
	M.[ACTOR 1] = S.[ACTOR 1]

--TO REMOVE DUPLICATES BY USING DISTINCT 
SELECT
	DISTINCT M.Movie_Name, M.DIRECTOR,S.[series name],S.genre
	FROM MOVIES M FULL JOIN SERIES S ON M.[ACTOR 1] = S.[ACTOR 1]

----------------------------------------------------------------------------------------------------------------------------------------------

--BY USING UNION TO APPEND SIMILAR FIELDS FROM MOVIES AND SERIES TABLE
SELECT
	DISTINCT [ACTOR 1],[ACTOR 2],[ACTOR 3],[ACTOR 4] FROM MOVIES
	UNION 
SELECT
	DISTINCT [ACTOR 1],[ACTOR 2],[ACTOR 3],[ACTOR 4] FROM SERIES

------------------------------------------------------------------------------------------------------------------------------------------------

--USING CASE STAEMENT TO GET RANKING  
SELECT 
	s.[ranking ], s.rating, s.VOTES, 
	CASE
		WHEN s.[ranking ] > 130 THEN 'C'
		WHEN s.[ranking ] BETWEEN 80 AND 130 THEN 'B'
		ELSE 'A'
	END AS CATEGORY
	FROM MOVIES AS m INNER JOIN SERIES AS s ON
	m.[ACTOR 1] = s.[ACTOR 1]

----------------------------------------------------------------------------------------------------------------------------------------------

--USING AGGREGATE FUNCTIONS TO EXPLORE DATA

SELECT
	S.rating,COUNT(S.rating) AS total FROM MOVIES AS M 
	INNER JOIN SERIES AS S
	ON M.[ACTOR 1] = S.[ACTOR 1]
	GROUP BY S.rating
	HAVING COUNT(S.rating) > 2

SELECT 
	S.runtime, S.VOTES, AVG(S.VOTES) average FROM MOVIES AS M 
	INNER JOIN SERIES AS S ON
	M.[ACTOR 1] = S.[ACTOR 1]
	GROUP BY S.runtime, S.VOTES
	HAVING AVG(S.VOTES) > 45000
	ORDER BY AVG(S.VOTES)

----------------------------------------------------------------------------------------------------------------------------------------------

--TO REMOVE NULL VALUES BY USING NOT NULL FUNCTION

SELECT 
	* FROM MOVIES 
	WHERE metascore IS NOT NULL
	AND [GROSS COLLECTION] IS NOT NULL

SELECT 
	DIRECTOR,Movie_Name,genre FROM MOVIES
	WHERE metascore>50 AND metascore IS NOT NULL

----------------------------------------------------------------------------------------------------------------------------------------------

--WRITING SUB QUERY TO GET RATING GREATER THAN 9 AND VOTETES GREATER THAN ONE LAKH
SELECT
	* FROM MOVIES WHERE Movie_Name in
	(SELECT Movie_Name FROM MOVIES WHERE RATING>=9)

SELECT 
	[series name],genre,rating FROM SERIES WHERE [ranking ] IN
	(SELECT [ranking ] FROM SERIES WHERE runtime >= '100min' AND [ranking ]<=100 AND VOTES>100000)

---------------------------------------------------------------------------------------------------------------------------------------------

--CTE

WITH Movieslist (Movie_Name,ranking,rating)  AS
(SELECT movie_name,ranking,RATING FROM Movies WHERE ranking>8.3)
SELECT * FROM Movieslist

----------------------------------------------------------------------------------------------------------------------------------------------

--CREATING A VIEW FOR REPORTING PURPOSE

CREATE VIEW my_view AS
SELECT * FROM Movies
GO
SELECT * FROM my_view

