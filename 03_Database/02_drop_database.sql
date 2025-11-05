/*
==============================================================
SECCIÓN 2: DROP DATABASE EN SQL
==============================================================

1. ¿QUÉ ES DROP DATABASE?
--------------------------------------------------------------
El comando **DROP DATABASE** se utiliza para **eliminar por completo una base de datos**
del servidor SQL, junto con todas sus tablas, datos, vistas, procedimientos y objetos relacionados.

⚠️ Advertencia importante:
Una vez eliminada la base de datos, **no se puede recuperar** a menos que exista
una copia de seguridad (backup).

==============================================================
2. ESTRUCTURA BÁSICA DE DROP DATABASE
--------------------------------------------------------------
DROP DATABASE nombre_base_datos;

Ejemplo:
--------------------------------------------------------------
DROP DATABASE empresa;

Explicación:
Elimina del servidor la base de datos llamada “empresa”, incluyendo todos sus datos.

==============================================================
3. USO SEGURO CON IF EXISTS
--------------------------------------------------------------
Para evitar errores si la base de datos no existe, se recomienda incluir
la condición **IF EXISTS**.

Ejemplo:
--------------------------------------------------------------
DROP DATABASE IF EXISTS empresa;

Explicación:
Solo eliminará la base de datos si realmente existe en el sistema,
evitando errores por intentos de eliminación duplicada.

==============================================================
4. VERIFICAR LAS BASES DE DATOS DISPONIBLES
--------------------------------------------------------------
Antes y después de eliminar una base de datos, puedes listar las existentes:

Ejemplo:
--------------------------------------------------------------
SHOW DATABASES;

Salida esperada (antes):
+--------------------+
| Database           |
+--------------------+
| empresa            |
| mysql              |
| performance_schema |
| test               |
+--------------------+

Salida esperada (después de DROP DATABASE empresa):
+--------------------+
| Database           |
+--------------------+
| mysql              |
| performance_schema |
| test               |
+--------------------+

==============================================================
5. ELIMINAR VARIAS BASES DE DATOS (EJECUCIÓN MANUAL)
--------------------------------------------------------------
MySQL no permite eliminar varias bases de datos en una sola instrucción.
Debes ejecutar un comando por cada base de datos:

Ejemplo:
--------------------------------------------------------------
DROP DATABASE IF EXISTS ventas;
DROP DATABASE IF EXISTS clientes;
DROP DATABASE IF EXISTS inventario;

==============================================================
6. CONSIDERACIONES DE SEGURIDAD
--------------------------------------------------------------
1. Asegúrate de estar trabajando en el entorno correcto (por ejemplo, desarrollo y no producción).
2. Realiza una copia de seguridad antes de eliminar una base de datos importante.
3. Revisa dos veces el nombre de la base de datos antes de ejecutar el comando.
4. Usa **IF EXISTS** para evitar errores si la base no está presente.
5. Solo los usuarios con privilegios de **DROP** pueden eliminar bases de datos.
6. Evita ejecutar DROP DATABASE dentro de scripts automáticos sin confirmación.
7. En entornos de trabajo en equipo, comunica la eliminación de una base antes de hacerlo.

==============================================================
7. VERIFICAR PRIVILEGIOS DEL USUARIO
--------------------------------------------------------------
Si recibes un error de permiso al ejecutar DROP DATABASE,
verifica los privilegios del usuario con:

Ejemplo:
--------------------------------------------------------------
SHOW GRANTS FOR 'usuario'@'localhost';

Salida esperada:
--------------------------------------------------------------
GRANT ALL PRIVILEGES ON *.* TO 'usuario'@'localhost' WITH GRANT OPTION;

Si el usuario no tiene permiso de DROP, un administrador deberá otorgarlo:

--------------------------------------------------------------
GRANT DROP ON *.* TO 'usuario'@'localhost';
FLUSH PRIVILEGES;

==============================================================
8. ELIMINAR UNA BASE DE DATOS DESDE WORKBENCH
--------------------------------------------------------------
En MySQL Workbench también puedes eliminar una base de datos visualmente:

Pasos:
--------------------------------------------------------------
1. Abre MySQL Workbench y conéctate al servidor.
2. En el panel de la izquierda (Navigator), ubica la base de datos.
3. Haz clic derecho sobre ella.
4. Selecciona **"Drop Schema..."**.
5. Confirma con **"Drop Now"**.

Esto ejecutará internamente el comando DROP DATABASE correspondiente.

==============================================================
9. DIFERENCIA ENTRE DROP DATABASE Y DROP TABLE
--------------------------------------------------------------
- **DROP DATABASE**: Elimina toda la base de datos y todos sus objetos.
- **DROP TABLE**: Elimina únicamente una tabla dentro de una base de datos existente.

Ejemplo:
--------------------------------------------------------------
-- Elimina toda la base de datos
DROP DATABASE empresa;

-- Elimina solo una tabla específica dentro de la base
DROP TABLE empleados;

==============================================================
10. RESUMEN GENERAL
--------------------------------------------------------------
• DROP DATABASE elimina completamente una base de datos.
• IF EXISTS evita errores si la base no existe.
• Es irreversible: los datos no se pueden recuperar sin backup.
• Solo usuarios con privilegios de DROP pueden ejecutarlo.
• Revisa siempre el nombre y entorno antes de ejecutar el comando.
• DROP TABLE se usa cuando solo quieres eliminar tablas, no bases completas.
==============================================================
*/


-- Elimina la base de datos llamada "test"
DROP DATABASE test;