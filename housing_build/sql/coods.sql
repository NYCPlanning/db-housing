-- Set the Lat/Long and X/Y 
UPDATE housing
SET
	latitude = ST_Y(geom),
	longitude = ST_X(geom),
	ycoord = ST_Y(ST_Transform(geom, 2263)),
	xcoord = ST_X(ST_Transform(geom, 2263))
	WHERE geom IS NOT NULL;
-- If there is no geometry but there is a lat / long then create the geometry
UPDATE housing
SET geom = ST_SetSRID(ST_MakePoint(longitude::double precision, latitude::double precision), 4326)
WHERE geom IS NULL AND longitude IS NOT NULL;