/*
==============================================================
SECCIÓN 1: INSERT EN SQL
==============================================================

1. ¿QUÉ ES EL COMANDO INSERT?
--------------------------------------------------------------
El comando **INSERT** se utiliza para **agregar nuevos registros**
(filas) en una tabla existente dentro de una base de datos SQL.

Cada registro insertado debe coincidir con la estructura de la tabla:
 - En el número de columnas.
 - En el tipo de datos de cada columna.
 - En las restricciones definidas (como NOT NULL, UNIQUE, etc).

==============================================================
2. ESTRUCTURA BÁSICA DE INSERT
==============================================================
Existen dos formas principales de insertar datos:

A. Especificando las columnas explícitamente:
--------------------------------------------------------------
INSERT INTO nombre_tabla (columna1, columna2, columna3)
VALUES (valor1, valor2, valor3);

B. Insertando en todas las columnas (en orden exacto):
--------------------------------------------------------------
INSERT INTO nombre_tabla
VALUES (valor1, valor2, valor3);

⚠️ Recomendación:
Siempre es buena práctica **especificar los nombres de las columnas**.
Esto evita errores si la estructura de la tabla cambia en el futuro.

==============================================================
3. EJEMPLO PRÁCTICO
--------------------------------------------------------------
-- Crear la tabla:
CREATE TABLE empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    cargo VARCHAR(50),
    salario DECIMAL(10,2)
);

-- Insertar un registro:
INSERT INTO empleados (nombre, cargo, salario)
VALUES ('Laura Gómez', 'Ingeniera de Datos', 4500.00);

-- Insertar varios registros a la vez:
INSERT INTO empleados (nombre, cargo, salario)
VALUES 
('Andrés Pérez', 'Analista', 3200.00),
('María López', 'Gerente', 6000.00),
('Carlos Ruiz', 'Técnico', 2800.00);

==============================================================
4. INSERTAR SOLO EN ALGUNAS COLUMNAS
--------------------------------------------------------------
Puedes omitir columnas que acepten valores NULL o tengan un valor por defecto.

Ejemplo:
--------------------------------------------------------------
INSERT INTO empleados (nombre, cargo)
VALUES ('Ana Torres', 'Asistente');

Explicación:
La columna “salario” no se incluye, por lo tanto:
 - Si tiene un valor por defecto, se asigna automáticamente.
 - Si acepta NULL, se guarda como NULL.
 - Si es obligatoria (NOT NULL), el comando fallará.

==============================================================
5. INSERTAR DESDE OTRA TABLA
--------------------------------------------------------------
También puedes insertar datos en una tabla a partir de otra.

Ejemplo:
--------------------------------------------------------------
INSERT INTO empleados_backup (nombre, cargo, salario)
SELECT nombre, cargo, salario
FROM empleados
WHERE salario > 4000;

Explicación:
Copia todos los empleados cuyo salario es mayor a 4000 desde la tabla
“empleados” hacia “empleados_backup”.

==============================================================
6. INSERTAR CON VALORES POR DEFECTO
--------------------------------------------------------------
Puedes usar la palabra clave **DEFAULT** para asignar el valor por defecto
definido en la estructura de la tabla.

Ejemplo:
--------------------------------------------------------------
INSERT INTO empleados (nombre, cargo, salario)
VALUES ('Julio Rojas', 'Practicante', DEFAULT);

==============================================================
7. INSERTAR MÚLTIPLES FILAS EN UNA SOLA INSTRUCCIÓN
--------------------------------------------------------------
Es posible agregar varios registros en un solo INSERT para mayor eficiencia.

Ejemplo:
--------------------------------------------------------------
INSERT INTO empleados (nombre, cargo, salario)
VALUES 
('Laura Gómez', 'Ingeniera de Datos', 4500.00),
('Pedro Salazar', 'Diseñador', 3700.00),
('Marta Díaz', 'Administradora', 5200.00);

Ventajas:
 - Menos llamadas a la base de datos.
 - Mejora el rendimiento en grandes cargas de datos.

==============================================================
8. USO DE INSERT CON FUNCIONES
--------------------------------------------------------------
Puedes usar funciones dentro de los valores que insertas.

Ejemplo:
--------------------------------------------------------------
INSERT INTO usuarios (nombre, fecha_creacion)
VALUES ('Henry Parra', NOW());

Explicación:
 - NOW() inserta la fecha y hora actual del sistema.
 - También puedes usar funciones como UUID(), CONCAT(), o RAND().

==============================================================
9. INSERT IGNORE (MySQL)
--------------------------------------------------------------
En MySQL, la palabra clave **IGNORE** evita errores si ocurre un conflicto,
por ejemplo, cuando intentas insertar un valor duplicado en una columna UNIQUE.

Ejemplo:
--------------------------------------------------------------
INSERT IGNORE INTO usuarios (id, nombre)
VALUES (1, 'Carlos Pérez');

Si el registro con ID=1 ya existe, MySQL ignora el INSERT en lugar de fallar.

==============================================================
10. INSERT ... ON DUPLICATE KEY UPDATE (MySQL)
--------------------------------------------------------------
Permite insertar un registro, y si ya existe una clave duplicada,
actualiza los datos existentes.

Ejemplo:
--------------------------------------------------------------
INSERT INTO productos (id, nombre, precio)
VALUES (1, 'Teclado Mecánico', 120.00)
ON DUPLICATE KEY UPDATE
precio = VALUES(precio);

Explicación:
 - Si el producto con ID=1 no existe, lo inserta.
 - Si ya existe, actualiza el campo “precio”.

==============================================================
11. BUENAS PRÁCTICAS
--------------------------------------------------------------
1. Especifica siempre las columnas en el INSERT.
2. Asegúrate de que los tipos de datos coincidan con los de la tabla.
3. Usa comillas simples (' ') para valores de texto.
4. Usa **NOW()** o funciones de fecha para registros de auditoría.
5. Usa transacciones (BEGIN/COMMIT/ROLLBACK) en cargas críticas.
6. Evita los INSERT sin columnas explícitas en proyectos grandes.
7. Controla los errores de duplicidad con **IGNORE** o **ON DUPLICATE KEY**.
8. Inserta varias filas en una sola sentencia para optimizar rendimiento.

==============================================================
12. RESUMEN GENERAL
--------------------------------------------------------------
• INSERT agrega nuevos registros a una tabla.
• Puede insertar una o varias filas a la vez.
• Puedes insertar valores específicos, por defecto o generados.
• Admite inserciones desde otras tablas (INSERT ... SELECT).
• En MySQL, puedes controlar duplicados con IGNORE o UPDATE.
• Siempre especifica las columnas para mayor seguridad.
• Úsalo junto a transacciones cuando manipules muchos datos.
==============================================================
*/

-- Inserta un registro con identificador, nombre y apellido en la tabla "users"
INSERT INTO users (user_id, name, surname) VALUES (8, 'María', 'López');

-- Inserta un registro con nombre y apellido en la tabla "users"
INSERT INTO users (name, surname) VALUES ('Paco', 'Pérez');

-- Inserta un registro con identificador no correlativo, nombre y apellido en la tabla "users"
INSERT INTO users (user_id, name, surname) VALUES (11, 'El', 'Merma');