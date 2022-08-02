/* Laboratorios clase 1 */

use AdventureWorks2019
go

	-- Laboratorio OPERADORES LÓGICOS --

/*
	1) Mostrar los empleados que tienen más de 90 horas de vacaciones
	Tablas: HumanResources.Employee
	Campos: VacationHours, BusinessEntityID
*/

select		HumanResources.Employee.BusinessEntityID as ID,
			HumanResources.Employee.VacationHours as HsVacaciones
from		HumanResources.Employee
where		HumanResources.Employee.VacationHours > 90

/*
	2) Mostrar el nombre, precio y precio con iva de los productos con precio distinto de cero
	Tablas:Production.Product
	Campos: Name, ListPrice
*/

select		Production.Product.Name as Nombre,
			ListPrice as PrecioLista,
			ListPrice * 0.21 as IVA,
			ListPrice * 1.21 as PrecioConIVA
from		Production.Product
where		ListPrice!=0
			

/*
	3) Mostrar precio y nombre de los productos 776, 777, 778
	Tablas:Production.Product
	Campos: ProductID, Name, ListPrice
*/

select		ProductID,
			Name,
			ListPrice
from		Production.Product
where		ProductID in (776,777,778)

-- equivalente con op OR -- 

select		ProductID,
			Name,
			ListPrice
from		Production.Product
where		ProductId=776 or
			ProductID=777 or
			ProductID=778

/*
	4) Mostrar el nombre concatenado con el apellido de las 
	personas cuyo apellido sea johnson
	Tablas:Person.Person
	Campos: FirstName, LastName
*/

select		FirstName as PrimerNombre,
			LastName as Apellido,
			FirstName+' '+LastName as NombreCompleto
from		Person.Person
where		LastName='Johnson'

/*
	5) Mostrar todos los productos cuyo precio sea inferior a 150$ de color rojo o cuyo precio sea mayor a 500$ de color
	negro
	Tablas:Production.Product
	Campos: ListPrice, Color
*/

select		Color,
			ListPrice
from		Production.Product
where		ListPrice<50
order by	ListPrice desc

/*
	6) Mostrar el código, fecha de ingreso y horas de vacaciones 
	de los empleados ingresaron a partir del año 2000
	Tablas: HumanResources.Employee
	Campos: BusinessEntityID, HireDate, VacationHours
*/

select		BusinessEntityID,
			HireDate,
			VacationHours
from		HumanResources.Employee
where		year(HireDate)>=2009
order by	HireDate desc

/*
	7) Mostrar el nombre, número de producto, precio de lista y el precio de lista incrementado en un 10% de los
	productos cuya fecha de fin de venta sea anterior al día de hoy
	Tablas:Production.Product
	Campos: Name, ProductNumber, ListPrice, SellEndDate
*/

select		Name,
			ProductNumber,
			ListPrice,
			SellEndDate
from		Production.Product
where		SellEndDate<GETDATE()

-- NULL --

/*
	1) Mostrar los representantes de ventas (vendedores) 
	que no tienen definido el número de territorio
	Tablas: Sales.SalesPerson
	Campos: TerritoryID, BusinessEntityID
*/

select		TerritoryID,
			BusinessEntityID
from		Sales.SalesPerson
where		TerritoryID is null

/*
	2) Mostrar el peso de todos los artículos. 
	si el peso no estuviese definido, reemplazar por cero
	Tablas:Production.Product
	Campos: Weight
*/

select		ISNULL(Weight,0) as Weight,
			Name
from		Production.Product

/***************************************************************/

-- Laboratorio Criterios de selección --

/*
	1) Mostrar el nombre, precio y color de los accesorios 
	para asientos de las bicicletas cuyo
	precio sea mayor a 100 pesos
	Tablas: Production.Product
	Campos: Name, ListPrice, Color
*/

select		Name,
			Color,
			ListPrice
from		Production.Product
where		ListPrice>100

/*
	2) Mostrar los nombre de los productos que tengan 
	cualquier combinación de ‘mountain bike’
	​Tablas: Production.Product
	Campos: Name
*/

select		name
from		Production.Product
where		name like '%mountain bike%'

/*
	 ​3) ​ ​Mostrar las personas cuyo nombre empiece con la letra “y”
	Tablas: Person.Person
	Campos: FirstName
*/

