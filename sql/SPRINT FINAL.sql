CREATE DATABASE TeLoVendo; /*Creacion de la base de datos*/
create user 'gestor' identified by 'gestor123'; /*Creacion de usuario gestor*/
grant select, create, insert, delete, update on TeLoVendo.* to 'gestor'; /*Asignacion de permisos*/


/*Creacion de tablas*/
CREATE TABLE proveedor (
    id_proveedor INT NOT NULL AUTO_INCREMENT,
    nombre_rep VARCHAR(100) NOT NULL,
    nombre_corp VARCHAR(150) NOT NULL,
    categoria_prod VARCHAR(50) NOT NULL, /*electronico,abarrotes, sonido*/
    telefono1 VARCHAR(50) NOT NULL,
    telefono2 VARCHAR(50) NOT NULL,
    asistente VARCHAR(100) NOT NULL,
    correo VARCHAR(250) NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id_proveedor)
);
CREATE TABLE cliente (
    id_cliente INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    direccion VARCHAR(250) NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id_cliente)
);
CREATE TABLE producto (
    id_producto INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(250) NOT NULL,
    precio INT NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    color VARCHAR(15) NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id_producto)
);

CREATE TABLE detalle_producto (
    id_detalle INT NOT NULL AUTO_INCREMENT,
    id_producto INT NOT NULL,
    id_proveedor INT NOT NULL,
    stock INT NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_producto)
        REFERENCES producto (id_producto),
    FOREIGN KEY (id_proveedor)
        REFERENCES proveedor (id_proveedor),
    PRIMARY KEY (id_detalle)
);

/* INSERT DE DATOS*/
INSERT INTO cliente (nombre, apellido, direccion)
values  ("Luis","Aguirre","Marchant Pereira 190"),
		("Ana","Diaz","Calle Antonio Varas 215"),
		("Claudia","Medina","Avenida Alemania, 0241"),
		("Raúl","Lopez","Calle Club Hípico, 1320 - Dpto.402"),
		("Mirta","Torres","Gran Avda. José M.Carrera 9306");
        
INSERT INTO producto (nombre, precio,categoria, color) 
values	("Licuadora Somela Berry Blender",19990,"Licuadoras","rojo"),
		("Panasonic TC-55HX550P",299990,"Televisores","negro"),
		("LG GB37MPD",389990,"Refrigeradores","gris"),
		("Samsung HW-Q700A",599990,"Audio","negro"),
		("Rosen Futón Violet Azul",449990,"Sillones y Sofas","azul"),
        ("Samsung QN55QN90A",799990,"Televisores","negro"),
		("Samsung QN55QN90B",1099990,"Celulares","gris"),
		("LG Velvet",279990,"Celulares","blanco"),
		("Estufa Somela Carbono Ecoheat Pro He1000",47990,"Estufas y calefactores","gris"),
		("Rosen Bergere Orson Stone",399990,"Sillones y Sofas","negro");
INSERT INTO proveedor (nombre_rep,nombre_corp,categoria_prod,telefono1,telefono2,asistente,correo)
values	('Juan Alfaro', 'SAMSUNG', 'Electronico', '962788869', '980706077', 'Maria Larrain', 'samsungmaria@gmail.com'),
		('Alfonso Perez', 'LG', 'Electronico', '969088869', '980765341', 'Margarita Estay', 'lgmargarita@gmail.com'),
		('Marisol Opazo', 'SOMELA', 'Electrodomestico', '912388869', '980888877', 'Mario Saavedra', 'somelamario@gmail.com'),
		('Cataliana Villalobos', 'ROSEN', 'Mueble', '945688869', '980704589', 'Luis Silva', 'rosenluis@gmail.com'),
		('Sebastian Torres', 'PANASONIC', 'Electronico', '987498869', '98079980', 'Ernesto Carvallo', 'panasonicernesto@gmail.com');


INSERT INTO detalle_producto(id_producto,id_proveedor,stock)
values  (1,3,28),
		(2,5,10),
        (3,2,5),
        (4,1,12),
        (5,4,42),
        (6,1,5),
        (7,1,1),
        (8,2,8),
        (9,3,24),
        (10,4,16);

/*Categoria de productos que mas se repite*/
SELECT 
    categoria, COUNT(categoria)
FROM
    producto
GROUP BY categoria
ORDER BY COUNT(categoria) DESC
LIMIT 1;

/*Producto con mayor stock*/
SELECT 
    p.nombre, d.stock
FROM
    producto p
        INNER JOIN
    detalle_producto d ON (p.id_producto = d.id_producto)
WHERE
    (SELECT d.stock)
ORDER BY stock DESC
LIMIT 1;

/*Color de productos que mas se repite*/
SELECT 
    color, COUNT(color)
FROM
    producto
GROUP BY color
ORDER BY COUNT(color) DESC
LIMIT 1;

/*  proveedores con menor stock de productos.*/
SELECT 
    p.nombre_corp, d.stock
FROM
    proveedor p
        INNER JOIN
    detalle_producto d ON (p.id_proveedor = d.id_proveedor)
WHERE
    (SELECT d.stock)
GROUP BY nombre_corp
ORDER BY stock ASC
LIMIT 1;

/* cambio de la categoría de productos más popular por ‘Electrónica y computación’. */
set @cambioCategoria =
(SELECT 
    categoria
FROM
    producto
GROUP BY categoria
ORDER BY COUNT(categoria) DESC
LIMIT 1);
UPDATE producto 
SET 
    categoria = 'Electrónica y computación'
WHERE
    categoria = @cambioCategoria