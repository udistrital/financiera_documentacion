# Despliegues para las Aplicaciones

## Entornos
La oficina en su misión de mantener entornos pare el  desarrollo como para producción, establece pipelines por los cuales los desarrolladores pueden correr sus pruebas y hacer modificaciones sobre el aplicativo. 
Principalmente existen 3 entornos de desarrollo:
- [Local](#local)
- [Pre-producción](#preproduccion)
- [Producción](#produccion)

Las Herramientas para el despliegue en cada entorno pueden variar pero principalmente son:
- [Jenkins](#jenkins)
- [WSO2](#wso2)
- [DRONE](#drone)
- [SONARQ](#sonarq)

El despliegue también puede variar de acuerdo al lenguaje de programación,aunque la oficina trabaja principalmente con Go y Typescript(Javascript). El lenguaje usado definira el pipeline que debe seguir, sobre todo los comandos usados para lograr su ejecutable optimizado en producción.

### Local
El ambiente local se refiere principalmente a los servidores físicos en la oficina y se reconoce porque en su direccionamiento mantienen la ip principal sobre la que se montan las APIs y clientes, la xxx.xxx.xxx.254. 

Para los despliegues sobre la oficina se debe contar con acceso a jenkins, acceso por consola al servidor (arquitecto) y acceso a la administración de APIs desde WSO2. 
Estos 3 elementos son importantes ya que bajo la arquitectura de micro-servicios, cada API se desarrolla de forma independiente, pueden trabajar en interoperatividad con otras APIs y cada una tiene su puerto; Por lo que en la práctica cada API tiene su propio repositorio, y cada una maneja conexiones independientes a las base de datos.

Para Iniciar su despliegue se debe contar con el apoyo del arquitecto, a quien se le hara llegar una lista de variables de entorno que se registraran en el servidor ( ya que está información es confidencial y no debe agregarse al repositorio), el arquitecto reconoce que estas variables deben contar con las credenciales para la conexión a la base de datos, como el puerto sobre el que se desplegara el API. Por lo que su contenido denuevo es confidencial incluso para los desarrolladores.

Una vez registradas las variables se puede proceder al despliegue con Jenkins, está es una herramienta de CI(Continous Integration) que nos permitir establecer un pipeline por lo cual se pueden aplicar pruebas al código y solo en caso de que no surjan errores, finalizara el despliegue. Hay que tener en cuenta que está herramienta estara copiando directamente el código desde el repositorio y tomando la versión del código en la rama que establezcamos.

Una vez que el despliegue sea exitoso, se puede comprobar que el API se conecto a la base de datos satisfactoriamente realizando una inspeccion a los esquemas y tablas creadas ( se debe contar con acceso por medio de un adm. de base de datos) y haciendo pruebas sobre las endpoints del componente.

Como siguiente paso, los endpoints de los APIs no deben quedar públicos y solo se debe accerder a la información de estos por medio de una autenticación única que provee WSO2. WSO2 principalmente se encierra bajo el concepto de ser un API Manager, en este se tendran que registrar las APIs ( mas que todo los endpoints y es necesario conocer el puerto), se asociara un service_provider, y por medio de este último es que se monta la autenticación con el usuario, se obtiene los token de cliente y el secreto.

Ya finalizado el registro dentro de WSO2 y con el client_token se podra agregar este token al aplicativo de Angular para la autenticación con el usuario y si he de correr todo bien, se tendra un aplicativo cliente desplegado que se alimenta de las API's, que logra autenticar un usuario para el consumo de estas. Se recomienda asimismo seguir las instrucciones entregadas por el equipo del CORE para los despliegues y configuraciones de los aplicativos basados en Angular 7.

#### Jenkins
#### WSO2
#### Aplicaciones en Go
#### APlicaciones en Angular 
### Preproducción
### Producción
## Herramientas
- Jenkins
- WSO2
- DRONE
- SONARQ
