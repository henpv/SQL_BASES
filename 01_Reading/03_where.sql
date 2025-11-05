/*
==============================================================
SECCIÓN 3: CLAÚSULA WHERE EN SQL
==============================================================

1. ¿Qué es WHERE?
--------------------------------------------------------------
La cláusula WHERE se utiliza en SQL para filtrar registros
que cumplen con una o varias condiciones específicas.

Solo las filas que satisfacen las condiciones de WHERE
serán incluidas en los resultados de la consulta.

==============================================================
2. ESTRUCTURA BÁSICA
==============================================================
SELECT columnas
FROM tabla
WHERE condición;

Ejemplo:
--------------------------------------------------------------
-- Mostrar los usuarios que estén activos
SELECT nombre, correo
FROM usuarios
WHERE estado = 'activo';

==============================================================
3. OPERADORES DE COMPARACIÓN
==============================================================
WHERE permite usar operadores lógicos para comparar valores.

Lista de operadores más comunes:
--------------------------------------------------------------
=      Igual
<>     Diferente (también !=)
>      Mayor que
<      Menor que
>=     Mayor o igual que
<=     Menor o igual que

Ejemplos:
--------------------------------------------------------------
-- Usuarios mayores de 18 años
SELECT nombre, edad
FROM usuarios
WHERE edad > 18;

-- Usuarios con edad igual a 25
SELECT nombre, edad
FROM usuarios
WHERE edad = 25;

-- Usuarios con edad diferente de 30
SELECT nombre, edad
FROM usuarios
WHERE edad <> 30;

==============================================================
4. OPERADORES LÓGICOS
==============================================================
Se pueden combinar varias condiciones con operadores lógicos:

AND     -> Ambas condiciones deben cumplirse
OR      -> Al menos una condición debe cumplirse
NOT     -> Niega una condición

Ejemplos:
--------------------------------------------------------------
-- Usuarios activos mayores de 18 años
SELECT nombre, edad, estado
FROM usuarios
WHERE estado = 'activo' AND edad > 18;

-- Usuarios que estén inactivos o suspendidos
SELECT nombre, estado
FROM usuarios
WHERE estado = 'inactivo' OR estado = 'suspendido';

-- Usuarios que no sean de Colombia
SELECT nombre, pais
FROM usuarios
WHERE NOT pais = 'Colombia';

==============================================================
5. OPERADOR BETWEEN
==============================================================
Se usa para buscar valores dentro de un rango (inclusive).

Ejemplo:
--------------------------------------------------------------
-- Usuarios con edad entre 18 y 30 años
SELECT nombre, edad
FROM usuarios
WHERE edad BETWEEN 18 AND 30;

-- Equivalente sin BETWEEN
SELECT nombre, edad
FROM usuarios
WHERE edad >= 18 AND edad <= 30;

==============================================================
6. OPERADOR IN
==============================================================
Permite especificar varios valores posibles para una columna.

Ejemplo:
--------------------------------------------------------------
-- Usuarios de Colombia, México o Perú
SELECT nombre, pais
FROM usuarios
WHERE pais IN ('Colombia', 'México', 'Perú');

-- Excluir esos países
SELECT nombre, pais
FROM usuarios
WHERE pais NOT IN ('Colombia', 'México', 'Perú');

==============================================================
7. OPERADOR LIKE (búsquedas con texto)
==============================================================
LIKE se usa para buscar patrones en texto.
Los comodines más usados son:
- % (porcentaje): representa cualquier cantidad de caracteres.
- _ (guion bajo): representa un solo carácter.

Ejemplos:
--------------------------------------------------------------
-- Usuarios cuyo nombre comience con 'A'
SELECT nombre
FROM usuarios
WHERE nombre LIKE 'A%';

-- Usuarios cuyo correo termine en '@gmail.com'
SELECT nombre, correo
FROM usuarios
WHERE correo LIKE '%@gmail.com';

-- Usuarios cuyo nombre tenga una 'e' en la segunda posición
SELECT nombre
FROM usuarios
WHERE nombre LIKE '_e%';

==============================================================
8. CONDICIONES CON NULL
==============================================================
Para verificar si un valor es nulo se usa IS NULL o IS NOT NULL.

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
9. COMBINAR VARIAS CONDICIONES
==============================================================
Puedes usar WHERE con AND, OR, NOT, IN, BETWEEN y LIKE
para crear filtros más precisos.

Ejemplo:
--------------------------------------------------------------
-- Usuarios activos entre 18 y 30 años, que sean de Colombia o México
SELECT nombre, edad, pais
FROM usuarios
WHERE estado = 'activo'
  AND edad BETWEEN 18 AND 30
  AND pais IN ('Colombia', 'México');

==============================================================
10. RESUMEN GENERAL
==============================================================
WHERE              -> Filtra registros según una condición
OPERADORES          -> =, <>, >, <, >=, <=
LÓGICOS             -> AND, OR, NOT
RANGOS              -> BETWEEN ... AND ...
CONJUNTOS           -> IN (...)
PATRONES            -> LIKE '%texto%'
VALORES NULOS       -> IS NULL, IS NOT NULL

==============================================================
*/

-- Filtra todos los datos de la tabla "users" con edad igual a 15
SELECT * FROM users WHERE age = 15;

-- Filtra todos los nombres de la tabla "users" con edad igual a 15
SELECT name FROM users WHERE age = 15;

-- Filtra todos los nombres distintos de la tabla "users" con edad igual a 15
SELECT DISTINCT name FROM users WHERE age = 15;

-- Filtra todas las edades distintas de la tabla "users" con edad diferente a 15
SELECT DISTINCT name, age FROM users WHERE NOT age = 15;