/*
==============================================================
SECCIÓN 18: HAVING EN SQL
==============================================================

1. ¿Qué es HAVING?
--------------------------------------------------------------
La cláusula HAVING se utiliza en SQL para **filtrar los resultados
después de haber realizado una agrupación con GROUP BY**.

Diferencia clave:
 - WHERE → filtra filas antes de agrupar.
 - HAVING → filtra los grupos después de aplicar GROUP BY o funciones agregadas.

==============================================================
2. ESTRUCTURA BÁSICA
==============================================================
SELECT columna_agrupada, función_agregada(columna)
FROM tabla
GROUP BY columna_agrupada
HAVING condición;

Ejemplo:
--------------------------------------------------------------
-- Mostrar categorías con más de 5 productos
SELECT categoria, COUNT(*) AS total_productos
FROM productos
GROUP BY categoria
HAVING COUNT(*) > 5;

Explicación:
Primero agrupa los productos por categoría y luego muestra solo
las categorías que tienen más de 5 productos.

==============================================================
3. DIFERENCIA ENTRE WHERE Y HAVING
--------------------------------------------------------------
WHERE y HAVING no son equivalentes, aunque ambas se usan para filtrar.

Ejemplo:
--------------------------------------------------------------
-- WHERE filtra antes del agrupamiento
SELECT categoria, COUNT(*) AS total_productos
FROM productos
WHERE precio > 1000
GROUP BY categoria;

-- HAVING filtra después del agrupamiento
SELECT categoria, COUNT(*) AS total_productos
FROM productos
GROUP BY categoria
HAVING COUNT(*) > 5;

Explicación:
• WHERE → filtra productos con precio > 1000 antes de agrupar.
• HAVING → filtra categorías con más de 5 productos después de agrupar.

==============================================================
4. USO CON FUNCIONES DE AGREGACIÓN
--------------------------------------------------------------
HAVING puede contener funciones de agregación como SUM, AVG, COUNT, MIN, MAX.

Ejemplo:
--------------------------------------------------------------
-- Mostrar clientes con compras totales mayores a $10,000
SELECT id_cliente, SUM(total) AS total_compras
FROM ventas
GROUP BY id_cliente
HAVING SUM(total) > 10000;

==============================================================
5. USO DE ALIAS EN HAVING
--------------------------------------------------------------
Puedes usar alias definidos en el SELECT dentro de la cláusula HAVING
(en la mayoría de motores, incluido MySQL).

Ejemplo:
--------------------------------------------------------------
SELECT id_cliente, SUM(total) AS total_compras
FROM ventas
GROUP BY id_cliente
HAVING total_compras > 5000
ORDER BY total_compras DESC;

==============================================================
6. COMBINAR WHERE Y HAVING
--------------------------------------------------------------
Puedes usar ambas cláusulas en una misma consulta:
 - WHERE filtra los registros iniciales.
 - HAVING filtra los grupos resultantes.

Ejemplo:
--------------------------------------------------------------
-- Clientes activos con más de $5000 en compras en 2025
SELECT id_cliente, SUM(total) AS total_anual
FROM ventas
WHERE YEAR(fecha_venta) = 2025
GROUP BY id_cliente
HAVING total_anual > 5000;

==============================================================
7. HAVING CON VARIAS CONDICIONES
--------------------------------------------------------------
Puedes combinar condiciones en HAVING con operadores lógicos (AND, OR, NOT).

Ejemplo:
--------------------------------------------------------------
-- Mostrar categorías con más de 10 productos y promedio de precio > 2000
SELECT categoria, COUNT(*) AS total, AVG(precio) AS promedio
FROM productos
GROUP BY categoria
HAVING COUNT(*) > 10 AND AVG(precio) > 2000;

==============================================================
8. HAVING SIN GROUP BY
--------------------------------------------------------------
Aunque es poco común, HAVING puede usarse sin GROUP BY
cuando la consulta contiene una función agregada general.

Ejemplo:
--------------------------------------------------------------
-- Verificar si el total de ventas supera 1 millón
SELECT SUM(total) AS total_general
FROM ventas
HAVING SUM(total) > 1000000;

==============================================================
9. HAVING CON SUBCONSULTAS
--------------------------------------------------------------
También puedes combinar HAVING con subconsultas o funciones anidadas.

Ejemplo:
--------------------------------------------------------------
-- Categorías que superan el promedio general de productos
SELECT categoria, COUNT(*) AS total
FROM productos
GROUP BY categoria
HAVING COUNT(*) > (
  SELECT AVG(sub_total)
  FROM (
    SELECT COUNT(*) AS sub_total
    FROM productos
    GROUP BY categoria
  ) AS t
);

==============================================================
10. ORDEN DE EJECUCIÓN DE HAVING
--------------------------------------------------------------
El orden de ejecución de una consulta SQL es el siguiente:

1. FROM (selecciona la tabla)
2. WHERE (filtra filas)
3. GROUP BY (agrupa)
4. HAVING (filtra los grupos)
5. SELECT (devuelve columnas)
6. ORDER BY (ordena resultados)

Ejemplo:
--------------------------------------------------------------
SELECT categoria, SUM(precio) AS total
FROM productos
WHERE stock > 0
GROUP BY categoria
HAVING total > 5000
ORDER BY total DESC;

==============================================================
11. BUENAS PRÁCTICAS
--------------------------------------------------------------
1. Usa WHERE para filtrar filas individuales antes de agrupar.
2. Usa HAVING solo cuando necesites filtrar resultados agrupados.
3. Aplica alias a funciones agregadas para mayor claridad.
4. No abuses de HAVING con condiciones no agregadas (reduce rendimiento).
5. Si una condición puede aplicarse con WHERE, usa WHERE (es más eficiente).
6. Combina HAVING con ORDER BY para ver resultados más claros.

==============================================================
12. RESUMEN GENERAL
==============================================================
HAVING                         -> Filtra después del GROUP BY.
WHERE                          -> Filtra antes del GROUP BY.
USO CON FUNCIONES AGREGADAS    -> SUM, AVG, COUNT, etc.
PERMITE CONDICIONES MÚLTIPLES  -> AND, OR, NOT.
SE PUEDE USAR SIN GROUP BY     -> Sí, si hay funciones agregadas.
BUENA PRÁCTICA                 -> Usar solo para filtrar grupos.
ORDEN DE EJECUCIÓN             -> WHERE → GROUP BY → HAVING → ORDER BY.
==============================================================
*/

-- Cuenta cuantas filas contienen un dato no nulo en el campo edad de la tabla "users" mayor que 3
SELECT COUNT(age) FROM users HAVING COUNT(age) > 3