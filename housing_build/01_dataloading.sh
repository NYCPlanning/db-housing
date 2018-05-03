#!/bin/bash

################################################################################################
### OBTAINING DATA
################################################################################################
### NOTE: This script requires you to setup the DATABASE_URL environment variable.
### Directions are in the README.md.

## Load all datasets from sources using the civic data loader
## https://github.com/NYCPlanning/data-loading-scripts

cd '/prod/data-loading-scripts'

## Open_datasets - PULLING FROM OPEN DATA
echo 'Loading open source datasets...'
node loader.js install dob_jobapplications
node loader.js install dob_permitissuance

## Other_datasets - PULLING FROM GitHub repo
echo 'Loading datasets from GitHub repo...'
node loader.js install housing_input_lookup_occupancy
node loader.js install housing_input_lookup_status
node loader.js install dob_cofos