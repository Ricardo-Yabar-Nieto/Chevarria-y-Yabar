-- =====================================
-- CREACIÓN DE BASE DE DATOS
-- =====================================
IF DB_ID('BDSUMAQLlantaFC') IS NOT NULL
DROP DATABASE BDSUMAQLlantaFC;
GO
CREATE DATABASE BDSUMAQLlantaFC;
GO
USE BDSUMAQLlantaFC;
GO
-- =====================================
-- CREACIÓN DE TABLAS
-- =====================================
-- CLIENTE
IF OBJECT_ID('Cliente', 'U') IS NOT NULL DROP TABLE Cliente;
GO
CREATE TABLE Cliente (
idC INT IDENTITY(1,1) PRIMARY KEY,
Nombre VARCHAR(100) NOT NULL,
Apellido VARCHAR(100),
Telefono BIGINT,
Email VARCHAR(150),
DNI BIGINT,
RUC BIGINT,
EsEmpresa BIT NOT NULL DEFAULT 0
);
GO
-- EMPLEADO
IF OBJECT_ID('Empleado', 'U') IS NOT NULL DROP TABLE Empleado;
GO
CREATE TABLE Empleado (
codE INT IDENTITY(1,1) PRIMARY KEY,
Nombre VARCHAR(100) NOT NULL,
Apellido VARCHAR(100) NOT NULL,
Cargo VARCHAR(50) NOT NULL,
Salario DECIMAL(10,2) NOT NULL
);
GO
-- PROVEEDOR
IF OBJECT_ID('Proveedor', 'U') IS NOT NULL DROP TABLE Proveedor;
GO
CREATE TABLE Proveedor (
idP INT IDENTITY(1,1) PRIMARY KEY,
Nombre VARCHAR(100) NOT NULL,
Contacto VARCHAR(100) NOT NULL,
Telefono BIGINT NOT NULL,
RUC BIGINT NOT NULL,
Direccion VARCHAR(255) NOT NULL
);
GO
-- PRODUCTO
IF OBJECT_ID('Producto', 'U') IS NOT NULL DROP TABLE Producto;
GO
CREATE TABLE Producto (
idProd INT IDENTITY(1,1) PRIMARY KEY,
idP INT NOT NULL,
Nombre VARCHAR(100) NOT NULL,
Categoria VARCHAR(50) NOT NULL,
Precio DECIMAL(10,2) NOT NULL,
Stock INT NOT NULL CHECK (Stock >= 0),
FOREIGN KEY (idP) REFERENCES Proveedor(idP)
);
GO
-- COMPROBANTE
IF OBJECT_ID('Comprobante', 'U') IS NOT NULL DROP TABLE Comprobante;
GO
CREATE TABLE Comprobante (
idComp INT IDENTITY(1,1) PRIMARY KEY,
idC INT NOT NULL,
codE INT NOT NULL,
Fecha DATE NOT NULL,
TipoComp VARCHAR(10) NOT NULL CHECK (TipoComp IN ('Boleta', 'Factura')),
IGV DECIMAL(10,2) NULL,
Total DECIMAL(10,2) NULL,
TipoComprobante VARCHAR(10) NOT NULL,
FOREIGN KEY (idC) REFERENCES Cliente(idC),
FOREIGN KEY (codE) REFERENCES Empleado(codE)
);
GO
-- DETALLE_PEDIDO
IF OBJECT_ID('Detalle_Pedido', 'U') IS NOT NULL DROP TABLE Detalle_Pedido;
GO
CREATE TABLE Detalle_Pedido (
idDet INT IDENTITY(1,1) PRIMARY KEY,
idComp INT NOT NULL,
idProd INT NOT NULL,
Cantidad INT NOT NULL CHECK (Cantidad > 0),
Subtotal DECIMAL(10,2) NULL,
FOREIGN KEY (idComp) REFERENCES Comprobante(idComp),
FOREIGN KEY (idProd) REFERENCES Producto(idProd)
);
GO
-- INGRESO
IF OBJECT_ID('Ingreso', 'U') IS NOT NULL DROP TABLE Ingreso;
GO
CREATE TABLE Ingreso (
idIng INT IDENTITY(1,1) PRIMARY KEY,
codE INT NOT NULL,
Descripcion VARCHAR(255) NOT NULL,
Monto DECIMAL(10,2) NOT NULL,
Fecha DATE NOT NULL,
Origen VARCHAR(100) NOT NULL,
FOREIGN KEY (codE) REFERENCES Empleado(codE)
);
GO
-- DELIVERY
IF OBJECT_ID('Delivery', 'U') IS NOT NULL DROP TABLE Delivery;
GO
CREATE TABLE Delivery (
idDel INT IDENTITY(1,1) PRIMARY KEY,
idComp INT NOT NULL,
Direccion VARCHAR(255) NOT NULL,
Estado VARCHAR(50) NOT NULL,
FechaEntrega DATE NOT NULL,
CostoEnvio DECIMAL(10,2) NOT NULL,
FOREIGN KEY (idComp) REFERENCES Comprobante(idComp)
);
GO
-- =====================================
-- INSERCIÓN DE DATOS
-- =====================================
-- CLIENTES
INSERT INTO Cliente (Nombre, Apellido, Telefono, Email, DNI, RUC, EsEmpresa) VALUES
('Carlos', 'Lopez', 999888777, 'carlos@gmail.com', 45879632, NULL, 0),
('Empresa Alfa', NULL, 983456712, 'contacto@alfa.com', NULL, 20458796321, 1),
('Lucía', 'Ramirez', 945781234, 'lucia.ramirez@mail.com', 40782341, NULL, 0),
('Restaurante Delicias', NULL, 932001122, 'delicias@restaurantes.pe', NULL, 20654123987, 1),
('Ana', 'Huaman', 953002547, 'ana.h@mail.com', 45678912, NULL, 0),
('Eduardo', 'Paredes', 987654321, 'edu.p@gmail.com', 43456578, NULL, 0),
('Tech Solutions', NULL, 901123987, 'info@techsol.com', NULL, 20876543901, 1);
GO
-- EMPLEADOS
INSERT INTO Empleado (Nombre, Apellido, Cargo, Salario) VALUES
('Andrei', 'Chevarria', 'Cajero', 1500.00),
('Mauricio', 'Gamarra', 'Administrador', 2500.00),
('Danny', 'Vargas', 'Mozo', 1200.00),
('Ricardo', 'Yabar', 'Cocinero', 1800.00),
('Paola', 'Castro', 'Recepcionista', 1400.00),
('Luis', 'Soto', 'Cajero', 1500.00),
('Javier', 'Pino', 'Seguridad', 1600.00);
GO
-- PROVEEDORES
INSERT INTO Proveedor (Nombre, Contacto, Telefono, RUC, Direccion) VALUES
('Distribuciones SAC', 'Jose Gómez', 944123456, 20458796231, 'Av. Colonial 123'),
('Bebidas Andes', 'Clara Ramos', 987654321, 20321456987, 'Jr. Huánuco 456'),
('Insumos Marinos', 'Pedro Quispe', 912341234, 20987654321, 'Av. Grau 987'),
('Panificadora PanPan', 'Marta Linares', 963852741, 20111222334, 'Calle Lima 123'),
('Lácteos del Sur', 'Rosa Salazar', 954789632, 20888888888, 'Av. Cusco 789'),
('Frutas Perú', 'Jorge Ayala', 987654123, 20666666666, 'Jr. Arequipa 111'),
('Carnes Selectas', 'Luis Vargas', 921212121, 20999999999, 'Av. Arequipa 222');
GO
-- PRODUCTOS
INSERT INTO Producto (idP, Nombre, Categoria, Precio, Stock) VALUES
(1, 'Cerveza Cristal', 'Bebida', 6.50, 100),
(2, 'Pisco Quebranta', 'Licor', 35.00, 30),
(3, 'Pulpo', 'Mariscos', 20.00, 25),
(4, 'Pan de ajo', 'Panadería', 3.00, 80),
(5, 'Queso fresco', 'Lácteos', 8.00, 50),
(6, 'Plátano', 'Fruta', 1.00, 120),
(7, 'Bistec de res', 'Carne', 15.00, 40);
GO
-- COMPROBANTES
INSERT INTO Comprobante (idC, codE, Fecha, TipoComp, IGV, Total, TipoComprobante)
VALUES
(1, 1, '2025-04-01', 'Boleta', NULL, NULL, 'Venta'),
(2, 2, '2025-04-02', 'Factura', NULL, NULL, 'Venta'),
(3, 3, '2025-04-03', 'Boleta', NULL, NULL, 'Venta'),
(4, 4, '2025-04-04', 'Factura', NULL, NULL, 'Venta'),
(5, 5, '2025-04-05', 'Boleta', NULL, NULL, 'Venta'),
(6, 6, '2025-04-06', 'Factura', NULL, NULL, 'Venta'),
(7, 7, '2025-04-07', 'Boleta', NULL, NULL, 'Venta');
GO
-- DETALLE_PEDIDO
INSERT INTO Detalle_Pedido (idComp, idProd, Cantidad, Subtotal) VALUES
(1, 1, 2, NULL),
(1, 4, 1, NULL),
(2, 2, 3, NULL),
(3, 5, 2, NULL),
(4, 6, 6, NULL),
(5, 3, 1, NULL),
(6, 7, 4, NULL);
GO
-- INGRESOS
INSERT INTO Ingreso (codE, Descripcion, Monto, Fecha, Origen) VALUES
(1, 'Venta en caja', 100.00, '2025-04-01', 'Caja'),
(2, 'Propina clientes', 30.00, '2025-04-01', 'Clientes'),
(3, 'Transferencia Interbank', 500.00, '2025-04-02', 'Banco'),
(4, 'Venta evento', 800.00, '2025-04-03', 'Evento privado'),
(5, 'Ingreso adicional', 250.00, '2025-04-04', 'Promoción'),
(6, 'Pago online', 700.00, '2025-04-05', 'Web'),
(7, 'Renta local', 900.00, '2025-04-06', 'Alquiler');
GO
-- DELIVERY
INSERT INTO Delivery (idComp, Direccion, Estado, FechaEntrega, CostoEnvio) VALUES
(1, 'Av. La Cultura 123', 'Entregado', '2025-04-02', 5.00),
(2, 'Jr. Ayacucho 456', 'Pendiente', '2025-04-03', 6.00),
(3, 'Calle Arequipa 789', 'Entregado', '2025-04-04', 4.50),
(4, 'Av. Cusco 111', 'Cancelado', '2025-04-05', 5.50),
(5, 'Av. Tullumayu 222', 'Entregado', '2025-04-06', 5.00),
(6, 'Jr. Belén 333', 'Entregado', '2025-04-07', 6.50),
(7, 'Calle Manco Cápac 444', 'Pendiente', '2025-04-08', 4.00);
GO
-- =====================================
-- CONSULTAS Y PROCEDIMIENTOS
-- =====================================
-- VENTAS POR CLIENTE
SELECT c.Nombre, c.Apellido, p.Nombre AS Producto, dp.Cantidad
FROM Cliente c
JOIN Comprobante comp ON c.idC = comp.idC
JOIN Detalle_Pedido dp ON comp.idComp = dp.idComp
JOIN Producto p ON dp.idProd = p.idProd;
-- EMPLEADOS E INGRESOS
SELECT e.Nombre, e.Apellido, i.Descripcion, i.Monto
FROM Empleado e
LEFT JOIN Ingreso i ON e.codE = i.codE;
-- CLIENTES CON FACTURA
SELECT Nombre, Apellido
FROM Cliente
WHERE idC IN (
SELECT idC
FROM Comprobante
WHERE TipoComp = 'Factura'
);
-- PROCEDIMIENTO: Calcular Subtotal
CREATE PROCEDURE CalcularSubtotal
AS
BEGIN
UPDATE dp
SET dp.Subtotal = dp.Cantidad * p.Precio
FROM Detalle_Pedido dp
JOIN Producto p ON dp.idProd = p.idProd
WHERE dp.Subtotal IS NULL;
END;
GO
-- PROCEDIMIENTO: Calcular IGV y Total
CREATE PROCEDURE CalcularIGVTotal
AS
BEGIN
UPDATE com
SET
com.IGV = (SELECT SUM(dp.Subtotal) * 0.18 FROM Detalle_Pedido dp WHERE
dp.idComp = com.idComp),
com.Total = (SELECT SUM(dp.Subtotal) + SUM(dp.Subtotal) * 0.18 FROM Detalle_Pedido
dp WHERE dp.idComp = com.idComp)
WHERE com.IGV IS NULL OR com.Total IS NULL;
END;
GO
-- PROCEDIMIENTO: Total ingresos por empleado
CREATE PROCEDURE CalcularIngresoTotalPorEmpleado
AS
BEGIN
SELECT
e.Nombre AS Empleado,
e.Apellido,
SUM(i.Monto) AS TotalIngresos
FROM Ingreso i
JOIN Empleado e ON i.codE = e.codE
GROUP BY e.codE, e.Nombre, e.Apellido;
END;
GO

