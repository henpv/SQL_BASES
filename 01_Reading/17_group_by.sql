/*
==============================================================
SECCIÓN 17: GROUP BY EN SQL
==============================================================

1. ¿Qué es GROUP BY?
--------------------------------------------------------------
La cláusula GROUP BY se utiliza en SQL para **agrupar filas**
que tienen valores idénticos en una o más columnas, de modo que
puedan aplicarse funciones de agregación sobre cada grupo.

Las funciones de agregación más comunes son:
   • SUM()   → suma los valores de un grupo
   • AVG()   → calcula el promedio
   • COUNT() → cuenta el número de filas
   • MIN()   → obtiene el valor mínimo
   • MAX()   → obtiene el valor máximo

==============================================================
2. ESTRUCTURA BÁSICA
==============================================================
SELECT columna_agrupada, función(columna)
FROM tabla
GROUP BY columna_agrupada;

Ejemplo:
--------------------------------------------------------------
-- Calcular el total de ventas por cada cliente
SELECT id_cliente, SUM(total) AS total_compras
FROM ventas
GROUP BY id_cliente;

Explicación:
Cada cliente se agrupa por su "id_cliente", y se calcula
la suma de sus compras en una sola fila.

==============================================================
3. GROUP BY CON VARIAS COLUMNAS
--------------------------------------------------------------
Puedes agrupar por más de una columna, creando subgrupos.

Ejemplo:
--------------------------------------------------------------
-- Total de ventas por cliente y año
SELECT id_cliente, YEAR(fecha_venta) AS año, SUM(total) AS total_anual
FROM ventas
GROUP BY id_cliente, YEAR(fecha_venta);

Explicación:
Agrupa primero por cliente, luego por el año de la venta.

==============================================================
4. GROUP BY Y ORDER BY
--------------------------------------------------------------
Puedes combinar GROUP BY con ORDER BY para ordenar los resultados
según las agrupaciones o los valores agregados.

Ejemplo:
--------------------------------------------------------------
-- Mostrar clientes ordenados por total de ventas (descendente)
SELECT id_cliente, SUM(total) AS total_compras
FROM ventas
GROUP BY id_cliente
ORDER BY total_compras DESC;

==============================================================
5. GROUP BY CON COUNT()
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
-- Contar cuántos pedidos tiene cada cliente
SELECT id_cliente, COUNT(*) AS cantidad_pedidos
FROM pedidos
GROUP BY id_cliente;

==============================================================
6. GROUP BY CON AVG(), MIN() Y MAX()
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
-- Calcular promedio, mínimo y máximo de precios por categoría
SELECT categoria, 
       AVG(precio) AS promedio_precio,
       MIN(precio) AS precio_mínimo,
       MAX(precio) AS precio_máximo
FROM productos
GROUP BY categoria;

==============================================================
7. GROUP BY CON CONCAT() Y OTROS CAMPOS
--------------------------------------------------------------
Cuando usas GROUP BY, todas las columnas en el SELECT que no
forman parte de una función de agregación deben estar en el GROUP BY.

Ejemplo correcto:
--------------------------------------------------------------
SELECT categoria, COUNT(*) AS total
FROM productos
GROUP BY categoria;

Ejemplo incorrecto:
--------------------------------------------------------------
SELECT categoria, nombre FROM productos;
-- ❌ Error: la columna “nombre” no está en GROUP BY ni en una función agregada.

==============================================================
8. USO DE GROUP BY CON WHERE Y HAVING
--------------------------------------------------------------
WHERE filtra las filas **antes** de agrupar.
HAVING filtra los grupos **después** de agrupar.

Ejemplo:
--------------------------------------------------------------
-- Mostrar categorías con más de 10 productos
SELECT categoria, COUNT(*) AS total
FROM productos
GROUP BY categoria
HAVING COUNT(*) > 10;

-- Mostrar solo ventas de 2025 y agrupar por cliente
SELECT id_cliente, SUM(total) AS total_anual
FROM ventas
WHERE YEAR(fecha_venta) = 2025
GROUP BY id_cliente
HAVING total_anual > 5000;

==============================================================
9. GROUP BY Y ALIAS
--------------------------------------------------------------
Puedes usar alias para las funciones de agregación
y luego referenciarlos en la cláusula HAVING o ORDER BY.

Ejemplo:
--------------------------------------------------------------
SELECT id_cliente, SUM(total) AS total_compras
FROM ventas
GROUP BY id_cliente
HAVING total_compras > 10000
ORDER BY total_compras DESC;

==============================================================
10. GROUP BY EN SUBCONSULTAS
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
-- Subconsulta con GROUP BY para obtener el gasto promedio
SELECT nombre, total_compras
FROM (
    SELECT id_cliente, SUM(total) AS total_compras
    FROM ventas
    GROUP BY id_cliente
) AS resumen
WHERE total_compras > 5000;

==============================================================
11. DIFERENCIA ENTRE GROUP BY Y DISTINCT
--------------------------------------------------------------
• DISTINCT elimina duplicados sin agrupar ni aplicar cálculos.
• GROUP BY agrupa y permite usar funciones de agregación.

Ejemplo:
--------------------------------------------------------------
-- DISTINCT:
SELECT DISTINCT pais FROM clientes;

-- GROUP BY (más flexible):
SELECT pais, COUNT(*) AS total_clientes
FROM clientes
GROUP BY pais;

==============================================================
12. BUENAS PRÁCTICAS
--------------------------------------------------------------
1. Incluye en el SELECT solo columnas agrupadas o agregadas.
2. Usa alias descriptivos para los cálculos.
3. Combina HAVING y WHERE correctamente.
4. Evita usar GROUP BY con demasiadas columnas (puede ser costoso).
5. Usa índices en las columnas que agrupan para mejorar rendimiento.
6. Recuerda que GROUP BY se ejecuta después de WHERE, pero antes de ORDER BY.

==============================================================
13. RESUMEN GENERAL
==============================================================
GROUP BY columna(s)       -> Agrupa filas con valores iguales.
FUNCIONES AGREGADAS       -> SUM, AVG, COUNT, MIN, MAX, etc.
WHERE                     -> Filtra filas antes de agrupar.
HAVING                    -> Filtra grupos después de agrupar.
ORDER BY                  -> Ordena el resultado final.
DISTINCT VS GROUP BY      -> DISTINCT solo elimina duplicados.
BUENA PRÁCTICA            -> Usar alias y limitar columnas agrupadas.
==============================================================
*/

-- Agrupa los resultados por edad diferente
SELECT MAX(age) FROM users GROUP BY age;

-- Agrupa los resultados por edad diferente y cuenta cuantos registros existen de cada una
SELECT COUNT(age), age FROM users GROUP BY age;

-- Agrupa los resultados por edad diferente, cuenta cuantos registros existen de cada una y los ordena
SELECT COUNT(age), age FROM users GROUP BY age ORDER BY age ASC;

-- Agrupa los resultados por edad diferente mayor de 15, cuenta cuantos registros existen de cada una y los ordena
SELECT COUNT(age), age FROM users WHERE age > 15 GROUP BY age ORDER BY age ASC