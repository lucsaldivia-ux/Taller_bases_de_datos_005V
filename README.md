# 🗄️ Guía Práctica de Bases de Datos Relacionales & PL/SQL

![SQL](https://img.shields.io/badge/Language-SQL-blue)
![PL/SQL](https://img.shields.io/badge/Language-PL%2FSQL-orange)
![Status](https://img.shields.io/badge/Status-En_Desarrollo-brightgreen)

Repositorio personal de apuntes, ejercicios prácticos y guías conceptuales sobre diseño, administración y consulta de Bases de Datos Relacionales.

---

## 📚 Contenido del Repositorio

El material está organizado de manera progresiva, abarcando desde conceptos fundamentales hasta programación en base de datos:

### 1. Consultas y Manipulación de Datos (SQL)
- **Operaciones DDL y DML:** Creación de tablas, inserción, actualización y borrado de datos.
- **Combinación de Tablas (Joins):** `INNER JOIN`, `LEFT/RIGHT JOIN`, `FULL OUTER JOIN` y subconsultas.
- **Funciones de Agregación:** `GROUP BY`, `HAVING`, `COUNT`, `SUM`, `AVG`.

### 2. Programación en Base de Datos (PL/SQL)
- **Bloques Anónimos:** Estructura básica, declaración de variables y control de flujo (`IF`, `CASE`, bucles).
- **Manejo de Excepciones:** Tratamiento de errores predefinidos y excepciones personalizadas (`RAISE_APPLICATION_ERROR`).
- **Procedimientos Almacenados y Funciones:** Automatización de lógica de negocio dentro del motor de base de datos.
- **Cursores y Triggers:** Procesamiento de conjuntos de datos registro a registro y disparadores automáticos.

### 3. Conectividad
- **Conectores:** Integración y conexión de la base de datos con aplicaciones externas (drivers/conectores).

---

## 📁 Estructura del Repositorio

```text
├── 01-sql-basico/           # Sentencias DDL y DML fundamentales
├── 02-joins-y-subconsultas/ # Ejercicios de combinación de tablas
├── 03-plsql/                # Bloques, procedimientos, funciones y excepciones
├── 04-conectores/           # Ejemplos de conexión con lenguajes de programación
└── README.md                # Documentación principal
