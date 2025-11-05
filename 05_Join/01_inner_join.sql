/*
==============================================================
SECCIÓN 1: INNER JOIN EN SQL
==============================================================

1. ¿QUÉ ES INNER JOIN?
--------------------------------------------------------------
El comando **INNER JOIN** se utiliza para **combinar filas de dos o más tablas**
basándose en una condición de coincidencia entre columnas relacionadas.

Muestra únicamente las filas donde **existe una coincidencia en ambas tablas**.

Si un registro no tiene correspondencia, no aparecerá en el resultado.

==============================================================
2. SINTAXIS BÁSICA
--------------------------------------------------------------
SELECT columnas
FROM tabla1
INNER JOIN tabla2
ON tabla1.columna = tabla2.columna;

Explicación:
 - **tabla1** y **tabla2**: las tablas que deseas unir.
 - **ON**: define la condición que relaciona ambas tablas.
 - Solo se muestran las filas donde los valores coinciden en ambas tablas.

==============================================================
3. EJEMPLO PRÁCTICO
--------------------------------------------------------------
Supongamos que tenemos las siguientes tablas:

Tabla: empleados
--------------------------------------------------------------
id | nombre   | departamento_id
---|----------|----------------
1  | Laura    | 1
2  | Pedro    | 2
3  | Ana      | 1
4  | Juan     | 3

Tabla: departamentos
--------------------------------------------------------------
id | nombre
---|----------------
1  | Ventas
2  | Finanzas
3  | Recursos Humanos

Consulta:
--------------------------------------------------------------
SELECT empleados.nombre, departamentos.nombre AS departamento
FROM empleados
INNER JOIN departamentos
ON empleados.departamento_id = departamentos.id;

Resultado:
--------------------------------------------------------------
nombre | departamento
--------|----------------
Laura  | Ventas
Pedro  | Finanzas
Ana    | Ventas
Juan   | Recursos Humanos

Explicación:
 - INNER JOIN combina las tablas “empleados” y “departamentos”.
 - Solo muestra los empleados que tienen un departamento válido.
 - Si un empleado no tuviera un “departamento_id” asignado, no aparecería.

==============================================================
4. INNER JOIN ENTRE TRES O MÁS TABLAS
--------------------------------------------------------------
También puedes unir varias tablas a la vez, siempre que estén relacionadas.

Ejemplo:
--------------------------------------------------------------
SELECT e.nombre AS empleado,
       d.nombre AS departamento,
       s.nombre AS sede
FROM empleados e
INNER JOIN departamentos d ON e.departamento_id = d.id
INNER JOIN sedes s ON d.sede_id = s.id;

Explicación:
 - Se combinan tres tablas: empleados, departamentos y sedes.
 - Cada INNER JOIN debe tener su condición ON.
 - Solo se muestran las filas donde todas las relaciones tienen coincidencia.

==============================================================
5. USO DE ALIAS EN INNER JOIN
--------------------------------------------------------------
Los alias (abreviaciones) facilitan la lectura de consultas largas.

Ejemplo:
--------------------------------------------------------------
SELECT e.nombre, d.nombre AS depto
FROM empleados AS e
INNER JOIN departamentos AS d
ON e.departamento_id = d.id;

Explicación:
 - “e” representa a la tabla empleados.
 - “d” representa a la tabla departamentos.
 - Se simplifica la sintaxis, especialmente en consultas complejas.

==============================================================
6. INNER JOIN CON CONDICIONES ADICIONALES
--------------------------------------------------------------
Puedes agregar condiciones adicionales usando WHERE.

Ejemplo:
--------------------------------------------------------------
SELECT e.nombre, d.nombre AS depto
FROM empleados e
INNER JOIN departamentos d
ON e.departamento_id = d.id
WHERE d.nombre = 'Ventas';

Explicación:
 - Se muestran solo los empleados del departamento “Ventas”.
 - Se combinan condiciones de relación y filtrado.

==============================================================
7. INNER JOIN ENTRE TABLAS SIN CLAVE FORÁNEA FORMAL
--------------------------------------------------------------
Aunque no haya una FOREIGN KEY definida en el esquema,
puedes unir tablas siempre que haya columnas con valores en común.

Ejemplo:
--------------------------------------------------------------
SELECT a.nombre, b.ciudad
FROM alumnos a
INNER JOIN colegios b
ON a.codigo_colegio = b.codigo;

==============================================================
8. INNER JOIN Y AGRUPAMIENTO (GROUP BY)
--------------------------------------------------------------
También puedes combinar INNER JOIN con funciones de agregación.

Ejemplo:
--------------------------------------------------------------
SELECT d.nombre AS departamento,
       COUNT(e.id) AS total_empleados
FROM empleados e
INNER JOIN departamentos d
ON e.departamento_id = d.id
GROUP BY d.nombre;

Resultado:
--------------------------------------------------------------
departamento       | total_empleados
-------------------|----------------
Ventas             | 2
Finanzas           | 1
Recursos Humanos   | 1

Explicación:
 - Se cuentan los empleados por departamento.
 - INNER JOIN une las tablas antes de agrupar los resultados.

==============================================================
9. DIFERENCIA ENTRE INNER JOIN Y OTROS JOIN
--------------------------------------------------------------
INNER JOIN → Muestra solo los registros con coincidencia en ambas tablas.  
LEFT JOIN  → Muestra todos los registros de la izquierda y los coincidentes de la derecha.  
RIGHT JOIN → Muestra todos los registros de la derecha y los coincidentes de la izquierda.  
FULL JOIN  → Muestra todos los registros, coincidan o no (no disponible en todas las bases de datos).

==============================================================
10. BUENAS PRÁCTICAS
--------------------------------------------------------------
1. Usa alias para mejorar la legibilidad.
2. Asegúrate de que las columnas unidas tengan el mismo tipo de dato.
3. Evita unir tablas innecesarias; puede afectar el rendimiento.
4. Utiliza índices en las columnas que se usan en los JOIN.
5. Siempre verifica los resultados, especialmente con datos duplicados.
6. Para depurar una consulta compleja, prueba cada JOIN por separado.
7. Evita usar SELECT * en consultas con JOIN; especifica las columnas necesarias.

==============================================================
11. RESUMEN GENERAL
--------------------------------------------------------------
• INNER JOIN combina datos de tablas relacionadas.  
• Solo muestra las filas con coincidencias en ambas tablas.  
• Puede aplicarse entre dos o más tablas.  
• Se usa ON para definir la relación y WHERE para filtros adicionales.  
• Compatible con agregaciones, alias y condiciones múltiples.  
• Es el JOIN más común en el diseño de bases de datos relacionales.
==============================================================
*/

