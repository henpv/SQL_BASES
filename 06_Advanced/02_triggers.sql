/*
==============================================================
SECCIÓN 2: TRIGGERS (DISPARADORES) EN SQL
==============================================================

1. ¿QUÉ ES UN TRIGGER?
--------------------------------------------------------------
Un **TRIGGER** (disparador) es un bloque de código SQL que se ejecuta 
automáticamente cuando ocurre un evento específico en una tabla.

Los eventos pueden ser:
 - INSERT
 - UPDATE
 - DELETE

En resumen:
Un TRIGGER "escucha" cambios en una tabla y ejecuta acciones
antes o después del evento.

==============================================================
2. TIPOS DE TRIGGERS EN MYSQL
--------------------------------------------------------------
MySQL permite dos momentos de ejecución:

• BEFORE → Antes de que ocurra la operación.
• AFTER  → Después de que la operación se haya realizado.

Combinando ambos con los tres eventos posibles (INSERT, UPDATE, DELETE),
tenemos seis tipos de triggers:

1. BEFORE INSERT  
2. AFTER INSERT  
3. BEFORE UPDATE  
4. AFTER UPDATE  
5. BEFORE DELETE  
6. AFTER DELETE

==============================================================
3. ESTRUCTURA BÁSICA DE UN TRIGGER
--------------------------------------------------------------
CREATE TRIGGER nombre_trigger
{BEFORE | AFTER} {INSERT | UPDATE | DELETE}
ON nombre_tabla
FOR EACH ROW
BEGIN
    -- Acciones a ejecutar
END;

--------------------------------------------------------------
⚠️ Nota:
En MySQL, cuando defines un bloque BEGIN ... END dentro de un TRIGGER,
debes cambiar el delimitador temporalmente para que no cause error.
--------------------------------------------------------------

Ejemplo de delimitadores:
--------------------------------------------------------------
DELIMITER //

CREATE TRIGGER ejemplo_trigger
BEFORE INSERT
ON empleados
FOR EACH ROW
BEGIN
    SET NEW.fecha_creacion = NOW();
END;
//

DELIMITER ;

==============================================================
4. BEFORE INSERT
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
DELIMITER //

CREATE TRIGGER before_insert_empleado
BEFORE INSERT ON empleados
FOR EACH ROW
BEGIN
    SET NEW.fecha_creacion = NOW();
END;
//

DELIMITER ;

Explicación:
 - Se ejecuta antes de insertar un nuevo empleado.
 - Asigna automáticamente la fecha actual al campo “fecha_creacion”.

==============================================================
5. AFTER INSERT
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
DELIMITER //

CREATE TRIGGER after_insert_empleado
AFTER INSERT ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO auditoria (accion, fecha, descripcion)
    VALUES ('INSERT', NOW(), CONCAT('Nuevo empleado: ', NEW.nombre));
END;
//

DELIMITER ;

Explicación:
 - Se ejecuta después de insertar un nuevo registro.
 - Guarda un registro en una tabla de auditoría.

==============================================================
6. BEFORE UPDATE
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
DELIMITER //

CREATE TRIGGER before_update_empleado
BEFORE UPDATE ON empleados
FOR EACH ROW
BEGIN
    SET NEW.fecha_actualizacion = NOW();
END;
//

DELIMITER ;

Explicación:
 - Antes de actualizar el registro, actualiza el campo
   “fecha_actualizacion” con la hora actual.

==============================================================
7. AFTER UPDATE
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
DELIMITER //

CREATE TRIGGER after_update_empleado
AFTER UPDATE ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO auditoria (accion, fecha, descripcion)
    VALUES ('UPDATE', NOW(), CONCAT('Empleado modificado: ', NEW.nombre));
END;
//

DELIMITER ;

Explicación:
 - Guarda en la tabla “auditoria” información sobre quién fue modificado.

==============================================================
8. BEFORE DELETE
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
DELIMITER //

CREATE TRIGGER before_delete_empleado
BEFORE DELETE ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO auditoria (accion, fecha, descripcion)
    VALUES ('DELETE', NOW(), CONCAT('Eliminando empleado: ', OLD.nombre));
END;
//

DELIMITER ;

Explicación:
 - Antes de eliminar el registro, registra el nombre del empleado eliminado.
 - En este caso se usa **OLD** para acceder a los valores anteriores.

==============================================================
9. AFTER DELETE
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
DELIMITER //

CREATE TRIGGER after_delete_empleado
AFTER DELETE ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO eliminados (nombre, fecha_eliminacion)
    VALUES (OLD.nombre, NOW());
END;
//

DELIMITER ;

Explicación:
 - Inserta en una tabla “eliminados” información sobre el registro borrado.

==============================================================
10. PALABRAS CLAVE NEW Y OLD
--------------------------------------------------------------
• **NEW.columna** → Representa el valor NUEVO del registro (INSERT o UPDATE).  
• **OLD.columna** → Representa el valor ANTIGUO del registro (UPDATE o DELETE).  

Ejemplo:
--------------------------------------------------------------
-- Mostrar valores antes y después de actualizar
CREATE TRIGGER ejemplo_cambios
AFTER UPDATE ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO auditoria (accion, fecha, descripcion)
    VALUES (
        'UPDATE',
        NOW(),
        CONCAT('Cambio en salario de ', OLD.nombre,
               ' de ', OLD.salario, ' a ', NEW.salario)
    );
END;

==============================================================
11. VER TRIGGERS EXISTENTES
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
SHOW TRIGGERS;

Explicación:
 - Muestra todos los triggers existentes en la base de datos actual.

==============================================================
12. ELIMINAR UN TRIGGER
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
DROP TRIGGER IF EXISTS before_insert_empleado;

Explicación:
 - Elimina el trigger llamado “before_insert_empleado”.

==============================================================
13. USO DE TRIGGERS PARA AUDITORÍA
--------------------------------------------------------------
Los triggers son ideales para mantener un historial automático
de cambios en los datos.

Ejemplo:
--------------------------------------------------------------
CREATE TABLE auditoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    accion VARCHAR(20),
    tabla_afectada VARCHAR(50),
    fecha DATETIME,
    descripcion TEXT
);

CREATE TRIGGER after_update_empleado
AFTER UPDATE ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO auditoria (accion, tabla_afectada, fecha, descripcion)
    VALUES ('UPDATE', 'empleados', NOW(),
            CONCAT('Empleado ', OLD.nombre, ' modificado a ', NEW.nombre));
END;

==============================================================
14. LIMITACIONES DE LOS TRIGGERS
--------------------------------------------------------------
1. Un trigger no puede ejecutar COMMIT ni ROLLBACK.  
2. No se pueden llamar procedimientos almacenados con transacciones internas.  
3. No se pueden usar para tablas TEMPORALES.  
4. Cada combinación de momento (BEFORE/AFTER) y evento (INSERT/UPDATE/DELETE)
   solo puede tener un trigger por tabla.  
5. Un trigger no puede modificar la misma tabla que lo dispara (evita recursión).  
6. Excesivo uso de triggers puede afectar el rendimiento.

==============================================================
15. BUENAS PRÁCTICAS
--------------------------------------------------------------
1. Usa nombres descriptivos (ej. after_update_empleado_auditoria).  
2. Limita la lógica dentro de un trigger (manténlo simple).  
3. Documenta bien qué hace cada uno (comentarios).  
4. Centraliza la auditoría en una sola tabla.  
5. Evita dependencias entre triggers y procedimientos complejos.  
6. Verifica con SHOW TRIGGERS o INFORMATION_SCHEMA.TRIGGERS
   antes de crear nuevos.  
7. Prueba siempre tus triggers con copias de datos, no en producción directa.

==============================================================
16. RESUMEN GENERAL
--------------------------------------------------------------
• Los triggers ejecutan acciones automáticas en respuesta a INSERT, UPDATE o DELETE.  
• BEFORE → Antes de la operación.  
• AFTER → Después de la operación.  
• OLD → Datos anteriores, NEW → Datos nuevos.  
• Son útiles para auditorías, validaciones o actualizaciones automáticas.  
• Usar con precaución: pueden afectar el rendimiento si hay muchos.  
• No permiten transacciones explícitas (COMMIT/ROLLBACK).  
• SHOW TRIGGERS muestra todos los disponibles.  
==============================================================
*/


