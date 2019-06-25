-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.1
-- PostgreSQL version: 10.0
-- Project Site: pgmodeler.io
-- Model Author: ---


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: financiera | type: DATABASE --
-- -- DROP DATABASE IF EXISTS financiera;
-- CREATE DATABASE financiera;
-- -- ddl-end --
-- 

-- object: plan_cuentas | type: SCHEMA --
-- DROP SCHEMA IF EXISTS plan_cuentas CASCADE;
CREATE SCHEMA plan_cuentas;
-- ddl-end --
ALTER SCHEMA plan_cuentas OWNER TO postgres;
-- ddl-end --

-- object: "plan cuentas" | type: SCHEMA --
-- DROP SCHEMA IF EXISTS "plan cuentas" CASCADE;
CREATE SCHEMA "plan cuentas";
-- ddl-end --
ALTER SCHEMA "plan cuentas" OWNER TO postgres;
-- ddl-end --
COMMENT ON SCHEMA "plan cuentas" IS 'esquema para gestion de rubros ';
-- ddl-end --

SET search_path TO pg_catalog,public,plan_cuentas,"plan cuentas";
-- ddl-end --

-- object: plan_cuentas.apropiacion | type: TABLE --
-- DROP TABLE IF EXISTS plan_cuentas.apropiacion CASCADE;
CREATE TABLE plan_cuentas.apropiacion(
	id serial NOT NULL,
	vigencia integer NOT NULL,
	valor numeric(20,7) NOT NULL,
	estado_apropiacion_id integer NOT NULL,
	rubro_id integer,
	CONSTRAINT pk_apropiacion PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE plan_cuentas.apropiacion IS 'tabla que registra las apropiaciones iniciales para los rubros';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.apropiacion.id IS 'identificador de la apropiacion';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.apropiacion.vigencia IS 'año de la vigencia a la que pertenece la apropiacion';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.apropiacion.valor IS 'valor en moneda de la apropiacion';
-- ddl-end --
ALTER TABLE plan_cuentas.apropiacion OWNER TO postgres;
-- ddl-end --

-- object: plan_cuentas.estado_apropiacion | type: TABLE --
-- DROP TABLE IF EXISTS plan_cuentas.estado_apropiacion CASCADE;
CREATE TABLE plan_cuentas.estado_apropiacion(
	id serial NOT NULL,
	nombre varchar NOT NULL,
	descripcion varchar NOT NULL,
	codigo_abreviacion varchar NOT NULL,
	numero_orden integer,
	activo bool NOT NULL,
	CONSTRAINT pk_estado_apropiacion PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE plan_cuentas.estado_apropiacion IS 'tabla parametrica que registra los estados de las apropiaciones';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.estado_apropiacion.id IS 'identificador único del estado de la apropiacion';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.estado_apropiacion.nombre IS 'nombre del estado de la apropiacion que sera visible';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.estado_apropiacion.descripcion IS 'descripcion del estado de la apropiacion';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.estado_apropiacion.codigo_abreviacion IS 'acronimo del nombre del estado de la apropiación';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.estado_apropiacion.numero_orden IS 'por si es necesario establecer una orden a los registros que no se encuentren definidos';
-- ddl-end --
ALTER TABLE plan_cuentas.estado_apropiacion OWNER TO postgres;
-- ddl-end --

-- object: fk_apropiacion_estado_apropiacion | type: CONSTRAINT --
-- ALTER TABLE plan_cuentas.apropiacion DROP CONSTRAINT IF EXISTS fk_apropiacion_estado_apropiacion CASCADE;
ALTER TABLE plan_cuentas.apropiacion ADD CONSTRAINT fk_apropiacion_estado_apropiacion FOREIGN KEY (estado_apropiacion_id)
REFERENCES plan_cuentas.estado_apropiacion (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: plan_cuentas.rubro | type: TABLE --
-- DROP TABLE IF EXISTS plan_cuentas.rubro CASCADE;
CREATE TABLE plan_cuentas.rubro(
	id serial NOT NULL,
	organizacion integer NOT NULL,
	codigo varchar(50) NOT NULL,
	nombre varchar(250) NOT NULL,
	unidad_ejecutora integer NOT NULL,
	descripcion text,
	CONSTRAINT pk_rubro PRIMARY KEY (id),
	CONSTRAINT uq_organizacion_codigo_unidad_ejecutora_rubro UNIQUE (organizacion,unidad_ejecutora,codigo),
	CONSTRAINT ck_codigo_rubro CHECK (((codigo)::text ~ '^([0-9]+-)+[0-9]+$'::text))

);
-- ddl-end --
COMMENT ON TABLE plan_cuentas.rubro IS 'la tabla rubro almacena la informacion de los rubros (nodos del arbol de rubros)';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.rubro.id IS 'identificador de la tabla rubro';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.rubro.organizacion IS 'codigo identificador de la entidad  del distrito para el rubro';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.rubro.codigo IS 'codigo del rubro de la forma 0-0-0-0... donde se utilizan numeros identificadores para los ancestros del rubro separados por guiones y el ultimo digito es el codigo perteneciente al rubro';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.rubro.nombre IS 'nombre del rubro';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.rubro.unidad_ejecutora IS 'unidad ejecutora para el rubro';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.rubro.descripcion IS 'descripcion adicional del rubro suministrada por el funcionario durante el proceso de registro de rubro';
-- ddl-end --
COMMENT ON CONSTRAINT pk_rubro ON plan_cuentas.rubro  IS 'restriccion llave primaria de rubro';
-- ddl-end --
COMMENT ON CONSTRAINT uq_organizacion_codigo_unidad_ejecutora_rubro ON plan_cuentas.rubro  IS 'restriccion creada para que dentro de la organizacion (entidad del distrito) y a su vez dentro de la unidad ejecutora no puedan existir 2 rubros con un mismo codigo, sin embargo pudiendo existir rubros con el mismo codigo en unidades u organizaciones diferentes.';
-- ddl-end --
COMMENT ON CONSTRAINT ck_codigo_rubro ON plan_cuentas.rubro  IS 'este check se encarga de que los codigos esten restringidos a la forma de 1 a 8 secuencias de digitos 999 separados por guiones -';
-- ddl-end --
ALTER TABLE plan_cuentas.rubro OWNER TO postgres;
-- ddl-end --

-- object: plan_cuentas.rama | type: TABLE --
-- DROP TABLE IF EXISTS plan_cuentas.rama CASCADE;
CREATE TABLE plan_cuentas.rama(
	id serial NOT NULL,
	rubro_padre integer NOT NULL,
	rubro_hijo integer NOT NULL,
	CONSTRAINT pk_rama PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE plan_cuentas.rama IS 'rama almacena relaciones entre los rubros';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.rama.id IS 'identificador de la tabla rama que almacena relaciones entre rubros';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.rama.rubro_padre IS 'identificador del rubro que cumple el rol de padre en la relacion';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.rama.rubro_hijo IS 'identificador del rubro que cumple el rol de hijo en la relacion';
-- ddl-end --
COMMENT ON CONSTRAINT pk_rama ON plan_cuentas.rama  IS 'restriccion de llave primaria de la tabla rama';
-- ddl-end --
ALTER TABLE plan_cuentas.rama OWNER TO postgres;
-- ddl-end --

-- object: fk_apropiacion_rubro | type: CONSTRAINT --
-- ALTER TABLE plan_cuentas.apropiacion DROP CONSTRAINT IF EXISTS fk_apropiacion_rubro CASCADE;
ALTER TABLE plan_cuentas.apropiacion ADD CONSTRAINT fk_apropiacion_rubro FOREIGN KEY (rubro_id)
REFERENCES plan_cuentas.rubro (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: plan_cuentas.fuente_financiamiento | type: TABLE --
-- DROP TABLE IF EXISTS plan_cuentas.fuente_financiamiento CASCADE;
CREATE TABLE plan_cuentas.fuente_financiamiento(
	id serial NOT NULL,
	nombre character varying(70) NOT NULL,
	descripcion character varying(200),
	fecha_creacion date,
	tipo_fuente_financiamiento integer NOT NULL,
	codigo character varying(10) NOT NULL,
	CONSTRAINT pk_fuente_financiamiento PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.fuente_financiamiento.id IS 'Llave primaria de la tabla fuente_financiamiento';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.fuente_financiamiento.nombre IS 'Nombre de la fuente de financiamiento';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.fuente_financiamiento.descripcion IS 'Una descripción de la fuente de financiamiento, como por ejemplo:
- Razón por la que fue creada
- Un año con que se pueda identificar
En general un texto que pueda diferenciarla de otra fuente de financiamiento con un nombre muy similar';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.fuente_financiamiento.fecha_creacion IS 'Fecha de la creación de la fuente de financiamiento';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.fuente_financiamiento.tipo_fuente_financiamiento IS 'Tipo de la fuente de financiamiento';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.fuente_financiamiento.codigo IS 'Codigo de la fuente de financiamiento ';
-- ddl-end --
COMMENT ON CONSTRAINT pk_fuente_financiamiento ON plan_cuentas.fuente_financiamiento  IS 'Primary Key de la tabla fuente_financiamiento';
-- ddl-end --
ALTER TABLE plan_cuentas.fuente_financiamiento OWNER TO postgres;
-- ddl-end --

-- object: plan_cuentas.tipo_fuente_financiamiento | type: TABLE --
-- DROP TABLE IF EXISTS plan_cuentas.tipo_fuente_financiamiento CASCADE;
CREATE TABLE plan_cuentas.tipo_fuente_financiamiento(
	id serial NOT NULL,
	nombre character varying(70) NOT NULL,
	descripcion character varying(300),
	CONSTRAINT pk_tipo_fuente_financiamiento PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE plan_cuentas.tipo_fuente_financiamiento IS 'Tabla para tipificar o catalogar las fuentes de financiamiento';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.tipo_fuente_financiamiento.id IS 'Llave primaria de la tabla tipo_fuente_financiamiento';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.tipo_fuente_financiamiento.nombre IS 'Nombre de la categorización de la fuente';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.tipo_fuente_financiamiento.descripcion IS 'Descripción que se le pueda dar a la categorización de la fuente. Puede ser cualquier texto que facilite su rápida identificación p comprensión ';
-- ddl-end --
COMMENT ON CONSTRAINT pk_tipo_fuente_financiamiento ON plan_cuentas.tipo_fuente_financiamiento  IS 'Constraint PK de la tabla tipo_fuente_financiamiento';
-- ddl-end --
ALTER TABLE plan_cuentas.tipo_fuente_financiamiento OWNER TO postgres;
-- ddl-end --

-- object: plan_cuentas.fuente_financiamiento_apropiacion | type: TABLE --
-- DROP TABLE IF EXISTS plan_cuentas.fuente_financiamiento_apropiacion CASCADE;
CREATE TABLE plan_cuentas.fuente_financiamiento_apropiacion(
	id serial NOT NULL,
	apropiacion_id integer NOT NULL,
	fuente_financiamiento_id integer NOT NULL,
	dependencia integer NOT NULL,
	CONSTRAINT pk_fuente_financiamiento_apropiacion PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE plan_cuentas.fuente_financiamiento_apropiacion IS 'Tabla que relaciona una fuente de financiamiento con una apropiación';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.fuente_financiamiento_apropiacion.id IS 'Primary key de la tabla fuente_financiamiento_apropiacion';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.fuente_financiamiento_apropiacion.apropiacion_id IS 'Fk referencia a la tabla apropiacion';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.fuente_financiamiento_apropiacion.fuente_financiamiento_id IS 'Fk fuente de financiamiento';
-- ddl-end --
COMMENT ON COLUMN plan_cuentas.fuente_financiamiento_apropiacion.dependencia IS 'Id de la dependencia a la cual va destinada el dinero del rubro obtenido a partir de la fuente de financiamiento';
-- ddl-end --
ALTER TABLE plan_cuentas.fuente_financiamiento_apropiacion OWNER TO postgres;
-- ddl-end --

-- object: fk_rama_rubro_padre | type: CONSTRAINT --
-- ALTER TABLE plan_cuentas.rama DROP CONSTRAINT IF EXISTS fk_rama_rubro_padre CASCADE;
ALTER TABLE plan_cuentas.rama ADD CONSTRAINT fk_rama_rubro_padre FOREIGN KEY (rubro_padre)
REFERENCES plan_cuentas.rubro (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_rama_rubro_hijo | type: CONSTRAINT --
-- ALTER TABLE plan_cuentas.rama DROP CONSTRAINT IF EXISTS fk_rama_rubro_hijo CASCADE;
ALTER TABLE plan_cuentas.rama ADD CONSTRAINT fk_rama_rubro_hijo FOREIGN KEY (rubro_hijo)
REFERENCES plan_cuentas.rubro (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_fuente_financiamiento_tipo_fuente_financiamiento | type: CONSTRAINT --
-- ALTER TABLE plan_cuentas.fuente_financiamiento DROP CONSTRAINT IF EXISTS fk_fuente_financiamiento_tipo_fuente_financiamiento CASCADE;
ALTER TABLE plan_cuentas.fuente_financiamiento ADD CONSTRAINT fk_fuente_financiamiento_tipo_fuente_financiamiento FOREIGN KEY (tipo_fuente_financiamiento)
REFERENCES plan_cuentas.tipo_fuente_financiamiento (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_fuente_financiamiento_apropiacion_apropiacion | type: CONSTRAINT --
-- ALTER TABLE plan_cuentas.fuente_financiamiento_apropiacion DROP CONSTRAINT IF EXISTS fk_fuente_financiamiento_apropiacion_apropiacion CASCADE;
ALTER TABLE plan_cuentas.fuente_financiamiento_apropiacion ADD CONSTRAINT fk_fuente_financiamiento_apropiacion_apropiacion FOREIGN KEY (apropiacion_id)
REFERENCES plan_cuentas.apropiacion (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_fuente_financiamiento_apropiacion_fuente_financiamiento | type: CONSTRAINT --
-- ALTER TABLE plan_cuentas.fuente_financiamiento_apropiacion DROP CONSTRAINT IF EXISTS fk_fuente_financiamiento_apropiacion_fuente_financiamiento CASCADE;
ALTER TABLE plan_cuentas.fuente_financiamiento_apropiacion ADD CONSTRAINT fk_fuente_financiamiento_apropiacion_fuente_financiamiento FOREIGN KEY (fuente_financiamiento_id)
REFERENCES plan_cuentas.fuente_financiamiento (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: grant_6bb9a6edb6 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE plan_cuentas.apropiacion
   TO postgres WITH GRANT OPTION;
-- ddl-end --

-- object: grant_b647a726f4 | type: PERMISSION --
GRANT CREATE,USAGE
   ON SCHEMA plan_cuentas
   TO postgres WITH GRANT OPTION;
-- ddl-end --


