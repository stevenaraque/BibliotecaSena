# Sistema de Gestión de Biblioteca - SENA

Sistema web desarrollado en Java con arquitectura MVC para gestionar
préstamos de libros, usuarios y multas de una biblioteca universitaria.
Proyecto formativo del programa Tecnólogo en Análisis y Desarrollo de
Software - SENA Regional Boyacá.

---

## Tecnologías usadas

- Java EE (Servlets, JSP, JSTL)
- MySQL 8
- Apache Tomcat 9
- Bootstrap 5.3.3
- JDBC
- NetBeans IDE
- Maven

---

## Requisitos previos

Antes de correr el proyecto necesitas tener instalado:

- JDK 11 o superior
- Apache Tomcat 9
- MySQL Server 8
- MySQL Workbench
- NetBeans IDE

---

## Configuración de la base de datos

1. Abre MySQL Workbench
2. Ejecuta el archivo `biblioteca_db_completa.sql` que está en la raíz del repositorio
3. Esto crea la base de datos `biblioteca_db` con todas las tablas y datos de prueba

Verifica que los datos de conexión en `ConexionDB.java` coincidan con tu instalación:
```java
private static final String URL  = "jdbc:mysql://localhost:3306/biblioteca_db";
private static final String USER = "root";
private static final String PASS = "tu_contraseña";
```

---

## Como correr el proyecto

1. Clona el repositorio:
```bash
git clone https://github.com/stevenaraque/BibliotecaSena.git
```

2. Abre el proyecto en NetBeans:
   - File, Open Project, selecciona la carpeta `biblioteca-web`

3. Configura Tomcat en NetBeans:
   - Tools, Servers, Add Server, Apache Tomcat 9

4. Ejecuta el proyecto con clic derecho sobre el proyecto y Run

5. Abre el navegador en: http://localhost:8080/biblioteca-web/login

---

## Usuarios de prueba

| Tipo    | Email                          | Contrasena |
|---------|--------------------------------|------------|
| Admin   | monica.suarez@urb.edu.co       | admin123   |
| Admin   | hernando.medina@urb.edu.co     | admin123   |
| Usuario | carlos.rodriguez@urb.edu.co    | 1234       |
| Usuario | maria.gonzalez@urb.edu.co      | 1234       |

Los usuarios de tipo administrativo ingresan como administradores.
Los estudiantes y docentes ingresan como usuarios normales.