-- Crea una tabla de historial para usar en el ejemplo
CREATE TABLE `hello_mysql`.`email_history` (
`email_history_id` INT NOT NULL AUTO_INCREMENT,
`user_id` INT NOT NULL,
`email` VARCHAR(100) NULL,
PRIMARY KEY (`email_history_id`),
UNIQUE INDEX `email_history_id_UNIQUE` (`email_history_id` ASC) VISIBLE);

-- Crea un trigger llamado "tg_email" que guarda el email previo en la tabla "email_history" siempre
-- que se actualiza el campo "email" en la tabla "users"

-- DELIMITER es una directiva que sirve para cambiar el delimitador de instrucciones SQL, que por defecto es ;
-- Se utiliza cuando se define un bloque de código como un procedimiento donde se requieren múltiples 
-- instrucciones SQL terminadas con punto y coma dentro de un mismo bloque.
DELIMITER //
CREATE TRIGGER tg_email
AFTER UPDATE ON users
FOR EACH ROW
BEGIN
	IF OLD.email <> NEW.email THEN
		INSERT INTO email_history (user_id, email)
		VALUES (OLD.user_id, OLD.email);
	END IF;
END//

-- Actualiza el campo "email" del usuario 1 la tabla "users" para probar el trigger
UPDATE users SET email = 'mouredev@gmail.com' WHERE user_id = 1

-- Elimina el trigger llamado "tg_email"
DROP TRIGGER tg_email;