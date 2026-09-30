-- Create the location dimension table

USE JobMarket;
GO

DROP TABLE IF EXISTS dbo.DimLocation;
GO

CREATE TABLE dbo.DimLocation (
	LocationID INT IDENTITY(1,1) PRIMARY KEY,
	Locality VARCHAR(100) NOT NULL,
	State VARCHAR(6) NOT NULL
);
GO