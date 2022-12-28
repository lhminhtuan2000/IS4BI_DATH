USE tempdb
GO
DROP DATABASE covid_dds
GO

CREATE DATABASE covid_dds
GO
USE covid_dds
GO
CREATE TABLE dim_date
(
    id int IDENTITY,
    day_in_month tinyint,
    month_in_year tinyint,
    quarter_in_year tinyint,
    year int,

    CONSTRAINT pk__dim_date PRIMARY KEY (id)
)

GO
DECLARE @StartDate  date = '20200101';
DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, 3, @StartDate));

;WITH seq(n) AS 
(
  SELECT 0 UNION ALL SELECT n + 1 FROM seq
  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
),
d(d) AS 
(
  SELECT DATEADD(DAY, n, @StartDate) FROM seq
),
src AS
(
  SELECT
    TheDate         = CONVERT(date, d),
    TheDay          = DATEPART(DAY,       d),
    TheMonth        = DATEPART(MONTH,     d),
    TheQuarter      = DATEPART(Quarter,   d),
    TheYear         = DATEPART(YEAR,      d)
  FROM d
),
dim AS
(
  SELECT
    TheDate, 
    TheDay,
    TheMonth,
    TheQuarter,
    TheYear
  FROM src
)

INSERT INTO dim_date(day_in_month,month_in_year,quarter_in_year,year)
SELECT TheDay,TheMonth,TheQuarter,TheYear FROM dim
  ORDER BY TheDate
  OPTION (MAXRECURSION 0);

GO
