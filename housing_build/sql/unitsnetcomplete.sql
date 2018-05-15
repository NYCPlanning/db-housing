-- Caculate the number of complete and incomplete units
UPDATE housing
SET units_net_complete =
	-- Calculation is not performed if units_net or u_prop were NULL
		(CASE
			WHEN dcp_status = 'Complete (demolition)' AND units_net IS NOT NULL THEN units_net
			WHEN latest_cofo IS NULL AND units_net IS NOT NULL THEN '0' 
			WHEN dob_type = 'A1' AND latest_cofo IS NOT NULL AND units_net IS NOT NULL THEN (latest_cofo::numeric - units_init::numeric)::text
			WHEN dob_type = 'NB' AND latest_cofo IS NOT NULL AND units_net IS NOT NULL THEN latest_cofo
		END),
	units_net_incomplete =
		(CASE 
			WHEN units_net IS NOT NULL AND dcp_status LIKE '%Complete%' THEN '0'
			WHEN units_net IS NOT NULL AND dcp_status <> 'Complete' THEN (units_net::numeric - units_net_complete::numeric)::text
			WHEN units_net IS NULL AND units_prop IS NOT NULL AND latest_cofo IS NOT NULL AND units_prop <> 'NONE' AND units_prop <> 'NON5' THEN (units_prop::numeric - latest_cofo::numeric)::text
			ELSE units_net
		END);