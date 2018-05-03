-- populate the dcp status field using the housing_input_lookup_status lookup table
UPDATE housing a
SET dcp_status = b.dcpstatus
FROM housing_input_lookup_status b
WHERE a.status_latest=b.dobstatus;

-- where values were not populated set to be the dob status
UPDATE housing a
SET a.dcp_status = INITCAP(a.status_latest)
WHERE a.dcp_status IS NULL;