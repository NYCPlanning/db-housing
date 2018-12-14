# Housing DB - Metadata README Document
### The common name of the dataset

DCP Housing Database

### Name of data set in the spatial data warehouse

dcp_housing_permits

### Summary

Completed residential construction and residential job applications for 2010 – present, based on DOB job application permits and Certificates of Occupancy.

### Description

The DCP Housing Database includes all residential New Building (NB) and Major Alteration (A1) __completions__ between January 1, 2010 and present, with the corresponding job applications data, as well as all __residential job applications__ (NB, A1, DM) __filed or issued__ in the same time period, with corresponding completions data (if job application has reached completion).

### Data Steward

Housing, Economic, and Infrastructure Planning (HEIP)

### Data Engineer

Enterprise Data Management (EDM)

### Update frequency

Quarterly

### Date of the last update

May 2018

### Date of underlying data

[DOB Job Application Filings](https://data.cityofnewyork.us/Housing-Development/DOB-Job-Application-Filings/ic3t-wcy2): May 2018 <br>
DOB Certificates of Occupancy (COs) Data – Completions: February 2018
<br>
## Data sources and compilation process

#### DOB Jobs Data - Permit Applications

These data are pulled from NYC Open Data. The jobs data provides a comprehensive list of development projects, including projects where an application has been filed, but no permit has yet been issued, or a permit has been issued but construction has not yet been completed. For more information on DOB job milestones and status, labels see https://www1.nyc.gov/assets/buildings/pdf/bisjobstatus.pdf.

For each project, the jobs data captures the type of development, the initial number of existing units (relevant for alterations and demolitions) and the number of proposed units (relevant for alterations and new buildings). Some records, especially alterations, have missing values.

#### DOB Certificates of Occupancy (COs) Data – Completions


These data are requested from DOB. The public version is missing the number of dwelling units that each CO certifies. The CO data captures the legal number of existing units at a given point in time. Since a job may have multiple temporary COs before the final CO is given, there may be multiple rows per job ID.<br>
Information on the COs enables the calculation of the incremental change in housing units per year. Buildings, particularly large ones, may have construction periods spanning several years.

#### DCP Compilation
DCP combines the two datasets, because the jobs data does not capture the change in a number of housing units over time, and the COs data lacks context for determining the net change in units. COs do not account for how many units already existed or how many outstanding units are still planned to be built. Furthermore, DCP adds some value-add and quality checks to the data, such as translating DOB codes to more meaningful values, mapping the projects, and flagging potentially duplicate records.

#### Version

18v1

#### Common uses (optional)

**How do I calculate how many housing units were completed in New Buildings in a given year in a given area?**
When calculating totals of completed units (i.e. real growth that has occurred during a time range), users should take the sum of the annual incremental changes during the desired years.
+ Filter for __job_type__ “New Building”
+ Exclude __x_withdrawal__ “Withdrawn” or “Administrative Closure”
+ Exclude __x_dup_flag__ “Possible Duplicate”
+ Summarize the field __unit_change_[year of interest]__
+ Depending on the purpose of the analysis, you may want to add a slicer for __unit_change_[year of interest]__, and filter for only positive numbers (unit additions, excluding unit subtractions). Negative numbers in __unit_change_[year of interest]__ account for either unit corrections compared to previous years, or the merging of existing units.

Correct completion numbers (_including subtracted units, through corrections on previous years’ error or unit mergers_) for the years 2010 through 2017 by borough, are:

| Year | MN | BX | BK | QN | SI | NYC|
| ---- | -- | -- | -- | -- | -- | -- |
| **2010**  | 7,252  | 3,988  |7,254 |  3,685  | 816  | **22,995**  |
| **2011**  | 4,727  | 3,287 |4,833|2,808| 623  | **16,278**  |
| **2012**   | 1,900 | 1,754|3,355 | 2,581  |656 |**10,246**  |
| **2013**   | 3,003   |  1,245 | 4,203  |3,961   |575 | **12,987** |
| **2014**   | 4,225  | 1,669  | 4,502  |3,446  | 519  |**14,361** |
| **2015**   | 3,371  | 2,293  | 5,559  |3,127    |547| **14,897**  |
| **2016**   | 8,226  | 2,300  | 8,758  | 3,310  | 1,255   |**23,849**|
| **2017**   | 5,844  | 2,672  | 11,054  | 4,976  |  671  | **25,217**  |


**How do I determine how many housing units were permitted in New Buildings in a given year or time frame in a given area?**

+ Filter for __job_type__ “New Building”
+ Exclude __x_dup_flag__ “Possible Duplicate”
+ Summarize the field __units_prop__, based on __status_q__
+ Depending on the objective of the analysis, you may want to exclude __x_withdrawal__ “Withdrawn” or “Administrative Closure”

Correct permitting numbers for the years 2010 through 2017 by borough, are:

| Year | MN | BX | BK | QN | SI | NYC|
| ---- | -- | -- | -- | -- | -- | -- |
| **2010**  | 1,625 | 1,747  |907 |  2,415  | 449  | **7,143**  |
| **2011**  | 971  | 1,470 | 2,837 | 3,181 | 492  | **8,951**  |
| **2012**   | 2,270 | 3,632 |4,711 | 1,383  |395 |**12,391**   |
| **2013**   | 2,428   |  6,100 | 4,236 |3,788   |1,250 | **17,802** |
| **2014**   | 1,888  | 9,303 | 9,553  |4,543  | 710  |**25,997** |
| **2015**   | 4,986  | 27,125  | 11,352  |14,155    |656| **58,274**  |
| **2016**   | 3,574  | 5,007  | 3,934  | 2,986  |643   |**16,144**|
| **2017**   | 5,255  | 5,618  | 3,700  | 4,374 |  672  | **19,619**  |

**How do I find out how many __of the permitted__ housing units in new Buildings __were actually completed__ in a time frame?**

**How do I know how many housing units existed at a given ate in a given area?**

#### Data Quality

* The source of this data is administrative.
* There are known data inconsistencies in Certificate of Occupancy records over time. All dwelling unit counts in the DOB jobs data are self-reported by the applicant, as are occupancy codes. Errors in unit counts may exist, as may misclassifications. Mixed-use buildings in particular are not treated consistently. Certain mixed-use hotel/residential buildings may have excessive unit counts, since hotel rooms may appear as residential units (e.g. Job No: 104576246, or 110089779). It is DCP’s aim to improve the flagging of such errors.
* This data does not capture any illegal, non-DOB-permitted construction, such as non-permitted alterations or subdivisions of units.
* Various methods were used to geocode the data. The source of the x/y coordinates is noted in the field **x_geomsource**. For a subset of records, where **x_geomsource** = Geoclient, the x/y coordinates fall near the street center line associated with the BBL, but within the correct Neighborhood Tabulation Area, census tract, etc.
* For alterations, there are several cases where DOB job records do not provide the initial number of units or proposed number of units. For these records, the proposed net change in units cannot be calculated.
* Note that for Alteration permits, this database only includes A1 type permits. These are major alterations that will change use, egress or occupancy. Alteration applications records are typically less reliable than New Building applications. They may have missing data or the reported building classification may not reflect the actually occupancy of the entire building.
* For Demolitions, this database captures all demolitions (partial and full). However, many of these records are only for partial demolitions, often the demolition of a stand-alone garage. Interpretation of Demolitions should be made with caution.

#### Caveats

* Users should be wary of doing data aggregations using units_net and units_net_complete. These two fields are generally only useful when looking at individual jobs and tracking their progress. The aggregated total of these fields is not meaningful because of the variance in time scale involved between projects.
* For completions, rely on Certificate of Occupancy data (field **latest_cofo**) and not status_x field. This is because a building can receive a temporary CO and not be at Sign-off status.
* General filtering criteria to consider for analyses:
  * **Withdrawn job application:** flagged in **x_withdrawal** or **dcp_status** field
  * **Duplicates:** flagged in **x_dup_flag** field
  * **Outliers:** flagged in **x_outlier** field
  * **Inactivity:** flagged in the **x_inactive** field. All jobs where 5+ years have passed since the most recent status update.
  * **Applications** that have not yet been permitted/reached **status_q** (no date in **status_q**). This is also captured in the **dcp_status** field, althought the **status_q** field is more reiable. Depending on the use case and required degree of confidence that a project will come to fruition, it could make sense to exclude projects where there is only an application on file and no permit issued yet. Only 30% of job applications progress to getting permits.
  
#### Future Plans

Incorporate complete projects from COs data that do not appear in

#### Distribution

Who is allowed to use this data set? Specific divisions within DCP, all DCP staff, other city agencies, the public?

#### Credits

New York City Department of Buildings, New York City Department of City Planning

#### Citation

Extensive: DCP Housing Database 18v1, compilation of NYC DOB Applications and Certificates of Occupancy data, (as provided by DOB and compiled by DCP in May 2018 as version 1)

Regular: DCP Housing Database 18v1, compilation of NYC DOB Applications and Certificates of Occupancy data

Abbreviated: DCP Housing Database 18v1

#### Use Limitations

DCP Housing Database is being provided by the Department of City Planning (DCP) for informational purposes only. DCP does not warranty the completeness, accuracy, content, or fitness for any particular purpose or use of DCP Housing Database, nor are any such warranties to be implied or inferred with respect to DCP Housing Database. DCP and the City are not liable for any deficiencies in the completeness, accuracy, content, or fitness for any particular purpose or use of DCP Housing Database, or applications utilizing DCP Housing Database, provided by any third party. __Enter any additional use limitations. These might include a disclaimer that should be displayed on any map using the data or restrictions on how the data can be used.__

#### Tags

Housing<br>New Construction<br>Building Permits<br>Certificates of Occupancy
