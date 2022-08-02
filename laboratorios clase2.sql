/***********	LABORATORIOS CLASE 2	*************************/
use AdventureWorks2019
go

/*	Distinct
	1) Mostrar los diferentes productos vendidos
	Tablas: Sales.SalesOrderDetail
	Campos: ProductID
*/

select	distinct	ProductID
from				Sales.SalesOrderDetail	

/*	Union
	1) Mostrar TODOS los productos vendidos y ordenados
	Tablas: Sales.SalesOrderDetail, Production.WorkOrder
	Campos: ProductID
	2) Mostrar LOS DIFERENTES productos vendidos y ordenados
	Tablas: Sales.SalesOrderDetail, Production.WorkOrder
	Campos: ProductID
*/

select		ProductID
from		sales.SalesOrderDetail
union 
select		ProductID
from		Production.WorkOrder
order by	ProductID desc

select		ProductID
from		sales.SalesOrderDetail
union all
select		productid
from		Production.WorkOrder

/*	Case
	1) Obtener el id y una columna denominada sexo cuyo valores disponibles sean “Masculino” y ”Femenino”
	Tablas: HumanResources.Employee
	Campos: BusinessEntityID, Gender
*/
select gender from HumanResources.Employee
select		case 
			when Gender='M' then 'Masculino'
			when Gender='F' then 'Femenino' end as Sexo,
			BusinessEntityID as ID
from		HumanResources.Employee		

/*
	2) Mostrar el id de los empleados si tiene salario deberá mostrarse descendente de lo contrario ascendente
	Tablas:HumanResources.Employee
	Campos: BusinessEntityID, SalariedFlag
*/

-- esto está muy mal--
select		BusinessEntityID,
			case when SalariedFlag = 1 then 'descendente'
				 when SalariedFlag = 0 then 'ascendente' end
from		HumanResources.Employee

--esto sí está bien--
select		BusinessEntityID,
			SalariedFlag
from		HumanResources.Employee
order by	SalariedFlag asc,
			case SalariedFlag
			when 1 then businessEntityID end desc,
			case SalariedFlag
			when 0 then businessentityid end asc


/*	Agrupamiento
	1) Mostrar la fecha más reciente de venta
	Tablas: Sales.SalesOrderHeader
	Campos: OrderDate
*/

select		max(OrderDate)
from		Sales.SalesOrderHeader

/*
	2) Mostrar el precio más barato de todas las bicicletas
	Tablas: Production.Product
	Campos: ListPrice, Name
*/

select  	min(listprice) as PrecioMinimo
from		Production.Product

/*
	3) Mostrar la fecha de nacimiento del empleado más joven
	Tablas: HumanResources.Employee
	Campos: BirthDate
*/

select	max(BirthDate)
from	HumanResources.Employee

select		top 1 
			HumanResources.Employee.LoginID,
			HumanResources.Employee.BirthDate
from		HumanResources.Employee
order by	BirthDate desc

/*
	4) Mostrar el promedio del listado de precios de productos
	Tablas: Production.Product
	Campos: ListPrice
*/

select		avg(ListPrice)
from		Production.Product

/*
	5) Mostrar la cantidad y el total vendido por productos
	Tablas: Sales.SalesOrderDetail
	Campos: LineTotal
*/

select		ProductID,
			sum(LineTotal) as TotVendido,
			sum(OrderQty) as CantTot
from		sales.SalesOrderDetail
group by	ProductID
order by	ProductID asc

/*	Agregado, group by
	1) Mostrar el código de subcategoría y el precio del producto más barato de cada una de ellas
	Tablas: Production.Product
	Campos: ProductSubcategoryID, ListPrice
*/

select		Production.Product.ProductSubcategoryID,
			min(Production.Product.ListPrice) as PMinimo
from		Production.Product
group by	ProductSubcategoryID

/*
	2) Mostrar los productos y la cantidad total vendida de cada uno de ellos
	Tablas: Sales.SalesOrderDetail
	Campos: ProductID, OrderQty
*/

select		ProductID,
			sum(orderqty) as CantTotVendida
from		sales.SalesOrderDetail
group by	ProductID
order by	ProductID asc

/*
	3) Mostrar los productos y el total vendido de cada uno de ellos, ordenados por el total vendido
	Tablas: Sales.SalesOrderDetail
	Campos: ProductID, LineTotal
*/

select		ProductID,
			sum(LineTotal) as TotVendido
from		Sales.SalesOrderDetail
group by	ProductID
order by	ProductID desc

/*
	4) Mostrar el promedio vendido por factura.
	Tablas: Sales.SalesOrderDetail
	Campos: SalesOrderID, LineTotal
*/

