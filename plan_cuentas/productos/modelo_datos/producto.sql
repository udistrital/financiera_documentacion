-- object: plan_cuentas.producto | type: TABLE --
-- DROP TABLE IF EXISTS plan_cuentas.producto CASCADE;
CREATE TABLE plan_cuentas.producto (
	id serial NOT NULL,
	nombre character varying(150) NOT NULL,
	descripcion character varying(255),
	fecha_registro date NOT NULL,
	CONSTRAINT pk_productos PRIMARY KEY (id),
	CONSTRAINT uq_nombre_producto UNIQUE (nombre)

);
-- ddl-end --
COMMENT ON TABLE plan_cuentas.producto IS 'Tabla para registrar los productos asociados a un rubro.';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.producto.id IS 'id interno de la tabla';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.producto.nombre IS 'nombre del producto a asociar';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.producto.descripcion IS 'descripcion del producto';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.producto.fecha_registro IS 'fecha en la que se registro el producto';
-- ddl-end --
COMMENT ON CONSTRAINT pk_productos ON plan_cuentas.producto  IS 'identificador primario de la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT uq_nombre_producto ON plan_cuentas.producto  IS 'restriccion de llave unica para el nombre del producto';
-- ddl-end --
ALTER TABLE plan_cuentas.producto OWNER TO postgres;
-- ddl-end --

-- object: plan_cuentas.producto_detalle | type: TABLE --
-- DROP TABLE IF EXISTS plan_cuentas.producto_detalle CASCADE;
CREATE TABLE plan_cuentas.producto_detalle (
	id serial NOT NULL,
	rubro_id integer NOT NULL,
	producto_id integer NOT NULL,
	fuente_financiamiento_id integer,
	valor_distribucion numeric(3,2) NOT NULL,
	activo boolean NOT NULL DEFAULT true,
	fecha_registro date NOT NULL,
	CONSTRAINT pk_producto_detalle PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE plan_cuentas.producto_detalle IS 'tabla compuesta para referenciar las operaciones de los productos ';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.producto_detalle.id IS 'identificador interno de los registros de la tabla';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.producto_detalle.rubro_id IS 'referencia al rubro que asocia al producto';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.producto_detalle.producto_id IS 'referencia al producto asociado a un rubro';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.producto_detalle.fuente_financiamiento_id IS 'referencia opcional a la tabla fuente_financiamiento';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.producto_detalle.valor_distribucion IS 'Valor asignado en porcentaje por cada producto para el rubro asociado a este mismo';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.producto_detalle.activo IS 'determina si el paramertro se encuentra activo para Determina si el parametro se encuentra activo para realizar calculos';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.producto_detalle.fecha_registro IS 'fecha en la que se registro la distribucion';
-- ddl-end --
COMMENT ON CONSTRAINT pk_producto_detalle ON plan_cuentas.producto_detalle  IS 'llave primaria de la tabla producto_detalle';


-- object: fk_producto_detalle_producto | type: CONSTRAINT --
-- ALTER TABLE plan_cuentas.producto_detalle DROP CONSTRAINT IF EXISTS fk_producto_detalle_producto CASCADE;
ALTER TABLE plan_cuentas.producto_detalle ADD CONSTRAINT fk_producto_detalle_producto FOREIGN KEY (producto_id)
REFERENCES plan_cuentas.producto (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --
COMMENT ON CONSTRAINT fk_producto_detalle_producto ON plan_cuentas.producto_detalle  IS 'llave foranea hacia la tabla producto';
-- ddl-end --


-- object: fk_producto_detalle_rubro | type: CONSTRAINT --
-- ALTER TABLE plan_cuentas.producto_detalle DROP CONSTRAINT IF EXISTS fk_producto_detalle_rubro CASCADE;
ALTER TABLE plan_cuentas.producto_detalle ADD CONSTRAINT fk_producto_detalle_rubro FOREIGN KEY (rubro_id)
REFERENCES plan_cuentas.rubro (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --
COMMENT ON CONSTRAINT fk_producto_detalle_rubro ON plan_cuentas.producto_detalle  IS 'llave foranea a la tabla rubro';
-- ddl-end --


-- object: fk_producto_detalle_fuente_financiamiento | type: CONSTRAINT --
-- ALTER TABLE plan_cuentas.producto_detalle DROP CONSTRAINT IF EXISTS fk_producto_detalle_fuente_financiamiento CASCADE;
ALTER TABLE plan_cuentas.producto_detalle ADD CONSTRAINT fk_producto_detalle_fuente_financiamiento FOREIGN KEY (fuente_financiamiento_id)
REFERENCES plan_cuentas.fuente_financiamiento (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --
COMMENT ON CONSTRAINT fk_producto_detalle_fuente_financiamiento ON plan_cuentas.producto_detalle  IS 'llave foranea a la tabla fuente_financiamiento';
-- ddl-end --
