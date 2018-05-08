SELECT DISTINCT dob_occ_init, COUNT(*) FROM housing WHERE dcp_occ_init IS NULL GROUP BY dob_occ_init;

SELECT DISTINCT dob_occ_prop, COUNT(*) FROM housing WHERE dcp_occ_prop IS NULL GROUP BY dob_occ_prop;

WITH dupjobnum AS (SELECT DISTINCT jobnumber FROM dob_jobapplications GROUP BY jobnumber HAVING COUNT(*)>1),
nondup AS (SELECT DISTINCT jobnumber FROM dob_jobapplications GROUP BY jobnumber, borough HAVING COUNT(*)>1) 

COPY(
SELECT * FROM dob_jobapplications 
WHERE jobnumber IN (SELECT jobnumber FROM dob_jobapplications WHERE jobdocnumber = '01' GROUP BY jobnumber HAVING COUNT(*)>1)
AND jobdocnumber = '01'
ORDER BY jobnumber
)TO '/prod/db-housing/housing_build/output/qc_duplicatejobnums.csv' DELIMITER ',' CSV HEADER;

SELECT DISTINCT jobnum, numofdwellingunits FROM dob_cofos 
WHERE jobnum IN (SELECT jobnum FROM dob_cofos GROUP BY jobnum HAVING COUNT(*)>3)
	AND jobnum IN (SELECT dob_job_number FROM housing WHERE u_2007_existtotal <> u_2017_existtotal AND u_2007_existtotal IS NOT NULL AND u_2017_existtotal IS NOT NULL)
AND occupancyclass = 'RES' 
ORDER BY jobnum;

COPY(
SELECT * FROM dob_cofos
WHERE jobnum = '102494249'
OR jobnum = '102549299'
OR jobnum = '102597691'
OR jobnum = '102685284'
OR jobnum = '102697841'
ORDER BY jobnum, effectivedate::date
)TO '/prod/db-housing/housing_build/output/qc_examplecofochanges.csv' DELIMITER ',' CSV HEADER;
