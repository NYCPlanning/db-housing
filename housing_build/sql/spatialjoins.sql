-- adding on ids from spatial joins from boundary datasets
-- community district
UPDATE housing
	SET geo_cd = b.borocd::text
	FROM dcp_cdboundaries as b
	WHERE ST_Intersects(a.the_geom,b.the_geom);
-- nta
UPDATE housing
	SET geo_ntacode = b.ntacode,
		geo_ntaname = b.ntaname
	FROM dcp_ntaboundaries as b
	WHERE ST_Intersects(a.the_geom,b.the_geom); 
-- cenus block
UPDATE housing
	SET geo_censusblock = b.bctcb2010
	FROM nyc_census_blocks_2010_wi as b
	WHERE ST_Within(a.the_geom,b.the_geom); 
-- school districts
UPDATE housing
	SET geo_csd = b.schooldist::text,
		geo_subdistrict = b.distzone
	FROM doe_schoolsubdistricts as b
	WHERE ST_Intersects(a.the_geom,b.the_geom);
-- preliminary flood zone
UPDATE housing
	SET f_pfirms2015_100yr = b.fld_zone
	FROM fema_pfirms_100yr_2015 as b
	WHERE ST_Intersects(a.the_geom,b.the_geom);