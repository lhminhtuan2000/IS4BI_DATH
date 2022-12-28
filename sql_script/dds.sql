CREATE DATABASE covid_dds
GO

USE covid_dds
GO


CREATE TABLE outcome
(
    id INT IDENTITY,
    outcome NVARCHAR(255),
    source_id INT,

    CONSTRAINT pk__outcome PRIMARY KEY (id)
)
GO


CREATE TABLE exposure
(
    id INT IDENTITY,
    exposure NVARCHAR(255),
    source_id INT,

    CONSTRAINT pk__exposure PRIMARY KEY (id)
)
GO


CREATE TABLE 