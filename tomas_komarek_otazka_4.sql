WITH diff AS (
SELECT 
	fp_year ,
	AVG (avg_wages) AS all_wages_avg , 
	(AVG (avg_wages) - LAG(AVG (avg_wages)) OVER (ORDER BY fp_year)) / (LAG(AVG (avg_wages)) OVER (ORDER BY fp_year)) * 100 AS wages_percentage_diff,
	AVG (avg_price) AS all_food_avg , 
	(AVG (avg_price) - LAG(AVG (avg_price)) OVER (ORDER BY fp_year)) / (LAG(AVG (avg_price)) OVER (ORDER BY fp_year)) * 100 AS price_percentage_diff
	FROM t_tomas_komarek_project_SQL_primary_final
GROUP BY fp_year 
ORDER BY fp_year
)
SELECT 
	fp_year,
	wages_percentage_diff,
	price_percentage_diff,
	CASE
		WHEN price_percentage_diff < 0 THEN 'Ceny nerostly'
		WHEN ABS(price_percentage_diff / wages_percentage_diff) > 1.1 THEN 'Růst větší než 10%'
		ELSE 'Růst menší než 10%'
	END AS case_result
FROM diff