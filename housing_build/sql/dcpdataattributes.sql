-- overwite DOB data with DCP researched values
-- where DCP reseached value is valid
UPDATE housing a
SET stories_prop = TRIM(b.prop_stories),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.prop_stories ~ '[0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET occ_init = TRIM(b.occ_init),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.occ_init IS NOT NULL
	AND a.job_number=b.job_number;

UPDATE housing a
SET occ_prop = TRIM(b.dcp_occ_pr),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.dcp_occ_pr IS NOT NULL
	AND a.job_number=b.job_number;

UPDATE housing a
SET dcp_occ_category = TRIM(b.dcp_occ_category),
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
SET unit_change_preapr2010 = TRIM(b.unit_change_preapr2010),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.unit_change_preapr2010 ~ '[0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET unit_change_postapr2010 = TRIM(b.unit_change_postapr2010),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.unit_change_postapr2010 ~ '[0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET unit_change_2011 = TRIM(b.unit_change_2011),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.unit_change_2011 ~ '[0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET unit_change_2012 = TRIM(b.unit_change_2012),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.unit_change_2012 ~ '[0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET unit_change_2013 = TRIM(b.unit_change_2013),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.unit_change_2013 ~ '[0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET unit_change_2014 = TRIM(b.unit_change_2014),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.unit_change_2014 ~ '[0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET unit_change_2015 = TRIM(b.unit_change_2015),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.unit_change_2015 ~ '[0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET unit_change_2016 = TRIM(b.unit_change_2016),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.unit_change_2016 ~ '[0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET unit_change_2017 = TRIM(b.unit_change_2017),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.unit_change_2017 ~ '[0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET unit_change_2017 = TRIM(b.unit_change_2017),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.unit_change_2017 ~ '[0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET unit_change_2018 = TRIM(b.unit_change_2018),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.unit_change_2018 ~ '[0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET unit_change_2018 = TRIM(b.unit_change_2018),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.unit_change_2018 IS NOT NULL
	AND a.job_number=b.job_number;

UPDATE housing a
SET x_inactive = TRIM(b.x_inactive),
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.x_inactive IS NOT NULL
	AND a.job_number=b.job_number;