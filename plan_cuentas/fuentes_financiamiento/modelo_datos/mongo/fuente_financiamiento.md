# Estructura para Fuentes de Financiamiento
Estructura del API:


```go 
type codigoRubro string

// dependenciaRubro Relación entre dependencia y rubro
type dependenciaRubro struct {
	ID    int     `json:"Id" bson:"idDepdencia"`
	Valor float64 `json:"ValorDependencia" bson:"valorDependencia"`
}

// rubroFuente Relación entre un rubro y una fuente
type rubroFuente struct {
	Dependencias []*dependenciaRubro `json:"Dependencias" bson:"dependencias"`
	Productos    []int               `json:"Productos" bson:"productos`
}

// FuenteFinanciamiento ...
type FuenteFinanciamiento struct {
	*General
	ID             string                       `json:"Codigo" bson:"_id,omitempty"`
	TipoFuente     interface{}                  `json:"TipoFuente" bson"tipoFuente"`
	ValorOriginal  float64                      `json:"ValorOriginal" bson:"valorOriginal"`
	ValorAcumulado float64                      `json:"ValorAcumulado" bson"valorAcumulado"`
	Rubros         map[codigoRubro]*rubroFuente `json:"Rubros" bson:"rubros"`
}
```

Un objeto enviado como parámetro del servicio POST para registrar debe tener la siguiente estructura de json:
```json
{
	"Vigencia": 2019,
	"Nombre": "fuente de financiamiento 1",
	"Descripcion": "descripcion de la fuente de financiamiento 1",
	"FechaCreacion": "2018-09-01T05:00:00.000Z",
	"FechaModificacion": "2018-09-01T05:00:00.000Z",
	"Activo": true,
	"TipoFuente": "algo del tipo de fuente",
	"ValorOriginal": 30000,
	"ValorAcumulado": 0,
	"Codigo": "fuente3",
	"Rubros": {
		"3-1": {
			"Productos": [1,2,3],
			"Dependencias": [
				{
					"Id": 30,
					"Valor": 300
				},
				{
					"Id": 31,
					"Valor": 450
				}
			]
		},
		"3-2": {
			"Productos": [4,5,6],
			"Dependencias": [
				{
					"Id": 35,
					"Valor": 500
				}
			]
		}
	}
}
```

## Estructura en MongoDB

La **colección** correspondiente a estos documentos es **fuente_financiamiento**

La estructura en MongoDB es la siguiente:

```json
{
	"Vigencia": "Int32",
	"Nombre": "String",
	"Descripcion": "String",
	"FechaCreacion": "Date",
	"FechaModificacion": "Date",
	"Activo": "Boolean",
	"TipoFuente": "String",
	"ValorOriginal": "Double",
	"ValorAcumulado": "Double",
	"_id": "String",
	"Rubros": {
		"String": {
			"Productos": "[]Int32",
			"Dependencias": [{
                              "Id": "String",
                              "Valor": "Double"
                             }, "..."
                         ]
		}
	}
}
```

Lo que indica cada uno de los atributos es:
* **_id**: Codigo de la fuente (es la PK de la colección)
* **Vigencia**: Vigencia de la fuente
* **Nombre**: Nombre de la fuente
* **Descripción**: Descripción de la fuente 
* **FechaCreacion**: Fecha de creación de la fuente
* **FechaModificacion**: Fecha de la última modificación de la fuente
* **Valor Original**: Valor original asignado a la fuente
* **Valor acumulado**: Valor acumulado hasta ahora de la fuente
* **Rubros**: Diccionario con la información de los rubros asociados a esta fuente. La **llave es el código del producto** y su valor es :
   * Productos: Arreglo de enteros con los id de postgresql correspondiente a los productps
   * Dependencias: Arreglo de diccionarios con la información de las dependencias. 
      * Id: Id de postgresql de la dependencia
      * Valor: Valor asignado a la dependencia en esa fuente
