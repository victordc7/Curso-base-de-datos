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
*/
SELECT * FROM libros WHERE autor_id IN(SELECT autor_id FROM autores WHERE seudonimo IS NOT NULL AND YEAR(fecha_nacimiento) < 1965);


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


/* EJERCICIO 12
Obtener el título del libro con más páginas.
*/
SELECT titulo FROM libros WHERE paginas = (SELECT MAX(paginas) FROM libros);


/* EJERCICIO 13
Obtener todos los libros cuyo título comience con la palabra “La”.
*/
SELECT * FROM libros WHERE titulo LIKE 'La %';


/* EJERCICIO 14
Obtener todos los libros cuyo título comience con la palabra “La” y termine con la letra “a”.*/
SELECT * FROM libros WHERE titulo LIKE 'La %a';


/* EJERCICIO 15
Establecer el stock en cero a todos los libros publicados antes del año de 1995 Mostrar el mensaje “Disponible” si el libro con id 1 posee más de 5 ejemplares en stock, en caso contrario mostrar el mensaje “No disponible”.
*/
UPDATE libros SET stock = 0 WHERE YEAR(fecha_publicacion) < '1995';
SELECT IF((SELECT stock FROM libros WHERE libro_id=1)>5,"Disponible","No disponible") AS "Disponibilidad del libro";


/* EJERCICIO 16
Obtener el título los libros ordenador por fecha de publicación del más reciente al más viejo.
*/
SELECT titulo FROM libros ORDER BY fecha_publicacion DESC;


/* EJERCICIO 17
Obtener el nombre de los autores cuya fecha de nacimiento sea posterior a 1950
*/
SELECT nombre FROM autores WHERE 1950<YEAR(fecha_nacimiento);


/* EJERCICIO 18
Obtener la el nombre completo y la edad de todos los autores.
*/
SELECT CONCAT(nombre, ' ',apellido) AS "Nombre completo", IF(MONTH(NOW())<MONTH(fecha_nacimiento),(YEAR(NOW())-YEAR(fecha_nacimiento)-1),(YEAR(NOW())-YEAR(fecha_nacimiento))) AS Edad FROM autores;


/* EJERCICIO 19
Obtener el nombre completo de todos los autores cuyo último libro publicado sea posterior al 2005
*/
SELECT CONCAT(nombre," ",apellido) AS "Nombre completo" FROM autores WHERE autor_id IN (SELECT autor_id FROM libros GROUP BY autor_id HAVING YEAR(MAX(fecha_publicacion)) > 2005);


/* EJERCICIO 20
Obtener el id de todos los escritores cuyas ventas en sus libros superen el promedio.
*/
SELECT autor_id FROM libros GROUP BY autor_id HAVING SUM(ventas) > (SELECT AVG(SumaDeVentasPorAutor) FROM (SELECT SUM(ventas) AS SumaDeVentasPorAutor FROM libros GROUP BY autor_id) AS PromedioVentas);