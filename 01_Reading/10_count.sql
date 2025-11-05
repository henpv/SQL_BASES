/*
==============================================================
SECCIÓN 10: FUNCIÓN COUNT() EN SQL
==============================================================

1. ¿Qué es COUNT()?
--------------------------------------------------------------
COUNT() es una función de agregación que devuelve la cantidad
de filas que cumplen una determinada condición dentro de una tabla.

Se utiliza para saber cuántos registros existen, cuántos cumplen
ciertos criterios o cuántos valores no son NULL en una columna.

==============================================================
2. ESTRUCTURA BÁSICA
==============================================================
SELECT COUNT(*) FROM tabla;

Ejemplo:
--------------------------------------------------------------
-- Contar el total de usuarios registrados
SELECT COUNT(*) AS total_usuarios
FROM usuarios;

Explicación:
COUNT(*) cuenta todas las filas de la tabla, sin importar si tienen
valores NULL o no.

==============================================================
3. DIFERENCIA ENTRE COUNT(*) Y COUNT(columna)
==============================================================
COUNT(*)        -> Cuenta todas las filas, incluidas las que tienen NULL.
COUNT(columna)  -> Cuenta solo las filas donde la columna no es NULL.

Ejemplos:
--------------------------------------------------------------
-- Contar todos los registros
SELECT COUNT(*) AS total_registros
FROM usuarios;

-- Contar solo los usuarios con correo asignado
SELECT COUNT(correo) AS usuarios_con_correo
FROM usuarios;

==============================================================
4. USO DE COUNT() CON WHERE
==============================================================
Puedes combinar COUNT() con condiciones para contar filas específicas.

Ejemplos:
--------------------------------------------------------------
-- Contar usuarios activos
SELECT COUNT(*) AS total_activos
FROM usuarios
WHERE estado = 'activo';

-- Contar usuarios sin correo
SELECT COUNT(*) AS sin_correo
FROM usuarios
WHERE correo IS NULL;

==============================================================
5. USO DE COUNT() CON GROUP BY
==============================================================
COUNT() se usa comúnmente junto con GROUP BY para obtener conteos
agrupados por una categoría.

Ejemplos:
--------------------------------------------------------------
-- Cantidad de usuarios por país
SELECT pais, COUNT(*) AS total
FROM usuarios
GROUP BY pais;

-- Número de pedidos por cliente
SELECT id_cliente, COUNT(*) AS pedidos_realizados
FROM pedidos
GROUP BY id_cliente;

==============================================================
6. USO DE COUNT() CON DISTINCT
==============================================================
Puedes combinar COUNT() con DISTINCT para contar valores únicos.

Ejemplo:
--------------------------------------------------------------
-- Contar cuántos países distintos hay registrados
SELECT COUNT(DISTINCT pais) AS total_paises
FROM usuarios;

-- Contar cuántos correos únicos existen
SELECT COUNT(DISTINCT correo) AS correos_unicos
FROM usuarios;

==============================================================
7. COUNT() EN SUBCONSULTAS
================================================--------------
Puedes usar COUNT() dentro de una subconsulta para obtener estadísticas
que luego compares o muestres junto con otros resultados.

Ejemplo:
--------------------------------------------------------------
-- Mostrar usuarios junto con el total general de registros
SELECT nombre,
       (SELECT COUNT(*) FROM usuarios) AS total_general
FROM usuarios;

-- Mostrar clientes con más de 5 pedidos
SELECT id_cliente
FROM pedidos
GROUP BY id_cliente
HAVING COUNT(*) > 5;

==============================================================
8. CONSIDERACIONES IMPORTANTES
==============================================================
1. COUNT(*) cuenta todas las filas, incluso si hay valores NULL.
2. COUNT(columna) ignora los NULL.
3. COUNT(DISTINCT columna) cuenta solo los valores únicos no nulos.
4. COUNT() no se puede usar dentro de WHERE directamente; se usa con HAVING.
5. Se puede combinar con otras funciones o filtros para análisis más precisos.

==============================================================
9. RESUMEN GENERAL
==============================================================
COUNT(*)               -> Cuenta todas las filas
COUNT(columna)         -> Cuenta solo valores no nulos
COUNT(DISTINCT valor)  -> Cuenta valores únicos
CON WHERE              -> Filtra filas antes de contar
CON GROUP BY           -> Conteo por categorías
CON HAVING             -> Filtra grupos según el resultado del conteo
==============================================================
*/


-- Cuenta cuantas filas contiene la tabla "users"
Select COUNT(*) FROM users;

-- Cuenta cuantas filas contienen un dato no nulo en el campo edad de la tabla "users"
Select COUNT(age) FROM users;