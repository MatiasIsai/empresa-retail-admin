# FUNDACIÓN UNIVERSITARIA DE POPAYÁN

## EMPRESA RETAIL

### IMPLEMENTACIÓN DE SEGURIDAD Y CONTROL DE ACCESO EN BASE DE DATOS MYSQL

**Documento técnico**

**Asignatura:** Administración de Bases de Datos

**Estudiantes:**

* Matias Isai Martinez
* Juan Andres Espinosa Grijalba

**Docente:** Luis Vejarano

**Institución:** Fundación Universitaria de Popayán

**Base de datos:** `empresa-retail-db`

**Repositorio:** `empresa-retail-admin`

**Rama de desarrollo:** `develop`

**Ciudad:** Popayán, Cauca

**Fecha:** Octubre de 2026

---

# Tabla de contenido

1. Introducción
2. Desarrollo
   2.1. Descripción de la solución
   2.2. Estructura de la base de datos
   2.3. Estructura de roles
   2.4. Creación de roles
   2.5. Asignación de permisos
   2.6. Creación de usuarios
   2.7. Asignación de roles a usuarios
   2.8. Pruebas de seguridad
   2.9. Estructura del repositorio
   2.10. Control de versiones
3. Conclusiones
4. Referencias

---

# 1. Introducción

La seguridad de las bases de datos es un aspecto fundamental para garantizar la confidencialidad, integridad y disponibilidad de la información almacenada en una organización. Una adecuada administración de usuarios y permisos permite controlar qué operaciones puede realizar cada persona de acuerdo con sus responsabilidades, reduciendo el riesgo de accesos no autorizados, modificaciones accidentales y pérdida de información.

En el presente proyecto se implementa un esquema de seguridad y control de acceso para la base de datos `empresa-retail-db`, utilizando el sistema gestor de bases de datos MySQL. La solución se basa en la creación de roles y usuarios, permitiendo separar las responsabilidades correspondientes a las áreas de Cajas, Inventario y Gerencia.

Para la implementación se aplica el principio de mínimo privilegio, mediante el cual cada usuario recibe únicamente los permisos necesarios para desarrollar las actividades asociadas a su función. De esta manera, se evita otorgar privilegios innecesarios sobre información que no corresponde a sus responsabilidades.

El proyecto también contempla la validación de los permisos mediante diferentes pruebas de acceso, consulta, inserción, actualización y eliminación de información. Estas pruebas permiten comprobar que cada usuario puede realizar las operaciones autorizadas y que las operaciones no permitidas son rechazadas por el sistema gestor de bases de datos.

Finalmente, la solución desarrollada se organiza mediante un repositorio de GitHub denominado `empresa-retail-admin`, utilizando la rama `develop` para almacenar los scripts SQL y la documentación correspondiente a la implementación de seguridad.

---

# 2. Desarrollo

## 2.1. Descripción de la solución

La solución implementada tiene como objetivo establecer un mecanismo de control de acceso para los usuarios que interactúan con la base de datos `empresa-retail-db`.

Para lograrlo se utilizaron los mecanismos de seguridad proporcionados por MySQL, específicamente:

* Usuarios.
* Roles.
* Privilegios.
* Asignación de roles.
* Roles predeterminados.
* Pruebas de autorización.

La estructura permite asociar cada usuario con un rol determinado y administrar los permisos desde el rol en lugar de asignarlos directamente a cada usuario.

Esta estrategia facilita la administración de la seguridad, ya que los permisos pueden modificarse directamente sobre los roles y posteriormente aplicarse a los usuarios que pertenecen a ellos.

## 2.2. Estructura de la base de datos

La base de datos utilizada en el proyecto se denomina:

```text
empresa-retail-db
```

Debido a que el nombre contiene guiones, en las instrucciones SQL se utiliza entre comillas invertidas:

```sql
`empresa-retail-db`
```

La base de datos está compuesta por las siguientes tablas:

* `campania`
* `canal`
* `cliente`
* `conversion`
* `interaccion`

Estas tablas representan la información que será utilizada por las diferentes áreas de la organización.

La tabla `cliente` almacena información relacionada con los clientes.

La tabla `conversion` registra las conversiones realizadas por los clientes.

La tabla `campania` contiene información relacionada con las campañas.

La tabla `canal` almacena los diferentes canales utilizados para las campañas.

La tabla `interaccion` registra las interacciones realizadas entre clientes y campañas.

## 2.3. Estructura de roles

Se definieron tres roles de seguridad de acuerdo con las responsabilidades establecidas para el proyecto:

```text
rol_cajas
rol_inventario
rol_gerencia
```

Cada rol posee un conjunto específico de permisos.

### Rol de Cajas

El rol:

```text
rol_cajas
```

está destinado al usuario responsable de las operaciones relacionadas con Cajas.

Sus permisos son:

| Tabla      | SELECT | INSERT | UPDATE | DELETE |
| ---------- | ------ | ------ | ------ | ------ |
| cliente    | Sí     | No     | No     | No     |
| conversion | Sí     | Sí     | No     | No     |

