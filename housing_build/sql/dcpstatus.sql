-- populate the dcp status field using the housing_input_lookup_status lookup table
UPDATE housing a
SET dcp_status = b.dcpstatus
FROM housing_input_lookup_status b
WHERE a.dob_status=b.dobstatus;

-- update dcp_status to 'Complete (demolition)' where dob_type ='DM' AND dcp_status = 'Complete' or 'Permit issued'
UPDATE housing a
SET dcp_status =
	(CASE
		WHEN dob_type = 'DM' AND dcp_status IN ('Complete','Permit issued') THEN 'Complete (demolition)'
		ELSE dcp_status
	END);

-- where values were not populated set to be the dob status
UPDATE housing a
SET a.dcp_status = INITCAP(a.dob_status)
WHERE a.dcp_status IS NULL;