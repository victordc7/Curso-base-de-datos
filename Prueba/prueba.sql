DROP DATABASE IF EXISTS libreria_cf;

CREATE DATABASE IF NOT EXISTS libreria_cf;

USE libreria_cf;

CREATE TABLE IF NOT EXISTS autores(
    autor_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, 
    nombre VARCHAR(25) NOT NULL,
    apellido VARCHAR(25)NOT NULL,
    seudonimo VARCHAR(50) UNIQUE,
    genero ENUM('M','F') NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    pais_origen VARCHAR(40) NOT NULL,
    fecha_creacion DATETIME DEFAULT current_timestamp
);

CREATE TABLE IF NOT EXISTS libros(
    libro_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    autor_id INT UNSIGNED NOT NULL,
    titulo VARCHAR(50) NOT NULL,
    descripcion VARCHAR(250),
    paginas INT UNSIGNED,
    fecha_publicacion DATE NOT NULL,
    fecha_creacion DATETIME DEFAULT NOW(),
    FOREIGN KEY (autor_id) REFERENCES autores(autor_id)
);    


INSERT INTO autores(nombre, apellido, seudonimo, genero, fecha_nacimiento, pais_origen)
VALUES  ('Victor','del Carpio',NULL,'M','1994-04-07','Venezuela'),
        ('Joanne','Rowling','J.K. Rowling','f','1965-07-31','Reino Unido'),
        ('Stephen Edwin','King','Richard Bachman','M','1947-09-27','USA')
;

INSERT INTO libros(autor_id,titulo,fecha_publicacion)
VALUES  (1,'Biografia por VDC','2018-10-01'),
        (2,'Harry Potter y la Piedra Filosofal', '1997-06-30'),
        (2,'Harry Potter y la Camara Secreta', '1998-07-02'),
        (2,'Harry Potter y el Prisionero de Azkaban', '1990-07-08'),
        (2,'Harry Potter y la Orden del Fenix', '2003-06-21'),
        (2,'Harry Potter y el Caliz de Fuego', '2000-03-20'),
        (3,'El Resplandor','1977-01-01')
;


SELECT * FROM autores;
SELECT * FROM libros;