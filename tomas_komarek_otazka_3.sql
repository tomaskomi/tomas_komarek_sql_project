WITH price_increasing AS (
SELECT
	food_category ,
	avg_price ,
	fp_year,
	CASE 
	WHEN fp_year = 2006 THEN ''
	WHEN food_category = 'Jakostní víno bílé' THEN ROUND((avg_price - 92.42) / 92.42 * 100, 2)
	ELSE ROUND((avg_price - (LAG(avg_price) OVER (ORDER BY food_category, fp_year))) / (LAG(avg_price) OVER (ORDER BY food_category, fp_year)) * 100, 2)
	END AS percentage_difference
FROM t_tomas_komarek_project_SQL_primary_final
WHERE fp_year IN (2006,2018)
GROUP BY food_category, fp_year
)
SELECT 
	food_category ,
	percentage_difference
FROM price_increasing
WHERE fp_year = 2018 AND percentage_difference > 0
ORDER BY CAST(percentage_difference AS DECIMAL(10,2))
LIMIT 1;