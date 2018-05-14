-- populate the dcp occupancy code fields using the housing_input_lookup_occupancy lookup table
-- exitsting 
-- post 2008
UPDATE housing a
SET occ_init = b.dcpclassificationnew
FROM housing_input_lookup_occupancy b
WHERE a.dob_occ_init = b.doboccupancycode2008
	AND (right(status_a,4))::numeric >= 2008;
-- pre 2008
UPDATE housing a
SET occ_init = b.dcpclassificationnew
FROM housing_input_lookup_occupancy b
WHERE a.dob_occ_init = b.doboccupancycode1968
	AND (right(status_a,4))::numeric < 2008;
-- no date filter 2008
UPDATE housing a
SET occ_init = b.dcpclassificationnew
FROM housing_input_lookup_occupancy b
WHERE a.dob_occ_init = b.doboccupancycode2008;
-- no date filter 1968
UPDATE housing a
SET occ_init = b.dcpclassificationnew
FROM housing_input_lookup_occupancy b
WHERE a.dob_occ_init = b.doboccupancycode1968;

-- proposed 
-- post 2008
UPDATE housing a
SET occ_prop = b.dcpclassificationnew
FROM housing_input_lookup_occupancy b
WHERE a.dob_occ_prop = b.doboccupancycode2008
	AND (right(status_a,4))::numeric >= 2008;
-- pre 2008
UPDATE housing a
SET occ_prop = b.dcpclassificationnew
FROM housing_input_lookup_occupancy b
WHERE a.dob_occ_prop = b.doboccupancycode1968
	AND (right(status_a,4))::numeric < 2008;
-- no date filter 2008
UPDATE housing a
SET occ_prop = b.dcpclassificationnew
FROM housing_input_lookup_occupancy b
WHERE a.dob_occ_prop = b.doboccupancycode2008;
-- no date filter 1968
UPDATE housing a
SET occ_prop = b.dcpclassificationnew
FROM housing_input_lookup_occupancy b
WHERE a.dob_occ_prop = b.doboccupancycode1968;

-- mark records as Empty Lots
UPDATE housing
SET occ_init = 'Empty Lot'
WHERE dob_type = 'NB' AND occ_init IS NULL;

UPDATE housing
SET occ_prop = 'Empty Lot'
WHERE dob_type = 'DM' AND occ_prop IS NULL;


-- category
-- set to Residential where exiting or proposed occupany is Residential
UPDATE housing
SET dcp_occ_category = 'Residential'
WHERE occ_init LIKE '%Residential%' OR occ_prop LIKE '%Residential%';

-- otherwise set to other
UPDATE housing
SET dcp_occ_category = 'Other'
WHERE dcp_occ_category IS NULL;