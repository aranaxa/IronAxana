# 1. Write a SELECT statement that lists the customerid along with their account number, type, the city the customer lives in and their postalcode.
SELECT 
	c.CustomerID,  
    c.AccountNumber, 
    c.CustomerType, 
    a.City,
    a.PostalCode
FROM customer c
JOIN customeraddress ca
USING(CustomerID)
JOIN address a
USING(AddressID);

# 2. Write a SELECT statement that lists the 20 most recently launched products, their name and colour
SELECT 
	Name,
    ProductNumber,
    Color,
    SellStartDate
FROM product
ORDER BY SellStartDate DESC
LIMIT 20;

# 3. Write a SELECT statement that shows how many products are on each shelf in 2/5/98
SELECT 
	Shelf,
    COUNT(DISTINCT ProductID)
FROM productinventory
WHERE ModifiedDate = DATE("1998-05-02")
GROUP BY Shelf; 

# 4. I am trying to track down a vendor email address… his name is Stuart and he works at G&K Bicycle Corp. Can you help?
SELECT 
	c.FirstName,
    c.LastName,
    c.EmailAddress,
    v.Name
FROM vendor v
JOIN vendorcontact vc
USING(VendorID)
JOIN contact c
USING(ContactID)
WHERE c.FirstName = "Stuart"
AND v.Name = "G & K Bicycle Corp.";

# 5.1 What’s the total sales tax amount for sales to Germany? 
SELECT 
	st.CountryRegionCode,
    soh.TerritoryID,
    SUM(soh.TaxAmt) AS TotalTaxAmt
FROM salesorderheader soh
JOIN salesterritory st
USING(TerritoryID)
WHERE st.CountryRegionCode = "DE"
GROUP BY 1, 2;

# 5.2 What’s the top region in Germany by sales tax?
SELECT 
	sp.Name AS RegionName,
    SUM(soh.TaxAmt) AS TotalTaxAmt
FROM salesorderheader soh
JOIN salesterritory st
USING(TerritoryID)
JOIN address a
ON a.AddressId = soh.BillToAddressID
JOIN stateprovince sp
USING(StateProvinceID)
WHERE st.CountryRegionCode = "DE"
GROUP BY 1
ORDER BY 2 DESC;

# 6. Summarise the distinct # transactions by month
SELECT 
	MONTH(TransactionDate) AS Month,
    YEAR(TransactionDate) AS Year,
	COUNT(DISTINCT TransactionID) AS NumTransactions
FROM transactionhistory
GROUP BY 1, 2
ORDER BY 2, 1;

# 7. Which (if any) of the sales people exceeded their sales quota this year and last year?
SELECT 
	s.SalesPersonID,
    c.FirstName,
    c.LastName,
    s.SalesQuota,
    s.SalesYTD,
    s.SalesLastYear
FROM salesperson s
JOIN employee e
ON s.SalesPersonID = e.EmployeeID
JOIN contact c
USING(ContactID)
WHERE s.SalesQuota < s.SalesYTD
AND s.SalesQuota < s.SalesLastYear;

# 8. Do all products in the inventory have photos in the database and a text product description?
SELECT 
	COUNT(DISTINCT ProductID) AS NumProducts
FROM product;

SELECT 
	COUNT(DISTINCT ProductPhotoID) AS NumProductPhotos
FROM productphoto;

SELECT
    SUM(CASE WHEN pd.ProductDescriptionID IS NULL THEN 1 END) AS NumMissingProductDescriptions
FROM product p
LEFT JOIN productmodel pm
USING(ProductModelID)
LEFT JOIN productmodelproductdescriptionculture pmp
USING(ProductModelID)
LEFT JOIN productdescription pd
USING(ProductDescriptionID)
;

# 9. What's the average unit price of each product name on purchase orders which were not fully, but at least partially rejected?
SELECT 
	po.ProductID,
    p.Name,
    #po.OrderQty,
    #po.RejectedQty,
    AVG(UnitPrice)
FROM purchaseorderdetail po
JOIN product p
USING(ProductID)
WHERE po.OrderQty > po.RejectedQty
AND po.RejectedQty >= 1
GROUP BY 1, 2;

# 10. How many engineers are on the employee list? Have they taken any sickleave?
SELECT 
	COUNT(EmployeeID) AS NumEngineers
FROM employee
WHERE Title LIKE "%Engineer%";

SELECT 
	EmployeeID,
    Title,
    SickLeaveHours
FROM employee
WHERE Title LIKE "%Engineer%";

# 11. How many days difference on average between the planned and actual end date of workorders in the painting stages?
SELECT
	AVG(DATEDIFF(ActualEndDate, ScheduledEndDate)) AS AvgDateDiff
FROM workorderrouting
JOIN location
USING(LocationID)
WHERE Name IN ("Paint", "Specialized Paint");