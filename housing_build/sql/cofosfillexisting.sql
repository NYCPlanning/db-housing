-- Calculate the total existing units between CofOs and before first CofO. 
-- Looks for most recent CofO value and fills that in. 
-- If a CofO value doesn't exist, fills in the initial number of exisiting units from the job application.
UPDATE housing b
SET u_2018_existtotal = 
			(CASE 
				WHEN b.u_2018_existtotal IS NULL AND dcp_status <> 'Complete (demolition)'
				THEN COALESCE(b.u_2017_existtotal, b.u_2016_existtotal, b.u_2015_existtotal, b.u_2014_existtotal, b.u_2013_existtotal, b.u_2012_existtotal, b.u_2011_existtotal, b.u_2010post_existtotal, b.u_2010pre_existtotal, b.u_2009_existtotal, b.u_2008_existtotal, b.u_2007_existtotal, units_init)
				WHEN b.u_2018_existtotal IS NOT NULL THEN b.u_2018_existtotal
			END),
		u_2017_existtotal = 
			(CASE 
				WHEN b.u_2017_existtotal IS NULL AND dcp_status <> 'Complete (demolition)'
				THEN COALESCE(b.u_2016_existtotal, b.u_2015_existtotal, b.u_2014_existtotal, b.u_2013_existtotal, b.u_2012_existtotal, b.u_2011_existtotal, b.u_2010post_existtotal, b.u_2010pre_existtotal, b.u_2009_existtotal, b.u_2008_existtotal, b.u_2007_existtotal, units_init)
				WHEN b.u_2017_existtotal IS NOT NULL THEN b.u_2017_existtotal
			END),
		u_2016_existtotal = 
			(CASE 
				WHEN b.u_2016_existtotal IS NULL AND dcp_status <> 'Complete (demolition)'
				THEN COALESCE(b.u_2015_existtotal, b.u_2014_existtotal, b.u_2013_existtotal, b.u_2012_existtotal, b.u_2011_existtotal, b.u_2010post_existtotal, b.u_2010pre_existtotal, b.u_2009_existtotal, b.u_2008_existtotal, b.u_2007_existtotal, units_init)
				WHEN b.u_2016_existtotal IS NOT NULL THEN b.u_2016_existtotal
			END),
		u_2015_existtotal = 
			(CASE 
				WHEN b.u_2015_existtotal IS NULL AND dcp_status <> 'Complete (demolition)'
				THEN COALESCE(b.u_2014_existtotal, b.u_2013_existtotal, b.u_2012_existtotal, b.u_2011_existtotal, b.u_2010post_existtotal, b.u_2010pre_existtotal, b.u_2009_existtotal, b.u_2008_existtotal, b.u_2007_existtotal, units_init)
				WHEN b.u_2015_existtotal IS NOT NULL THEN b.u_2015_existtotal
			END),
		u_2014_existtotal = 
			(CASE 
				WHEN b.u_2014_existtotal IS NULL AND dcp_status <> 'Complete (demolition)'
				THEN COALESCE(b.u_2013_existtotal, b.u_2012_existtotal, b.u_2011_existtotal, b.u_2010post_existtotal, b.u_2010pre_existtotal, b.u_2009_existtotal, b.u_2008_existtotal, b.u_2007_existtotal, units_init)
				WHEN b.u_2014_existtotal IS NOT NULL THEN b.u_2014_existtotal
			END),
		u_2013_existtotal = 
			(CASE 
				WHEN b.u_2013_existtotal IS NULL AND dcp_status <> 'Complete (demolition)'
				THEN COALESCE(b.u_2012_existtotal, b.u_2011_existtotal, b.u_2010post_existtotal, b.u_2010pre_existtotal, b.u_2009_existtotal, b.u_2008_existtotal, b.u_2007_existtotal, units_init)
				WHEN b.u_2013_existtotal IS NOT NULL THEN b.u_2013_existtotal
			END),
		u_2012_existtotal = 
			(CASE 
				WHEN b.u_2012_existtotal IS NULL AND dcp_status <> 'Complete (demolition)'
				THEN COALESCE(b.u_2011_existtotal, b.u_2010post_existtotal, b.u_2010pre_existtotal, b.u_2009_existtotal, b.u_2008_existtotal, b.u_2007_existtotal, units_init)
				WHEN b.u_2012_existtotal IS NOT NULL THEN b.u_2012_existtotal
			END),
		u_2011_existtotal = 
			(CASE 
				WHEN b.u_2011_existtotal IS NULL AND dcp_status <> 'Complete (demolition)'
				THEN COALESCE(b.u_2010post_existtotal, b.u_2010pre_existtotal, b.u_2009_existtotal, b.u_2008_existtotal, b.u_2007_existtotal, units_init)
				WHEN b.u_2011_existtotal IS NOT NULL THEN b.u_2011_existtotal 
			END),
		u_2010post_existtotal = 
			(CASE 
				WHEN b.u_2010post_existtotal IS NULL AND dcp_status <> 'Complete (demolition)'
				THEN COALESCE(b.u_2010pre_existtotal, b.u_2009_existtotal, b.u_2008_existtotal, b.u_2007_existtotal, units_init)
				WHEN b.u_2010post_existtotal IS NOT NULL THEN b.u_2010post_existtotal 
			END),
		u_2010pre_existtotal = 
			(CASE 
				WHEN b.u_2010pre_existtotal IS NULL AND dcp_status <> 'Complete (demolition)'
				THEN COALESCE(b.u_2009_existtotal, b.u_2008_existtotal, b.u_2007_existtotal, units_init)
				WHEN b.u_2010pre_existtotal IS NOT NULL THEN b.u_2010pre_existtotal 
			END),
		u_2009_existtotal = 
			(CASE 
				WHEN b.u_2009_existtotal IS NULL AND dcp_status <> 'Complete (demolition)'
				THEN COALESCE(b.u_2008_existtotal, b.u_2007_existtotal, units_init)
				WHEN b.u_2009_existtotal IS NOT NULL THEN b.u_2009_existtotal
			END),
		u_2008_existtotal = 
			(CASE 
				WHEN b.u_2008_existtotal IS NULL AND dcp_status <> 'Complete (demolition)'
				THEN COALESCE(b.u_2007_existtotal, units_init)
				WHEN b.u_2008_existtotal IS NOT NULL THEN b.u_2008_existtotal
			END),
		u_2007_existtotal = 
			(CASE 
				WHEN b.u_2007_existtotal IS NULL AND dcp_status <> 'Complete (demolition)'
				THEN COALESCE(units_init)
				WHEN b.u_2007_existtotal IS NOT NULL THEN b.u_2007_existtotal
			END);

