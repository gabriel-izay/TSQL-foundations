/*****	Laboratorio clase 3 pt2 *****/

/* Tablas temporales */

use AdventureWorks2019
go

/*
	1) Clonar estructura y datos de los campos nombre, color y precio de lista de la tabla 
	production.product en una tabla llamada #Productos
	Tablas:Production.Product
	Campos: Name, ListPrice, Color
*/

create table #Productos
(
	Name		nvarchar(50)	not null,
	Color		nvarchar(15)	not null,
	ListPrice	money			not null
);

select		Color, Name, ListPrice
into		#Productos
from		Production.Product

select * from #Productos

/*
	2) Clonar solo estructura de los campos identificador, nombre y apellido de la tabla 
	person.person en una tabla llamada #Personas
	Tablas: Person.Person
	Campos: BusinessEntityID, FirstName, LastName
*/

SELECT	BusinessEntityID, FirstName, LastName
INTO	#personas
FROM	Person.Person
WHERE	1=2; --condición que nuca va a dar true, asi que no copia ningún registro

/*
	3) Eliminar si existe la tabla #Productos
	Tablas: #Productos
*/

IF OBJECT_ID (N'tempdb..#Productos', N'U') IS NOT NULL
		DROP TABLE #Productos;
GO

/*
	4) Eliminar si existe la tabla #Personas
	Tablas: #personas
*/

IF OBJECT_ID (N'tempdb..#Personas', N'U') IS NOT NULL
		DROP TABLE #Personas;
GO

/*
	5) Crear una CTE con las órdenes de venta
	Tablas: Sales.SalesOrderHeader
	Campos: SalesPersonID, SalesOrderID, OrderDate
*/

WITH Sales_CTE (SalesPersonID, SalesOrderID, SalesYear)  
AS    
(  
    SELECT  SalesPersonID
			,SalesOrderID 
			,YEAR(OrderDate) AS Anio  
    FROM 
			Sales.SalesOrderHeader  
    WHERE 
			SalesPersonID IS NOT NULL  
)  
SELECT SalesPersonID, SalesOrderID, SalesYear
from	Sales_CTE