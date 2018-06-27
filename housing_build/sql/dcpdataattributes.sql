-- overwite DOB data with DCP researched values

UPDATE housing a
SET stories_prop = b.prop_stories,
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.prop_stories ~ '[^0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET dcp_occ_category = b.dcp_occ_pr,
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.dcp_occ_pr IS NOT NULL
	AND a.job_number=b.job_number;

UPDATE housing a
SET units_prop = b.units_prop_res,
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.units_prop_res ~ '[^0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET units_prop = b.u_prop,
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.u_prop ~ '[^0-9]'
	AND a.job_number=b.job_number
	AND b.units_prop_res<>b.u_prop;

UPDATE housing a
SET units_net_complete = b.u_net_comp,
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.u_net_comp ~ '[^0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET units_net_incomplete = b.u_net_inc,
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.u_net_inc ~ '[^0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET latest_cofo = b.c_u_latest,
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.c_u_latest ~ '[^0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET unit_change_2013 = b.u_2013_inc,
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.u_2013_inc ~ '[^0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET unit_change_2015 = b.u_2015_inc,
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.u_2015_inc ~ '[^0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET unit_change_2016 = b.u_2016_inc,
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.u_2016_inc ~ '[^0-9]'
	AND a.job_number=b.job_number;

UPDATE housing a
SET unit_change_2017 = b.u_2017_inc,
	x_dcpedited = TRUE
FROM housing_input_dcpattributes b
WHERE b.u_2017_inc ~ '[^0-9]'
	AND a.job_number=b.job_number;