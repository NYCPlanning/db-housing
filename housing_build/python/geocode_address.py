import pandas as pd
import subprocess
import os
import sqlalchemy as sql
import json
from nyc_geoclient import Geoclient

# make sure we are at the top of the repo
wd = subprocess.check_output('git rev-parse --show-toplevel', shell = True)
os.chdir(wd[:-1]) #-1 removes \n

# load config file
with open('housing.config.json') as conf:
    config = json.load(conf)

DBNAME = config['DBNAME']
DBUSER = config['DBUSER']
# load necessary environment variables
# set variables with following command: export SECRET_KEY="somesecretvalue"
app_id = config['GEOCLIENT_APP_ID']
app_key = config['GEOCLIENT_APP_KEY']

# connect to postgres db
engine = sql.create_engine('postgresql://{}@localhost:5432/{}'.format(DBUSER, DBNAME))

# read in housing table
housing = pd.read_sql_query('SELECT job_number, address_house, address_street, boro FROM housing WHERE address_house IS NOT NULL AND address_street IS NOT NULL AND address IS NOT NULL AND boro IS NOT NULL AND geom IS NULL LIMIT 2500;', engine)

# replace single quotes with doubled single quotes for psql compatibility 
housing['address_house'] = [i.replace("'", "''") for i in housing['address_house']]
housing['address_street'] = [i.replace("'", "''") for i in housing['address_street']]


# get the geo data
g = Geoclient(app_id, app_key)

def get_loc(num, street, borough):
    geo = g.address(num, street, borough)
    try:
        b_in = geo['buildingIdentificationNumber']
    except:
        b_in = 'none'
    try:
        lat = geo['latitude']
    except:
        lat = 'none'
    try:
        lon = geo['longitude']
    except:
        lon = 'none'
    loc = pd.DataFrame({'bin' : [b_in],
                        'lat' : [lat],
                        'lon' : [lon]})
    return(loc)

locs = pd.DataFrame()
for i in range(len(housing)):
    new = get_loc(housing['address_house'][i],
                  housing['address_street'][i],
                  housing['boro'][i]
    )
    locs = pd.concat((locs, new))
locs.reset_index(inplace = True)

# update housing geom based on bin or lat and long
for i in range(len(housing)):
    if (locs['lat'][i] != 'none') & (locs['lon'][i] != 'none'):
        upd = "UPDATE housing a SET geom = ST_SetSRID(ST_MakePoint(" + str(locs['lon'][i]) + ", " + str(locs['lat'][i]) + "), 4326), x_geomsource = 'geoclient' WHERE a.job_number = '" + housing['job_number'][i] + "';"
    elif locs['lat'][i] == 'none': 
        upd = "UPDATE housing a SET geom = NULL WHERE a.job_number = '" + housing['job_number'][i] + "';"
    engine.execute(upd)


# not deleting because if I ever figure it out this is probably a better way of doing this... 
#md = sql.MetaData(engine)
#table = sql.Table('sca', md, autoload=True)
#upd = table.update(values={
