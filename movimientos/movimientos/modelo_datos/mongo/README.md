
# MOVIMIENTOS PRESUPUESTALES MONGO

  ## Modelo del Documento
```json

{
	"idpsql": int,
	"rubros_afecta": [{
			"Codigo": string,
			"Valor": float64,
			"Tipo": string
	}],
	"Tipo": string,
	"fecha_registro": string,
	"unidad_ejecutora": int16
}

```
#
#### Nota: 
El propósito del objeto "rubros_afecta" es el de guardar todas las modificaciones realizadas a uno o más rubros, de allí el origen del elemento "Codigo" y "Tipo". A su vez este elemento es definido de forma dinámica para que pueda ser utilizado no solo en modificaciones presupuestas, también en documentos como CDP y CRP que tienen afectación directa o indirecta sobre las apropiaciones.