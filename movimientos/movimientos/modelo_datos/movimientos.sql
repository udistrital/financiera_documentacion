-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.1
-- PostgreSQL version: 10.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- -- object: test | type: ROLE --
-- -- DROP ROLE IF EXISTS test;
-- CREATE ROLE test WITH 
-- 	SUPERUSER
-- 	CREATEDB
-- 	CREATEROLE
-- 	INHERIT
-- 	LOGIN
-- 	REPLICATION
-- 	BYPASSRLS
-- 	ENCRYPTED PASSWORD '********';
-- -- ddl-end --
-- 

-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: test | type: DATABASE --
-- -- DROP DATABASE IF EXISTS test;
-- CREATE DATABASE test
-- 	ENCODING = 'UTF8'
-- 	LC_COLLATE = 'en_US.utf8'
-- 	LC_CTYPE = 'en_US.utf8'
-- 	TABLESPACE = pg_default
-- 	OWNER = test;
-- -- ddl-end --
-- 

-- object: movimientos | type: SCHEMA --
-- DROP SCHEMA IF EXISTS movimientos CASCADE;
CREATE SCHEMA movimientos;
-- ddl-end --
ALTER SCHEMA movimientos OWNER TO test;
-- ddl-end --

SET search_path TO pg_catalog,public,movimientos;
-- ddl-end --

-- object: movimientos.movimiento_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS movimientos.movimiento_id_seq CASCADE;
CREATE SEQUENCE movimientos.movimiento_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE movimientos.movimiento_id_seq OWNER TO test;
-- ddl-end --

