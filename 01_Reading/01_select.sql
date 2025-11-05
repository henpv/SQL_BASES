/*
==============================================================
SECCIÓN 1: COMANDO SELECT EN SQL
==============================================================

1. ¿Qué es SELECT?
------------------------------------------------
El comando SELECT se utiliza para CONSULTAR o LEER datos almacenados en una base de datos.
Es el comando más importante de SQL, ya que nos permite obtener información
de una o varias tablas, aplicar filtros, ordenar resultados, y mucho más.

Estructura básica:
------------------------------------------------
SELECT columnas
FROM tabla;

Ejemplo:
------------------------------------------------
SELECT nombre, correo
FROM usuarios;

Esto obtiene únicamente las columnas “nombre” y “correo”
de todos los registros de la tabla “usuarios”.

==============================================================
2. SELECCIONAR TODAS LAS COLUMNAS
==============================================================
Usa el asterisco (*) para seleccionar TODAS las columnas de una tabla.

Ejemplo:
------------------------------------------------
SELECT * FROM usuarios;

Nota: Es útil para pruebas rápidas, pero en sistemas reales
es mejor especificar las columnas necesarias (por rendimiento y claridad).

==============================================================
3. ELIMINAR DUPLICADOS CON DISTINCT
==============================================================
DISTINCT elimina filas duplicadas en los resultados.

Ejemplo:
------------------------------------------------
-- Mostrar solo los países distintos de los usuarios registrados
SELECT DISTINCT pais
FROM usuarios;

==============================================================
4. APLICAR CONDICIONES CON WHERE
==============================================================
WHERE sirve para filtrar los resultados según una o más condiciones.

Ejemplo:
------------------------------------------------
-- Mostrar los usuarios activos mayores de 18 años
SELECT nombre, edad
FROM usuarios
WHERE estado = 'activo' AND edad >= 18;

==============================================================
5. ORDENAR RESULTADOS CON ORDER BY
==============================================================
ORDER BY permite ordenar los resultados en orden ascendente o descendente.

Ejemplo:
------------------------------------------------
-- Listar los usuarios ordenados alfabéticamente por nombre
SELECT nombre, correo
FROM usuarios
ORDER BY nombre ASC;

-- Orden descendente
SELECT nombre, correo
FROM usuarios
ORDER BY nombre DESC;

==============================================================
6. LIMITAR RESULTADOS CON LIMIT
==============================================================
LIMIT restringe el número de filas devueltas.

Ejemplo:
------------------------------------------------
-- Mostrar solo los primeros 5 usuarios
SELECT nombre, correo
FROM usuarios
LIMIT 5;

==============================================================
7. COMBINAR VARIAS OPCIONES
==============================================================
Puedes usar todas las cláusulas juntas para consultas más precisas.

Ejemplo:
------------------------------------------------
-- Obtener los 10 usuarios activos más recientes
SELECT nombre, correo, fecha_registro
FROM usuarios
WHERE estado = 'activo'
ORDER BY fecha_registro DESC
LIMIT 10;

==============================================================
8. RESUMEN GENERAL
==============================================================
SELECT     -> Qué columnas quieres ver
FROM       -> De qué tabla provienen los datos
WHERE      -> Condiciones o filtros
ORDER BY   -> Orden de los resultados
LIMIT      -> Cantidad máxima de registros a mostrar

==============================================================
*/
-- Ejemplos
-- Obtiene todos los datos de la tabla "users"
SELECT * FROM users LIMIT 10;

-- Obtiene todos los nombres de la tabla "users"
SELECT name FROM users;

-- Obtiene todos los identificadores y nombres de la tabla "users"
SELECT user_id, name FROM users;
