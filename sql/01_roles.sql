-- =========================================================
-- PROYECTO: Empresa Retail
-- Archivo: 01_roles.sql
-- Descripción: Creación de roles de seguridad
-- =========================================================

USE `empresa-retail-db`;

-- Eliminar roles si ya existen
DROP ROLE IF EXISTS 'rol_cajas';
DROP ROLE IF EXISTS 'rol_inventario';
DROP ROLE IF EXISTS 'rol_gerencia';

-- Crear roles
CREATE ROLE 'rol_cajas';
CREATE ROLE 'rol_inventario';
CREATE ROLE 'rol_gerencia';
