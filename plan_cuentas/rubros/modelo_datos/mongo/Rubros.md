# Estructura de rubros para el árbol de rubros
Los modelos de datos en MongoDB están más enfocados desde el punto de vista de la aplicación, por eso, estos modelos están  definidos directamente en la aplicación y no en un modelado en la base de datos como es más común hacerse.

La estructura desde el API es la siguiente

```go
// General estructura general de una entidad en plan de cuentas
type General struct {
	Vigencia    int                           `json:"Vigencia"`
	Nombre      string                        `json:"Nombre"`
	Descripcion string                        `json:"Descripcion"`
	IDPsql      int                           `json:"IdPsql"`
}

// NodoRubro es la estructura de un Rubro, es un nodo puesto que forma parte del árbol
type NodoRubro struct {
	*General
	ID              string   `json:"_id" bson:"_id,omitempty"`
	Hijos           []string `json:"Hijos"`
	Padre           string   `json:"Padre"`
	UnidadEjecutora string   `json:"UnidadEjecutora"`
}
```

Un objeto enviado como parámetro del **servicio POST para registrar** debe tener la siguiente estructura de json:
```json
{
	"Vigencia": 2019,
	"Nombre": "Rubro 3-8",
	"Descripcion": "Algo del rubro 3-8",
	"Codigo": "3-8",
	"Hijos": ["3-8-1", "3-8-2"],
	"Padre": "3",
	"UnidadEjecutora": "1"
}
```

### Estructura en MongoDB

La **colección** correspondiente a estos documentos es **arbol_rubro**

Cuando se registra un rubro en la estructura **arbol_rubro** lo que estamos registrando es un nodo propio del árbol, no todo el árbol en cuestión.

La estructura de un nodo en MongoDB es la siguiente:
```json
{ 
    "_id" : "string", 
    "general" : {
        "vigencia" : "int", 
        "nombre" : "string", 
        "descripcion" : "string", 
        "idpsql" : "int"
    }, 
    "hijos" : "[]string", 
    "padre" : "string", 
    "unidadejecutora" : "string"
}
```
__Nota__: Aunque los atributos se muestran todos como un string, es solo la forma para que se vea mejor el json en este fichero .MD, pero hay que fijarse es en el tipo.
Lo que indica cada uno de los atributos del json anterior es:
* **_id**: Id o llave única del registro. En nuestro caso es el código del rubro, esta llave única no puede repetirse.
* **general**: Son los atributos generales que tienen todos las "entidades" que se encuentran dentro del sistema fianciero en general.
  * **vigencia**: Vigencia a la que corresponde el registro
  * **nombre**: Nombre propio del registro
  * **descripcion**: Descripción propia del registro
  * **idpsql**: Id al que este registro corresponde en PostgreSQL. Se utiliza principalmente para tener una conexión entre las bases de datos
* **hijos**: Son los nodos hijos de este nodo, o en otras palabras los que se encuentran en el nivel inmediatamente inferior.
* **padre**: Es el nodo padre del nodo actual, o en otras palabras el que se encuentra en el nivel inmeditamente superior.
* **unidadejecutora**: Unidad ejecutora a la que pertenece este nodo

**Ejemplo**:
```json
{ 
    "Codigo" : "3-8", 
    "General" : {
        "Vigencia" : 2019, 
        "Nombre" : "Rubro 3-8", 
        "Descripcion" : "Algo del rubro 3-8"
    }, 
    "Padre" : "3", 
    "UnidadEjecutora" : "1"
}
```
