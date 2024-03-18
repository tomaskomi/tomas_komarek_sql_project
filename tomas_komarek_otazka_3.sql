WITH price_increasing AS (
SELECT
	food_category ,
	avg_price ,
	year_final,
	CASE 
	WHEN year_final = 2006 THEN ''
	-- WHEN food_category = 'Jakostní víno bílé' THEN ROUND((avg_price - 92.42) / 92.42 * 100, 2)
	ELSE ROUND((avg_price - (LAG(avg_price) OVER (ORDER BY food_category, year_final))) / (LAG(avg_price) OVER (ORDER BY food_category, year_final)) * 100, 2)
	END AS percentage_difference
FROM t_tomas_komarek_project_SQL_primary_final
WHERE year_final IN (2006,2018) AND food_category != "Jakostní víno bílé"
GROUP BY food_category, year_final
)
SELECT 
	food_category ,
	percentage_difference
FROM price_increasing
WHERE year_final = 2018
ORDER BY CAST(percentage_difference AS DECIMAL(10,2))
LIMIT 1;