-- Identify potential duplicate records
-- generate unique id for potential duplicates
UPDATE housing
	SET
		x_dup_id = job_type||bbl||bin||address
	WHERE
		dcp_status <> 'Withdrawn'
		AND dcp_status <> 'Disapproved'
		AND dcp_status <> 'Suspended'
		AND x_inactive <> 'true'
		AND 
			((units_init <> '0' AND units_prop <> '0')
				OR (units_init <> '0' AND units_prop <> '')
				OR (units_init <> '' AND units_prop <> '0')
				OR (units_init <> '' AND units_prop <> '')
			);
-- calculate the max status date for each unique dup id
UPDATE housing a
	SET
		x_dup_maxstatusdate = maxdate
	FROM (SELECT 
       	x_dup_id,
       	MAX(status_date) AS maxdate
       FROM housing
       WHERE x_dup_id IS NOT NULL
       GROUP BY x_dup_id) AS b
	WHERE a.x_dup_id = b.x_dup_id;
-- calculate the max cofo date for each unique dup id
UPDATE housing a
	SET
		x_dup_maxcofodate = maxdate
	FROM (SELECT
       	x_dup_id,
       	MAX(latest_effectivedate) AS maxdate
       FROM housing
       WHERE x_dup_id IS NOT NULL
       GROUP BY x_dup_id) AS b
	WHERE a.x_dup_id = b.x_dup_id;
-- flag possible duplicates based on records having a max status date > the status date
UPDATE housing
	SET
		x_dup_flag = 'Possible duplicate'
	WHERE
		x_dup_id IS NOT NULL
		AND x_dup_maxstatusdate > status_date
		AND x_dup_maxcofodate IS NULL
		AND latest_effectivedate IS NULL
		AND dcp_status <> 'Complete';
-- flag possible duplicates based on records having a max c of o date > the status date
UPDATE housing
	SET
		x_dup_flag = 'Possible duplicate'
	WHERE
		x_dup_id IS NOT NULL
		AND x_dup_maxcofodate > status_date
		AND x_dup_maxcofodate IS NOT NULL
		AND latest_effectivedate IS NULL
		AND dcp_status <> 'Complete';