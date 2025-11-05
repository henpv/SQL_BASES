/*
==============================================================
SECCIÓN 4: CLAÚSULA ORDER BY EN SQL
==============================================================

1. ¿Qué es ORDER BY?
--------------------------------------------------------------
La cláusula ORDER BY se utiliza para ordenar los resultados
de una consulta en orden ASCENDENTE o DESCENDENTE,
según una o más columnas.

Por defecto, los resultados se ordenan en orden ASCENDENTE (ASC).

==============================================================
2. ESTRUCTURA BÁSICA
==============================================================
SELECT columnas
FROM tabla
ORDER BY columna [ASC | DESC];

Ejemplo:
--------------------------------------------------------------
-- Listar los usuarios ordenados por nombre de forma ascendente
SELECT nombre, correo
FROM usuarios
ORDER BY nombre ASC;

-- Listar los usuarios ordenados por nombre de forma descendente
SELECT nombre, correo
FROM usuarios
ORDER BY nombre DESC;

==============================================================
3. ORDENAR POR VARIAS COLUMNAS
==============================================================
Puedes ordenar los resultados según más de una columna.
El orden de prioridad se respeta según la posición en la lista.

Ejemplo:
--------------------------------------------------------------
-- Ordenar primero por país (ascendente) y luego por nombre (descendente)
SELECT nombre, pais
FROM usuarios
ORDER BY pais ASC, nombre DESC;

Explicación:
Primero agrupa por país de la A a la Z, 
y dentro de cada país, ordena los nombres de la Z a la A.

==============================================================
4. USAR ALIAS EN ORDER BY
==============================================================
Si en tu SELECT defines alias para las columnas, 
puedes usarlos también en ORDER BY.

Ejemplo:
--------------------------------------------------------------
-- Mostrar nombre completo y ordenar por él
SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo
FROM usuarios
ORDER BY nombre_completo ASC;

==============================================================
5. ORDENAR POR POSICIÓN DE COLUMNA
==============================================================
También puedes usar el número de la columna en lugar del nombre.
Esto no es recomendable, pero es válido en SQL.

Ejemplo:
--------------------------------------------------------------
-- Ordenar por la segunda columna
SELECT nombre, edad, pais
FROM usuarios
ORDER BY 2 DESC;

Aquí se ordena por “edad” (segunda columna del SELECT).

==============================================================
6. ORDENAR RESULTADOS NUMÉRICOS Y DE TEXTO
==============================================================
SQL ordena los datos según su tipo:

- Texto: en orden alfabético (A–Z o Z–A)
- Números: en orden creciente o decreciente
- Fechas: de la más antigua a la más reciente (ASC) o viceversa (DESC)

Ejemplos:
--------------------------------------------------------------
-- Ordenar usuarios por edad (número)
SELECT nombre, edad
FROM usuarios
ORDER BY edad ASC;

-- Ordenar por fecha de registro más reciente
SELECT nombre, fecha_registro
FROM usuarios
ORDER BY fecha_registro DESC;

==============================================================
7. COMBINAR ORDER BY CON WHERE Y LIMIT
==============================================================
ORDER BY se puede combinar con otras cláusulas
para obtener resultados más específicos.

Ejemplo:
--------------------------------------------------------------
-- Obtener los 5 usuarios más recientes
SELECT nombre, correo, fecha_registro
FROM usuarios
WHERE estado = 'activo'
ORDER BY fecha_registro DESC
LIMIT 5;

==============================================================
8. ORDENAR POR EXPRESIONES O FUNCIONES
==============================================================
También puedes ordenar los resultados usando expresiones calculadas.

Ejemplos:
--------------------------------------------------------------
-- Ordenar por la longitud del nombre
SELECT nombre
FROM usuarios
ORDER BY LENGTH(nombre) DESC;

-- Ordenar por el año de la fecha de registro
SELECT nombre, fecha_registro
FROM usuarios
ORDER BY YEAR(fecha_registro) ASC;

==============================================================
9. RESUMEN GENERAL
==============================================================
ORDER BY               -> Ordena los resultados de la consulta
ASC                    -> Ascendente (por defecto)
DESC                   -> Descendente
VARIAS COLUMNAS        -> ORDER BY col1 ASC, col2 DESC
ALIAS O NÚMEROS        -> Se pueden usar en lugar del nombre real
SE PUEDE COMBINAR CON  -> WHERE, LIMIT, DISTINCT, GROUP BY

==============================================================
*/

-- Ordena todos los datos de la tabla "users" por edad (ascendente por defecto)
SELECT * FROM users ORDER BY age;

-- Ordena todos los datos de la tabla "users" por edad de manera ascendente
SELECT * FROM users ORDER BY age ASC;

-- Ordena todos los datos de la tabla "users" por edad de manera descendente
SELECT * FROM users ORDER BY age DESC;

-- Obtiene todos los datos de la tabla "users" con email igual a sara@gmail.com y los ordena por edad de manera descendente
SELECT * FROM users WHERE email='sara@gmail.com' ORDER BY age DESC;

-- Obtiene todos los nombres de la tabla "users" con email igual a sara@gmail.com y los ordena por edad de manera descendente
SELECT name FROM users WHERE email='sara@gmail.com' ORDER BY age DESC;