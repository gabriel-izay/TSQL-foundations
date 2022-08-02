/********** LABORATORIOS CLASE 4 **************/

use AdventureWorks2019
go

/***** Subconsultas *****/

/*
	1. Listar todos los productos cuyo precio sea
	inferior al precio promedio de todos los
	productos.
	Tablas: Production.Product
	Campos: Name, ListPrice
*/
select avg(listprice) from Production.Product

select		Name,
			ListPrice
from		Production.Product
where		ListPrice<(select avg(listprice) from Production.Product)
order by	ListPrice desc

/*
	2. Listar el nombre, precio de lista, precio
	promedio y diferencia de precios entre
	cada producto y el valor promedio general.
	Tablas: Production.Product
	Campos: Name, ListPrice
*/

SELECT		name as Nombre, 
			listprice as PrecioLista,
			(select avg(listprice) from Production.Product) as Promedio,
			listprice - (select avg(listprice) from Production.Product) as Diferencia
from		Production.Product
order by	ListPrice desc

/*
	3. Mostrar el o los códigos del producto
	más caro.
	Tablas: Production.Product
	Campos: ProductID,ListPrice
*/

select		Production.Product.ProductID,
			Production.Product.ListPrice
from		Production.Product
where		listprice=(select max(listprice) from	Production.Product)
order by	ListPrice desc

/*
	4. Mostrar el producto más barato de cada
	subcategoría. mostrar subcategoría, código
	de producto y el precio de lista más barato
	ordenado por subcategoría.
	Tablas: Production.Product
	Campos: ProductSubcategoryID, ProductID,
	ListPrice
*/