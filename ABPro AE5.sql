/*Crear dos tablas*/

CREATE TABLE usuario (
    id_usuario INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    contrasenia VARCHAR(200) NOT NULL,
    zona_horaria VARCHAR(100) NOT NULL DEFAULT 'UTC-3',
    genero CHAR,
    telefono VARCHAR(100),
    PRIMARY KEY (id_usuario)
);

CREATE TABLE ingreso (
    id_ingreso INT NOT NULL AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    fecha_hora DATETIME DEFAULT NOW(),
    PRIMARY KEY (id_ingreso),
    FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)
);

/*Modificacion de la tabla*/
ALTER TABLE usuario
CHANGE COLUMN zona_horaria zona_horaria VARCHAR(100) NOT NULL DEFAULT 'UTC-2' ;

/* Creacion de registros */
insert into usuario(nombre,apellido,contrasenia,genero,telefono)
values  ("Maria","Troncoso","123456",'F',"2 6232367"),
		("Juana","Medina","123456",'F',"(2) 9852826"),
		("Silvio","Paramal","123456",'M',"(9) 76094079"),
		("Armando","Basek","123456",'M',"(32) 2821036"),
		("Ariel","Rojas","123456",'O',"(45) 213172"),
		("Alicia","Ruiz","123456",'F',"(9) 76971842"),
		("Cintia","Gonzalez","123456",'F',"(63) 225723"),
		("Jhon","Salchichon","123456",'M',"9971495");
        

insert into ingreso (id_usuario)
values (3),
(4),
(2),
(1),
(5),
(7),
(8),
(6);

/*
	Justifique cada tipo de dato utilizado. ¿Es el óptimo en cada caso?
    
    Para id(s) se utilizo el tipo INT para asegurarse de que sea auto incrementable y no se repita el registro,
    Para la fecha-hora se utilizo el tipo DATETIME que convenientemente almacena este tipo de informacion,
    Para el genero se utilizo el tipo CHAR como representacion basica del genero del individuo, sin limitaciones aceptando valores como F, M, O(otros).
    Para el resto de los campos se utilizo el tipo VARCHAR que permite flexibilidad al momento de ingresar informacion como nombres, correos o cualquier cadena de texto.
    
    A nuestro entendimiento corresponde al tipo optimo para cada caso.
*/

/* Creacion */
CREATE TABLE contacto (
    id_contacto INT NOT NULL AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    telefono VARCHAR(100),
    correo VARCHAR(250),
    PRIMARY KEY (id_contacto)
);

/*Modificacion de las tablas*/
select * from usuario;

insert into contacto (id_usuario, telefono) SELECT id_usuario, telefono from usuario;

        UPDATE contacto SET correo = 'maria.troncoso@correo.org' WHERE (id_contacto = 1);
        UPDATE contacto SET correo = 'juana.medina@correo.org' WHERE (id_contacto = 2);
        UPDATE contacto SET correo = 'silvio.paramal@correo.org' WHERE (id_contacto = 3);
        UPDATE contacto SET correo = 'armando.basek@correo.org' WHERE (id_contacto = 4);
        UPDATE contacto SET correo = 'ariel.rojas@correo.org' WHERE (id_contacto = 5);
        UPDATE contacto SET correo = 'alicia.ruiz@correo.org' WHERE (id_contacto = 6);
        UPDATE contacto SET correo = 'cintia.gonzalez@correo.org' WHERE (id_contacto = 7);
        UPDATE contacto SET correo = 'jhon.salchichon@correo.org' WHERE (id_contacto = 8);

alter table usuario drop column telefono; /*Se elimina columna en la tabla de usuario*/


ALTER TABLE contacto
ADD CONSTRAINT `id_usuario`
  FOREIGN KEY (id_usuario)
  REFERENCES usuario(id_usuario)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;



/* SELECT DE PRUEBA*/
SELECT 
    u.nombre, u.apellido, c.telefono, c.correo
FROM
    usuario u
        INNER JOIN
    contacto c ON (u.id_usuario = c.id_usuario);
