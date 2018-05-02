INSERT INTO housing (
	dob_job_number,
	address_house,
	address_street,
	latitude,
	longitude,
	bin,
	boro,
	block,
	lot,
	dob_type,
	dob_occ_init,
	dob_occ_prop,
	status_latest,
	status_date,
	status_a,
	status_d,
	status_p,
	status_r,

	status_x,
	dob_bldg_type,

	stories_init,
	stories_prop,

	u_init,
	u_prop

	)
SELECT 
	jobnumber,
	housenumber,
	streetname,
	latitude,
	longitude,
	bin,
	borough,
	block,
	lot,
	jobtype,
	existingoccupancy,
	proposedoccupancy,
	jobstatusdesc,
	latestactiondate,
	prefilingdate,
	fullypaid,

	approved,
	fullypermitted,

	signoffdate,
	buildingtype,

	existingnumstories,
	proposednumstories,

	existingdwellingunits,
	proposeddwellingunits


FROM dob_jobapplications
WHERE jobdocnumber = '01' 
	AND (jobtype = 'A1' OR jobtype = 'DM' OR jobtype = 'NB') 
	AND (proposedoccupancy LIKE '%R%' OR existingoccupancy LIKE '%R%');