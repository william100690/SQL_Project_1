use adventureworks;

-- 1. Obtain a list of contacts who have ordered products from the "Mountain Bikes" subcategory,
-- between 2000 and 2003, whose shipping method is "CARGO TRANSPORT 5".


select C.ContactID, C.FirstName, C.LastName,  count(SOD.SalesOrderDetailID) Ordenes
from salesorderheader SOH
join contact C on SOH.ContactID = C.ContactID
join salesorderdetail SOD on SOH.SalesOrderID = SOD.SalesOrderID
join product P on SOD.ProductID = P.ProductID
join productsubcategory PS on P.ProductSubcategoryID = PS.ProductSubcategoryID
join shipmethod SM on SOH.ShipMethodID = SM.ShipMethodID
where 
PS.Name = 'Mountain Bikes' and
year(SOH.OrderDate) between 2002 and 2003 and
SM.Name = 'CARGO TRANSPORT 5'
group by (C.ContactID)
order by FirstName asc;


-- 2. Obtain a list of contacts who have ordered products from the "Mountain Bikes" subcategory,
-- between 2000 and 2003, with the quantity of products purchased and ordered by this value, in descending order.
select C.ContactID, C.FirstName, C.LastName,  sum(SOD.OrderQty) Productos
from salesorderheader SOH
join contact C on SOH.ContactID = C.ContactID
join salesorderdetail SOD on SOH.SalesOrderID = SOD.SalesOrderID
join product P on SOD.ProductID = P.ProductID
join productsubcategory PS on P.ProductSubcategoryID = PS.ProductSubcategoryID
join shipmethod SM on SOH.ShipMethodID = SM.ShipMethodID
where 
PS.Name = 'Mountain Bikes' and
year(SOH.OrderDate) between 2002 and 2003
group by (C.ContactID)
order by Productos desc;


-- 3. Obtain a list of the purchase volume (quantity) by year and shipping method.

select year(SOH.OrderDate) Año_, SM.Name, sum(SOD.OrderQty)
from salesorderheader SOH
join contact C on SOH.ContactID = C.ContactID
join salesorderdetail SOD on SOH.SalesOrderID = SOD.SalesOrderID
join product P on SOD.ProductID = P.ProductID
join productsubcategory PS on P.ProductSubcategoryID = PS.ProductSubcategoryID
join shipmethod SM on SOH.ShipMethodID = SM.ShipMethodID
group by year(SOH.OrderDate), SM.Name;


-- 4. Obtain a list by product category, with the total sales value and products sold.

select PC.Name, sum(SOD.LineTotal), sum(SOD.OrderQty)
from salesorderheader SOH
join salesorderdetail SOD on SOH.SalesOrderID = SOD.SalesOrderDetailID
join product P on SOD.ProductID = P.ProductID
join productsubcategory PSC on P.ProductSubcategoryID = PSC.ProductSubcategoryID
join productcategory PC on PSC.ProductCategoryID = PC.ProductCategoryID
group by PC.Name
order by PC.Name;


-- 5. Obtain a list by country (according to the shipping address), with the total sales value and products sold,
-- only for those countries where more than 15 thousand products were shipped.
	
select * from salesorderheader;
select * from salesorderdetail;
select * from address;
select * from stateprovince;
select * from countryregion;	

select CR.Name, sum(SOD.LineTotal), sum(SOD.OrderQty)
from salesorderheader SOH
join salesorderdetail SOD on SOH.SalesOrderID = SOD.SalesOrderID
join address A on SOH.ShipToAddressID = A.AddressID
join stateprovince SP on A.StateProvinceID = SP.StateProvinceID
join countryregion CR on SP.CountryRegionCode = CR.CountryRegionCode
group by (CR.Name)
having sum(SOD.OrderQty) > 15000;