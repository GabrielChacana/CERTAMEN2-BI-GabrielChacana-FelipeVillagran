# CERTAMEN2-BI-GabrielChacana-FelipeVillagran

## Caso seleccionado
Caso 3: KentFoods

## Integrantes y Paralelo
- Gabriel Chacana
- Felipe Villagran
- Paralelo 300

## Descripción del problema
KentFoods es una empresa de venta de alimentos por envios, que ha logrado un rápido crecimiento durante los últimos años. Debido a esto, el propietario necesita incorporar Inteligencia de Negocios, con la intención de apoyar la toma de decisiones, permitiendo a los encargados seguir un buen camino estratégico.

## Objetivo del proyecto
Desarrollar una propuesta integral de Inteligencia de Negocios que permita analizar los datos de ventas, clientes, empleados y envíos, facilitando en gran parte el proceso de la toma de decisiones del dueño mediante un modelo dimensional y procesos ETL.

## KPI definidos
1. **Ingresos Totales por Ventas:** Permite evaluar el estado financiero del negocio midiendo el monto real generado en las transacciones, considerando el precio unitario, la cantidad y los descuentos aplicados.  
  **Ingresos Totales** = (Cantidad x PrecioUnitario x (1-Descuento)).
2. **Cantidad Total de Productos Vendidos:** Mide el volumen de movimiento de inventario para identificar los productos de mayor demanda y rotación, apoyando la gestión de abastecimiento.
3. **Promedio de Días de Envío:** Evalúa la eficiencia logística y de despacho midiendo el tiempo promedio transcurrido entre la generación de la orden de compra y su envío efectivo.

## Modelo dimensional
### 1. Proceso de negocio
Gestión de Ventas y Despacho de Pedidos.

### 2. Granularidad
Una línea de producto por cada orden de compra generada (nivel más atómico basado en el detalle de la orden).

### 3. Dimensiones
- **DimTiempo:** Para analizar ventas por fecha de orden y fecha de envío.
- **DimCliente:** Datos descriptivos del cliente como: su empresa, contacto, ciudad, Pais.
- **DimProducto:** Información del producto, categoría y su respectivo proveedor.
- **DimEmpleado:** Información del trabajador que gestionó la venta y su territorio/región.
- **DimTransportista:** Datos de la empresa a cargo del envío.

### 4. Tabla de hechos y medidas
- **Tabla:** FactVentas
- **Medidas:** Cantidad, PrecioUnitario, Descuento, MontoVenta (medida calculada), MontoConDescuento (medida calculada), DiasDeEnvio (medida calculada).

## Proceso ETL Fase 1
*(Se completará durante el desarrollo en SSIS)*

## Estructura del repositorio
- `docs/`: Documentación del modelo dimensional y presentaciones.
- `database/`: Scripts SQL de creación del modelo y archivos de backup `.bak`.
- `etl/`: Proyecto de Integration Services (SSIS).
- `olap/`: Proyecto de Analysis Services (SSAS).
- `powerbi/`: Archivo del dashboard `.pbix`.

## Instrucciones de ejecución/revisión
*(Se agregarán las instrucciones para ejecutar los scripts y proyectos)*

