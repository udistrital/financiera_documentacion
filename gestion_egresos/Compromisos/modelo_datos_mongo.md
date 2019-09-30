# Modelos de Tipos de Compromisos

### Categoría (Compromisos)

```json
{
    "_id": "242bdaoiro3r49r4",
    "nombre": "CONTRATO",
    "activo": true,
    "fechaCreacion": "2018-09-01T05:00:00Z",
    "fechaModificacion":"2018-09-01T05:00:00Z"
}

``` 
- **_id:** identificador unico de una categoría
- **nombre:** Nombre de la **Categoría** 
- **activo:** Indica si el registro está activo o no  *Lineamiento OAS*
- **fechaCreacion:** fecha en la que se crea la Categoría *Lineamiento OAS*
- **fechaModificacion** fecha en la que se realiza una modificación sobre el registro *Lineamiento OAS*

### Tipos de Compromiso
```json
{
    "_id": "68jsnvksjdkw0232",
    "idCategoria": "242bdaoiro3r49r4" ,
    "nombre": "CONTRATO DE OBRA",
    "descripcion": "Acuerdo temporal mediante el cual se contratar a un trabajador para que lleve a cabo un servicio concreto dentro de la empresa o una obra determinada.",
    "activo": true,
    "fechaCreacion": "2018-09-01T05:00:00Z",
    "fechaModificacion":"2018-09-01T05:00:00Z"
}
``` 
- **_id:** identificador unico de un tipo de compromiso
- **idCategoria:** Identificador que hace referencia a la Categoría a la que pertenece el tipo de documento
- **nombre:** Nombre del **Tipo de Compromiso** 
- **descripcion:** Descripción larga del  **Tipo de Compromiso** 
- **activo:** Indica si el registro está activo o no  *Lineamiento OAS*
- **fechaCreacion:** fecha en la que se crea la Categoría *Lineamiento OAS*
- **fechaModificacion** fecha en la que se realiza una modificación sobre el registro *Lineamiento OAS*
    
### Compromiso
```json
{
    "_id": "998vaajfoa2jfalfja",
    "idTipoCompromiso": "68jsnvksjdkw0232" ,
    "vigencia": "2019",
    "url": "http://www.contratacion.euskadi.eus/w32-1084/es/contenidos/anuncio_contratacion/expjaso6729/es_doc/adjuntos/otros1.pdf",
    "activo": true,
    "fechaCreacion": "2018-09-01T05:00:00Z",
    "fechaModificacion":"2018-09-01T05:00:00Z"
}
``` 
- **_id:** identificador unico de un Compromiso
- **idTipoCompromiso:** Identificador que hace referencia al Tipo de Compromiso al que pertenece el compromiso particular
- **vigencia:** Año en el cual el compromiso está vigente 
- **url:** Enlace al documento o soporte que respalda el**Compromiso** 
- **activo:** Indica si el registro está activo o no  *Lineamiento OAS*
- **fechaCreacion:** fecha en la que se crea la Categoría *Lineamiento OAS*
- **fechaModificacion** fecha en la que se realiza una modificación sobre el registro *Lineamiento OAS*
        