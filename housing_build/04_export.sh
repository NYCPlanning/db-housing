#!/bin/bash

# make sure we are at the top of the git directory
REPOLOC="$(git rev-parse --show-toplevel)"
cd $REPOLOC

# load config
DBNAME=$(cat $REPOLOC/housing.config.json | jq -r '.DBNAME')
DBUSER=$(cat $REPOLOC/housing.config.json | jq -r '.DBUSER')

# eventually these should copy directly from psql to carto
# for now, write to files which can by copied

# points
pgsql2shp -u $DBUSER -f capitalprojects_build/output/cpdb_dcpattributes_pts $DBNAME "SELECT * FROM housing AND ST_GeometryType(geom)='ST_Point'"

# Output individual helper tables
# cpdb_commitments
psql -U $DBUSER -d $DBNAME -c "COPY( SELECT * FROM housing) TO '$REPOLOC/housing_build/output/hdb_housingpermits.csv' DELIMITER ',' CSV HEADER;"
