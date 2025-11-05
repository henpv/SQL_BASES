/*
==============================================================
SECCIÓN 1: CREATE DATABASE EN SQL
==============================================================

1. ¿QUÉ ES CREATE DATABASE?
--------------------------------------------------------------
El comando **CREATE DATABASE** se utiliza para **crear una nueva base de datos**
en un sistema de gestión SQL (como MySQL, MariaDB, PostgreSQL, SQL Server, etc.).

Cada base de datos es un contenedor lógico donde se almacenan:
 - Tablas
 - Vistas
 - Procedimientos almacenados
 - Funciones
 - Índices
 - Usuarios y privilegios asociados

==============================================================
2. ESTRUCTURA BÁSICA DE CREATE DATABASE
--------------------------------------------------------------
CREATE DATABASE nombre_base_datos;

Ejemplo:
--------------------------------------------------------------
CREATE DATABASE empresa;

Explicación:
Crea una nueva base de datos llamada “empresa” en el servidor.

==============================================================
3. VERIFICAR BASES DE DATOS EXISTENTES
--------------------------------------------------------------
Puedes listar las bases de datos disponibles con:

SHOW DATABASES;

Ejemplo:
--------------------------------------------------------------
SHOW DATABASES;

Salida esperada (ejemplo):
+--------------------+
| Database           |
+--------------------+
| empresa            |
| information_schema |
| mysql              |
| performance_schema |
+--------------------+

==============================================================
4. CREAR UNA BASE DE DATOS CON CONDICIONAL
--------------------------------------------------------------
Para evitar errores al intentar crear una base de datos que ya existe,
usa la condición **IF NOT EXISTS**.

Ejemplo:
--------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS empresa;

Explicación:
Solo crea la base de datos si no existe previamente.

==============================================================
5. SELECCIONAR UNA BASE DE DATOS PARA USO
--------------------------------------------------------------
Una vez creada, debes seleccionarla antes de crear tablas u objetos.

Ejemplo:
--------------------------------------------------------------
USE empresa;

Explicación:
Indica al servidor que las siguientes operaciones se realizarán dentro
de la base de datos “empresa”.

==============================================================
6. DEFINIR CARACTERES Y COLLATION
--------------------------------------------------------------
Puedes especificar el conjunto de caracteres (CHARACTER SET) y
la colación (COLLATE) al crear la base de datos.

Ejemplo:
--------------------------------------------------------------
CREATE DATABASE empresa
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

Explicación:
 - utf8mb4: permite almacenar cualquier caracter Unicode (ideal para emojis o acentos).
 - utf8mb4_general_ci: define reglas de comparación insensibles a mayúsculas/minúsculas.

==============================================================
7. CONSULTAR INFORMACIÓN DETALLADA DE UNA BASE DE DATOS
--------------------------------------------------------------
Puedes usar el esquema del sistema para obtener más detalles.

Ejemplo:
--------------------------------------------------------------
SELECT SCHEMA_NAME, DEFAULT_CHARACTER_SET_NAME, DEFAULT_COLLATION_NAME
FROM information_schema.SCHEMATA
WHERE SCHEMA_NAME = 'empresa';

Explicación:
Muestra el conjunto de caracteres y colación utilizados en la base de datos.

==============================================================
8. RENOMBRAR UNA BASE DE DATOS (NO DIRECTAMENTE SOPORTADO)
--------------------------------------------------------------
MySQL **no permite renombrar una base de datos directamente**, pero puedes hacerlo de forma manual.

Pasos recomendados:
--------------------------------------------------------------
-- 1. Crear una nueva base de datos
CREATE DATABASE nueva_empresa;

-- 2. Exportar la base de datos anterior (por ejemplo, con mysqldump)
-- 3. Importar los datos a la nueva
-- 4. Eliminar la base de datos antigua (con precaución)
DROP DATABASE empresa;

==============================================================
9. ELIMINAR UNA BASE DE DATOS
--------------------------------------------------------------
Si ya no necesitas una base de datos, puedes eliminarla con **DROP DATABASE**.

Ejemplo:
--------------------------------------------------------------
DROP DATABASE empresa;

O, para hacerlo de forma segura:
--------------------------------------------------------------
DROP DATABASE IF EXISTS empresa;

⚠️ Precaución:
Esta acción elimina toda la base de datos y su contenido.
No puede deshacerse a menos que exista una copia de seguridad.

==============================================================
10. BUENAS PRÁCTICAS
--------------------------------------------------------------
1. Usa nombres descriptivos y en minúsculas para las bases de datos.
   Ejemplo: `sistema_ventas`, `gestion_rrhh`.
2. Siempre define el conjunto de caracteres como **utf8mb4**.
3. Evita usar espacios o caracteres especiales en el nombre.
4. Usa **IF NOT EXISTS** para evitar errores si ya existe.
5. Realiza copias de seguridad antes de eliminar bases de datos.
6. Usa privilegios adecuados para evitar modificaciones accidentales.
7. No trabajes en la base de datos "mysql" o "information_schema" directamente.
8. Documenta la configuración inicial (charset, collation, fecha de creación).

==============================================================
11. DIFERENCIA ENTRE DATABASE Y SCHEMA
--------------------------------------------------------------
En MySQL, **DATABASE** y **SCHEMA** son equivalentes.
Puedes usar cualquiera de las dos palabras clave.

Ejemplo:
--------------------------------------------------------------
CREATE SCHEMA empresa;
-- Es lo mismo que:
CREATE DATABASE empresa;

==============================================================
12. RESUMEN GENERAL
--------------------------------------------------------------
• CREATE DATABASE crea una nueva base de datos vacía.
• IF NOT EXISTS evita errores si ya existe.
• USE selecciona la base de datos para trabajar.
• Puedes definir CHARACTER SET y COLLATE.
• DROP DATABASE elimina completamente una base de datos.
• DATABASE y SCHEMA son equivalentes en MySQL.
• Siempre respalda tus datos antes de borrar o modificar bases.
==============================================================
*/

-- Crea una base de datos llamada "test"
CREATE DATABASE test;