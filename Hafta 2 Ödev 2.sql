--Bugün tarihi 1.1.2012

SELECT * FROM RFM_YAC

CREATE TABLE RFM_YAC (
    CUSTOMER_ID VARCHAR(20),
    LastInvoiceDate DATETIME,
    FirstInvoiceDate DATETIME,
    Tenure INT,
    Monetary INT,
    Basket_Size FLOAT,
    Frequance INT,
    Recency INT
);

INSERT INTO RFM_YAC (CUSTOMER_ID)
SELECT DISTINCT Customer_ID FROM retail_II

--LastInvoiceDate

UPDATE RFM_YAC SET LastInvoiceDate = (
    SELECT MAX(InvoiceDate) 
    FROM retail_II r
    WHERE r.Customer_ID = RFM_YAC.CUSTOMER_ID
)

--FirstInvoiceDate

UPDATE RFM_YAC SET FirstInvoiceDate = (
    SELECT MIN(InvoiceDate) 
    FROM retail_II r
    WHERE r.Customer_ID = RFM_YAC.CUSTOMER_ID
)

--1. Tenure’ ü hesaplayınız.

UPDATE RFM_YAC SET Tenure = DATEDIFF(DAY, FirstInvoiceDate, '01.01.2012')


--2. Monetary’ yi hesaplayınız.

UPDATE RFM_YAC SET Monetary = (
    SELECT SUM(Quantity * Price) 
    FROM retail_II r
    WHERE r.Customer_ID = RFM_YAC.CUSTOMER_ID
)

--3. Basket Size’ı bulunuz.

UPDATE RFM_YAC SET Basket_Size = (Monetary / Frequance)

--4. Frequance’ ı bulunuz.

UPDATE RFM_YAC SET Frequance = (
    SELECT COUNT(DISTINCT Invoice)
    FROM retail_II r
    WHERE r.Customer_ID = RFM_YAC.CUSTOMER_ID
)

--5. Recency’yi bulunuz

UPDATE RFM_YAC SET Recency = DATEDIFF(DAY, LastInvoiceDate, '01.01.2012')
    

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--


--1. Tenure’ ü hesaplayınız.

SELECT 
    Customer_ID,
    DATEDIFF (DAY, '1.1.2012' , MIN(InvoiceDate)) * -1 as Tenure
FROM retail_II
GROUP BY Customer_ID, InvoiceDate
ORDER BY Tenure DESC


--2. Monetary’ yi hesaplayınız.

SELECT 
    Customer_ID,
    SUM(ROUND(Quantity * Price,0,1)) as Monetary
 FROM retail_II
 GROUP BY 
    Customer_ID,
    ROUND(Quantity * Price,0,1)
ORDER BY Monetary DESC



--3. Basket Size’ı bulunuz.

SELECT 
    Customer_ID,
    ROUND(SUM(Quantity * Price),0) AS TotalAmount,
    COUNT(DISTINCT Invoice) AS TotalOrders,
    ROUND(SUM(Quantity * Price) * 1.0 / (COUNT(DISTINCT Invoice)),0) AS BasketSize
FROM retail_II
GROUP BY Customer_ID
ORDER BY BasketSize DESC


--4. Frequance’ ı bulunuz.
       
SELECT 
    Customer_ID,
    COUNT(DISTINCT Invoice) as AlisverisSayisi,
    DATEDIFF (DAY, '1.1.2012' , MIN(InvoiceDate)) * -1 as Tenure,
    (DATEDIFF (DAY, '1.1.2012' , MIN(InvoiceDate)) * -1) / COUNT(DISTINCT Invoice) as Frequance
FROM retail_II
GROUP BY Customer_ID
HAVING Customer_ID IS NOT NULL
ORDER BY Frequance ASC

--5. Recency’yi bulunuz

SELECT 
    Customer_ID,
    DATEDIFF (DAY, '1.1.2012' , MAX(InvoiceDate)) * -1 as Recency
FROM retail_II
GROUP BY Customer_ID, InvoiceDate
ORDER BY Recency ASC