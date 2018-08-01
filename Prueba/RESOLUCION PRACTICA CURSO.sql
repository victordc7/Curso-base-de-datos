/* EJERCICIO 1
Obtener todos los libros escritos por autores que cuenten con un seudónimo.
*/
SELECT * FROM libros WHERE autor_id IN(SELECT autor_id FROM autores WHERE seudonimo IS NOT NULL);


/* EJERCICIO 2
Obtener el título de todos los libros publicados en el año actual cuyos autores poseen un pseudónimo.
*/
SELECT titulo FROM libros WHERE YEAR(fecha_publicacion) = YEAR(NOW()) AND autor_id IN(SELECT autor_id FROM autores WHERE seudonimo IS NOT NULL);


/* EJERCICIO 3
Obtener todos los libros escritos por autores que cuenten con un seudónimo y que hayan nacido antes de 1965.

NO FUNCIONA
*/
SELECT * FROM libros WHERE autor_id IN(SELECT autor_id FROM autores WHERE seudonimo IS NOT NULL) AND 1965 < (SELECT YEAR(fecha_nacimiento) FROM autores);


/* EJERCICIO 4
Colocar el mensaje no disponible a la columna descripción, en todos los libros publicados antes del año 2000.
*/
UPDATE libros SET descripcion = "no disponible" WHERE YEAR(fecha_publicacion) < 2000;


/* EJERCICIO 5
Obtener la llave primaria de todos los libros cuya descripción sea diferente de no disponible.
*/
SELECT libro_id FROM libros WHERE descripcion != no disponible;


/* EJERCICIO 6
Obtener el título de los últimos 3 libros escritos por el autor con id 2.
*/
SELECT titulo FROM libros WHERE autor_id = 2 ORDER BY fecha_publicacion DESC LIMIT 3;


/* EJERCICIO 7
Obtener en un mismo resultado la cantidad de libros escritos por autores con seudónimo y sin seudónimo.
*/
SELECT COUNT(seudonimo) AS "con seudonimo", COUNT(*)-COUNT(seudonimo) AS "sin seudonimo" FROM autores;


/* EJERCICIO 8
Obtener la cantidad de libros publicados entre enero del año 2000 y enero del año 2005.
*/
SELECT COUNT(fecha_publicacion) AS "Libros publicados entre 2000-2005" FROM libros WHERE fecha_publicacion BETWEEN '2000-01-01' AND '2005-01-01';


/* EJERCICIO 9
Obtener el título y el número de ventas de los cinco libros más vendidos.
*/
SELECT titulo,ventas FROM libros ORDER BY ventas DESC LIMIT 5;


/* EJERCICIO 10
Obtener el título y el número de ventas de los cinco libros más vendidos de la última década.
*/
SELECT titulo,ventas FROM libros WHERE fecha_publicacion BETWEEN (NOW() - INTERVAL 10 YEAR) AND NOW() ORDER BY ventas DESC LIMIT 5;


/* EJERCICIO 11
Obtener la cantidad de libros vendidos por los autores con id 1, 2 y 3.
*/
SELECT autor_id AS autor, SUM(ventas) AS ventas FROM libros GROUP BY autor_id HAVING autor_id REGEXP'^[123]';