/*
==============================================================
SECCIÓN 7: CLAÚSULA LIMIT EN SQL
==============================================================

1. ¿Qué es LIMIT?
--------------------------------------------------------------
La cláusula LIMIT se utiliza para restringir la cantidad de registros
que devuelve una consulta.

Es muy útil cuando solo necesitas ver una parte de los resultados,
por ejemplo, los primeros 5 registros o una "página" de datos.

==============================================================
2. ESTRUCTURA BÁSICA
==============================================================
SELECT columnas
FROM tabla
LIMIT número;

Ejemplo:
--------------------------------------------------------------
-- Mostrar los primeros 5 usuarios registrados
SELECT nombre, correo
FROM usuarios
LIMIT 5;

Explicación:
Devuelve únicamente las primeras 5 filas encontradas en la tabla.

==============================================================
3. USAR LIMIT CON ORDER BY
==============================================================
LIMIT se suele combinar con ORDER BY para controlar qué registros se devuelven.

Ejemplo:
--------------------------------------------------------------
-- Obtener los 10 usuarios más recientes
SELECT nombre, fecha_registro
FROM usuarios
ORDER BY fecha_registro DESC
LIMIT 10;

-- Obtener los 10 usuarios más antiguos
SELECT nombre, fecha_registro
FROM usuarios
ORDER BY fecha_registro ASC
LIMIT 10;

==============================================================
4. LIMIT CON OFFSET (desplazamiento)
==============================================================
OFFSET indica desde qué posición comenzar a devolver los resultados.

Estructura:
--------------------------------------------------------------
SELECT columnas
FROM tabla
LIMIT cantidad OFFSET inicio;

Ejemplo:
--------------------------------------------------------------
-- Mostrar los registros del 11 al 20
SELECT nombre, correo
FROM usuarios
ORDER BY id ASC
LIMIT 10 OFFSET 10;

Explicación:
Omite los primeros 10 registros (OFFSET 10) y devuelve los siguientes 10.

==============================================================
5. ORDEN DE EVALUACIÓN
==============================================================
En una consulta SQL, el orden de ejecución común es:
1) FROM
2) WHERE
3) ORDER BY
4) LIMIT

Por eso, LIMIT siempre se coloca al final de la consulta.

==============================================================
6. USAR LIMIT PARA PAGINACIÓN
==============================================================
LIMIT y OFFSET se usan juntos para mostrar resultados por "páginas",
muy útil en sistemas web o aplicaciones que muestran listas de datos.

Ejemplo:
--------------------------------------------------------------
-- Página 1 (primeros 5 registros)
SELECT nombre
FROM usuarios
ORDER BY nombre
LIMIT 5 OFFSET 0;

-- Página 2 (siguientes 5 registros)
SELECT nombre
FROM usuarios
ORDER BY nombre
LIMIT 5 OFFSET 5;

-- Página 3 (registros del 11 al 15)
SELECT nombre
FROM usuarios
ORDER BY nombre
LIMIT 5 OFFSET 10;

==============================================================
7. LIMIT SIN ORDER BY
==============================================================
Si usas LIMIT sin ORDER BY, los resultados pueden variar
cada vez que ejecutes la consulta, ya que el orden interno
de los registros no está garantizado.

Ejemplo:
--------------------------------------------------------------
-- Muestra 3 registros al azar (pero sin orden definido)
SELECT nombre
FROM usuarios
LIMIT 3;

Recomendación:
Siempre usar ORDER BY con LIMIT si quieres resultados reproducibles.

==============================================================
8. VARIANTES EN OTROS SISTEMAS DE BASES DE DATOS
==============================================================
Aunque LIMIT es común en MySQL y PostgreSQL, otros motores usan
sintaxis diferente:

- SQL Server: usa TOP
  SELECT TOP 5 nombre FROM usuarios;

- Oracle: usa ROWNUM o FETCH
  SELECT nombre FROM usuarios FETCH FIRST 5 ROWS ONLY;

==============================================================
9. RESUMEN GENERAL
==============================================================
LIMIT n             -> Devuelve las primeras n filas
LIMIT n OFFSET m    -> Omite m filas y devuelve las siguientes n
ORDER BY + LIMIT    -> Controla qué filas específicas se obtienen
USO COMÚN           -> Paginación y pruebas rápidas
RECOMENDACIÓN       -> Siempre usar junto con ORDER BY
==============================================================
*/


-- Obtiene las 3 primeras filas de la tabla "users" omitiendo las primeras 4
SELECT * FROM users LIMIT 3 OFFSET 4;

-- Obtiene las 2 primeras filas de la tabla "users" con email distinto a sara@gmail.com o edad igual a 15
SELECT * FROM users WHERE NOT email = 'sara@gmail.com' OR age = 15 LIMIT 2;