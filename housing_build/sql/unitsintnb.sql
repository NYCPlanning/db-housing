-- set units_init = 0 for new building projects
UPDATE housing
SET units_init = '0'
WHERE units_init IS NULL
AND dob_type = 'NB';