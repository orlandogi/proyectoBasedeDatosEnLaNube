![image](https://github.com/orlandogi/proyectoBasedeDatosEnLaNube/assets/132794853/6595bcf5-956c-4a80-bf36-55df2799a531)# Practica. Implementing Dimensions and Fact Tables

En esta practica se creo un almacen de datos utilizando la base de datos TK463DW
---


## Ejercicio 1. Creación de una base de datos de almacén de datos y una secuencia

#### Se creo una base de datos llamada 'TK463DW' dentro de una carpeta con el mismo nombre en su carpeta 'C:' de su computadora
##### En este código SQL se crea la base de datos en la carpeta antes mencionada
```javascript
USE master;
IF DB_ID('TK463DW') IS NOT NULL
DROP DATABASE TK463DW;
GO
CREATE DATABASE TK463DW
ON PRIMARY
(NAME = N'TK463DW', FILENAME = N'C:\TK463\TK463DW.mdf',
SIZE = 307200KB , FILEGROWTH = 10240KB )
LOG ON
(NAME = N'TK463DW_log', FILENAME = N'C:\TK463\TK463DW_log.ldf',
SIZE = 51200KB , FILEGROWTH = 10%);
GO
ALTER DATABASE TK463DW SET RECOVERY SIMPLE WITH NO_WAIT;
GO
```
#### Despues se creo un objeto de secuencia llamado 'seqcustomerDwkey'.
##### Codigo de la creación del objeto
```javascript
USE TK463DW;
GO
IF OBJECT_ID('dbo.SeqCustomerDwKey','SO') IS NOT NULL
DROP SEQUENCE dbo.SeqCustomerDwKey;
GO
CREATE SEQUENCE dbo.SeqCustomerDwKey AS INT
START WITH 1
INCREMENT BY 1;
GO
```


## Ejercicio 2. Creación de Dimensiones

##### Creación de la dimensión de Productos
```javascript
CREATE TABLE dbo.Productos
(
ProductKey INT NOT NULL,
ProductName NVARCHAR(50) NULL,
Color NVARCHAR(15) NULL,
Size NVARCHAR(50) NULL,
SubCategoryName NVARCHAR(50) NULL,
Categoryname NVARCHAR(50) NULL,
DateKey INT NOT NULL,
FullDate DATE NOT NULL,
MounthNumberName NVARCHAR(15) NULL,
CalendarQuarter TINYINT NULL,
CalendarYear SMALLINT NULL,
CONSTRAINT PK_products PRIMARY KEY (ProductKey)
);
GO
```
##### Creación de la Dimensión Customers.
```javascript
CREATE TABLE dbo.Customers
(
CustomerDwKey INT NOT NULL,
CustomerKey INT NOT NULL,
FullName NVARCHAR(150) NULL,
EmailAddress NVARCHAR(50) NULL,
BirthDate DATE NULL,
MaritalStatus NCHAR(1) NULL,
Gender NCHAR(1) NULL,
Education NVARCHAR(40) NULL,
Occupation NVARCHAR(100) NULL,
City NVARCHAR(30) NULL,
StateProvince NVARCHAR(50) NULL,
CountryRegion NVARCHAR(50) NULL,
Age AS
CASE
WHEN DATEDIFF(yy, BirthDate, CURRENT_TIMESTAMP) <= 40
THEN 'Younger'
WHEN DATEDIFF(yy, BirthDate, CURRENT_TIMESTAMP) > 50
THEN 'Older'
ELSE 'Middle Age'
END,

CurrentFlag BIT NOT NULL DEFAULT 1,
CONSTRAINT PK_Customers PRIMARY KEY (CustomerDwKey)
);
GO
```

##### Creación de la dimensión de Fechas
```javascript
CREATE TABLE dbo.Dates
(
DateKey INT NOT NULL,
FullDate DATE NOT NULL,
MonthNumberName NVARCHAR(15) NULL,
CalendarQuarter TINYINT NULL,
CalendarYear SMALLINT NULL,
CONSTRAINT PK_Dates PRIMARY KEY (DateKey)
);

GO
```

## Ejercicio 3. Crear una tabla de hechos

##### Creación de la tabla de hechos InternetSales.
```javascript
CREATE TABLE dbo.InternetSales
(
InternetSalesKey INT NOT NULL IDENTITY(1,1),
CustomerDwKey INT NOT NULL,
ProductKey INT NOT NULL,
DateKey INT NOT NULL,
OrderQuantity SMALLINT NOT NULL DEFAULT 0,
SalesAmount MONEY NOT NULL DEFAULT 0,
UnitPrice MONEY NOT NULL DEFAULT 0,
DiscountAmount FLOAT NOT NULL DEFAULT 0,

CONSTRAINT PK_InternetSales
PRIMARY KEY (InternetSalesKey)
);
GO
```
##### Modificación de la tabla de hechos InternetSales para agregar restricciones de clave externa para las relaciones con las tres dimensiones.
```javascript
ALTER TABLE dbo.InternetSales ADD CONSTRAINT
FK_InternetSales_Customers FOREIGN KEY(CustomerDwKey)
REFERENCES dbo.Customers (CustomerDwKey);
ALTER TABLE dbo.InternetSales ADD CONSTRAINT
FK_InternetSales_Products FOREIGN KEY(ProductKey)
REFERENCES dbo.Products (ProductKey);
ALTER TABLE dbo.InternetSales ADD CONSTRAINT
FK_InternetSales_Dates FOREIGN KEY(DateKey)
REFERENCES
```



