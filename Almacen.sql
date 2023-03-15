CREATE SCHEMA Almacen;
USE Almacen; 

CREATE TABLE Producto(
id_producto INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, 
nombre_producto VARCHAR (20),
precio_producto INTEGER
);

CREATE TABLE Categoria(
id_categoria INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, 
nombre_categoria VARCHAR (30)
);

CREATE TABLE CategoriaProducto(
id_categoriaProducto INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
fk_id_categoria INTEGER,
fk_id_producto INTEGER
);

CREATE TABLE Proveedor(
id_proveedor INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_proveedor VARCHAR (30),
rut_proveedor VARCHAR (10)
);

CREATE TABLE ProductoProveedor(
id_productoProveedor INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
fk_id_producto INTEGER,
fk_id_proveedor INTEGER
);

CREATE TABLE FlujoDeCaja(
id_flujo INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
ingreso_diario INTEGER,
egreso_diario INTEGER,
utilidad_diaria INTEGER,
fecha DATE
);

CREATE TABLE Boleta(
id_boleta INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
num_boleta INTEGER,
medio_de_pago VARCHAR (10),
fecha DATE
);

ALTER TABLE ProductoProveedor
ADD FOREIGN KEY (fk_id_producto) REFERENCES Producto (id_producto);

ALTER TABLE ProductoProveedor
ADD FOREIGN KEY (fk_id_proveedor) REFERENCES Proveedor (id_proveedor);

ALTER TABLE CategoriaProducto
ADD FOREIGN KEY (fk_id_categoria) REFERENCES Categoria (id_categoria);

ALTER TABLE CategoriaProducto
ADD FOREIGN KEY (fk_id_producto) REFERENCES Producto (id_producto);

INSERT INTO FlujoDeCaja(ingreso_diario, egreso_diario, utilidad_diaria, fecha)
VALUES
(50000,30000,20000,"2023-03-15"),
(110000,80000,30000,"2023-03-14"),
(30000,10000,20000,"2023-03-13"),
(55000,33000,22000,"2023-03-12"),
(200000,50000,150000,"2022-12-31");

INSERT INTO Boleta(num_boleta, medio_de_pago, fecha)
VALUES
(100,"Débito", "2023-03-15"),
(99,"Efectivo", "2023-03-14"),
(98,"Débito", "2023-03-14"),
(97,"Débito", "2023-03-14"),
(96,"Débito", "2023-03-13"),
(95,"Efectivo", "2023-03-13"),
(94,"Débito", "2023-03-12"),
(1,"Débito", "2022-12-31");

INSERT INTO Proveedor(nombre_proveedor, rut_proveedor)
VALUES
("Ariztía", "11546587-9"),
("Florinda", "6546587-9"),
("Tucapel", "3656587-8"),
("Marcopolo", "11223875-2"),
("CCU", "20564789-4");

INSERT INTO Producto(nombre_producto, precio_producto)
VALUES
("Arroz", 1200),
("Papas Fritas", 2700),
("Cloro", 1000),
("Agua Mineral", 2000),
("Fideos", 950),
("Ramitas", 2700),
("Pollo", 3500);

INSERT INTO Categoria(nombre_categoria)
VALUES
("Higiene"),
("Despensa"),
("Bebestible"),
("Picoteo");

#erro1452: 
#INSERT INTO ProductoProveedor(fk_id_producto, fk_id_proveedor)
#VALUES
#(1, 3),
#(2, 4),
#(3, 2),
#(4, 5),
#(5, 3),
#(6, 4),
#(7, 1);
#


INSERT INTO CategoriaProducto(fk_id_categoria, fk_id_producto)
VALUES
(1,3),
(2, 1),
(2, 5),
(2, 7),
(3, 4),
(4, 2),
(4, 6);

#Consultas 

#Lista de boletas del año 2023 pagadas con débito.
SELECT * FROM Boleta WHERE medio_de_pago = "Débito" AND fecha > 2023-01-01;

#Lista de productos  con precio entre 1000 y 2000 pesos.
SELECT * FROM Producto WHERE precio_producto BETWEEN 1000 and 2000;

#Lista de productos ordenados por precio.
SELECT * FROM Producto ORDER BY precio_producto;

#Union de tabla Producto y Categoria

SELECT producto.id_producto, producto.nombre_producto, producto.precio_producto, categoria.id_categoria, categoria.nombre_Categoria FROM Producto LEFT JOIN CategoriaProducto ON producto.id_producto = CategoriaProducto.fk_id_producto RIGHT JOIN Categoria ON categoria.id_categoria = CategoriaProducto.fk_id_categoria;


#Informe anual sobre ganancias del año 2023
SELECT ingreso_diario FROM FlujoDeCaja WHERE fecha > 2023-01-01;
SELECT SUM(ingreso_diario) FROM FlujoDeCaja WHERE fecha > 2023-01-01;

#Informe anual sobre utilidades del año 2023
SELECT utilidad_diaria FROM FlujoDeCaja WHERE fecha > 2023-01-01;
SELECT SUM(utilidad_diaria) FROM FlujoDeCaja WHERE fecha > 2023-01-01;

