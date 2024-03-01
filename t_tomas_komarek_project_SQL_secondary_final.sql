CREATE TABLE t_tomas_komarek_project_SQL_secondary_final AS
WITH european_countries AS(
SELECT country 
FROM countries c
WHERE continent = "Europe"
)
SELECT 
	e.country,
	e.population,
	e.gini, 
	GDP AS gdp ,
	year AS e_year
FROM economies e
JOIN european_countries
	ON e.country = european_countries.country
	AND e.`year` BETWEEN 2006 AND 2018
ORDER BY year;