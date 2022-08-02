/********** LABORATORIOS CLASE 3 **************/

/*
	1) Mostrar los empleados que también son vendedores
	Tablas: HumanResources.Employee, Sales.SalesPerson
	Campos: BusinessEntityID
*/

select		emp.BusinessEntityID
from		HumanResources.Employee emp
inner join	Sales.SalesPerson sp on emp.BusinessEntityID=sp.BusinessEntityID
go

/*
	2) Mostrar los empleados ordenados alfabéticamente por apellido y por nombre
	Tablas: HumanResources.Employee, Person.Person
	Campos: BusinessEntityID, LastName, FirstName
*/

select		e.BusinessEntityID,
			p.LastName,
			p.FirstName
from		HumanResources.Employee e
inner join	Person.Person p on e.BusinessEntityID=p.BusinessEntityID
order by	p.LastName, p.FirstName
go

/*
	3) Mostrar el código de logueo, número de territorio y sueldo básico de los vendedores
	Tablas: HumanResources.Employee, Sales.SalesPerson
	Campos: LoginID, TerritoryID, Bonus, BusinessEntityID
*/

select		e.BusinessEntityID,
			e.LoginID,
			sp.TerritoryID,
			sp.Bonus
from		HumanResources.Employee e
inner join	Sales.SalesPerson sp on e.BusinessEntityID=sp.BusinessEntityID
go

/*
	4) Mostrar los productos que sean ruedas
	Tablas: Production.Product, Production.ProductSubcategory
	Campos: Name, ProductSubcategoryID
*/

select		p.Name as ProductName,
			ps.Name as SubcatName,
			ps.ProductCategoryID
from		Production.Product p
inner join	Production.ProductSubcategory ps on ps.ProductCategoryID=p.ProductSubcategoryID
where		ps.Name='Wheels'
go

/*
	5) Mostrar los nombres de los productos que no son bicicletas
	Tablas:Production.Product, Production.ProductSubcategory
	Campos: Name, ProductSubcategoryID
*/

select		p.Name as ProductName,
			ps.Name as SunCatName,
			ps.ProductSubcategoryID
from		Production.Product p
inner join	Production.ProductSubcategory ps on p.ProductSubcategoryID=ps.ProductSubcategoryID
where		ps.Name not like ('%bike%')
go

/*
	6) Mostrar los precios de venta de aquellos productos donde el precio de venta sea inferior al precio de lista
	recomendado para ese producto ordenados por nombre de producto
	Tablas: Sales.SalesOrderDetail, Production.Product
	Campos: ProductID, Name, ListPrice, UnitPrice
*/
-- query posta --

select		so.ProductID,
			p.Name,
			so.UnitPrice,
			p.ListPrice
from		Sales.SalesOrderDetail so
inner join	Production.Product p on so.ProductID=p.ProductID
where		so.UnitPrice<p.ListPrice
go

-- queries auxiliares para chusmear las tablas --
select		Production.Product.ProductID,
			Production.Product.Name,
			Production.Product.ListPrice
from		Production.Product

select		Sales.SalesOrderDetail.ProductID,
			sales.SalesOrderDetail.UnitPrice
from		Sales.SalesOrderDetail
order by	ProductID asc
go

/*
	7) Mostrar todos los productos que tengan igual precio. Se deben mostrar de a pares, código y nombre de cada uno
	de los dos productos y el precio de ambos.ordenar por precio en forma descendente
	Tablas:Production.Product
	Campos: ProductID, ListPrice, Name
*/

select		p1.ProductID,
			p1.Name,
			p1.ListPrice,
			p2.ProductID,
			p2.Name,
			p2.ListPrice
from		Production.Product p1
inner join	Production.Product p2 on p1.ListPrice=p2.ListPrice
--me faltaba esta condicion de filtro, LE agrego aparte el !=0 porque son una bocha
where		p1.ProductID>p2.ProductID
and			p1.ListPrice!=0
order by	p1.ListPrice
go

/*
	8) Mostrar el nombre de los productos y de los proveedores cuya subcategoría es 15 ordenados por nombre de
	proveedor
	Tablas: Production.Product, Purchasing.ProductVendor, Purchasing.Vendor
	Campos: Name ,ProductID, BusinessEntityID, ProductSubcategoryID
*/

select		p1.ProductID,
			p1.ProductSubcategoryID,
			p1.Name as NombreProducto,
			p3.Name as NombreProveedor,
			p3.BusinessEntityID
from		Production.Product p1 
inner join	Purchasing.ProductVendor p2 
			on p1.ProductID=p2.ProductID 
inner join	Purchasing.Vendor p3 
			on p2.BusinessEntityID=p3.BusinessEntityID
where		p1.ProductSubcategoryID=15
order by	p3.Name asc
go

/*
	9) Mostrar todas las personas (nombre y apellido) y en el caso que sean empleados mostrar también el login id, sino
	mostrar null
	Tablas: Person.Person, HumanResources.Employee
	Campos: FirstName, LastName, LoginID, BusinessEntityID
*/

select		p.FirstName,
			p.LastName,
			e.LoginID
from		Person.Person p left join HumanResources.Employee e 
			on  p.BusinessEntityID=e.BusinessEntityID
go

