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
    "justificacionRechazo" : "" ,
    "infoCdp" : {
        "consecutivo": 12,
        "fechaExpedicion": "2018-09-01T05:00:00Z",
        "estado": 1
    }
}
``` 
- **_id:** identificador unico de una solicitud de CDP
- **consecutivo:** consecutivo generado para la **SOLICITUD DE CDP** 
- **entidad:** entidad a la que corresponde, ej: u distrital 
- **centroGestor:** centro gestor ej: rector
- **necesidad:** referencia a la necesidad, cons esta llave se traeran todos los datos como objeto, financiacion etc 
- **fechaRegistro:** fecha en la que se hace la solicitud
- **justificacionRechazo:** justificacion de cuando se ha rechazado la solictud por defecto vacio "" 
- **infoCdp:** objeto que se genera cuando se expide el CDP, pur defecto nulo
  - **consecutivo:** consecutivo que genera el servicio para ese CDP en esa vigencia.
  - **fechaExpedicion:** fecha expedicon CDP
  - **estado:** estado cdp ej: parcialmente comprometido

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
        
    
