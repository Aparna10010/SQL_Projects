-- Creating DataBase
Create Database Retail_Sales_Analysis ;

--Using the created db
Use Retail_Sales_Analysis ;

-- To get Overview of the data
Select * From Online_Retail_sales
 

--Data Cleaning -- 

--Checking For the missing ColumnIDs
Select *
From 
   Online_Retail_sales
Where
   CustomerID is Null ;

 -- Deleting these null Columnids
 Delete From 
      Online_Retail_sales
Where 
    CustomerID is Null ;


--Checking for the Negative Quantity values And Unit Price:
Select
     *
From
    Online_Retail_sales
Where
    Quantity < 0 ;
--For Unit Price:
Select
     *
From
    Online_Retail_sales
Where
    UnitPrice < 0;

--Checking for the Duplicate Values:
Select 
     InvoiceNo
	 ,StockCode
	 ,Quantity
	 ,Count(*) As DuplicateCount
From
   Online_Retail_sales
Group By
    InvoiceNo
	,StockCode
	,Quantity
Having 
    Count(*) > 1 ;

--Removing Duplicates:
With CTE As (
        Select 
		   *,
		   ROW_NUMBER() Over(Partition By InvoiceNo , StockCode , Quantity 
		   Order By (Select Null)) As RN
		From 
		    Online_Retail_sales
	)

Delete From CTE
Where RN > 1;


-- Checking if dates are invalid or any future dates are there
Select *
From
   Online_Retail_sales
Where
   InvoiceDate > GetDate();

--Getting All the Unique Countries available:

Select
    Distinct Country
From
    Online_Retail_sales
Order By 
    Country;

-- What is total sales revenue by country?
Select 
   Country
   ,Round(Sum(UnitPrice * Quantity),2)
   As TotalSalesRevenue
From
   Online_Retail_sales
Group By
   Country
Order By
   TotalSalesRevenue Desc;


   select * from Online_Retail_sales


-- Find the Total number of Unique Customer:
Select 
     Count(Distinct CustomerID)
	 As Total_Unique_Customers
From
   Online_Retail_sales

-- Top 10 Countries by Sales:
Select
     Top 10 Country
	 ,Sum(Quantity*UnitPrice) As
	 Revenue
From
   Online_Retail_sales
Group By 
   Country
Order By 
   Revenue Desc;


-- What are the top 10 products sold?
Select 
      Top 10 Description
	  ,Sum(Quantity) As
	  Total_Quantity_Sold
From
    Online_Retail_sales
Group By
    Description
	,Quantity
Order By
    Quantity Desc;


--Customer Segmentation: (most frequent buyers):
SELECT 
    TOP 5 
    CustomerID,
    COUNT(*) AS PurchaseCount
FROM 
    Online_Retail_sales
WHERE 
    CustomerID IS NOT NULL
GROUP BY 
    CustomerID
ORDER BY 
    PurchaseCount DESC;

--Monthly Revenue Trends: (Total Sales per Month)
Select
    Format(InvoiceDate , 'yyyy-MM') As
	'Month'
    ,Sum(Quantity*UnitPrice) as 
	TotalRevenue
From
   Online_Retail_sales
Group By
    Format(InvoiceDate , 'yyyy-MM')
Order By
    'Month';
    

-- Find the average basket value per customer:
Select 
     CustomerID
	 ,Round(Avg(Quantity*UnitPrice),2) As
	 AverageBasketVaue
From
   Online_Retail_sales
Where
    CustomerID is not Null
Group By
    CustomerID
Order By
    AverageBasketVaue Desc;


--Products Sold in more than 500 invoices:
Select
      Description
	  ,Count(Distinct InvoiceNo)
	  As InvoiceCount
From
    Online_Retail_sales
Group By
    Description
Having
    Count(Distinct InvoiceNo) > 500
Order By
    InvoiceCount Desc;


--What are Top-3 Products on the basis of revenue per country ?
With ProductRevenue As (
        Select
           Country
           ,Description
	       ,Sum(Quantity * UnitPrice)
	        As Revenue
			,ROW_NUMBER() Over(Partition By Country
			Order By Sum(Quantity * UnitPrice)Desc)
			As Ranked
        From
           Online_Retail_sales
        Group By
           Country
		   ,Description
		)

Select 
    Country
	,Description
	,Revenue
From
    ProductRevenue
Where 
    Ranked <= 3
Order By
    Country
	,Revenue Desc;



--Find the repeat customers (those who made purchase in more than 1 invoice)

Select 
     CustomerID
	 ,InvoiceNo
From
    Online_Retail_sales
Group By
     CustomerID
	 ,InvoiceNo
Having 
    COUNT(Distinct InvoiceNo) > 1;


--Flag all the transactions where the quantity is negative (possible returns or refunds):
Select
    *,
	Case 
	   When Quantity < 0 Then 'Return / Refund'
	   Else 'Normal Sales'
	End as
	   'Transaction_Type'
From
   Online_Retail_sales;


--For each product , rank it within its country based on total revenue using window functions:
With ProductRevenue As (
            Select 
                  Description
	              ,Country
	              ,Sum(Quantity * UnitPrice)
	                As TotalRevenue
             From
                 Online_Retail_sales
             Group By
                  Country
	              ,Description
		)
Select 
     Description
	 ,Country
	 ,TotalRevenue
	 ,Rank() Over(
	            Partition By Country
	            Order By TotalRevenue Desc)
	 As Ranked
From 
    ProductRevenue;