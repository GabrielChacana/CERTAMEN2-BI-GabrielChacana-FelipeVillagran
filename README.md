# CERTAMEN2-BI-GabrielChacana-FelipeVillagran

## Caso seleccionado
Caso 3: KentFoods

## Integrantes y Paralelo
- Gabriel Chacana
- Felipe Villagran
- Paralelo 300

## Descripción del problema
KentFoods es una empresa de venta de alimentos por envíos que ha experimentado un rápido crecimiento durante los últimos años. Debido a esto, la administración requiere incorporar Inteligencia de Negocios para apoyar la toma de decisiones estratégicas mediante el análisis consolidado de sus datos operacionales.

## Objetivo del proyecto
Desarrollar una solución integral de Inteligencia de Negocios que permita centralizar y analizar datos de ventas, clientes, empleados, productos y despachos, facilitando el proceso de toma de decisiones a través de un modelo dimensional en estrella (Star Schema) y procesos de extracción, transformación y carga (ETL).

## KPI definidos
1. **Ingresos Totales por Ventas:** Evalúa el desempeño financiero del negocio midiendo el monto real neto generado en las transacciones.  
   $$\text{MontoConDescuento} = \text{Cantidad} \times \text{PrecioUnitario} \times (1 - \text{Descuento})$$
2. **Cantidad Total de Productos Vendidos:** Mide el volumen de movimiento de inventario para identificar productos con mayor rotación y apoyar la gestión de abastecimiento.
3. **Promedio de Días de Envío:** Mide la eficiencia logística evaluando el tiempo promedio transcurrido entre la fecha de generación de la orden y su despacho efectivo ($\text{FechaEnvio} - \text{FechaOrden}$).

---

## Modelo Dimensional

### 1. Proceso de Negocio
Gestión de Ventas y Despacho de Pedidos.

### 2. Granularidad
Un registro en la tabla de hechos `FactVentas` representa **una línea individual de detalle de una orden de compra** (nivel de detalle más atómico basado en el ítem de la orden: `OrdenID` + `ProductoID`).

### 3. Dimensiones
- **`DimTiempo`**: Permite analizar las ventas por fecha de orden y fecha de envío (Año, Semestre, Trimestre, Mes, Nombre de Mes, Día).
- **`DimCliente`**: Datos descriptivos del cliente (`ClienteID`, Empresa, Contacto, Cargo, Ciudad, País).
- **`DimProducto`**: Información desnormalizada del producto (`ProductoID`, Nombre, Categoría, Proveedor, Cantidad por Unidad, Precio Unitario).
- **`DimEmpleado`**: Información del trabajador que gestionó la venta (`EmpleadoID`, Nombre Completo, Cargo, Ciudad, País).
- **`DimTransportista`**: Datos de la empresa de transporte a cargo del despacho (`TransportistaID`, Nombre, Teléfono).

### 4. Tabla de Hechos y Medidas
- **Tabla:** `FactVentas`
- **Claves:** `ClienteKey`, `ProductoKey`, `EmpleadoKey`, `TransportistaKey`, `FechaOrdenKey`, `FechaEnvioKey`.
- **Medidas:** `PrecioUnitario`, `Cantidad`, `Descuento`, `MontoVenta` (calculada: Cantidad $\times$ PrecioUnitario), `MontoConDescuento` (calculada: Cantidad $\times$ PrecioUnitario $\times$ (1 - Descuento)), `DiasDeEnvio` (calculada: FechaEnvio - FechaOrden).

### 5. Diagrama Dimensional
El diagrama del modelo en estrella se encuentra disponible en:  
[Ver Diagrama Modelo Dimensional](docs/modelo-dimensional/Modelo%20dimensional.png)

---

## Proceso ETL - Fase 1
El proceso de extracción, transformación y carga se implementó mediante **SQL Server Integration Services (SSIS)** dividiéndose en 6 paquetes independientes (`.dtsx`):
1. **`01_DimCliente.dtsx`**: Extracción e inserción de la dimensión cliente con clave sustituta.
2. **`02_DimEmpleado.dtsx`**: Concatenación de nombre y apellido, e inserción en la dimensión empleado.
3. **`03_DimProducto.dtsx`**: Desnormalización (JOIN entre Productos, Categorías y Proveedores) para construir la dimensión producto.
4. **`04_DimTiempo.dtsx`**: Carga de la dimensión de tiempo (cobertura 1996 - 1998) generando claves sustitutas en formato `AAAAMMDD`.
5. **`05_DimTransportista.dtsx`**: Carga de la dimensión transportista.
6. **`06_FactVentas.dtsx`**: Carga de la tabla de hechos relacionando las claves del negocio con las claves sustitutas (`Keys`), calculando las métricas de negocio (`MontoVenta`, `MontoConDescuento`, `DiasDeEnvio`) y gestionando valores nulos para pedidos no enviados.

---

## Estructura del Repositorio
- `database/`: Script DDL de creación del Data Warehouse (`01_Create_KentFoods_DW.sql`), script de pruebas y validación (`02_Verificaciones_DW.sql`), y archivo de copia de seguridad (`KentFoods_DW.bak`).
- `docs/`: Documentación del modelo dimensional e imágenes.
- `etl/`: Solución de Visual Studio / SSIS con los paquetes ETL (`.dtsx`).
- `olap/`: Proyecto de Analysis Services (SSAS) - *Fase 2*.
- `powerbi/`: Reporte y Dashboard en Power BI (`.pbix`) - *Fase 3*.

---

## Instrucciones de Ejecución y Revisión

### Opción A: Restauración directa desde Backup (.bak)
1. Abrir **SQL Server Management Studio (SSMS)**.
2. Hacer clic derecho en **Databases** $\rightarrow$ **Restore Database...**
3. Seleccionar **Device** y examinar hasta el archivo `database/KentFoods_DW.bak`.
4. Ejecutar la restauración para obtener el Data Warehouse con la estructura y los 2,155 registros cargados.

### Opción B: Reconstrucción mediante Scripts y SSIS
1. Ejecutar el script `database/01_Create_KentFoods_DW.sql` en SQL Server para crear la base de datos `KentFoods_DW` vacía.
2. Abrir la solución SSIS situada en `etl/ETL_KentFoods.slnx` con Visual Studio.
3. Configurar las cadenas de conexión OLE DB hacia la base origen `KentFoods` y destino `KentFoods_DW`.
4. Ejecutar los 6 paquetes ETL en orden numérico (`01_DimCliente.dtsx` a `06_FactVentas.dtsx`).
5. Ejecutar el script `database/02_Verificaciones_DW.sql` para comprobar la integridad referencial y las consultas analíticas.
