/*
==============================================================
SECCIÓN 00: INTRODUCCIÓN A LAS BASES DE DATOS Y SQL
==============================================================

1. ¿QUÉ ES UNA BASE DE DATOS?
--------------------------------------------------------------
Una **base de datos** es un conjunto organizado de información
que se almacena y gestiona de forma que pueda ser consultada,
modificada y analizada fácilmente.

En lugar de usar archivos sueltos o documentos, una base de datos
permite mantener los datos centralizados, estructurados y seguros.

Ejemplos de uso:
- Registrar clientes, productos y ventas de una empresa.
- Almacenar usuarios y publicaciones de una red social.
- Guardar calificaciones y asistencia en una institución educativa.

==============================================================
2. TIPOS DE BASES DE DATOS
--------------------------------------------------------------
Existen varios tipos, pero las más comunes son:

1. **Relacionales (RDBMS)** → Organizan la información en tablas
   relacionadas entre sí mediante claves. Ej: MySQL, PostgreSQL, SQL Server.

2. **No Relacionales (NoSQL)** → Usan estructuras más flexibles
   como documentos, pares clave-valor o grafos. Ej: MongoDB, Redis.

En este repositorio nos centraremos en **bases de datos relacionales**.

==============================================================
3. ¿QUÉ ES UN SISTEMA GESTOR DE BASES DE DATOS (SGBD / DBMS)?
--------------------------------------------------------------
Un **Sistema Gestor de Base de Datos (DBMS)** es el software
que permite crear, administrar y manipular las bases de datos.

Ejemplos de DBMS:
- MySQL
- MariaDB
- PostgreSQL
- Oracle Database
- Microsoft SQL Server
- SQLite

Funciones principales:
• Crear bases de datos y tablas.
• Insertar, modificar o eliminar información.
• Asegurar la integridad de los datos.
• Permitir múltiples usuarios y conexiones.
• Optimizar consultas y rendimiento.

==============================================================
4. ¿QUÉ ES SQL?
--------------------------------------------------------------
**SQL (Structured Query Language)** es el lenguaje estándar
para interactuar con bases de datos relacionales.

Con SQL puedes:
1. Crear estructuras (bases, tablas, vistas, relaciones).
2. Insertar, actualizar o eliminar datos.
3. Consultar información.
4. Administrar permisos y usuarios.
5. Controlar transacciones y consistencia de datos.

==============================================================
5. PRINCIPALES CATEGORÍAS DE COMANDOS SQL
--------------------------------------------------------------

1. **DDL (Data Definition Language)** – Definición de datos  
   Se usa para crear, modificar o eliminar estructuras:
   • CREATE  
   • ALTER  
   • DROP  
   • TRUNCATE

2. **DML (Data Manipulation Language)** – Manipulación de datos  
   Se usa para insertar, actualizar o eliminar información:
   • INSERT  
   • UPDATE  
   • DELETE  

3. **DQL (Data Query Language)** – Consulta de datos  
   Se usa para buscar y filtrar información:
   • SELECT  

4. **DCL (Data Control Language)** – Control de permisos  
   Se usa para otorgar o revocar privilegios:
   • GRANT  
   • REVOKE  

5. **TCL (Transaction Control Language)** – Control de transacciones  
   Se usa para asegurar la consistencia:
   • COMMIT  
   • ROLLBACK  
   • SAVEPOINT  

==============================================================
6. ESTRUCTURA BÁSICA DE UNA BASE DE DATOS RELACIONAL
--------------------------------------------------------------

┌──────────────────────────────┐
│  SERVIDOR DE BASE DE DATOS   │
└──────────────┬───────────────┘
               │
┌──────────────┴───────────────┐
│         BASE DE DATOS         │
└──────────────┬───────────────┘
               │
┌──────────────┴───────────────┐
│            TABLAS             │
└──────────────┬───────────────┘
               │
┌──────────────┴───────────────┐
│     COLUMNAS Y REGISTROS      │
└──────────────────────────────┘

Cada tabla representa una entidad (clientes, productos, empleados),
y las **relaciones** entre tablas permiten vincular la información.

==============================================================
7. EJEMPLO DE UNA BASE DE DATOS SIMPLE
--------------------------------------------------------------

-- Crear una base de datos
CREATE DATABASE empresa;
USE empresa;

-- Crear una tabla
CREATE TABLE empleados (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    cargo VARCHAR(50),
    salario DECIMAL(10,2)
);

-- Insertar registros
INSERT INTO empleados (nombre, cargo, salario)
VALUES ('Laura Gómez', 'Analista', 2500.00),
       ('Carlos Ruiz', 'Desarrollador', 3200.00);

-- Consultar información
SELECT * FROM empleados;

Resultado:
+----+--------------+----------------+----------+
| id | nombre       | cargo          | salario  |
+----+--------------+----------------+----------+
|  1 | Laura Gómez  | Analista       | 2500.00  |
|  2 | Carlos Ruiz  | Desarrollador  | 3200.00  |
+----+--------------+----------------+----------+

==============================================================
8. ¿QUÉ ES UN ESQUEMA?
--------------------------------------------------------------
Un **esquema** es la estructura lógica que agrupa todos los objetos
(tablas, vistas, índices, triggers, procedimientos, etc.) dentro
de una base de datos.

En MySQL, cada base de datos actúa como un esquema.

Ejemplo:
--------------------------------------------------------------
CREATE SCHEMA tienda;
USE tienda;

CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(10,2)
);

==============================================================
9. VENTAJAS DE USAR SQL Y BASES DE DATOS RELACIONALES
--------------------------------------------------------------
1. Organización clara y estructurada de los datos.  
2. Integridad y coherencia garantizadas mediante claves y restricciones.  
3. Escalabilidad para manejar grandes volúmenes de información.  
4. Potente lenguaje de consulta (SELECT, JOIN, GROUP BY, etc.).  
5. Compatibilidad con múltiples plataformas.  
6. Seguridad mediante permisos y roles.  

==============================================================
10. CONCEPTO DE CONSULTA (QUERY)
--------------------------------------------------------------
Una **consulta** (query) es una instrucción SQL que pide
información a la base de datos.

Ejemplo:
--------------------------------------------------------------
SELECT nombre, salario
FROM empleados
WHERE salario > 3000
ORDER BY salario DESC;

==============================================================
11. CONCEPTO DE TRANSACCIÓN
--------------------------------------------------------------
Una **transacción** es un conjunto de operaciones SQL que se
ejecutan como una sola unidad lógica.  
Si alguna falla, se revierte todo para mantener la coherencia.

Ejemplo:
--------------------------------------------------------------
START TRANSACTION;
UPDATE cuentas SET saldo = saldo - 100 WHERE id = 1;
UPDATE cuentas SET saldo = saldo + 100 WHERE id = 2;
COMMIT;

==============================================================
12. BUENAS PRÁCTICAS AL TRABAJAR CON SQL
--------------------------------------------------------------
1. Usa nombres descriptivos para tablas y columnas.  
2. Siempre define claves primarias (PRIMARY KEY).  
3. Evita duplicidad mediante claves únicas o normalización.  
4. Usa comentarios (--) para documentar tus scripts.  
5. Haz respaldos frecuentes antes de modificaciones grandes.  
6. Prueba las consultas en entornos de prueba antes de producción.  

==============================================================
13. RESUMEN GENERAL
--------------------------------------------------------------
• SQL es el lenguaje estándar para administrar bases de datos relacionales.  
• Todo se organiza en bases → tablas → columnas → registros.  
• Existen diferentes tipos de comandos (DDL, DML, DQL, DCL, TCL).  
• Las bases relacionales usan claves y relaciones para mantener integridad.  
• El conocimiento de SQL te permite manipular y analizar datos con precisión.

==============================================================
*/
