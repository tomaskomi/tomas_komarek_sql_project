SELECT
	fp_year ,
	food_category ,
	avg_price ,
	unit ,
	ROUND (avg_wages/avg_price, 2) AS quantity , 
	ROUND (AVG (avg_wages), 2) AS avg_wages_avg
FROM t_tomas_komarek_project_SQL_primary_final
WHERE food_category IN ('Chléb konzumní kmínový', 'Mléko polotučné pasterované')
	AND fp_year IN (2006, 2018)
GROUP BY fp_year , food_category , avg_price , unit
ORDER BY food_category, fp_year ;