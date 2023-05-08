use adventureworks;
-- 1. Obtain a list of the purchase volume (quantity) per year and shipping method, showing for each record
-- the percentage it represents of the total for the year. Solve using subqueries and window functions,
-- and then compare the difference in query execution time.


select B.Anio, SM.Name, sum(A.QtyAcum) Acum, C.AcumAnio, (sum(A.QtyAcum)/C.AcumAnio)*100 Prcnt 
from (select SalesOrderID, sum(OrderQty) QtyAcum from salesorderdetail group by SalesOrderID) A
join (select SalesOrderID, year(OrderDAte) Anio, ShipmethodID from salesorderheader) B on A.SalesOrderID = B.SalesOrderID
join shipmethod SM on B.ShipMethodID = SM.ShipMethodID
join (select year(SOH.OrderDate) Anio, sum(SOD.OrderQty) AcumAnio from salesorderheader SOH
	join salesorderdetail SOD on SOH.SalesOrderID = SOD.SalesOrderID
	group by Anio) C on B.Anio = C.Anio
group by B.Anio, SM.Name
;


-- 2. Get a list by product category with the total sales value and products sold, 
--showing for both, their percentage of the total.

select Categoria, 
Vtas, round(Vtas/sum(Vtas) over () *100,2) as Porcentaje_Vtas,
PV, round(PV/sum(PV) over () *100, 2) as Porcentaje_PV
from ( Select
	PC.Name Categoria, round(sum(SOD.LineTotal),2) Vtas, sum(SOD.OrderQty) PV 
	from salesorderdetail SOD
	join product P on SOD.ProductID = P.ProductID
	join productsubcategory PSC on P.ProductSubcategoryID = PSC.ProductSubcategoryID
	join productcategory PC on PSC.ProductCategoryID = PC.ProductCategoryID
	group by PC.Name) A;



-- 3. Obtain a list by country (based on shipping address), with the total sales value and products sold,
-- showing for both their percentage relative to the total.

select Pais, 
Total_Vtas, round(Total_Vtas/sum(Total_Vtas) over () * 100,2) P_Vtas, 
Total_Prdct, round(Total_Prdct/sum(Total_Prdct) over () * 100,2) P_Prdct  
from(
	select CR.Name Pais, round(sum(SOD.LineTotal),2) Total_Vtas, sum(SOD.OrderQty) Total_Prdct
	from salesorderheader SOH
	join salesorderdetail SOD on SOD.SalesOrderID = SOH.SalesOrderID
	join stateprovince SP on SOH.TerritoryID = SP.TerritoryID
	join countryregion CR on SP.CountryRegionCode = CR.CountryRegionCode
	group by CR.Name) A 
order by Pais asc;


-- 4. Create a view with the names of the contacts whose products belong to the "Mountain Bikes" subcategory, 
-- using the "Cargo Transport 5" ship method between the years 2000 and 2003.
create view contacts as
select distinct C.FirstName, C.LastName
from salesorderheader SOH
join shipmethod SM on SOH.ShipMethodID = SM.ShipMethodID
join salesorderdetail SOD on SOD.SalesOrderID = SOH.SalesOrderID
join product P on SOD.ProductID = P.ProductID
join productsubcategory PSB on PSB.ProductSubcategoryID = P.ProductSubcategoryID
join contact C on SOH.ContactID = C.ContactID
where
SM.Name = 'CARGO TRANSPORT 5' and
PSB.Name = 'Mountain Bikes' and
year(SOH.OrderDate) BETWEEN 2000 and 2003;

-- See the view
select * from contacts;