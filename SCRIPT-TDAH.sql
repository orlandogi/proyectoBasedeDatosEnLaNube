
-- Comando sql-ldd para crear una base de datos
CREATE DATABASE tdasjoins;
go
use tdasjoins;
go

CREATE TABLE categoria
(
idCategoria INT NOT NULL IDENTITY(1,1),
nombre VARCHAR(100) NOT NULL,
CONSTRAINT pk_categoria
PRIMARY KEY (idCategoria)
);

use NORTHWND;

--CREA LA ESTRUCTURA DE UNA TABLA DESDE UNA CONSULTA
SELECT * FROM Categories;
SELECT TOP 0 CategoryID, CategoryName INTO categoria2 FROM NORTHWND.dbo.categories;

SELECT * FROM categoria2;

--AGREGA UN CONSTRAINT A UNA TABLA
ALTER TABLE categoria2
ADD CONSTRAINT pk_categoria2
PRIMARY KEY (CategoryID);

--ELIMINA UN CONSTRAINT
ALTER TABLE categoria2
DROP pk_categoria2

--ELIMINA UNA COLUMNA EXISTENTE
ALTER TABLE categoria2
DROP COLUMN CategoryID

--AGREGA UNA COLUMNA A UNA TABLA
ALTER TABLE categoria2
ADD CategoryID INT NOT NULL IDENTITY(1,1);

--Llenar la tabla categoria y categoria2 con una consulta
INSERT INTO categoria2(categoryName)
SELECT CategoryName FROM NORTHWND.dbo.Categories

INSERT INTO categoria(nombre)
SELECT CategoryName FROM NORTHWND.dbo.Categories

--Crear una tabla y llenarla con datos 

SELECT ProductID as numeroProducto, ProductName as nombreProducto,
CategoryID as categoria, UnitPrice as precioUnitario, UnitsInStock as existencia
INTO producto
FROM NORTHWND.dbo.Products;

SELECT * FROM producto;

ALTER TABLE producto
ADD CONSTRAINT pk_producto
PRIMARY KEY(numeroProducto)

ALTER TABLE producto
ADD CONSTRAINT unico_nombreProducto
UNIQUE(nombreProducto)

ALTER TABLE producto
ADD CONSTRAINT chk_precioUnitario
CHECK (precioUnitario BETWEEN 1 AND 100000)

ALTER TABLE producto
ADD CONSTRAINT chk_existencia
CHECK (existencia >=0 AND existencia <= 1000)

ALTER TABLE producto
ADD CONSTRAINT fk_producto_categoria
FOREIGN KEY (categoria) REFERENCES
categoria(idCategoria)
ON DELETE CASCADE 
ON UPDATE CASCADE
