# Documentacion general del Sistema de gestion financiera Kronos.

En este repositorio se guarda la documentación y diseños relacionados con el sistema de gestión financiera Kronos de la Universidad Distrital.

## Arquitectura.

(pendiente modelo archimate)

>### Cliente y APIs

se cuenta con los siguientes repositorios activos en el proyecto cada uno de ellos especifica las instrucciones de ejecucion del entorno de desarrollo local:

- [Cliente Angular Presupuesto](https://github.com/udistrital/presupuesto_cliente/tree/dev)
- [Plan cuentas MID](https://github.com/udistrital/plan_cuentas_mid/tree/dev)
- [Plan cuentas CRUD](https://github.com/udistrital/plan_cuentas_crud/tree/dev)<span style="color:red"> **Deprecated** </span>
- [Plan cuentas Mongo CRUD](https://github.com/udistrital/plan_cuentas_mongo_crud/tree/dev)
- [Movimientos CRUD](https://github.com/udistrital/movimientos_crud/tree/dev)

## Modulos Subsistema de presupuesto

En el sistema Kronos se cuenta con los siguientes módulos para el subsistema de presupuesto:

>### Plan de cuentas

>#### Rubros
- [Mockups](plan_cuentas/rubros/mockups.md)
- [Modelo de datos](plan_cuentas/rubros/modelo_datos.md)
>#### Apropiaciones
- [Mockups](plan_cuentas/apropiaciones/mockups.md)
- [Modelo de datos](plan_cuentas/apropiaciones/modelo_datos.md)
>#### Fuentes de financiamiento
- [Mockups](plan_cuentas/fuentes_financiamiento/mockups.md)
- [Modelo de datos](plan_cuentas/fuentes_financiamiento/modelo_datos.md)
>#### Productos
- [Modelo de datos](plan_cuentas/productos/modelo_datos.md)
>### Movimientos 
- [Mockups](movimientos/movimientos/mockups.md)
- [Modelo de datos](movimientos/movimientos/modelo_datos.md)

## Mock-ups editables
para realizar cambios o ver de forma mas detallada los mockups del sistema dirigirse a este **[Archivo](https://drive.google.com/file/d/1nBwIdN-Iue5I164bOOjwuNPBYWJMcBPB/view?usp=sharing)**


## Despliegues
Información referente a los despliegues en los distintos ambientes, conceptos básicos y herramientas a usar.
- [Despliegues general](despliegues/despliegues.md)
- [Jenkins](despliegues/jenkins.md)



