/*
==============================================================
SECCIÓN 4: FULL JOIN (FULL OUTER JOIN) EN SQL
==============================================================

1. ¿QUÉ ES FULL JOIN?
--------------------------------------------------------------
El comando **FULL JOIN** (o **FULL OUTER JOIN**) combina los resultados
de un LEFT JOIN y un RIGHT JOIN.

Esto significa:
 - Devuelve todas las filas de ambas tablas.
 - Si no hay coincidencia, los campos de la tabla faltante se llenan con NULL.

En otras palabras:
Muestra todo el contenido de ambas tablas, coincidan o no.

==============================================================
2. ESTRUCTURA BÁSICA
--------------------------------------------------------------
SELECT columnas
FROM tabla_izquierda
FULL JOIN tabla_derecha
ON tabla_izquierda.columna = tabla_derecha.columna;

--------------------------------------------------------------
⚠️ Nota importante:
MySQL **NO** soporta FULL JOIN directamente.
Sin embargo, puede simularse combinando LEFT JOIN y RIGHT JOIN
con la cláusula **UNION**.
--------------------------------------------------------------

==============================================================
3. EJEMPLO PRÁCTICO
--------------------------------------------------------------
Tabla: departamentos
--------------------------------------------------------------
id | nombre
---|----------------
1  | Ventas
2  | Finanzas
3  | RRHH

Tabla: empleados
--------------------------------------------------------------
id | nombre | departamento_id
---|--------|----------------
1  | Laura  | 1
2  | Pedro  | 2
3  | Ana    | 1
4  | Luis   | NULL

Simulación de FULL JOIN en MySQL:
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

Resultado:
--------------------------------------------------------------
departamento       | empleado
-------------------|----------
Ventas             | Laura
Finanzas           | Pedro
Ventas             | Ana
RRHH               | NULL
NULL               | Luis

Explicación:
 - Se muestran todos los registros de ambas tablas.
 - Si no hay coincidencia, los valores se muestran como NULL.

==============================================================
4. DIFERENCIA ENTRE FULL, LEFT Y RIGHT JOIN
--------------------------------------------------------------
LEFT JOIN  → Devuelve todo lo de la tabla izquierda.  
RIGHT JOIN → Devuelve todo lo de la tabla derecha.  
FULL JOIN  → Devuelve todo lo de ambas tablas.

Visualmente:
--------------------------------------------------------------
LEFT JOIN:   A + coincidencias  
RIGHT JOIN:  B + coincidencias  
FULL JOIN:   A + B + coincidencias  

==============================================================
5. USO CON CONDICIONES
--------------------------------------------------------------
Puedes agregar filtros en la cláusula ON o WHERE.

Ejemplo:
--------------------------------------------------------------
SELECT d.nombre AS departamento, e.nombre AS empleado
FROM departamentos d
LEFT JOIN empleados e
ON d.id = e.departamento_id
WHERE d.nombre LIKE 'F%'

UNION

SELECT d.nombre AS departamento, e.nombre AS empleado
FROM departamentos d
RIGHT JOIN empleados e
ON d.id = e.departamento_id
WHERE d.nombre LIKE 'F%';

Explicación:
 - Se muestran los empleados y departamentos cuyo nombre
   comienza con la letra "F".
 - UNION asegura que no se repitan filas duplicadas.

==============================================================
6. USO CON UNION ALL
--------------------------------------------------------------
La diferencia entre **UNION** y **UNION ALL**:
 - UNION elimina duplicados.
 - UNION ALL muestra todos los resultados (incluyendo duplicados).

Ejemplo:
--------------------------------------------------------------
SELECT d.nombre AS departamento, e.nombre AS empleado
FROM departamentos d
LEFT JOIN empleados e
ON d.id = e.departamento_id

UNION ALL

SELECT d.nombre AS departamento, e.nombre AS empleado
FROM departamentos d
RIGHT JOIN empleados e
ON d.id = e.departamento_id;

==============================================================
7. FILTRAR REGISTROS SIN COINCIDENCIA
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
-- Mostrar solo los registros que NO tienen coincidencias
SELECT d.nombre AS departamento, e.nombre AS empleado
FROM departamentos d
LEFT JOIN empleados e
ON d.id = e.departamento_id
WHERE e.departamento_id IS NULL

UNION

SELECT d.nombre AS departamento, e.nombre AS empleado
FROM departamentos d
RIGHT JOIN empleados e
ON d.id = e.departamento_id
WHERE d.id IS NULL;

Explicación:
 - Muestra departamentos sin empleados y empleados sin departamento.

==============================================================
8. FULL JOIN CON TRES TABLAS
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
SELECT d.nombre AS departamento,
       e.nombre AS empleado,
       s.nombre AS sede
FROM departamentos d
LEFT JOIN empleados e ON d.id = e.departamento_id
LEFT JOIN sedes s ON e.sede_id = s.id

UNION

SELECT d.nombre AS departamento,
       e.nombre AS empleado,
       s.nombre AS sede
FROM departamentos d
RIGHT JOIN empleados e ON d.id = e.departamento_id
RIGHT JOIN sedes s ON e.sede_id = s.id;

Explicación:
 - Combina información completa de tres tablas, sin perder registros
   de ninguna de ellas.

==============================================================
9. BUENAS PRÁCTICAS
--------------------------------------------------------------
1. Recuerda que MySQL no soporta FULL JOIN directamente.
2. Usa UNION entre LEFT y RIGHT JOIN para lograr el mismo efecto.
3. Si necesitas todos los registros, considera usar UNION ALL.
4. Filtra resultados NULL para identificar datos sin relación.
5. Usa alias (d, e, s) para hacer el código más legible.
6. Ten cuidado con el rendimiento si las tablas son grandes.
7. Evita SELECT * para mejorar claridad y desempeño.
8. Asegúrate de que los tipos de columnas sean compatibles.

==============================================================
10. RESUMEN GENERAL
--------------------------------------------------------------
• FULL JOIN devuelve todas las filas de ambas tablas.  
• MySQL no lo soporta nativamente (usa UNION para simularlo).  
• LEFT + RIGHT JOIN = FULL JOIN.  
• Puede incluir valores NULL donde no existan coincidencias.  
• Ideal para detectar datos faltantes o relaciones incompletas.  
• UNION ALL muestra todo, incluso duplicados.  
• Muy útil en auditorías y reportes de integridad de datos.

==============================================================
*/
