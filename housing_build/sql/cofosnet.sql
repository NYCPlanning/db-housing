-- calculate the net number of units using data derived from dob_cofos
UPDATE housing 
	SET
		u_2017_netcomplete = (CASE WHEN u_init IS NOT NULL THEN u_2017_existtotal::numeric - u_init::numeric END),
		u_2016_netcomplete = (CASE WHEN u_init IS NOT NULL THEN u_2016_existtotal::numeric - u_init::numeric END),
		u_2015_netcomplete = (CASE WHEN u_init IS NOT NULL THEN u_2015_existtotal::numeric - u_init::numeric END),
		u_2014_netcomplete = (CASE WHEN u_init IS NOT NULL THEN u_2014_existtotal::numeric - u_init::numeric END),
		u_2013_netcomplete = (CASE WHEN u_init IS NOT NULL THEN u_2013_existtotal::numeric - u_init::numeric END),
		u_2012_netcomplete = (CASE WHEN u_init IS NOT NULL THEN u_2012_existtotal::numeric - u_init::numeric END),
		u_2011_netcomplete = (CASE WHEN u_init IS NOT NULL THEN u_2011_existtotal::numeric - u_init::numeric END),
		u_2010post_netcomplete = (CASE WHEN u_init IS NOT NULL THEN u_2010post_existtotal::numeric - u_init::numeric END),
		u_2010pre_netcomplete = (CASE WHEN u_init IS NOT NULL THEN u_2010pre_existtotal::numeric - u_init::numeric END),		
		u_2009_netcomplete = (CASE WHEN u_init IS NOT NULL THEN u_2009_existtotal::numeric - u_init::numeric END),
		u_2008_netcomplete = (CASE WHEN u_init IS NOT NULL THEN u_2008_existtotal::numeric - u_init::numeric END),
		u_2007_netcomplete = (CASE WHEN u_init IS NOT NULL THEN u_2007_existtotal::numeric - u_init::numeric END)
;