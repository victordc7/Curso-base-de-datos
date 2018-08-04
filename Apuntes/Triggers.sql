En MySQL un trigger, también conocido como disparador (Por su traducción al español) es un conjunto de sentencias SQL que se ejecutan de forma automática cuando ocurre algún evento de tipo de modificación en una tabla, pero no una modificación de estructura, si no una modificación en cuando a los datos almacenados, es decir, cuando se ejecute una sentencia INSERT, UPDATE o DELETE.

A diferencia de una función o un store procedure un trigger no puede existir sin una tabla asociada.

Lo interresante aquí es que nosotros podemos programar los triggers de tal manera que se puedan ejecutar antes o después de dichas sentencias; Dando como resultado seis combinaciones de eventos.

BEFORE INSERT Acciones a realizar antes de insertar uno más o registros en una tabla.

AFTER INSERT Acciones a realizar después de insertar uno más o registros en una tabla.

BEFORE UPDATE Acciones a realizar antes de actualizar uno más o registros en una tabla.

AFTER UPDATE Acciones a realizar después de actualizar uno más o registros en una tabla.

BEFORE DELETE Acciones a realizar antes de eliminar uno más o registros en una tabla.

AFTER DELETE Acciones a realizar después de eliminar uno más o registros en una tabla.

A partir de la versión 5.7.2 de MySQL nosotros podemos tener la n cantidad de triggers asociados a una tabla. Anteriormente estábamos limitados a tener un máximo de seis trigger por tabla (Uno por cada combinación evento).

Algo importante a mencionar es que la sentencia TRUNCATE no ejecutará un trigger.

Ventajas de Utilizar triggers

Con los triggers nosotros podemos validar datos los cuales no pudieron ser validados mediante un constraint. De esta forma podemos mantener un integridad de datos.
Los triggers nos permitirán ejecutar reglas de negocios. Utilizando la combinación de eventos nosotros podemos realizar acciones sumamente complejas.
Con los triggers nosotros podemos programar tareas.
Los trigger nos permitirán llevar un control de los cambios realizados en una tabla. Para esto nos debemos de apoyar de una segunda tabla (Comúnmente una tabla log).


Desventajas de Utilizar triggers

Los triggers al ejecutarse de forma automática puede dificultar llevar un control sobre qué sentencias SQL fueron ejecutadas.

Los triggers incrementa la sobrecarga del servidor. Un mal uso de triggers puede tornarse en respuestas lentas por parte del servidor.