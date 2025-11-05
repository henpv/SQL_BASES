/*
==============================================================
SECCIÓN 2: UPDATE EN SQL
==============================================================

1. ¿QUÉ ES EL COMANDO UPDATE?
--------------------------------------------------------------
El comando **UPDATE** se utiliza para **modificar registros existentes**
dentro de una tabla.

Permite cambiar el valor de una o varias columnas en uno o varios
registros, dependiendo de las condiciones que se especifiquen en
la cláusula **WHERE**.

⚠️ Importante:
Si no se incluye una condición WHERE, se actualizarán **todos**
los registros de la tabla.

==============================================================
2. ESTRUCTURA BÁSICA DE UPDATE
==============================================================
UPDATE nombre_tabla
SET columna1 = nuevo_valor1,
    columna2 = nuevo_valor2,
    ...
WHERE condición;

Ejemplo:
--------------------------------------------------------------
-- Actualizar el salario de un empleado específico
UPDATE empleados
SET salario = 4800
WHERE id = 3;

Explicación:
Modifica el salario del empleado cuyo ID es 3.

==============================================================
3. ACTUALIZAR VARIAS COLUMNAS A LA VEZ
--------------------------------------------------------------
Puedes cambiar múltiples valores en una misma sentencia.

Ejemplo:
--------------------------------------------------------------
UPDATE empleados
SET cargo = 'Coordinador de Proyectos',
    salario = 5500
WHERE nombre = 'Laura Gómez';

Explicación:
Actualiza tanto el cargo como el salario para el registro que cumple
la condición especificada.

==============================================================
4. ACTUALIZAR TODOS LOS REGISTROS (SIN WHERE)
--------------------------------------------------------------
⚠️ Precaución: esto modifica toda la tabla.

Ejemplo:
--------------------------------------------------------------
-- Aumentar el salario de todos los empleados en un 5%
UPDATE empleados
SET salario = salario * 1.05;

Explicación:
Todos los registros en la tabla “empleados” son actualizados.

==============================================================
5. ACTUALIZAR USANDO CONDICIONES LÓGICAS
--------------------------------------------------------------
Puedes aplicar operadores lógicos (AND, OR, NOT) para definir
condiciones más precisas.

Ejemplo:
--------------------------------------------------------------
-- Aumentar salario solo a los analistas que ganan menos de 3500
UPDATE empleados
SET salario = salario + 500
WHERE cargo = 'Analista' AND salario < 3500;

==============================================================
6. ACTUALIZAR USANDO SUBCONSULTAS
--------------------------------------------------------------
Puedes usar el resultado de otra consulta dentro de un UPDATE.

Ejemplo:
--------------------------------------------------------------
-- Igualar el salario promedio de un área
UPDATE empleados
SET salario = (
    SELECT AVG(salario)
    FROM empleados
    WHERE cargo = 'Gerente'
)
WHERE cargo = 'Analista';

Explicación:
Actualiza el salario de los analistas al promedio del salario de los gerentes.

==============================================================
7. USAR UPDATE CON FUNCIONES
--------------------------------------------------------------
Puedes aplicar funciones SQL para transformar datos durante la actualización.

Ejemplo:
--------------------------------------------------------------
-- Convertir todos los nombres a mayúsculas
UPDATE empleados
SET nombre = UPPER(nombre);

-- Actualizar fecha de modificación
UPDATE empleados
SET fecha_actualizacion = NOW();

==============================================================
8. ACTUALIZAR DATOS ENTRE TABLAS RELACIONADAS
--------------------------------------------------------------
En MySQL, puedes combinar **UPDATE** con **JOIN** para modificar datos
usando valores de otra tabla.

Ejemplo:
--------------------------------------------------------------
-- Actualizar el campo “salario” de empleados según la tabla salarios_nuevos
UPDATE empleados AS e
JOIN salarios_nuevos AS s ON e.id = s.id_empleado
SET e.salario = s.nuevo_salario
WHERE s.nuevo_salario > e.salario;

Explicación:
Actualiza el salario de cada empleado con el valor nuevo, solo si es mayor.

==============================================================
9. USAR CASE DENTRO DE UPDATE
--------------------------------------------------------------
Puedes aplicar lógica condicional dentro de un UPDATE con **CASE**.

Ejemplo:
--------------------------------------------------------------
UPDATE empleados
SET salario = CASE
    WHEN cargo = 'Gerente' THEN salario * 1.10
    WHEN cargo = 'Analista' THEN salario * 1.07
    ELSE salario * 1.05
END;

Explicación:
Aplica un aumento diferente según el cargo del empleado.

==============================================================
10. CONTROLAR ACTUALIZACIONES CON TRANSACCIONES
--------------------------------------------------------------
Para evitar errores en actualizaciones masivas, usa transacciones.

Ejemplo:
--------------------------------------------------------------
START TRANSACTION;

UPDATE empleados
SET salario = salario * 1.05
WHERE cargo = 'Técnico';

-- Si todo está correcto:
COMMIT;

-- Si hubo un error o algo no salió bien:
ROLLBACK;

Explicación:
Las transacciones permiten revertir los cambios si ocurre un error.

==============================================================
11. VERIFICAR LOS CAMBIOS REALIZADOS
--------------------------------------------------------------
Después de un UPDATE, puedes usar un SELECT para confirmar el resultado.

Ejemplo:
--------------------------------------------------------------
SELECT * FROM empleados WHERE id = 3;

==============================================================
12. BUENAS PRÁCTICAS
--------------------------------------------------------------
1. Usa siempre la cláusula **WHERE** para evitar modificar todos los registros.
2. Realiza un **SELECT** previo para verificar qué filas serán afectadas.
3. Usa **transacciones** cuando la actualización sea crítica.
4. Realiza **copias de seguridad** antes de actualizaciones masivas.
5. Documenta los cambios en un campo de auditoría (por ejemplo, fecha_modificación).
6. Usa **JOIN** con cuidado para mantener integridad entre tablas.
7. Aplica **CASE** para actualizaciones condicionales complejas.
8. Verifica los permisos del usuario antes de ejecutar un UPDATE.

==============================================================
13. RESUMEN GENERAL
--------------------------------------------------------------
• UPDATE modifica registros existentes en una tabla.
• Puede afectar una o varias columnas.
• Si no se incluye WHERE, afecta a toda la tabla.
• Puede usarse con funciones, subconsultas y CASE.
• Se puede combinar con JOIN para actualizar desde otras tablas.
• Se recomienda usar transacciones para mayor seguridad.
• Siempre confirma los resultados con un SELECT posterior.
==============================================================
*/

-- Estable el valor 21 para la edad del registro de la tabla "users" con identificador igual a 11
UPDATE users SET age = '21' WHERE user_id = 11;

-- Estable el valor 20 para la edad del registro de la tabla "users" con identificador igual a 11
UPDATE users SET age = '20' WHERE user_id = 11;

-- Estable edad y una fecha para registro de la tabla "users" con identificador igual a 11
UPDATE users SET age = 20, init_date = '2020-10-12' WHERE user_id = 11;