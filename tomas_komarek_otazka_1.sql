SELECT
	industry_branch_name ,
	fp_year ,
	avg_wages ,
	-- LAG (avg_wages) OVER (ORDER BY industry_branch_name , fp_year) AS previous_year,
	CASE
		WHEN fp_year = 2006 THEN ''
    	WHEN avg_wages > LAG(avg_wages) OVER (ORDER BY industry_branch_name , fp_year) THEN 'Roste'
    	WHEN avg_wages < LAG(avg_wages) OVER (ORDER BY industry_branch_name , fp_year) THEN 'Klesá'
    	ELSE 'Stejná'
  	END AS comp_with_pr_year	
FROM t_tomas_komarek_project_SQL_primary_final
GROUP BY industry_branch_name , fp_year ;
