/*
==============================================================
SECCIÓN 13: OPERADOR IN EN SQL
==============================================================

1. ¿Qué es el operador IN?
--------------------------------------------------------------
El operador IN se utiliza en SQL para verificar si un valor
existe dentro de una lista específica de valores o dentro del
resultado de una subconsulta.

Permite simplificar comparaciones múltiples en una sola condición.

==============================================================
2. ESTRUCTURA BÁSICA
==============================================================
SELECT columnas
FROM tabla
WHERE columna IN (valor1, valor2, valor3, ...);

Ejemplo:
--------------------------------------------------------------
-- Mostrar usuarios cuyo país sea Colombia, México o Perú
SELECT nombre, pais
FROM usuarios
WHERE pais IN ('Colombia', 'México', 'Perú');

Explicación:
Solo se seleccionan los usuarios cuyo país coincide con alguno
de los valores de la lista.

==============================================================
3. IN VS. MÚLTIPLES CONDICIONES OR
==============================================================
IN es una forma más limpia y legible de reemplazar varios OR.

Ejemplo equivalente:
--------------------------------------------------------------
-- Forma con OR:
SELECT nombre
FROM usuarios
WHERE pais = 'Colombia'
   OR pais = 'México'
   OR pais = 'Perú';

-- Forma con IN (más simple):
SELECT nombre
FROM usuarios
WHERE pais IN ('Colombia', 'México', 'Perú');

==============================================================
4. USO DE NOT IN
==============================================================
NOT IN sirve para excluir los valores listados en la condición.

Ejemplo:
--------------------------------------------------------------
-- Mostrar usuarios que no sean de Colombia, México o Perú
SELECT nombre, pais
FROM usuarios
WHERE pais NOT IN ('Colombia', 'México', 'Perú');

==============================================================
5. USO DE IN CON NÚMEROS
==============================================================
IN también puede usarse con valores numéricos.

Ejemplo:
--------------------------------------------------------------
-- Seleccionar productos con ID específico
SELECT nombre, precio
FROM productos
WHERE id_producto IN (1, 3, 5, 7);

-- Excluir ciertos IDs
SELECT nombre, precio
FROM productos
WHERE id_producto NOT IN (2, 4, 6);

==============================================================
6. USO DE IN CON SUBCONSULTAS
==============================================================
IN puede contener una subconsulta, permitiendo comparar valores
contra resultados dinámicos obtenidos de otra tabla.

Ejemplos:
--------------------------------------------------------------
-- Mostrar clientes que tienen pedidos registrados
SELECT nombre
FROM clientes
WHERE id_cliente IN (
  SELECT id_cliente
  FROM pedidos
);

-- Mostrar productos que nunca se han vendido
SELECT nombre
FROM productos
WHERE id_producto NOT IN (
  SELECT id_producto
  FROM ventas
);

==============================================================
7. CUIDADO CON NULL EN SUBCONSULTAS CON IN
==============================================================
Si la subconsulta devuelve algún valor NULL, el resultado del IN
puede ser inesperado, ya que las comparaciones con NULL no son verdaderas.

Ejemplo:
--------------------------------------------------------------
-- Si la subconsulta incluye NULL, puede que no se devuelvan resultados
SELECT nombre
FROM clientes
WHERE id_cliente IN (
  SELECT id_cliente
  FROM pedidos
);

Solución:
Usar una condición que excluya los valores NULL dentro de la subconsulta:

SELECT nombre
FROM clientes
WHERE id_cliente IN (
  SELECT id_cliente
  FROM pedidos
  WHERE id_cliente IS NOT NULL
);

==============================================================
8. USO DE IN CON TEXTO Y FECHAS
==============================================================
IN puede usarse también con texto o fechas.

Ejemplos:
--------------------------------------------------------------
-- Empleados contratados en meses específicos
SELECT nombre, fecha_contrato
FROM empleados
WHERE MONTH(fecha_contrato) IN (1, 6, 12);

-- Usuarios con roles específicos
SELECT nombre, rol
FROM usuarios
WHERE rol IN ('admin', 'editor', 'moderador');

==============================================================
9. COMBINAR IN CON OTRAS CLÁUSULAS
==============================================================
IN puede combinarse con otras condiciones como AND, OR, BETWEEN, LIKE, etc.

Ejemplos:
--------------------------------------------------------------
-- Clientes activos y de ciertos países
SELECT nombre
FROM clientes
WHERE estado = 'activo'
  AND pais IN ('Colombia', 'México');

-- Ventas de ciertos productos en 2025
SELECT id_venta, total
FROM ventas
WHERE id_producto IN (1, 2, 3)
  AND YEAR(fecha_venta) = 2025;

==============================================================
10. RENDIMIENTO Y BUENAS PRÁCTICAS
==============================================================
1. IN es ideal para listas cortas o moderadas.
2. Para listas muy largas (miles de valores), puede ser más eficiente
   usar una tabla temporal o un JOIN.
3. Evitar IN con subconsultas que devuelvan muchos resultados.
4. Siempre eliminar o filtrar valores NULL en subconsultas.

==============================================================
11. RESUMEN GENERAL
==============================================================
IN (lista)            -> Comprueba si un valor está dentro de una lista.
NOT IN (lista)        -> Excluye los valores de la lista.
CON NÚMEROS           -> Compara IDs o códigos.
CON TEXTO O FECHAS    -> Filtra por categorías o rangos de tiempo.
CON SUBCONSULTAS      -> Compara contra resultados dinámicos.
IGNORA NULL           -> No, puede afectar el resultado.
BUENA PRÁCTICA        -> Filtrar NULL y usar con listas razonables.
==============================================================
*/

-- Ordena todos los datos de la tabla "users" con nombre igual a brais y sara
SELECT * FROM users WHERE name IN ('brais', 'sara')