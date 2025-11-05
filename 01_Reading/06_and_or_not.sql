/*
==============================================================
SECCIÓN 6: OPERADORES LÓGICOS EN SQL
==============================================================

1. ¿Qué son los operadores lógicos?
--------------------------------------------------------------
Los operadores lógicos en SQL permiten combinar o negar condiciones
dentro de una cláusula WHERE, para crear filtros más complejos y precisos.

Los principales operadores lógicos son:
- AND
- OR
- NOT

==============================================================
2. OPERADOR AND
==============================================================
El operador AND se utiliza para combinar dos o más condiciones.
Solo se devuelven las filas que CUMPLEN TODAS las condiciones.

Estructura:
--------------------------------------------------------------
SELECT columnas
FROM tabla
WHERE condición1 AND condición2;

Ejemplo:
--------------------------------------------------------------
-- Mostrar usuarios activos mayores de 18 años
SELECT nombre, edad, estado
FROM usuarios
WHERE estado = 'activo' AND edad >= 18;

Explicación:
Solo se mostrarán los usuarios que estén activos Y además tengan 18 años o más.

==============================================================
3. OPERADOR OR
==============================================================
El operador OR se utiliza cuando queremos que se cumpla
AL MENOS UNA de las condiciones.

Estructura:
--------------------------------------------------------------
SELECT columnas
FROM tabla
WHERE condición1 OR condición2;

Ejemplo:
--------------------------------------------------------------
-- Mostrar usuarios que sean de México o de Perú
SELECT nombre, pais
FROM usuarios
WHERE pais = 'México' OR pais = 'Perú';

Explicación:
El registro se mostrará si cumple cualquiera de las dos condiciones.

==============================================================
4. COMBINAR AND Y OR
==============================================================
Puedes combinar ambos operadores para crear condiciones más avanzadas.
Cuando lo hagas, usa paréntesis para dejar clara la prioridad.

Ejemplo:
--------------------------------------------------------------
-- Usuarios activos de México o Perú
SELECT nombre, pais, estado
FROM usuarios
WHERE estado = 'activo' AND (pais = 'México' OR pais = 'Perú');

Explicación:
Primero se evalúa la condición dentro de los paréntesis,
luego se aplica el AND con el estado.

==============================================================
5. OPERADOR NOT
==============================================================
El operador NOT se usa para negar una condición.
Devuelve los registros que NO cumplen la condición indicada.

Estructura:
--------------------------------------------------------------
SELECT columnas
FROM tabla
WHERE NOT condición;

Ejemplos:
--------------------------------------------------------------
-- Mostrar usuarios que NO sean de Colombia
SELECT nombre, pais
FROM usuarios
WHERE NOT pais = 'Colombia';

-- Mostrar usuarios que NO estén activos
SELECT nombre, estado
FROM usuarios
WHERE NOT estado = 'activo';

==============================================================
6. COMBINAR NOT CON OTROS OPERADORES
==============================================================
NOT puede aplicarse a cualquier condición, incluyendo IN, LIKE y BETWEEN.

Ejemplos:
--------------------------------------------------------------
-- Usuarios que no pertenezcan a los países indicados
SELECT nombre, pais
FROM usuarios
WHERE pais NOT IN ('Colombia', 'México', 'Perú');

-- Usuarios cuyo nombre no empiece con 'A'
SELECT nombre
FROM usuarios
WHERE nombre NOT LIKE 'A%';

-- Usuarios con edad fuera del rango 18-30
SELECT nombre, edad
FROM usuarios
WHERE edad NOT BETWEEN 18 AND 30;

==============================================================
7. ORDEN DE EVALUACIÓN DE CONDICIONES
==============================================================
Cuando se usan varios operadores lógicos, SQL los evalúa en este orden:

1) NOT
2) AND
3) OR

Ejemplo:
--------------------------------------------------------------
SELECT nombre, pais, estado
FROM usuarios
WHERE NOT pais = 'Colombia' AND estado = 'activo' OR edad > 30;

Explicación:
1. Primero se aplica NOT pais = 'Colombia'
2. Luego AND estado = 'activo'
3. Por último OR edad > 30

Si quieres cambiar el orden, usa paréntesis para hacerlo explícito:
--------------------------------------------------------------
SELECT nombre, pais, estado
FROM usuarios
WHERE NOT (pais = 'Colombia' AND estado = 'activo') OR edad > 30;

==============================================================
8. EJEMPLOS PRÁCTICOS COMBINADOS
================================================--------------
-- Usuarios activos de Colombia mayores de 25 años
SELECT nombre, pais, edad, estado
FROM usuarios
WHERE estado = 'activo' AND pais = 'Colombia' AND edad > 25;

-- Usuarios inactivos o suspendidos, pero NO de México
SELECT nombre, pais, estado
FROM usuarios
WHERE (estado = 'inactivo' OR estado = 'suspendido')
  AND NOT pais = 'México';

-- Usuarios cuyo nombre empiece con 'J' o 'M' y estén activos
SELECT nombre, estado
FROM usuarios
WHERE estado = 'activo' AND (nombre LIKE 'J%' OR nombre LIKE 'M%');

==============================================================
9. RESUMEN GENERAL
==============================================================
AND     -> Todas las condiciones deben cumplirse
OR      -> Al menos una condición debe cumplirse
NOT     -> Niega una condición
PRIORIDAD DE EVALUACIÓN -> NOT → AND → OR
USAR PARÉNTESIS -> Para agrupar condiciones y evitar confusiones
==============================================================
*/

-- Obtiene todos datos de la tabla "users" con email distinto a sara@gmail.com
SELECT * FROM users WHERE NOT email = 'sara@gmail.com';

-- Obtiene todos datos de la tabla "users" con email distinto a sara@gmail.com y edad igual a 15
SELECT * FROM users WHERE NOT email = 'sara@gmail.com' AND age = 15;

-- Obtiene todos datos de la tabla "users" con email distinto a sara@gmail.com o edad igual a 15
SELECT * FROM users WHERE NOT email = 'sara@gmail.com' OR age = 15;