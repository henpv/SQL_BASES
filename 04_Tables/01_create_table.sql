/*
==============================================================
SECCIÓN 1: CREATE TABLE EN SQL
==============================================================

1. ¿QUÉ ES CREATE TABLE?
--------------------------------------------------------------
El comando **CREATE TABLE** se utiliza para **crear una nueva tabla** dentro
de una base de datos.  
Una tabla almacena los datos en filas (registros) y columnas (campos),
cada una con un tipo de dato específico (por ejemplo: INT, VARCHAR, DATE, etc.).

Estructura básica:
--------------------------------------------------------------
CREATE TABLE nombre_tabla (
    nombre_columna tipo_dato
);

Ejemplo:
--------------------------------------------------------------
CREATE TABLE empleados (
    id INT,
    nombre VARCHAR(100),
    salario DECIMAL(10,2)
);

==============================================================
2. CONCEPTOS CLAVE
--------------------------------------------------------------
- **Columna:** Es un campo que almacena un tipo de dato específico.
- **Fila o registro:** Es una entrada o conjunto de valores dentro de la tabla.
- **Clave primaria (PRIMARY KEY):** Identifica de forma única cada registro.
- **Restricciones (CONSTRAINTS):** Reglas que aseguran la integridad de los datos.

==============================================================
3. RESTRICCIONES (CONSTRAINTS)
--------------------------------------------------------------
Las restricciones controlan cómo se almacenan los datos en la tabla
y aseguran que cumplan ciertas reglas o condiciones.

Principales restricciones:
--------------------------------------------------------------
1. NULL / NOT NULL
2. UNIQUE
3. PRIMARY KEY
4. FOREIGN KEY
5. CHECK
6. DEFAULT
7. AUTO_INCREMENT

==============================================================
4. NULL y NOT NULL
--------------------------------------------------------------
- **NULL:** Permite que una columna no tenga valor (dato desconocido o vacío).
- **NOT NULL:** Obliga a que la columna siempre tenga un valor.

Ejemplo:
--------------------------------------------------------------
CREATE TABLE clientes (
    id INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NULL
);

Explicación:
- “id” y “nombre” deben tener siempre un valor.
- “telefono” puede quedar vacío (NULL).

==============================================================
5. UNIQUE
--------------------------------------------------------------
Garantiza que los valores en una columna sean únicos (sin duplicados).

Ejemplo:
--------------------------------------------------------------
CREATE TABLE usuarios (
    id INT PRIMARY KEY,
    correo VARCHAR(100) UNIQUE
);

Explicación:
No pueden existir dos usuarios con el mismo correo electrónico.

==============================================================
6. PRIMARY KEY
--------------------------------------------------------------
Define la columna (o conjunto de columnas) que **identifica de manera única**
cada registro de la tabla.

Ejemplo:
--------------------------------------------------------------
CREATE TABLE empleados (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    cargo VARCHAR(50)
);

Explicación:
- La columna “id” es la clave primaria.
- No puede repetirse y no puede ser NULL.

También puedes definirla de forma separada:
--------------------------------------------------------------
CREATE TABLE productos (
    id INT,
    nombre VARCHAR(100),
    PRIMARY KEY (id)
);

==============================================================
7. FOREIGN KEY
--------------------------------------------------------------
Crea una relación entre dos tablas, asegurando que el valor en una columna
corresponda a un valor existente en otra tabla (integridad referencial).

Ejemplo:
--------------------------------------------------------------
CREATE TABLE departamentos (
    id INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE empleados (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    departamento_id INT,
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
);

Explicación:
- “departamento_id” debe existir previamente en la tabla “departamentos”.

Puedes definir acciones adicionales:
--------------------------------------------------------------
FOREIGN KEY (departamento_id)
REFERENCES departamentos(id)
ON DELETE CASCADE
ON UPDATE CASCADE;

Significado:
- **ON DELETE CASCADE:** si se elimina un departamento, se eliminan sus empleados asociados.
- **ON UPDATE CASCADE:** si cambia el ID del departamento, se actualiza automáticamente en empleados.

==============================================================
8. CHECK
--------------------------------------------------------------
Permite establecer una condición que los datos deben cumplir
para poder ser insertados o actualizados.

Ejemplo:
--------------------------------------------------------------
CREATE TABLE productos (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(10,2) CHECK (precio > 0)
);

Explicación:
El precio debe ser mayor que 0.  
Si intentas insertar un valor negativo o 0, el sistema lo rechazará.

==============================================================
9. DEFAULT
--------------------------------------------------------------
Asigna un valor por defecto cuando no se especifica ninguno.

Ejemplo:
--------------------------------------------------------------
CREATE TABLE pedidos (
    id INT PRIMARY KEY,
    fecha DATE DEFAULT (CURRENT_DATE),
    estado VARCHAR(20) DEFAULT 'pendiente'
);

Explicación:
- Si no se indica fecha, se usa la fecha actual.
- Si no se indica estado, se coloca “pendiente”.

==============================================================
10. AUTO_INCREMENT
--------------------------------------------------------------
Genera automáticamente un valor numérico secuencial para cada nuevo registro.

Ejemplo:
--------------------------------------------------------------
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100)
);

Explicación:
Cada vez que insertes un nuevo cliente, “id” aumentará automáticamente en 1.

Ejemplo de inserción:
--------------------------------------------------------------
INSERT INTO clientes (nombre, correo) VALUES ('Juan Pérez', 'juan@correo.com');
INSERT INTO clientes (nombre, correo) VALUES ('Ana Gómez', 'ana@correo.com');

Resultado:
--------------------------------------------------------------
| id | nombre     | correo           |
|----|-------------|------------------|
| 1  | Juan Pérez  | juan@correo.com  |
| 2  | Ana Gómez   | ana@correo.com   |

==============================================================
11. COMBINAR VARIAS CONSTRAINTS
--------------------------------------------------------------
Puedes usar varias restricciones en una misma tabla:

Ejemplo:
--------------------------------------------------------------
CREATE TABLE empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE,
    edad INT CHECK (edad >= 18),
    salario DECIMAL(10,2) DEFAULT 1000.00,
    departamento_id INT,
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
);

==============================================================
12. RENOMBRAR O ELIMINAR TABLAS
--------------------------------------------------------------
Renombrar una tabla:
--------------------------------------------------------------
RENAME TABLE empleados TO trabajadores;

Eliminar una tabla:
--------------------------------------------------------------
DROP TABLE IF EXISTS empleados;

==============================================================
13. VER ESTRUCTURA DE UNA TABLA
--------------------------------------------------------------
Para consultar cómo está definida una tabla:

--------------------------------------------------------------
DESCRIBE empleados;
-- o
SHOW CREATE TABLE empleados;

==============================================================
14. BUENAS PRÁCTICAS
--------------------------------------------------------------
1. Usa nombres descriptivos en minúsculas (ejemplo: empleados, ventas, clientes).
2. Define siempre una PRIMARY KEY por tabla.
3. Usa NOT NULL cuando el campo sea obligatorio.
4. Usa DEFAULT para valores comunes.
5. Agrega CHECK para validar rangos o condiciones.
6. Usa FOREIGN KEY para mantener coherencia entre tablas.
7. Nunca uses nombres con espacios o acentos.
8. Mantén una convención uniforme (por ejemplo, snake_case).
9. Evita usar AUTO_INCREMENT en combinaciones con claves compuestas.
10. Siempre prueba la creación en un entorno de desarrollo antes de producción.

==============================================================
15. RESUMEN GENERAL
--------------------------------------------------------------
• CREATE TABLE crea nuevas estructuras de almacenamiento.
• Las CONSTRAINTS aseguran la integridad de los datos.
• NULL / NOT NULL controlan la obligatoriedad de un campo.
• UNIQUE evita duplicados.
• PRIMARY KEY identifica registros únicos.
• FOREIGN KEY vincula tablas entre sí.
• CHECK valida condiciones.
• DEFAULT establece valores por omisión.
• AUTO_INCREMENT genera claves automáticas.
• ON DELETE / ON UPDATE definen acciones entre tablas relacionadas.
==============================================================
*/

