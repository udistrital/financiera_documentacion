# Modelo de datos de NECESIDADES

Los modelos de datos en MongoDB están más enfocados desde el punto de vista de la aplicación, por eso, estos modelos están  definidos directamente en la aplicación y no en un modelado en la base de datos como es más común hacerse.

La estructura desde el API es la siguiente

```go
// Actividades asociadas a una meta
type actividad struct {
	Codigo string  `json:"codigo" bson:"codigo"`
	Valor  float64 `json:"valor" bson:"valor"`
}

// Metas de una necesidad
type meta struct {
	Codigo 		string 		 `json:"codigo" bson:"codigo"`
	Actividades []*actividad `json:"actividades" bson:"actividades"`
}

// Apropiacion de la necesidad (es el que va a tener las metas)
type apropiacion struct {
	Codigo 			 string  			`json:"codigo" bson:"codigo"`
	Metas  			 []*meta 			`json:"metas" bson:"metas"`
	Fuentes			 []*fuente	   		`json:"fuentes" bson:"fuentes"`
	Productos		 []*producto   		`json:"productos" bson:"productos"`

}

// Fuentes de la necesidad 
type fuente struct {
	Codigo string  `json:"codigo" bson:"codigo"`
	Valor  float64 `json:"valor" bson:"valor"`
}

// Productos de la necesidad 
type producto struct {
	Codigo bson.ObjectId 		`json:"_id" bson:"_id,omitempty"`
	Valor  float64 				`json:"valor" bson:"valor"`
}

// Productos de la necesidad 
type detalleServicio struct {
	Codigo 			string  `json:"codigo" bson:"codigo"`
	Valor  			float64 `json:"valor" bson:"valor"`
	Descripcion 	string  `json:"descripcion" bson:"descripcion"`
}

// Necesidad información de la necesidad
type Necesidad struct {
	ID               bson.ObjectId 		`json:"_id" bson:"_id,omitempty"`
	IDAdministrativa int           		`json:"idAdministrativa" bson:"idAdministrativa"`
	Valor            float64       		`json:"valor" bson:"valor"`
	Apropiaciones    []*apropiacion		`json:"apropiaciones" bson:"apropiaciones"`
	DetalleServicio	 *detalleServicio	`json:"detalleServicio" bson:"detalleServicio"`
	TipoContrato	 int		   		`json:"tipoContrato" bson:"tipoContrato"`
}
```

Un objeto enviado como parámetro del **servicio POST para registrar** debe tener la siguiente estructura de json:
```json
{
    "_id": ObjectId("5d668b4379f72ba4d83902e0"),
    "idAdministrativa": 102710,
    "apropiaciones": [
        {
            "codigo": "3-1",
            "metas": [
                {
                    "codigo": "meta 1",
                    "actividades": [
                        {
                            "codigo": "actividad-1",
                            "valor": 5000
                        },
                        {
                            "codigo": "actividad-2",
                            "valor": 5000
                        }
                    ]
                }
            ],
            "fuentes": [
                {
                    "codigo": "34",
                    "valor": 10000
                }
            ],
            "productos": [
                {
                    "_id": "5d668b4379f72ba4d83902e0",
                    "valor": 10000
                }
            ]
        }
    ],
    "detalleServicio": {
        "codigo": "1",
        "valor": 10000,
        "descripcion": "Mantenimiento"
    },
    "tipoContrato": 0,
    "valor": 10000
}
```

### Estructura en MongoDB

La **colección** correspondiente a estos documentos es **necesidades**

__Nota__: Aunque los atributos se muestran todos como un string, es solo la forma para que se vea mejor el json en este fichero .MD, pero hay que fijarse es en el tipo.
Lo que indica cada uno de los atributos del json anterior es:
* **_id**: Id o llave única del registro. En nuestro caso es el código de la necesidad, esta llave única no puede repetirse.
* **idAdministrativa**: Id o llave única del registro en API administrativa. Esta llave única no puede repetirse.
* **apropiaciones**: Arreglo de diccionarios que representa las apropiaciones con su respectivo código y otros atributos como : 
  * **metas**: Arreglo de diccionarios que representa las metas asociadas a la apropiación con su respectivo código y otros atributos como :
    * **actividades**: Arreglo de diccionarios que representa las actividades relacionadas con la meta , con su correspondiente _id y su valor parcial.
  * **fuentes**: Arreglo de diccionarios que representa las fuentes de financiamiento asociadas a la apropiación con su respectivo código y el monto parcial.
  * **productos**: Arreglo de diccionarios que representa los productos asociados a la apropiación con su respectivo código y el monto parcial.
* **detalleServicio**: Diccionario con la información correspondiente al tipo de servicio que está adjunto a la necesidad :
    * **codigo**: Este es el id del tipo de servicio que  se vincula a la necesidad
    * **valor**: Flotante que representa el valor monetario del servicio
    * **descripcion**: Descripción del servicio
* **tipoContrato**: Id del tipo de contrato que se especifico en la solicitud.
* **valor**: Valor total de la solicitud de la necesidad

