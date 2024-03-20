use tdasjoins;


SELECT c.idCategoria as 'Clave Categoría', c.nombre as 'Nombre Categoría',
p.nombreProducto as 'Descripción del producto', p.precioUnitario as 'Precio',
p.existencia as 'Exixtencia', (precioUnitario * existencia) as total from categoria AS c 
JOIN producto AS p
ON c.idCategoria = p.categoria

SELECT  *,(precioUnitario * existencia) as total  FROM 
categoria as c
INNER JOIN 
(Select nombreProducto , precioUnitario ,existencia, categoria from producto) as p
ON c.idCategoria = p.categoria

USE NORTHWND;


SELECT categoryName, ProductName FROM 
(SELECT categoryId, categoryname from categories) as c
INNER JOIN 
(SELECT ProductName, CategoryID FROM Products) as P
ON c.CategoryID = p.CategoryID

--Cuantos productos se tienen por categoria
SELECT categoryId, COUNT(*) as 'Numero de productos' 
FROM Products 
GROUP BY CategoryID

-- Seleccionar el numero de productos por categoria pero que contenga el nombre de la categoria 
f
SELECT categoryId, COUNT(*) as 'Numero de productos',  FROM Products 
GROUP BY (CategoryID), (ProductName)