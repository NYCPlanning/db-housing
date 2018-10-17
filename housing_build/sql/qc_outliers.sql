-- Generate list of potential outliers for removal
-- criteria
-- 1) top 20 and bottom 20 for units_net
-- 2) top 20 for units_init and top 20 for units_prop
-- 3) units_net_complete is 50+ units greater than units proposed (NBs only)
-- 2) job_type= DM and units_init > 19
-- 3) job_type= A1 and units_net < -50
-- 4) job_type= A1, TOP 20 for units_net
-- 5) job_type= A1, TOP 10 for u_prop
-- 6) job_type= NB and units_init NOT 0
-- 7) job_description (field does not currently exist) contains both '%RESID%' AND '%HOTEL%'
-- 8) unit_change_2018 is negative (need to manually update the year)
DROP TABLE IF EXISTS qc_outliers;
CREATE TABLE qc_outliers
(
	job_number text,
	address text,
	address_house text,
	address_street text,
	latitude text,
	longitude text,
	ycoord text,
	xcoord text,
	bin text,
	bbl text,
	boro text,
	block text,
	lot text,
	dob_type text,
	job_type text,
	job_description text,
	dcp_occ_category text,
	occ_init text,
	occ_prop text,
	dob_occ_init text,
	dob_occ_prop text,
	dcp_status text,
	dob_status text,
	status_date text,
	status_a text,
	status_a_year text,
	status_d text,
	status_p text,
	status_q text,
	status_q_year text,
	status_r text,
	status_x text,
	dob_bldg_type text,
	stories_init text,
	stories_prop text,
	zoningsft_init text,
	zoningsft_prop text,
	units_init text,
	units_prop text,
	units_net text,
	units_net_complete text,
	units_net_incomplete text,
	earliest_effectivedate text,
	latest_effectivedate text,
	latest_certtype text,
	latest_cofo text,
	u_2007_existtotal text,
	u_2008_existtotal text,
	u_2009_existtotal text,
	u_2010pre_existtotal text,
	u_2010post_existtotal text,
	u_2011_existtotal text,
	u_2012_existtotal text,
	u_2013_existtotal text,
	u_2014_existtotal text,
	u_2015_existtotal text,
	u_2016_existtotal text,
	u_2017_existtotal text,
	u_2018_existtotal text,
	unit_change_2007 text,
	unit_change_2008 text,
	unit_change_2009 text,
	unit_change_preapr2010 text,
	unit_change_postapr2010 text,
	unit_change_2011 text,
	unit_change_2012 text,
	unit_change_2013 text,
	unit_change_2014 text,
	unit_change_2015 text,
	unit_change_2016 text,
	unit_change_2017 text,
	unit_change_2018 text,
	u_2007_netcomplete text,
	u_2008_netcomplete text,
	u_2009_netcomplete text,
	u_2010pre_netcomplete text,
	u_2010post_netcomplete text,
	u_2011_netcomplete text,
	u_2012_netcomplete text,
	u_2013_netcomplete text,
	u_2014_netcomplete text,
	u_2015_netcomplete text,
	u_2016_netcomplete text,
	u_2017_netcomplete text,
	u_2018_netcomplete text,
	geo_cd text,
	geo_ntacode text,
	geo_ntaname text,
	geo_censusblock text,
	geo_csd text,
 	f_pfirms2015_100yr text,
 	x_dcpedited text,
 	x_mixeduse text,
	x_dup_flag text,
	x_dup_id text,
	x_dup_maxstatusdate text,
	x_dup_maxcofodate text,
	x_geomsource text,
	x_occsource text,
	x_inactive text,
	x_outlier text,
	x_withdrawal text,
	geom text,
	flag text,
	outlier text
);

COPY qc_outliers FROM '/prod/db-housing/housing_build/output/qc_outliers.csv' DELIMITER ',' CSV HEADER;
-- add outlier records to old table
CREATE TABLE IF NOT EXISTS qc_outliersacrhived (
job_number text, flag text, outlier text);
INSERT INTO qc_outliersacrhived (
job_number, flag, outlier)
SELECT DISTINCT job_number, flag, outlier FROM qc_outliers;

DROP TABLE IF EXISTS qc_outliers;
CREATE TABLE qc_outliers AS (
(SELECT *, 
	'units_net_complete is 50+ units greater than units proposed (NBs only)' as flag,
	 NULL as outlier
FROM housing
WHERE
	dob_type = 'NB'
	AND (units_net_complete::integer - units_prop::integer) >= 50)
UNION
(SELECT *,
	'job_type= DM and units_init > 19' as flag,
	NULL as outlier 
FROM housing
WHERE
	dob_type = 'DM'
	AND units_init::integer >= 20)
UNION
(SELECT *,
	'job_type= A1 and units_net < -50' as flag,
	NULL as outlier   
FROM housing
WHERE
	dob_type = 'A1'
	AND units_net::integer <= -50)
UNION
(SELECT *,
	'top 20 units_net A1' as flag,
	NULL as outlier 
FROM housing
WHERE
	dob_type = 'A1'
	AND units_net IS NOT NULL
	AND (dcp_status <> 'Withdrawn' OR dcp_status IS NULL)
	AND x_dup_flag IS NULL
ORDER BY
	units_net DESC
LIMIT 20)
UNION
(SELECT *,
	'top 10 units_prop A1' as flag,
	NULL as outlier 
FROM housing
WHERE
	dob_type = 'A1'
	AND units_prop IS NOT NULL
	AND (dcp_status <> 'Withdrawn' OR dcp_status IS NULL)
	AND x_dup_flag IS NULL
ORDER BY
	units_prop DESC
LIMIT 10)
UNION
(SELECT *,
	'job_type= NB and units_init NOT 0' as flag,
	NULL as outlier
FROM housing
WHERE
	dob_type = 'NB'
	AND units_init::integer <> 0)
UNION
(SELECT *,
	'job_description contains both %RESID% AND %HOTEL%' as flag,
	NULL as outlier
FROM housing
WHERE
	upper(job_description) LIKE '%RESID%HOTEL%'
	OR upper(job_description) LIKE '%HOTEL%RESID%')
UNION
(SELECT *,
	'unit_change_2018 is negative' as flag,
	NULL as outlier    
FROM housing
WHERE
	unit_change_2018::numeric < 0)
);

\copy (SELECT * FROM qc_outliers WHERE job_number NOT IN (SELECT DISTINCT job_number FROM qc_outliersacrhived WHERE outlier = 'N' OR outlier = 'C')) TO '/prod/db-housing/housing_build/output/qc_outliers.csv' DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS qc_outliers;