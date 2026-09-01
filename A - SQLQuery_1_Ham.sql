-- 1.FLO tablosunu getirecek sorguyu yazınız.
SELECT * FROM flo;


-- 2.Kaç farklı müşterinin alışveriş yaptığını gösterecek sorguyu yazınız.
SELECT COUNT(DISTINCT master_id) as MusteriSayisi from flo;

-- 3.Toplam yapılan alışveriş adedini ve ciroyu getirecek sorguyu yazınız.

SELECT
SUM(order_num_total_ever_online + order_num_total_ever_offline) as Satislar,
SUM(customer_value_total_ever_offline + customer_value_total_ever_online) as Cirolar
FROM flo;


-- 4.Alışveriş başına ortalama ciroyu getirecek sorguyu yazınız.
SELECT
(SUM(customer_value_total_ever_offline + customer_value_total_ever_online))
/ (SUM(order_num_total_ever_online + order_num_total_ever_offline)) as Average_Reveneu
FROM flo;



--5.En son alışveriş yapılan kanal (last_order_channel) üzerinden yapılan alışverişlerin toplam ciro ve alışveriş sayılarını getirecek sorguyu yazınız.
SELECT
last_order_channel,
SUM(order_num_total_ever_online + order_num_total_ever_offline) as Satislar,
SUM(customer_value_total_ever_offline + customer_value_total_ever_online) as Cirolar
FROM flo
GROUP BY last_order_channel;


-- 6. YIL kırılımında alışveriş sayılarını getirecek sorguyu yazınız (Yıl olarak müşterinin ilk alışveriş tarihi (first_order_date) yılını baz alınız).
SELECT
YEAR(first_order_date) SatisYili,
SUM(order_num_total_ever_online + order_num_total_ever_offline) as Satislar
FROM flo
GROUP BY YEAR(first_order_date)
ORDER BY SatisYili;


-- 7.En son alışveriş yapılan kanal kırılımında alışveriş başına ortalama ciroyu hesaplayacak sorguyu yazınız.
SELECT
last_order_channel,
(SUM(customer_value_total_ever_offline + customer_value_total_ever_online))
/ (SUM(order_num_total_ever_online + order_num_total_ever_offline)) as Average_Reveneu
FROM flo
GROUP BY last_order_channel;

-- 8.Online ve offline alışveriş yapan müşterilerin toplam cirolarını ayrı ayrı getiren sorguyu yazınız. 
--İpucu: SQL Başlıkları ”customer_value_total_ever_offline” , “customer_value_total_ever_online” 
SELECT
master_id,
SUM(customer_value_total_ever_offline)as 'Offline',
SUM(customer_value_total_ever_online) as 'Online'
FROM flo
GROUP BY master_id;


-- 9.FLO tablosundaki master_id ve order_channel kolonlarını getiren sorguyu yazınız.
SELECT
master_id,
order_channel
FROM flo

-- 10.FLO tablosundan 'Offline' olmayan sipariş kanalına sahip kayıtları getiren sorguyu yazınız.

SELECT
*
FROM flo
WHERE order_channel != 'Offline';

-- 11.FLO tablosundan sipariş kanalı 'Offline' olmayan ve online alışverişlerinde ödediği toplam ücret 1000'den fazla olan kayıtları getiren  sorguyu yazınız.
SELECT
*
FROM flo
WHERE order_channel != 'Offline' AND customer_value_total_ever_online > 1000;

-- 12.FLO tablosundan alışveriş yapılan platforma ait sipariş kanalı ‘Mobile‘ olan, 
-- online ve offline alışveriş yapan müşterilerin toplam cirolarını getiren sorguyu yazınız.
SELECT
ROUND(SUM(customer_value_total_ever_online),3) AS OnlineCiro,
ROUND(SUM(customer_value_total_ever_offline),3) AS OfflineCiro
FROM flo
WHERE order_channel = 'Mobile';



-- 13.«interested_in_categories_12» kategorisi içerisinde “SPOR” geçen verileri getirecek sorguyu yazınız.
SELECT
*
FROM flo
WHERE interested_in_categories_12 LIKE '%SPOR%'



-- 14.Müşterinin offline alışverişlerinde ödediği ücretin 0 ile 10.000 arasında olduğu kayıtları getiren sorguyu yazınız.
SELECT
*
FROM flo
WHERE customer_value_total_ever_offline BETWEEN 0 and 10000;

