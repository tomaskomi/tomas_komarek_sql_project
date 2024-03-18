SELECT
	year_final ,
	food_category ,
	avg_price ,
	unit ,
	ROUND (AVG (avg_wages), 1) AS avg_wages_avg ,
	ROUND (AVG (avg_wages)/avg_price, 1) AS quantity
FROM t_tomas_komarek_project_SQL_primary_final
WHERE food_category IN ('Chléb konzumní kmínový', 'Mléko polotučné pasterované')
	AND year_final IN (2006, 2018)
GROUP BY year_final , food_category , avg_price , unit
ORDER BY food_category, year_final ;