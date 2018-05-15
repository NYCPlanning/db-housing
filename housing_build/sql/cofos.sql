-- populate core CofO data for dates and number of units from dob_cofos
-- add cofo_year column and populate it using the effectivedate value so that you can calculate cof values by year
ALTER TABLE dob_cofos DROP COLUMN cofo_year;
ALTER TABLE dob_cofos
	ADD COLUMN cofo_year text;

UPDATE dob_cofos
    SET cofo_year = (
        CASE
            WHEN effectivedate::date < TO_DATE('04/01/2010', 'MM/DD/YYYY')
                AND effectivedate::date >= TO_DATE('01/01/2010', 'MM/DD/YYYY')
                THEN '2010-PreCensus'
            WHEN effectivedate::date >= TO_DATE('04/01/2010', 'MM/DD/YYYY')
                AND effectivedate::date < TO_DATE('01/01/2011', 'MM/DD/YYYY')
                THEN '2010-PostCensus'
            ELSE right(effectivedate::text,2)
        END);

-- get the max cof by year, min and max dates for CofOs and update the housing table
WITH cofobyyear AS (
    SELECT
        jobnum,
        max(CASE WHEN cofo_year = '07' THEN numofdwellingunits::numeric END) as u_2007_existtotal,
        max(CASE WHEN cofo_year = '08' THEN numofdwellingunits::numeric END) as u_2008_existtotal,
        max(CASE WHEN cofo_year = '09' THEN numofdwellingunits::numeric END) as u_2009_existtotal,
        max(CASE WHEN cofo_year = '10-PreCensus' THEN numofdwellingunits::numeric END) as u_2010pre_existtotal,
        max(CASE WHEN cofo_year = '10-PostCensus' THEN numofdwellingunits::numeric END) as u_2010post_existtotal,
        max(CASE WHEN cofo_year = '11' THEN numofdwellingunits::numeric END) as u_2011_existtotal,
        max(CASE WHEN cofo_year = '12' THEN numofdwellingunits::numeric END) as u_2012_existtotal,
        max(CASE WHEN cofo_year = '13' THEN numofdwellingunits::numeric END) as u_2013_existtotal,
        max(CASE WHEN cofo_year = '14' THEN numofdwellingunits::numeric END) as u_2014_existtotal,
        max(CASE WHEN cofo_year = '15' THEN numofdwellingunits::numeric END) as u_2015_existtotal,
        max(CASE WHEN cofo_year = '16' THEN numofdwellingunits::numeric END) as u_2016_existtotal,
        max(CASE WHEN cofo_year = '17' THEN numofdwellingunits::numeric END) as u_2017_existtotal,
        max(effectivedate::date) AS latest_effectivedate,
        min(effectivedate::date) AS earliest_effectivedate,
        min(certificatetype) AS latest_certtype,
        NULL::numeric AS latest_cofo
    FROM dob_cofos
    GROUP BY jobnum
)

UPDATE housing a
SET u_2007_existtotal = b.u_2007_existtotal,
    u_2008_existtotal = b.u_2008_existtotal, 
    u_2009_existtotal = b.u_2009_existtotal,
    u_2010pre_existtotal = b.u_2010pre_existtotal,
    u_2010post_existtotal =b.u_2010post_existtotal,
    u_2011_existtotal = b.u_2011_existtotal,
    u_2012_existtotal = b.u_2012_existtotal,
    u_2013_existtotal = b.u_2013_existtotal,
    u_2014_existtotal = b.u_2014_existtotal,
    u_2015_existtotal = b.u_2015_existtotal,
    u_2016_existtotal = b.u_2016_existtotal,
    u_2017_existtotal = b.u_2017_existtotal,
    latest_effectivedate = b.latest_effectivedate,
    earliest_effectivedate = b.earliest_effectivedate,
    latest_certtype = b.latest_certtype,
    latest_cofo = COALESCE(
            b.u_2017_existtotal,
            b.u_2016_existtotal,
            b.u_2015_existtotal,
            b.u_2014_existtotal,
            b.u_2013_existtotal,
            b.u_2012_existtotal,
            b.u_2011_existtotal,
            b.u_2010post_existtotal,
            b.u_2010pre_existtotal,
            b.u_2009_existtotal,
            b.u_2008_existtotal,
            b.u_2007_existtotal)
    FROM cofobyyear b
    WHERE a.job_number = b.jobnum;