--Geciken Urunler" ortalama kaç gün geciktiğini bulan sorguyu yazınız.

SELECT 
    AVG(DATEDIFF(DAY, RequiredDate, ShippedDate)) AS OrtalamaGecikmeGun 
    FROM Orders
WHERE 
    DATEDIFF(DAY, RequiredDate, ShippedDate) > 0;

--"Erken Giden Urunler" in ortalama kaç gün erken gittiğini bulan sorguyu yazınız.

SELECT 
    AVG(DATEDIFF(DAY, RequiredDate, ShippedDate)) * -1 AS ErkenGonderimGun 
    FROM Orders
WHERE 
    DATEDIFF(DAY, RequiredDate, ShippedDate) < 0;

--CustomerID bazında Toplam Ne Kadar Gelir elde edildiğini gösteren tabloyu getiren sorguyu yazınız. - Monetary
SELECT Customer_ID, 
    SUM(Quantity * Price) as Monetary
FROM retail_II
GROUP BY Customer_ID
HAVING Customer_ID IS NOT NULL
ORDER BY Monetary DESC

--CustomerID bazında 2011.12.30 tarihine göre Recency değerlerini gösteren tabloyu oluşturacak sorguyu yazınız.

SELECT 
    Customer_ID,
    MAX(InvoiceDate) as SonSiparisTarihi,
    DATEDIFF(DAY, MAX(InvoiceDate), '2011.12.30') as Recency
FROM retail_II
GROUP BY Customer_ID
ORDER BY Recency DESC;

--Ülke bazında en fazla satın alınan ürünlerin Toplam Cirosu nu gösteren tabloyu oluşturacak sorguyu yazınız.ÖDEV 1

SELECT 
    Country,
    [Description],
    ToplamSatis,
    ROUND(Ciro, 2) as Ciro
FROM
    (
        SELECT 
            Country, 
            [Description],
            SUM(Quantity) as ToplamSatis,
            SUM(Quantity * Price) as Ciro,
            ROW_NUMBER() OVER (PARTITION BY Country ORDER BY SUM(Quantity) DESC) as RANK
        FROM retail_II
        GROUP BY Country, [Description]
    ) T
WHERE RANK = 1
ORDER BY 4 DESC
