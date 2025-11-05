/*
==============================================================
SECCIÓN 8: VALORES NULL EN SQL
==============================================================

1. ¿Qué es NULL?
--------------------------------------------------------------
En SQL, NULL representa la ausencia de un valor.
No significa “cero” ni “cadena vacía”, sino simplemente
que el dato es desconocido, no definido o no aplicable.

Ejemplo:
--------------------------------------------------------------
Una tabla de usuarios podría tener:
- Un campo “telefono” NULL si el usuario no registró número.
- Un campo “fecha_baja” NULL si el usuario sigue activo.

==============================================================
2. DIFERENCIA ENTRE NULL Y OTROS VALORES
==============================================================
NULL no es igual a 0, ni a '', ni a “ningún valor”.
Es un estado lógico que significa “sin dato”.

Ejemplo conceptual:
--------------------------------------------------------------
NULL ≠ 0
NULL ≠ ''
NULL ≠ 'NULL'
NULL ≠ cualquier otro valor

==============================================================
3. COMPARAR VALORES NULL
==============================================================
No se puede usar = o <> para comparar valores NULL.
En su lugar, se deben usar los operadores IS NULL e IS NOT NULL.

Ejemplos:
--------------------------------------------------------------
-- Usuarios sin correo registrado
SELECT nombre
FROM usuarios
WHERE correo IS NULL;

-- Usuarios con correo registrado
SELECT nombre
FROM usuarios
WHERE correo IS NOT NULL;

==============================================================
4. RESULTADOS DE OPERACIONES CON NULL
==============================================================
Cualquier operación que involucra NULL produce NULL.

Ejemplos:
--------------------------------------------------------------
SELECT 5 + NULL;          -- Resultado: NULL
SELECT 'Texto' || NULL;   -- Resultado: NULL
SELECT NULL = NULL;       -- Resultado: NULL (no TRUE)

Explicación:
SQL considera que NULL no es igual ni diferente a otro NULL,
porque ambos representan “valor desconocido”.

==============================================================
5. USAR FUNCIONES PARA REEMPLAZAR NULL
==============================================================
Puedes usar funciones para sustituir valores NULL por un valor definido.

Funciones útiles:
--------------------------------------------------------------
COALESCE(valor1, valor2, ...)  -> Devuelve el primer valor que no sea NULL
IFNULL(valor, reemplazo)       -> Devuelve el reemplazo si el valor es NULL

Ejemplos:
--------------------------------------------------------------
-- Mostrar 'Sin correo' si el campo correo está NULL
SELECT nombre, IFNULL(correo, 'Sin correo') AS correo_mostrado
FROM usuarios;

-- Mostrar teléfono o el texto 'No disponible'
SELECT nombre, COALESCE(telefono, 'No disponible') AS telefono
FROM usuarios;

==============================================================
6. USAR NULL EN CONDICIONES CONJUNTAS
==============================================================
Puedes combinar IS NULL con otros operadores.

Ejemplos:
--------------------------------------------------------------
-- Usuarios activos sin fecha de baja
SELECT nombre, estado
FROM usuarios
WHERE estado = 'activo' AND fecha_baja IS NULL;

-- Usuarios inactivos con fecha de baja asignada
SELECT nombre, fecha_baja
FROM usuarios
WHERE estado = 'inactivo' AND fecha_baja IS NOT NULL;

==============================================================
7. ORDENAR Y AGRUPAR VALORES NULL
==============================================================
Por defecto, los valores NULL suelen aparecer al final
cuando se usa ORDER BY ASC, y al inicio cuando es DESC,
aunque esto depende del motor de base de datos.

Ejemplo:
--------------------------------------------------------------
-- Ordenar por correo, mostrando los NULL al final
SELECT nombre, correo
FROM usuarios
ORDER BY correo ASC;

-- Agrupar registros considerando valores NULL
SELECT pais, COUNT(*) AS total
FROM usuarios
GROUP BY pais;

Nota:
NULL se trata como un grupo separado dentro de GROUP BY.

==============================================================
8. FUNCIONES DE AGREGACIÓN Y NULL
==============================================================
Las funciones de agregación (COUNT, SUM, AVG, etc.)
ignoran automáticamente los valores NULL,
excepto COUNT(*), que cuenta todas las filas.

Ejemplos:
--------------------------------------------------------------
-- Cuenta solo los registros con edad conocida
SELECT COUNT(edad) FROM usuarios;

-- Cuenta todas las filas, incluidas las que tienen edad NULL
SELECT COUNT(*) FROM usuarios;

-- Promedio de edades (sin contar NULL)
SELECT AVG(edad) FROM usuarios;

==============================================================
9. INSERCIÓN Y COMPORTAMIENTO DE NULL
==============================================================
Puedes insertar NULL explícitamente o dejar el campo vacío
si permite valores nulos.

Ejemplos:
--------------------------------------------------------------
INSERT INTO usuarios (nombre, telefono)
VALUES ('Carlos', NULL);

INSERT INTO usuarios (nombre)
VALUES ('María');  -- telefono será NULL por omisión

==============================================================
10. RESUMEN GENERAL
==============================================================
NULL              -> Representa un valor desconocido o ausente
NO ES IGUAL A     -> 0, '', o cualquier otro valor
COMPARACIÓN       -> Usar IS NULL o IS NOT NULL
FUNCIONES ÚTILES  -> IFNULL(), COALESCE()
EN AGREGACIÓN     -> Se ignora, excepto con COUNT(*)
BUENA PRÁCTICA    -> Reemplazar NULL en resultados visibles
==============================================================
*/

-- Obtiene todos datos de la tabla "users" de la tabla "users" con email nulo
SELECT * FROM users WHERE email IS NULL;

-- Obtiene todos datos de la tabla "users" de la tabla "users" con email no nulo
SELECT * FROM users WHERE email IS NOT NULL;

-- Obtiene todos datos de la tabla "users" de la tabla "users" con email no nulo y edad igual a 15
SELECT * FROM users WHERE email IS NOT NULL AND age = 15;

/*
IFNULL
Lección 10.14: https://youtu.be/OuJerKzV5T0?t=10023
*/

-- Obtiene el nombre, apellido y edad de la tabla "users", y si la edad es nula la muestra como 0
SELECT name, surname, IFNULL(age, 0) AS age FROM users;