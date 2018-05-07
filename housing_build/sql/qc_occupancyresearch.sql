-- pull out records with a specific occupancy code for manual research
-- occupancy codes: A-3 (ASSEMBLY: OTHER), H-2 (HIGH HAZARD: ACCELERATED BURNING)
COPY(
	SELECT * 
	FROM housing
	WHERE dob_occ_init = 'A-3'
		OR dob_occ_prop = 'A-3'
		OR dob_occ_init = 'H-2'
		OR dob_occ_prop = 'H-2'
)TO '/prod/db-housing/housing_build/output/qc_occupancyresearch.csv' DELIMITER ',' CSV HEADER;