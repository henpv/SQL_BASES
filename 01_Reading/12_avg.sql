/*
==============================================================
SECCIÓN 12: FUNCIÓN AVG() EN SQL
==============================================================

1. ¿Qué es AVG()?
--------------------------------------------------------------
AVG() es una función de agregación que calcula el promedio
(la media aritmética) de los valores numéricos de una columna.

Se usa comúnmente para obtener el salario promedio, la edad media,
el promedio de ventas, calificaciones, etc.

==============================================================
2. ESTRUCTURA BÁSICA
==============================================================
SELECT AVG(columna) FROM tabla;

Ejemplo:
--------------------------------------------------------------
-- Calcular el promedio de edades de los usuarios
SELECT AVG(edad) AS edad_promedio
FROM usuarios;

Explicación:
Devuelve el resultado de sumar todas las edades y dividirlo
entre el número de registros no nulos.

==============================================================
3. AVG() IGNORA LOS VALORES NULL
==============================================================
Al igual que SUM(), la función AVG() no considera los valores NULL
en su cálculo.

Ejemplo:
--------------------------------------------------------------
-- Si un usuario tiene edad = NULL, no afecta el promedio
SELECT AVG(edad) AS promedio
FROM usuarios;

==============================================================
4. USO DE AVG() CON WHERE
==============================================================
Puedes calcular promedios sobre subconjuntos de datos específicos.

Ejemplos:
--------------------------------------------------------------
-- Promedio de salarios de empleados activos
SELECT AVG(salario) AS salario_promedio_activos
FROM empleados
WHERE estado = 'activo';

-- Promedio de ventas realizadas en 2025
SELECT AVG(total_venta) AS promedio_ventas_2025
FROM ventas
WHERE YEAR(fecha_venta) = 2025;

==============================================================
5. USO DE AVG() CON GROUP BY
==============================================================
AVG() se combina frecuentemente con GROUP BY para obtener promedios
por categoría o grupo.

Ejemplos:
--------------------------------------------------------------
-- Promedio de salario por departamento
SELECT departamento, AVG(salario) AS salario_promedio
FROM empleados
GROUP BY departamento;

-- Promedio de ventas por país
SELECT pais, AVG(total_venta) AS promedio_pais
FROM ventas
GROUP BY pais;

==============================================================
6. USO DE AVG() CON DISTINCT
==============================================================
Puedes calcular el promedio solo de valores distintos.

Ejemplo:
--------------------------------------------------------------
-- Promedio de precios únicos (sin duplicados)
SELECT AVG(DISTINCT precio) AS promedio_unico
FROM productos;

==============================================================
7. USO DE AVG() CON FUNCIONES CONDICIONALES
==============================================================
Puedes usar CASE, IF o COALESCE dentro de AVG()
para controlar condiciones o reemplazar valores NULL.

Ejemplos:
--------------------------------------------------------------
-- Promedio de salarios solo de empleados fijos
SELECT AVG(CASE WHEN tipo_contrato = 'fijo' THEN salario END) AS promedio_fijo
FROM empleados;

-- Promedio de ventas, considerando 0 si el valor es NULL
SELECT AVG(COALESCE(total_venta, 0)) AS promedio_reparado
FROM ventas;

==============================================================
8. AVG() EN SUBCONSULTAS
==============================================================
AVG() puede usarse dentro de subconsultas para comparar resultados.

Ejemplo:
--------------------------------------------------------------
-- Clientes con ventas por encima del promedio general
SELECT id_cliente, AVG(total_venta) AS promedio_cliente
FROM ventas
GROUP BY id_cliente
HAVING AVG(total_venta) > (
  SELECT AVG(total_venta)
  FROM ventas
);

==============================================================
9. ORDENAR Y FILTRAR POR PROMEDIO
==============================================================
Puedes usar HAVING y ORDER BY con AVG() para mostrar solo los grupos
que cumplan una condición o para ordenarlos según su promedio.

Ejemplos:
--------------------------------------------------------------
-- Mostrar solo los departamentos con salario promedio mayor a 3000
SELECT departamento, AVG(salario) AS promedio_salario
FROM empleados
GROUP BY departamento
HAVING AVG(salario) > 3000;

-- Ordenar los países por promedio de ventas (descendente)
SELECT pais, AVG(total_venta) AS promedio_ventas
FROM ventas
GROUP BY pais
ORDER BY promedio_ventas DESC;

==============================================================
10. CONSIDERACIONES IMPORTANTES
==============================================================
1. AVG() solo funciona con columnas numéricas.
2. Los valores NULL se ignoran automáticamente.
3. Puede usarse con DISTINCT, GROUP BY, HAVING y subconsultas.
4. En columnas enteras, el resultado puede incluir decimales.
5. En algunos motores SQL puedes usar ROUND() para redondear.

Ejemplo:
--------------------------------------------------------------
-- Redondear el promedio a 2 decimales
SELECT ROUND(AVG(total_venta), 2) AS promedio_redondeado
FROM ventas;

==============================================================
11. RESUMEN GENERAL
==============================================================
AVG(columna)              -> Calcula el promedio
IGNORA NULL               -> Sí
CON WHERE                 -> Promedios filtrados
CON GROUP BY              -> Promedios por grupo
CON DISTINCT              -> Evita duplicados
CON CASE / COALESCE       -> Controla condiciones o NULL
CON HAVING / ORDER BY     -> Filtra u ordena por promedio
==============================================================
*/

-- Obitne la media de edad de la tabla "users"
Select AVG(age) FROM users;