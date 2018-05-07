SELECT DISTINCT dob_occ_init, COUNT(*) FROM housing WHERE dcp_occ_init IS NULL GROUP BY dob_occ_init;

SELECT DISTINCT dob_occ_prop, COUNT(*) FROM housing WHERE dcp_occ_prop IS NULL GROUP BY dob_occ_prop;