-- =====================================
-- VISTAS
-- =====================================
-- VISTA: Ventas por cliente
CREATE VIEW VistaVentasPorCliente AS
SELECT
c.Nombre AS Cliente,
c.Apellido,
com.Fecha AS FechaVenta,
com.TipoComp AS TipoComprobante,
p.Nombre AS Producto,
dp.Cantidad,
dp.Cantidad * p.Precio AS Subtotal,
com.IGV,
com.Total
FROM Comprobante com
JOIN Cliente c ON com.idC = c.idC
JOIN Detalle_Pedido dp ON com.idComp = dp.idComp
JOIN Producto p ON dp.idProd = p.idProd
WHERE com.TipoComprobante = 'Venta';
GO
-- VISTA: Ingresos por empleados
CREATE VIEW VistaEmpleadosIngresos AS
SELECT
e.Nombre AS Empleado,
e.Apellido,
e.Cargo,
SUM(i.Monto) AS TotalIngresos
FROM Empleado e
LEFT JOIN Ingreso i ON e.codE = i.codE
GROUP BY e.codE, e.Nombre, e.Apellido, e.Cargo;
GO
-- VISTA: Productos en stock
CREATE VIEW VistaProductosStock AS
SELECT
p.Nombre AS Producto,
p.Categoria,
p.Precio,
p.Stock,
pr.Nombre AS Proveedor
FROM Producto p
JOIN Proveedor pr ON p.idP = pr.idP
WHERE p.Stock > 0;
GO

select * from Cliente;
select * from Empleado;
select * from Proveedor;
select * from Producto;
select * from Comprobante;
select * from Detalle_Pedido;
select * from Ingreso;
select * from Delivery;

-- CONSULTAS DE LAS VISTAS
SELECT * FROM VistaVentasPorCliente;
SELECT * FROM VistaEmpleadosIngresos;
SELECT * FROM VistaProductosStock;

EXEC CalcularIngresoTotalPorEmpleado;