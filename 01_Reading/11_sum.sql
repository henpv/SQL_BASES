/*
==============================================================
SECCIÓN 11: FUNCIÓN SUM() EN SQL
==============================================================

1. ¿Qué es SUM()?
--------------------------------------------------------------
SUM() es una función de agregación que calcula la suma total
de los valores numéricos en una columna.

Se usa comúnmente para obtener totales de ventas, ingresos,
cantidades, puntuaciones, etc.

==============================================================
2. ESTRUCTURA BÁSICA
==============================================================
SELECT SUM(columna) FROM tabla;

Ejemplo:
--------------------------------------------------------------
-- Calcular el total de ventas realizadas
SELECT SUM(total_venta) AS ventas_totales
FROM ventas;

Explicación:
Devuelve la suma de todos los valores de la columna “total_venta”.

==============================================================
3. SUM() IGNORA LOS VALORES NULL
==============================================================
Los valores NULL no afectan el resultado de SUM().

Ejemplo:
--------------------------------------------------------------
-- Si una venta tiene NULL en “total_venta”, no se suma.
SELECT SUM(total_venta) AS total
FROM ventas;

==============================================================
4. USO DE SUM() CON WHERE
==============================================================
Puedes sumar solo los valores que cumplan una condición.

Ejemplos:
--------------------------------------------------------------
-- Sumar solo las ventas confirmadas
SELECT SUM(total_venta) AS total_confirmadas
FROM ventas
WHERE estado = 'confirmada';

-- Sumar las ventas de un cliente específico
SELECT SUM(total_venta) AS total_cliente
FROM ventas
WHERE id_cliente = 15;

==============================================================
5. USO DE SUM() CON GROUP BY
==============================================================
SUM() se usa frecuentemente junto con GROUP BY para obtener
sumas por grupo o categoría.

Ejemplos:
--------------------------------------------------------------
-- Total de ventas por cliente
SELECT id_cliente, SUM(total_venta) AS total_cliente
FROM ventas
GROUP BY id_cliente;

-- Total de ventas por país
SELECT pais, SUM(total_venta) AS ventas_pais
FROM ventas
GROUP BY pais;

==============================================================
6. USO DE SUM() CON DISTINCT
==============================================================
Puedes sumar solo los valores distintos de una columna.

Ejemplo:
--------------------------------------------------------------
-- Sumar montos únicos (sin duplicados)
SELECT SUM(DISTINCT total_venta) AS total_unico
FROM ventas;

==============================================================
7. SUM() CON OTRAS FUNCIONES
==============================================================
SUM() puede combinarse con IF(), CASE o COALESCE para sumar
condicionalmente o manejar valores NULL.

Ejemplos:
--------------------------------------------------------------
-- Sumar solo los pedidos con estado "entregado"
SELECT SUM(CASE WHEN estado = 'entregado' THEN total ELSE 0 END) AS total_entregado
FROM pedidos;

-- Sumar reemplazando valores NULL por 0
SELECT SUM(COALESCE(total, 0)) AS total_reparado
FROM pedidos;

==============================================================
8. USO DE SUM() EN SUBCONSULTAS
==============================================================
Puedes usar SUM() dentro de subconsultas para cálculos más complejos.

Ejemplo:
--------------------------------------------------------------
-- Mostrar clientes cuyo total de ventas supere el promedio general
SELECT id_cliente, SUM(total_venta) AS total_cliente
FROM ventas
GROUP BY id_cliente
HAVING SUM(total_venta) > (
  SELECT AVG(total_venta)
  FROM ventas
);

==============================================================
9. ORDEN Y FILTRADO CON SUM()
==============================================================
Puedes ordenar o filtrar resultados basados en la suma calculada.

Ejemplos:
--------------------------------------------------------------
-- Ordenar clientes por el total de ventas (de mayor a menor)
SELECT id_cliente, SUM(total_venta) AS total
FROM ventas
GROUP BY id_cliente
ORDER BY total DESC;

-- Mostrar solo los clientes con más de 10,000 en ventas
SELECT id_cliente, SUM(total_venta) AS total
FROM ventas
GROUP BY id_cliente
HAVING SUM(total_venta) > 10000;

==============================================================
10. RESUMEN GENERAL
==============================================================
SUM(columna)              -> Suma los valores numéricos
IGNORA NULL               -> Sí
CON WHERE                 -> Suma filtrada
CON GROUP BY              -> Totales por grupo
CON DISTINCT              -> Evita duplicados
CON CASE / COALESCE       -> Controla condiciones o NULL
CON HAVING / ORDER BY     -> Filtra u ordena por suma total
==============================================================
*/


-- Suma todos los valores del campo edad de la tabla "users"
Select SUM(age) FROM users;