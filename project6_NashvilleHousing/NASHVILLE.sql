USE NASHVILE_HOUSING ;

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Nashville Housing';

--LIST ALL THE PROPERTIES AND THIER SALE PRICES :

SELECT * FROM
[Nashville Housing] ;

SELECT 
     PROPERTYADDRESS
	 ,SALEPRICE
FROM
     "Nashville Housing";

--FIND THE PROPERTIES SOLD AFTER 2010 :

SELECT
    PropertyAddress
	,SaleDate
FROM 
   "Nashville Housing"
WHERE
    SaleDate > '2010-01-01';


--COUNT HOW MANY PROPERTIES WERE SOLD AS VACANT 

SELECT 
     COUNT(*) AS
	 NUMBER_OF_PROPERTY
FROM 
     "Nashville Housing"
WHERE
     SoldAsVacant = 1 ;


--FIND ALL THE PROPERTIES WITH MORE THAN 3 BEDROOMS :

SELECT 
     PropertyAddress
	 ,Bedrooms
FROM 
   "Nashville Housing"
WHERE 
    Bedrooms > 3;


--CALCULATES THE AVERAGE SALE PRICE OF PROPERTIES BASED ON LAND USE:

SELECT 
     AVG(SALEPRICE) AS
	 AVERAGESALEPRICE
	 ,LANDUSE
FROM
     "Nashville Housing"
GROUP BY
     LANDUSE ;


--FIND THE MOST EXPENSIVE PROPERTY SOLD IN EACH TAX DISTRICT :

SELECT 
     TaxDistrict
     ,MAX(SALEPRICE)AS 
	 MOSTEXPENSIVE
FROM 
     "Nashville Housing"
GROUP BY 
      TaxDistrict;


/* FIND PROPERTIES WITH A TOTAL VALUE HIGHER THAN $500,000 AND SHOW THIER 
BUILDING AND LAND VALUE : */

SELECT 
    PropertyAddress
    ,LandValue
	,BuildingValue
	,TotalValue
FROM
    "Nashville Housing"
WHERE
    TotalValue  > 500000 ;


--LIST PROPERTIES SOLD IN EACH YEAR,GROUPED BY SALE YEAR :

SELECT 
     YEAR(SALEDATE)AS 
	 SALE_YEAR
	 ,COUNT(*) AS 
	 PROPERTIESSOLD
FROM
    "Nashville Housing" 
GROUP BY
     YEAR(SALEDATE)
ORDER BY
     SALE_YEAR;


--FIND THE PROPERTIES WHERE THE LAND VALUE EXCEEDS THE BUILDING VALUE BY 
-- MORE THAN 50%

SELECT 
     PropertyAddress
	 ,LandValue
	 ,BuildingValue
FROM
    "Nashville Housing"
WHERE
     LandValue > BuildingValue * 1.5 ;


--IDENTIFY THE TOP 5 MOST EXPENSIVE PROPERTIES SOLD BASED ON ACERAGE

SELECT 
     TOP 5 
	 PropertyAddress
	 ,SalePrice
	 ,Acreage
FROM
    "Nashville Housing"
ORDER BY
     Acreage DESC;


--FIND THE PROPERTIES BUILT BEFORE 1980 WITH MORE THAN 2 BATHROOMS

SELECT 
     PropertyAddress
	 ,YearBuilt
	 ,FullBath
	 ,HalfBath
FROM
    "Nashville Housing"
WHERE
     YearBuilt < 1980
AND
    (FullBath + HalfBath) > 2;


--ANALYZE THE PRICE PER ACRE FOR PROPERTIES SOLD ,AND RANK THEM 
-- BY THE HIGHEST PRICE PER ACRE :

SELECT 
     PropertyAddress
	 ,SalePrice
	 ,Acreage
	 (SalePrice / Acreage)
	 AS PRICE_PER_ACRE
FROM 
    "Nashville Housing"
WHERE
    Acreage > 0
ORDER BY
    PRICE_PER_ACRE DESC;


--IDENTIFY MOST COMMON LAND USE FOR THE PROPERTIES SOLD ABOVE $1,000,000 :

SELECT 
     TOP 1 LandUse
	 ,COUNT(*) AS "COUNT"
	 ,SalePrice
FROM
    "Nashville Housing" 
WHERE
     SalePrice > 1000000
GROUP BY
     LandUse
	 ,SalePrice
ORDER BY
     "COUNT" DESC;


--FIND THE PROPERTIES WHERE THE DIFFERENCE BETWEEN TOTAL VALUE AND SALE PRICE IS SIGNIFICANT 
--(E.G 20% LESS)

SELECT
     PropertyAddress
	 ,TotalValue
	 ,SalePrice
FROM
    "Nashville Housing"
WHERE
     SalePrice < TotalValue  * 0.8 ;


--CREATE A VIEW OF PROPERTIES SOLD IN THE LAST 5 YEARS :

CREATE VIEW RECENT_SALES
AS
  SELECT 
        *
  FROM 
      [Nashville Housing]
  WHERE
     SaleDate > DATEADD(YEAR,-5,GETDATE()) ;

--CALLING THE VIEW

SELECT * FROM RECENT_SALES ;

SELECT * FROM RECENT_SALES
WHERE SalePrice > 30000;


