-- populate the dcp occupancy code fields using the housing_input_lookup_occupancy lookup table
-- exitsting 
-- post 2008
UPDATE housing a
SET dcp_occ_init = b.dcpclassificationnew
FROM housing_input_lookup_occupancy b
WHERE a.dob_occ_init = b.doboccupancycode2008
	AND (right(status_a,4))::numeric >= 2008;
-- pre 2008
UPDATE housing a
SET dcp_occ_init = b.dcpclassificationnew
FROM housing_input_lookup_occupancy b
WHERE a.dob_occ_init = b.doboccupancycode1968
	AND (right(status_a,4))::numeric < 2008;
-- no date filter 2008
UPDATE housing a
SET dcp_occ_init = b.dcpclassificationnew
FROM housing_input_lookup_occupancy b
WHERE a.dob_occ_init = b.doboccupancycode2008;
-- no date filter 1968
UPDATE housing a
SET dcp_occ_init = b.dcpclassificationnew
FROM housing_input_lookup_occupancy b
WHERE a.dob_occ_init = b.doboccupancycode1968;

-- proposed 
-- post 2008
UPDATE housing a
SET dcp_occ_prop = b.dcpclassificationnew
FROM housing_input_lookup_occupancy b
WHERE a.dob_occ_prop = b.doboccupancycode2008
	AND (right(status_a,4))::numeric >= 2008;
-- pre 2008
UPDATE housing a
SET dcp_occ_prop = b.dcpclassificationnew
FROM housing_input_lookup_occupancy b
WHERE a.dob_occ_prop = b.doboccupancycode1968
	AND (right(status_a,4))::numeric < 2008;
-- no date filter 2008
UPDATE housing a
SET dcp_occ_prop = b.dcpclassificationnew
FROM housing_input_lookup_occupancy b
WHERE a.dob_occ_prop = b.doboccupancycode2008;
-- no date filter 1968
UPDATE housing a
SET dcp_occ_prop = b.dcpclassificationnew
FROM housing_input_lookup_occupancy b
WHERE a.dob_occ_prop = b.doboccupancycode1968;

-- category
-- set to Residential where exiting or proposed occupany is Residential
UPDATE housing
SET dcp_occ_category = 'Residential'
WHERE dcp_occ_init LIKE '%Residential%' OR dcp_occ_prop LIKE '%Residential%';

-- otherwise set to other
UPDATE housing
SET dcp_occ_category = 'Other'
WHERE dcp_occ_category IS NULL;