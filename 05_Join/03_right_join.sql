/*
==============================================================
SECCIÓN 3: RIGHT JOIN EN SQL
==============================================================

1. ¿QUÉ ES RIGHT JOIN?
--------------------------------------------------------------
El comando **RIGHT JOIN** (también llamado RIGHT OUTER JOIN)
devuelve todas las filas de la tabla de la derecha,
y las filas coincidentes de la tabla de la izquierda.

Si no existe coincidencia, los campos de la tabla izquierda se llenan con NULL.

En pocas palabras:
 - LEFT JOIN conserva la tabla izquierda.
 - RIGHT JOIN conserva la tabla derecha.

==============================================================
2. ESTRUCTURA BÁSICA
--------------------------------------------------------------
SELECT columnas
FROM tabla_izquierda
RIGHT JOIN tabla_derecha
ON tabla_izquierda.columna = tabla_derecha.columna;

==============================================================
3. EJEMPLO PRÁCTICO
--------------------------------------------------------------
Supongamos estas tablas:

Tabla: departamentos
--------------------------------------------------------------
id | nombre
---|----------------
1  | Ventas
2  | Finanzas
3  | Recursos Humanos

Tabla: empleados
--------------------------------------------------------------
id | nombre | departamento_id
---|--------|----------------
1  | Laura  | 1
2  | Pedro  | 2
3  | Ana    | 1
4  | Juan   | 3
5  | Luis   | NULL

Consulta:
--------------------------------------------------------------
SELECT e.nombre AS empleado, d.nombre AS departamento
FROM departamentos d
RIGHT JOIN empleados e
ON d.id = e.departamento_id;

Resultado:
--------------------------------------------------------------
empleado | departamento
---------|--------------
Laura    | Ventas
Pedro    | Finanzas
Ana      | Ventas
Juan     | Recursos Humanos
Luis     | NULL

Explicación:
 - Se muestran todos los empleados (tabla derecha).
 - Si un empleado no pertenece a ningún departamento, su valor aparece como NULL.

==============================================================
4. DIFERENCIA ENTRE RIGHT JOIN Y LEFT JOIN
--------------------------------------------------------------
LEFT JOIN  → Muestra todas las filas de la tabla izquierda.  
RIGHT JOIN → Muestra todas las filas de la tabla derecha.

Ambos producen el mismo resultado si se invierte el orden de las tablas.

Ejemplo:
--------------------------------------------------------------
SELECT d.nombre, e.nombre
FROM departamentos d
LEFT JOIN empleados e
ON d.id = e.departamento_id;

Es equivalente a:
--------------------------------------------------------------
SELECT e.nombre, d.nombre
FROM empleados e
RIGHT JOIN departamentos d
ON d.departamento_id = e.id;

==============================================================
5. MOSTRAR SOLO REGISTROS SIN COINCIDENCIA
--------------------------------------------------------------
Puedes filtrar los registros de la tabla derecha que no tienen coincidencia en la izquierda.

Ejemplo:
--------------------------------------------------------------
SELECT e.nombre AS empleado
FROM departamentos d
RIGHT JOIN empleados e
ON d.id = e.departamento_id
WHERE d.id IS NULL;

Resultado:
--------------------------------------------------------------
empleado
--------
Luis

Explicación:
 - Muestra los empleados que no tienen un departamento asignado.

==============================================================
6. RIGHT JOIN CON FUNCIONES DE AGRUPACIÓN
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
SELECT e.departamento_id,
       COUNT(d.id) AS total_departamentos
FROM departamentos d
RIGHT JOIN empleados e
ON d.id = e.departamento_id
GROUP BY e.departamento_id;

Explicación:
 - Permite analizar cuántos departamentos coinciden (o no) con los empleados.
 - Si un empleado no tiene departamento, el conteo reflejará el NULL.

==============================================================
7. RIGHT JOIN ENTRE TRES TABLAS
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
SELECT e.nombre AS empleado,
       d.nombre AS departamento,
       s.nombre AS sede
FROM departamentos d
RIGHT JOIN empleados e ON d.id = e.departamento_id
RIGHT JOIN sedes s ON e.sede_id = s.id;

Explicación:
 - Se muestran todas las sedes (tabla derecha final).
 - Si un empleado o departamento no tiene relación, aparecerá como NULL.

==============================================================
8. RIGHT JOIN CON CONDICIONES ADICIONALES
--------------------------------------------------------------
Puedes incluir filtros en el ON o en el WHERE.

Ejemplo:
--------------------------------------------------------------
SELECT e.nombre AS empleado, d.nombre AS departamento
FROM departamentos d
RIGHT JOIN empleados e
ON d.id = e.departamento_id AND d.nombre LIKE 'V%';

Explicación:
 - Muestra todos los empleados.
 - Solo muestra departamentos cuyo nombre empiece por "V".
 - Si no coinciden, el campo del departamento será NULL.

==============================================================
9. BUENAS PRÁCTICAS
--------------------------------------------------------------
1. Usa RIGHT JOIN solo cuando realmente necesites conservar todos los registros de la tabla derecha.  
2. En la mayoría de los casos, un LEFT JOIN con el orden de tablas invertido logra lo mismo y es más legible.  
3. Usa alias (como e y d) para mantener claridad.  
4. Asegúrate de usar las columnas correctas en la condición ON.  
5. Evita SELECT * cuando solo necesites algunas columnas.  
6. Aplica WHERE ... IS NULL para detectar valores faltantes.  
7. Mantén consistencia en el uso de JOINs en todo el proyecto.

==============================================================
10. RESUMEN GENERAL
--------------------------------------------------------------
• RIGHT JOIN muestra todas las filas de la tabla derecha.  
• Los registros sin coincidencia en la izquierda aparecen como NULL.  
• Ideal cuando la tabla derecha es la principal del informe.  
• LEFT JOIN y RIGHT JOIN son opuestos funcionalmente.  
• LEFT JOIN suele ser más común y recomendado por legibilidad.  
==============================================================
*/

-- Obtiene todos los dni junto a su usuario (lo tenga o no)
SELECT * FROM users
RIGHT JOIN dni
ON users.user_id = dni.user_id;

-- Obtiene todos los dni junto al nombre de su usuario (lo tenga o no)
SELECT name, dni_number FROM users
RIGHT JOIN dni
ON users.user_id = dni.user_id;

-- Obtiene el nombre de todos los usuarios junto a su dni (lo tenga o no)
SELECT name, dni_number FROM dni
RIGHT JOIN users
ON users.user_id = dni.user_id;

-- Obtiene el nombre de todos los lenguajes junto a sus usuarios (los tenga o no)
SELECT users.name, languages.name
FROM users
RIGHT JOIN users_languages ON users.user_id=users_languages.user_id
RIGHT JOIN languages ON users_languages.language_id=languages.language_id;