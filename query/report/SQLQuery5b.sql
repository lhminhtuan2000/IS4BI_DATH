/****** Script for SelectTopNRows command from SSMS  ******/
select t.year,sum(t.Number) as 'total'
from
(SELECT [phu_id]
      ,[vba_age_group_id]
      ,dd.[year]
      ,max([at_least_one_dose_cumulative]) as 'Number'
  FROM [covid_dds].[dbo].[fact_vaccines] inner join dim_date dd on dd.id = date_id
  group by [phu_id],[vba_age_group_id],dd.[year]) as t
group by t.year