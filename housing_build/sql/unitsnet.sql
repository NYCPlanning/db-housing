-- populate u_net to capture proposed net change in units
-- negative for demolitions, proposed for new buildings, and net change for alterations
-- (note: if an alteration is missing value for existing or proposed units, value set to null)
UPDATE housing 
SET u_net =
	(CASE
		WHEN dob_type = 'DM' AND u_init ~ '[0-9]' THEN u_init::numeric * -1
		WHEN dob_type = 'NB' AND u_prop ~ '^[0-9\.]+$' THEN u_prop::numeric
		WHEN dob_type = 'A1' AND u_init::integer IS NOT NULL AND u_prop::integer IS NOT NULL AND u_prop ~ '^[0-9\.]+$' AND u_init ~ '[0-9]' THEN u_prop::integer - u_init::integer
		ELSE NULL 
	END);