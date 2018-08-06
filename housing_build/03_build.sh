#!/bin/bash

# make sure we are at the top of the git directory
REPOLOC="$(git rev-parse --show-toplevel)"
cd $REPOLOC

# load config
DBNAME=$(cat $REPOLOC/housing.config.json | jq -r '.DBNAME')
DBUSER=$(cat $REPOLOC/housing.config.json | jq -r '.DBUSER')

start=$(date +'%T')
echo "Starting to build Housing DB"

# create the table
echo 'Creating base Housing DB table'
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/create.sql
# populate job application data
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/jobnumber.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/clean.sql

# populate other fields from misc sources
echo 'Adding on DCP data attributes'
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/bbl.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/address.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/dcpdevcategory.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/dcpoccupancy.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/dcpstatus.sql
echo 'Adding on DCP researched attributes'
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/dcpdataattributes.sql

echo 'Calculating data attributes'
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/statusq.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/statusyear.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/unitsintnb.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/unitspropdm.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/unitsnet.sql

# add on CofO data attributes
echo 'Adding on CofO data attributes'
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/cofos.sql

psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/cofosfillexisting.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/cofosincrem.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/cofosnet.sql

psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/unitsnetcomplete.sql


echo 'Running DCP data qulaity checks'
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/qc_outliers.sql

echo 'Populating DCP data flags'
# psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/dcpdataattributes.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/duplicates.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/outliers.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/mixeduse.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/inactive.sql

echo 'Geocoding geoms...'
source activate py2
python $REPOLOC/housing_build/python/geocode_address.py
source deactivate

echo 'Adding DCP geoms...'
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/dcpgeoms.sql

echo 'Calculating spatial data attributes...'
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/coords.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/spatialjoins.sql







