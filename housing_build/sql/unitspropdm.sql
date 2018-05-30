-- set units_prop = 0 for demolition projects
UPDATE housing
SET units_prop = '0'
WHERE units_prop IS NULL
AND dob_type = 'DM';