/*
==============================================================
SECCIÓN 4: RELATIONSHIPS (RELACIONES ENTRE TABLAS)
==============================================================

1. ¿QUÉ SON LAS RELACIONES EN SQL?
--------------------------------------------------------------
Las relaciones (relationships) en SQL definen cómo una tabla 
se conecta con otra mediante campos comunes (claves).

Son la base de las bases de datos relacionales, porque permiten:
 - Evitar duplicación de datos.
 - Mantener la coherencia entre registros.
 - Facilitar consultas complejas mediante JOINs.

Cada relación se define con **claves primarias (PRIMARY KEY)** 
y **claves foráneas (FOREIGN KEY)**.

==============================================================
2. TIPOS DE RELACIONES
--------------------------------------------------------------
Existen tres tipos principales de relaciones:

1) Uno a uno (1:1)
2) Uno a muchos (1:N)
3) Muchos a muchos (N:M)

==============================================================
3. RELACIÓN UNO A UNO (1:1)
--------------------------------------------------------------
Cada registro de una tabla está relacionado con un solo registro
en otra tabla.

Ejemplo:
--------------------------------------------------------------
CREATE TABLE personas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    identificacion VARCHAR(20)
);

CREATE TABLE pasaportes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    numero_pasaporte VARCHAR(20),
    persona_id INT UNIQUE,
    FOREIGN KEY (persona_id) REFERENCES personas(id)
);

Explicación:
 - Una persona tiene un solo pasaporte.
 - Un pasaporte pertenece a una sola persona.
 - La restricción UNIQUE en persona_id asegura la relación 1:1.

==============================================================
4. RELACIÓN UNO A MUCHOS (1:N)
--------------------------------------------------------------
El tipo más común de relación en bases de datos.

Ejemplo:
--------------------------------------------------------------
CREATE TABLE departamentos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50)
);

CREATE TABLE empleados (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    departamento_id INT,
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
);

Explicación:
 - Un departamento puede tener muchos empleados.
 - Cada empleado pertenece solo a un departamento.
 - Esto forma una relación 1:N.

==============================================================
5. RELACIÓN MUCHOS A MUCHOS (N:M)
--------------------------------------------------------------
Para representar este tipo de relación, se necesita una tabla intermedia
que contenga las claves foráneas de ambas tablas principales.

Ejemplo:
--------------------------------------------------------------
CREATE TABLE estudiantes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100)
);

CREATE TABLE cursos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100)
);

CREATE TABLE estudiantes_cursos (
    estudiante_id INT,
    curso_id INT,
    PRIMARY KEY (estudiante_id, curso_id),
    FOREIGN KEY (estudiante_id) REFERENCES estudiantes(id),
    FOREIGN KEY (curso_id) REFERENCES cursos(id)
);

Explicación:
 - Un estudiante puede inscribirse en varios cursos.
 - Un curso puede tener varios estudiantes.
 - La tabla intermedia “estudiantes_cursos” representa la relación N:M.

==============================================================
6. RELACIÓN CON AUTO BORRADO Y ACTUALIZACIÓN EN CASCADA
--------------------------------------------------------------
Las relaciones pueden configurarse para mantener la coherencia
cuando los datos se eliminan o actualizan.

Ejemplo:
--------------------------------------------------------------
CREATE TABLE clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100)
);

CREATE TABLE pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(150),
    cliente_id INT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

Explicación:
 - Si se elimina un cliente, también se eliminan sus pedidos (ON DELETE CASCADE).
 - Si cambia el ID del cliente, el cambio se replica en pedidos (ON UPDATE CASCADE).

==============================================================
7. RELACIÓN SIN AUTO BORRADO (PROTEGIDA)
--------------------------------------------------------------
Si no deseas que los registros dependientes se borren automáticamente:

Ejemplo:
--------------------------------------------------------------
CREATE TABLE pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(150),
    cliente_id INT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
    ON DELETE RESTRICT
);

Explicación:
 - Si intentas borrar un cliente con pedidos asociados, SQL impedirá el borrado.
 - Esto protege la integridad de los datos dependientes.

==============================================================
8. RELACIONES Y NORMALIZACIÓN
--------------------------------------------------------------
Las relaciones forman parte del proceso de normalización de bases de datos,
que busca eliminar redundancias y mejorar la coherencia.

Las tres primeras formas normales (NF) son:

1) Primera Forma Normal (1NF)
   - No se permiten valores repetidos o múltiples en una columna.

2) Segunda Forma Normal (2NF)
   - Cada columna depende completamente de la clave primaria.

3) Tercera Forma Normal (3NF)
   - Ninguna columna depende de otra columna que no sea la clave primaria.

==============================================================
9. VISUALIZAR RELACIONES EN UNA BASE DE DATOS
--------------------------------------------------------------
Puedes usar comandos o diagramas:

1) En MySQL Workbench:
   - Menú: Database → Reverse Engineer → EER Diagram.
   - Muestra todas las relaciones visualmente.

2) Desde consola:
   SHOW CREATE TABLE nombre_tabla;

   Ejemplo:
   SHOW CREATE TABLE empleados;

   Muestra las claves foráneas y sus referencias.

==============================================================
10. BUENAS PRÁCTICAS EN RELACIONES
--------------------------------------------------------------
1. Usa nombres descriptivos para las claves foráneas:
   fk_empleados_departamentos, fk_pedidos_clientes, etc.

2. Mantén consistencia en los tipos de datos entre claves:
   Si la PRIMARY KEY es INT, la FOREIGN KEY también debe ser INT.

3. Siempre indexa las columnas usadas en relaciones
   para mejorar el rendimiento de las consultas JOIN.

4. Documenta las relaciones en tu esquema.

5. Usa CASCADE solo cuando estés seguro de que la eliminación
   o actualización automática no afectará negativamente los datos.

==============================================================
11. RESUMEN GENERAL
--------------------------------------------------------------
• Las relaciones enlazan tablas mediante PRIMARY KEY y FOREIGN KEY.
• Existen tres tipos: 1:1, 1:N y N:M.
• Las relaciones pueden usar ON DELETE y ON UPDATE para definir comportamientos.
• Las claves deben tener tipos de datos compatibles.
• La normalización ayuda a diseñar estructuras más limpias y coherentes.
• Las relaciones son la base para consultas JOIN.
==============================================================
*/

