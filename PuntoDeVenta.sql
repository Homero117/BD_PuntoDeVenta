/* 
Carrera: Ingeniería en tecnologías de la información y la comunicación.
Asignatura: Fundamentos de Base de Datos.
Profesora: DISE. Thalia Heidi Hernández Omaña. 
Práctica: Diseño del modelo relacional de una base de datos.
Grado y grupo: ¨3-A¨
Alumno: Homero de Jesús Portillo Calva
Objetivo: Elaborar el modelo relacional a partir del modelo entidad-relación.
*/
-- BD PuntoDeVenta
use master

create database PuntoDeVenta
go

-- Tablas
use PuntoDeVenta
go

-- Tabla 1: Categoria
create table Categoria(

	ID varchar(50) Primary key,
	Nombre varchar(100) not null,
	Descripcion varchar(500) null
)
go

-- Tabla 2: Proveedor
create table Proveedor(

	RUT varchar(50) Primary key,
	WEB varchar(500) null,
	Nombre varchar(50) not null,
	Telefono varchar(15) Unique not null,

-- Atributo Compuesto (Direccion)
    Calle VARCHAR(100) not null,
    Numero VARCHAR(20) null,
    Ciudad VARCHAR(50) not null

)
go

Alter table Proveedor
add constraint DFL_WEB default 'Sin página web' for WEB
Go


-- Table 3: Cliente
create table Cliente(

	RUT varchar(50) Primary key,
	Nombre varchar(50) not null,
	Telefono varchar(15) Unique not null,

-- Atributo Compuesto (Direccion)
    Calle VARCHAR(100) not null,
    Numero VARCHAR(20) null,
    Ciudad VARCHAR(50) not null

)
go

-- Table 4: Venta
create table Venta(

	ID varchar(50) Primary key,
	Fecha date not null,
	Monto_Final money not null,
	Descuento float null
)
go

-- Tabla 5: Producto
create table Producto(

	ID varchar(50) Primary key,
	Nombre varchar(100) Unique not null,
	Precio money not null,
	Stock int not null

)
go

-- Relacciones

-- Proveedor - Producto 1:N
Alter table Producto
add RUT_Proveedor varchar(50)
go

Alter table Producto
add constraint FK_Producto_Proveedor foreign key(RUT_Proveedor)
references Proveedor(RUT)
Go

-- Categoria - Producto 1:N
Alter table Producto
add ID_Categoria varchar(50)
go

Alter table Producto
add constraint FK_Producto_Categoria foreign key(ID_Categoria)
references Categoria(ID)
Go

-- Cliente - Venta 1:N
Alter table Venta
add RUT_Cliente varchar(50)
go

Alter table Venta
add constraint FK_Venta_Cliente foreign key(RUT_Cliente)
references Cliente(RUT)
Go

-- Venta - Producto N:M
create table VentaProduct(

	PRIMARY KEY (VentaID, ProductoID),
    VentaID varchar(50),
    ProductoID varchar(50),
    Cantidad int not null,
    FOREIGN KEY (VentaID) REFERENCES Venta(ID),
    FOREIGN KEY (ProductoID) REFERENCES Producto(ID)

)
go

-- Restricciones:
--unique

Alter table Categoria
add constraint UQ_NombreCa unique(Nombre)
Go

Alter table Producto
add constraint UQ_NombreP unique(Nombre)
Go

Alter table Cliente
add constraint UQ_NombreCl unique(Nombre)
Go

-- check
ALTER TABLE Producto
ADD CONSTRAINT CHK_Precio CHECK (Precio > 0)
go

ALTER TABLE Producto
ADD CONSTRAINT CHK_Stock CHECK (Stock > 0)
go

ALTER TABLE Venta
ADD CONSTRAINT CHK_Monto_Final CHECK (Monto_Final > 0)
go
