use covid_nds
go

select REPLACE(phu_group_name, 'West', 'East')
from phu_group
