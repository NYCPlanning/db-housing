-- calculate the incremental unit changes using data derived from dob_cofos
UPDATE housing 
	SET
		u_2017_increm = u_2017_existtotal::numeric - u_2016_existtotal::numeric,
		u_2016_increm = u_2016_existtotal::numeric - u_2015_existtotal::numeric,
		u_2015_increm = u_2015_existtotal::numeric - u_2014_existtotal::numeric,
		u_2014_increm = u_2014_existtotal::numeric - u_2013_existtotal::numeric,
		u_2013_increm = u_2013_existtotal::numeric - u_2012_existtotal::numeric,
		u_2012_increm = u_2012_existtotal::numeric - u_2011_existtotal::numeric,
		u_2011_increm = u_2011_existtotal::numeric - u_2010post_existtotal::numeric,
		u_2010post_increm = u_2010post_existtotal::numeric - u_2010pre_existtotal::numeric,
		u_2010pre_increm = u_2010pre_existtotal::numeric - u_2009_existtotal::numeric,
		u_2009_increm = u_2009_existtotal::numeric - u_2008_existtotal::numeric,
		u_2008_increm = u_2008_existtotal::numeric - u_2007_existtotal::numeric,
		u_2007_increm = u_2007_existtotal::numeric - u_init::numeric
;