-- populate the status q field
-- date of the oldest issuance date for that job number in dob_permitissuance
WITH minissuacedate as (
	SELECT jobnum, min(issuancedate::date) as minissuancedate
	FROM dob_permitissuance
	WHERE jobdocnum = '01' 
	AND (jobtype = 'A1' OR jobtype = 'DM' OR jobtype = 'NB') 
	GROUP BY jobnum
)

UPDATE housing a
SET status_q = b.minissuancedate
FROM minissuacedate b
WHERE a.dob_job_number = b.jobnum;