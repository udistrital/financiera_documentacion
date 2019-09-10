# Modelo de datos para Productos
Los modelos de datos en MongoDB están más enfocados desde el punto de vista de la aplicación, por eso, estos modelos están  definidos directamente en la aplicación y no en un modelado en la base de datos como es más común hacerse.

La estructura desde el API es la siguiente

```go
// Producto ...
type Producto struct {
	*General
	ID bson.ObjectId `json:"_id" bson:"_id,omitempty"`
}
```

Un objeto enviado como parámetro del **servicio POST para registrar** debe tener la siguiente estructura de json:
```json
{
  "Vigencia": 2019,
  "Nombre": "Producto 1",
  "Descripcion": "Descripción del producto 1",
  "FechaCreacion": "2018-09-01T05:00:00.000Z",
  "Activo": true
}
```

### Estructura en MongoDB

La **colección** correspondiente a estos documentos es **productos**

La estructura de registrada en MongoDB es la siguiente:
```json
{ 
    "_id" : "objectId", 
    "general" : {
        "vigencia" : "int", 
        "nombre" : "string", 
        "descripcion" : "string", 
        "fechaCreacion": "date",
        "fechaModificacion": "date",
        "activo": "boolean"
    }
}
```
__Nota__: Aunque los atributos se muestran todos como un string, es solo la forma para que se vea mejor el json en este fichero .MD, pero hay que fijarse es en el tipo.
Lo que indica cada uno de los atributos del json anterior es:
* **_id**: Id o llave única del documento. 
* **general**: Son los atributos generales que tienen todos las "entidades" que se encuentran dentro del sistema fianciero en general.
  * **vigencia**: Vigencia a la que corresponde el documento
  * **nombre**: Nombre propio del documento
  * **descripcion**: Descripción propia del documento
  * **fechaCreacion**: Fecha y hora completa en la que se hizo el documento
  * **fechaModificacion**: Fecha y hora completa de la última modificación del documento
  * **activo**: Indica si el documento está activo o no

**Ejemplo**:
```json
{
    "_id" : 'ObjectId("5d55fe9c02c02b24c7867170")',
    "general" : {
        "vigencia" : 0,
        "nombre" : "Producto de prueba...",
        "descripcion" : "",
        "fechaCreacion" : "Date(-62135596800000)",
        "fechaModificacion" : "Date(-62135596800000)",
        "activo" : false
    }
}
```
