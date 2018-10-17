-- Set the Lat/Long and X/Y 
UPDATE housing
SET
	latitude = ST_Y(geom),
	longitude = ST_X(geom),
	ycoord = ST_Y(ST_Transform(geom, 2263)),
	xcoord = ST_X(ST_Transform(geom, 2263))
	WHERE geom IS NOT NULL;