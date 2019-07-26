# DESPLIEGUE WSO2 en Local

Para el despliegue en integración con WSO2 en local se debe contar con un usuario y contraseña en el siguiente dominio [Login WSO2](https://autenticacion.udistrital.edu.co/dashboard/).

El usuario debe contar con el rol para poder registrar nuevas API's en el publisher, y crear un service_provider. 

## Publisher
Con el mismo usuario se ingresa al publisher donde se registrara un API nuevo o se modificara los endpoints anteriormente registrados.

Para empezar entrar al siguiente Link [Publisher WSO2](https://autenticacion.udistrital.edu.co/publisher) 

### Registro de una nueva API
Tras loguearse en el menu principal aparece una opción : **Add new API**, dar click.
Apareceran 4 opciones:  
- I have an existing API --  **Se trabajara sobre está opción**
- I have a SOAP endpoint
- Design a new REST-API
- Design a new websocket API

1. **I HAVE AN EXISTING API"**
Ya que todos los API's a registrar han sido creados previamente en beego , se escoge está opción. En necesario tener el archivo swagger a la mano.

_**Antes de importar el archivo swagger directamente**_ revisar el archivo manualmente y corregir los casos en el que el endpoint apunta a un carpeta, es decir los casos en que finaliza en **/**. Por lo que todos los endpoints deben finalizar en */endpoint* o */endoint/($query)*.


## API Store
https://autenticacion.udistrital.edu.co/store
## WSO2 Management Console
https://autenticacion.udistrital.edu.co/carbon/