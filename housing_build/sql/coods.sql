-- Set the Lat/Long and X/Y 
UPDATE housing
SET
	latitude = ST_Y(the_geom),
	longitude = ST_X(the_geom),
	ycoord = ST_Y(ST_Transform(the_geom, 2263)),
	xcoord = ST_X(ST_Transform(the_geom, 2263))
	WHERE geom IS NOT NULL;