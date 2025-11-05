/*
==============================================================
SECCIÓN 3: ALTER TABLE EN SQL
==============================================================

1. ¿QUÉ ES ALTER TABLE?
--------------------------------------------------------------
El comando **ALTER TABLE** se utiliza para **modificar la estructura**
de una tabla existente sin necesidad de eliminarla ni recrearla.

Permite:
 - Agregar o eliminar columnas.
 - Cambiar el tipo de dato de una columna.
 - Modificar o eliminar restricciones (PRIMARY KEY, FOREIGN KEY, etc.).
 - Cambiar el nombre de columnas o de la tabla.
 - Establecer o quitar valores por defecto (DEFAULT).

==============================================================
2. AGREGAR UNA NUEVA COLUMNA
--------------------------------------------------------------
Sintaxis:
--------------------------------------------------------------
ALTER TABLE nombre_tabla
ADD nombre_columna tipo_dato [restricciones];

Ejemplo:
--------------------------------------------------------------
ALTER TABLE empleados
ADD fecha_ingreso DATE;

Explicación:
Agrega la columna “fecha_ingreso” al final de la tabla “empleados”.

Agregar varias columnas a la vez:
--------------------------------------------------------------
ALTER TABLE empleados
ADD telefono VARCHAR(20),
ADD direccion VARCHAR(150);

==============================================================
3. ELIMINAR UNA COLUMNA
--------------------------------------------------------------
Sintaxis:
--------------------------------------------------------------
ALTER TABLE nombre_tabla
DROP COLUMN nombre_columna;

Ejemplo:
--------------------------------------------------------------
ALTER TABLE empleados
DROP COLUMN telefono;

⚠️ Advertencia:
Al eliminar una columna, se borran permanentemente todos los datos almacenados en ella.

==============================================================
4. CAMBIAR EL TIPO DE DATO DE UNA COLUMNA
--------------------------------------------------------------
Sintaxis:
--------------------------------------------------------------
ALTER TABLE nombre_tabla
MODIFY nombre_columna nuevo_tipo_dato;

Ejemplo:
--------------------------------------------------------------
ALTER TABLE empleados
MODIFY salario DECIMAL(12,2);

Explicación:
Cambia el tipo de dato de la columna “salario” a DECIMAL(12,2).

==============================================================
5. RENOMBRAR UNA COLUMNA
--------------------------------------------------------------
Sintaxis:
--------------------------------------------------------------
ALTER TABLE nombre_tabla
CHANGE COLUMN nombre_actual nuevo_nombre tipo_dato;

Ejemplo:
--------------------------------------------------------------
ALTER TABLE empleados
CHANGE COLUMN nombre nombre_completo VARCHAR(120);

Explicación:
Cambia el nombre de la columna “nombre” a “nombre_completo”
y actualiza su tipo de dato.

==============================================================
6. RENOMBRAR UNA TABLA
--------------------------------------------------------------
Sintaxis:
--------------------------------------------------------------
ALTER TABLE nombre_tabla
RENAME TO nuevo_nombre;

Ejemplo:
--------------------------------------------------------------
ALTER TABLE empleados
RENAME TO trabajadores;

Explicación:
Cambia el nombre de la tabla “empleados” por “trabajadores”.

==============================================================
7. AGREGAR UNA RESTRICCIÓN PRIMARY KEY
--------------------------------------------------------------
Sintaxis:
--------------------------------------------------------------
ALTER TABLE nombre_tabla
ADD CONSTRAINT nombre_constraint PRIMARY KEY (columna);

Ejemplo:
--------------------------------------------------------------
ALTER TABLE empleados
ADD CONSTRAINT pk_empleados PRIMARY KEY (id);

Explicación:
Define la columna “id” como clave primaria.

==============================================================
8. ELIMINAR UNA PRIMARY KEY
--------------------------------------------------------------
Sintaxis:
--------------------------------------------------------------
ALTER TABLE nombre_tabla
DROP PRIMARY KEY;

Ejemplo:
--------------------------------------------------------------
ALTER TABLE empleados
DROP PRIMARY KEY;

==============================================================
9. AGREGAR UNA FOREIGN KEY
--------------------------------------------------------------
Sintaxis:
--------------------------------------------------------------
ALTER TABLE tabla_hija
ADD CONSTRAINT nombre_constraint
FOREIGN KEY (columna_hija)
REFERENCES tabla_padre(columna_padre)
[ON DELETE acción] [ON UPDATE acción];

Ejemplo:
--------------------------------------------------------------
ALTER TABLE empleados
ADD CONSTRAINT fk_empleados_departamentos
FOREIGN KEY (departamento_id)
REFERENCES departamentos(id)
ON DELETE CASCADE
ON UPDATE CASCADE;

==============================================================
10. ELIMINAR UNA FOREIGN KEY
--------------------------------------------------------------
Primero necesitas conocer el nombre de la restricción:

SHOW CREATE TABLE nombre_tabla;

Luego ejecutas:
--------------------------------------------------------------
ALTER TABLE nombre_tabla
DROP FOREIGN KEY nombre_constraint;

Ejemplo:
--------------------------------------------------------------
ALTER TABLE empleados
DROP FOREIGN KEY fk_empleados_departamentos;

==============================================================
11. AGREGAR UNA RESTRICCIÓN UNIQUE
--------------------------------------------------------------
Sintaxis:
--------------------------------------------------------------
ALTER TABLE nombre_tabla
ADD CONSTRAINT nombre_constraint UNIQUE (columna);

Ejemplo:
--------------------------------------------------------------
ALTER TABLE usuarios
ADD CONSTRAINT uq_usuarios_correo UNIQUE (correo);

==============================================================
12. ELIMINAR UNA RESTRICCIÓN UNIQUE
--------------------------------------------------------------
ALTER TABLE nombre_tabla
DROP INDEX nombre_constraint;

Ejemplo:
--------------------------------------------------------------
ALTER TABLE usuarios
DROP INDEX uq_usuarios_correo;

==============================================================
13. AGREGAR O MODIFICAR UN VALOR DEFAULT
--------------------------------------------------------------
Agregar un valor por defecto:
--------------------------------------------------------------
ALTER TABLE productos
ALTER COLUMN estado SET DEFAULT 'activo';

Eliminar el valor por defecto:
--------------------------------------------------------------
ALTER TABLE productos
ALTER COLUMN estado DROP DEFAULT;

==============================================================
14. AGREGAR UNA RESTRICCIÓN CHECK
--------------------------------------------------------------
Sintaxis:
--------------------------------------------------------------
ALTER TABLE nombre_tabla
ADD CONSTRAINT nombre_constraint CHECK (condición);

Ejemplo:
--------------------------------------------------------------
ALTER TABLE empleados
ADD CONSTRAINT chk_salario CHECK (salario > 0);

Eliminar una restricción CHECK:
--------------------------------------------------------------
ALTER TABLE empleados
DROP CHECK nombre_constraint;

==============================================================
15. CAMBIAR EL NOMBRE DE UNA RESTRICCIÓN
--------------------------------------------------------------
Sintaxis:
--------------------------------------------------------------
ALTER TABLE nombre_tabla
RENAME CONSTRAINT nombre_actual TO nuevo_nombre;

Ejemplo (según motor SQL compatible, no todos lo admiten):
--------------------------------------------------------------
ALTER TABLE empleados
RENAME CONSTRAINT chk_salario TO chk_salario_positivo;

==============================================================
16. VER TODAS LAS RESTRICCIONES DE UNA TABLA
--------------------------------------------------------------
SHOW CREATE TABLE nombre_tabla;

Ejemplo:
--------------------------------------------------------------
SHOW CREATE TABLE empleados;

Esto mostrará las claves primarias, foráneas, índices y restricciones.

==============================================================
17. USO DE ALTER TABLE CON AUTO_INCREMENT
--------------------------------------------------------------
Puedes reiniciar el contador AUTO_INCREMENT de una tabla.

Ejemplo:
--------------------------------------------------------------
ALTER TABLE clientes AUTO_INCREMENT = 1;

Explicación:
Hace que el próximo registro insertado comience desde el ID 1.

==============================================================
18. BUENAS PRÁCTICAS
--------------------------------------------------------------
1. Realiza una copia de seguridad antes de modificar estructuras.
2. Usa nombres descriptivos para las constraints (pk_, fk_, uq_, chk_).
3. Evita eliminar columnas que puedan tener datos importantes.
4. Verifica dependencias (FOREIGN KEY) antes de borrar restricciones.
5. Documenta cada cambio en el esquema.
6. Prueba los ALTER TABLE en entornos de desarrollo antes de producción.
7. Usa SHOW CREATE TABLE antes y después para confirmar los cambios.

==============================================================
19. RESUMEN GENERAL
--------------------------------------------------------------
• ALTER TABLE modifica estructuras existentes sin recrearlas.
• ADD agrega columnas o restricciones.
• DROP elimina columnas o constraints.
• MODIFY o CHANGE cambian tipos o nombres.
• RENAME cambia el nombre de la tabla.
• PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK y DEFAULT pueden agregarse o quitarse.
• AUTO_INCREMENT puede reiniciarse o ajustarse.
• Siempre verificar las dependencias y los efectos de cada cambio.
==============================================================
*/

-- ADD: Añade un nuevo atributo surname a la tabla "persons8"
ALTER TABLE persons8
ADD surname varchar(150);


-- RENAME COLUMN: Renombra el atributo surname a description en la tabla "persons8"
ALTER TABLE persons8
RENAME COLUMN surname TO description;

-- MODIFY COLUMN: Modifica el tipo de dato del atributo description en la tabla "persons8"
ALTER TABLE persons8
MODIFY COLUMN description varchar(250);

-- DROP COLUMN: Elimina el atributo description en la tabla "persons8"
ALTER TABLE persons8
DROP COLUMN description;