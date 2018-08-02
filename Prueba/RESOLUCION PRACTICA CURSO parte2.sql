/* EJERCICIO 1
Obtener a todos los usuarios que han realizado un préstamo en los últimos diez días.
*/
SELECT DISTINCT
    usuarios.nombre AS Nombre_Usuarios
FROM usuarios
INNER JOIN libros_usuarios ON libros_usuarios.usuario_id = usuarios.usuario_id AND libros_usuarios.fecha_creacion >= NOW() - INTERVAL 10 DAY;


/* EJERCICIO 2
Obtener a todos los usuarios que no ha realizado ningún préstamo.
*/
SELECT
  CONCAT(usuarios.nombre, " ", usuarios.apellidos) AS nombre_usuario
FROM usuarios
LEFT JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id WHERE libros_usuarios.libro_id IS NULL;


/* EJERCCIO 3
Listar de forma descendente a los tres usuarios con más préstamos.
*/
SELECT
    usuarios.nombre AS Nombre_Usuarios,
    COUNT(usuarios.usuario_id) AS Total_prestamos
FROM usuarios
INNER JOIN libros_usuarios ON libros_usuarios.usuario_id = usuarios.usuario_id GROUP BY usuarios.usuario_id ORDER BY Total_prestamos DESC LIMIT 3;


/* EJERCICIO 4
Listar 5 títulos con más préstamos en los últimos 30 días.
*/
SELECT 
    libros.titulo AS Titulos,
    COUNT(libros.libro_id) AS TOTAL_PRESTADOS
FROM libros
INNER JOIN libros_usuarios ON libros_usuarios.libro_id = libros.libro_id
                AND libros_usuarios.fecha_creacion >= NOW() - INTERVAL 1 MONTH
GROUP BY libros.libro_id ORDER BY TOTAL_PRESTADOS DESC LIMIT 5;


/* EJERCICIO 5
Obtener el título de todos los libros que no han sido prestados.
*/
SELECT
    libros.titulo AS Titulos,
    COUNT(libros_usuarios.usuario_id) AS TOTAL_PRESTADOS
FROM libros
LEFT JOIN libros_usuarios ON libros_usuarios.libro_id = libros.libro_id
WHERE  libros_usuarios.usuario_id IS NULL
GROUP BY libros.libro_id;


/* EJERCICIO 6
Obtener la cantidad de libros prestados el día de hoy.
*/
SELECT
    DATE(libros_usuarios.fecha_creacion) AS Fecha_prestamo,
    COUNT(libros_usuarios.fecha_creacion) AS Total_libros_prestados
FROM libros_usuarios
WHERE DATE(fecha_creacion) = DATE(NOW())
GROUP BY DATE(fecha_creacion);


/* EJERCICIO 7
Obtener la cantidad de libros prestados por el autor con id 1.
*/
SELECT
    libros.autor_id,
    COUNT(libros.libro_id) AS Total_libros_prestados
FROM libros_usuarios
INNER JOIN libros ON libros_usuarios.libro_id = libros.libro_id
WHERE libros.autor_id = 1 AND libros.libro_id IN (libros_usuarios.libro_id)
GROUP BY libros.autor_id;


/* EJERCICIO 8
Obtener el nombre completo de los cinco autores con más préstamos.
*/
SELECT
    libros.autor_id,
    COUNT(libros.libro_id) AS Total_libros_prestados
FROM libros_usuarios
INNER JOIN libros ON libros_usuarios.libro_id = libros.libro_id
WHERE libros.libro_id IN (libros_usuarios.libro_id)
GROUP BY libros.autor_id
ORDER BY Total_libros_prestados DESC LIMIT 5;


/* EJERCICIO 9
Obtener el título del libro con más préstamos esta semana.
*/
SELECT
    libros.titulo,
    COUNT(libros.libro_id) AS Total_libros_prestados
FROM libros_usuarios
INNER JOIN libros ON libros_usuarios.libro_id = libros.libro_id
WHERE libros.libro_id IN (libros_usuarios.libro_id) AND DATE(libros_usuarios.fecha_creacion) >= DATE(NOW()) - INTERVAL 7 DAY
GROUP BY libros.titulo
ORDER BY Total_libros_prestados DESC LIMIT 1;