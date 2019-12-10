# Modelos de CDP y CRP

### Solicitud de CDP - CDP

```json
{
    "_id": "020201abb243245454554" ,
    "consecutivo": 12, 
    "entidad": 203, 
    "centroGestor": 1 ,
    "necesidad" : 1026, 
    "fechaRegistro": "2018-09-01T05:00:00Z",
    "estado": {
        "id": 1,
        "nombre": "solicitud",
        "acronimo": "sol"
     },
    "justificacionRechazo" : "" ,
}
``` 
- **_id:** identificador unico de una solicitud de CDP
- **consecutivo:** consecutivo generado para la **SOLICITUD DE CDP** 
- **entidad:** entidad a la que corresponde, ej: u distrital 
- **centroGestor:** centro gestor ej: rector
- **necesidad:** referencia a la necesidad, cons esta llave se traeran todos los datos como objeto, financiacion etc 
- **fechaRegistro:** fecha en la que se hace la solicitud
- **estad:** estado de la solicitud de un CDP (ver [Estados CDP](https://github.com/udistrital/financiera_documentacion/blob/master/gestion_egresos/CDP-CRP/modelo_datos_mongo/ModeloDatos.md#estados-cdp) para la lista completa de estados).
- **justificacionRechazo:** justificacion de cuando se ha rechazado la solictud por defecto vacio "" 
  
#### Estados CDP
> https://github.com/udistrital/plan_cuentas_mid/blob/8f5e21713aa3f60ac869fa0df08a01717538cc18/models/cdp.go#L30
```json
"estado": {
    "id": 1,
    "nombre": "solicitud",
    "acronimo": "sol"
}

"estado": {
    "id": 2,
    "nombre": "rechazado",
    "acronimo": "rec"
}

"estado": {
    "id": 3,
    "nombre": "expedido",
    "acronimo": "exp"
}
```
### Expedido de CDP
> Un CDP expedido se compporta como un movimiento presupuestal, por ello, cuando una solicitud de CDP se aprueba y se expide el CDP, se hace un nuevo registro en la colección: _documento\_presuestal\_**{vigencia}**\_**{centro_gestor}**_
```json
{
    "_id" : "5de06653079c100319f2f2a2",
    "tipo" : "cdp",
    "valor_inicial" : 1160000.0,
    "afectacion_ids" : [ 
        "5de06653079c100319f2f2a3"
    ],
    "fecha_registro" : "2019-11-29T00:29:07Z",
    "estado" : "expedido",
    "valor_actual" : 1160000.0,
    "centro_gestor" : "1",
    "data" : {
        "consecutivo_cdp" : 11.0,
        "solicitud_cdp" : "020201abb243245454554"
    }
}
```
- **_id**: ID único del documento presupuestal
- **tipo**: Especifica el tipo del documento presupuestal, en este caso, se guardaran como _"cdp"_.
- **valor_inicial**: Es el valor del registro cuándo se hace por primera vez.
- **afectacion_ids**: Es un arreglo que tiene todos los ID que hayan afectado a ese documento (incluyendo la propía expedición del CDP). Estos ID corresponden a la colección: _movimientos\_**{vigencia}**\_**{centro_gestor}**_
- **valor_inicial**: Fecha en qué se creó el documento presupuestal
- **estado**: Estado del documento presupuestal, en este caso, se guarda "expedido" puesto que es un CDP expedido.
- **valor_actual**: Es el valor acual de un documento presupuestal, su valor disminuye o aumenta según sea las afectaciones que tenga asociadas (**afectacion_ids**)
- **centro_gestor**: Centro gestor al que pertecene el usuario que crea el documento_presupuestal
- **data**: Data guarda información particular del documento_presupuestal, en el caso del CDP se guardan dos valores:
    - **consecutivo_cdp**: Es el consecutivo que recibe el CDP una vez se ha expedido
    - **solicitud_cdp**: Es el id de la solicitud a partir de la cual se expidio el CDP, corresponde a un registro de la colección: **cdp**


### Solicitud de CRP - CRP
```json
{
    "consecutivo": 10,
    "consecutivoCdp": 11,
    "beneficiario": "1546721254",
    "valor": 5000,
    "compromiso": {
        "numeroCompromiso": 152,
        "tipoCompromiso" : 1
    },
    "infoCrp":{
    	"consecutivo": 100,
    	"fechaExpedicion": "2018-09-01T05:00:00Z",
        "estado": 1
        
    }
}
``` 
- **consecutivo:** Numero consecutivo de la solicitud de CRP
- **consecutivoCdp:** Referencia al consecutivo de CDP al cual afecta el CRP
- **beneficiario:** Referencia al identificador unico (documento) de la persona benerficiaria
- **valor:** valor del CRP
- **compromiso:** Objeto para guardar los datos del compromiso
  - **numeroCompromiso:** identificador del compromiso
  - **tipoCompromiso:** descripcion de tipo de compromiso

- **infoCrp:** objeto para guardar la informacon del CRP se crea cuando se expide el documento, por defecto null
  - **consecutivo:** consecutivo generado para el CRP en la vigencia
  - **fechaExpedicion:** fecha de expedicon del documento
  - **estado:** estado del crp ej: expedido - aprobado - anulado
        
    
