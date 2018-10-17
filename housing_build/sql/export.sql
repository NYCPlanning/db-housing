-- create a tempory table from the housing table where development happened
-- with the desired fields in the desired order named approriatly
-- copy that table to the output folder and drop the table
-- update the cutoff dates
	-- Cutoff date for 1st quarter would be March 31st.
	-- Cutoff date for 1st quarter would be June 30th.
	-- Cutoff date for 3rd quarter is Sept 30th.
	-- Cutoff date for 4th quarter is Dec 31st.
DROP TABLE IF EXISTS housing_export;
CREATE TABLE housing_export AS 
	(SELECT job_number,job_type,occ_init,occ_prop,dcp_occ_category,dcp_status,dob_status,status_date,status_a,status_a_year,status_d,status_p,status_q,status_q_year,status_r,status_x,stories_init,stories_prop,zoningsft_init,zoningsft_prop,units_init,units_prop,units_net,units_net_complete,units_net_incomplete,earliest_effectivedate,latest_effectivedate,latest_certtype,latest_cofo,unit_change_2007,unit_change_2008,unit_change_2009,unit_change_preapr2010,unit_change_postapr2010,unit_change_2011,unit_change_2012,unit_change_2013,unit_change_2014,unit_change_2015,unit_change_2016,unit_change_2017,unit_change_2018,geo_cd,geo_ntacode,geo_ntaname,geo_censusblock,geo_csd,f_pfirms2015_100yr as pfirms2015_100yr,x_dup_flag,x_dup_id,x_inactive,x_outlier,address,latitude,longitude,ycoord,xcoord,bin,bbl,boro,geom 
	FROM housing
	WHERE (earliest_effectivedate::date >= '2010-01-01' AND earliest_effectivedate::date <=  '2018-06-30')
	OR (earliest_effectivedate IS NULL AND status_q::date >= '2010-01-01' AND status_q::date <=  '2018-06-30')
	OR (earliest_effectivedate IS NULL AND status_q IS NULL AND status_a::date >= '2010-01-01' AND status_a::date <=  '2018-06-30')
	);
-- export
--all records
\copy (SELECT * FROM housing_export) TO '/prod/db-housing/housing_build/output/devdb_developments.csv' DELIMITER ',' CSV HEADER;
-- only points
\copy (SELECT * FROM housing_export WHERE ST_GeometryType(geom)='ST_Point') TO '/prod/db-housing/housing_build/output/devdb_developments_pts' DELIMITER ',' CSV HEADER;
-- only housing records
\copy (SELECT * FROM housing_export WHERE dcp_occ_category = 'Residential' OR occ_prop LIKE '%Residential%' OR occ_init LIKE '%Residential%' OR occ_prop LIKE '%Assisted%Living%' OR occ_init LIKE '%Assisted%Living%') TO '/prod/db-housing/housing_build/output/devdb_housing.csv' DELIMITER ',' CSV HEADER;
-- only housing points
\copy (SELECT * FROM housing_export WHERE ST_GeometryType(geom)='ST_Point' AND (dcp_occ_category = 'Residential' OR occ_prop LIKE '%Residential%' OR occ_init LIKE '%Residential%' OR occ_prop LIKE '%Assisted%Living%' OR occ_init LIKE '%Assisted%Living%')) TO '/prod/db-housing/housing_build/output/devdb_housing.csv' DELIMITER ',' CSV HEADER;

DROP TABLE housing_export;