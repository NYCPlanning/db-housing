-- populate the dcp development category field
WITH devcatlookup AS (
SELECT DISTINCT dob_type,
	(CASE 
		WHEN dob_type = 'A1' THEN 'Alteration'
		WHEN dob_type = 'DM' THEN 'Demolition'
		WHEN dob_type = 'NB' THEN 'New Building'
		ELSE NULL
	END ) dcpdevcat
FROM housing
)

UPDATE housing a
SET job_type = b.dcpdevcat
FROM devcatlookup b
WHERE a.dob_type=b.dob_type;