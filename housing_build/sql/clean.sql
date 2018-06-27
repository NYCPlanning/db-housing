-- make units null when it doesn't contain only numbers
UPDATE housing a
SET units_prop = NULL 
WHERE a.units_prop ~ '[^0-9]';

-- removing leading . in occupancy code value
UPDATE housing
SET dob_occ_init = split_part(dob_occ_init, '.', 2)
WHERE dob_occ_init LIKE '.%';

UPDATE housing
SET dob_occ_prop = split_part(dob_occ_prop, '.', 2)
WHERE dob_occ_prop LIKE '.%';