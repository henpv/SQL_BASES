/*
==============================================================
SECCIÓN 16: FUNCIÓN CONCAT() EN SQL
==============================================================

1. ¿Qué es CONCAT()?
--------------------------------------------------------------
La función CONCAT() en SQL se utiliza para **unir (concatenar)**
dos o más valores de texto en un solo resultado.

Es muy útil cuando quieres combinar nombres, etiquetas,
mensajes o construir cadenas dinámicas directamente desde la consulta.

==============================================================
2. ESTRUCTURA BÁSICA
==============================================================
SELECT CONCAT(valor1, valor2, valor3, ...) AS nuevo_nombre
FROM tabla;

Ejemplo:
--------------------------------------------------------------
-- Unir nombre y apellido en una sola columna
SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo
FROM empleados;

Explicación:
Une el valor de la columna "nombre", un espacio y la columna "apellido"
en una sola cadena llamada "nombre_completo".

==============================================================
3. CONCATENAR TEXTO ESTÁTICO Y COLUMNAS
==============================================================
Puedes combinar texto fijo con valores de columnas.

Ejemplo:
--------------------------------------------------------------
-- Mostrar un mensaje descriptivo
SELECT CONCAT('El cliente ', nombre, ' tiene un saldo de $', saldo) AS mensaje
FROM clientes;

Resultado ejemplo:
El cliente Carlos tiene un saldo de $150000.

==============================================================
4. CONCAT CON VALORES NUMÉRICOS O FECHAS
--------------------------------------------------------------
Si alguno de los valores no es texto (por ejemplo, un número o fecha),
SQL lo convierte automáticamente en cadena antes de concatenarlo.

Ejemplo:
--------------------------------------------------------------
SELECT CONCAT('Producto #', id_producto, ' - Precio: $', precio) AS info_producto
FROM productos;

==============================================================
5. CONCAT Y NULL
--------------------------------------------------------------
IMPORTANTE: Si alguno de los valores dentro de CONCAT() es NULL,
el resultado completo será NULL.

Ejemplo:
--------------------------------------------------------------
SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo
FROM empleados;

-- Si "apellido" es NULL → El resultado será NULL.

Solución:
Usar **CONCAT_WS()** o **IFNULL()**.

==============================================================
6. CONCAT_WS() (CON SEPARADOR)
--------------------------------------------------------------
La función CONCAT_WS(separador, valor1, valor2, ...) concatena
valores usando un separador definido y **omite valores NULL**.

Ejemplo:
--------------------------------------------------------------
-- Unir nombre y apellido con espacio, ignorando NULL
SELECT CONCAT_WS(' ', nombre, apellido) AS nombre_completo
FROM empleados;

Explicación:
Si "apellido" es NULL, igualmente mostrará el nombre sin devolver NULL.

==============================================================
7. USO EN CONSULTAS MÁS COMPLEJAS
--------------------------------------------------------------
Puedes usar CONCAT() para generar información dinámica o formatear resultados.

Ejemplos:
--------------------------------------------------------------
-- Combinar columnas y texto para generar etiquetas
SELECT CONCAT('ID: ', id_cliente, ' - ', nombre, ' (', ciudad, ')') AS etiqueta
FROM clientes;

-- Mostrar descripción detallada de producto
SELECT CONCAT(nombre, ' - $', FORMAT(precio, 2), ' | Stock: ', stock) AS descripcion
FROM productos;

==============================================================
8. CONCAT EN CONSULTAS CON JOIN
--------------------------------------------------------------
También se puede usar CONCAT en consultas que combinan tablas.

Ejemplo:
--------------------------------------------------------------
SELECT CONCAT(c.nombre, ' compró ', p.nombre, ' por $', v.total) AS detalle_compra
FROM ventas AS v
JOIN clientes AS c ON v.id_cliente = c.id_cliente
JOIN productos AS p ON v.id_producto = p.id_producto;

Resultado ejemplo:
"María compró Laptop por $3500"

==============================================================
9. CONCAT Y ORDEN DE PARÁMETROS
--------------------------------------------------------------
El orden en que se pasen los valores dentro de CONCAT()
determina cómo aparecerán en el resultado final.

Ejemplo:
--------------------------------------------------------------
SELECT CONCAT(ciudad, ', ', pais) AS ubicacion
FROM sucursales;

Resultado ejemplo:
“Bogotá, Colombia” y no “Colombia, Bogotá”.

==============================================================
10. BUENAS PRÁCTICAS
--------------------------------------------------------------
1. Usa CONCAT_WS() cuando haya posibilidad de valores NULL.
2. Evita concatenar demasiadas columnas (impacta el rendimiento).
3. Usa FORMAT() o ROUND() para números antes de concatenar.
4. No uses CONCAT() para cálculos o comparaciones lógicas.
5. Asegúrate de que los datos tengan el tipo de codificación adecuado (UTF-8).
6. Usa alias claros para resultados concatenados.

==============================================================
11. RESUMEN GENERAL
==============================================================
CONCAT(a, b, c)           -> Une los valores especificados.
CONCAT_WS('sep', a, b, c) -> Une valores con separador y omite NULL.
INCLUYE NULL               -> CONCAT sí, CONCAT_WS no.
USO FRECUENTE              -> Unir nombres, direcciones, etiquetas.
ORDEN DE PARÁMETROS        -> Afecta el resultado.
MEJOR PRÁCTICA             -> CONCAT_WS() si hay posibilidad de NULL.
EJEMPLO CLAVE              -> CONCAT(nombre, ' ', apellido) AS nombre_completo.
==============================================================
*/

-- Concatena en una sola columa los campos nombre y apellido
SELECT CONCAT('Nombre: ', name, ', Apellidos: ', surname) FROM users;

-- Concatena en una sola columa los campos nombre y apellido y le establece el alias 'Nombre completo'
SELECT CONCAT('Nombre: ', name, ', Apellidos: ', surname) AS 'Nombre completo' FROM users