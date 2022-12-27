use covid_nds
go

select REPLACE(phu_group_name, 'West', 'East')
from phu_group

-- [OLE DB Destination [75]] Error: An error occurred while setting up a binding for the 'outcome' column. 
-- The binding status was 'DT_TEXT'. The data flow column type is 'DBBINDSTATUS_UNSUPPORTEDCONVERSION'. 
-- The conversion from the OLE DB type of 'DBTYPE_IUNKNOWN' to the destination column type of 'DBTYPE_VARCHAR' might not 
-- be supported by this provider.

SELECT CAST(REPLACE('2020/03/23 12:00:00',' 12:00:00+00', '') as datetime) as 'as'

SELECT REPLACE('2020/03/23 12:00:00',' 12:00:00+00', '')


use covid_stage
UPDATE public_health_unit
SET [reporting_phu] =  REPLACE(
    REPLACE(
        REPLACE(
            REPLACE( 
                [reporting_phu], 
                'Health Unit', 
                'Public Health'
            ), ' &', ','
        ), ' and', ','
    ), ' District', ''
)

select * from public_health_unit


