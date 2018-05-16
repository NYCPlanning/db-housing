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

# connect to postgres db
engine = sql.create_engine('postgresql://{}@localhost:5432/{}'.format(DBUSER, DBNAME))

# load necessary environment variables
# set variables with following command: export SECRET_KEY="somesecretvalue"
app_id = os.environ['GEOCLIENT_APP_ID']
app_key = os.environ['GEOCLIENT_APP_KEY']

# read in housing table
housing = pd.read_sql_query('SELECT DISTINCT address_house, address_street, boro FROM housing WHERE address_house IS NOT NULL AND address_street IS NOT NULL AND address IS NOT NULL AND boro IS NOT NULL AND geom IS NULL;', engine)

# replace single quotes with doubled single quotes for psql compatibility 
housing['address_house'] = [i.replace("'", "''") for i in housing['address_house']]
housing['address_street'] = [i.replace("'", "''") for i in housing['address_street']]


# get the geo data
g = Geoclient(app_id, app_key)

# address_borough from the github page. not sure why it wasn't in module
def address_borough(self, houseNumber, street, borough):
    """
    Like the above address function, except it uses "zip code" instead of borough

    :param houseNumber:
            The house number to look up.
    :param street:
            The name of the street to look up
    :param zip:
            The zip code of the address to look up.

    :returns: A dict with blockface-level, property-level, and political
            information.

    """
    return self._request(u'address', houseNumber=houseNumber, street=street, borough=borough)

# bound it to the class
Geoclient.address_borough = address_borough

def get_loc(num, street, borough):
    geo = g.address_borough(num, street, borough)
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
    if locs['bin'][i] != 'none': 
        upd = "UPDATE housing a SET geom = ST_Centroid(b.geom), x_geomsource = 'geoclient' FROM doitt_buildingfootprints b WHERE a.address_house = '"+ housing['address_house'][i] + "' AND a.address_street = '"+ housing['address_street'][i] + "' AND b.bin = '"+ locs['bin'][i] + "';"
        engine.execute(upd)
    elif (locs['lat'][i] != 'none') & (locs['lon'][i] != 'none'):
        upd = "UPDATE housing a SET geom = ST_SetSRID(ST_MakePoint(" + str(locs['lon'][i]) + ", " + str(locs['lat'][i]) + "), 4326), x_geomsource = 'geoclient' WHERE address_house = '" + housing['address_house'][i] + "' AND a.address_street = '"+ housing['address_street'][i] + "';"
        engine.execute(upd)


# not deleting because if I ever figure it out this is probably a better way of doing this... 
#md = sql.MetaData(engine)
#table = sql.Table('sca', md, autoload=True)
#upd = table.update(values={
