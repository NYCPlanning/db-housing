-- calculate the incremental unit changes using data derived from dob_cofos
UPDATE housing 
	SET
		unit_change_2017 = u_2017_existtotal::numeric - u_2016_existtotal::numeric,
		unit_change_2016 = u_2016_existtotal::numeric - u_2015_existtotal::numeric,
		unit_change_2015 = u_2015_existtotal::numeric - u_2014_existtotal::numeric,
		unit_change_2014 = u_2014_existtotal::numeric - u_2013_existtotal::numeric,
		unit_change_2013 = u_2013_existtotal::numeric - u_2012_existtotal::numeric,
		unit_change_2012 = u_2012_existtotal::numeric - u_2011_existtotal::numeric,
		unit_change_2011 = u_2011_existtotal::numeric - u_2010post_existtotal::numeric,
		unit_change_postapr2010 = u_2010post_existtotal::numeric - u_2010pre_existtotal::numeric,
		unit_change_preapr2010 = u_2010pre_existtotal::numeric - u_2009_existtotal::numeric,
		unit_change_2009 = u_2009_existtotal::numeric - u_2008_existtotal::numeric,
		unit_change_2008 = u_2008_existtotal::numeric - u_2007_existtotal::numeric,
		unit_change_2007 = u_2007_existtotal::numeric - u_init::numeric
;