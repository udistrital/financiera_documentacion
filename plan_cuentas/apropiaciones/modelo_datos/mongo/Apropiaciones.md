# Estructura de rubros para el árbol de rubros apropiaciones
Los modelos de datos en MongoDB están más enfocados desde el punto de vista de la aplicación, por eso, estos modelos están definidos directamente en la aplicación y no en un modelado en la base de datos como es más común hacerse.

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

// NodoRubroApropiacion es la estructura de un nodo rubro pero sumandole la apropiación
type NodoRubroApropiacion struct {
	*NodoRubro
	ApropiacionInicial 	float64 	`json:"ApropiacionInicial"`
	Movimientos 		[]string 	`json:"Movimientos"`
}
```
**_Nota: definir si los movimientos son necesarios._**

Un objeto enviado como parámetro del **servicio POST para registrar** debe tener la siguiente estructura de json:
```json
{
	"Vigencia": 2019,
	"Nombre": "Rubro 3-8",
	"Descripcion": "Algo del rubro 3-8",
	"IdPsql": 32,
	"_id": "3-8",
	"Hijos": ["3-8-1", "3-8-2"],
	"Padre": "3",
	"UnidadEjecutora": "1",
	"ApropiacionInicial": 300000.0
}
```

### Estructura en MongoDB

La **colección** correspondiente a estos documentos es **arbol_rubro_apropiacion_:vigencia:_:unidadEjecutora:**. 

Estas colecciones están divididas por vigencia y unidad ejecutora.

Ejemplo: 
* arbol_rubro_apropiacion_2018_1
* arbol_rubro_apropiacion_2018_2
* arbol_rubro_apropiacion_2019_1

Cuando se registra una apropiación de un rbro en la estructura **arbol_rubro_apropiacion** lo que estamos registrando es un nodo propio del árbol, no todo el árbol en cuestión.

La estructura de un nodo en MongoDB es la siguiente:
```json
{ 
    "_id" : "string", 
    "nodorubro" : {
        "general" : {
            "vigencia" : "Int32", 
            "nombre" : "String", 
            "descripcion" : "String", 
            "idpsql" : "Int32"
        }, 
        "hijos" : "[]String", 
        "padre" : "String", 
        "unidadejecutora" : "String"
    }, 
    "apropiacioninicial" : "Double", 
    "movimientos" : "[]String"
}

```
_Nota: Aunque los atributos se muestran todos como un string, es solo la forma para que se vea mejor el json en este fichero .MD, pero hay que fijarse es en el tipo._

Lo que indica cada uno de los atributos del json anterior es:
* **_id**: Id o llave única del registro. En nuestro caso es el código del rubro, esta llave única no puede repetirse.
* **nodorubro**: Son los atributos que hereda de nodo rubro [Rubro]
  * **general**: Son los atributos generales que tienen todos las "entidades" que se encuentran dentro del sistema fianciero en general.
    * **vigencia**: Vigencia a la que corresponde el registro
    * **nombre**: Nombre propio del registro
    * **descripcion**: Descripción propia del registro
    * **idpsql**: Id al que este registro corresponde en PostgreSQL. Se utiliza principalmente para tener una conexión entre las bases de datos
  * **hijos**: Son los nodos hijos de este nodo, o en otras palabras los que se encuentran en el nivel inmediatamente inferior.
  * **padre**: Es el nodo padre del nodo actual, o en otras palabras el que se encuentra en el nivel inmeditamente superior.
  * **unidadejecutora**: Unidad ejecutora a la que pertenece este nodo
* **apropiacioninicial**: Valor de la apropiación inicial de ese rubro
* **movimientos**: Todos ids de los movimientos asociados a ese rubro (Adición, Traslado, Suspensión, Reducción, CDP, RP, etc. En general cualquier afectación directa o indirecta a dicho rubro) _Puede que este atributo no sea necesario_

**Ejemplo**:
```json
{ 
    "_id" : "3-8", 
    "nodorubro" : {
        "general" : {
            "vigencia" : 2019, 
            "nombre" : "Rubro 3-8", 
            "descripcion" : "Algo del rubro 3-8", 
            "idpsql" : 32
        }, 
        "hijos" : [
            "3-8-1", 
            "3-8-2"
        ], 
        "padre" : "3", 
        "unidadejecutora" : "1"
    }, 
    "apropiacioninicial" : 300000.0, 
    "movimientos" : [

    ]
}
```

[rubro]: <https://github.com/udistrital/Financiera_documentacion/blob/master/plan_cuentas/rubros/modelo_datos/mongo/Rubros.md>
