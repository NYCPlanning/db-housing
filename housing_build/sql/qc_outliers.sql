-- Generate list of potential outliers for removal
COPY(
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
LIMIT 10)
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
LIMIT 10)
ORDER by units_net
)TO '/prod/db-housing/housing_build/output/qc_outliers.csv' DELIMITER ',' CSV HEADER;