-- object: movimientos.movimiento_proceso_externo | type: TABLE --
-- DROP TABLE IF EXISTS movimientos.movimiento_proceso_externo CASCADE;
CREATE TABLE movimientos.movimiento_proceso_externo(
	id integer NOT NULL DEFAULT nextval('movimientos.movimiento_id_seq'::regclass),
	tipo_movimiento_id integer NOT NULL,
	proceso_externo bigint NOT NULL,
	movimiento_proceso_externo integer,
	CONSTRAINT pk_movimiento PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE movimientos.movimiento_proceso_externo IS 'Entidad que identifica todos los  diferentes movimientos para procesos externos';
-- ddl-end --
COMMENT ON COLUMN movimientos.movimiento_proceso_externo.id IS 'identificador de la tabla movimiento_proceso_externo';
-- ddl-end --
COMMENT ON COLUMN movimientos.movimiento_proceso_externo.tipo_movimiento_id IS 'campo que relaciona a la tabla de tipo de movimiento';
-- ddl-end --
COMMENT ON COLUMN movimientos.movimiento_proceso_externo.proceso_externo IS 'identificador del proceso al que hace referencia este movimiento, por ejemplo apropiaciones, adiciones, traslados, suspensiones, etc';
-- ddl-end --
COMMENT ON COLUMN movimientos.movimiento_proceso_externo.movimiento_proceso_externo IS 'Campo que hace referencia cuando un movimiento involucra más de un ente externo ';
-- ddl-end --
COMMENT ON CONSTRAINT pk_movimiento ON movimientos.movimiento_proceso_externo  IS 'Llave primaria de la entidad movimiento';
-- ddl-end --
ALTER TABLE movimientos.movimiento_proceso_externo OWNER TO test;
-- ddl-end --

-- object: movimientos.movimiento_detalle_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS movimientos.movimiento_detalle_id_seq CASCADE;
CREATE SEQUENCE movimientos.movimiento_detalle_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE movimientos.movimiento_detalle_id_seq OWNER TO test;
-- ddl-end --

-- object: movimientos.movimiento_detalle | type: TABLE --
-- DROP TABLE IF EXISTS movimientos.movimiento_detalle CASCADE;
CREATE TABLE movimientos.movimiento_detalle(
	id integer NOT NULL DEFAULT nextval('movimientos.movimiento_detalle_id_seq'::regclass),
	movimiento_id bigint NOT NULL,
	valor numeric(20,7) NOT NULL,
	fecha_registro date NOT NULL,
	descripcion character varying,
	CONSTRAINT pk_movimiento_detalle PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE movimientos.movimiento_detalle IS 'Entidad que recibe la información detallada de cada movimiento';
-- ddl-end --
COMMENT ON COLUMN movimientos.movimiento_detalle.id IS 'identificador de la tabla movimiento_detalle';
-- ddl-end --
COMMENT ON COLUMN movimientos.movimiento_detalle.movimiento_id IS 'identificador que relaciona la entidad de movimiento';
-- ddl-end --
COMMENT ON COLUMN movimientos.movimiento_detalle.valor IS 'valor que corresponda a un movimiento';
-- ddl-end --
COMMENT ON COLUMN movimientos.movimiento_detalle.fecha_registro IS 'fecha en la que se registra el movimiento';
-- ddl-end --
COMMENT ON COLUMN movimientos.movimiento_detalle.descripcion IS 'descripcion del movimiento';
-- ddl-end --
COMMENT ON CONSTRAINT pk_movimiento_detalle ON movimientos.movimiento_detalle  IS 'Llave primaria de la entidad movimiento_detalle';
-- ddl-end --
ALTER TABLE movimientos.movimiento_detalle OWNER TO test;
-- ddl-end --

-- object: movimientos.tipo_movimiento_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS movimientos.tipo_movimiento_id_seq CASCADE;
CREATE SEQUENCE movimientos.tipo_movimiento_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE movimientos.tipo_movimiento_id_seq OWNER TO test;
-- ddl-end --

-- object: movimientos.tipo_movimiento | type: TABLE --
-- DROP TABLE IF EXISTS movimientos.tipo_movimiento CASCADE;
CREATE TABLE movimientos.tipo_movimiento(
	id integer NOT NULL DEFAULT nextval('movimientos.tipo_movimiento_id_seq'::regclass),
	nombre character varying(20) NOT NULL,
	descripcion character varying,
	acronimo character varying(10) NOT NULL,
	CONSTRAINT pk_tipo_movimiento PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE movimientos.tipo_movimiento IS 'Entidad que se encarga de definir los tipos de movimientos de cada proceso';
-- ddl-end --
COMMENT ON COLUMN movimientos.tipo_movimiento.id IS 'identificador de la tabla tipo_movimiento';
-- ddl-end --
COMMENT ON COLUMN movimientos.tipo_movimiento.nombre IS 'nombre del tipo de movimiento';
-- ddl-end --
COMMENT ON COLUMN movimientos.tipo_movimiento.descripcion IS 'descripcion detallada del tipo de movimiento';
-- ddl-end --
COMMENT ON COLUMN movimientos.tipo_movimiento.acronimo IS 'Acronimo que pueda identificar y se relacione con el nombre del tipo_movimiento';
-- ddl-end --
COMMENT ON CONSTRAINT pk_tipo_movimiento ON movimientos.tipo_movimiento  IS 'Llave primaria de la entidad tipo_movimiento';
-- ddl-end --
ALTER TABLE movimientos.tipo_movimiento OWNER TO test;
-- ddl-end --

-- object: fk_movimiento_tipo_movimiento | type: CONSTRAINT --
-- ALTER TABLE movimientos.movimiento_proceso_externo DROP CONSTRAINT IF EXISTS fk_movimiento_tipo_movimiento CASCADE;
ALTER TABLE movimientos.movimiento_proceso_externo ADD CONSTRAINT fk_movimiento_tipo_movimiento FOREIGN KEY (tipo_movimiento_id)
REFERENCES movimientos.tipo_movimiento (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_movimiento_detalle_movimiento | type: CONSTRAINT --
-- ALTER TABLE movimientos.movimiento_detalle DROP CONSTRAINT IF EXISTS fk_movimiento_detalle_movimiento CASCADE;
ALTER TABLE movimientos.movimiento_detalle ADD CONSTRAINT fk_movimiento_detalle_movimiento FOREIGN KEY (movimiento_id)
REFERENCES movimientos.movimiento_proceso_externo (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --


