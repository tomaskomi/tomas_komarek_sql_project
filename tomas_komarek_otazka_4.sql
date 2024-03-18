WITH diff AS (
SELECT 
	year_final ,
	AVG (avg_wages) AS all_wages_avg , 
	(AVG (avg_wages) - LAG(AVG (avg_wages)) OVER (ORDER BY year_final)) / (LAG(AVG (avg_wages)) OVER (ORDER BY year_final)) * 100 AS wages_percentage_diff,
	AVG (avg_price) AS all_food_avg , 
	(AVG (avg_price) - LAG(AVG (avg_price)) OVER (ORDER BY year_final)) / (LAG(AVG (avg_price)) OVER (ORDER BY year_final)) * 100 AS price_percentage_diff
	FROM t_tomas_komarek_project_SQL_primary_final
GROUP BY year_final 
ORDER BY year_final
)
SELECT 
	year_final,
	wages_percentage_diff,
	price_percentage_diff,
	CASE
		WHEN ABS(price_percentage_diff - wages_percentage_diff) > 10 THEN 'Růst větší než 10%'
		ELSE 'Růst menší než 10%'
	END AS case_result
FROM diff