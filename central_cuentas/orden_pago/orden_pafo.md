### modelo ordenes de pago

el modelo se escribe en lenguaje de typescript a manera de documentacion y poder saber comentarios y tipos de datos

```typescript
export interface orden_pago { 
    _id: string; // bjson autogenerado
    fecha_creacion: Date;
    fecha_modificacion: Date;
    activo: boolean;
    numero: number; // numero de la orden de pago
    solicitante_id: string; // tercero que solicito la orden de pago
    beneficiario_id: string; //documento de identidad del beneficiario de la orden de pago
    tipo_compromiso: string; // lista que ongluye , orden de compra, contrato ...
    numero_compromiso: number; // numero de compromiso, solo se usa para algo 
                               // llamado compromisos que es intermedio entr el contrato 
                               // y la orden de pago, podriamos dejar el numero del contrato
    vigencia: number; // numero de la vigencia sobre la que se realiza la OP
    area_funcional: string; // s es rector o convenios
    concepto_id: string; // concepto del sistema de contabilidad
    estados: [ // relacion muchos a muchos con coleccion de estados
        {
            coleccion: 'estados',
            estado_id: string;  // id de referencia del estado,
            activo: boolean;
            descripcion: string; // razon de cambio del estado
            fecha_creacion: Date;
            fecha_modificacion: Date;
        }
    ];
    imputacion_presupuestal: [ // se describen las afectaciones presupuestales
                            // es un array por que hay ordenes 
                            // de pago que tienen 1 cdp , 1 rp y 2 rubros
        {
            _id: string;
            activo: boolean;
            fecha_creacion: Date;
            fecha_modificacion: Date;
            numero_cdp: number; // numero del certificado de disponibilidad presupuestal
            numero_rp: number; // numero del registro presupuestal
            rubro_presupuestal: string;
            valor_aplicado: number; // valor aplicado 
        }
    ]
    movimiento_contable: [ // se describen los descuentos
        {
            _id: string,
            activo: boolean;
            fecha_creacion: Date;
            fecha_modificacion: Date;
            retencion_id: number; // id de referencia de la retencion
            base_retencion: number; // numero de la base de retencion digitado por el usuario
            codigo_contable?: string; // codigo de la cuenta contable a la que esta sociada la retencion
            informativo: boolean; // si es informativo true el registro no afecta los calculos de descuentos
        }
    ]
}
```