-- Capture demolitions in a given year and proxy for CofO date
UPDATE housing
	SET
		earliest_effectivedate = status_q,
		latest_effectivedate = status_q,
		u_2007_existtotal = 
			(CASE WHEN RIGHT(status_q::text, 4) = '2007' THEN '0' ELSE u_2007_existtotal END),
		u_2008_existtotal = 
			(CASE WHEN RIGHT(status_q::text, 4) = '2008' THEN '0' ELSE u_2008_existtotal END),
		u_2009_existtotal = 
			(CASE WHEN RIGHT(status_q::text, 4) = '2009' THEN '0' ELSE u_2009_existtotal END),
		u_2010pre_existtotal = 
			(CASE WHEN status_q::date < TO_DATE('04/01/2010', 'MM/DD/YYYY') AND status_q::date >= TO_DATE('01/01/2010', 'MM/DD/YYYY') THEN '0' ELSE u_2010pre_existtotal END),
		u_2010post_existtotal = 
			(CASE WHEN status_q::date >= TO_DATE('04/01/2010', 'MM/DD/YYYY') AND status_q::date < TO_DATE('01/01/2011', 'MM/DD/YYYY') THEN '0' ELSE u_2010post_existtotal END),
		u_2011_existtotal = 
			(CASE WHEN RIGHT(status_q::text, 4) = '2011' THEN '0' ELSE u_2011_existtotal END),
		u_2012_existtotal = 
			(CASE WHEN RIGHT(status_q::text, 4) = '2012' THEN '0' ELSE u_2012_existtotal END),
		u_2013_existtotal = 
			(CASE WHEN RIGHT(status_q::text, 4) = '2013' THEN '0' ELSE u_2013_existtotal END),
		u_2014_existtotal = 
			(CASE WHEN RIGHT(status_q::text, 4) = '2014' THEN '0' ELSE u_2014_existtotal END),
		u_2015_existtotal = 
			(CASE WHEN RIGHT(status_q::text, 4) = '2015' THEN '0' ELSE u_2015_existtotal END),
		u_2016_existtotal = 
			(CASE WHEN RIGHT(status_q::text, 4) = '2016' THEN '0' ELSE u_2016_existtotal END),
		u_2017_existtotal = 
			(CASE WHEN RIGHT(status_q::text, 4) = '2017' THEN '0' ELSE u_2017_existtotal END),
		u_2018_existtotal = 
			(CASE WHEN RIGHT(status_q::text, 4) = '2018' THEN '0' ELSE u_2018_existtotal END)
	WHERE dcp_status = 'Complete (demolition)';

