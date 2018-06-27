-- populate u_net to capture proposed net change in units
-- negative for demolitions, proposed for new buildings, and net change for alterations
-- (note: if an alteration is missing value for existing or proposed units, value set to null)
-- only calculated when both u_init and u_prop are available
UPDATE housing 
SET units_net =
	(CASE
		WHEN dob_type = 'DM' AND units_init ~ '[0-9]' THEN units_init::numeric * -1
		WHEN dob_type = 'NB' AND units_prop ~ '^[0-9\.]+$' THEN units_prop::numeric
		WHEN dob_type = 'A1' AND units_init::integer IS NOT NULL AND units_prop::integer IS NOT NULL AND units_prop ~ '^[0-9\.]+$' AND units_init ~ '[0-9]' THEN units_prop::integer - units_init::integer
		ELSE NULL 
	END)
WHERE units_init ~ '[0-9]' AND units_prop ~ '^[0-9\.]+$' AND units_init IS NOT NULL AND units_prop IS NOT NULL;