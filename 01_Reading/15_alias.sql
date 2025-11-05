/*
==============================================================
SECCIÓN 15: ALIAS EN SQL (USO DE "AS")
==============================================================

1. ¿Qué son los alias?
--------------------------------------------------------------
Un **alias** es un nombre temporal asignado a una columna o tabla
dentro de una consulta SQL.

Se utilizan para:
 - Hacer los resultados más legibles.
 - Simplificar consultas largas o complejas.
 - Evitar ambigüedades al usar varias tablas con nombres similares.
 - Mejorar la comprensión de los cálculos o subconsultas.

==============================================================
2. ESTRUCTURA BÁSICA
==============================================================
-- Alias para columnas:
SELECT columna AS nuevo_nombre
FROM tabla;

-- Alias para tablas:
SELECT t.columna
FROM tabla AS t;

La palabra clave **AS** es opcional en la mayoría de motores SQL
(como MySQL), pero se recomienda para claridad.

==============================================================
3. ALIAS PARA COLUMNAS
==============================================================
Permite cambiar el nombre de una columna en el resultado.

Ejemplo:
--------------------------------------------------------------
-- Mostrar nombre completo con alias
SELECT nombre AS 'Nombre del cliente', 
       correo AS 'Correo electrónico'
FROM clientes;

-- Alias sin comillas (válido también)
SELECT nombre AS NombreCompleto
FROM empleados;

Explicación:
El alias cambia cómo aparece el nombre de la columna en el resultado,
no el nombre real dentro de la tabla.

==============================================================
4. ALIAS CON OPERACIONES O FUNCIONES
==============================================================
Cuando aplicas una operación o función, es útil asignarle un alias
para darle un nombre significativo al resultado.

Ejemplo:
--------------------------------------------------------------
-- Calcular el total con IVA incluido
SELECT precio * 1.19 AS total_con_iva
FROM productos;

-- Mostrar el promedio de notas con un alias descriptivo
SELECT AVG(nota) AS promedio_general
FROM estudiantes;

==============================================================
5. ALIAS PARA TABLAS
==============================================================
Los alias para tablas se usan para escribir consultas más cortas
y legibles, especialmente cuando hay varias tablas o uniones (JOIN).

Ejemplo:
--------------------------------------------------------------
-- Consulta sin alias:
SELECT clientes.nombre, pedidos.total
FROM clientes
JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente;

-- Consulta con alias:
SELECT c.nombre, p.total
FROM clientes AS c
JOIN pedidos AS p ON c.id_cliente = p.id_cliente;

Explicación:
Se reemplaza el nombre completo de cada tabla con una abreviatura,
lo que mejora la claridad y reduce la repetición.

==============================================================
6. USO DE ALIAS EN SUBCONSULTAS
==============================================================
Cuando una subconsulta genera una tabla temporal, se le debe dar un alias.

Ejemplo:
--------------------------------------------------------------
-- Subconsulta con alias
SELECT nombre, total_compras
FROM (
    SELECT id_cliente, SUM(total) AS total_compras
    FROM pedidos
    GROUP BY id_cliente
) AS resumen_pedidos;

Explicación:
La subconsulta genera una tabla temporal llamada "resumen_pedidos"
que luego se usa en la consulta principal.

==============================================================
7. ALIAS SIN "AS"
--------------------------------------------------------------
MySQL permite omitir la palabra **AS** al declarar alias.

Ejemplo:
--------------------------------------------------------------
-- Ambas formas son válidas:
SELECT nombre AS cliente, ciudad AS ubicacion FROM usuarios;
SELECT nombre cliente, ciudad ubicacion FROM usuarios;

Recomendación:
Aunque **AS** no es obligatorio, se recomienda usarlo para que el
código sea más claro y coherente.

==============================================================
8. ALIAS CON ESPACIOS O CARACTERES ESPECIALES
==============================================================
Si el alias contiene espacios o caracteres especiales, debes encerrarlo
entre comillas simples (' '), dobles (" ") o backticks (` `).

Ejemplo:
--------------------------------------------------------------
SELECT nombre AS 'Nombre Completo',
       correo AS "Email del Cliente",
       precio AS `Precio (USD)`
FROM clientes;

==============================================================
9. BUENAS PRÁCTICAS
==============================================================
1. Usa alias para hacer tus consultas más legibles.
2. Utiliza **AS** incluso si no es obligatorio.
3. Mantén los alias cortos pero descriptivos (ej: “c” para clientes).
4. Usa alias en subconsultas y uniones para evitar errores.
5. Evita alias ambiguos o poco claros (ej: “x”, “y”, “z” sin contexto).
6. Usa comillas si el alias contiene espacios o caracteres especiales.

==============================================================
10. RESUMEN GENERAL
==============================================================
ALIAS PARA COLUMNAS        -> Da un nombre temporal a los resultados.
ALIAS PARA TABLAS          -> Simplifica nombres largos o repetidos.
USO DE "AS"                -> Recomendado, aunque opcional.
USO CON FUNCIONES          -> Ideal para nombrar cálculos.
USO EN SUBCONSULTAS        -> Obligatorio para identificar la tabla resultante.
COMILLAS EN ALIAS          -> Necesarias si el alias tiene espacios.
MEJORA LEGIBILIDAD         -> Sí, ampliamente recomendado.
==============================================================
*/

-- Establece el alias 'Fecha de inicio en programación' a la columna init_date
SELECT name, init_date AS 'Fecha de inicio en programación' FROM users WHERE name = 'Brais';

-- Consulta igual que la anterior. Representa la posibilidad de usar comillas dobles para cadenas
SELECT name, init_date AS "Fecha de inicio en programación" FROM users WHERE name = "Brais"