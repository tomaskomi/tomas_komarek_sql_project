WITH comparison AS(
SELECT
	industry_branch_name ,
	year_final ,
	avg_wages ,
	LAG (avg_wages) OVER (ORDER BY industry_branch_name , year_final) AS previous_year,
	CASE
		WHEN year_final = 2006 THEN ''
    	WHEN avg_wages > LAG(avg_wages) OVER (ORDER BY industry_branch_name , year_final) THEN 'Roste'
    	WHEN avg_wages < LAG(avg_wages) OVER (ORDER BY industry_branch_name , year_final) THEN 'Klesá'
    	ELSE 'Stejná'
  	END AS comp_with_pr_year	
FROM t_tomas_komarek_project_SQL_primary_final
GROUP BY industry_branch_name , year_final
)
SELECT 
	industry_branch_name ,
	year_final ,
	comp_with_pr_year
FROM comparison ;
