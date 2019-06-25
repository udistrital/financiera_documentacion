-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.2-alpha1
-- PostgreSQL version: 11.0
-- Project Site: pgmodeler.io
-- Model Author: carlos gutierrez


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: financiera | type: DATABASE --
-- -- DROP DATABASE IF EXISTS financiera;
-- CREATE DATABASE financiera;
-- -- ddl-end --
-- 

-- object: "plan cuentas" | type: SCHEMA --
-- DROP SCHEMA IF EXISTS "plan cuentas" CASCADE;
CREATE SCHEMA "plan cuentas";
-- ddl-end --
ALTER SCHEMA "plan cuentas" OWNER TO postgres;
-- ddl-end --
COMMENT ON SCHEMA "plan cuentas" IS 'esquema para gestion de rubros ';
-- ddl-end --



SET search_path TO pg_catalog,public,"plan cuentas";
-- ddl-end --

-- object: "plan cuentas".rubro | type: TABLE --
-- DROP TABLE IF EXISTS "plan cuentas".rubro CASCADE;
CREATE TABLE "plan cuentas".rubro (
	id serial NOT NULL,
	organizacion integer NOT NULL,
	codigo varchar(50) NOT NULL,
	nombre varchar(250) NOT NULL,
	unidad_ejecutora integer NOT NULL,
	descripcion text,
	CONSTRAINT pk_rubro PRIMARY KEY (id),
	CONSTRAINT uq_organizacion_codigo_unidad_ejecutora_rubro UNIQUE (organizacion,unidad_ejecutora,codigo),
	CONSTRAINT ck_codigo_rubro CHECK (((codigo)::text ~ '^([0-9]+-){0,7}[0-9]+$'::text))

);
-- ddl-end --
COMMENT ON TABLE "plan cuentas".rubro IS 'la tabla rubro almacena la informacion de los rubros (nodos del arbol de rubros)';
-- ddl-end --
COMMENT ON COLUMN "plan cuentas".rubro.id IS 'identificador de la tabla rubro';
-- ddl-end --
COMMENT ON COLUMN "plan cuentas".rubro.organizacion IS 'codigo identificador de la entidad  del distrito para el rubro';
-- ddl-end --
COMMENT ON COLUMN "plan cuentas".rubro.codigo IS 'codigo del rubro de la forma 0-0-0-0... donde se utilizan numeros identificadores para los ancestros del rubro separados por guiones y el ultimo digito es el codigo perteneciente al rubro';
-- ddl-end --
COMMENT ON COLUMN "plan cuentas".rubro.nombre IS 'nombre del rubro';
-- ddl-end --
COMMENT ON COLUMN "plan cuentas".rubro.unidad_ejecutora IS 'unidad ejecutora para el rubro';
-- ddl-end --
COMMENT ON COLUMN "plan cuentas".rubro.descripcion IS 'descripcion adicional del rubro suministrada por el funcionario durante el proceso de registro de rubro';
-- ddl-end --
COMMENT ON CONSTRAINT pk_rubro ON "plan cuentas".rubro  IS 'restriccion llave primaria de rubro';
-- ddl-end --
COMMENT ON CONSTRAINT uq_organizacion_codigo_unidad_ejecutora_rubro ON "plan cuentas".rubro  IS 'restriccion creada para que dentro de la organizacion (entidad del distrito) y a su vez dentro de la unidad ejecutora no puedan existir 2 rubros con un mismo codigo, sin embargo pudiendo existir rubros con el mismo codigo en unidades u organizaciones diferentes.';
-- ddl-end --
COMMENT ON CONSTRAINT ck_codigo_rubro ON "plan cuentas".rubro  IS 'este check se encarga de que los codigos esten restringidos a la forma de 1 a 8 secuencias de digitos 999 separados por guiones -';
-- ddl-end --
ALTER TABLE "plan cuentas".rubro OWNER TO postgres;
-- ddl-end --

-- object: "plan cuentas".rama | type: TABLE --
-- DROP TABLE IF EXISTS "plan cuentas".rama CASCADE;
CREATE TABLE "plan cuentas".rama (
	id serial NOT NULL,
	rubro_padre integer NOT NULL,
	rubro_hijo integer NOT NULL,
	CONSTRAINT pk_rama PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE "plan cuentas".rama IS 'rama almacena relaciones entre los rubros';
-- ddl-end --
COMMENT ON COLUMN "plan cuentas".rama.id IS 'identificador de la tabla rama que almacena relaciones entre rubros';
-- ddl-end --
COMMENT ON COLUMN "plan cuentas".rama.rubro_padre IS 'identificador del rubro que cumple el rol de padre en la relacion';
-- ddl-end --
COMMENT ON COLUMN "plan cuentas".rama.rubro_hijo IS 'identificador del rubro que cumple el rol de hijo en la relacion';
-- ddl-end --
COMMENT ON CONSTRAINT pk_rama ON "plan cuentas".rama  IS 'restriccion de llave primaria de la tabla rama';
-- ddl-end --
ALTER TABLE "plan cuentas".rama OWNER TO postgres;
-- ddl-end --

-- object: fk_rama_rubro_padre | type: CONSTRAINT --
-- ALTER TABLE "plan cuentas".rama DROP CONSTRAINT IF EXISTS fk_rama_rubro_padre CASCADE;
ALTER TABLE "plan cuentas".rama ADD CONSTRAINT fk_rama_rubro_padre FOREIGN KEY (rubro_padre)
REFERENCES "plan cuentas".rubro (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --
COMMENT ON CONSTRAINT fk_rama_rubro_padre ON "plan cuentas".rama  IS 'relacion llave foranea entre la tabla rama y la tabla rubro para el rubro padre';
-- ddl-end --


-- object: fk_rama_rubro_hijo | type: CONSTRAINT --
-- ALTER TABLE "plan cuentas".rama DROP CONSTRAINT IF EXISTS fk_rama_rubro_hijo CASCADE;
ALTER TABLE "plan cuentas".rama ADD CONSTRAINT fk_rama_rubro_hijo FOREIGN KEY (rubro_hijo)
REFERENCES "plan cuentas".rubro (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --
COMMENT ON CONSTRAINT fk_rama_rubro_hijo ON "plan cuentas".rama  IS 'relacion llave foranea entre la tabla rama y la tabla rubro para el rubro hijo';
-- ddl-end --



