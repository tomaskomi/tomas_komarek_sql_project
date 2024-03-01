WITH gdp_impact AS (
SELECT
	e_year,
	ttkpssf.gdp AS gdp,
	ROUND((ttkpssf.gdp - (LAG(ttkpssf.gdp) OVER (ORDER BY e_year))) / (LAG(ttkpssf.gdp) OVER (ORDER BY e_year)) * 100, 2) AS gdp_diff,
	AVG(avg_wages) AS wages,
	(AVG(avg_wages) - (LAG(AVG(avg_wages)) OVER (ORDER BY e_year, ttkpssf.GDP))) / (LAG(AVG(avg_wages)) OVER (ORDER BY e_year, ttkpssf.GDP)) * 100 AS wages_diff,
	AVG(avg_price) AS price,
	(AVG(avg_price) - (LAG(AVG(avg_price)) OVER (ORDER BY e_year, ttkpssf.GDP))) / (LAG(AVG(avg_price)) OVER (ORDER BY e_year, ttkpssf.GDP)) * 100 AS price_diff
FROM t_tomas_komarek_project_SQL_primary_final ttkpspf 
JOIN t_tomas_komarek_project_SQL_secondary_final ttkpssf 
	ON ttkpspf.fp_year = ttkpssf.e_year
	AND ttkpssf.country = "Czech Republic"
GROUP BY e_year, ttkpssf.GDP
)
SELECT 
	e_year AS year,
	gdp_diff,
	ROUND (wages_diff, 2) AS wages_diff,
	ROUND (price_diff, 2) AS price_diff,
	CASE 
		WHEN gdp_diff > 3 AND wages_diff > 3 AND price_diff > 3 THEN 'Významný růst gdp, cen a mezd současně'
		WHEN gdp_diff > 3 AND (wages_diff < 3 OR price_diff < 3) THEN 'Významný růst gdp'
		ELSE ''	
	END AS gdp_current_year_wages_price,
	CASE 
		WHEN LAG(gdp_diff) OVER (ORDER BY e_year) > 3 AND wages_diff > 3 AND price_diff > 3 THEN 'Významný růst gdp, cen a mezd současně'
		WHEN LAG(gdp_diff) OVER (ORDER BY e_year) > 3 AND (wages_diff < 3 OR price_diff < 3) THEN 'Významný růst gdp'
		ELSE ''	
	END AS gdp_previous_year_wages_price
FROM gdp_impact