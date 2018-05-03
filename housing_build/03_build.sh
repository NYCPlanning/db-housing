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


# add on CofO data attributes
echo 'Adding on CofO data attributes'

# populate other fields from misc sources
echo 'Adding on DCP data attributes'
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/bbl.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/address.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/dcpdevcategory.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/dcpoccupancy.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/dcpstatus.sql

psql -U $DBUSER -d $DBNAME -f $REPOLOC/housing_build/sql/statusq.sql