UPDATE housing
	SET
		u_2018_existtotal = 
			(CASE
				WHEN u_2018_existtotal IS NULL 
				THEN COALESCE(u_2017_existtotal, u_2016_existtotal, u_2015_existtotal, u_2014_existtotal, u_2013_existtotal, u_2012_existtotal, u_2011_existtotal, u_2010post_existtotal, u_2010pre_existtotal, u_2009_existtotal, u_2008_existtotal, u_2007_existtotal, units_init)
				ELSE u_2018_existtotal
			END),
		u_2017_existtotal = 
			(CASE
				WHEN u_2017_existtotal IS NULL 
				THEN COALESCE(u_2016_existtotal, u_2015_existtotal, u_2014_existtotal, u_2013_existtotal, u_2012_existtotal, u_2011_existtotal, u_2010post_existtotal, u_2010pre_existtotal, u_2009_existtotal, u_2008_existtotal, u_2007_existtotal, units_init)
				ELSE u_2017_existtotal
			END),
		u_2016_existtotal = 
			(CASE
				WHEN u_2016_existtotal IS NULL 
				THEN COALESCE(u_2015_existtotal, u_2014_existtotal, u_2013_existtotal, u_2012_existtotal, u_2011_existtotal, u_2010post_existtotal, u_2010pre_existtotal, u_2009_existtotal, u_2008_existtotal, u_2007_existtotal, units_init)
				ELSE u_2016_existtotal
			END),
		u_2015_existtotal = 
			(CASE
				WHEN u_2015_existtotal IS NULL 
				THEN COALESCE(u_2014_existtotal, u_2013_existtotal, u_2012_existtotal, u_2011_existtotal, u_2010post_existtotal, u_2010pre_existtotal, u_2009_existtotal, u_2008_existtotal, u_2007_existtotal, units_init)
				ELSE u_2015_existtotal
			END),
		u_2014_existtotal = 
			(CASE
				WHEN u_2014_existtotal IS NULL 
				THEN COALESCE(u_2013_existtotal, u_2012_existtotal, u_2011_existtotal, u_2010post_existtotal, u_2010pre_existtotal, u_2009_existtotal, u_2008_existtotal, u_2007_existtotal, units_init)
				ELSE u_2014_existtotal
			END),
		u_2013_existtotal = 
			(CASE
				WHEN u_2013_existtotal IS NULL 
				THEN COALESCE(u_2012_existtotal, u_2011_existtotal, u_2010post_existtotal, u_2010pre_existtotal, u_2009_existtotal, u_2008_existtotal, u_2007_existtotal, units_init)
				ELSE u_2013_existtotal
			END),
		u_2012_existtotal = 
			(CASE
				WHEN u_2012_existtotal IS NULL 
				THEN COALESCE(u_2011_existtotal, u_2010post_existtotal, u_2010pre_existtotal, u_2009_existtotal, u_2008_existtotal, u_2007_existtotal, units_init)
				ELSE u_2012_existtotal
			END),
		u_2011_existtotal = 
			(CASE
				WHEN u_2011_existtotal IS NULL 
				THEN COALESCE(u_2010post_existtotal, u_2010pre_existtotal, u_2009_existtotal, u_2008_existtotal, u_2007_existtotal, units_init)
				ELSE u_2011_existtotal
			END),
		u_2010post_existtotal = 
			(CASE
				WHEN u_2010post_existtotal IS NULL 
				THEN COALESCE(u_2010pre_existtotal, u_2009_existtotal, u_2008_existtotal, u_2007_existtotal, units_init)
				ELSE u_2010post_existtotal
			END),
		u_2010pre_existtotal = 
			(CASE
				WHEN u_2010pre_existtotal IS NULL 
				THEN COALESCE(u_2009_existtotal, u_2008_existtotal, u_2007_existtotal, units_init)
				ELSE u_2010pre_existtotal
			END),
		u_2009_existtotal = 
			(CASE
				WHEN u_2009_existtotal IS NULL 
				THEN COALESCE(u_2008_existtotal, u_2007_existtotal, units_init)
				ELSE u_2009_existtotal
			END),
		u_2008_existtotal = 
			(CASE
				WHEN u_2008_existtotal IS NULL 
				THEN COALESCE(u_2007_existtotal, units_init)
				ELSE u_2008_existtotal
			END),
		u_2007_existtotal = 
			(CASE
				WHEN u_2007_existtotal IS NULL 
				THEN COALESCE(u_2007_existtotal, units_init)
				ELSE u_2007_existtotal
			END)
	WHERE dcp_status = 'Complete (demolition)';