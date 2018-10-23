-- overwite DOB data with DCP researched values
-- where DCP reseached value is valid
UPDATE housing a
SET stories_prop = TRIM(b.prop_stories),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.prop_stories ~ '[0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET occ_prop = TRIM(b.dcp_occ_pr),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.dcp_occ_pr IS NOT NULL
	AND a.job_number=b.job_number;

UPDATE housing a
SET occ_init = TRIM(b.dcp_occ_category),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.dcp_occ_category IS NOT NULL
	AND a.job_number=b.job_number;

UPDATE housing a
SET units_init = TRIM(b.units_init),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.units_init ~ '[0-9]'
	AND b.units_init IS NOT NULL
	AND a.job_number=b.job_number;

UPDATE housing a
SET units_prop = TRIM(b.units_prop_res),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.units_prop_res ~ '[0-9]'
	AND b.units_prop_res IS NOT NULL
	AND a.job_number=b.job_number;

UPDATE housing a
SET units_prop = TRIM(b.units_prop),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.units_prop ~ '[0-9]'
	AND a.job_number=b.job_number
	AND b.units_prop_res IS NULL;

UPDATE housing a
SET units_net_complete = TRIM(b.u_net_comp),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.u_net_comp ~ '[0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET units_net_incomplete = TRIM(b.u_net_inc),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.u_net_inc ~ '[0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET latest_cofo = TRIM(b.c_u_latest),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.c_u_latest ~ '[0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET unit_change_2013 = TRIM(b.u_2013_inc),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.u_2013_inc ~ '[0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET unit_change_2015 = TRIM(b.u_2015_inc),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.u_2015_inc ~ '[0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET unit_change_2016 = TRIM(b.u_2016_inc),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.u_2016_inc ~ '[0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET unit_change_2017 = TRIM(b.u_2017_inc),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.u_2017_inc ~ '[0-9]'
	AND a.job_number=b.job_number;