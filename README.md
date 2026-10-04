# empresa-retail-admin

## Descripción

Este proyecto implementa un sistema de **seguridad y control de acceso** para la base de datos `empresa-retail-db`, utilizando usuarios y roles de MySQL para separar las responsabilidades de las áreas de **Cajas, Inventario y Gerencia**.

La solución aplica el principio de **mínimo privilegio**, asignando a cada usuario únicamente los permisos necesarios para realizar las operaciones correspondientes a su función.

## Objetivo

Configurar una estructura de usuarios y roles que permita:

* Separar las responsabilidades de las diferentes áreas.
* Controlar el acceso a las tablas de la base de datos.
* Evitar modificaciones o consultas no autorizadas.
* Aplicar permisos específicos mediante roles.
* Verificar mediante pruebas que los permisos asignados funcionan correctamente.

## Estructura de roles

### Cajas

Rol:

```text
rol_cajas
```

Usuario:

```text
ana_crm
```

Permisos:

* `SELECT` sobre `cliente`.
* `SELECT` e `INSERT` sobre `conversion`.

### Inventario

Rol:

```text
rol_inventario
```

Usuario:

```text
pedro_mkt
```

Permisos:

* `SELECT` sobre `campania`.
* `SELECT` sobre `canal`.
* `SELECT` sobre `interaccion`.

### Gerencia

Rol:

```text
rol_gerencia
```

Usuario:

```text
marta_auditoria
```

Permisos:

* `SELECT`
* `INSERT`
* `UPDATE`
* `DELETE`

sobre las tablas:

* `campania`
* `canal`
* `cliente`
* `conversion`
* `interaccion`

## Estructura del proyecto

```text
empresa-retail-admin/
├── .gitignore
├── README.md
├── docs/
└── sql/
    ├── 01_roles.sql
    ├── 02_permisos.sql
    └── 03_usuarios.sql
```

## Scripts SQL

### `01_roles.sql`

Crea los roles de seguridad:

* `rol_cajas`
* `rol_inventario`
* `rol_gerencia`

### `02_permisos.sql`

Asigna los permisos correspondientes a cada rol sobre las tablas de la base de datos.

### `03_usuarios.sql`

Crea los usuarios, asigna cada usuario a su respectivo rol y configura el rol como predeterminado.

## Pruebas de seguridad

La configuración fue validada mediante pruebas de acceso con los tres usuarios.

Entre las pruebas realizadas se verificó que:

* `ana_crm` puede consultar clientes y registrar conversiones, pero no puede modificar conversiones ni consultar campañas.
* `pedro_mkt` puede consultar campañas, canales e interacciones, pero no puede consultar clientes ni modificar información.
* `marta_auditoria` puede consultar, insertar, modificar y eliminar información de las tablas asignadas a Gerencia.

Estas pruebas permiten comprobar que los permisos se aplican de acuerdo con las responsabilidades definidas.

## Rama de desarrollo

La solución se desarrolla en la rama:

```text
develop
```

La rama `main` contiene la versión inicial del repositorio, mientras que `develop` contiene la implementación de seguridad de la base de datos.

## Tecnologías

* MySQL 8.0
* SQL
* Git
* GitHub

## Principio de seguridad aplicado

El proyecto aplica el principio de **mínimo privilegio (Least Privilege)**, mediante el cual cada usuario recibe únicamente los permisos necesarios para desempeñar sus funciones dentro del sistema.

Esto reduce el riesgo de accesos indebidos, modificaciones accidentales y exposición innecesaria de información.
