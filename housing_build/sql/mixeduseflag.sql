UPDATE housing
SET x_mixeduse = TRUE
WHERE job_description LIKE '%MIX%'
	OR (upper(job_description) LIKE '%RES%' AND upper(job_description) LIKE '%COMM%')
  	OR (upper(job_description) LIKE '%RES%' AND upper(job_description) LIKE '%HOTEL%')
  	OR (upper(job_description) LIKE '%RES%' AND upper(job_description) LIKE '%RETAIL%');