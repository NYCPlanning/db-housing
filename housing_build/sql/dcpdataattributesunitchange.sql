-- for unit_change_year overwite calcualted values
-- where DCP reseached value is valid
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