Por lo tanto, este rol permite consultar información de clientes y registrar nuevas conversiones, pero no permite modificar o eliminar información.

### Rol de Inventario

El rol:

```text
rol_inventario
```

está destinado al usuario responsable de las operaciones relacionadas con Inventario.

Sus permisos son:

| Tabla       | SELECT | INSERT | UPDATE | DELETE |
| ----------- | ------ | ------ | ------ | ------ |
| campania    | Sí     | No     | No     | No     |
| canal       | Sí     | No     | No     | No     |
| interaccion | Sí     | No     | No     | No     |

Este rol permite consultar información relacionada con campañas, canales e interacciones, pero no permite modificar los datos.

### Rol de Gerencia

El rol:

```text
rol_gerencia
```

está destinado al área de Gerencia.

Este rol posee los siguientes permisos:

| Tabla       | SELECT | INSERT | UPDATE | DELETE |
| ----------- | ------ | ------ | ------ | ------ |
| campania    | Sí     | Sí     | Sí     | Sí     |
| canal       | Sí     | Sí     | Sí     | Sí     |
| cliente     | Sí     | Sí     | Sí     | Sí     |
| conversion  | Sí     | Sí     | Sí     | Sí     |
| interaccion | Sí     | Sí     | Sí     | Sí     |

Este nivel de acceso permite a Gerencia realizar las operaciones necesarias para administrar la información de la base de datos.

## 2.4. Creación de roles

La creación de los roles se realizó mediante el script:

```text
sql/01_roles.sql
```

El script elimina previamente los roles en caso de que existan y posteriormente crea los tres roles necesarios.

La estructura principal utilizada fue:

```sql
CREATE ROLE 'rol_cajas';
CREATE ROLE 'rol_inventario';
CREATE ROLE 'rol_gerencia';
```

Esta separación permite administrar los permisos de acuerdo con las responsabilidades de cada área.

## 2.5. Asignación de permisos

Los permisos fueron configurados mediante el script:

```text
sql/02_permisos.sql
```

Para el rol de Cajas se utilizaron permisos de consulta sobre `cliente` y permisos de consulta e inserción sobre `conversion`.

Para Inventario se asignaron permisos de consulta sobre `campania`, `canal` e `interaccion`.

Para Gerencia se asignaron permisos de consulta, inserción, actualización y eliminación sobre las cinco tablas de la base de datos.

La configuración utiliza instrucciones `GRANT`, mecanismo proporcionado por MySQL para otorgar privilegios a usuarios o roles.

Un ejemplo de la configuración utilizada es:

```sql
GRANT SELECT ON `empresa-retail-db`.cliente
TO 'rol_cajas';
```

Y para permitir el registro de conversiones:

```sql
GRANT SELECT, INSERT ON `empresa-retail-db`.conversion
TO 'rol_cajas';
```

De esta forma se evita otorgar permisos generales sobre toda la base de datos.

## 2.6. Creación de usuarios

Los usuarios fueron creados mediante el script:

```text
sql/03_usuarios.sql
```

Se crearon los siguientes usuarios:

| Usuario           | Área       | Rol              |
| ----------------- | ---------- | ---------------- |
| `ana_crm`         | Cajas      | `rol_cajas`      |
| `pedro_mkt`       | Inventario | `rol_inventario` |
| `marta_auditoria` | Gerencia   | `rol_gerencia`   |

Los usuarios fueron creados mediante la instrucción `CREATE USER`.

Por motivos de seguridad, las contraseñas utilizadas durante la implementación no se documentan en este documento técnico ni en el archivo README del repositorio.

## 2.7. Asignación de roles a usuarios

Después de crear los usuarios, se realizó la asignación de cada usuario a su respectivo rol.

La configuración utilizada fue:

```text
ana_crm            → rol_cajas
pedro_mkt          → rol_inventario
marta_auditoria    → rol_gerencia
```

También se configuraron los roles como roles predeterminados mediante `SET DEFAULT ROLE`.

Esto permite que el rol correspondiente se active automáticamente cuando el usuario inicia sesión en MySQL.

## 2.8. Pruebas de seguridad

Para verificar la correcta configuración de los permisos se realizaron pruebas de acceso utilizando los tres usuarios.

### Pruebas con `ana_crm`

Se verificó que el usuario pudiera consultar información de clientes:

```sql
SELECT * FROM cliente LIMIT 1;
```

La consulta fue ejecutada correctamente.

También se verificó que pudiera registrar una nueva conversión:

```sql
INSERT INTO conversion
(con_tipo, con_valor, con_fecha, cliente_cli_id_cliente)
VALUES
('compra', 150000, CURDATE(), 1);
```

La operación fue ejecutada correctamente.

Posteriormente se realizaron pruebas de operaciones no autorizadas.

Al intentar consultar la tabla `campania`, MySQL rechazó la operación indicando que el usuario no tenía permiso `SELECT`.

También se intentó realizar una actualización sobre `conversion`, obteniendo un error de autorización debido a que el rol no posee el privilegio `UPDATE`.

