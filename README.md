# SQL-analisis-datos-ventas
Este proyecto tiene como objetivo diseñar, construir y analizar una base de datos relacional utilizando SQL. Para ello se utilizó un dataset de ventas minoristas (supermercado) y se desarrolló un proceso completo que incluye:

* Modelado de datos y creación de tablas

* Proceso ETL para carga, limpieza y transformación de datos

* Análisis exploratorio mediante consultas SQL

* Generación de métricas clave para el negocio

Buscando demostrar habilidades técnicas en SQL, buenas prácticas de modelado y capacidad analítica para extraer informacion relevante del negocio.

## Herramientas utilizadas
- MySQL 8
- VS Code + SQLTools
- Git & GitHub
- Archivos CSV como fuente de datos

## Origen y modelado de datos
Los datos utilizados en este proyecto provienen de "Datasets para Proyecto BI - Análisis de Ventas", disponible en Kaggle en formato CSV, públicamente en el siguiente enlace:
https://www.kaggle.com/datasets/dataregina/datasets-para-proyecto-bi

El dataset incluye información de:
- Clientes
- Productos
- Categorías
- Ventas
- Métodos de pago

A partir de estos datos se construyó un modelo relacional que incluye las siguientes tablas y relaciones:
- Clientes
- Producto
- Categorias
- Metodo_pago
- Ventas

Con relaciones que garantizan integridad y trazabilidad:
```
- Ventas.ID_Cliente → Clientes.ID_Cliente
- Ventas.ID_Producto → Producto.ID_Producto
- Producto.ID_Categoria → Categorias.ID_Categoria
- Ventas.Metodo_Pago → Metodo_pago.ID_Metodo
```

 # Detalle de tareas realizadas
Se desarrolló un flujo completo de análisis de datos de ventas utilizando SQL. Entre las principales tareas realizadas se incluyen:

1. Construcción de una base de datos relacional a partir de archivos CSV crudos.

2. Diseño de tablas y relaciones (claves primarias, claves foráneas e integridad referencial).

3. Implementación de un proceso ETL: carga de datos, limpieza, normalización y validación.

4. Análisis exploratorio de los datos para descubrir patrones y comportamientos relevantes.

5. Cálculo de métricas y KPIs clave para retail, como revenue, ticket promedio y top productos vendidos.

6. Documentación detallada de todo el flujo de trabajo para que sirva como ejemplo profesional de análisis de datos.