select		FirstName
from		Person.Person
where		FirstName like '[y-Y]%' 

/*
	4) Mostrar las personas que la segunda letra de su 
	apellido es una s
	​Tablas: Person.Person
	Campos: LastName
*/

select		LastName
from		Person.Person
where		LastName like '_s%'

/*
	5) Mostrar el nombre concatenado con el apellido de las 
	personas cuyo apellido tengan terminación española (ez)
	Tablas: Person.Person
	Campos: FirstName, LastName
*/

select		FirstName as Nombre,
			LastName as Apellido,
			FirstName+' '+LastName
from		Person.Person
where		LastName like '%ez'

/*
	6) Mostrar los nombres de los productos que terminen en un 
	número
	Tablas: Production.Product
	Campos: Name
*/

select		Name
from		Production.Product
where		Name like '%[0-9]'

/*
	7) Mostrar las personas cuyo nombre tenga una C o c como 
	primer carácter,
	cualquier otro como segundo carácter, ni d ni e ni f ni g 
	como tercer carácter,
	cualquiera entre j y r o entre s y w como cuarto carácter 
	y el resto sin restricciones
	Tablas: Person.Person
	Campos: FirstName
*/

select		FirstName
from		Person.Person
where		FirstName like '[C-c]_[^d-g][j-r]%' or
			Firstname like '[C-c]_[^d-g][s-w]%'

/****************************************************/

-- Laboratorio BETWEEN --


/*
	1) Mostrar todos los productos cuyo precio de lista 
	esté entre 200 y 300
	Tablas: Production.Product
	Campos: ListPrice
*/

select		Name,
			ListPrice
from		Production.Product
where		ListPrice between 200 and 300

/*
	2) Mostrar todos los empleados que nacieron entre 1970 y 1985
	Tablas: HumanResources.Employee
	Campos: BirthDate
*/

select		HumanResources.Employee.BusinessEntityID,
			BirthDate
from		HumanResources.Employee
where		year(birthdate) between 1970 and 1985
order by	BirthDate desc

/*
	3) Mostrar el la fecha,numero de version y subtotal de las 
	ventas efectuadas en los años
	2005 y 2006
	Tablas: Sales.SalesOrderHeader
	Campos: OrderDate, AccountNumber, SubTotal
*/

select		OrderDate,
			AccountNumber,
			SubTotal
from		Sales.SalesOrderHeader
where		year(OrderDate) between 2010 and 2012

/*
	4) Mostrar todos los productos cuyo Subtotal no esté entre 
	50 y 70
	Tablas: Sales.SalesOrderHeader
	Campos: OrderDate, AccountNumber, SubTotal
*/

select		OrderDate,
			AccountNumber,
			SubTotal
from		Sales.SalesOrderHeader
where		SubTotal not between 50 and 70

/****************************************************/

-- Laboratorio IN

/*
	1) Mostrar los códigos de venta y producto, cantidad de 
	venta y precio unitario de los
	artículos 750, 753 y 770
	Tablas: Sales.SalesOrderDetail
	Campos: SalesOrderID, OrderQty, ProductID, UnitPrice
*/

select		SalesOrderID,
			OrderQty,
			ProductID,
			UnitPrice
from		Sales.SalesOrderDetail
where		ProductID in (750,753,770)

/*
	2) Mostrar todos los productos cuyo color sea verde, 
	blanco y azul
	Tablas: Production.Product
	Campos: Color
*/

select		Color
from		Production.Product
where		Color in ('Green','White','Blue')


/**************************************************************/

-- Laboratorio ORDER BY

/*
1) Mostrar las personas ordenadas primero por su apellido y luego por su nombre
​ Tablas:Person.Person
Campos: Firstname, Lastname
*/

select		LastName,
			FirstName			
from		Person.Person
Order by	LastName asc, FirstName asc

/*
2) Mostrar cinco productos más caros y su nombre ordenado en forma alfabética
​ Tablas:Production.Product
Campos: Name, ListPrice
*/
-- con 5 no se aprecia con claridad el ordenamiento, por eso elijo 20-
select top 20	Name,
				ListPrice
from			Production.Product
order by		ListPrice desc,
				Name asc	