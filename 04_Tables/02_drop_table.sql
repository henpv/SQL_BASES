/*
==============================================================
SECCIÓN 2: DROP TABLE EN SQL
==============================================================

1. ¿QUÉ ES DROP TABLE?
--------------------------------------------------------------
El comando **DROP TABLE** se utiliza para **eliminar por completo una tabla**
de una base de datos, junto con todos sus registros, índices y restricciones.

⚠️ Importante:
Una vez eliminada una tabla, **no se puede recuperar**
a menos que exista una copia de seguridad (backup) previa.

==============================================================
2. ESTRUCTURA BÁSICA DE DROP TABLE
--------------------------------------------------------------
DROP TABLE nombre_tabla;

Ejemplo:
--------------------------------------------------------------
DROP TABLE empleados;

Explicación:
Elimina la tabla “empleados” y todo su contenido.

==============================================================
3. USO SEGURO CON IF EXISTS
--------------------------------------------------------------
Para evitar errores si la tabla no existe, se recomienda usar:
--------------------------------------------------------------
DROP TABLE IF EXISTS nombre_tabla;

Ejemplo:
--------------------------------------------------------------
DROP TABLE IF EXISTS empleados;

Explicación:
Si la tabla existe, se eliminará.
Si no existe, no generará error.

==============================================================
4. ELIMINAR VARIAS TABLAS A LA VEZ
--------------------------------------------------------------
Puedes eliminar varias tablas en una sola instrucción,
separando los nombres con comas.

Ejemplo:
--------------------------------------------------------------
DROP TABLE IF EXISTS empleados, departamentos, proyectos;

==============================================================
5. EFECTOS DE DROP TABLE
--------------------------------------------------------------
Cuando ejecutas DROP TABLE:
1. Se eliminan todas las filas (registros).
2. Se eliminan las restricciones (PRIMARY KEY, FOREIGN KEY, UNIQUE, etc.).
3. Se eliminan los índices asociados.
4. Se libera el espacio ocupado en el almacenamiento.
5. Se elimina la definición de la tabla del esquema.

==============================================================
6. DIFERENCIA ENTRE DROP, TRUNCATE Y DELETE
--------------------------------------------------------------
| COMANDO       | ¿Elimina la tabla? | ¿Elimina los datos? | ¿Reversible? | ¿Libera espacio? |
|----------------|--------------------|----------------------|--------------|------------------|
| DROP TABLE     | ✅ Sí              | ✅ Sí                | ❌ No         | ✅ Sí            |
| TRUNCATE TABLE | ❌ No              | ✅ Sí                | ❌ No         | ✅ Sí (parcial)  |
| DELETE FROM    | ❌ No              | ✅ Sí (condicional)  | ✅ Sí (si hay backup o transacción) | ❌ No |

Ejemplo:
--------------------------------------------------------------
-- Elimina solo los registros, no la tabla
DELETE FROM empleados;

-- Elimina todos los registros más rápido, pero deja la estructura
TRUNCATE TABLE empleados;

-- Elimina la tabla completa
DROP TABLE empleados;

==============================================================
7. ELIMINAR UNA TABLA CON CLAVES FORÁNEAS
--------------------------------------------------------------
Si una tabla tiene una **FOREIGN KEY** que depende de otra,
MySQL no permitirá eliminarla directamente.

Ejemplo:
--------------------------------------------------------------
-- Si empleados tiene una clave foránea hacia departamentos,
-- no podrás eliminar departamentos primero.
DROP TABLE departamentos;

Error:
Cannot drop table 'departamentos' because it is referenced by a foreign key constraint.

Solución:
--------------------------------------------------------------
1. Elimina primero la tabla hija (la que tiene la FOREIGN KEY).
2. Luego elimina la tabla padre.

Ejemplo:
--------------------------------------------------------------
DROP TABLE IF EXISTS empleados;
DROP TABLE IF EXISTS departamentos;

También puedes desactivar temporalmente la verificación de claves foráneas (con precaución):
--------------------------------------------------------------
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS empleados, departamentos;
SET FOREIGN_KEY_CHECKS = 1;

⚠️ Usa esta opción solo en entornos de desarrollo o pruebas.

==============================================================
8. VERIFICAR LAS TABLAS EXISTENTES
--------------------------------------------------------------
Antes de eliminar una tabla, puedes revisar las disponibles:

--------------------------------------------------------------
SHOW TABLES;

Salida esperada:
+------------------+
| Tables_in_empresa |
+------------------+
| empleados         |
| departamentos     |
+------------------+

==============================================================
9. RECREAR UNA TABLA DESPUÉS DE ELIMINARLA
--------------------------------------------------------------
Después de usar DROP TABLE, puedes volver a crearla con CREATE TABLE.

Ejemplo:
--------------------------------------------------------------
CREATE TABLE empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    cargo VARCHAR(50),
    salario DECIMAL(10,2)
);

==============================================================
10. USO EN MYSQL WORKBENCH
--------------------------------------------------------------
En MySQL Workbench puedes eliminar una tabla visualmente:

Pasos:
--------------------------------------------------------------
1. Abre el esquema (base de datos) en el panel izquierdo.
2. Expande la lista de tablas.
3. Haz clic derecho sobre la tabla que deseas eliminar.
4. Selecciona **"Drop Table..."**.
5. Confirma con **"Drop Now"**.

Workbench ejecutará internamente el comando:
--------------------------------------------------------------
DROP TABLE nombre_tabla;

==============================================================
11. CONSIDERACIONES DE SEGURIDAD
--------------------------------------------------------------
1. Verifica que estés conectado al entorno correcto (por ejemplo, no en producción).
2. Usa **IF EXISTS** para evitar errores.
3. Asegúrate de no tener dependencias activas (FOREIGN KEY).
4. Realiza copias de seguridad si los datos son importantes.
5. Evita ejecutar DROP TABLE dentro de scripts automáticos sin confirmación.
6. Revisa los logs para confirmar que la eliminación fue exitosa.
7. No uses SET FOREIGN_KEY_CHECKS = 0 en producción sin supervisión.

==============================================================
12. RESUMEN GENERAL
--------------------------------------------------------------
• DROP TABLE elimina completamente una tabla del sistema.
• IF EXISTS evita errores si la tabla no existe.
• No se puede recuperar la tabla después de eliminarla.
• Si existen claves foráneas, elimina primero las tablas dependientes.
• DROP TABLE ≠ TRUNCATE ≠ DELETE.
• Usa con precaución y, si es posible, en entornos de prueba.
==============================================================
*/

-- Elimina la tabla llamada "persons8"
DROP TABLE persons8;