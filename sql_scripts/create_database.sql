USE master;
GO

-- If database exists then disconnect everyone from it before dropping
IF DB_ID('JobMarket') IS NOT NULL
BEGIN
	ALTER DATABASE JobMarket
		SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE JobMarket;
END;
GO

CREATE DATABASE JobMarket;
GO

USE JobMarket;
GO