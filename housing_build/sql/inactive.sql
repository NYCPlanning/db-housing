-- Tag projects that have been inactive for at least 5 years
UPDATE housing
	SET x_inactive =
		(CASE
			WHEN (CURRENT_DATE - status_date::date)/365 >= 5 THEN TRUE
			ELSE FALSE
		END)
	WHERE
		dcp_status <> 'Complete'
		AND dcp_status <> 'Complete (demolition)'
		AND dob_status <> 'SIGNED OFF'
		AND dob_status <> 'SIGNED-OFF';

UPDATE housing
	SET x_inactive = FALSE
	WHERE
		x_inactive IS NULL;