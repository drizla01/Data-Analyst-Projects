/**
CLEANING DATA IN SQL QUERIES
*/

------------------------------------------------------------------------------------------

--STARNDARDIZE DATE FORMAT
SELECT *
FROM PortfolioCovidProject..nashville

SELECT SaleDate, CONVERT(DATE,SaleDate)
FROM PortfolioCovidProject..nashville

ALTER TABLE PortfolioCovidProject..nashville
ADD SaleDated DATE;

UPDATE PortfolioCovidProject..nashville
SET SaleDated = CONVERT(DATE, SaleDate);
------------------------------------------------------------------------------------------

--POPULATE THE PROPERTY ADDRESS DATA

SELECT *
FROM PortfolioCovidProject..nashville
--WHERE PropertyAddress is null
ORDER BY ParcelID;


SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioCovidProject..nashville a
JOIN PortfolioCovidProject..nashville b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ];


UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioCovidProject..nashville a
JOIN PortfolioCovidProject..nashville b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL;

------------------------------------------------------------------------------------------

-- BREAKING OUT ADDRESS INTO INDIVIDUAL COLUMNS(ADDRESS,CITY, STATES)

ALTER TABLE PortfolioCovidProject..nashville
ADD HomeAddress VARCHAR, Town VARCHAR;

SELECT
SUBSTRING(PropertyAddress, 1 , CHARINDEX(',',PropertyAddress) -1 ) AS HomeAddress, 
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) AS Town
FROM PortfolioCovidProject..nashville

UPDATE PortfolioCovidProject..nashville
SET HomeAddress = (SELECT
SUBSTRING(PropertyAddress, 1 , CHARINDEX(',',PropertyAddress) -1 ));

UPDATE PortfolioCovidProject..nashville
SET Town = CONVERT(DATE, Town);


SELECT *
FROM PortfolioCovidProject..nashville;
------------------------------------------------------------------------------------------

-- CHANGE Y AND INTO YES AND NO















------------------------------------------------------------------------------------------

-- REMOVE DUPLICATE

















------------------------------------------------------------------------------------------

--DELETE UNUSED COLUMNS



