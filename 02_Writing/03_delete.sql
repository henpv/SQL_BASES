/*
==============================================================
SECCIÓN 3: DELETE EN SQL
==============================================================

1. ¿QUÉ ES EL COMANDO DELETE?
--------------------------------------------------------------
El comando **DELETE** se usa para **eliminar registros existentes**
de una tabla en una base de datos.

Puede eliminar:
 - Un solo registro.
 - Varios registros que cumplan una condición.
 - Todos los registros de una tabla (si no se usa WHERE).

⚠️ Importante:
DELETE **no borra la estructura de la tabla**, solo los datos contenidos en ella.

==============================================================
2. ESTRUCTURA BÁSICA DE DELETE
==============================================================
DELETE FROM nombre_tabla
WHERE condición;

Ejemplo:
--------------------------------------------------------------
-- Eliminar un empleado específico
DELETE FROM empleados
WHERE id = 3;

Explicación:
Elimina el registro donde el campo “id” sea igual a 3.

==============================================================
3. ELIMINAR VARIOS REGISTROS
--------------------------------------------------------------
Puedes eliminar varios registros a la vez usando condiciones lógicas.

Ejemplo:
--------------------------------------------------------------
-- Eliminar empleados con salario inferior a 2500
DELETE FROM empleados
WHERE salario < 2500;

-- Eliminar todos los registros de un cargo específico
DELETE FROM empleados
WHERE cargo = 'Practicante';

==============================================================
4. ELIMINAR TODOS LOS REGISTROS (SIN WHERE)
--------------------------------------------------------------
⚠️ PELIGRO: Si no se incluye una cláusula WHERE, se eliminarán **todos**
los registros de la tabla.

Ejemplo:
--------------------------------------------------------------
DELETE FROM empleados;

Explicación:
Borra todos los datos de la tabla “empleados”, pero la estructura permanece.

==============================================================
5. DIFERENCIA ENTRE DELETE Y TRUNCATE
--------------------------------------------------------------
Ambos eliminan registros, pero tienen diferencias importantes:

DELETE:
 - Se puede usar con condiciones (WHERE).
 - Se puede revertir si está dentro de una transacción.
 - Es más lento porque borra fila por fila.
 - Activa triggers (si existen).

TRUNCATE:
 - Borra **todos** los registros sin posibilidad de condición.
 - No puede usarse con WHERE.
 - Es mucho más rápido.
 - Reinicia los contadores AUTO_INCREMENT.
 - No activa triggers en la mayoría de los motores.

Ejemplo:
--------------------------------------------------------------
TRUNCATE TABLE empleados;

==============================================================
6. ELIMINAR USANDO SUBCONSULTAS
--------------------------------------------------------------
Puedes eliminar registros según el resultado de otra consulta.

Ejemplo:
--------------------------------------------------------------
-- Eliminar empleados que no tengan registros en la tabla “proyectos”
DELETE FROM empleados
WHERE id NOT IN (
    SELECT id_empleado FROM proyectos
);

Explicación:
Solo se eliminan los empleados que no están asignados a ningún proyecto.

==============================================================
7. ELIMINAR REGISTROS RELACIONADOS ENTRE TABLAS (CON JOIN)
--------------------------------------------------------------
En MySQL, puedes combinar **DELETE** con **JOIN** para borrar datos
dependientes en múltiples tablas.

Ejemplo:
--------------------------------------------------------------
-- Eliminar todos los pedidos asociados a un cliente específico
DELETE p
FROM pedidos AS p
JOIN clientes AS c ON p.id_cliente = c.id
WHERE c.nombre = 'Juan Pérez';

Explicación:
Elimina de la tabla “pedidos” todos los registros cuyo cliente sea “Juan Pérez”.

==============================================================
8. ELIMINAR CON LIMIT (MySQL)
--------------------------------------------------------------
En MySQL puedes limitar la cantidad de registros a eliminar.

Ejemplo:
--------------------------------------------------------------
DELETE FROM logs
WHERE nivel = 'DEBUG'
LIMIT 100;

Explicación:
Elimina solo los primeros 100 registros que cumplan la condición.

==============================================================
9. ELIMINAR REGISTROS CON CLAVES FORÁNEAS
--------------------------------------------------------------
Cuando existen relaciones entre tablas (FOREIGN KEY), debes asegurarte
de no violar la integridad referencial.

Ejemplo:
--------------------------------------------------------------
-- Si la tabla “pedidos” tiene una FK hacia “clientes”:
DELETE FROM clientes WHERE id = 10;

Posibles resultados:
 - Si existe un pedido con ese id_cliente, el DELETE fallará (si no hay ON DELETE CASCADE).
 - Si la relación tiene ON DELETE CASCADE, los pedidos relacionados se eliminarán automáticamente.

Explicación:
**ON DELETE CASCADE** es una regla que permite eliminar los registros hijos
automáticamente cuando se borra el padre.

==============================================================
10. USAR TRANSACCIONES PARA MAYOR SEGURIDAD
--------------------------------------------------------------
Para evitar pérdidas de datos irreversibles, es recomendable usar
transacciones en eliminaciones críticas.

Ejemplo:
--------------------------------------------------------------
START TRANSACTION;

DELETE FROM empleados
WHERE salario < 2000;

-- Si todo está correcto:
COMMIT;

-- Si detectas un error:
ROLLBACK;

Explicación:
Puedes revertir los cambios si te das cuenta de un error antes del COMMIT.

==============================================================
11. ELIMINAR DATOS DUPLICADOS
--------------------------------------------------------------
En MySQL, puedes usar una subconsulta con ROW_NUMBER o técnicas similares
para eliminar duplicados dejando solo uno.

Ejemplo:
--------------------------------------------------------------
-- Eliminar registros duplicados por nombre, dejando el menor ID
DELETE e1
FROM empleados AS e1
JOIN empleados AS e2 
ON e1.nombre = e2.nombre AND e1.id > e2.id;

Explicación:
Compara la tabla consigo misma y elimina los duplicados con un ID mayor.

==============================================================
12. BUENAS PRÁCTICAS
--------------------------------------------------------------
1. Usa SIEMPRE una cláusula WHERE (a menos que estés 100% seguro).
2. Realiza un **SELECT** previo para confirmar qué filas serán afectadas.
3. Usa **transacciones** para proteger tus datos.
4. Realiza **copias de seguridad** antes de eliminar registros masivos.
5. Evita borrar registros en tablas relacionadas sin revisar claves foráneas.
6. Usa **LIMIT** en MySQL para eliminar por lotes grandes volúmenes.
7. Si necesitas limpiar toda la tabla, considera **TRUNCATE** (más rápido).
8. Revisa los **triggers** antes de ejecutar un DELETE masivo.

==============================================================
13. RESUMEN GENERAL
--------------------------------------------------------------
• DELETE elimina registros de una tabla.
• Sin WHERE, elimina todos los registros.
• Puede usarse con condiciones, subconsultas y JOIN.
• Usa transacciones para evitar pérdidas irreversibles.
• TRUNCATE borra todos los registros más rápido, pero sin reversión.
• ON DELETE CASCADE elimina automáticamente registros relacionados.
• Siempre valida los datos antes de eliminar.
==============================================================
*/

-- Elimina el registro de la tabla "users" con identificador igual a 11
DELETE FROM users WHERE user_id = 11;