/*
==============================================================
SECCIÓN 2: COMANDO DISTINCT EN SQL
==============================================================

1. ¿Qué es DISTINCT?
------------------------------------------------
El modificador DISTINCT se utiliza junto con el comando SELECT
para eliminar filas duplicadas en los resultados de una consulta.

Cuando una tabla contiene valores repetidos en una columna,
DISTINCT devuelve únicamente una copia de cada valor distinto.

==============================================================
2. ESTRUCTURA BÁSICA
==============================================================
SELECT DISTINCT nombre_columna
FROM nombre_tabla;

Ejemplo:
------------------------------------------------
-- Obtener los países únicos registrados por los usuarios
SELECT DISTINCT pais
FROM usuarios;

En este caso, si existen usuarios de Colombia repetidos,
solo se mostrará "Colombia" una vez.

==============================================================
3. USAR DISTINCT CON VARIAS COLUMNAS
==============================================================
También se puede aplicar DISTINCT a más de una columna.
En ese caso, el resultado mostrará combinaciones únicas de los valores
de esas columnas.

Ejemplo:
------------------------------------------------
-- Mostrar combinaciones únicas de país y ciudad
SELECT DISTINCT pais, ciudad
FROM usuarios;

Esto eliminará filas que tengan el mismo país y la misma ciudad repetidos.

==============================================================
4. DIFERENCIA ENTRE DISTINCT Y GROUP BY
==============================================================
Ambos pueden producir resultados sin duplicados,
pero su propósito principal es diferente:

- DISTINCT elimina duplicados de forma directa.
- GROUP BY agrupa registros para aplicar funciones de agregación
  como COUNT, SUM, AVG, MAX, MIN, etc.

Ejemplo comparativo:
------------------------------------------------
-- Usando DISTINCT
SELECT DISTINCT pais
FROM usuarios;

-- Usando GROUP BY (mismo resultado visual)
SELECT pais
FROM usuarios
GROUP BY pais;

Nota: Si solo necesitas eliminar duplicados, usa DISTINCT.
Si vas a realizar cálculos por grupo, usa GROUP BY.

==============================================================
5. USAR DISTINCT CON FUNCIONES DE AGREGACIÓN
==============================================================
DISTINCT también puede utilizarse dentro de algunas funciones
para considerar únicamente valores únicos en los cálculos.

Ejemplo:
------------------------------------------------
-- Contar cuántos países diferentes hay en la tabla
SELECT COUNT(DISTINCT pais) AS cantidad_paises
FROM usuarios;

-- Contar cuántos correos distintos existen
SELECT COUNT(DISTINCT correo) AS correos_unicos
FROM usuarios;

==============================================================
6. LIMITACIONES Y RECOMENDACIONES
==============================================================
- DISTINCT se aplica al conjunto completo de columnas especificadas.
- Puede aumentar el tiempo de ejecución en tablas muy grandes,
  ya que el motor debe comparar todos los registros.
- Evita usar DISTINCT si los duplicados no son relevantes
  o si puedes resolverlo con un filtro o un GROUP BY más específico.

==============================================================
7. RESUMEN GENERAL
==============================================================
DISTINCT     -> Elimina filas duplicadas del resultado
USO BÁSICO   -> SELECT DISTINCT columna FROM tabla;
VARIAS COLUMNAS -> SELECT DISTINCT col1, col2 FROM tabla;
CON FUNCIONES   -> COUNT(DISTINCT columna)
NO SIRVE PARA   -> Agrupar ni ordenar (se puede combinar con ORDER BY)
==============================================================
*/

-- Obtiene todos los datos distintos entre sí de la tabla "users"
SELECT DISTINCT * FROM users;

-- Obtiene todos los valores distintos referentes al atributo edad de la tabla "users"
SELECT DISTINCT age FROM users;