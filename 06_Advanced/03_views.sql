/*
==============================================================
SECCIÓN 3: VISTAS (VIEWS) EN SQL
==============================================================

1. ¿QUÉ ES UNA VISTA?
--------------------------------------------------------------
Una **VISTA** es una consulta SQL almacenada en la base de datos 
que actúa como una “tabla virtual”.  
No almacena los datos físicamente, sino que muestra los resultados
de una o varias tablas según una consulta predefinida.

En otras palabras:
• Una vista es una forma personalizada de ver los datos.
• Permite simplificar consultas complejas.
• Facilita el control de acceso a la información.

==============================================================
2. SINTAXIS BÁSICA DE CREACIÓN
--------------------------------------------------------------
CREATE VIEW nombre_vista AS
SELECT columnas
FROM tabla
WHERE condiciones;

Ejemplo:
--------------------------------------------------------------
CREATE VIEW vista_empleados_activos AS
SELECT id_empleado, nombre, cargo, salario
FROM empleados
WHERE estado = 'activo';

Explicación:
• Crea una vista llamada “vista_empleados_activos”.
• Muestra únicamente los empleados cuyo estado sea “activo”.

==============================================================
3. CONSULTAR UNA VISTA
--------------------------------------------------------------
SELECT * FROM vista_empleados_activos;

Explicación:
• Se consulta igual que una tabla normal.
• Los resultados siempre reflejan los datos actuales de las tablas base.

==============================================================
4. VENTAJAS DE USAR VISTAS
--------------------------------------------------------------
1. Simplifican consultas complejas:  
   - Puedes encapsular un SELECT largo y usarlo como si fuera una tabla.

2. Mejoran la seguridad:  
   - Permiten ocultar columnas sensibles (por ejemplo, salarios o contraseñas).

3. Facilitan el mantenimiento:  
   - Si cambia la estructura de la tabla, solo ajustas la vista, no todos los SELECT.

4. Permiten consistencia:  
   - Garantizan que todos los usuarios vean la información de la misma forma.

==============================================================
5. VISTA CON JOIN ENTRE TABLAS
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
CREATE VIEW vista_pedidos_clientes AS
SELECT 
    p.id_pedido,
    c.nombre AS cliente,
    p.fecha_pedido,
    p.total
FROM pedidos p
INNER JOIN clientes c ON p.id_cliente = c.id_cliente;

Explicación:
• Combina información de dos tablas (pedidos y clientes).
• Facilita obtener información relacionada en una sola vista.

==============================================================
6. VISTAS CON FUNCIONES AGREGADAS
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
CREATE VIEW vista_total_por_cliente AS
SELECT 
    id_cliente,
    SUM(total) AS total_compras,
    COUNT(id_pedido) AS cantidad_pedidos
FROM pedidos
GROUP BY id_cliente;

Explicación:
• Muestra el total de compras y el número de pedidos por cliente.
• Ideal para reportes o análisis.

==============================================================
7. ACTUALIZAR UNA VISTA EXISTENTE
--------------------------------------------------------------
ALTER VIEW nombre_vista AS
SELECT columnas
FROM tabla
WHERE condiciones;

Ejemplo:
--------------------------------------------------------------
ALTER VIEW vista_empleados_activos AS
SELECT id_empleado, nombre, cargo, salario, departamento
FROM empleados
WHERE estado = 'activo';

Explicación:
• Modifica la vista existente sin necesidad de eliminarla primero.

==============================================================
8. ELIMINAR UNA VISTA
--------------------------------------------------------------
DROP VIEW IF EXISTS nombre_vista;

Ejemplo:
--------------------------------------------------------------
DROP VIEW IF EXISTS vista_empleados_activos;

Explicación:
• Elimina la vista “vista_empleados_activos” si existe.

==============================================================
9. VISTAS ACTUALIZABLES
--------------------------------------------------------------
Algunas vistas permiten insertar, actualizar o eliminar registros
directamente, **solo si cumplen ciertas condiciones**:

✔ La vista se basa en una sola tabla.  
✔ No usa funciones agregadas (SUM, COUNT, etc.).  
✔ No usa DISTINCT, GROUP BY ni UNION.  
✔ No incluye subconsultas en la lista SELECT.

Ejemplo (vista actualizable):
--------------------------------------------------------------
CREATE VIEW vista_departamentos AS
SELECT id_departamento, nombre
FROM departamentos;

-- Insertar en la tabla a través de la vista:
INSERT INTO vista_departamentos (nombre)
VALUES ('Recursos Humanos');

Explicación:
• El INSERT en la vista afectará directamente a la tabla base.

==============================================================
10. VISTAS NO ACTUALIZABLES
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
CREATE VIEW vista_resumen AS
SELECT departamento, COUNT(*) AS total_empleados
FROM empleados
GROUP BY departamento;

-- Intentar insertar o actualizar en esta vista producirá error,
-- porque usa una función agregada y GROUP BY.

==============================================================
11. VER TODAS LAS VISTAS EXISTENTES
--------------------------------------------------------------
SHOW FULL TABLES WHERE table_type = 'VIEW';

Explicación:
• Lista todas las vistas creadas en la base de datos actual.

==============================================================
12. VER LA DEFINICIÓN DE UNA VISTA
--------------------------------------------------------------
SHOW CREATE VIEW nombre_vista;

Ejemplo:
--------------------------------------------------------------
SHOW CREATE VIEW vista_pedidos_clientes;

Explicación:
• Muestra el comando SQL con el que fue creada la vista.

==============================================================
13. VISTAS CON ALIAS DE COLUMNAS
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
CREATE VIEW vista_productos_info AS
SELECT 
    id_producto AS codigo,
    nombre AS producto,
    precio AS valor_unitario
FROM productos;

Explicación:
• Permite renombrar las columnas para que sean más comprensibles.

==============================================================
14. USO DE VISTAS PARA SEGURIDAD
--------------------------------------------------------------
Ejemplo:
--------------------------------------------------------------
CREATE VIEW vista_clientes_publica AS
SELECT nombre, ciudad, telefono
FROM clientes;

Explicación:
• Crea una vista que omite datos sensibles como el número de identificación.
• Ideal para otorgar permisos de lectura sin exponer toda la información.

==============================================================
15. BUENAS PRÁCTICAS CON VISTAS
--------------------------------------------------------------
1. Usa nombres descriptivos (ej. vista_ventas_mensuales).  
2. No anides vistas sobre vistas (dificulta el rendimiento).  
3. Usa vistas para seguridad o simplificación, no para cálculos pesados.  
4. Verifica su impacto con EXPLAIN antes de usarlas en reportes grandes.  
5. Documenta siempre su propósito con comentarios.  
6. Mantén consistencia en nombres y alias de columnas.  

==============================================================
16. RESUMEN GENERAL
--------------------------------------------------------------
• Las vistas son consultas almacenadas que se comportan como tablas virtuales.  
• No guardan datos, solo muestran resultados dinámicos.  
• Se usan para simplificar consultas, proteger datos y estandarizar reportes.  
• Pueden ser actualizables o no, dependiendo de su complejidad.  
• SHOW FULL TABLES muestra las vistas existentes.  
• SHOW CREATE VIEW permite ver su definición.  
• DROP VIEW elimina vistas no necesarias.  
• Son una herramienta esencial para organizar y asegurar tus datos SQL.
==============================================================
*/

-- Crea unaa vista llamada "v_adult_users" con los nombres y edades de usuarios de la table "users"
-- que tienen una edad igual o mayor a 18 años.
CREATE VIEW v_adult_users AS
SELECT name, age
FROM users
WHERE age >= 18;

SELECT * FROM v_adult_users;

-- Elimina la vista llamada "v_adult_users"
DROP VIEW v_adult_users;