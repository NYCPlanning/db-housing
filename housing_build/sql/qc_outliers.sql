-- Generate list of potential outliers for removal
-- criteria
-- 1) top 20 and bottom 20 for units_net
-- 2) top 20 for units_init and top 20 for units_prop
-- 3) units_net_complete is 50+ units greater than units proposed (NBs only)
DROP TABLE IF EXISTS qc_outliers;
CREATE TABLE qc_outliers AS (
(SELECT
	* 
FROM
	housing
WHERE
	units_net IS NOT NULL
	AND (dcp_status <> 'Withdrawn' OR dcp_status IS NULL)
	AND x_dup_flag IS NULL
ORDER BY
	units_net DESC
LIMIT 20)
UNION
(SELECT
	* 
FROM
	housing
WHERE
	units_net IS NOT NULL
	AND (dcp_status <> 'Withdrawn' OR dcp_status IS NULL)
	AND x_dup_flag IS NULL
ORDER BY
	units_net ASC
LIMIT 20)
UNION
(SELECT
	* 
FROM
	housing
WHERE
	units_init IS NOT NULL
	AND (dcp_status <> 'Withdrawn' OR dcp_status IS NULL)
	AND x_dup_flag IS NULL
ORDER BY
	units_init DESC
LIMIT 20)
UNION
(SELECT
	* 
FROM
	housing
WHERE
	units_prop IS NOT NULL
	AND (dcp_status <> 'Withdrawn' OR dcp_status IS NULL)
	AND x_dup_flag IS NULL
ORDER BY
	units_prop DESC
LIMIT 20)
UNION
(SELECT
	* 
FROM
	housing
WHERE
	dob_type = 'NB'
	AND (units_net_complete::integer - units_prop::integer) >= 50)
);

\copy (SELECT * FROM qc_outliers) TO '/prod/db-housing/housing_build/output/qc_outliers.csv' DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS qc_outliers;