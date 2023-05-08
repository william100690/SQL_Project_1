use adventureworks;
select * from salesorderheader limit 10;

select * from salesorderheader;
-- 1. Create a procedure that receives a date parameter and shows the number of orders entered on that date.
Delimiter //
Create procedure buscar_por_fecha (IN fecha date)
begin
	select * 
	from salesorderheader 
	where 
	date(OrderDate) = fecha;
end;
delimiter//

call buscar_por_fecha('2001-06-30');

-- 2. Create a function that calculates the face value of a
-- gross margin determined by the user based on the list price of the products.
select * from product where ListPrice > 0;

Delimiter //
create function margen_bruto (Precio_Lista decimal(15,3), Margen_usuario decimal(15,3)) returns decimal(15,3) deterministic
begin
	declare mrgn_bruto decimal(15,3);
    set mrgn_bruto = Precio_lista * Margen_usuario;
	return mrgn_bruto;
END //
Delimiter ;

select *, margen_bruto(ListPrice, 0.8) from product where ListPrice >0;


-- 3. Obtain a list of products in alphabetical order that shows what the list price should be 
-- if a gross margin of 20% is to be applied, using the function created in point 2 on the StandardCost field.
-- Also, display the ListPrice field and the difference with the new field created.

select ProductID, Name, ProductNumber,StandardCost,ListPrice, 
margen_bruto(StandardCost, 1.2), Listprice - margen_bruto(StandardCost, 1.2) as diferencia 
from product where ListPrice >0 order by(name) asc;


-- 4. Create a procedure that receives a from date and a to date parameter,
-- and shows a list with the IDs of the ten customers with the highest transportation costs
-- between those dates (Freight field).
select * from salesorderheader;
select CustomerID, sum(Freight) from salesorderheader group by (CustomerID);

Delimiter //
create procedure buscar_por_fechas(IN fecha_desde date, IN fecha_hasta date)
begin
	select CustomerID, sum(Freight) 
	from salesorderheader
    Where 
    date(orderDate) between  fecha_desde and fecha_hasta
    group by CustomerID
    order by sum(Freight) desc
    limit 10;	
end;
Delimiter//


call buscar_por_fechas('2001-08-01','2001-08-30');


-- 5. Create a procedure that allows inserting data into the shipmethod table.
select * from shipmethod;

delimieter //
create procedure 
Insertar_en_shipmethod
(in Ship_MethodID int, in Name_ varchar(25), in Ship_Base decimal(15,2), in Ship_Rate decimal(15,2), in rowguid_ int, in Modified_Date date)

Begin
	insert into shipmethod
	values
    (Ship_MethodID, Name_, Ship_Base, Ship_Rate, rowguid_, Modified_Date);
End;
Delimiter //

Delimiter //
create procedure Cargar_en_shipmethod(in Nombre varchar(20), in Ship_Base float, in Ship_Rate float)
begin
	insert into shipmethod (Name, ShipBase, ShipRate, ModifiedDate)
    values (Nombre, Ship_Base, Ship_Rate, now());
End;
Delimiter//
