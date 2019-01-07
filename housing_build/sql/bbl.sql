-- populate the bbl field
-- create the boro code lookup table
WITH borolookup AS (
SELECT DISTINCT boro,
	(CASE 
		WHEN boro = 'MANHATTAN' THEN '1'
		WHEN boro = 'BRONX' THEN '2'
		WHEN boro = 'BROOKLYN' THEN '3'
		WHEN boro = 'QUEENS' THEN '4'
		WHEN boro = 'STATEN ISLAND' THEN '5'
		ELSE NULL
	END ) borocode
FROM housing
)

UPDATE housing a
SET bbl = b.borocode||lpad(a.block, 5, '0')||lpad(RIGHT(a.lot,4), 4, '0')
FROM borolookup b
WHERE a.boro=b.boro;

UPDATE housing a
SET bbl = trim(trailing '0' FROM bbl::text)
WHERE length(bbl)>10;