USE tempdb
GO
DROP DATABASE covid_nds
GO

CREATE DATABASE covid_nds
GO
USE covid_nds
GO

CREATE TABLE [phu_city]
(
    id INT IDENTITY,
    [name] NVARCHAR(255),
    phu_group_id INT,

    CONSTRAINT pk__phu_city PRIMARY KEY (id)
)
GO


CREATE TABLE [phu_group]
(
    id INT IDENTITY,
    phu_group_name NVARCHAR(255),

    CONSTRAINT pk__phu_group PRIMARY KEY (id)
)
GO


CREATE TABLE [outbreak_group]
(
    id INT IDENTITY,
    outbreak_group NVARCHAR(255),

    CONSTRAINT pk__outbreak_group PRIMARY KEY (id)
)
GO


CREATE TABLE [ongoing_outbreaks_phu]
(
    id INT IDENTITY,
    [date] DATE,
    phu_id INT,
    outbreak_group_id INT

    CONSTRAINT pk__ongoing_outbreaks_phu PRIMARY KEY (id)
)
GO


CREATE TABLE [vaccines_by_age_phu] 
(
    id INT IDENTITY,
    [date] DATE,
    phu_id INT,
    age_group_id INT,
    at_least_one_dose_cumulative INT,
    second_dose_cumulative INT,
    fully_vaccinated_cumulative INT,
    third_dose_cumulative INT

    CONSTRAINT pk__vaccines_by_age_phu PRIMARY KEY (id)
)
GO


CREATE TABLE [outcome]
(
    id INT IDENTITY,
    outcome NVARCHAR(255),

    CONSTRAINT pk__outcome PRIMARY KEY (id)
)
GO


CREATE TABLE [exposure]
(
    id INT IDENTITY,
    exposure NVARCHAR(255),

    CONSTRAINT pk__exposure PRIMARY KEY (id)
)
GO


CREATE TABLE [age_group]
(
    id INT IDENTITY,
    age_group NVARCHAR(255),

    CONSTRAINT pk__age_group PRIMARY KEY (id)
)
GO


CREATE TABLE [case] 
(
    id INT IDENTITY,
    reported_date DATE,
    reporting_phu_id INT,
    gender NVARCHAR(255),
    age_group_id INT,
    exposure_id INT,
    outcome_id INT

    CONSTRAINT pk__case PRIMARY KEY (id)
)   
GO


CREATE TABLE [public_health_unit]
(
    id INT IDENTITY,
    phu_nk INT UNIQUE,
    [name] NVARCHAR(255),
    [address] NVARCHAR(255),
    phu_group_id INT,
    postal_code VARCHAR(10),
    website NVARCHAR(255),
    latitude FLOAT,
    longitude FLOAT,

    CONSTRAINT pk__public_health_unit PRIMARY KEY (id)
)
GO


ALTER TABLE [case]
    ADD CONSTRAINT fk__case__outcome
    FOREIGN KEY (outcome_id) REFERENCES outcome (id)
ALTER TABLE [case]
    ADD CONSTRAINT fk__case__exposure
    FOREIGN KEY (exposure_id) REFERENCES exposure (id)
ALTER TABLE [case]
    ADD CONSTRAINT fk__case__age_group
    FOREIGN KEY (age_group_id) REFERENCES age_group (id)
ALTER TABLE [case]
    ADD CONSTRAINT fk__case__public_health_unit
    FOREIGN KEY (reporting_phu_id) REFERENCES public_health_unit (id)
GO


ALTER TABLE [phu_city]
    ADD CONSTRAINT fk__phu_city__phu_group
    FOREIGN KEY (phu_group_id) REFERENCES phu_group (id)
GO


ALTER TABLE [ongoing_outbreaks_phu]
    ADD CONSTRAINT fk__ongoing_outbreaks_phu__outbreak_group
    FOREIGN KEY (outbreak_group_id) REFERENCES outbreak_group (id)
ALTER TABLE [ongoing_outbreaks_phu]
    ADD CONSTRAINT fk__ongoing_outbreaks_phu__public_health_unit
    FOREIGN KEY (phu_id) REFERENCES public_health_unit (id)
GO


ALTER TABLE [public_health_unit]
    ADD CONSTRAINT fk__public_health_unit__phu_group
    FOREIGN KEY (phu_group_id) REFERENCES phu_group (id)
GO


ALTER TABLE [vaccines_by_age_phu]
    ADD CONSTRAINT fk__public_health_unit__public_health_unit
    FOREIGN KEY (phu_id) REFERENCES public_health_unit (id)
ALTER TABLE [vaccines_by_age_phu]
    ADD CONSTRAINT fk__public_health_unit__age_group
    FOREIGN KEY (age_group_id) REFERENCES age_group (id)
GO