Por lo tanto, se comprobó que `ana_crm` posee únicamente los permisos correspondientes al área de Cajas.

### Pruebas con `pedro_mkt`

Se verificó que el usuario pudiera consultar las tablas correspondientes a Inventario:

```sql
SELECT * FROM campania LIMIT 1;

SELECT * FROM canal LIMIT 1;

SELECT * FROM interaccion LIMIT 1;
```

Las consultas fueron ejecutadas correctamente.

Posteriormente se intentó consultar la tabla `cliente`, operación que fue rechazada por MySQL debido a que el usuario no posee el privilegio `SELECT` sobre dicha tabla.

También se intentó modificar información de `campania` mediante una operación `UPDATE`.

La operación fue rechazada porque `rol_inventario` solamente posee permisos de consulta.

De esta manera se comprobó que el usuario `pedro_mkt` tiene acceso limitado a las operaciones correspondientes al área de Inventario.

### Pruebas con `marta_auditoria`

Finalmente se realizaron pruebas con el usuario de Gerencia.

Se verificó que pudiera consultar información:

```sql
SELECT * FROM cliente LIMIT 1;
```

La consulta fue ejecutada correctamente.

También se verificó la capacidad de actualizar información mediante:

```sql
UPDATE cliente
SET cli_ciudad = 'Popayan'
WHERE cli_id_cliente = 1;
```

La operación fue ejecutada correctamente.

Adicionalmente se realizó una prueba de inserción de un cliente y posteriormente se eliminó el registro de prueba.

Las operaciones fueron ejecutadas correctamente, demostrando que el rol de Gerencia posee los privilegios `SELECT`, `INSERT`, `UPDATE` y `DELETE` establecidos en la configuración.

## 2.9. Estructura del repositorio

El proyecto fue organizado utilizando un repositorio de GitHub denominado:

```text
empresa-retail-admin
```

La estructura principal es:

```text
empresa-retail-admin/
├── .gitignore
├── README.md
├── docs/
│   └── documento_tecnico.md
├── sql/
│   ├── 01_roles.sql
│   ├── 02_permisos.sql
│   └── 03_usuarios.sql
└── .git/
```

La carpeta `sql` contiene los scripts utilizados para implementar la seguridad.

La carpeta `docs` contiene la documentación técnica del proyecto.

El archivo `README.md` contiene la descripción general, objetivos, estructura de roles, permisos, tecnologías utilizadas y principio de seguridad aplicado.

El archivo `.gitignore` permite evitar el almacenamiento de archivos temporales relacionados con SQL.

## 2.10. Control de versiones

Para administrar el proyecto se utilizó Git junto con GitHub.

Se establecieron dos ramas principales:

```text
main
develop
```

La rama `main` conserva la versión inicial del repositorio.

La implementación de la solución se realizó en la rama:

```text
develop
```

Durante el desarrollo se realizaron diferentes commits para registrar los cambios efectuados.

Entre los commits principales se encuentran:

```text
b0d931c  Initial commit
88b2e4c  Se implemento seguridad y gestion de usuario en la base de datos empresa retail db
dbd54b8  Se Actualizar README del proyecto
```

Finalmente, la rama `develop` fue sincronizada con el repositorio remoto `origin/develop`.

---

# 3. Conclusiones

La implementación realizada permitió establecer un sistema básico de seguridad y control de acceso para la base de datos `empresa-retail-db` utilizando usuarios y roles de MySQL.

La utilización de roles permitió separar las responsabilidades de las áreas de Cajas, Inventario y Gerencia, evitando asignar directamente los mismos permisos a todos los usuarios.

Las pruebas realizadas demostraron que los usuarios pueden ejecutar las operaciones correspondientes a sus funciones y que las operaciones no autorizadas son rechazadas por el sistema gestor de bases de datos.

La aplicación del principio de mínimo privilegio permite reducir los riesgos asociados con accesos innecesarios y modificaciones no autorizadas de la información.

El uso de Git y GitHub permitió organizar los scripts SQL y la documentación, además de mantener un historial de cambios mediante commits y ramas de desarrollo.

Como resultado, se obtuvo una estructura de seguridad funcional que puede ampliarse posteriormente mediante políticas adicionales, auditoría de operaciones, gestión de contraseñas, cifrado y mecanismos de monitoreo.

---

# 4. Referencias

Oracle. (s. f.). *MySQL 8.0 Reference Manual*. MySQL. https://dev.mysql.com/doc/refman/8.0/en/

Git. (s. f.). *Git documentation*. https://git-scm.com/doc

GitHub. (s. f.). *GitHub documentation*. https://docs.github.com/

Oracle. (s. f.). *MySQL 8.0 Reference Manual: Access control and account management*. MySQL. https://dev.mysql.com/doc/refman/8.0/en/access-control.html

Oracle. (s. f.). *MySQL 8.0 Reference Manual: Roles*. MySQL. https://dev.mysql.com/doc/refman/8.0/en/roles.html