-- 15. interested_in_categories_12 ve order_channel bazında online sipariş adetlerini toplayan sorguyu yazınız.
SELECT
interested_in_categories_12,
order_channel,
SUM(order_num_total_ever_online) as OnlineSiparis
FROM flo
GROUP BY interested_in_categories_12, order_channel
ORDER BY interested_in_categories_12;

-- 16.En son alışveriş yapılan kanal (last_order_channel) bazında, 
-- her bir  kategoriden(interested_in_categories_12) kaç adet alışveriş yapıldığını getiren sorguyu yazınız 
-- ve adet sayısına göre büyükten küçüğe doğru sıralayanız.

SELECT
last_order_channel, interested_in_categories_12,SUM(order_num_total_ever_online + order_num_total_ever_offline) as Toplam
FROM flo
GROUP BY last_order_channel, interested_in_categories_12
ORDER BY Toplam DESC;


-- 17.En çok alışveriş yapan 50 kişinin ID’ sini getiren sorguyu yazınız.
SELECT TOP 50 master_id, order_num_total_ever_online + order_num_total_ever_offline as Av_Adet
FROM flo
ORDER BY Av_Adet DESC;

-- 18.First Order Date e göre yıl bazında müşteri sayısını getiren sorguyu yazınız.
SELECT YEAR(first_order_date) as yil, COUNT(master_id) as MüsteriAdet
FROM flo
GROUP BY YEAR(first_order_date);

-- 19.Last order date i 2020 olan müşterilerin sayısını getiren sorguyu yazınız.
SELECT COUNT(master_id) as MüsteriSayisi
FROM flo
WHERE YEAR(last_order_date) = 2020;

-- 20.Sadece [AKTIFSPOR] dan alışveriş yapmış kişilerin Order Channel’larını sağ tarafa kolon olarak ekleyen sorguyu yazınız.
SELECT
master_id, interested_in_categories_12, order_channel
FROM flo
WHERE interested_in_categories_12 = '[AKTIFSPOR]';

-- 21. İçerisinde [AKTIFSPOR] dan alışveriş yapmış kişilerin Order Channel’larını sağ tarafa kolon olarak ekleyen sorguyu yazınız.

SELECT
master_id, interested_in_categories_12, order_channel
FROM flo
WHERE interested_in_categories_12 LIKE '%AKTIFSPOR%';


-- 22.2018/2019 arası her ay yeni gelen müşteri sayısını yıl ve ay kolonları ile birlikte getiren sorguyu yazınız.
SELECT YEAR(first_order_date) YIL, MONTH(first_order_date) AY, COUNT(DISTINCT master_id) MüsteriSayisi
FROM flo
WHERE YEAR(first_order_date) BETWEEN 2018 AND 2019
GROUP BY YEAR(first_order_date), MONTH(first_order_date)
ORDER BY YIL, AY;

-- 23.Order_channel'da 'Mobile' veya 'Desktop' siparişlerinde interested_in_categories_12 de 'AKTIFSPOR' olmayan kayıtları getiren sorguyu yazınız.
SELECT
*
FROM flo
WHERE order_channel IN ('Mobile','Desktop')
AND interested_in_categories_12 NOT LIKE '%AKTIFSPOR%';

-- 24.Order_channel'da 'Mobile' veya 'Desktop' siparişlerin kayıtlarını getiren sorguyu yazınız.
SELECT
*
FROM flo
WHERE order_channel IN ('Mobile','Desktop');

 --25 Onlinedaki en çok siparişin olduğu(first_order_date) ay ı ve bu aydaki toplam siparişi(ciro) getiren sorguyu yazınız.

SELECT TOP 1 YEAR(first_order_date) as Yıl, MONTH(first_order_date) as Month, SUM(customer_value_total_ever_online) as OnlineCiro 
FROM flo
GROUP BY YEAR(first_order_date), MONTH(first_order_date)
ORDER BY OnlineCiro DESC


--Aşağıdaki soruları Northwind database içerisinde yapınız.

-- 26. Müşteriler ve onların verdiği siparişleri listeyecek sorguyu inner join ile yazınız.
SELECT * from Customers
SELECT * from Orders

SELECT * 
FROM Customers c 
INNER JOIN Orders o
ON C.CustomerID = O.CustomerID 


-- 27. Müşteriler ve onların verdiği siparişlerin detaylarını listeyecek sorguyu left join ile yazınız.

SELECT * 
FROM Customers c 
LEFT JOIN Orders o
ON C.CustomerID = O.CustomerID 

-- 28. Müşteriler ve onların verdiği siparişlerin detaylarını listeyecek sorguyu right join ile yazınız.

SELECT
*
FROM flo













