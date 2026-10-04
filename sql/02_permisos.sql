-- =========================================================
-- PROYECTO: Empresa Retail
-- Archivo: 02_permisos.sql
-- Descripción: Asignación de permisos a los roles
-- =========================================================

USE `empresa-retail-db`;

-- ROL CAJAS

GRANT SELECT ON `empresa-retail-db`.cliente
TO 'rol_cajas';

GRANT SELECT, INSERT ON `empresa-retail-db`.conversion
TO 'rol_cajas';


-- ROL INVENTARIO

GRANT SELECT ON `empresa-retail-db`.campania
TO 'rol_inventario';

GRANT SELECT ON `empresa-retail-db`.canal
TO 'rol_inventario';

GRANT SELECT ON `empresa-retail-db`.interaccion
TO 'rol_inventario';


-- ROL GERENCIA

GRANT SELECT, INSERT, UPDATE, DELETE
ON `empresa-retail-db`.campania
TO 'rol_gerencia';

GRANT SELECT, INSERT, UPDATE, DELETE
ON `empresa-retail-db`.canal
TO 'rol_gerencia';

GRANT SELECT, INSERT, UPDATE, DELETE
ON `empresa-retail-db`.cliente
TO 'rol_gerencia';

GRANT SELECT, INSERT, UPDATE, DELETE
ON `empresa-retail-db`.conversion
TO 'rol_gerencia';

GRANT SELECT, INSERT, UPDATE, DELETE
ON `empresa-retail-db`.interaccion
TO 'rol_gerencia';
