/*
==============================================================
SECCIÓN 14: OPERADOR BETWEEN EN SQL
==============================================================

1. ¿Qué es el operador BETWEEN?
--------------------------------------------------------------
El operador BETWEEN se utiliza en SQL para filtrar resultados
que se encuentran dentro de un rango de valores (numéricos,
de texto o fechas). 

Por defecto, BETWEEN incluye los valores límite:
   (valor_inicial <= valor <= valor_final)

==============================================================
2. ESTRUCTURA BÁSICA
==============================================================
SELECT columnas
FROM tabla
WHERE columna BETWEEN valor_inicial AND valor_final;

Ejemplo:
--------------------------------------------------------------
-- Mostrar productos con precio entre 1000 y 5000
SELECT nombre, precio
FROM productos
WHERE precio BETWEEN 1000 AND 5000;

Explicación:
Devuelve todos los productos cuyo precio sea igual o mayor a 1000
y menor o igual a 5000.

==============================================================
3. USO DE NOT BETWEEN
==============================================================
NOT BETWEEN excluye los valores dentro del rango especificado.

Ejemplo:
--------------------------------------------------------------
-- Mostrar productos con precio fuera del rango 1000-5000
SELECT nombre, precio
FROM productos
WHERE precio NOT BETWEEN 1000 AND 5000;

Explicación:
Devuelve todos los productos cuyo precio sea menor que 1000
o mayor que 5000.

==============================================================
4. BETWEEN CON FECHAS
==============================================================
BETWEEN es muy útil para filtrar registros por intervalos de fechas.

Ejemplo:
--------------------------------------------------------------
-- Mostrar ventas entre el 1 y el 31 de enero de 2025
SELECT id_venta, fecha, total
FROM ventas
WHERE fecha BETWEEN '2025-01-01' AND '2025-01-31';

Importante:
El formato de fecha depende del motor de base de datos.
En MySQL se recomienda el formato 'YYYY-MM-DD'.

==============================================================
5. BETWEEN CON TEXTO
==============================================================
También se puede usar BETWEEN con texto (según orden alfabético).

Ejemplo:
--------------------------------------------------------------
-- Mostrar empleados cuyos nombres estén alfabéticamente
-- entre 'A' y 'H'
SELECT nombre
FROM empleados
WHERE nombre BETWEEN 'A' AND 'H';

Explicación:
MySQL compara cadenas según el orden del conjunto de caracteres (collation).

==============================================================
6. ENTRE NÚMEROS Y EXPRESIONES
==============================================================
Se pueden usar expresiones, funciones o columnas en BETWEEN.

Ejemplos:
--------------------------------------------------------------
-- Mostrar productos con precio entre 20% y 80% del promedio
SELECT nombre, precio
FROM productos
WHERE precio BETWEEN (SELECT AVG(precio)*0.2 FROM productos)
                  AND (SELECT AVG(precio)*0.8 FROM productos);

-- Mostrar estudiantes con nota entre 3.0 y 4.5
SELECT nombre, nota
FROM estudiantes
WHERE nota BETWEEN 3.0 AND 4.5;

==============================================================
7. ENTRE COLUMNAS
==============================================================
También puedes comparar un valor contra columnas distintas.

Ejemplo:
--------------------------------------------------------------
-- Mostrar pedidos donde la fecha actual esté dentro del rango del pedido
SELECT id_pedido, fecha_inicio, fecha_fin
FROM pedidos
WHERE CURDATE() BETWEEN fecha_inicio AND fecha_fin;

Explicación:
Devuelve los pedidos activos en el día actual.

==============================================================
8. DIFERENCIA ENTRE BETWEEN Y >, <
==============================================================
BETWEEN incluye los valores de los extremos.
Si quieres excluirlos, debes usar operadores tradicionales.

Ejemplo:
--------------------------------------------------------------
-- BETWEEN incluye los límites:
WHERE edad BETWEEN 18 AND 30;   -- incluye 18 y 30

-- Exclusión de límites:
WHERE edad > 18 AND edad < 30;  -- excluye 18 y 30

==============================================================
9. BUENAS PRÁCTICAS
==============================================================
1. BETWEEN incluye los límites del rango.
2. Es ideal para comparar fechas, números o cadenas ordenadas.
3. Usar formato estándar de fechas (‘YYYY-MM-DD’) para evitar errores.
4. Si el valor inicial es mayor que el final, el resultado será vacío.
5. BETWEEN con texto depende del collation (orden de caracteres).
6. Si los límites pueden ser NULL, BETWEEN devolverá falso (no coincide).

==============================================================
10. RESUMEN GENERAL
==============================================================
BETWEEN valor1 AND valor2     -> Filtra valores dentro del rango.
NOT BETWEEN valor1 AND valor2 -> Excluye valores dentro del rango.
INCLUYE LÍMITES               -> Sí (valor1 y valor2 incluidos).
CON FECHAS                    -> Usa formato 'YYYY-MM-DD'.
CON TEXTO                     -> Basado en orden alfabético.
CON FUNCIONES O SUBCONSULTAS  -> Totalmente válido.
CUIDADO CON NULL              -> Ignora comparaciones con NULL.
==============================================================
*/

-- Ordena todos los datos de la tabla "users" con edad comprendida entre 20 y 30
SELECT * FROM users WHERE age BETWEEN 20 AND 30