select		SalesOrderID,
			avg(linetotal) as Promedio
from		Sales.SalesOrderDetail
group by	SalesOrderID
order by	SalesOrderID asc

/*	**** Having ***
	1) Mostrar todas las facturas realizadas y el total facturado de cada una de ellas ordenado por número de factura
	pero sólo de aquellas órdenes superen un total de $10.000
	Tablas: Sales.SalesOrderDetail
	Campos: SalesOrderID, LineTotal
*/

select		SalesOrderID,
			sum(LineTotal) as MontoFactura
from		Sales.SalesOrderDetail
group by	SalesOrderID
--having		sum(LineTotal)>10000
order by	MontoFactura asc

select		SalesOrderID,
			sum(LineTotal) as MontoFactura
from		Sales.SalesOrderDetail
group by	SalesOrderID
having		sum(LineTotal)>10000
order by	SalesOrderID


/*
	2) Mostrar la cantidad de facturas que vendieron más de 20 unidades
	Tablas: Sales.SalesOrderDetail
	Campos: SalesOrderID, OrderQty
*/

select		SalesOrderID,
			sum(orderQty) as CantUVendidas
from		Sales.SalesOrderDetail
group by	SalesOrderID
having		sum(orderQty)>20

/*
	3) Mostrar las subcategorías de los productos que tienen dos o más productos que cuestan menos de $150
	Tablas: Production.Product
	Campos: ProductSubcategoryID, ListPrice
*/
-- query auxiliar para ver que onda la tabla y aislar el productID 4--
select		ProductSubcategoryID,
			ProductID,
			ListPrice
from		Production.Product
where		ListPrice<150 and  ProductSubcategoryID is not null and ProductSubcategoryID = 4
order by	ProductSubcategoryID asc

-- esta es la query posta--
select		ProductSubcategoryID,
			count(ListPrice) as CantProd_min150
from		Production.Product
where		ListPrice<150 and ProductSubcategoryID  is not null
group by	ProductSubcategoryID
having		(COUNT(listPrice)>2)

--3)Mostrar las subcategorías de los productos que tienen dos o más productos que cuestan menos de $150 
--Tablas: Production.Product
--Campos: ProductSubcategoryID, ListPrice
SELECT		ProductSubcategoryID,
			COUNT(ProductSubcategoryID) AS Cantidad
 FROM		Production.Product
-- WHERE		ListPrice>150 -- error en codigo de la plataforma
WHERE		ListPrice<150
 GROUP BY	ProductSubcategoryID
 HAVING		COUNT(ProductSubcategoryID)>2
/*
	4) Mostrar todos los códigos de subcategorías existentes junto con la cantidad para los productos cuyo precio de
	lista sea mayor a $ 70 y el precio promedio sea mayor a $ 300.
	Tablas: Production.Product
	Campos: ProductSubcategoryID, ListPrice
*/
-- query auxiliar para ver que onda la tabla y aislar el PID 14-
select			ProductSubcategoryID,
				count(listprice) as QtyPrecios,
				avg(listprice) as AvPrecio
from			Production.Product
where			ListPrice>70  and ProductSubcategoryID=14
group by		ProductSubcategoryID

-- esta es la query posta --
select		ProductSubcategoryID,
			count(ListPrice) as QtyPrecios,
			avg(ListPrice) as PromPrecios
from		Production.Product
where		ListPrice>70
group by	ProductSubcategoryID
having		(avg(listprice)>300)

/*	Rollup
	1) Mostrar el número de factura, el monto vendido, y al final, totalizar la facturación.
	Tablas: Sales.SalesOrderDetail
	Campos: SalesOrderID, UnitPrice, OrderQty	
*/
--1)Mostrar el número de factura, el monto vendido, y al final, totalizar la facturación.
--Tablas: Sales.SalesOrderDetail
--Campos: SalesOrderID, UnitPrice, OrderQty

-- despues analizo esto... --
SELECT		SalesOrderID,
			SUM(UnitPrice*OrderQty) AS Total
FROM		Sales.SalesOrderDetail
GROUP BY	SalesOrderID WITH ROLLUP;

SELECT		ProductID,
			MAX(LineTotal) as Maximo
FROM		Sales.SalesOrderDetail
WHERE		ProductID>995
GROUP BY	ProductID
HAVING		MAX(LineTotal)>3000
order by	ProductID asc

SELECT		ProductID,
			MAX(LineTotal) as Maximo
FROM		Sales.SalesOrderDetail
WHERE		ProductID>995
GROUP BY	ProductID WITH ROLLUP
HAVING		MAX(LineTotal)>3000
