/*
==============================================================
SECCIÓN 2: LEFT JOIN EN SQL
==============================================================

1. ¿QUÉ ES LEFT JOIN?
--------------------------------------------------------------
El comando **LEFT JOIN** (también llamado LEFT OUTER JOIN)
devuelve todas las filas de la tabla de la izquierda,
y las filas coincidentes de la tabla de la derecha.

Si no existe coincidencia, los campos de la tabla derecha se llenan con NULL.

==============================================================
2. ESTRUCTURA BÁSICA
--------------------------------------------------------------
SELECT columnas
FROM tabla_izquierda
LEFT JOIN tabla_derecha
ON tabla_izquierda.columna = tabla_derecha.columna;

==============================================================
3. EJEMPLO SENCILLO
--------------------------------------------------------------
Supongamos estas tablas:

Tabla: departamentos
--------------------------------------------------------------
id | nombre
---|----------------
1  | Ventas
2  | Finanzas
3  | Recursos Humanos
4  | Marketing

Tabla: empleados
--------------------------------------------------------------
id | nombre | departamento_id
---|--------|----------------
1  | Laura  | 1
2  | Pedro  | 2
3  | Ana    | 1
4  | Juan   | 3

Consulta:
--------------------------------------------------------------
SELECT d.nombre AS departamento, e.nombre AS empleado
FROM departamentos d
LEFT JOIN empleados e
ON d.id = e.departamento_id;

Resultado:
--------------------------------------------------------------
departamento       | empleado
-------------------|----------
Ventas             | Laura
Ventas             | Ana
Finanzas           | Pedro
Recursos Humanos   | Juan
Marketing          | NULL

Explicación:
 - Se muestran todos los departamentos.
 - Si un departamento no tiene empleados, sus columnas del lado derecho quedan en NULL.

==============================================================
4. DIFERENCIA ENTRE LEFT JOIN E INNER JOIN
--------------------------------------------------------------
INNER JOIN → Solo muestra las filas que coinciden en ambas tablas.  
LEFT JOIN  → Muestra todas las filas de la tabla izquierda, aunque no coincidan.

Ejemplo de comparación:

INNER JOIN:
--------------------------------------------------------------
SELECT d.nombre, e.nombre
FROM departamentos d
INNER JOIN empleados e
ON d.id = e.departamento_id;

LEFT JOIN:
--------------------------------------------------------------
SELECT d.nombre, e.nombre
FROM departamentos d
LEFT JOIN empleados e
ON d.id = e.departamento_id;

La diferencia:
 - El LEFT JOIN muestra también "Marketing", aunque no tenga empleados.

==============================================================
5. MOSTRAR SOLO REGISTROS SIN COINCIDENCIA
--------------------------------------------------------------
Puedes usar una condición para filtrar los registros de la izquierda
que no tienen coincidencias en la derecha.

Ejemplo:
--------------------------------------------------------------
SELECT d.nombre AS departamento
FROM departamentos d
LEFT JOIN empleados e
ON d.id = e.departamento_id
WHERE e.id IS NULL;

Resultado:
--------------------------------------------------------------
departamento
------------
Marketing

Explicación:
 - Muestra solo los departamentos que no tienen empleados asignados.

==============================================================
6. LEFT JOIN CON FUNCIONES DE AGRUPACIÓN
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
SELECT d.nombre AS departamento,
       COUNT(e.id) AS total_empleados
FROM departamentos d
LEFT JOIN empleados e
ON d.id = e.departamento_id
GROUP BY d.nombre;

Resultado:
--------------------------------------------------------------
departamento       | total_empleados
-------------------|----------------
Ventas             | 2
Finanzas           | 1
Recursos Humanos   | 1
Marketing          | 0

Explicación:
 - “Marketing” aparece con 0 empleados gracias al LEFT JOIN.

==============================================================
7. LEFT JOIN ENTRE TRES TABLAS
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
SELECT e.nombre AS empleado,
       d.nombre AS departamento,
       s.nombre AS sede
FROM empleados e
LEFT JOIN departamentos d ON e.departamento_id = d.id
LEFT JOIN sedes s ON d.sede_id = s.id;

Explicación:
 - Siempre se muestran todos los empleados.
 - Si un empleado no tiene departamento o la sede no está asignada, se mostrará NULL.

==============================================================
8. LEFT JOIN CON CONDICIONES ADICIONALES
--------------------------------------------------------------
Puedes combinar condiciones dentro del ON o en el WHERE.

Ejemplo:
--------------------------------------------------------------
SELECT d.nombre AS departamento, e.nombre AS empleado
FROM departamentos d
LEFT JOIN empleados e
ON d.id = e.departamento_id AND e.nombre LIKE 'A%';

Explicación:
 - Muestra todos los departamentos.
 - Solo muestra empleados cuyo nombre empiece por “A”.
 - Los demás empleados quedan fuera, pero los departamentos siguen apareciendo.

==============================================================
9. BUENAS PRÁCTICAS
--------------------------------------------------------------
1. Usa LEFT JOIN cuando quieras conservar todos los registros de la tabla principal.  
2. Usa WHERE ... IS NULL para detectar registros sin coincidencia.  
3. Asegúrate de que las columnas unidas tengan tipos de datos compatibles.  
4. Usa alias para mejorar la legibilidad.  
5. No uses SELECT * si solo necesitas algunas columnas.  
6. Indexa las columnas utilizadas en las uniones.  
7. Revisa los resultados para interpretar correctamente los NULL.

==============================================================
10. RESUMEN GENERAL
--------------------------------------------------------------
• LEFT JOIN muestra todas las filas de la tabla izquierda.  
• Los registros sin coincidencia en la derecha muestran NULL.  
• Ideal para reportes completos y detectar datos faltantes.  
• Compatible con GROUP BY, WHERE, alias y múltiples uniones.  
• Es uno de los JOIN más usados junto con INNER JOIN.  
==============================================================
*/

-- Obtiene los datos de todos los usuarios junto a su dni (lo tenga o no)
SELECT * FROM users
LEFT JOIN dni
ON users.user_id = dni.user_id;

-- Obtiene el nombre de todos los usuarios junto a su dni (lo tenga o no)
SELECT name, dni_number FROM users
LEFT JOIN dni
ON users.user_id = dni.user_id;

-- Obtiene todos los dni junto al nombre de su usuario (lo tenga o no)
SELECT name, dni_number FROM dni
LEFT JOIN users
ON users.user_id = dni.user_id;

-- Obtiene el nombre de todos los usuarios junto a sus lenguajes (los tenga o no)
SELECT users.name, languages.name
FROM users
LEFT JOIN users_languages ON users.user_id=users_languages.user_id
LEFT JOIN languages ON users_languages.language_id=languages.language_id;