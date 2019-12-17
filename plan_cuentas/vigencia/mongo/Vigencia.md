# Estructura de las vigencias

La estructura de las vigencias dentro del API es la siguiente:

```go
type Vigencia struct {
	ID            string `json:"Id" bson:"_id,omitempty"`
	Valor         int    `json:"Valor" bson:"valor"`
	Estado        string `json:"Estado" bson:"estado"`
	Activo	      bool `json:"Activo" bson:"activo"`	
  FechaCreacion  time.Time `json:"fechaCreacion" bson:"fechaCreacion"`
  FechaModificacion  time.Time `json:"fechaModificacion" bson:"fechaModificacion"`
  FechaCierre  time.Time `json:"fechaCierre" bson:"fechaCierre"`
}
```

Para poder registrar una nueva vigencia, la cual será creada con el estado actual, se deberá enviar como parámetro al servicio **POST** para la creación de la vigencia, un json con la siguiente estructura:

```json
{    
    "CentroGestor" : "1",
    "AreaFuncional" : "1",
    "Valor" : 2020,
    "FechaCreacion": "2018-09-01T05:00:00.000Z",
    "FechaCreacion": "2018-09-01T05:00:00.000Z",
}
```

El nombre de la colección en la que se guardaran los datos de las vigencias se llama **vigencia**


Las vigencias quedarán guardadas en MONGODB con la siguiente estructura: 
```json
{
    "_id" : "ObjectId",
    "centro_gestor" : "string",
    "area_funcional" : "string",
    "valor" : "int",
    "estado" : "string",
    "activo" : "boolean",
    "fecha_creacion" : "date",
    "fecha_modificacion" : "date",
    "fecha_cierre" : "date"
}
```

El valor de cada uno de los atributos de la anterior estructura tienen el siguiente significado:

**_id:** Atributo único que identifica el registro, se conforma por el año de la vigencia y el centro gestor la que le pertenece.

**valor:** Año al cuál hace referencia la vigencia.

**activo:** Indica el estado del registro, si se encuentra activo o no.

**estado:** Una vigencia puede estar en ejecución, puede estar cerrada o puede ser la siguiente a la vigencia actual, de esta forma la vigencia puede tener los siguientes estados: **activa, cerrada, siguiente**

**fecha_creacion:** Fecha en la cual fue creada la vigencia.

**fecha_modificacion:** Fecha en la que se realizó la última modificación de la vigencia.

**fecha_cierre:** Fecha en la que se dió cierre a la vigencia.


Un ejemplo de una vigencia registrada es el siguiente:
```json
{
    "_id" : "2020_2",
    "valor" : 2020,
    "estado" : "actual",
    "activo" : true,
    "fecha_creacion" : ISODate("2019-12-10T17:21:58.276Z"),
    "fecha_modificacion" : ISODate("2019-12-10T17:21:58.276Z"),
    "fecha_cierre" : ISODate("2019-12-10T17:21:58.276Z")
}
```
