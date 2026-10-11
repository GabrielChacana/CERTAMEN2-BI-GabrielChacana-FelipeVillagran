USE KentFoods_DW;
GO

-- 1. Dimensión Tiempo
CREATE TABLE DimTiempo (
    Tiempo_SK INT PRIMARY KEY, -- YYYYMMDD
    Fecha DATE,
    Anio INT,
    Mes INT,
    Dia INT,
    NombreMes NVARCHAR(20)
);
GO

-- 2. Dimensión Cliente (De la tabla transaccional Clientes)
CREATE TABLE DimCliente (
    Cliente_SK INT IDENTITY(1,1) PRIMARY KEY, -- Clave Subrrogada (Surrogate Key)
    ClienteID NCHAR(5) NOT NULL,              -- Clave de negocio original
    Empresa NVARCHAR(40),
    Contacto NVARCHAR(30),
    Ciudad NVARCHAR(15),
    Pais NVARCHAR(15)
);
GO

-- 3. Dimensión Producto (Desnormalizada: Productos + Categorias + Proveedores)
CREATE TABLE DimProducto (
    Producto_SK INT IDENTITY(1,1) PRIMARY KEY,
    ProductoID INT NOT NULL,
    Producto NVARCHAR(40),
    Categoria NVARCHAR(15),
    Proveedor NVARCHAR(40)
);
GO

-- 4. Dimensión Empleado (De la tabla transaccional Empleados)
CREATE TABLE DimEmpleado (
    Empleado_SK INT IDENTITY(1,1) PRIMARY KEY,
    EmpleadoID INT NOT NULL,
    NombreCompleto NVARCHAR(50),
    Cargo NVARCHAR(30)
);
GO

-- 5. Dimensión Transportista (De la tabla transaccional Transportistas)
CREATE TABLE DimTransportista (
    Transportista_SK INT IDENTITY(1,1) PRIMARY KEY,
    TransportistaID INT NOT NULL,
    Transportista NVARCHAR(40)
);
GO

-- 6. Tabla de Hechos (Cruza todas las dimensiones)
CREATE TABLE FactVentas (
    FactVentas_ID INT IDENTITY(1,1) PRIMARY KEY, 
    
    FechaOrden_SK INT FOREIGN KEY REFERENCES DimTiempo(Tiempo_SK),
	FechaEnvio_SK INT NULL FOREIGN KEY REFERENCES DimTiempo(Tiempo_SK),
    Cliente_SK INT FOREIGN KEY REFERENCES DimCliente(Cliente_SK),
    Producto_SK INT FOREIGN KEY REFERENCES DimProducto(Producto_SK),
    Empleado_SK INT FOREIGN KEY REFERENCES DimEmpleado(Empleado_SK),
    Transportista_SK INT FOREIGN KEY REFERENCES DimTransportista(Transportista_SK),
    
    -- Medidas
    Cantidad INT,
    PrecioUnitario DECIMAL(10,2),
    Descuento DECIMAL(4,2),
    MontoVenta DECIMAL(12,2),
    MontoConDescuento DECIMAL(12,2),
    DiasDeEnvio INT
);
GO