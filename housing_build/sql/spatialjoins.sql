-- adding on ids from spatial joins from boundary datasets
-- community district
UPDATE housing a
	SET geo_cd = b.borocd::text
	FROM dcp_cdboundaries as b
	WHERE ST_Intersects(a.geom,b.geom);
-- nta
UPDATE housing a
	SET geo_ntacode = b.ntacode,
		geo_ntaname = b.ntaname
	FROM dcp_ntaboundaries as b
	WHERE ST_Intersects(a.geom,b.geom); 
-- cenus block
UPDATE housing a
	SET geo_censusblock = b.bctcb2010
	FROM dcp_censusblocks as b
	WHERE ST_Within(a.geom,b.geom); 
-- school districts
UPDATE housing a
	SET geo_csd = b.schooldist::text	
	FROM dcp_school_districts as b
	WHERE ST_Intersects(a.geom,b.geom);
-- preliminary flood zone
UPDATE housing a
	SET f_pfirms2015_100yr = b.fld_zone
	FROM fema_pfirms2015_100yr as b
	WHERE ST_Intersects(a.geom,b.geom);