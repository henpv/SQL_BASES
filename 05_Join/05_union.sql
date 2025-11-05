/*
==============================================================
SECCIÓN 5: UNION Y UNION ALL EN SQL
==============================================================

1. ¿QUÉ ES UNION?
--------------------------------------------------------------
El operador **UNION** en SQL se utiliza para combinar los resultados
de dos o más sentencias **SELECT**.

Cada SELECT debe tener:
 - El mismo número de columnas.
 - Tipos de datos compatibles.
 - Orden de columnas correspondiente.

UNION elimina los registros duplicados entre las consultas combinadas.

==============================================================
2. ESTRUCTURA BÁSICA
--------------------------------------------------------------
SELECT columna1, columna2, ...
FROM tabla1
[WHERE condición]

UNION

SELECT columna1, columna2, ...
FROM tabla2
[WHERE condición];

==============================================================
3. DIFERENCIA ENTRE UNION Y UNION ALL
--------------------------------------------------------------
• **UNION** → combina resultados y elimina duplicados (usa un filtro interno tipo DISTINCT).  
• **UNION ALL** → combina resultados y mantiene todos los registros, incluso los duplicados.  

Ejemplo rápido:
--------------------------------------------------------------
SELECT ciudad FROM clientes
UNION
SELECT ciudad FROM proveedores;

-- Elimina ciudades repetidas.

SELECT ciudad FROM clientes
UNION ALL
SELECT ciudad FROM proveedores;

-- Muestra todas las ciudades, incluso si están duplicadas.

==============================================================
4. EJEMPLO PRÁCTICO CON DOS TABLAS
--------------------------------------------------------------
Tabla: clientes
--------------------------------------------------------------
id | nombre   | ciudad
---|----------|---------
1  | Laura    | Bogotá
2  | Pedro    | Cali
3  | Ana      | Medellín

Tabla: proveedores
--------------------------------------------------------------
id | nombre     | ciudad
---|------------|---------
1  | Carlos     | Cali
2  | Valentina  | Bogotá
3  | Andrés     | Barranquilla

Consulta:
--------------------------------------------------------------
SELECT nombre, ciudad, 'Cliente' AS tipo
FROM clientes

UNION

SELECT nombre, ciudad, 'Proveedor' AS tipo
FROM proveedores;

Resultado:
--------------------------------------------------------------
nombre     | ciudad        | tipo
-----------|---------------|------------
Laura      | Bogotá        | Cliente
Pedro      | Cali          | Cliente
Ana        | Medellín      | Cliente
Carlos     | Cali          | Proveedor
Valentina  | Bogotá        | Proveedor
Andrés     | Barranquilla  | Proveedor

Explicación:
 - Las dos consultas deben devolver el mismo número de columnas.
 - Las etiquetas de tipo ayudan a identificar el origen del registro.

==============================================================
5. UNION ALL PARA CONSERVAR DUPLICADOS
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
SELECT ciudad FROM clientes
UNION ALL
SELECT ciudad FROM proveedores;

Resultado (incluye duplicados):
--------------------------------------------------------------
Bogotá
Cali
Medellín
Cali
Bogotá
Barranquilla

==============================================================
6. USO CON ORDER BY
--------------------------------------------------------------
El **ORDER BY** solo puede aplicarse **una vez** al final de todas las consultas.

Ejemplo:
--------------------------------------------------------------
SELECT nombre, ciudad FROM clientes
UNION
SELECT nombre, ciudad FROM proveedores
ORDER BY ciudad ASC;

Explicación:
 - Ordena el resultado final, no cada consulta por separado.

==============================================================
7. USO CON WHERE Y CONDICIONES DIFERENTES
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
SELECT nombre, ciudad
FROM clientes
WHERE ciudad LIKE 'B%'

UNION

SELECT nombre, ciudad
FROM proveedores
WHERE ciudad LIKE 'B%';

Explicación:
 - Combina los nombres de clientes y proveedores cuya ciudad
   comienza con la letra "B".

==============================================================
8. UNION ENTRE MÁS DE DOS CONSULTAS
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
SELECT nombre, ciudad FROM clientes
UNION
SELECT nombre, ciudad FROM proveedores
UNION
SELECT nombre, ciudad FROM empleados;

Explicación:
 - Puedes unir tres o más SELECT, siempre que cumplan
   las mismas reglas de número y tipo de columnas.

==============================================================
9. USO DE ALIAS Y CAMPOS CALCULADOS
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
SELECT nombre, 'Cliente' AS tipo FROM clientes
UNION
SELECT nombre, 'Proveedor' AS tipo FROM proveedores
UNION
SELECT nombre, 'Empleado' AS tipo FROM empleados;

Explicación:
 - El campo “tipo” se usa para identificar el origen de cada registro.

==============================================================
10. SIMULACIÓN DE FULL JOIN USANDO UNION
--------------------------------------------------------------
Ejemplo (para MySQL):
--------------------------------------------------------------
SELECT d.nombre AS departamento, e.nombre AS empleado
FROM departamentos d
LEFT JOIN empleados e
ON d.id = e.departamento_id

UNION

SELECT d.nombre AS departamento, e.nombre AS empleado
FROM departamentos d
RIGHT JOIN empleados e
ON d.id = e.departamento_id;

Explicación:
 - Como MySQL no soporta FULL JOIN, se logra el mismo resultado
   combinando LEFT y RIGHT JOIN con UNION.

==============================================================
11. BUENAS PRÁCTICAS
--------------------------------------------------------------
1. Asegúrate de que cada SELECT tenga el mismo número de columnas.
2. Los tipos de datos deben ser compatibles (por ejemplo, texto con texto).
3. Usa UNION ALL si necesitas incluir duplicados.
4. Aplica ORDER BY solo al final de todas las consultas.
5. Usa alias descriptivos para saber de qué tabla proviene cada resultado.
6. UNION puede afectar el rendimiento si hay muchas filas, ya que elimina duplicados.
7. Usa UNION ALL si no necesitas eliminar duplicados (más rápido).

==============================================================
12. RESUMEN GENERAL
--------------------------------------------------------------
• UNION combina resultados y elimina duplicados.  
• UNION ALL conserva duplicados.  
• Las columnas deben coincidir en número y tipo.  
• ORDER BY se aplica al final del conjunto.  
• Es útil para fusionar datos similares de tablas distintas.  
• Puede usarse para simular un FULL JOIN en MySQL.  
==============================================================
*/

-- UNION elimina duplicados

-- Obtiene todos los id de usuarios de las tablas dni y usuarios (exista o no relación)
SELECT users.user_id AS u_user_id, dni.user_id AS d_user_id
FROM users
LEFT JOIN dni
ON users.user_id = dni.user_id
UNION
SELECT users.user_id AS user_id, dni.user_id AS d_user_id
FROM users
RIGHT JOIN dni
ON users.user_id = dni.user_id;

-- Obtiene todos los datos de las tablas dni y usuarios (exista o no relación)
SELECT *
FROM users
LEFT JOIN dni
ON users.user_id = dni.user_id
UNION
SELECT *
FROM users
RIGHT JOIN dni
ON users.user_id = dni.user_id;

-- UNION ALL mantiene duplicados