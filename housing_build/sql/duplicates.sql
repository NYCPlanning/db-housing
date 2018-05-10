-- Identify potential duplicate records
UPDATE housing
	SET
		x_dup_id = 'ID'
	WHERE
		dcp_status <> 'Withdrawn'
		AND dcp_status <> 'Disapproved'
		AND dcp_status <> 'Suspended'
		AND x_inactive <> 'true'
		AND 
			((units_init <> '0' AND u_prop <> '0')
				OR (units_init <> '0' AND u_prop <> '')
				OR (units_init <> '' AND u_prop <> '0')
				OR (units_init <> '' AND u_prop <> '')
			);

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

UPDATE housing a
	SET
		x_dup_maxcofodate = maxdate
	FROM (SELECT
       	x_dup_id,
       	MAX(latest_effectivedate) AS maxdate
       FROM capitalplanning.dobdev_jobs
       WHERE x_dup_id IS NOT NULL
       GROUP BY x_dup_id) AS b
	WHERE a.x_dup_id = b.x_dup_id;

-- 
UPDATE housing
	SET
		x_dup_flag = 'Possible duplicate',
	WHERE
		x_dup_id IS NOT NULL
		AND x_dup_maxstatusdate > status_date
		AND x_dup_maxcofodate IS NULL
		AND latest_effectivedate IS NULL
		AND dcp_status <> 'Complete';

-- 
UPDATE housing
	SET
		x_dup_flag = 'Possible duplicate',
		x_dup_notes = 'CofOs - Job status is earlier than latest CofO update'
	WHERE
		x_dup_id IS NOT NULL
		AND x_dup_maxcofodate > status_date
		AND x_dup_maxcofodate IS NOT NULL
		AND latest_effectivedate IS NULL
		AND dcp_status <> 'Complete';