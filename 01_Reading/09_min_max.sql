/*
==============================================================
SECCIÓN 9: FUNCIONES MIN() Y MAX() EN SQL
==============================================================

1. ¿Qué son MIN() y MAX()?
--------------------------------------------------------------
MIN() y MAX() son funciones de agregación en SQL que permiten
obtener, respectivamente, el valor mínimo y el valor máximo
de una columna.

Son muy útiles para identificar los valores extremos en un conjunto
de datos, como el salario más alto, la fecha más reciente, o la edad
menor dentro de un grupo.

==============================================================
2. ESTRUCTURA BÁSICA
==============================================================
SELECT MIN(columna), MAX(columna)
FROM tabla;

Ejemplo:
--------------------------------------------------------------
-- Obtener la edad mínima y máxima de todos los usuarios
SELECT MIN(edad) AS edad_menor, MAX(edad) AS edad_mayor
FROM usuarios;

Explicación:
Devuelve una sola fila con ambos valores extremos.

==============================================================
3. USO CON WHERE
==============================================================
Puedes usar WHERE para calcular los valores solo sobre un subconjunto
de datos.

Ejemplo:
--------------------------------------------------------------
-- Obtener la edad mínima y máxima de los usuarios activos
SELECT MIN(edad) AS menor_edad_activo, MAX(edad) AS mayor_edad_activo
FROM usuarios
WHERE estado = 'activo';

-- Obtener la fecha más antigua de registro de usuarios verificados
SELECT MIN(fecha_registro) AS primer_usuario_verificado
FROM usuarios
WHERE verificado = 1;

==============================================================
4. USAR MIN() Y MAX() CON COLUMNAS DE TEXTO
==============================================================
Estas funciones también pueden aplicarse sobre texto o fechas,
según el orden alfabético o cronológico.

Ejemplos:
--------------------------------------------------------------
-- Primer y último nombre en orden alfabético
SELECT MIN(nombre) AS primer_nombre, MAX(nombre) AS ultimo_nombre
FROM usuarios;

-- Primera y última fecha de registro
SELECT MIN(fecha_registro) AS primer_registro,
       MAX(fecha_registro) AS ultimo_registro
FROM usuarios;

==============================================================
5. USAR MIN() Y MAX() CON GROUP BY
==============================================================
Puedes agrupar los resultados por una columna y calcular el mínimo
y máximo dentro de cada grupo.

Ejemplo:
--------------------------------------------------------------
-- Edad mínima y máxima por país
SELECT pais,
       MIN(edad) AS menor_edad,
       MAX(edad) AS mayor_edad
FROM usuarios
GROUP BY pais;

-- Fecha del primer y último pedido por cliente
SELECT id_cliente,
       MIN(fecha_pedido) AS primer_pedido,
       MAX(fecha_pedido) AS ultimo_pedido
FROM pedidos
GROUP BY id_cliente;

==============================================================
6. USAR MIN() Y MAX() CON SUBCONSULTAS
==============================================================
Puedes utilizar MIN() y MAX() dentro de subconsultas para filtrar
otros resultados.

Ejemplo:
--------------------------------------------------------------
-- Usuario con la edad más alta
SELECT nombre, edad
FROM usuarios
WHERE edad = (SELECT MAX(edad) FROM usuarios);

-- Producto con el menor precio
SELECT nombre, precio
FROM productos
WHERE precio = (SELECT MIN(precio) FROM productos);

==============================================================
7. MIN() Y MAX() EN CONSULTAS COMPLEJAS
==============================================================
También puedes combinarlas con otras funciones o condiciones.

Ejemplos:
--------------------------------------------------------------
-- Mostrar el país con la edad promedio más alta
SELECT pais, AVG(edad) AS promedio_edad
FROM usuarios
GROUP BY pais
HAVING AVG(edad) = (
  SELECT MAX(promedio)
  FROM (
    SELECT AVG(edad) AS promedio
    FROM usuarios
    GROUP BY pais
  ) AS promedios
);

-- Mostrar el pedido más costoso de cada cliente
SELECT id_cliente, MAX(total) AS pedido_mayor
FROM pedidos
GROUP BY id_cliente;

==============================================================
8. CONSIDERACIONES IMPORTANTES
==============================================================
1. MIN() y MAX() ignoran los valores NULL.
2. Se pueden usar en cualquier tipo de columna numérica, texto o fecha.
3. Si no hay filas que cumplan la condición, el resultado será NULL.
4. Combinadas con GROUP BY, permiten análisis por categorías.

==============================================================
9. RESUMEN GENERAL
==============================================================
MIN(columna)           -> Devuelve el valor más bajo
MAX(columna)           -> Devuelve el valor más alto
IGNORA NULL            -> Sí
USO COMÚN              -> Estadísticas, reportes, límites de datos
CON GROUP BY           -> Mínimos y máximos por grupo
CON SUBCONSULTA        -> Filtrar filas extremas (ej. salario mayor)
CON TEXTO O FECHA      -> Orden alfabético o cronológico
==============================================================
*/

-- Obtiene el valor menor del campo edad de la tabla "users"
Select MIN(age) FROM users;

-- Obtiene el valor mayor del campo edad de la tabla "users"
Select MAX(age) FROM users;

-- Obtiene el valor menor y mayor del campo edad de la tabla "users", agrupado poor nombre.
Select name, MIN(age), MAX(age) FROM users GROUP BY name;