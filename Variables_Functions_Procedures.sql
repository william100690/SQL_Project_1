use adventureworks;
select * from salesorderheader limit 10;

select * from salesorderheader;
-- 1. Crear un procedimiento que recibe como parametro una fecha y muestre la cantidad de ordenes ingresadas en esa fecha.
-- 1. 
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

-- 2. Crear una función que calcule el valor nominal de un margen bruto determinado por el usuario a partir del precio de lista de los productos.
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


-- 3. Obtner un listado de productos en orden alfabético que muestre cuál debería ser el valor de precio de lista, 
-- si se quiere aplicar un margen bruto del 20%, utilizando la función creada en el punto 2, sobre el campo StandardCost. 
-- Mostrando tambien el campo ListPrice y la diferencia con el nuevo campo creado.

select ProductID, Name, ProductNumber,StandardCost,ListPrice, 
margen_bruto(StandardCost, 1.2), Listprice - margen_bruto(StandardCost, 1.2) as diferencia 
from product where ListPrice >0 order by(name) asc;


-- 4. Crear un procedimiento que reciba como parámetro una fecha desde y una hasta, 
-- y muestre un listado con los Id de los diez Clientes que más costo de transporte 
-- tienen entre esas fechas (campo Freight).
select * from salesorderheader;
select CustomerID, sum(Freight) from salesorderheader group by (CustomerID);
drop procedure buscar_por_fechas;

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


-- 5. Crear un procedimiento que permita realizar la insercción de datos en la tabla shipmethod.
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
