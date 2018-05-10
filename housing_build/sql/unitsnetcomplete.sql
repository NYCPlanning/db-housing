-- Caculate the number of complete and incomplete units
UPDATE housing
SET u_net_complete =
	-- Calculation is not performed if u_init or u_prop were NULL
		(CASE
			WHEN dcp_status = 'Complete (demolition)' AND u_net IS NOT NULL THEN u_net
			WHEN c_u_latest IS NULL AND u_net IS NOT NULL THEN '0' 
			WHEN dob_type = 'A1' AND c_u_latest IS NOT NULL AND u_net IS NOT NULL THEN (c_u_latest::numeric - u_init::numeric)::text
			WHEN dob_type = 'NB' AND c_u_latest IS NOT NULL AND u_net IS NOT NULL THEN c_u_latest
		END),
	u_net_incomplete =
		(CASE 
			WHEN u_net IS NOT NULL AND dcp_status LIKE '%Complete%' THEN '0'
			WHEN u_net IS NOT NULL AND dcp_status <> 'Complete' THEN (u_net::numeric - u_net_complete::numeric)::text
			WHEN u_init IS NULL AND u_prop IS NOT NULL AND c_u_latest IS NOT NULL AND u_prop <> 'NONE' AND u_prop <> 'NON5' THEN (u_prop::numeric - c_u_latest::numeric)::text
			ELSE u_net
		END);