-- El campo user_id de la tabla "dni" es clave foránea de la clave primaria user_id de la tabla "users"
-- (Un usuario sólo puede tener un DNI. Un DNI sólo puede estar asociado a un usuario)
CREATE TABLE dni(
	dni_id int AUTO_INCREMENT PRIMARY KEY,
    dni_number int NOT NULL,
    user_id int,
    UNIQUE(dni_id),
    FOREIGN KEY(user_id) REFERENCES users(user_id)
);


CREATE TABLE companies(
	company_id int AUTO_INCREMENT PRIMARY KEY,
    name varchar(100) NOT NULL
);
ALTER TABLE users
ADD company_id int;

-- El campo company_id de la tabla "users" es clave foránea de la clave primaria company_id de la tabla "companies"
-- (Un empleado (usuario) sólo puede tener una empresa, pero una empresa puede tener muchos empleados (usuarios))
ALTER TABLE users 
ADD CONSTRAINT fk_companies
FOREIGN KEY(company_id) REFERENCES companies(company_id);


CREATE TABLE languages(
	language_id int AUTO_INCREMENT PRIMARY KEY,
    name varchar(100) NOT NULL
);

-- El campo user_id y language_id de la tabla intermedia "users_languages" es clave foránea de las
-- claves primarias user_id de la tabla "users" y de language_id de la tabla "languages"
-- Un usuario puede conoces muchos lenguajes. Un lenguaje puede ser conocido por muchos usuarios.
CREATE TABLE users_languages(
	users_language_id int AUTO_INCREMENT PRIMARY KEY,
    user_id int,
    language_id int,
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(language_id) REFERENCES languages(language_id),
    UNIQUE (user_id, language_id)
);

/*
Relación de Auto-Referencia
Relación que indica que un un registro en la tabla A puede 
relacionarse con otro registro de la tabla A.
*/

/*
INSERT y UPDATE para trabajar con JOIN
*/
-- "dni" (Relación 1:1)
INSERT INTO dni (dni_number, user_id) VALUES (11111111, 1);
INSERT INTO dni (dni_number, user_id) VALUES (22222222, 2);
INSERT INTO dni (dni_number, user_id) VALUES (33333333, 3);
INSERT INTO dni (dni_number) VALUES (44444444);


-- "companies" y "users"  (Relación 1:N)
INSERT INTO companies (name) VALUES ('MoureDev');
INSERT INTO companies (name) VALUES ('Apple');
INSERT INTO companies (name) VALUES ('Google');

UPDATE users SET company_id = 1 WHERE user_id = 1;
UPDATE users SET company_id = 2 WHERE user_id = 3;
UPDATE users SET company_id = 3 WHERE user_id = 4;
UPDATE users SET company_id = 1 WHERE user_id = 7;

-- "languages" y "users_languages"  (Relación N:M)
INSERT INTO languages (name) VALUES ('Swift');
INSERT INTO languages (name) VALUES ('Kotlin');
INSERT INTO languages (name) VALUES ('JavaScript');
INSERT INTO languages (name) VALUES ('Java');
INSERT INTO languages (name) VALUES ('Python');
INSERT INTO languages (name) VALUES ('C#');
INSERT INTO languages (name) VALUES ('COBOL');

INSERT INTO users_languages (user_id, language_id) VALUES (1, 1);
INSERT INTO users_languages (user_id, language_id) VALUES (1, 2);
INSERT INTO users_languages (user_id, language_id) VALUES (1, 5);
INSERT INTO users_languages (user_id, language_id) VALUES (2, 3);
INSERT INTO users_languages (user_id, language_id) VALUES (2, 5);