-- Realiza un JOIN de manera incorrecta, ya que no existe un campo de relación
SELECT * FROM users
INNER JOIN dni;

-- Obtiene los datos de los usuarios que tienen un dni 
SELECT * FROM users
INNER JOIN dni
ON users.user_id = dni.user_id;

-- Obtiene los datos de los usuarios que tienen un dni (JOIN es lo mismo que INNER JOIN)
SELECT * FROM users
JOIN dni
ON users.user_id = dni.user_id;

-- Obtiene el nombre y el dni de los usuarios que tienen un dni y los ordena por edad
SELECT name, dni_number FROM users
JOIN dni
ON users.user_id = dni.user_id
ORDER BY age ASC;

-- Obtiene los datos de los usuarios que tienen empresa
SELECT * FROM users
JOIN companies
ON users.company_id = companies.company_id;

-- Obtiene los datos de las empresas que tienen usuarios
SELECT * FROM companies
JOIN users
ON users.company_id = companies.company_id;

-- Obtiene el nombre de las empresas junto al nombre de sus usuarios
SELECT companies.name, users.name FROM companies
JOIN users
ON companies.company_id = users.company_id;

-- Obtiene los nombres de usuarios junto a los lenguajes que conocen
SELECT users.name, languages.name
FROM users_languages
JOIN users ON users_languages.user_id=users.user_id
JOIN languages ON users_languages.language_id=languages.language_id;

-- Obtiene los nombres de usuarios junto a los lenguajes que conocen (utilizando otro orden de relación entre tablas)
SELECT users.name, languages.name
FROM users
JOIN users_languages ON users.user_id=users_languages.user_id
JOIN languages ON users_languages.language_id=languages.language_id;