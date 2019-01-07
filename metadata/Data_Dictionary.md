# Housing DB - Data Dictionary
|Order|Field Name|Longform Name|Description|Geocoded|Required|Data Type|Expected/Allowed Values|Last Modified Date|No Longer In Use|Notes|
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | job_number | Job Number  |  Unique identification DOB Job Application Number assigned to every application |  - [] | - [] |  Number | 321652310, 103293480 | N/A  | - []  |  It is a 9-digit number where the first digit indicates the borough where the building is located. <br>(1 = Manhattan) <br> (2 = Bronx) <br>(3 = Brooklyn) <br>(4 = Queens) <br> (5 = Staten Island) |
| 2  | address  | Address  | House number and street name of the site | - []  | - []  | Text  | 19 Stanton Road, 27 Cooper Square  | N/A  | - []  | N/A  |
| 3  | latitude  | Latitude  | Latitude of the property  | - []  | - []  | Point  | 40.703235, 40.72782 | N/A  | - []  |  Latitude in WGS84 / SRID:4326 |
| 4  | longitude  | Longitude  | Longitude of the property  | - []  | - []  | Point  | -74.00476529, -73.9907  | N/A  | - []  | Longitude in WGS84 / SRID:4326  |
| 5  | xcoord  | X Coordinate  | X Coordinate of the property  | - []  | - []  | Point  | 982928.7861, 992300.0701 | N/A  | - []  | X coordinate in NAD83-New York Long Island (ftUS) / SRID:2263  |
| 6   | ycoord | Y Coordinate  | Y Coordinate of the property  | - []  | - []  | Point  |  196309.9909, 209014.978  | N/A  | - []  | Y coordinate in NAD83-New York Long Island (ftUS) / SRID:2263  |
| 7  | bin  | BIN  | DOB Building Identification Number (BIN) for the property  | - []  | - []  | Number  | 1036456, 5170584 | N/A  | - []  | N/A  |
| 8  | bbl  | BBL  | DOB Borough-Block-Lot (BBL) tax lot ID number for the tax lot the property is within  | - []  | - []  | Number  | 1000080003, 5045000000 | N/A  | - []  | N/A  |
| 9  | boro  | Borough  | Borough where the property is located  | - []  | - []  | Text  | Brooklyn,  Queens | N/A  | - []  | N/A  |
| 10  | job_type  | Job Type  | Category of development based on the permit issued  | - []  | - []  | Text  | New Building,<br> Alteration,<br> Demolition | N/A  | - []   | New Building (NB),<br> Alteration (A1),<br> Demolition (DM)  |
| 11   | occ_init  | Occupancy Initial  | Initial property type at time of the job application filing  | - [] | - []  | Text  | Residential: 1 & 2 Family, <br> Empty Lot  | N/A  | - []  | This indicates whether a site is/was initially a hotel, 1-2 family home, commercial space, etc.  These values are created and maintained by DCP based on DOB input data.  |
| 12 | occ_prop  | Occupancy Proposed  | Proposed property type at time of the job application filing  | - []  | - []  | Text  | Hotel or Dormitory, <br> Residential: Multi-Family  | N/A | - [] | This indicates whether the site is being converted into a hotel, 1-2 family home, commercial space, etc. These values are created and maintained by DCP based on DOB input data.   |
| 13  | dcp_status | DCP Status  | Field created by DCP to capture progress of Certificates of Occupancy (CO) issuances  | - []  | - []  | Text  | Complete (demolition), <br> Permit issued | N/A | - []  | - Complete: most recent CO lists >80% of permit proposed units.<br> - Partial complete: most recent CO lists <80% of permit proposed units. <br> - Permit outstanding: first permit issued but no COs issued.<br> - Permit pending: permit application complete but first permit not issued.  |
| 14  | dob_status  | DOB Status  | Most recent job status, listed in DOB jobs data  | - []  | - []  | Text  | Permit Issued - Entire Job/Work, <br> Signed Off  | N/A  | - []  | More details on each status label: <br> https://www1.nyc.gov/assets/buildings/pdf/bisjobstatus.pdf |
| 15  | status_date  | Status Date  | Date of most recent DOB job status update  | - []  | - []  | Date  |  2/16/18 0:00, 10/15/15 0:00 | N/A  | - []  | N/A  |
| 16  | status_a  | Status A  | Date of pre-filing application  | - []  | - []  | Date  | 2/7/18, 6/19/07, 5/28/10, 1/28/09, 3/1/10, 4/14/14 | N/A  | - []  | N/A  |
| 17   | status_d  | Status D  | Date of completed application on file  | - []  | - []  | Date  | Same as status_a | N/A  | - []  | N/A  |
| 18  | status_p  | Status P  | Date of plan examination approval  | - []  | - []  | Date  | Same as status_a | N/A  | - []  | N/A  |
| 19  | status_q  | Status Q  | Date of first partial permit issuance  | - []  | - []  | Date  | Same as status_a  | N/A   | - []  | N/A  |
| 20  | status_r  | Status R  | Date of full permit issuance | - []  | - []  | Date  | Same as status_a | N/A  | - []  | N/A  |
| 21  | status_x  | Status X  | Date of job completion  | - []  | - []  | Date  | Same as status_a  | N/A  | - []  | N/A  |
| 22  | stories_init  | Stories Initial  | Initial number of building stories  | - []  | - []  | Number  | 1, 13, 20, 41  | N/A  | - []  | N/A  |
| 23  | stories_prop  | Stories Proposed  | Proposed number of building stories  | - []  | - [] | Number  | Same as stories_init | N/A  | - []  | N/A  |
| 24  | zoningsft_init  | Zoning Square Footage Initial  | This is the Total Zoning Floor Area for the existing building, if any  | - []  | - []  | Number  | 0, 523095, 467234, 343902  | N/A  | - []  |  This is only required for a Job Type of NB or A1.  |
| 25  | zoningsft_prop  | Zoning Square Footage Proposed  | This is the Total Zoning Floor Area for the  building after the proposed work is completed | - []  | - []  | Number  | Same as zoningsft_init  | N/A  | - []  | This is only required for a Job Type of NB or A1.  |
| 26   | units_init  | Units Initial  | Number of units that initially existed in building at time of job application  | - []  | - []  | Number  | 134, 40, -121, 32  | N/A  | - []  | N/A  |
| 27   | units_prop   | Units Proposed  | Number of final units proposed in job application  | - []  | - []  | Number  | Same as units_init  | N/A  | - []  | N/A  |
| 28  | units_net  | Units Net  | Net change in unit count proposed in application  | - []  |  - [] | Number  | Same as units_init  | N/A  | - []  | This value could only be calculated in cases where values were provided for both units_init and units_prop  |
| 29  | units_net_complete | Units Net Complete  | Cumulative number of proposed units that have been completed to date based on Certificates of Occupancy (CO) data  | - []  | - []  | Number  | Same as units_init  | N/A  | - []  | N/A  |
| 30  | units_net_incomplete  | Units Net Incomplete  | Number of proposed units that have not yet been completed to date based on Certificates of Occupancy (CO) data | - []  | - []  | Number  | Same as units_init  | N/A  | - []  | N/A  |
| 31  | earliest_effectivedate  | Earliest Effective Date  | Date of earliest Certificates of Occupancy (CO) issued  |  - [] | - []  | Date  | 11/8/10, 9/20/12  | N/A  | - []  | N/A  |
| 32  | latest_effectivedate  | Latest Effective Date  | Date of most recent Certificates of Occupancy (CO) issued  | - []  | - []  | Date   | Same as earliest_effectivedate  | N/A  | - []  | N/A  |
| 33  | latest_certtype  | Latest Certificate Type  | Specifics most recent Certificate of Occupancy type (CO) type (Temporary or Final) | - []  | - []  | Text  | T- TCO, C- CO | N/A  | - []  | N/A  |
| 34  | latest_cofo | Latest Certificate of Occupancy  | Number of units captured in most recent CO issued  | - []  | - []  | Number  | 150, 3  | N/A | - []  | N/A  |
| 35  | unit_change_2007  | Unit Change 2007  | The net number of units added or removed in 2007 based on DOB application and CO data  | - []  | - []  | Number  | -12, 33, 36, 112  | N/A  | - []  | N/A  |
| 36  | unit_change_2008  | Unit Change 2008  | The net number of units added or removed in 2008 based on DOB application and CO data  | - []  | - []  | Number  |  Same as unit_change_2007  | N/A  | - []  | N/A  |
| 37  | unit_change_2009  | Unit Change 2009  | The net number of units added or removed in 2009 based on DOB application and CO data  | - []  | - []  | Number  | Same as unit_change_2007  | N/A  | - []  | N/A  |
| 38  | unit_change_preapr2010  | Unit Change Pre April 2010  |  The net number of units added or removed in 2010 before April 1 based on DOB application and CO data | - []  | - []  | Number  | Same as unit_change_2007 | N/A  | - []  | N/A  |
| 39  | unit_change_postapr2010  | Unit Change Post April 2010  | The net number of units added or removed in 2010 after April 1 based on DOB application and CO data  | - []  | - []  | Number  | Same as unit_change_2007  | N/A  | - []  | N/A  |
| 40  | unit_change_2011  | Unit Change 2011  | The net number of units added or removed in 2011 based on DOB application and CO data  | - []  | - []  | Number  | Same as unit_change_2007  | N/A  | - []  | N/A  |
| 41  | unit_change_2012  | Unit Change 2012  | The net number of units added or removed in 2012 based on DOB application and CO data  | - []  | - []  | Number  | Same as unit_change_2007  | N/A  | - []  | N/A  |
| 42  | unit_change_2013  | Unit Change 2013  | The net number of units added or removed in 2013 based on DOB application and CO data  | - []  | - []  | Number  | Same as unit_change_2007  | N/A  | - []  | N/A  |
| 43  | unit_change_2014  | Unit Change 2014  | The net number of units added or removed in 2014 based on DOB application and CO data  | - []   | - []  | Number  | Same as unit_change_2007  | N/A  | - []  | N/A  |
| 44  | unit_change_2015  | Unit Change 2015  | The net number of units added or removed in 2015 based on DOB application and CO data  | - []  | - []  | Number  | Same as unit_change_2007  | N/A  | - []  | N/A  |
| 45  | unit_change_2016  | Unit Change 2016  | The net number of units added or removed in 2016 based on DOB application and CO data  | - []  | - []  | Number  | Same as unit_change_2007  | N/A  | - []  | N/A  |
| 46  | unit_change_2017  | Unit Change 2017  | The net number of units added or removed in 2017 based on DOB application and CO data  | - []  | - []  | Number  | Same as unit_change_2007  | N/A  | - []  | N/A  |
| 47  | geo_cd  | Geographic Community District  | NYC Community District  | - []  | - []  | Number  | 105, 302  | N/A  | - []  | N/A  |
| 48  | geo_ntacode  | Geographic NTA Code  | Neighborhood Tabulation Areas (NTA) Code  | - []  | - []  | Text  | MN17, BK38  | N/A  | - []  | N/A  |
| 49  | geo_ntaname  | Geographic NTA Name  | Neighborhood Tabulation Areas (NTA) Name  | - []  | - []  | Text  | Clinton Hill, <br>Dyker Heights  | N/A  | - []  | N/A  |
| 50  | geo_censusblock  | Geographic Census Block  | US Census Block  | - []  | - []  | Number | N/A  | N/A  | - []  | N/A  |
| 51  | geo_csd  | Geographic Community School District | DOE school district  | - []  | - []  | Number | 2, 13  | N/A  | - []  | Range is from 1 - 32  |
| 52  | pfirms2015_100yr  | Preliminary Flood Insurance Rate Map 2015 100 Year  | 2015 Preliminary FEMA Flood Insurance Rate Map zone  | - []  | - []  | N/A  | N/A  | N/A  | - []  | N/A  |
| 53  | x_dup_flag  | X Dedup Flag  | Flag that identifies likely duplicate records that should be excluded from analyses  | - []  | - []  | Boolean  | TRUE, FALSE  | N/A  | - []  | N/A  |
| 54  | x_dup_id  | X Dedup ID  | Unique ID, comprised of a concatentation of address, job ID, and project type used to check for duplicates  | - []  | - []  | Text  | New Building1010513305108843740WEST41STREET  | N/A  | - []  | N/A  |
| 55  | x_inactive  | X Inactive  | Flag that indicates if more than 5 years have passed since a permit was issued and there have been no changes to the count of units in the building  | - []  | - []  | Boolean  | TRUE, FALSE  | N/A | - []  | N/A  |
| 56  | x_outlier  | X Outlier  | Flag that indicates whether a record is a suspected outlier or DOB data error and should be excluded from analysis calculations  | - []  | - []  | Boolean  |  TRUE, FALSE | N/A  | - []  | N/A  |

