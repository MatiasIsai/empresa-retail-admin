-- =========================================================
-- PROYECTO: Empresa Retail
-- Archivo: 03_usuarios.sql
-- Descripción: Creación de usuarios y asignación de roles
-- =========================================================

USE `empresa-retail-db`;

-- =========================================================
-- CREACIÓN DE USUARIOS
-- =========================================================

DROP USER IF EXISTS 'ana_crm'@'localhost';
DROP USER IF EXISTS 'pedro_mkt'@'localhost';
DROP USER IF EXISTS 'marta_auditoria'@'localhost';

CREATE USER 'ana_crm'@'localhost'
IDENTIFIED BY 'Retail2026!Caja';

CREATE USER 'pedro_mkt'@'localhost'
IDENTIFIED BY 'Retail2026!Stock';

CREATE USER 'marta_auditoria'@'localhost'
IDENTIFIED BY 'Retail2026!Admin';


-- =========================================================
-- ASIGNACIÓN DE ROLES
-- =========================================================

GRANT 'rol_cajas' TO 'ana_crm'@'localhost';

GRANT 'rol_inventario' TO 'pedro_mkt'@'localhost';

GRANT 'rol_gerencia' TO 'marta_auditoria'@'localhost';


-- =========================================================
-- ACTIVAR LOS ROLES POR DEFECTO
-- =========================================================

SET DEFAULT ROLE 'rol_cajas'
TO 'ana_crm'@'localhost';

SET DEFAULT ROLE 'rol_inventario'
TO 'pedro_mkt'@'localhost';

SET DEFAULT ROLE 'rol_gerencia'
TO 'marta_auditoria'@'localhost';
