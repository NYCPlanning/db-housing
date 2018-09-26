-- Generate list of potential outliers for removal
-- criteria
-- 1) top 20 and bottom 20 for units_net
-- 2) top 20 for units_init and top 20 for units_prop
-- 3) units_net_complete is 50+ units greater than units proposed (NBs only)
-- 2) job_type= DM and units_init > 19
-- 3) job_type= A1 and units_net < -50
-- 4) job_type= A1, TOP 20 for units_net
-- 5) job_type= A1, TOP 10 for u_prop
-- 6) job_type= NB and units_init NOT 0
-- 7) job_description (field does not currently exist) contains both '%RESID%' AND '%HOTEL%'

DROP TABLE IF EXISTS qc_outliers;
CREATE TABLE qc_outliers AS (
(SELECT * 
FROM housing
WHERE
	dob_type = 'NB'
	AND (units_net_complete::integer - units_prop::integer) >= 50)
UNION
(SELECT * 
FROM housing
WHERE
	dob_type = 'DM'
	AND units_init::integer >= 20)
UNION
(SELECT * 
FROM housing
WHERE
	dob_type = 'A1'
	AND units_net::integer <= -50)
UNION
(SELECT * 
FROM housing
WHERE
	dob_type = 'A1'
	AND units_net IS NOT NULL
	AND (dcp_status <> 'Withdrawn' OR dcp_status IS NULL)
	AND x_dup_flag IS NULL
ORDER BY
	units_net DESC
LIMIT 20)
UNION
(SELECT * 
FROM housing
WHERE
	dob_type = 'A1'
	AND units_prop IS NOT NULL
	AND (dcp_status <> 'Withdrawn' OR dcp_status IS NULL)
	AND x_dup_flag IS NULL
ORDER BY
	units_prop DESC
LIMIT 10)
UNION
(SELECT * 
FROM housing
WHERE
	dob_type = 'NB'
	AND units_init::integer <> 0)
UNION
(SELECT * 
FROM housing
WHERE
	upper(job_description) LIKE '%RESID%HOTEL%'
	OR upper(job_description) LIKE '%HOTEL%RESID%')
);

\copy (SELECT * FROM qc_outliers) TO '/prod/db-housing/housing_build/output/qc_outliers.csv' DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS qc_outliers;