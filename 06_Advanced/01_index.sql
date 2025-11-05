/*
==============================================================
SECCIÓN 1: ÍNDICES (INDEXES) EN SQL
==============================================================

1. ¿QUÉ ES UN ÍNDICE EN SQL?
--------------------------------------------------------------
Un **índice** es una estructura especial que mejora la velocidad
de las consultas (SELECT), permitiendo al motor de base de datos
encontrar los datos más rápidamente, sin tener que recorrer
toda la tabla.

En términos simples:
Un índice funciona como el índice de un libro:
en lugar de leer todas las páginas, va directo a donde está el dato.

==============================================================
2. ¿CUÁNDO USAR ÍNDICES?
--------------------------------------------------------------
• Cuando haces muchas consultas con condiciones WHERE.
• Cuando usas columnas en ORDER BY o GROUP BY.
• Cuando realizas muchas búsquedas por columnas específicas.
• Cuando hay relaciones entre tablas con FOREIGN KEYS.

⚠️ Nota:
Los índices aceleran las consultas **SELECT**, pero **ralentizan** 
las operaciones **INSERT, UPDATE y DELETE**, porque la base de datos 
debe mantener actualizados los índices.

==============================================================
3. CREACIÓN BÁSICA DE UN ÍNDICE
--------------------------------------------------------------
Sintaxis general:
--------------------------------------------------------------
CREATE INDEX nombre_indice
ON nombre_tabla (columna1, columna2, ...);

Ejemplo:
--------------------------------------------------------------
CREATE INDEX idx_nombre
ON empleados (nombre);

Explicación:
 - Crea un índice llamado "idx_nombre" sobre la columna "nombre"
   de la tabla "empleados".

==============================================================
4. CREAR ÍNDICE ÚNICO
--------------------------------------------------------------
Los índices únicos garantizan que los valores en una columna
no se repitan (similares a la restricción UNIQUE).

Ejemplo:
--------------------------------------------------------------
CREATE UNIQUE INDEX idx_email_unico
ON empleados (email);

Explicación:
 - Evita que dos empleados tengan el mismo correo electrónico.

==============================================================
5. CREAR ÍNDICE COMPUESTO (VARIAS COLUMNAS)
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
CREATE INDEX idx_nombre_ciudad
ON clientes (nombre, ciudad);

Explicación:
 - Crea un índice combinado sobre “nombre” y “ciudad”.
 - Es útil cuando se realizan consultas con ambas columnas
   en el WHERE o en el ORDER BY.

⚠️ Importante:
El orden de las columnas en un índice compuesto afecta el rendimiento.
Por ejemplo, el índice (nombre, ciudad) se usará si consultas por nombre,
pero no si solo consultas por ciudad.

==============================================================
6. VER ÍNDICES EXISTENTES EN UNA TABLA
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
SHOW INDEX FROM empleados;

Explicación:
 - Muestra todos los índices asociados a la tabla “empleados”.

==============================================================
7. ELIMINAR UN ÍNDICE
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
DROP INDEX idx_nombre ON empleados;

Explicación:
 - Elimina el índice “idx_nombre” de la tabla “empleados”.

==============================================================
8. ÍNDICES AUTOMÁTICOS CON PRIMARY KEY Y UNIQUE
--------------------------------------------------------------
Cuando se declara una **PRIMARY KEY** o una **UNIQUE constraint**,
MySQL crea automáticamente un índice.

Ejemplo:
--------------------------------------------------------------
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    nombre VARCHAR(100)
);

Explicación:
 - PRIMARY KEY crea un índice para búsqueda rápida por “id”.
 - UNIQUE crea otro índice para garantizar emails únicos.

==============================================================
9. ÍNDICES EN CLAVES FORÁNEAS (FOREIGN KEYS)
--------------------------------------------------------------
MySQL crea automáticamente un índice en la columna de clave foránea
para optimizar las consultas de relación.

Ejemplo:
--------------------------------------------------------------
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

Explicación:
 - MySQL crea un índice sobre “cliente_id” para agilizar
   las uniones (JOIN) entre pedidos y clientes.

==============================================================
10. ÍNDICES Y ORDENAMIENTO (ORDER BY)
--------------------------------------------------------------
Los índices también mejoran la velocidad en consultas
con cláusulas ORDER BY.

Ejemplo:
--------------------------------------------------------------
SELECT * FROM empleados
ORDER BY nombre;

Si “nombre” tiene un índice, la base de datos podrá ordenar
los resultados más rápido.

==============================================================
11. TIPOS DE ÍNDICES EN MYSQL
--------------------------------------------------------------
1. **INDEX (NORMAL):**
   - Mejora búsquedas y ordenamientos.
   - Permite valores duplicados.

2. **UNIQUE INDEX:**
   - Igual que INDEX, pero no permite valores repetidos.

3. **PRIMARY KEY:**
   - Índice único especial, identifica cada fila de la tabla.
   - Solo puede haber uno por tabla.

4. **FULLTEXT INDEX:**
   - Permite búsquedas de texto avanzado (palabras dentro de texto).
   - Se usa con columnas tipo CHAR, VARCHAR o TEXT.
   - Ideal para motores de búsqueda o blogs.

   Ejemplo:
   --------------------------------------------------------------
   CREATE FULLTEXT INDEX idx_descripcion
   ON productos (descripcion);

5. **SPATIAL INDEX:**
   - Índice especial para datos geométricos (coordenadas, polígonos, etc.).
   - Se usa con tipos espaciales (POINT, GEOMETRY).

==============================================================
12. CREAR ÍNDICE AL MISMO TIEMPO QUE LA TABLA
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
CREATE TABLE clientes (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    ciudad VARCHAR(50),
    email VARCHAR(100),
    PRIMARY KEY (id),
    UNIQUE (email),
    INDEX idx_nombre_ciudad (nombre, ciudad)
);

Explicación:
 - Se crean varios índices desde el inicio, junto con la tabla.

==============================================================
13. BUENAS PRÁCTICAS
--------------------------------------------------------------
1. No indexes todas las columnas; usa índices solo donde se consultan con frecuencia.
2. Usa nombres de índice descriptivos (ej. idx_columna1_columna2).
3. Evita crear demasiados índices, ya que pueden ralentizar las escrituras.
4. Usa EXPLAIN antes de consultas grandes para verificar si los índices se usan.
5. Combina índices en columnas que suelen consultarse juntas.
6. Evita índices innecesarios en columnas pequeñas o de baja cardinalidad (ej. valores SÍ/NO).
7. Recuerda que las claves PRIMARY y UNIQUE ya generan índices automáticamente.
8. Usa FULLTEXT para búsquedas de texto, no para números o claves.

==============================================================
14. RESUMEN GENERAL
--------------------------------------------------------------
• Los índices mejoran la velocidad de búsqueda.  
• Los índices pueden ralentizar las operaciones de escritura.  
• PRIMARY KEY y UNIQUE crean índices automáticos.  
• Se pueden crear índices simples o compuestos.  
• FULLTEXT permite búsquedas en texto libre.  
• SPATIAL se usa para datos geométricos.  
• Usa SHOW INDEX FROM tabla; para revisar los existentes.  
• Usa DROP INDEX para eliminarlos.  
• Usa EXPLAIN para analizar el impacto en rendimiento.
==============================================================
*/

-- Crea un índice llamado "idx_name" en la tabla "users" asociado al campo "name"
CREATE INDEX idx_name ON users(name);

-- Crea un índice único llamado "idx_name" en la tabla "users" asociado al campo "name"
CREATE UNIQUE INDEX idx_name ON users(name);

-- Crea un índice llamado "idx_name_surname" en la tabla "users" asociado a los campos "name" y "surname"
CREATE UNIQUE INDEX idx_name_surname ON users(name, surname);

-- Elimina el índice llamado "idx_name"
DROP INDEX idx_name ON users;