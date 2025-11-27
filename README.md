Portafolio de Bases de Datos (M3)

Este repositorio actúa como el portafolio principal (Módulo 3) que agrupa y organiza diferentes proyectos de bases de datos, diagramas y archivos de configuración relacionados.

📁 Estructura del Proyecto

El portafolio está organizado principalmente a través de Git en el repositorio https://github.com/NataliaYC/ecommerce-db-m3.git
 
 
 Objetivo de la Base de Datos

El propósito principal de este esquema es gestionar la información central de una plataforma de e-commerce, incluyendo:

 Inventario: Seguimiento de productos, categorias y stock.
 Clientes: Almacenamiento seguro de datos de usuario.
 Pedidos: Registro de transacciones, detalles de líneas de pedido y estado de envío.
 Relaciones: Conexión entre productos, clientes y sus pedidos.
 Archivos Clave del Proyecto

La estructura del repositorio está organizada en tres archivos SQL principales, siguiendo un flujo de trabajo estándar de desarrollo de bases de datos:

1. schema.sql (La Estructura)

Este archivo contiene todas las sentencias DDL (Data Definition Language) para construir la base de datos desde cero.
  Define la creación de todas las tablas (CREATE TABLE).
  Establece las claves primarias y claves foráneas para garantizar la integridad referencial.
  Incluye la definición de índices para optimizar el rendimiento de las consultas.

2. seed.sql (Los Datos de Prueba)

Este archivo utiliza sentencias DML (Data Manipulation Language) y es fundamental para probar la funcionalidad de la aplicación.
   
   Contiene comandos INSERT para poblar las tablas con datos de ejemplo (productos, usuarios, pedidos simulados).

3. queries.sql (La Lógica del Negocio)

Este archivo es un conjunto de consultas SQL predefinidas que resuelven las preguntas típicas de negocio.


Base De Datos Creada por Natalia Yañez Correa, para completar portafolio de datos para Bootcamp Desarrollador Full stack Java Trainee.

   Incluye consultas SELECT complejas para obtener el ranking de productos más vendidos, el gasto total por cliente, o la distribución de pedidos por estado.
   Puede contener vistas o funciones.


ESTA BASE DE DATOS ESTA CREADA POR NATALIA YAÑEZ CORREA PARA EL BOOTCAM DESARROLLADOR FULL STACK JAVA PARA SER PRESENTADO COMO PORTAFOLIO DE BASE DE DATOS PARA UN ECOMMERCE COMO COMPLEMENTO EDUCATIVO Y DE APRENDIZAJE.
