-- Set occ_init = 'Garage/Miscellaneous' AND occ_prop = 'Garage/Miscellaneous'
-- Where job_type is Demolition or Alteration
-- AND address contains REAR or where job_description contains GARAGE 

UPDATE housing
SET occ_init = 'Garage/Miscellaneous' AND occ_prop = 'Garage/Miscellaneous'
WHERE (dob_type = 'DM' OR dob_type = 'A1')
AND (upper(job_description) LIKE '%GARAGE%' OR upper(address) LIKE '%REAR%');