-- Crea una tabla llamada "persons" con nombre de columna (atributos) de tipo int, varchar y date
CREATE TABLE persons (
	id int,
    name varchar(100),
    age int,
    email varchar(50),
    created date
);

-- NOT NULL: Obliga a que el campo id posea siempre un valor no nulo
CREATE TABLE persons2 (
	id int NOT NULL,
    name varchar(100) NOT NULL,
    age int,
    email varchar(50),
    created date
);

-- UNIQUE: Obliga a que el campo id posea valores diferentes
CREATE TABLE persons3 (
	id int NOT NULL,
    name varchar(100) NOT NULL,
    age int,
    email varchar(50),
    created datetime,
    UNIQUE(id)
);

-- PRIMARY KEY: Establece el campo id como clave primaria para futuras relaciones con otras tablas
CREATE TABLE persons4 (
	id int NOT NULL,
    name varchar(100) NOT NULL,
    age int,
    email varchar(50),
    created datetime,
    UNIQUE(id),
    PRIMARY KEY(id)
);

-- CHECK: Establece que el campo age sólo podrá contener valores mayores o iguales a 18
CREATE TABLE persons5 (
	id int NOT NULL,
    name varchar(100) NOT NULL,
    age int,
    email varchar(50),
    created datetime,
    UNIQUE(id),
    PRIMARY KEY(id),
    CHECK(age>=18)
);

-- DEFAULT: Establece un valor por defecto en el campo created correspondiente a la fecha del sistema
CREATE TABLE persons6 (
	id int NOT NULL,
    name varchar(100) NOT NULL,
    age int,
    email varchar(50),
    created datetime DEFAULT CURRENT_TIMESTAMP(),
    UNIQUE(id),
    PRIMARY KEY(id),
    CHECK(age>=18)
);

-- AUTO_INCREMENT: Indica que el campo id siempre se va a incrementar en 1 con cada nuevo inserto
CREATE TABLE persons7 (
	id int NOT NULL AUTO_INCREMENT,
    name varchar(100) NOT NULL,
    age int,
    email varchar(50),
    created datetime DEFAULT CURRENT_TIMESTAMP(),
    UNIQUE(id),
    PRIMARY KEY(id),
    CHECK(age>=18)
);