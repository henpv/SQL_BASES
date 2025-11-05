/*
==============================================================
SECCIÓN 19: CASE EN SQL
==============================================================

1. ¿QUÉ ES CASE?
--------------------------------------------------------------
El comando CASE en SQL se usa para **evaluar condiciones** y 
**devolver un valor diferente según el resultado** de cada condición.

Es similar a una estructura "IF-ELSE" en otros lenguajes de programación.

==============================================================
2. ESTRUCTURA BÁSICA
==============================================================
SELECT
    columna,
    CASE
        WHEN condición1 THEN resultado1
        WHEN condición2 THEN resultado2
        ELSE resultado_por_defecto
    END AS nombre_alias
FROM tabla;

Ejemplo:
--------------------------------------------------------------
-- Clasificar los productos según su precio
SELECT
    nombre_producto,
    precio,
    CASE
        WHEN precio >= 1000 THEN 'ALTO'
        WHEN precio BETWEEN 500 AND 999 THEN 'MEDIO'
        ELSE 'BAJO'
    END AS rango_precio
FROM productos;

Explicación:
Dependiendo del valor de "precio", el CASE asigna un texto diferente.

==============================================================
3. USO DE CASE EN EL SELECT
--------------------------------------------------------------
CASE puede usarse dentro del SELECT para crear columnas calculadas o categorizadas.

Ejemplo:
--------------------------------------------------------------
-- Clasificar empleados según su salario
SELECT
    nombre,
    salario,
    CASE
        WHEN salario >= 5000 THEN 'ALTO'
        WHEN salario >= 3000 THEN 'MEDIO'
        ELSE 'BAJO'
    END AS categoria_salario
FROM empleados;

==============================================================
4. USO DE CASE EN EL ORDER BY
--------------------------------------------------------------
Puedes usar CASE en la cláusula ORDER BY para personalizar el orden.

Ejemplo:
--------------------------------------------------------------
-- Ordenar productos por categoría de precio (de mayor a menor)
SELECT nombre_producto, precio
FROM productos
ORDER BY
    CASE
        WHEN precio >= 1000 THEN 1
        WHEN precio BETWEEN 500 AND 999 THEN 2
        ELSE 3
    END;

Explicación:
Los precios altos se muestran primero, seguidos de los medios y bajos.

==============================================================
5. USO DE CASE EN EL WHERE
--------------------------------------------------------------
Aunque menos común, también puedes usar CASE dentro del WHERE,
pero suele ser más claro combinarlo con operadores lógicos.

Ejemplo:
--------------------------------------------------------------
-- Mostrar solo los productos con un rango específico
SELECT *
FROM productos
WHERE
    CASE
        WHEN precio >= 1000 THEN 1
        ELSE 0
    END = 1;

==============================================================
6. USO DE CASE CON FUNCIONES DE AGREGACIÓN
--------------------------------------------------------------
Puedes usar CASE para aplicar condiciones dentro de funciones agregadas
como COUNT, SUM o AVG.

Ejemplo:
--------------------------------------------------------------
-- Contar cuántos productos son caros, medios y baratos
SELECT
    SUM(CASE WHEN precio >= 1000 THEN 1 ELSE 0 END) AS total_caros,
    SUM(CASE WHEN precio BETWEEN 500 AND 999 THEN 1 ELSE 0 END) AS total_medios,
    SUM(CASE WHEN precio < 500 THEN 1 ELSE 0 END) AS total_baratos
FROM productos;

==============================================================
7. CASE ANIDADO (NESTED CASE)
--------------------------------------------------------------
Puedes anidar varios CASE dentro de otros para crear condiciones más complejas.

Ejemplo:
--------------------------------------------------------------
-- Clasificar productos según precio y stock
SELECT
    nombre_producto,
    precio,
    stock,
    CASE
        WHEN precio > 1000 THEN
            CASE
                WHEN stock > 50 THEN 'ALTO PRECIO - ALTO STOCK'
                ELSE 'ALTO PRECIO - BAJO STOCK'
            END
        ELSE
            CASE
                WHEN stock > 50 THEN 'PRECIO BAJO - ALTO STOCK'
                ELSE 'PRECIO BAJO - BAJO STOCK'
            END
    END AS clasificacion
FROM productos;

==============================================================
8. USO DE CASE EN GROUP BY Y HAVING
--------------------------------------------------------------
También puedes incluir CASE en columnas agrupadas o filtros de grupos.

Ejemplo:
--------------------------------------------------------------
-- Total de ventas por tipo de cliente
SELECT
    CASE
        WHEN tipo_cliente = 'VIP' THEN 'Cliente VIP'
        ELSE 'Cliente Regular'
    END AS tipo,
    SUM(total) AS total_ventas
FROM ventas
GROUP BY
    CASE
        WHEN tipo_cliente = 'VIP' THEN 'Cliente VIP'
        ELSE 'Cliente Regular'
    END;

==============================================================
9. CASE CON VALORES NUMÉRICOS O TEXTO
--------------------------------------------------------------
CASE puede devolver números, texto, fechas, o incluso resultados calculados.

Ejemplo:
--------------------------------------------------------------
-- Aplicar un descuento según el precio
SELECT
    nombre_producto,
    precio,
    CASE
        WHEN precio > 2000 THEN precio * 0.9
        WHEN precio BETWEEN 1000 AND 2000 THEN precio * 0.95
        ELSE precio
    END AS precio_con_descuento
FROM productos;

==============================================================
10. DIFERENCIA ENTRE SIMPLE Y SEARCHED CASE
--------------------------------------------------------------
Existen dos tipos de CASE:

A. SIMPLE CASE → compara una columna con varios valores.
B. SEARCHED CASE → usa condiciones lógicas con operadores.

Ejemplo SIMPLE CASE:
--------------------------------------------------------------
SELECT
    estado_pedido,
    CASE estado_pedido
        WHEN 'P' THEN 'Pendiente'
        WHEN 'E' THEN 'Enviado'
        WHEN 'C' THEN 'Cancelado'
        ELSE 'Desconocido'
    END AS descripcion_estado
FROM pedidos;

Ejemplo SEARCHED CASE:
--------------------------------------------------------------
SELECT
    estado_pedido,
    CASE
        WHEN estado_pedido = 'P' THEN 'Pendiente'
        WHEN estado_pedido = 'E' THEN 'Enviado'
        WHEN estado_pedido = 'C' THEN 'Cancelado'
        ELSE 'Desconocido'
    END AS descripcion_estado
FROM pedidos;

==============================================================
11. BUENAS PRÁCTICAS
--------------------------------------------------------------
1. Usa alias claros para las columnas generadas por CASE.
2. Siempre incluye un ELSE para evitar valores NULL inesperados.
3. No anides demasiados CASE para mantener la legibilidad.
4. Úsalo para lógica condicional simple dentro de consultas.
5. Si la lógica se vuelve compleja, considera una tabla auxiliar.

==============================================================
12. RESUMEN GENERAL
==============================================================
• CASE permite lógica condicional dentro de consultas SQL.
• Puede usarse en SELECT, ORDER BY, WHERE, GROUP BY y HAVING.
• Dos tipos: SIMPLE CASE y SEARCHED CASE.
• Permite devolver texto, números, cálculos o alias.
• Es ideal para clasificar, etiquetar y transformar datos.
• Siempre es recomendable usar ELSE para mayor seguridad.
==============================================================
*/

-- Obtiene todos los datos de la tabla "users" y establece condiciones de visualización de cadenas de texto según el valor de la edad 
SELECT *,
CASE 
	WHEN age > 18 THEN 'Es mayor de edad'
    WHEN age = 18 THEN 'Acaba de cumplir la mayoría de edad'
    ELSE 'Es menor de edad'
END AS '¿Es mayor de edad?'
FROM users;

-- Obtiene todos los datos de la tabla "users" y establece condiciones de visualización de valores booleanos según el valor de la edad 
SELECT *,
CASE 
	WHEN age > 17 THEN True
    ELSE False
END AS '¿Es mayor de edad?'
FROM users;