CREATE TABLE t_tomas_komarek_project_SQL_primary_final AS
WITH food_price AS -- tabulka cen
( 
SELECT 
	year(date_from) AS fp_year, 
	cpc.name AS food_category,
	cpc.price_value AS quantity,
	cpc.price_unit AS unit,
	round(avg(value), 2) AS avg_price	
FROM czechia_price cprc 
JOIN czechia_price_category cpc
	ON cpc.code = cprc.category_code
GROUP BY year(date_from), cpc.name, cpc.price_value, cpc.price_unit
),
payroll AS -- tabulka mezd
(
SELECT
	payroll_year,
	cpib.name AS industry_branch_name,
	round(avg (value), 2) AS avg_wages
FROM czechia_payroll cpay
JOIN czechia_payroll_industry_branch cpib 
	ON cpay.industry_branch_code = cpib.code 
	AND cpay.value_type_code = 5958
GROUP BY payroll_year, cpib.name
)
-- propojení payroll a food_price
SELECT 
	industry_branch_name,
	avg_wages,
	food_category,
	quantity,
	unit,
	avg_price,
	fp_year
FROM payroll pay
JOIN food_price fp
	ON pay.payroll_year = fp.fp_year;
