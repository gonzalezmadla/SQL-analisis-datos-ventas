-- Se crean tablas con la informacion a analizar 

-- Tabla 'Categorias'
CREATE TABLE IF NOT EXISTS Categorias(
    ID_Categoria INT PRIMARY KEY,
    Categoria VARCHAR(255),
    Descripcion_c TEXT
);
-- Se ingresan valores a la tabla 'Categorias'
INSERT INTO Categorias (ID_Categoria, Categoria, Descripcion_c)
VALUES 
    (1,'Lácteos','Productos lácteos frescos y procesados, como leche, yogur, queso y manteca.'), 
    (2,'Carnicería','Carnes frescas y procesadas, como carne de vaca, cerdo, pollo y embutidos.'),
    (3,'Panadería','Productos horneados frescos, como pan, facturas, medialunas y tortas.'),
    (4,'Frutas y Verduras','Frutas y verduras frescas, locales e importadas, para consumo diario.'),
    (5,'Congelados','Productos congelados, como papas fritas, empanadas, pizzas y verduras congeladas.'),
    (6,'Bebidas','Bebidas de todo tipo, como agua, jugos, refrescos, cerveza, vino y bebidas espirituosas.'),
    (7,'Galletitas y Snacks','Productos de snack, como galletitas, papas chips, maníes y otros productos para merendar.'),
    (8,'Conservas','Productos alimenticios enlatados o envasados, como arroz, lentejas, garbanzos y atún.');
-- Se consulta
SELECT * 
FROM categorias;

-- Tabla 'Metodo de pago'
CREATE TABLE IF NOT EXISTS Metodo_pago(
    ID_Metodo INT PRIMARY KEY,
    Metodo VARCHAR(255),
    Descripcion_mp TEXT
);
-- Se ingresan valores a la tabla 'Metodo de pago'
INSERT INTO metodo_pago(ID_Metodo, Metodo, Descripcion_mp)
VALUES
    (1, 'Efectivo','Pago en dinero en efectivo, sin intermediarios financieros.'),
    (2,'Tarjeta de Crédito','Pago con tarjetas emitidas por bancos y financieras, con la opción de pago a crédito.'),
    (3,'Tarjeta de Débito','Pago con tarjetas que debitán directamente de la cuenta bancaria del titular.'),
    (4,'Mercado Pago','Plataforma de pagos online que permite realizar transacciones con tarjetas, cuenta bancaria o efectivo.'),
    (5,'Transferencia','Pago realizado a través de una transferencia de fondos entre cuentas bancarias.');
-- Se consulta
SELECT *
FROM metodo_pago;

-- Tabla 'Clientes'
CREATE TABLE IF NOT EXISTS Clientes(
    ID_Cliente INT PRIMARY KEY,
    Nombre VARCHAR (255),
    Apellido VARCHAR (255),
    Email VARCHAR (255),
    Fecha_Registro DATE,
    Region VARCHAR (255)
);
-- Se ingresan valores a la tabla 'Cliente', como son muchas filas, se hace importacion de archivos
LOAD DATA INFILE  
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/clientes.csv'
INTO TABLE Clientes
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(ID_Cliente, Nombre, Apellido, Email, @Fecha_Registro, Region)
SET Fecha_Registro = CASE WHEN @Fecha_Registro = '' THEN NULL ELSE STR_TO_DATE(@Fecha_Registro, '%d/%m/%Y') END;
-- Se consulta
SELECT * 
FROM clientes;

-- Tabla 'Producto'
CREATE TABLE IF NOT EXISTS Producto(
    ID_Producto INT PRIMARY KEY,
    Nombre_producto VARCHAR (255),
    Categoria VARCHAR (255),
    Precio_Unitario DECIMAL(20,2),
    Stock INT
);
-- Se ingresan valores a la tabla 'Producto', como son muchas filas, se hace importacion de archivos
LOAD DATA INFILE  
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/productos.csv'
INTO TABLE Producto
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
;
-- Se consulta
SELECT * 
FROM producto;

--Para establecer una relación de clave foránea entre la tabla Producto y la tabla Categorias, se agrega una nueva columna ID_Categoria en la tabla Producto. Esta columna almacenará el ID de la categoría correspondiente a cada producto, para luego definir la  FOREIGN KEY.
ALTER TABLE Producto
ADD COLUMN ID_Categoria INT;

-- Se agrega valores ID a la nueva columna
UPDATE Producto AS p
JOIN Categorias AS c ON p.Categoria = c.Categoria
SET p.ID_Categoria = c.ID_Categoria;

-- Se establece clave foránea en tabla Producto
ALTER TABLE Producto
ADD CONSTRAINT fk_producto_categoria
FOREIGN KEY (ID_Categoria) REFERENCES categorias(ID_Categoria);

-- Tabla 'Ventas'
CREATE TABLE IF NOT EXISTS Ventas(
    ID_Venta INT PRIMARY KEY,
    Fecha DATE,
    ID_Cliente INT,
    ID_Producto INT,
    Cantidad INT,
    Metodo_Pago INT,
    Estado VARCHAR (255),
    FOREIGN KEY (Metodo_Pago) REFERENCES metodo_pago(ID_Metodo),
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente),
    FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto)
)
-- Se ingresan valores a la tabla 'Ventas' mediante importacion
-- Se detectaron lineas duplicadas en el archivo que correspondian
-- a una misma venta, se agrega IGNORE para descartar valores duplicados
LOAD DATA INFILE  
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ventas.csv'
IGNORE
INTO TABLE Ventas
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(ID_Venta, @Fecha, ID_Cliente, ID_Producto, Cantidad, Metodo_Pago,Estado)
SET Fecha = CASE WHEN @Fecha = '' THEN NULL ELSE STR_TO_DATE(@Fecha, '%d/%m/%Y') END;
;
SELECT *
FROM ventas;


