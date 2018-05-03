-- status q
-- https://data.cityofnewyork.us/Housing-Development/DOB-Permit-Issuance/ipu4-2q9a/data
-- min issuance date
WITH subset as (
	SELECT jobnum, issuancedate::date
	FROM dob_permitissuanceDownloading
	WHERE jobdocnum = '01' 
	AND (jobtype = 'A1' OR jobtype = 'DM' OR jobtype = 'NB') 
	AND (proposedoccupancy LIKE '%R%' OR existingoccupancy LIKE '%R%'))