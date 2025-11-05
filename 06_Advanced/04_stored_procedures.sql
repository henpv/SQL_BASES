/*
==============================================================
SECCIÓN 4: PROCEDIMIENTOS ALMACENADOS (STORED PROCEDURES)
==============================================================

1. ¿QUÉ ES UN PROCEDIMIENTO ALMACENADO?
--------------------------------------------------------------
Un **Stored Procedure** (procedimiento almacenado) es un bloque de código SQL 
almacenado en el servidor de la base de datos, que puede ejecutarse cuando sea necesario.

En lugar de repetir una misma consulta muchas veces en tu aplicación,
puedes crear un procedimiento que la contenga y llamarlo fácilmente.

En resumen:
• Encapsula lógica SQL en un solo bloque reutilizable.
• Mejora el rendimiento (se ejecuta del lado del servidor).
• Facilita el mantenimiento y la seguridad.

==============================================================
2. SINTAXIS BÁSICA
--------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE nombre_procedimiento()
BEGIN
    -- Aquí van las instrucciones SQL
END;
//

DELIMITER ;

Explicación:
• Se usa `DELIMITER //` para que MySQL no confunda el punto y coma interno.
• El procedimiento se encierra entre `BEGIN` y `END`.

==============================================================
3. EJEMPLO BÁSICO
--------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE listar_empleados()
BEGIN
    SELECT * FROM empleados;
END;
//

DELIMITER ;

-- Para ejecutar el procedimiento:
CALL listar_empleados();

Explicación:
• Crea un procedimiento que muestra todos los empleados.
• Se ejecuta con la instrucción `CALL nombre_procedimiento();`.

==============================================================
4. PARÁMETROS EN UN PROCEDIMIENTO
--------------------------------------------------------------
Los procedimientos pueden recibir parámetros para hacerlo más flexible.

Sintaxis general:
--------------------------------------------------------------
CREATE PROCEDURE nombre(IN param1 tipo, OUT param2 tipo, INOUT param3 tipo)
BEGIN
    -- Código
END;

Tipos de parámetros:
• IN → Entrada (envías el valor al procedimiento).
• OUT → Salida (el procedimiento devuelve un valor).
• INOUT → Entrada y salida (envías y modificas el valor).

==============================================================
5. EJEMPLO CON PARÁMETRO DE ENTRADA
--------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE buscar_empleado(IN p_id INT)
BEGIN
    SELECT * FROM empleados WHERE id_empleado = p_id;
END;
//

DELIMITER ;

-- Llamada:
CALL buscar_empleado(5);

Explicación:
• Busca un empleado según el ID pasado como parámetro.

==============================================================
6. EJEMPLO CON PARÁMETRO DE SALIDA
--------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE contar_empleados(OUT total INT)
BEGIN
    SELECT COUNT(*) INTO total FROM empleados;
END;
//

DELIMITER ;

-- Llamada:
CALL contar_empleados(@resultado);
SELECT @resultado AS total_empleados;

Explicación:
• El parámetro OUT devuelve el total de empleados a una variable (@resultado).

==============================================================
7. EJEMPLO CON PARÁMETRO DE ENTRADA Y SALIDA
--------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE duplicar_valor(INOUT numero INT)
BEGIN
    SET numero = numero * 2;
END;
//

DELIMITER ;

-- Llamada:
SET @valor = 10;
CALL duplicar_valor(@valor);
SELECT @valor AS resultado;

Explicación:
• Recibe un número, lo duplica y devuelve el resultado modificado.

==============================================================
8. USO DE VARIABLES INTERNAS
--------------------------------------------------------------
Puedes declarar variables locales dentro del procedimiento:

DELIMITER //

CREATE PROCEDURE ejemplo_variables()
BEGIN
    DECLARE contador INT DEFAULT 0;
    SELECT COUNT(*) INTO contador FROM empleados;
    SELECT CONCAT('Total de empleados: ', contador) AS mensaje;
END;
//

DELIMITER ;

==============================================================
9. CONDICIONALES DENTRO DE UN PROCEDIMIENTO
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE verificar_salario(IN id INT)
BEGIN
    DECLARE salario_empleado DECIMAL(10,2);

    SELECT salario INTO salario_empleado
    FROM empleados
    WHERE id_empleado = id;

    IF salario_empleado > 3000 THEN
        SELECT 'El salario es alto' AS resultado;
    ELSE
        SELECT 'El salario es bajo' AS resultado;
    END IF;
END;
//

DELIMITER ;

==============================================================
10. CICLOS (LOOPS) EN UN PROCEDIMIENTO
--------------------------------------------------------------
Ejemplo con WHILE:
--------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE contar_hasta(IN n INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= n DO
        SELECT i AS numero;
        SET i = i + 1;
    END WHILE;
END;
//

DELIMITER ;

Explicación:
• Muestra una lista de números del 1 hasta “n”.

==============================================================
11. MANEJO DE ERRORES (HANDLERS)
--------------------------------------------------------------
Puedes capturar errores dentro de un procedimiento con HANDLER:

DELIMITER //

CREATE PROCEDURE ejemplo_handler()
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SELECT 'Ocurrió un error al ejecutar el procedimiento' AS error;

    -- Simulación de error (tabla inexistente)
    SELECT * FROM tabla_inexistente;
END;
//

DELIMITER ;

==============================================================
12. MODIFICAR UN PROCEDIMIENTO
--------------------------------------------------------------
No se puede modificar directamente un procedimiento.
Debes eliminarlo y volver a crearlo.

DROP PROCEDURE IF EXISTS nombre_procedimiento;
CREATE PROCEDURE nombre_procedimiento() ... ;

==============================================================
13. ELIMINAR UN PROCEDIMIENTO
--------------------------------------------------------------
DROP PROCEDURE IF EXISTS nombre_procedimiento;

Ejemplo:
--------------------------------------------------------------
DROP PROCEDURE IF EXISTS listar_empleados;

==============================================================
14. LISTAR TODOS LOS PROCEDIMIENTOS
--------------------------------------------------------------
SHOW PROCEDURE STATUS WHERE Db = 'nombre_base_datos';

Explicación:
• Muestra los procedimientos creados en la base de datos actual.

==============================================================
15. VER EL CÓDIGO DE UN PROCEDIMIENTO
--------------------------------------------------------------
SHOW CREATE PROCEDURE nombre_procedimiento;

Ejemplo:
--------------------------------------------------------------
SHOW CREATE PROCEDURE buscar_empleado;

==============================================================
16. USO PRÁCTICO DE PROCEDIMIENTOS
--------------------------------------------------------------
Ejemplo completo:
--------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE registrar_cliente(
    IN p_nombre VARCHAR(100),
    IN p_ciudad VARCHAR(50),
    IN p_correo VARCHAR(100)
)
BEGIN
    INSERT INTO clientes(nombre, ciudad, correo)
    VALUES(p_nombre, p_ciudad, p_correo);

    SELECT CONCAT('Cliente ', p_nombre, ' registrado correctamente') AS mensaje;
END;
//

DELIMITER ;

-- Llamada:
CALL registrar_cliente('Carlos Ruiz', 'Bogotá', 'carlos@example.com');

==============================================================
17. BUENAS PRÁCTICAS
--------------------------------------------------------------
1. Usa nombres descriptivos (ej. sp_registrar_cliente).  
2. Incluye comentarios detallando la lógica.  
3. Maneja errores con HANDLER cuando sea posible.  
4. Evita lógica excesiva dentro de un procedimiento.  
5. Usa parámetros IN, OUT e INOUT de forma clara.  
6. Controla los permisos (no todos los usuarios deben poder crear o ejecutar SPs).  
7. Versiona los procedimientos junto con el esquema de la base de datos.  

==============================================================
18. RESUMEN GENERAL
--------------------------------------------------------------
• Un procedimiento almacenado encapsula lógica SQL ejecutable.  
• Se ejecuta con CALL nombre_procedimiento().  
• Puede tener parámetros IN, OUT o INOUT.  
• Se crean con CREATE PROCEDURE y delimitadores personalizados.  
• Se pueden listar con SHOW PROCEDURE STATUS.  
• No se pueden modificar directamente, se deben eliminar y recrear.  
• Mejoran el rendimiento y centralizan la lógica del negocio.  
==============================================================
*/


-- Crea un procedimiento almacenado llamado "p_all_users" que obtiene todos los datos de "users"
DELIMITER //
CREATE PROCEDURE p_all_users()
BEGIN
	SELECT * FROM users;
END//

-- Invoca al procedimiento almacenado llamado "p_all_users"
CALL p_all_users;

-- Crea un procedimiento almacenado llamado "p_age_users" parametrizado para
-- obtener usuarios con edad variable
DELIMITER //
CREATE PROCEDURE p_age_users(IN age_param int)
BEGIN
	SELECT * FROM users WHERE age = age_param;
END//

-- Invoca al procedimiento almacenado llamado "p_age_users" con un parámetro de valor 30
CALL p_age_users(30);

-- Elimina el procedimiento almacenado llamado "p_age_users"
DROP PROCEDURE p_age_users;