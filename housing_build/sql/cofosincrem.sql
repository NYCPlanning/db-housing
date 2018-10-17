-- calculate the incremental unit changes using data derived from dob_cofos
UPDATE housing 
	SET
		unit_change_2018 = u_2018_existtotal::numeric - u_2017_existtotal::numeric,
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
		unit_change_2007 = u_2007_existtotal::numeric - units_init::numeric
;

-- for demolitations calculate the incremental unit changes using the status_q_year and data derived from dob_cofos
UPDATE housing 
	SET unit_change_2018 = units_net
	WHERE status_q_year = '2018'
	AND dob_type = 'DM';
UPDATE housing 
	SET unit_change_2017 = units_net
	WHERE status_q_year = '2017'
	AND dob_type = 'DM';
UPDATE housing 
	SET unit_change_2016 = units_net
	WHERE status_q_year = '2016'
	AND dob_type = 'DM';
UPDATE housing 
	SET unit_change_2015 = units_net
	WHERE status_q_year = '2015'
	AND dob_type = 'DM';
UPDATE housing 
	SET unit_change_2014 = units_net
	WHERE status_q_year = '2014'
	AND dob_type = 'DM';
UPDATE housing 
	SET unit_change_2013 = units_net
	WHERE status_q_year = '2013'
	AND dob_type = 'DM';
UPDATE housing 
	SET unit_change_2012 = units_net
	WHERE status_q_year = '2012'
	AND dob_type = 'DM';
UPDATE housing 
	SET unit_change_2011 = units_net
	WHERE status_q_year = '2011'
	AND dob_type = 'DM';
UPDATE housing 
	SET unit_change_postapr2010 = units_net
	WHERE status_q::date < '2011-01-01' AND status_q::date >= '2010-04-01'
	AND dob_type = 'DM';
UPDATE housing 
	SET unit_change_preapr2010 = units_net
	WHERE status_q::date < '2010-04-01' AND status_q::date >= '2010-01-01'
	AND dob_type = 'DM';
UPDATE housing 
	SET unit_change_2009 = units_net
	WHERE status_q_year = '2009'
	AND dob_type = 'DM';
UPDATE housing 
	SET unit_change_2008 = units_net
	WHERE status_q_year = '2008'
	AND dob_type = 'DM';
UPDATE housing 
	SET unit_change_2007 = units_net
	WHERE status_q_year = '2007'
	AND dob_type = 'DM';