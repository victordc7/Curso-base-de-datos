/* 
Que tipo de entidades? autores
Nombre(de la tabla): autores
*/




/* 
Datos de los autores
*/

Nombre
Genero
Fecha de nacimiento
Pais de origen 





/*
Crear columnas y el tipo de datos
El dato nombre es una coluna compuesta por eso la separaremos en 2
Como varios autores pueden repetir estos datos propuestos no los vamos a conciderar como duplicados.Pero nos hace falta crear una columna mas para diferenciar a los autores por eso agregaremos autor_id
*/


autor_id INT --solo almacena numeros enteros, sera nuestra llave primaria
nombre VARCHAR(25)
apellido VARCHAR(25)
genero CHAR(1) --M o F
fecha_nacimiento DATE --YYYY-MM-DD
pais_origen VARCHAR(40)


/*
Para crear la tabla usamos el comando CREATE TABLA nombreTabla();
*/

CREATE TABLE autores(
    autor_id INT, 
    nombre VARCHAR(25),
    apellido VARCHAR(25),
    genero CHAR(1),
    fecha_nacimiento DATE,
    pais_origen VARCHAR(40)
);


/*
Para insertar registros a la tabla
*/

INSERT INTO autores(autor_id, nombre, apellido, genero, fecha_nacimiento, pais_origen)
VALUES (1,'Test autor','Test autor','M','2018-07-25','Venezuela');

/*
No es necesario que utilices todas las columnas, podrias crear otro autor con el siguiente codigo. 
A las columnas que no llenes se les asigna el valor NULL
*/

INSERT INTO autores(autor_id, nombre)
VALUES (2,'Test autor');

/*
Para insertar varios registros a la vez  usamos la siguiente sentencia
*/

INSERT INTO autores(autor_id, nombre, apellido, genero, fecha_nacimiento, pais_origen)
VALUES  (1,'Test autor','Test autor','M','2018-07-25','Venezuela'),
        (2,'Test autor','Test autor','M','2018-07-25','Venezuela'),
        (3,'Test autor','Test autor','M','2018-07-25','Venezuela'),
        (4,'Test autor','Test autor','M','2018-07-25','Venezuela'),
        (5,'Test autor','Test autor','M','2018-07-25','Venezuela');

/*
LLAVES FORANEAS
En el siguiente codigo se muestra como se aplican.
En este caso como un autor puede tener muchos libros vamos a asociar al libro con su autor
Para ello repetimos el autor_id en la tabla del libro y al final de la creacion indicamos que la columna autor_id es una llave foranea, y a que tabla y columna hace referencia (se hace referencia a una llave primaria, que es el identificador del registro)

IMPORTANTE crear primero la tabla a la cual se hace referencia en este caso la tabla de autores
*/        

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

/*
Forma generica de realizar consultas
las condiciones usan los operadores =, <, >, <=, >=, (!= o <>) 
*/

SELECT lasColumnasQueQueramosVer FROM laTabla WHERE condiciones;

/*
Operadores logicos AND, OR, NOT
Con el operador AND todas las condiciones deben cumplirse apra que nos muestre el resultado
Con el operador OR basta que solo 1 condicon se cumpla para que muestre un resultado
Combinando AND y OR se mostraran todos los resultados que cumplan ambas condiciones dentro de cada parentesis (ver siguiente ejemplo)
*/

SELECT lasColumnasQueQueramosVer FROM laTabla WHERE (titulo ='algo' AND autor_id = 2) OR (titulo = 'otro algo' AND autor_id = 1);

/*
El operador NOT se utiliza para los datos que no tienen un valor. Ya que NULL no se puede usar como un tipo de dato no se puede usar una condicion como (seudonimo = NULL) en su lugar si queremos ver los autores que no tiene seudonimo usamos IS
*/

SELECT * FROM autores WHERE seudonimo IS NULL;

/*
Y en caso de querer ver los que si tienen seudonimo usariamos
*/

SELECT * FROM autores WHERE seudonimo IS NOT NULL;


/*
Sub Consultas
se realizan consultas dentro de otras para usar el resultado de la primera como condicion de la segunda
*/

SELECT autor_id FROM libros GROUP BY autor_id HAVING SUM(ventas) > (SELECT AVG(ventas) FROM libros);

/*
En este ejemplo se ejcutara primero la consulta del promedio, la que esta entre parentesis, y una vez obtenido este promedio se ejecutara la siguiente consulta.

A modo de repaso, en este ejemplo calculamos el promedio de ventas de cada libro, luego agrupamos todos los libros que tienen el mismo autor_id de la tabla libros, sumamos todos los libros vendidos por cada autor y lo compraramos con el promedio calculado anteriormente. Para finalizar devolviendo el autor_id de aquellos que hayan cumplido la condicion.

Como los autores_id pueden ser poco legibles podemos usar la consulta anterior como una subconsulta para mostrar el nombre y apellido del autor con la siguiente sentencia.
*/

SELECT CONCAT(nombre," ",apellido) FROM autores WHERE autor_id IN (SELECT autor_id FROM libros GROUP BY autor_id HAVING SUM(ventas) > (SELECT AVG(ventas) FROM libros));