--[CALULATE THE APPRECIATION : COMPARE SALE PRICES OF PROPERTIES THAT WERE SOLD MORE THAN ONCE:

SELECT
     ParcelID
	 ,MAX(SALEPRICE)AS LATESTSALEPRICE
	 ,MIN(SALEPRICE)AS FIRSTSALEPRICE
	 ,(MAX(SALEPRICE) - MIN(SALEPRICE)) 
	 AS APPRECIATION
FROM
    "Nashville Housing"
GROUP BY
     ParcelID
HAVING
     COUNT(*) > 1 ;


/* WRITE A QUERY TO CALCULATE THE CUMULATIVE TOTAL OF THE SALE PRICE FOR EACH PROPERTY ADDRESS OVERTIME,
BY PARCELID AND SORT BY SALEDATE */

SELECT
    UniqueID
	,PropertyAddress
	,SalePrice
	,SaleDate
	,SUM(SalePrice)
	OVER(PARTITION BY ParcelID
	ORDER BY SaleDate) AS 
	'CUMULATIVE TOTAL'
FROM
   "Nashville Housing"
;


/* FOR EACH PROPERTY CALCULATE THE DIFFRENCE IN SALEPRICE BETWEEN THE CURRENT SALE AND THE PREVIOUS SALE
FOR THE SAME PARCELID */

SELECT
    UniqueID
	,SaleDate
	,SalePrice
	,SalePrice - LAG(SalePrice,1)
	OVER(PARTITION BY ParceLID
	ORDER BY SaleDate)
	AS 'Price Difference'
FROM
   "Nashville Housing"
    


--FIND THE PROPERTIES WHERE THE SALEPRICE IS GREATER THAN THE AVERAGE SALE PRICE OF ALL PROPERTIES :

SELECT
     UniqueID
	 ,SalePrice
	 ,PropertyAddress
FROM
   "Nashville Housing"
WHERE
    SalePrice > (
	             SELECT
				     AVG(SalePrice)
				 FROM
				     "Nashville Housing"
				)


--WRITE A QUERY TO FIND THE TOP 5 MOST EXPENSIVE PROPERTY BASED ON TOTAL VALUE .

SELECT
	  UNIQUEID
	  ,SALEPRICE
FROM
     "Nashville Housing"
WHERE
     PARCELID IN (
	          SELECT
			      PARCELID
			  FROM
			       (
	                SELECT
					    PARCELID
						,TOTALVALUE
						,RANK() OVER(
						ORDER BY TOTALVALUE)
						AS RANKS
					FROM
					    "Nashville Housing"
				) AS RANKED
			WHERE 
			    RANKS <= 5
	);

	SELECT * FROM
	"Nashville Housing"

/* WRITE A QUERY TO JOIN THE TABLE WITH ITSELF TO FIND THE PROPERTIES THAT HAVE BEEN
SOLD MULTIPLE TIMES . RETURNS PARCELID,PROPERTY ADDRESS AND THE COUNT OF SALES FOR EACH
PROPERTY */

    
SELECT 
    N1.PARCELID
    ,N1.PROPERTYADDRESS
    ,COUNT(N2.SALEDATE)
	AS [SALES COUNT]
FROM
    [Nashville Housing] 
	AS N1
JOIN
    [Nashville Housing]
	AS N2
ON
    N1.PARCELID = N2.PARCELID
GROUP BY
    N1.PARCELID
    ,N1.PROPERTYADDRESS
HAVING
    COUNT(N2.SALEDATE) > 1;

/* Write a query that classifies properties into different categories based on their TotalValue. Label them as 'High' for
TotalValue > 1,000,000, 'Medium' for 500,000 to 1,000,000, and 'Low' for anything below 500,000. */

SELECT
     UniqueID
	 ,ParcelID
	 ,SalePrice
	 ,TotalValue
	 ,CASE
	    WHEN TotalValue > 100000 THEN 'HIGH'
		WHEN TotalValue BETWEEN 50000 AND 100000 THEN 'MEDIUM'
		ELSE 'LOW'
	  END AS 
	    CATEGORISATION
FROM
    "Nashville Housing"


--Write a query to label properties as either 'New' or 'Old' based on the YearBuilt. 
--If the property was built after 1990, it should be labeled as 'New'; otherwise, label it as 'Old'.

SELECT
     UniqueID
	 ,ParcelID
	 ,SalePrice
	 ,TotalValue
	 ,YearBuilt
	 ,CASE
	     WHEN YearBuilt > 1990 THEN 'NEW'
		 ELSE 'OLD'
	 END AS
	     LABELS
FROM
    "Nashville Housing"


--Write a query to calculate the average SalePrice for properties that have been sold multiple times. 
--Use a subquery to first identify the properties with multiple sales.

SELECT 
     AVG(SalePrice) AS
	 'AVERAGE SALE PRICE'
FROM
    "Nashville Housing"
WHERE
     UniqueID IN (
                   SELECT 
				       UniqueID
                   FROM
                      "Nashville Housing"
                   GROUP BY
				       UniqueID
				   HAVING
                      COUNT(SALEDATE) > 1
	);


/* Write a query that calculates the total LandValue for each TaxDistrict but only includes properties
where the SalePrice is greater than 30,000.Additionally, classify the total LandValue into 'High' or 
'Low' based on whether it's greater than 5,00,000. */

SELECT 
    UniqueID
	,ParcelID
	,SUM(LandValue) AS 
	'TOTAL LAND VALUE'
	,TaxDistrict
	,CASE
	    WHEN SUM(LandValue) > 500000
		    THEN 'HIGH'
		ELSE
		    'LOW'
	 END AS
	     LANDVALUECATEGORY	
FROM
   "Nashville Housing"
WHERE
    SalePrice > 30000
GROUP BY
    TaxDistrict
	,UniqueID
	,ParcelID
;


     





