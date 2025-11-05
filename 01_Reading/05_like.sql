/*
==============================================================
SECCIÓN 5: OPERADOR LIKE EN SQL
==============================================================

1. ¿Qué es LIKE?
--------------------------------------------------------------
El operador LIKE se utiliza en SQL para realizar búsquedas de texto
basadas en patrones dentro de una columna.

Permite encontrar coincidencias parciales o aproximadas
utilizando caracteres comodín.

==============================================================
2. ESTRUCTURA BÁSICA
==============================================================
SELECT columnas
FROM tabla
WHERE columna LIKE 'patrón';

Ejemplo:
--------------------------------------------------------------
-- Buscar usuarios cuyo nombre empiece por la letra 'A'
SELECT nombre
FROM usuarios
WHERE nombre LIKE 'A%';

==============================================================
3. COMODINES UTILIZADOS EN LIKE
==============================================================
LIKE usa dos comodines principales:

1) %  -> Representa cualquier cantidad de caracteres (incluso cero)
2) _  -> Representa exactamente un solo carácter

Ejemplos:
--------------------------------------------------------------
-- Nombres que comienzan con "J"
SELECT nombre FROM usuarios WHERE nombre LIKE 'J%';

-- Nombres que terminan en "n"
SELECT nombre FROM usuarios WHERE nombre LIKE '%n';

-- Nombres que contienen la letra "e" en cualquier posición
SELECT nombre FROM usuarios WHERE nombre LIKE '%e%';

-- Nombres con una "a" como segundo carácter
SELECT nombre FROM usuarios WHERE nombre LIKE '_a%';

==============================================================
4. DIFERENCIA ENTRE % Y _
==============================================================
- El símbolo % es flexible: puede representar cualquier número de caracteres.
- El símbolo _ es exacto: representa solo uno.

Ejemplos:
--------------------------------------------------------------
-- %e% encuentra “Javier”, “Sergio”, “Pedro”
-- _e% encuentra “Beto”, “Cesar”, “Pepe”, pero no “Sergio”

==============================================================
5. USAR LIKE CON MÚLTIPLES CONDICIONES
==============================================================
Puedes combinar LIKE con operadores lógicos como AND, OR y NOT.

Ejemplos:
--------------------------------------------------------------
-- Usuarios cuyo nombre empieza con “A” o “J”
SELECT nombre
FROM usuarios
WHERE nombre LIKE 'A%' OR nombre LIKE 'J%';

-- Usuarios cuyo correo no contenga “gmail”
SELECT nombre, correo
FROM usuarios
WHERE correo NOT LIKE '%gmail%';

==============================================================
6. LIKE ES INSENSIBLE A MAYÚSCULAS EN MYSQL
==============================================================
En la mayoría de configuraciones de MySQL (con colaciones por defecto),
LIKE no distingue entre mayúsculas y minúsculas.

Ejemplo:
--------------------------------------------------------------
-- Ambas consultas devuelven los mismos resultados
SELECT nombre FROM usuarios WHERE nombre LIKE 'ana%';
SELECT nombre FROM usuarios WHERE nombre LIKE 'ANA%';

Si necesitas una búsqueda sensible a mayúsculas,
puedes usar una colación diferente:
--------------------------------------------------------------
SELECT nombre
FROM usuarios
WHERE nombre LIKE BINARY 'Ana%';

==============================================================
7. COMBINAR LIKE CON ORDER BY Y LIMIT
==============================================================
Puedes usar LIKE junto con otras cláusulas para búsquedas específicas.

Ejemplo:
--------------------------------------------------------------
-- Buscar los 5 primeros usuarios cuyo nombre contenga “mar”
SELECT nombre, correo
FROM usuarios
WHERE nombre LIKE '%mar%'
ORDER BY nombre ASC
LIMIT 5;

==============================================================
8. USAR LIKE EN OTRAS FUNCIONES
==============================================================
LIKE puede combinarse con funciones de texto
para búsquedas más flexibles.

Ejemplo:
--------------------------------------------------------------
-- Convertir a minúsculas antes de comparar
SELECT nombre
FROM usuarios
WHERE LOWER(nombre) LIKE '%juan%';

-- Buscar correos que terminen en “.edu”
SELECT correo
FROM usuarios
WHERE correo LIKE '%.edu';

==============================================================
9. LIMITACIONES DE LIKE
==============================================================
1) LIKE no funciona bien con datos muy grandes (búsquedas lentas).
2) No usa índices eficientemente cuando el patrón comienza con “%”.
3) Para búsquedas más avanzadas o rápidas, se recomienda usar
   FULLTEXT SEARCH o expresiones regulares (REGEXP).

==============================================================
10. RESUMEN GENERAL
==============================================================
LIKE            -> Busca texto por patrón
%               -> Cualquier cantidad de caracteres
_               -> Un solo carácter
NOT LIKE        -> Excluye coincidencias
SENSIBILIDAD    -> Generalmente no distingue mayúsculas/minúsculas
BUENA PRÁCTICA  -> Evitar patrones que empiecen con “%” en tablas grandes

==============================================================
*/


-- Obtiene todos datos de la tabla "users" que contienen un email con el texto "gmail.com" en su parte final
SELECT * FROM users WHERE email LIKE '%gmail.com';

-- Obtiene todos datos de la tabla "users" que contienen un email con el texto "sara" en su parte inicial
SELECT * FROM users WHERE email LIKE 'sara%';

-- Obtiene todos datos de la tabla "users" que contienen un email una arroba
SELECT * FROM users WHERE email LIKE '%@%';