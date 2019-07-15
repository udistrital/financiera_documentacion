# Documentacion de proceso de despliegues para proyecto financiera

## Ambiente local (254)

### Registro Jenkins

La [consola de administracion de jenkins](https://intelligentia.udistrital.edu.co:8443/jenkins) permite realizar la creacion de los jobs para construir proyectos, tanto del cliente como de las APIS, luego de ingresar con las credenciales podemos desarrollar los siguientes procesos:
- Ingresar a la pestaña de financiera, alli se podra ver el estado de los diferentes jobs de despliegue:
![image](https://user-images.githubusercontent.com/32855979/61229028-043bd200-a6ed-11e9-9998-16a7b476a627.png)

#### Clientes Angular 7
- Nombre y direccion del repositorio:
![image](https://user-images.githubusercontent.com/32855979/61229493-ea4ebf00-a6ed-11e9-9f26-9f210de8406e.png)
- Configuracion repositorio y rama a construir:
![image](https://user-images.githubusercontent.com/32855979/61229577-0c484180-a6ee-11e9-9d51-98fbdd5c1a03.png)
- Configuracion disparadores de construccion y entorno:
![image](https://user-images.githubusercontent.com/32855979/61229705-40bbfd80-a6ee-11e9-8744-b6fdfd7c51e7.png)
- Comandos de despliegue y ejecucion:
![image](https://user-images.githubusercontent.com/32855979/61229830-7cef5e00-a6ee-11e9-8af9-862406452165.png)
**IMPORTANTE, POR LOS ANTERIORES COMANDOS, ANTES DE REALIZAR EL DESPLIEGUE HAY QUE CORREGIR LOS POSIBLES ERRORES QUE EL PROYECTO ARROJE EN EL SIGUIENTE COMANDO LOCALMENTE:**
```shell
npm run build:prod
```

#### APIS golang

- Nombre y repositorio para el proyecto

![image](https://user-images.githubusercontent.com/32855979/61230701-2daa2d00-a6f0-11e9-9433-1abfbd9c980f.png)

- Configurar SCM repo y rama
![image](https://user-images.githubusercontent.com/32855979/61231112-030ca400-a6f1-11e9-829f-ec3504b5d494.png)

- configurar el entorno para la construcciondel proyecto generico **golang API** que sera el que realizara la compilacion, y ejecutara las migraciones
![image](https://user-images.githubusercontent.com/32855979/61231181-33544280-a6f1-11e9-92ef-75bf0f196ae5.png)

**IMPORTANTE: LAS MIGRACIONES DEBEN ESTAR CORRIENDO CORRECTAMENTE DE FORMA LOCAL Y LAS VARIABLES DE ENTORNO DEBEN ESTAR CONFIGURADAS POR EL ARQUITECTO Y EL LIDER TECNICO**
