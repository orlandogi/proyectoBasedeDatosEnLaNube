create database ejemploETL;
use ejemploETL;

create table productos(
productoid int not null identity(1,1), 
nombreProducto varchar(40) not null, 
precio money not null, 
stock smallint not null,
importe as
(precio * stock),
categoria nvarchar(15) not null,
constraint pk_producto
primary key(productoid)
)

select * from productos;

-- Permite visualizar las caracteristicas de las tablas  --
select * from sys.tables

insert into ejemploETL.dbo.productos

select p.ProductName, p.UnitPrice, p.UnitsInStock, c.CategoryName from
NORTHWND.dbo.Products
inner join NORTHWND.dbo.Categorias as c
on c.CategoryID = p.CategoryID


select * from productos;
