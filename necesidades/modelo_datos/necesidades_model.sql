-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.2-beta
-- PostgreSQL version: 11.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- object: crud_user | type: ROLE --
-- DROP ROLE IF EXISTS crud_user;
CREATE ROLE crud_user WITH 
	INHERIT
	LOGIN
	ENCRYPTED PASSWORD '********';
-- ddl-end --

-- object: coasverage_app | type: ROLE --
-- DROP ROLE IF EXISTS coasverage_app;
CREATE ROLE coasverage_app WITH 
	INHERIT
	LOGIN
	ENCRYPTED PASSWORD '********';
-- ddl-end --

-- object: admin_core | type: ROLE --
-- DROP ROLE IF EXISTS admin_core;
CREATE ROLE admin_core WITH 
	INHERIT
	LOGIN
	ENCRYPTED PASSWORD '********';
-- ddl-end --

-- object: admin_coasverage | type: ROLE --
-- DROP ROLE IF EXISTS admin_coasverage;
CREATE ROLE admin_coasverage WITH 
	INHERIT
	LOGIN
	ENCRYPTED PASSWORD '********';
-- ddl-end --

-- object: "soporteDBAjar" | type: ROLE --
-- DROP ROLE IF EXISTS "soporteDBAjar";
CREATE ROLE "soporteDBAjar" WITH 
	SUPERUSER
	INHERIT
	LOGIN
	ENCRYPTED PASSWORD '********';
-- ddl-end --

-- object: "soporteDBAggf" | type: ROLE --
-- DROP ROLE IF EXISTS "soporteDBAggf";
CREATE ROLE "soporteDBAggf" WITH 
	SUPERUSER
	INHERIT
	LOGIN
	ENCRYPTED PASSWORD '********';
-- ddl-end --

-- object: financiera_app | type: ROLE --
-- DROP ROLE IF EXISTS financiera_app;
CREATE ROLE financiera_app WITH 
	INHERIT
	LOGIN
	ENCRYPTED PASSWORD '********';
-- ddl-end --

-- object: financiera_role | type: ROLE --
-- DROP ROLE IF EXISTS financiera_role;
CREATE ROLE financiera_role WITH 
	INHERIT
	ENCRYPTED PASSWORD '********';
-- ddl-end --

-- object: administrativa_app | type: ROLE --
-- DROP ROLE IF EXISTS administrativa_app;
CREATE ROLE administrativa_app WITH 
	INHERIT
	LOGIN
	ENCRYPTED PASSWORD '********';
-- ddl-end --

-- object: administrativa_role | type: ROLE --
-- DROP ROLE IF EXISTS administrativa_role;
CREATE ROLE administrativa_role WITH 
	INHERIT
	ENCRYPTED PASSWORD '********';
-- ddl-end --

-- object: core_app | type: ROLE --
-- DROP ROLE IF EXISTS core_app;
CREATE ROLE core_app WITH 
	INHERIT
	LOGIN
	ENCRYPTED PASSWORD '********';
-- ddl-end --

-- object: core_role | type: ROLE --
-- DROP ROLE IF EXISTS core_role;
CREATE ROLE core_role WITH 
	INHERIT
	ENCRYPTED PASSWORD '********';
-- ddl-end --

-- object: academica_app | type: ROLE --
-- DROP ROLE IF EXISTS academica_app;
CREATE ROLE academica_app WITH 
	INHERIT
	LOGIN
	ENCRYPTED PASSWORD '********';
-- ddl-end --

-- object: academica_role | type: ROLE --
-- DROP ROLE IF EXISTS academica_role;
CREATE ROLE academica_role WITH 
	INHERIT
	ENCRYPTED PASSWORD '********';
-- ddl-end --


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: udistrital_core_db | type: DATABASE --
-- -- DROP DATABASE IF EXISTS udistrital_core_db;
-- CREATE DATABASE udistrital_core_db
-- 	ENCODING = 'UTF8'
-- 	LC_COLLATE = 'en_US'
-- 	LC_CTYPE = 'en_US'
-- 	TABLESPACE = pg_default
-- 	OWNER = postgres;
-- -- ddl-end --
-- 

-- object: core | type: SCHEMA --
-- DROP SCHEMA IF EXISTS core CASCADE;
CREATE SCHEMA core;
-- ddl-end --
ALTER SCHEMA core OWNER TO admin_core;
-- ddl-end --

-- object: financiera | type: SCHEMA --
-- DROP SCHEMA IF EXISTS financiera CASCADE;
CREATE SCHEMA financiera;
-- ddl-end --
ALTER SCHEMA financiera OWNER TO admin_core;
-- ddl-end --
COMMENT ON SCHEMA financiera IS 'esquema para el módulo presupuestal del sistema financiero';
-- ddl-end --

-- object: administrativa | type: SCHEMA --
-- DROP SCHEMA IF EXISTS administrativa CASCADE;
CREATE SCHEMA administrativa;
-- ddl-end --
ALTER SCHEMA administrativa OWNER TO admin_core;
-- ddl-end --

-- object: necesidades_metas | type: SCHEMA --
-- DROP SCHEMA IF EXISTS necesidades_metas CASCADE;
CREATE SCHEMA necesidades_metas;
-- ddl-end --
ALTER SCHEMA necesidades_metas OWNER TO postgres;
-- ddl-end --

SET search_path TO pg_catalog,public,core,financiera,administrativa,necesidades_metas;
-- ddl-end --

-- object: financiera.apropiacion | type: TABLE --
-- DROP TABLE IF EXISTS financiera.apropiacion CASCADE;
CREATE TABLE financiera.apropiacion (
	id integer NOT NULL DEFAULT nextval('nix_presupuesto.apropiacion_id_seq'::regclass),
	vigencia numeric(4,0) NOT NULL,
	rubro integer NOT NULL,
	valor numeric(30,5) NOT NULL,
	estado integer NOT NULL DEFAULT 1,
	CONSTRAINT pk_apropiacion PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE financiera.apropiacion IS 'apropiaciones iniciales';
-- ddl-end --
COMMENT ON COLUMN financiera.apropiacion.id IS 'identificador de la apropiación';
-- ddl-end --
COMMENT ON COLUMN financiera.apropiacion.vigencia IS 'año de la vigencia';
-- ddl-end --
COMMENT ON COLUMN financiera.apropiacion.rubro IS 'rubro asociado';
-- ddl-end --
COMMENT ON COLUMN financiera.apropiacion.valor IS 'valor de la apropiación';
-- ddl-end --
ALTER TABLE financiera.apropiacion OWNER TO admin_core;
-- ddl-end --

-- object: financiera.fuente_financiamiento | type: TABLE --
-- DROP TABLE IF EXISTS financiera.fuente_financiamiento CASCADE;
CREATE TABLE financiera.fuente_financiamiento (
	id integer NOT NULL DEFAULT nextval('nix_presupuesto.fuente_financiacion_id_seq'::regclass),
	descripcion character varying(250),
	nombre character varying(250) NOT NULL,
	codigo character varying(6) NOT NULL,
	tipo_fuente_financiamiento integer,
	CONSTRAINT pk_fuente_financiamiento PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE financiera.fuente_financiamiento IS 'tabla en la que se registran las fuentes de financiamiento que maneja la universidad distrital';
-- ddl-end --
COMMENT ON COLUMN financiera.fuente_financiamiento.id IS 'identificador de la Fuente de financiamiento';
-- ddl-end --
COMMENT ON COLUMN financiera.fuente_financiamiento.descripcion IS 'descrpcion de la fuente de financiamiento ';
-- ddl-end --
COMMENT ON COLUMN financiera.fuente_financiamiento.nombre IS 'nombre de la Fuente de financiamiento';
-- ddl-end --
COMMENT ON COLUMN financiera.fuente_financiamiento.codigo IS 'codigo de la Fuente de financiamiento que utiliza la universidad distrital';
-- ddl-end --
ALTER TABLE financiera.fuente_financiamiento OWNER TO admin_core;
-- ddl-end --

-- object: financiera.disponibilidad | type: TABLE --
-- DROP TABLE IF EXISTS financiera.disponibilidad CASCADE;
CREATE TABLE financiera.disponibilidad (
	id integer NOT NULL DEFAULT nextval('nix_presupuesto.disponibilidad_id_seq'::regclass),
	vigencia numeric(4,0) NOT NULL,
	numero_disponibilidad numeric(6,0) NOT NULL,
	responsable integer NOT NULL,
	fecha_registro date NOT NULL,
	estado smallint NOT NULL,
	solicitud integer NOT NULL,
	CONSTRAINT pk_id_entidad PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE financiera.disponibilidad IS 'tabla de registro de los CDP expedidos';
-- ddl-end --
COMMENT ON COLUMN financiera.disponibilidad.id IS 'identificador de la disponibilidad';
-- ddl-end --
COMMENT ON COLUMN financiera.disponibilidad.vigencia IS 'Vigencia de la disponibilidad';
-- ddl-end --
COMMENT ON COLUMN financiera.disponibilidad.numero_disponibilidad IS 'número de la disponibilidad';
-- ddl-end --
COMMENT ON COLUMN financiera.disponibilidad.responsable IS 'Referencia a al responsable de presupuesto.';
-- ddl-end --
COMMENT ON COLUMN financiera.disponibilidad.fecha_registro IS 'fecha de registro de la disponibilidad';
-- ddl-end --
COMMENT ON COLUMN financiera.disponibilidad.estado IS 'paramétrica estado disponibilidad';
-- ddl-end --
ALTER TABLE financiera.disponibilidad OWNER TO admin_core;
-- ddl-end --

-- object: administrativa.necesidad | type: TABLE --
-- DROP TABLE IF EXISTS administrativa.necesidad CASCADE;
CREATE TABLE administrativa.necesidad (
	id integer NOT NULL DEFAULT nextval('administrativa.necesidad_id_seq'::regclass),
	numero integer,
	vigencia numeric(4,0) NOT NULL,
	objeto character varying(700) NOT NULL,
	fecha_solicitud timestamp NOT NULL,
	valor numeric(16,0) NOT NULL,
	justificacion character varying(600) NOT NULL,
	unidad_ejecutora integer NOT NULL,
	dias_duracion numeric(4,0) NOT NULL DEFAULT 0,
	unico_pago boolean NOT NULL DEFAULT false,
	agotar_presupuesto boolean NOT NULL DEFAULT false,
	modalidad_seleccion integer NOT NULL,
	tipo_contrato_necesidad integer NOT NULL,
	plan_anual_adquisiciones integer NOT NULL,
	estudio_mercado character varying(600),
	tipo_financiacion_necesidad integer NOT NULL,
	analisis_riesgo character varying(600),
	numero_elaboracion integer NOT NULL,
	fecha_modificacion timestamp NOT NULL,
	estado_necesidad integer NOT NULL,
	supervisor integer NOT NULL,
	tipo_necesidad integer NOT NULL,
	justificacion_rechazo character varying(600),
	justificacion_anulacion character varying(600),
	CONSTRAINT solicitud_necesidad_pk PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE administrativa.necesidad IS 'Tabla encargada de gestionar la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.id IS 'Identificador del registro de la solicitud de necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.numero IS 'Número consecutivo de la solicitud de necesidad. Se reinicia al empezar el año, solo se asignara a solicitudes con estado de "Enviadas"';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.vigencia IS 'Año de realización de la solicitud';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.objeto IS 'Objeto del contrato a realizar';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.fecha_solicitud IS 'Fecha de realización de la solicitud de necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.valor IS 'Valor total por el cual se solicita la necesidad (en pesos)';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.justificacion IS 'Justificación del objeto contractual a realizar';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.unidad_ejecutora IS 'Id de la unidad ejecutora de la necesidad solicitada';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.dias_duracion IS 'días de duración del contrato (se guardan solo los días, los meses corresponden a 30 días y los años a 360). Sólo es 0 en caso que sea Único Pago o Hasta Agotar Presupuesto';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.unico_pago IS 'Caso especial de los días de duración, si es verdadero Hasta Agotar Presupuesto es falso y los días son 0';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.agotar_presupuesto IS 'Caso especial de los días de duración, si es verdadero Único Pago es falso y los días son 0';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.modalidad_seleccion IS 'Identificador de la modalidad de selección aplicada a la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.tipo_contrato_necesidad IS 'Identificador del tipo de contrato requerido en la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.plan_anual_adquisiciones IS 'Plan anual de adquisiciones de la entidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.estudio_mercado IS 'Estudio de mercado realizado para tener un panorama claro sobe la necesidad en cuestión';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.tipo_financiacion_necesidad IS 'Identificador del tipo de financiacion a utilizar en la necesidad, si se elige inversion se podran seleccionar fuentes de financiacion caso contrario a elegir financiamiento';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.analisis_riesgo IS 'Análisis de riesgos de la necesidad solicitada';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.numero_elaboracion IS 'Numero de elaboracion de la necesidad, se reinicia con el cambio de vigencia, una vez que se cambie el estado a "Enviada" se asigna un numero de necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.fecha_modificacion IS 'Fecha de la ultima modificacion de estado de la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.estado_necesidad IS 'Estado actual de la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.supervisor IS 'Llave foránea de um_id de la tabla um.um_hybrid_role referenciando el supervisor de una solicitud de la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.tipo_necesidad IS 'Llave foránea de administrativa.tipo_necesidad en el que como su nombre lo indica es el tipo de necesidad que se ha creado.';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.justificacion_rechazo IS 'Justificación del rechazo de la necesidad, es un atributo nulo si no se encuentra la necesidad en este estado.';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad.justificacion_anulacion IS 'Justificación dela anulación de la necesidad, es un atributo nulo si no se encuentra la necesidad en este estado. La necesidad sólo se puede anular si el CDP no se ha expedido o ya ha sido completamente anulado.';
-- ddl-end --
COMMENT ON CONSTRAINT solicitud_necesidad_pk ON administrativa.necesidad  IS 'Llave primaria de la solicitud de necesidad';
-- ddl-end --
ALTER TABLE administrativa.necesidad OWNER TO admin_core;
-- ddl-end --

-- object: administrativa.estado_necesidad | type: TABLE --
-- DROP TABLE IF EXISTS administrativa.estado_necesidad CASCADE;
CREATE TABLE administrativa.estado_necesidad (
	id integer NOT NULL DEFAULT nextval('administrativa.estado_necesidad_id_seq'::regclass),
	nombre character varying(20) NOT NULL,
	descripcion character varying(250),
	codigo_abreviacion character varying(20),
	estado boolean NOT NULL,
	numero_orden numeric(5,2),
	CONSTRAINT pk_estado_necesidad PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE administrativa.estado_necesidad IS 'Tabla encargada de gestionar los estados posibles para una solicitud de la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.estado_necesidad.id IS 'Identificador del registro del estado de la solicitud de necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.estado_necesidad.nombre IS 'Nombre del estado de la solicitud de necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.estado_necesidad.descripcion IS 'Descripción corta del estado de la solicitud';
-- ddl-end --
COMMENT ON COLUMN administrativa.estado_necesidad.codigo_abreviacion IS 'Codigo de abreviación de los estados de la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.estado_necesidad.estado IS 'Estado de los estados de la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.estado_necesidad.numero_orden IS 'Número orden de los estados de la necesidad';
-- ddl-end --
COMMENT ON CONSTRAINT pk_estado_necesidad ON administrativa.estado_necesidad  IS 'Llave primaria del estado de solicitud de necesidad';
-- ddl-end --
ALTER TABLE administrativa.estado_necesidad OWNER TO admin_core;
-- ddl-end --

-- object: administrativa.actividad_solicitud_necesidad | type: TABLE --
-- DROP TABLE IF EXISTS administrativa.actividad_solicitud_necesidad CASCADE;
CREATE TABLE administrativa.actividad_solicitud_necesidad (
	id integer NOT NULL DEFAULT nextval('administrativa.actividad_solicitud_necesidad_id_seq'::regclass),
	actividad integer NOT NULL,
	monto_parcial numeric(16,0) NOT NULL,
	necesidad integer NOT NULL,
	CONSTRAINT pk_actividad_solicitud_necesidad PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE administrativa.actividad_solicitud_necesidad IS 'Tabla encargada de gestionar las actividades posibles para una solicitud de la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.actividad_solicitud_necesidad.id IS 'Identificador del registro de la actividad de la solicitud de necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.actividad_solicitud_necesidad.actividad IS 'Identificador de la actividad asociada al centro de costos';
-- ddl-end --
COMMENT ON COLUMN administrativa.actividad_solicitud_necesidad.monto_parcial IS 'Monto para la actividad (en pesos)';
-- ddl-end --
COMMENT ON CONSTRAINT pk_actividad_solicitud_necesidad ON administrativa.actividad_solicitud_necesidad  IS 'Llave primaria de la actividad de solicitud de necesidad';
-- ddl-end --
ALTER TABLE administrativa.actividad_solicitud_necesidad OWNER TO admin_core;
-- ddl-end --

-- object: administrativa.especificacion_tecnica | type: TABLE --
-- DROP TABLE IF EXISTS administrativa.especificacion_tecnica CASCADE;
CREATE TABLE administrativa.especificacion_tecnica (
	id integer NOT NULL DEFAULT nextval('administrativa.especificacion_tecnica_id_seq'::regclass),
	catalogo integer NOT NULL,
	necesidad integer NOT NULL,
	elemento character varying(250),
	unidad integer NOT NULL,
	iva integer NOT NULL,
	valor numeric(16,0) NOT NULL,
	cantidad integer NOT NULL,
	CONSTRAINT pk_especificacion_tecnica PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE administrativa.especificacion_tecnica IS 'Tabla encargada de gestionar las especificaciones técnicas posibles para una solicitud de la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.especificacion_tecnica.id IS 'Identificador del registro de la especificación técnica de la solicitud de necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.especificacion_tecnica.catalogo IS 'Llave foránea de arka.subgrupo referenciando el identificador del catálogo de productos proveniente del sistema Arka';
-- ddl-end --
COMMENT ON COLUMN administrativa.especificacion_tecnica.necesidad IS 'Identificador de la solicitud de la necesidad a la que se le asocia la especificación técnica';
-- ddl-end --
COMMENT ON COLUMN administrativa.especificacion_tecnica.elemento IS 'Elemento a solicitar en la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.especificacion_tecnica.unidad IS 'Llave foránea de core.unidad referenciando el identificador de la unidad del (los) elemento(s)';
-- ddl-end --
COMMENT ON COLUMN administrativa.especificacion_tecnica.iva IS 'Llave foránea de core.iva referenciando el identificador del iva del elemento';
-- ddl-end --
COMMENT ON COLUMN administrativa.especificacion_tecnica.valor IS 'Valor unitario del elemento';
-- ddl-end --
COMMENT ON COLUMN administrativa.especificacion_tecnica.cantidad IS 'Cantidad de elementos que se piden en este registro para la necesidad en cuestión';
-- ddl-end --
COMMENT ON CONSTRAINT pk_especificacion_tecnica ON administrativa.especificacion_tecnica  IS 'Llave primaria de la especificación técnica de solicitud de necesidad';
-- ddl-end --
ALTER TABLE administrativa.especificacion_tecnica OWNER TO admin_core;
-- ddl-end --

-- object: administrativa.requisito_minimo | type: TABLE --
-- DROP TABLE IF EXISTS administrativa.requisito_minimo CASCADE;
CREATE TABLE administrativa.requisito_minimo (
	id integer NOT NULL DEFAULT nextval('administrativa.requisito_minimo_id_seq'::regclass),
	especificacion_tecnica integer NOT NULL,
	descripcion character varying(250) NOT NULL,
	CONSTRAINT pk_requisito_minimo PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE administrativa.requisito_minimo IS 'Tabla encargada de gestionar los requisitos mínimos asociados a una especificación técnica para una solicitud de la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.requisito_minimo.id IS 'Identificador del registro del requisito mínimo de la especificación técnica para la solicitud';
-- ddl-end --
COMMENT ON COLUMN administrativa.requisito_minimo.especificacion_tecnica IS 'Id de la especificación técnica asociada al requisito mínimo';
-- ddl-end --
COMMENT ON COLUMN administrativa.requisito_minimo.descripcion IS 'Descripción del requisito mínimo de la especificación técnica para la solicitud';
-- ddl-end --
COMMENT ON CONSTRAINT pk_requisito_minimo ON administrativa.requisito_minimo  IS 'Llave primaria del requisito mínimo de la especificación técnica para la solicitud de la necesidad';
-- ddl-end --
ALTER TABLE administrativa.requisito_minimo OWNER TO admin_core;
-- ddl-end --

-- object: administrativa.marco_legal | type: TABLE --
-- DROP TABLE IF EXISTS administrativa.marco_legal CASCADE;
CREATE TABLE administrativa.marco_legal (
	id integer NOT NULL DEFAULT nextval('administrativa.marco_legal_id_seq'::regclass),
	enlace character varying(100) NOT NULL,
	nombre_documento character varying(50) NOT NULL,
	CONSTRAINT pk_marco_legal PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE administrativa.marco_legal IS 'Tabla encargada de gestionar los marcos legales posibles para una solicitud de la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.marco_legal.id IS 'Identificador del registro del marco legal de la solicitud de necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.marco_legal.enlace IS 'URL del documento determinado como marco legal para la solicitud en formato PDF';
-- ddl-end --
COMMENT ON COLUMN administrativa.marco_legal.nombre_documento IS 'Nombre del documento determinado como marco legal para la solicitud de necesidad';
-- ddl-end --
COMMENT ON CONSTRAINT pk_marco_legal ON administrativa.marco_legal  IS 'LLave primaria del marco legal de solicitud de necesidad';
-- ddl-end --
ALTER TABLE administrativa.marco_legal OWNER TO admin_core;
-- ddl-end --

-- object: administrativa.fuente_financiacion_rubro_necesidad | type: TABLE --
-- DROP TABLE IF EXISTS administrativa.fuente_financiacion_rubro_necesidad CASCADE;
CREATE TABLE administrativa.fuente_financiacion_rubro_necesidad (
	id integer NOT NULL DEFAULT nextval('administrativa.fuente_financiacion_rubro_necesidad_id_seq'::regclass),
	fuente_financiamiento integer,
	apropiacion integer NOT NULL,
	monto_parcial numeric(16,0) NOT NULL,
	necesidad integer NOT NULL,
	CONSTRAINT pk_fuente_financiacion_rubro_necesidad PRIMARY KEY (id),
	CONSTRAINT uk_fuente_financiacion_rubro_necesidad UNIQUE (fuente_financiamiento,apropiacion,necesidad)

);
-- ddl-end --
COMMENT ON TABLE administrativa.fuente_financiacion_rubro_necesidad IS 'Tabla encargada de gestionar las fuentes de financiación asociadas a un rubro para una solicitud de la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.fuente_financiacion_rubro_necesidad.id IS 'Identificador del registro de la fuente de financiación del rubro para la solicitud';
-- ddl-end --
COMMENT ON COLUMN administrativa.fuente_financiacion_rubro_necesidad.fuente_financiamiento IS 'Llave foránea de  financiera.fuente_financiamiento que referencia el identificador de la fuente de financiación asociada al rubro';
-- ddl-end --
COMMENT ON COLUMN administrativa.fuente_financiacion_rubro_necesidad.apropiacion IS 'Llave foránea de financiera.apropiacion que referencia el identificador de la apropiacion la cual indica el rubro del cual proviene la fuente de financiamiento para la solicitud)';
-- ddl-end --
COMMENT ON COLUMN administrativa.fuente_financiacion_rubro_necesidad.monto_parcial IS 'Monto de la fuente de financiación (en pesos)';
-- ddl-end --
COMMENT ON COLUMN administrativa.fuente_financiacion_rubro_necesidad.necesidad IS 'Llave foránea de la necesidad';
-- ddl-end --
COMMENT ON CONSTRAINT pk_fuente_financiacion_rubro_necesidad ON administrativa.fuente_financiacion_rubro_necesidad  IS 'Llave primaria de la fuente de financiación del rubro para la solicitud de necesidad';
-- ddl-end --
COMMENT ON CONSTRAINT uk_fuente_financiacion_rubro_necesidad ON administrativa.fuente_financiacion_rubro_necesidad  IS 'Llave unica entre la necesidad, la apropiacion y la fuente de financiacimiento';
-- ddl-end --
ALTER TABLE administrativa.fuente_financiacion_rubro_necesidad OWNER TO admin_core;
-- ddl-end --

-- object: administrativa.marco_legal_necesidad | type: TABLE --
-- DROP TABLE IF EXISTS administrativa.marco_legal_necesidad CASCADE;
CREATE TABLE administrativa.marco_legal_necesidad (
	id integer NOT NULL DEFAULT nextval('administrativa.marco_legal_necesidad_id_seq'::regclass),
	marco_legal integer NOT NULL,
	necesidad integer NOT NULL,
	CONSTRAINT pk_marco_legal_necesidad PRIMARY KEY (id),
	CONSTRAINT uk_marco_legal_necesidad UNIQUE (marco_legal,necesidad)

);
-- ddl-end --
COMMENT ON TABLE administrativa.marco_legal_necesidad IS 'Tabla de rompimiento entre el marco legal y la solicitud de necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.marco_legal_necesidad.id IS 'Identificador del registro de la tabla de rompimiento entre marco legal y solicitud de necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.marco_legal_necesidad.marco_legal IS 'Identificador del marco legal asociado a la solicitud de la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.marco_legal_necesidad.necesidad IS 'Identificador de la solicitud de necesidad a la cual se le determina el marco legal';
-- ddl-end --
COMMENT ON CONSTRAINT pk_marco_legal_necesidad ON administrativa.marco_legal_necesidad  IS 'Llave primaria de la tabla de rompimiento entre marco legal y solicitud de necesidad';
-- ddl-end --
COMMENT ON CONSTRAINT uk_marco_legal_necesidad ON administrativa.marco_legal_necesidad  IS 'Llaves únicas de la tabla (marco legal y solicitud de necesidad)';
-- ddl-end --
ALTER TABLE administrativa.marco_legal_necesidad OWNER TO admin_core;
-- ddl-end --

-- object: administrativa.modalidad_seleccion | type: TABLE --
-- DROP TABLE IF EXISTS administrativa.modalidad_seleccion CASCADE;
CREATE TABLE administrativa.modalidad_seleccion (
	id integer NOT NULL DEFAULT nextval('administrativa.modalidad_seleccion_id_seq'::regclass),
	nombre character varying(50) NOT NULL,
	descripcion character varying(250),
	codigo_abreviacion character varying(20),
	estado boolean NOT NULL,
	numero_orden numeric(5,2),
	CONSTRAINT pk_modalidad_seleccion PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE administrativa.modalidad_seleccion IS 'Tabla encargada de gestionar las modalidades de selección posibles para una solicitud de la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.modalidad_seleccion.id IS 'Identificador del registro de la modalidad de selección de la solicitud de necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.modalidad_seleccion.nombre IS 'Nombre de la modalidad de selección de la solicitud de necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.modalidad_seleccion.descripcion IS 'Descripción corta de la modalidad de selección de la solicitud';
-- ddl-end --
COMMENT ON COLUMN administrativa.modalidad_seleccion.codigo_abreviacion IS 'Código abreviación de la modalidad de selección';
-- ddl-end --
COMMENT ON COLUMN administrativa.modalidad_seleccion.estado IS 'Estado de la modalidad de selección';
-- ddl-end --
COMMENT ON COLUMN administrativa.modalidad_seleccion.numero_orden IS 'Número de orden de la modalidad de selección';
-- ddl-end --
COMMENT ON CONSTRAINT pk_modalidad_seleccion ON administrativa.modalidad_seleccion  IS 'Llave primaria de la modalidad de selección de solicitud de necesidad';
-- ddl-end --
ALTER TABLE administrativa.modalidad_seleccion OWNER TO admin_core;
-- ddl-end --

-- object: administrativa.tipo_financiacion_necesidad | type: TABLE --
-- DROP TABLE IF EXISTS administrativa.tipo_financiacion_necesidad CASCADE;
CREATE TABLE administrativa.tipo_financiacion_necesidad (
	id integer NOT NULL DEFAULT nextval('administrativa.tipo_financiacion_necesidad_id_seq'::regclass),
	nombre character varying(50) NOT NULL,
	descripcion character varying(250),
	codigo_abreviacion character varying(20),
	estado boolean NOT NULL,
	numero_orden numeric(5,2),
	CONSTRAINT pk_tipo_fuente_financiacion PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE administrativa.tipo_financiacion_necesidad IS 'Tabla encargada de gestionar los tipos de financiacion para una necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.tipo_financiacion_necesidad.id IS 'Identificador del registro del tipo de financiacion de una necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.tipo_financiacion_necesidad.nombre IS 'Nombre del tipo de financiacion de la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.tipo_financiacion_necesidad.descripcion IS 'Descripción corta del tipo de financiacion de la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.tipo_financiacion_necesidad.codigo_abreviacion IS 'codigo_abreviacion del tipo de financiacion de la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.tipo_financiacion_necesidad.estado IS 'Estado del tipo de financiacion de la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.tipo_financiacion_necesidad.numero_orden IS 'Número de orden del tipo de financiacion de la necesidad';
-- ddl-end --
COMMENT ON CONSTRAINT pk_tipo_fuente_financiacion ON administrativa.tipo_financiacion_necesidad  IS 'Llave primaria de la tabla tipo_fuente_financiacion';
-- ddl-end --
ALTER TABLE administrativa.tipo_financiacion_necesidad OWNER TO admin_core;
-- ddl-end --

-- object: administrativa.actividad_economica_necesidad | type: TABLE --
-- DROP TABLE IF EXISTS administrativa.actividad_economica_necesidad CASCADE;
CREATE TABLE administrativa.actividad_economica_necesidad (
	id integer NOT NULL DEFAULT nextval('administrativa.actividad_economica_necesidad_id_seq'::regclass),
	necesidad integer NOT NULL,
	actividad_economica integer NOT NULL,
	CONSTRAINT pk_actividad_economica_necesidad PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE administrativa.actividad_economica_necesidad IS 'Tabla de rompimiento entre la necesidad y las activiades económicas';
-- ddl-end --
COMMENT ON COLUMN administrativa.actividad_economica_necesidad.id IS 'Identificador de la tabla de rompimiento entre la necesidad y las actividades economicas';
-- ddl-end --
COMMENT ON COLUMN administrativa.actividad_economica_necesidad.necesidad IS 'Identificador de la necesidad a la que van a ir asociadas las actividades economicas';
-- ddl-end --
COMMENT ON COLUMN administrativa.actividad_economica_necesidad.actividad_economica IS 'Identificador de la actividad economica de menor jerarquía que se asocia a una necesidad (ciiu_subclase)';
-- ddl-end --
COMMENT ON CONSTRAINT pk_actividad_economica_necesidad ON administrativa.actividad_economica_necesidad  IS 'Llave primaria de la tabla de rompimiento entre las actividades economicas y solicitud de necesidad';
-- ddl-end --
ALTER TABLE administrativa.actividad_economica_necesidad OWNER TO admin_core;
-- ddl-end --

-- object: financiera.unidad_ejecutora | type: TABLE --
-- DROP TABLE IF EXISTS financiera.unidad_ejecutora CASCADE;
CREATE TABLE financiera.unidad_ejecutora (
	id integer NOT NULL,
	nombre character varying(300),
	descripcion character varying(500),
	entidad integer NOT NULL,
	CONSTRAINT pk_unidad_ejecutora PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE financiera.unidad_ejecutora IS 'tabla que almacena las unidades ejecutoras involucradas en el sistema';
-- ddl-end --
COMMENT ON COLUMN financiera.unidad_ejecutora.id IS 'identificador unico de la unidad ejecutora';
-- ddl-end --
COMMENT ON COLUMN financiera.unidad_ejecutora.nombre IS 'nombre de la unidad ejecutora';
-- ddl-end --
COMMENT ON COLUMN financiera.unidad_ejecutora.descripcion IS 'descripcion de la unidad ejecutora ';
-- ddl-end --
COMMENT ON COLUMN financiera.unidad_ejecutora.entidad IS 'identificador de la tabla entidad que se referncia para saber a que entidad corresponde la unidad ejecutora';
-- ddl-end --
ALTER TABLE financiera.unidad_ejecutora OWNER TO admin_core;
-- ddl-end --

-- object: financiera.fuente_financiamiento_apropiacion | type: TABLE --
-- DROP TABLE IF EXISTS financiera.fuente_financiamiento_apropiacion CASCADE;
CREATE TABLE financiera.fuente_financiamiento_apropiacion (
	id integer NOT NULL DEFAULT nextval('financiera.fuente_financiacion_apropiacion_id_seq'::regclass),
	apropiacion integer NOT NULL,
	fuente_financiamiento integer NOT NULL,
	dependencia integer NOT NULL,
	CONSTRAINT pk_fuente_financiamiento_apropiacion PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE financiera.fuente_financiamiento_apropiacion IS 'tabla en la que se realiza un registro donde se relaciona la fuente de financiamiento, apropiacion y dependencia para ingresarle dinero a la fuente';
-- ddl-end --
COMMENT ON COLUMN financiera.fuente_financiamiento_apropiacion.id IS 'Identificador de la tabla fuente_financiamiento_apropiacion';
-- ddl-end --
COMMENT ON COLUMN financiera.fuente_financiamiento_apropiacion.apropiacion IS 'identificador de la tabla apropiacion que indica a que apropiacion se asigna el recurso';
-- ddl-end --
COMMENT ON COLUMN financiera.fuente_financiamiento_apropiacion.fuente_financiamiento IS 'identificador de la tabla fuente_financiamiento que indica a que fuente se le aigna el recurso ';
-- ddl-end --
COMMENT ON COLUMN financiera.fuente_financiamiento_apropiacion.dependencia IS 'identificador de la dependencia en el cual no se tiene una relacion directamente, sino se trabaja por el cliente';
-- ddl-end --
ALTER TABLE financiera.fuente_financiamiento_apropiacion OWNER TO admin_core;
-- ddl-end --

-- object: administrativa.tipo_contrato_necesidad | type: TABLE --
-- DROP TABLE IF EXISTS administrativa.tipo_contrato_necesidad CASCADE;
CREATE TABLE administrativa.tipo_contrato_necesidad (
	id integer NOT NULL DEFAULT nextval('administrativa.servicio_id_seq'::regclass),
	nombre character varying(50) NOT NULL,
	descripcion character varying(250),
	codigo_abreviacion character varying(20),
	estado boolean NOT NULL,
	numero_orden numeric(5,2),
	CONSTRAINT pk_servicio PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE administrativa.tipo_contrato_necesidad IS 'Tabla encargada de gestionar los tipos de contrato de la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.tipo_contrato_necesidad.id IS 'Identificador del registro del servicio de la solicitud de necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.tipo_contrato_necesidad.nombre IS 'Nombre del tipo de contrato de la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.tipo_contrato_necesidad.descripcion IS 'Descripción del tipo de contrato de la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.tipo_contrato_necesidad.codigo_abreviacion IS 'Código de abreviación del tipo de contrato de la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.tipo_contrato_necesidad.estado IS 'Estado del tipo de contrato de la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.tipo_contrato_necesidad.numero_orden IS 'Número de orden del tipo de contrato de la necesidad';
-- ddl-end --
COMMENT ON CONSTRAINT pk_servicio ON administrativa.tipo_contrato_necesidad  IS 'Llave foránea del servicio de solicitud de necesidad (servicio.id y necesidad.servicio)';
-- ddl-end --
ALTER TABLE administrativa.tipo_contrato_necesidad OWNER TO admin_core;
-- ddl-end --

-- object: administrativa.solicitud_disponibilidad | type: TABLE --
-- DROP TABLE IF EXISTS administrativa.solicitud_disponibilidad CASCADE;
CREATE TABLE administrativa.solicitud_disponibilidad (
	id integer NOT NULL DEFAULT nextval('administrativa.solicitud_disponibilidad_id_seq'::regclass),
	numero integer NOT NULL,
	vigencia numeric(4,0) NOT NULL,
	fecha_solicitud timestamp NOT NULL,
	necesidad integer NOT NULL,
	expedida boolean NOT NULL DEFAULT false,
	justificacion_rechazo character varying(250),
	CONSTRAINT pk_solicitud_disponibilidad PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE administrativa.solicitud_disponibilidad IS 'Tabla encargada de gestionar la solicitud de la disponibilidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.solicitud_disponibilidad.id IS 'Identificador del registro de la solicitud de disponibilidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.solicitud_disponibilidad.numero IS 'Número consecutivo de la solicitud de disponibilidad. Se reinicia al empezar el año';
-- ddl-end --
COMMENT ON COLUMN administrativa.solicitud_disponibilidad.vigencia IS 'Año de realización de la solicitud de disponibilidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.solicitud_disponibilidad.fecha_solicitud IS 'Fecha de realización de la solicitud de disponibilidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.solicitud_disponibilidad.necesidad IS 'Identificador de la necesidad de la cual proviene la isponibilidad (Para crear una disponibilidad, el estado de la necesidad debe ser aprobado)';
-- ddl-end --
COMMENT ON COLUMN administrativa.solicitud_disponibilidad.expedida IS 'Booleano que identifica si la solicitud de cdp ya ha sido expedida o no';
-- ddl-end --
COMMENT ON COLUMN administrativa.solicitud_disponibilidad.justificacion_rechazo IS 'Justificación de rechazo de la solicitud de disponibilidad, si la solicitud es aprobada se debe dejar este campo nulo.';
-- ddl-end --
COMMENT ON CONSTRAINT pk_solicitud_disponibilidad ON administrativa.solicitud_disponibilidad  IS 'Llave primaria de la solicitud de disponibildiad';
-- ddl-end --
ALTER TABLE administrativa.solicitud_disponibilidad OWNER TO admin_core;
-- ddl-end --

-- object: administrativa.actividad_especifica | type: TABLE --
-- DROP TABLE IF EXISTS administrativa.actividad_especifica CASCADE;
CREATE TABLE administrativa.actividad_especifica (
	id integer NOT NULL DEFAULT nextval('administrativa.actividad_especifica_id_seq'::regclass),
	descripcion character varying(250) NOT NULL,
	necesidad integer NOT NULL,
	CONSTRAINT pk_actividad_especifica PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE administrativa.actividad_especifica IS 'Tabla encargada de registrar todas las actividades especificas de una necesidad (Un registro por necesidad) y solo sera visible si el tipo de servicio es un "Servicio" y no compra o arriendo';
-- ddl-end --
COMMENT ON COLUMN administrativa.actividad_especifica.id IS 'Identificador serial de la tabla de actividades especificas';
-- ddl-end --
COMMENT ON COLUMN administrativa.actividad_especifica.descripcion IS 'Descripcion de la actividad especifica que se diligencia a la necesidad (Puede ser mas de una y cada una genera un nuevo registro en la tabla)';
-- ddl-end --
COMMENT ON COLUMN administrativa.actividad_especifica.necesidad IS 'Llave foránea de la necesidad (id)';
-- ddl-end --
COMMENT ON CONSTRAINT pk_actividad_especifica ON administrativa.actividad_especifica  IS 'Llave foránea de la necesidad a la cual corresponde la actividad especifica';
-- ddl-end --
ALTER TABLE administrativa.actividad_especifica OWNER TO admin_core;
-- ddl-end --

-- object: administrativa.dependencia_necesidad | type: TABLE --
-- DROP TABLE IF EXISTS administrativa.dependencia_necesidad CASCADE;
CREATE TABLE administrativa.dependencia_necesidad (
	id integer NOT NULL DEFAULT nextval('administrativa.dependencia_necesidad_id_seq'::regclass),
	jefe_dependencia_solicitante integer NOT NULL,
	jefe_dependencia_destino integer NOT NULL,
	necesidad integer NOT NULL,
	ordenador_gasto integer NOT NULL,
	CONSTRAINT pk_dependencia_necesidad PRIMARY KEY (id),
	CONSTRAINT uk_dependencia_necesidad UNIQUE (necesidad)

);
-- ddl-end --
COMMENT ON TABLE administrativa.dependencia_necesidad IS 'Tabla de rompimiento para relacionar las dependencias con las necesidades y registrar así los jefes de dependencia de ese momento.';
-- ddl-end --
COMMENT ON COLUMN administrativa.dependencia_necesidad.id IS 'Identificador de la tabla de rompimiento entre la dependencia y la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.dependencia_necesidad.jefe_dependencia_solicitante IS 'Llave foránea de um.um_hybrid_role en la cual se puede el jefe de la dependencia en el momento en el cual se registra la solicitud de necesidad y por el cuál se puede encontrar la dependencia a la que pertenece también.';
-- ddl-end --
COMMENT ON COLUMN administrativa.dependencia_necesidad.jefe_dependencia_destino IS 'Llave foránea de um.um_hybrid_role en la cual se puede el jefe de la dependencia en el momento en el cual se registra la solicitud de necesidad y por el cuál se puede encontrar la dependencia a la que pertenece también.';
-- ddl-end --
COMMENT ON COLUMN administrativa.dependencia_necesidad.necesidad IS 'Llave foránea de la necesidad que se ha rechazado (id)';
-- ddl-end --
COMMENT ON COLUMN administrativa.dependencia_necesidad.ordenador_gasto IS 'Llave foránea de um.um_hybrid_role en la cual se puede encontrar el ordenador del gasto el cuál va a calificar la necesidad (aprobarla o rechazarla)';
-- ddl-end --
COMMENT ON CONSTRAINT pk_dependencia_necesidad ON administrativa.dependencia_necesidad  IS 'LLave primaria de la tabla de rompimiento entre la dependencia y la necesidad';
-- ddl-end --
COMMENT ON CONSTRAINT uk_dependencia_necesidad ON administrativa.dependencia_necesidad  IS 'Llave única de la tabla de rompimiento asegurando que solo se tenga un registro por necesidad';
-- ddl-end --
ALTER TABLE administrativa.dependencia_necesidad OWNER TO admin_core;
-- ddl-end --

-- object: administrativa.necesidad_rechazada | type: TABLE --
-- DROP TABLE IF EXISTS administrativa.necesidad_rechazada CASCADE;
CREATE TABLE administrativa.necesidad_rechazada (
	id integer NOT NULL DEFAULT nextval('administrativa.necesidad_rechazada_id_seq'::regclass),
	necesidad integer NOT NULL,
	justificacion character varying(1) NOT NULL,
	fecha date NOT NULL,
	CONSTRAINT pk_necesidad_rechazada PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE administrativa.necesidad_rechazada IS 'Tabla para registro de datos importantes al momento que un ordenador del gasto rechazase una necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad_rechazada.id IS 'Identificador de la tabla de necesidades rechazadas';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad_rechazada.justificacion IS 'Justificacion de porque se rechaza la necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad_rechazada.fecha IS 'Fecha en la que se rechazó la necesidad';
-- ddl-end --
COMMENT ON CONSTRAINT pk_necesidad_rechazada ON administrativa.necesidad_rechazada  IS 'LLave primaria de la tabla de necesidades rechazadas';
-- ddl-end --
ALTER TABLE administrativa.necesidad_rechazada OWNER TO admin_core;
-- ddl-end --

-- object: core.jefe_dependencia | type: TABLE --
-- DROP TABLE IF EXISTS core.jefe_dependencia CASCADE;
CREATE TABLE core.jefe_dependencia (
	id integer NOT NULL DEFAULT nextval('core.jefe_dependencia_id_seq'::regclass),
	fecha_inicio date NOT NULL,
	fecha_fin date NOT NULL,
	tercero_id integer NOT NULL,
	dependencia_id integer NOT NULL,
	acta_aprobacion character varying(1),
	CONSTRAINT "PK_jefe_dependencia" PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE core.jefe_dependencia IS 'Tabla de Jefe de dependencia';
-- ddl-end --
COMMENT ON COLUMN core.jefe_dependencia.id IS 'Identificador del jefe de dependencia';
-- ddl-end --
COMMENT ON COLUMN core.jefe_dependencia.fecha_inicio IS 'Indica la fecha de inicio en la que la persona empezó a ser jefe de dependencia';
-- ddl-end --
COMMENT ON COLUMN core.jefe_dependencia.fecha_fin IS 'Indica la fecha fin en la que la persona deja de ser jefe de dependencia';
-- ddl-end --
COMMENT ON COLUMN core.jefe_dependencia.tercero_id IS 'Identificador de tercero';
-- ddl-end --
COMMENT ON COLUMN core.jefe_dependencia.dependencia_id IS 'Identificador dependencia';
-- ddl-end --
COMMENT ON CONSTRAINT "PK_jefe_dependencia" ON core.jefe_dependencia  IS 'Llave primaria de la tabla jefe dependencia';
-- ddl-end --
ALTER TABLE core.jefe_dependencia OWNER TO admin_core;
-- ddl-end --

-- object: core.ordenador_gasto | type: TABLE --
-- DROP TABLE IF EXISTS core.ordenador_gasto CASCADE;
CREATE TABLE core.ordenador_gasto (
	id integer NOT NULL DEFAULT nextval('core.ordenador_gasto_id_seq'::regclass),
	cargo character varying(1) NOT NULL,
	dependencia_id integer NOT NULL,
	CONSTRAINT "PK_ORDENADOR_GASTO" PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE core.ordenador_gasto IS 'Tabla que contiene la informacion del ordenador del gasto';
-- ddl-end --
COMMENT ON COLUMN core.ordenador_gasto.id IS 'Identificador del ordenador_gasto.';
-- ddl-end --
COMMENT ON COLUMN core.ordenador_gasto.cargo IS 'Cargo del ordenador del gasto';
-- ddl-end --
COMMENT ON COLUMN core.ordenador_gasto.dependencia_id IS 'Identificador de la dependencia';
-- ddl-end --
COMMENT ON CONSTRAINT "PK_ORDENADOR_GASTO" ON core.ordenador_gasto  IS 'Llave primaria de la tabla ordenador_gasto';
-- ddl-end --
ALTER TABLE core.ordenador_gasto OWNER TO admin_core;
-- ddl-end --

-- object: administrativa.detalle_servicio_necesidad | type: TABLE --
-- DROP TABLE IF EXISTS administrativa.detalle_servicio_necesidad CASCADE;
CREATE TABLE administrativa.detalle_servicio_necesidad (
	id integer NOT NULL DEFAULT nextval('administrativa.servicio_necesidad_id_seq'::regclass),
	perfil integer NOT NULL,
	nucleo_conocimiento integer NOT NULL,
	cantidad integer NOT NULL,
	necesidad integer NOT NULL,
	CONSTRAINT "PK_servicio_necesidad" PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE administrativa.detalle_servicio_necesidad IS 'Tabla con parámetros de una necesidad que requiera un servicio';
-- ddl-end --
COMMENT ON COLUMN administrativa.detalle_servicio_necesidad.id IS 'Identificador de la tabla de parámetros detalle_servicio_necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.detalle_servicio_necesidad.perfil IS 'Llave foránea del perfil del contratista requerido';
-- ddl-end --
COMMENT ON COLUMN administrativa.detalle_servicio_necesidad.nucleo_conocimiento IS 'Llave foránea de agora.nucleo_conocimiento del identificador del núcleo básico snies';
-- ddl-end --
COMMENT ON COLUMN administrativa.detalle_servicio_necesidad.cantidad IS 'Cantidad requerida';
-- ddl-end --
COMMENT ON COLUMN administrativa.detalle_servicio_necesidad.necesidad IS 'Llave foránea de la necesidad en la entidad detalle_servicio_necesidad.';
-- ddl-end --
COMMENT ON CONSTRAINT "PK_servicio_necesidad" ON administrativa.detalle_servicio_necesidad  IS 'Llave primaria de la tabla servicio_necesidad';
-- ddl-end --
ALTER TABLE administrativa.detalle_servicio_necesidad OWNER TO admin_core;
-- ddl-end --

-- object: administrativa.estado_preliquidacion | type: TABLE --
-- DROP TABLE IF EXISTS administrativa.estado_preliquidacion CASCADE;
CREATE TABLE administrativa.estado_preliquidacion (
	id integer NOT NULL DEFAULT nextval('administrativa.estado_preliquidacion_id_seq'::regclass),
	nombre character varying(30) NOT NULL,
	descripcion character varying(100),
	codigo_abreviacion character varying(20),
	activo boolean NOT NULL,
	numero_orden numeric(5,2),
	CONSTRAINT pk_estado_preliquidacion PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE administrativa.estado_preliquidacion IS 'Tabla que parametriza los diferentes estados que tiene una preliquidacion. Ejemplo: Si está abierta, está cerrada o en solicitud de necesidad';
-- ddl-end --
ALTER TABLE administrativa.estado_preliquidacion OWNER TO admin_core;
-- ddl-end --

-- object: administrativa.tipo_necesidad | type: TABLE --
-- DROP TABLE IF EXISTS administrativa.tipo_necesidad CASCADE;
CREATE TABLE administrativa.tipo_necesidad (
	id integer NOT NULL DEFAULT nextval('administrativa.tipo_necesidad_id_seq'::regclass),
	nombre character varying(50) NOT NULL,
	descripcion character varying(250),
	codigo_abreviacion character varying(20),
	estado boolean NOT NULL,
	numero_orden numeric(5,2),
	CONSTRAINT pk_tipo_necesidad PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE administrativa.tipo_necesidad IS 'Tabla encargada de gestionar los tipos de necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.tipo_necesidad.id IS 'Identificador del registro del tipo de necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.tipo_necesidad.nombre IS 'Nombre del tipo de necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.tipo_necesidad.descripcion IS 'Descripción corta del tipo de necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.tipo_necesidad.codigo_abreviacion IS 'codigo de abreviación del tipo de necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.tipo_necesidad.estado IS 'Estado del tipo de necesidad';
-- ddl-end --
COMMENT ON COLUMN administrativa.tipo_necesidad.numero_orden IS 'Número de orden del tipo de necesidad';
-- ddl-end --
COMMENT ON CONSTRAINT pk_tipo_necesidad ON administrativa.tipo_necesidad  IS 'Llave primaria del tipo de necesidad';
-- ddl-end --
ALTER TABLE administrativa.tipo_necesidad OWNER TO admin_core;
-- ddl-end --

-- object: administrativa.necesidad_proceso_externo | type: TABLE --
-- DROP TABLE IF EXISTS administrativa.necesidad_proceso_externo CASCADE;
CREATE TABLE administrativa.necesidad_proceso_externo (
	id integer NOT NULL DEFAULT nextval('administrativa.necesidad_proceso_externo_id_seq'::regclass),
	necesidad integer,
	proceso_externo integer NOT NULL,
	tipo_necesidad integer NOT NULL,
	CONSTRAINT pk_necesidad_proceso_externo PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE administrativa.necesidad_proceso_externo IS 'Tabla de rompimiento encargada de relacionar una necesidad con su correspondiente proceso externo teniendo en cuenta que tipo de necesidad es (Si es una necesidad de contratación no se necesita guardar un registro en esta tabla)';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad_proceso_externo.id IS 'Identificador del registro de la tabla de rompimiento necesidad_proceso_externo';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad_proceso_externo.necesidad IS 'Llave foránea de necesidad(id)';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad_proceso_externo.proceso_externo IS 'Llave foránea de los procesos externos, referencia varias tablas dependendiendo del tipo de proceso (por ejemplo nómina, seguridad social, etc)';
-- ddl-end --
COMMENT ON COLUMN administrativa.necesidad_proceso_externo.tipo_necesidad IS 'Identificador del tipo de necesidad para así diferenciar los procesos externos de acuerdo a su origen, aunque no se tiene una llave foránea en la base de datos se tendrá en el api de administrativa';
-- ddl-end --
COMMENT ON CONSTRAINT pk_necesidad_proceso_externo ON administrativa.necesidad_proceso_externo  IS 'Llave primaria de la tabla de rompimiento necesidad_proceso_externo';
-- ddl-end --
ALTER TABLE administrativa.necesidad_proceso_externo OWNER TO admin_core;
-- ddl-end --

-- object: core.actividad_economica | type: TABLE --
-- DROP TABLE IF EXISTS core.actividad_economica CASCADE;
CREATE TABLE core.actividad_economica (
	id integer NOT NULL DEFAULT nextval('core.actividad_economica_id_seq'::regclass),
	nombre character varying(300) NOT NULL,
	actividad_economica integer,
	clasificacion_ciiu integer,
	activo boolean NOT NULL,
	CONSTRAINT pk_actividad_economica PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE core.actividad_economica IS 'Tabla que almacena las actividades economicas de la DIAN de forma jerarquica de acuerdo a la calsificación ciiu';
-- ddl-end --
COMMENT ON COLUMN core.actividad_economica.id IS 'Idnetificador Unico de la tabla';
-- ddl-end --
COMMENT ON COLUMN core.actividad_economica.nombre IS 'corresponde al nombre de la actividad economica';
-- ddl-end --
COMMENT ON COLUMN core.actividad_economica.actividad_economica IS 'Referencia foranea a la misma tabla que establece la relación jerarquica de los registros';
-- ddl-end --
COMMENT ON COLUMN core.actividad_economica.clasificacion_ciiu IS 'Referencia foranea a la tabla parametrica que almacena la clasificacion de la DIAN';
-- ddl-end --
COMMENT ON COLUMN core.actividad_economica.activo IS 'Campo que indica si el lugar es activo o no';
-- ddl-end --
COMMENT ON CONSTRAINT pk_actividad_economica ON core.actividad_economica  IS 'Restrincción de Unicidad tabla lugar';
-- ddl-end --
ALTER TABLE core.actividad_economica OWNER TO admin_core;
-- ddl-end --

-- object: financiera.estado_apropiacion | type: TABLE --
-- DROP TABLE IF EXISTS financiera.estado_apropiacion CASCADE;
CREATE TABLE financiera.estado_apropiacion (
	id integer NOT NULL,
	nombre character varying(20),
	descripcion character varying(300),
	codigo_abreviacion character varying(20),
	activo boolean DEFAULT true,
	numero_orden numeric(5,2)
);
-- ddl-end --
COMMENT ON TABLE financiera.estado_apropiacion IS 'paramétrica estado de apropiaciones';
-- ddl-end --
COMMENT ON COLUMN financiera.estado_apropiacion.id IS 'identificador único del registro';
-- ddl-end --
COMMENT ON COLUMN financiera.estado_apropiacion.nombre IS 'nombre del estado, será el mostrado';
-- ddl-end --
COMMENT ON COLUMN financiera.estado_apropiacion.descripcion IS 'descripción del estado';
-- ddl-end --
COMMENT ON COLUMN financiera.estado_apropiacion.codigo_abreviacion IS 'Código de abreviación, sigla, acrónimo u otra representación corta del registro si se requiere.';
-- ddl-end --
COMMENT ON COLUMN financiera.estado_apropiacion.activo IS 'Campo que determina si el estado se encuentra activo para su uso.';
-- ddl-end --
COMMENT ON COLUMN financiera.estado_apropiacion.numero_orden IS 'En dado caso que se necesite establecer un orden a los registros que no se encuentre definido por aplicación ni por BD. Aqui se almacena permitiendo realizar subitems mediante la precisión.';
-- ddl-end --
ALTER TABLE financiera.estado_apropiacion OWNER TO admin_core;
-- ddl-end --

-- object: financiera.rubro | type: TABLE --
-- DROP TABLE IF EXISTS financiera.rubro CASCADE;
CREATE TABLE financiera.rubro (
	id integer NOT NULL DEFAULT nextval('nix_presupuesto.rubro_id_seq'::regclass),
	entidad smallint NOT NULL,
	codigo character varying(30),
	nombre text,
	unidad_ejecutora smallint,
	descripcion character varying(1)
);
-- ddl-end --
COMMENT ON COLUMN financiera.rubro.id IS 'identificador del rubro';
-- ddl-end --
COMMENT ON COLUMN financiera.rubro.entidad IS 'entidad a la que pertenece el rubro';
-- ddl-end --
COMMENT ON COLUMN financiera.rubro.codigo IS 'codigo interno';
-- ddl-end --
COMMENT ON COLUMN financiera.rubro.nombre IS 'nombre del rubro presupuestal ';
-- ddl-end --
COMMENT ON COLUMN financiera.rubro.unidad_ejecutora IS 'unidad ejecutora del rubro ';
-- ddl-end --
COMMENT ON COLUMN financiera.rubro.descripcion IS 'Descripcion del rubro presupuestal';
-- ddl-end --
ALTER TABLE financiera.rubro OWNER TO admin_core;
-- ddl-end --

-- object: financiera.estado_disponibilidad | type: TABLE --
-- DROP TABLE IF EXISTS financiera.estado_disponibilidad CASCADE;
CREATE TABLE financiera.estado_disponibilidad (
	id integer NOT NULL DEFAULT nextval('nix_presupuesto.estado_disponibilidad_id_seq'::regclass),
	nombre character varying(25) NOT NULL,
	descripcion character varying(150) NOT NULL,
	codigo_abreviacion character varying(20),
	activo boolean NOT NULL DEFAULT true,
	numero_orden numeric(5,2)
);
-- ddl-end --
COMMENT ON TABLE financiera.estado_disponibilidad IS 'paramétrica estado de disponibilidades';
-- ddl-end --
COMMENT ON COLUMN financiera.estado_disponibilidad.descripcion IS 'descripción del estado';
-- ddl-end --
COMMENT ON COLUMN financiera.estado_disponibilidad.codigo_abreviacion IS 'Código de abreviación, sigla, acrónimo u otra representación corta del registro si se requiere.';
-- ddl-end --
COMMENT ON COLUMN financiera.estado_disponibilidad.activo IS 'Campo que determina si el estado se encuentra activo para su uso';
-- ddl-end --
COMMENT ON COLUMN financiera.estado_disponibilidad.numero_orden IS 'En dado caso que se necesite establecer un orden a los registros que no se encuentre definido por aplicación ni por BD. Aqui se almacena permitiendo realizar subitems mediante la precisión.';
-- ddl-end --
ALTER TABLE financiera.estado_disponibilidad OWNER TO admin_core;
-- ddl-end --

-- object: financiera.entidad | type: TABLE --
-- DROP TABLE IF EXISTS financiera.entidad CASCADE;
CREATE TABLE financiera.entidad (
	id integer NOT NULL DEFAULT nextval('nix.entidad_id_seq'::regclass),
	nombre character varying(60) NOT NULL,
	codigo_entidad character varying(6) NOT NULL,
	tipo_entidad integer NOT NULL DEFAULT 1
);
-- ddl-end --
COMMENT ON TABLE financiera.entidad IS 'tabla en la que se registran las entidades referentes al esquema';
-- ddl-end --
COMMENT ON COLUMN financiera.entidad.id IS 'identificador de la tabla entidad';
-- ddl-end --
COMMENT ON COLUMN financiera.entidad.nombre IS 'campo en el que se indica el nombre de la entidad';
-- ddl-end --
COMMENT ON COLUMN financiera.entidad.codigo_entidad IS 'campo en el que se asigna un codigo a la entidad';
-- ddl-end --
COMMENT ON COLUMN financiera.entidad.tipo_entidad IS 'identificador de la tabla tipo_entidad relacionada para diferenciar el tipo de entidad que se registra';
-- ddl-end --
ALTER TABLE financiera.entidad OWNER TO admin_core;
-- ddl-end --

-- object: core.clasificacion_ciiu | type: TABLE --
-- DROP TABLE IF EXISTS core.clasificacion_ciiu CASCADE;
CREATE TABLE core.clasificacion_ciiu (
	id integer NOT NULL DEFAULT nextval('core.clasificacion_ciiu_id_seq'::regclass),
	nombre character varying(50) NOT NULL,
	descripcion character varying(250),
	codigo_abreviacion character varying(20),
	activo boolean NOT NULL,
	numero_orden numeric(5,2)
);
-- ddl-end --
COMMENT ON TABLE core.clasificacion_ciiu IS 'Almacena los parametros de clasificacion_ciiu';
-- ddl-end --
COMMENT ON COLUMN core.clasificacion_ciiu.id IS 'identificador unico de la tabla';
-- ddl-end --
COMMENT ON COLUMN core.clasificacion_ciiu.nombre IS 'Campo obligatorio de la tabla que indica el nombre del parametro.';
-- ddl-end --
COMMENT ON COLUMN core.clasificacion_ciiu.descripcion IS 'Descripción opcional del parámetro.';
-- ddl-end --
COMMENT ON COLUMN core.clasificacion_ciiu.codigo_abreviacion IS 'Código de abreviación, sigla, acrónimo u otra representación corta del registro si se requiere';
-- ddl-end --
COMMENT ON COLUMN core.clasificacion_ciiu.activo IS 'Campo de tipo boolean que inidica si el parametro esta activo';
-- ddl-end --
COMMENT ON COLUMN core.clasificacion_ciiu.numero_orden IS ' En dado caso que se necesite establecer un orden a los registros que no se encuentre definido por aplicación ni por BD. Allí se almacena permitiendo realizar subitems mediante la precisión.';
-- ddl-end --
ALTER TABLE core.clasificacion_ciiu OWNER TO admin_core;
-- ddl-end --

-- object: financiera.tipo_fuente_financiamiento | type: TABLE --
-- DROP TABLE IF EXISTS financiera.tipo_fuente_financiamiento CASCADE;
CREATE TABLE financiera.tipo_fuente_financiamiento (
	id integer NOT NULL DEFAULT nextval('financiera.tipo_fuente_financiamiento_id_seq'::regclass),
	nombre character varying(20) NOT NULL,
	descripcion character varying(250),
	codigo_abreviacion character varying(20),
	activo boolean NOT NULL,
	numero_orden numeric(5,2)
);
-- ddl-end --
COMMENT ON TABLE financiera.tipo_fuente_financiamiento IS 'esta tabla nos permite guardar los tipos de fuentes de financiamiento que pueden ser de inversión o de funcionamiento';
-- ddl-end --
COMMENT ON COLUMN financiera.tipo_fuente_financiamiento.id IS 'identificador de la tabla tipo_fuente_financiamiento';
-- ddl-end --
COMMENT ON COLUMN financiera.tipo_fuente_financiamiento.nombre IS 'nombre del tipo de la fuente de financiamiento';
-- ddl-end --
COMMENT ON COLUMN financiera.tipo_fuente_financiamiento.descripcion IS ' del tipo de la fuente de financiamiento';
-- ddl-end --
COMMENT ON COLUMN financiera.tipo_fuente_financiamiento.codigo_abreviacion IS 'abreviación del tipo de fuente';
-- ddl-end --
COMMENT ON COLUMN financiera.tipo_fuente_financiamiento.activo IS 'determina que el tipo de fuente esta activo y se puede utilizar';
-- ddl-end --
ALTER TABLE financiera.tipo_fuente_financiamiento OWNER TO admin_core;
-- ddl-end --

-- object: necesidades_metas.necesidad_meta_actividad | type: TABLE --
-- DROP TABLE IF EXISTS necesidades_metas.necesidad_meta_actividad CASCADE;
CREATE TABLE necesidades_metas.necesidad_meta_actividad (
	id serial NOT NULL,
	meta_id integer NOT NULL,
	actividad_id integer NOT NULL,
	necesidad_id integer NOT NULL,
	CONSTRAINT pk_necesidad_meta_actividad PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE necesidades_metas.necesidad_meta_actividad OWNER TO postgres;
-- ddl-end --

-- object: fk_apropiacion_estado_apropiacion | type: CONSTRAINT --
-- ALTER TABLE financiera.apropiacion DROP CONSTRAINT IF EXISTS fk_apropiacion_estado_apropiacion CASCADE;
ALTER TABLE financiera.apropiacion ADD CONSTRAINT fk_apropiacion_estado_apropiacion FOREIGN KEY (estado)
REFERENCES financiera.estado_apropiacion (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_apropiacion_rubro | type: CONSTRAINT --
-- ALTER TABLE financiera.apropiacion DROP CONSTRAINT IF EXISTS fk_apropiacion_rubro CASCADE;
ALTER TABLE financiera.apropiacion ADD CONSTRAINT fk_apropiacion_rubro FOREIGN KEY (rubro)
REFERENCES financiera.rubro (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: pk_tipo_fuente_financiamiento_fuente_financiamiento | type: CONSTRAINT --
-- ALTER TABLE financiera.fuente_financiamiento DROP CONSTRAINT IF EXISTS pk_tipo_fuente_financiamiento_fuente_financiamiento CASCADE;
ALTER TABLE financiera.fuente_financiamiento ADD CONSTRAINT pk_tipo_fuente_financiamiento_fuente_financiamiento FOREIGN KEY (tipo_fuente_financiamiento)
REFERENCES financiera.tipo_fuente_financiamiento (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_disponibilidad_estado_disponibilidad | type: CONSTRAINT --
-- ALTER TABLE financiera.disponibilidad DROP CONSTRAINT IF EXISTS fk_disponibilidad_estado_disponibilidad CASCADE;
ALTER TABLE financiera.disponibilidad ADD CONSTRAINT fk_disponibilidad_estado_disponibilidad FOREIGN KEY (estado)
REFERENCES financiera.estado_disponibilidad (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: rel_modalidad_seleccion_necesidad_solicitud_necesidad | type: CONSTRAINT --
-- ALTER TABLE administrativa.necesidad DROP CONSTRAINT IF EXISTS rel_modalidad_seleccion_necesidad_solicitud_necesidad CASCADE;
ALTER TABLE administrativa.necesidad ADD CONSTRAINT rel_modalidad_seleccion_necesidad_solicitud_necesidad FOREIGN KEY (modalidad_seleccion)
REFERENCES administrativa.modalidad_seleccion (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: rel_tipo_contratacion_necesidad_solicitud_necesidad | type: CONSTRAINT --
-- ALTER TABLE administrativa.necesidad DROP CONSTRAINT IF EXISTS rel_tipo_contratacion_necesidad_solicitud_necesidad CASCADE;
ALTER TABLE administrativa.necesidad ADD CONSTRAINT rel_tipo_contratacion_necesidad_solicitud_necesidad FOREIGN KEY (tipo_financiacion_necesidad)
REFERENCES administrativa.tipo_financiacion_necesidad (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: rel_servicio_necesidad | type: CONSTRAINT --
-- ALTER TABLE administrativa.necesidad DROP CONSTRAINT IF EXISTS rel_servicio_necesidad CASCADE;
ALTER TABLE administrativa.necesidad ADD CONSTRAINT rel_servicio_necesidad FOREIGN KEY (tipo_contrato_necesidad)
REFERENCES administrativa.tipo_contrato_necesidad (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: rel_estado_necesidad | type: CONSTRAINT --
-- ALTER TABLE administrativa.necesidad DROP CONSTRAINT IF EXISTS rel_estado_necesidad CASCADE;
ALTER TABLE administrativa.necesidad ADD CONSTRAINT rel_estado_necesidad FOREIGN KEY (estado_necesidad)
REFERENCES administrativa.estado_necesidad (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --
COMMENT ON CONSTRAINT rel_estado_necesidad ON administrativa.necesidad  IS 'Relación entre la necesidad (estado) y la tabla de parámetros de estados (id)';
-- ddl-end --


-- object: fk_necesidad_tipo_necesidad | type: CONSTRAINT --
-- ALTER TABLE administrativa.necesidad DROP CONSTRAINT IF EXISTS fk_necesidad_tipo_necesidad CASCADE;
ALTER TABLE administrativa.necesidad ADD CONSTRAINT fk_necesidad_tipo_necesidad FOREIGN KEY (tipo_necesidad)
REFERENCES administrativa.tipo_necesidad (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --
COMMENT ON CONSTRAINT fk_necesidad_tipo_necesidad ON administrativa.necesidad  IS 'Llave foránea entre necesidad(tipo_necesidad) y tipo_necesidad(id)';
-- ddl-end --


-- object: rel_necesidad_actividad_necesidad | type: CONSTRAINT --
-- ALTER TABLE administrativa.actividad_solicitud_necesidad DROP CONSTRAINT IF EXISTS rel_necesidad_actividad_necesidad CASCADE;
ALTER TABLE administrativa.actividad_solicitud_necesidad ADD CONSTRAINT rel_necesidad_actividad_necesidad FOREIGN KEY (necesidad)
REFERENCES administrativa.necesidad (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --
COMMENT ON CONSTRAINT rel_necesidad_actividad_necesidad ON administrativa.actividad_solicitud_necesidad  IS 'Relación entre la necesidad (id) y la tabla de actividades pertenecientes a centros de costos actividad_solicitud_necesidad (necesidad)';
-- ddl-end --


-- object: rel_especificacion_tecnica_solicitud_necesidad | type: CONSTRAINT --
-- ALTER TABLE administrativa.especificacion_tecnica DROP CONSTRAINT IF EXISTS rel_especificacion_tecnica_solicitud_necesidad CASCADE;
ALTER TABLE administrativa.especificacion_tecnica ADD CONSTRAINT rel_especificacion_tecnica_solicitud_necesidad FOREIGN KEY (necesidad)
REFERENCES administrativa.necesidad (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: rel_requisito_minimo_especificacion_tecnica | type: CONSTRAINT --
-- ALTER TABLE administrativa.requisito_minimo DROP CONSTRAINT IF EXISTS rel_requisito_minimo_especificacion_tecnica CASCADE;
ALTER TABLE administrativa.requisito_minimo ADD CONSTRAINT rel_requisito_minimo_especificacion_tecnica FOREIGN KEY (especificacion_tecnica)
REFERENCES administrativa.especificacion_tecnica (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: rel_fuentes_necesidad | type: CONSTRAINT --
-- ALTER TABLE administrativa.fuente_financiacion_rubro_necesidad DROP CONSTRAINT IF EXISTS rel_fuentes_necesidad CASCADE;
ALTER TABLE administrativa.fuente_financiacion_rubro_necesidad ADD CONSTRAINT rel_fuentes_necesidad FOREIGN KEY (necesidad)
REFERENCES administrativa.necesidad (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --
COMMENT ON CONSTRAINT rel_fuentes_necesidad ON administrativa.fuente_financiacion_rubro_necesidad  IS 'Relación entre la tabla de rompimiento entre las fuentes de financiacimiento y las apropiaciones que indican el rubro de dicha fuente y la necesidad';
-- ddl-end --


-- object: rel_marco_legal_marco_legal_necesidad | type: CONSTRAINT --
-- ALTER TABLE administrativa.marco_legal_necesidad DROP CONSTRAINT IF EXISTS rel_marco_legal_marco_legal_necesidad CASCADE;
ALTER TABLE administrativa.marco_legal_necesidad ADD CONSTRAINT rel_marco_legal_marco_legal_necesidad FOREIGN KEY (marco_legal)
REFERENCES administrativa.marco_legal (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: rel_solicitud_necesidad_marco_legal_necesidad | type: CONSTRAINT --
-- ALTER TABLE administrativa.marco_legal_necesidad DROP CONSTRAINT IF EXISTS rel_solicitud_necesidad_marco_legal_necesidad CASCADE;
ALTER TABLE administrativa.marco_legal_necesidad ADD CONSTRAINT rel_solicitud_necesidad_marco_legal_necesidad FOREIGN KEY (necesidad)
REFERENCES administrativa.necesidad (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: rel_solicitud_necesidad_actividad_economica_necesidad | type: CONSTRAINT --
-- ALTER TABLE administrativa.actividad_economica_necesidad DROP CONSTRAINT IF EXISTS rel_solicitud_necesidad_actividad_economica_necesidad CASCADE;
ALTER TABLE administrativa.actividad_economica_necesidad ADD CONSTRAINT rel_solicitud_necesidad_actividad_economica_necesidad FOREIGN KEY (necesidad)
REFERENCES administrativa.necesidad (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_entidad | type: CONSTRAINT --
-- ALTER TABLE financiera.unidad_ejecutora DROP CONSTRAINT IF EXISTS fk_entidad CASCADE;
ALTER TABLE financiera.unidad_ejecutora ADD CONSTRAINT fk_entidad FOREIGN KEY (entidad)
REFERENCES financiera.entidad (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_fuente_financiamiento_apropiacion | type: CONSTRAINT --
-- ALTER TABLE financiera.fuente_financiamiento_apropiacion DROP CONSTRAINT IF EXISTS fk_fuente_financiamiento_apropiacion CASCADE;
ALTER TABLE financiera.fuente_financiamiento_apropiacion ADD CONSTRAINT fk_fuente_financiamiento_apropiacion FOREIGN KEY (apropiacion)
REFERENCES financiera.apropiacion (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_apropiacion_fuente_financiamiento | type: CONSTRAINT --
-- ALTER TABLE financiera.fuente_financiamiento_apropiacion DROP CONSTRAINT IF EXISTS fk_apropiacion_fuente_financiamiento CASCADE;
ALTER TABLE financiera.fuente_financiamiento_apropiacion ADD CONSTRAINT fk_apropiacion_fuente_financiamiento FOREIGN KEY (fuente_financiamiento)
REFERENCES financiera.fuente_financiamiento (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: rel_necesidad_solicitud_disponibilidad | type: CONSTRAINT --
-- ALTER TABLE administrativa.solicitud_disponibilidad DROP CONSTRAINT IF EXISTS rel_necesidad_solicitud_disponibilidad CASCADE;
ALTER TABLE administrativa.solicitud_disponibilidad ADD CONSTRAINT rel_necesidad_solicitud_disponibilidad FOREIGN KEY (necesidad)
REFERENCES administrativa.necesidad (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --
COMMENT ON CONSTRAINT rel_necesidad_solicitud_disponibilidad ON administrativa.solicitud_disponibilidad  IS 'Llave foránea de la necesidad de la cual proviene la solicitud de disponibilidad (cdp)';
-- ddl-end --


-- object: rel_necesidad_actividad_especifica | type: CONSTRAINT --
-- ALTER TABLE administrativa.actividad_especifica DROP CONSTRAINT IF EXISTS rel_necesidad_actividad_especifica CASCADE;
ALTER TABLE administrativa.actividad_especifica ADD CONSTRAINT rel_necesidad_actividad_especifica FOREIGN KEY (necesidad)
REFERENCES administrativa.necesidad (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: rel_necesidad_rechazada_necesidad | type: CONSTRAINT --
-- ALTER TABLE administrativa.necesidad_rechazada DROP CONSTRAINT IF EXISTS rel_necesidad_rechazada_necesidad CASCADE;
ALTER TABLE administrativa.necesidad_rechazada ADD CONSTRAINT rel_necesidad_rechazada_necesidad FOREIGN KEY (necesidad)
REFERENCES administrativa.necesidad (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --
COMMENT ON CONSTRAINT rel_necesidad_rechazada_necesidad ON administrativa.necesidad_rechazada  IS 'Relación entre la tabla de necesidades rechazadas (necesidad) y la necesidad en cuestión (id)';
-- ddl-end --


-- object: fk_detalle_servicio_necesidad_necesidad | type: CONSTRAINT --
-- ALTER TABLE administrativa.detalle_servicio_necesidad DROP CONSTRAINT IF EXISTS fk_detalle_servicio_necesidad_necesidad CASCADE;
ALTER TABLE administrativa.detalle_servicio_necesidad ADD CONSTRAINT fk_detalle_servicio_necesidad_necesidad FOREIGN KEY (necesidad)
REFERENCES administrativa.necesidad (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --
COMMENT ON CONSTRAINT fk_detalle_servicio_necesidad_necesidad ON administrativa.detalle_servicio_necesidad  IS 'Llave foránea entre las tablas detalle_servicio_necesidad(necesidad) y necesidad(id)';
-- ddl-end --


-- object: fk_necesidad_proceso_externo_necesidad | type: CONSTRAINT --
-- ALTER TABLE administrativa.necesidad_proceso_externo DROP CONSTRAINT IF EXISTS fk_necesidad_proceso_externo_necesidad CASCADE;
ALTER TABLE administrativa.necesidad_proceso_externo ADD CONSTRAINT fk_necesidad_proceso_externo_necesidad FOREIGN KEY (necesidad)
REFERENCES administrativa.necesidad (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --
COMMENT ON CONSTRAINT fk_necesidad_proceso_externo_necesidad ON administrativa.necesidad_proceso_externo  IS 'Llave foránea entre necesidad_proceso_externo(necesidad) y necesidad(id)';
-- ddl-end --


-- object: fk_actividad_economica_actividad_economica | type: CONSTRAINT --
-- ALTER TABLE core.actividad_economica DROP CONSTRAINT IF EXISTS fk_actividad_economica_actividad_economica CASCADE;
ALTER TABLE core.actividad_economica ADD CONSTRAINT fk_actividad_economica_actividad_economica FOREIGN KEY (actividad_economica)
REFERENCES core.actividad_economica (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_actividad_economica_clasificacion_ciiu | type: CONSTRAINT --
-- ALTER TABLE core.actividad_economica DROP CONSTRAINT IF EXISTS fk_actividad_economica_clasificacion_ciiu CASCADE;
ALTER TABLE core.actividad_economica ADD CONSTRAINT fk_actividad_economica_clasificacion_ciiu FOREIGN KEY (clasificacion_ciiu)
REFERENCES core.clasificacion_ciiu (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: necesidad_id | type: CONSTRAINT --
-- ALTER TABLE necesidades_metas.necesidad_meta_actividad DROP CONSTRAINT IF EXISTS necesidad_id CASCADE;
ALTER TABLE necesidades_metas.necesidad_meta_actividad ADD CONSTRAINT necesidad_id FOREIGN KEY (necesidad_id)
REFERENCES administrativa.necesidad (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: grant_cc59a12fa3 | type: PERMISSION --
GRANT TEMPORARY
   ON DATABASE udistrital_core_db
   TO PUBLIC;
-- ddl-end --

-- object: grant_63993261d1 | type: PERMISSION --
GRANT CREATE,CONNECT,TEMPORARY
   ON DATABASE udistrital_core_db
   TO postgres;
-- ddl-end --

-- object: grant_a964f057a0 | type: PERMISSION --
GRANT CONNECT
   ON DATABASE udistrital_core_db
   TO crud_user;
-- ddl-end --

-- object: grant_63bf5cd43e | type: PERMISSION --
GRANT CREATE,CONNECT,TEMPORARY
   ON DATABASE udistrital_core_db
   TO admin_core;
-- ddl-end --

-- object: grant_6aa60d9bf6 | type: PERMISSION --
GRANT CONNECT
   ON DATABASE udistrital_core_db
   TO financiera_app;
-- ddl-end --

-- object: grant_9d7dafc149 | type: PERMISSION --
GRANT CONNECT
   ON DATABASE udistrital_core_db
   TO administrativa_app;
-- ddl-end --

-- object: grant_c7e646fd0f | type: PERMISSION --
GRANT CONNECT
   ON DATABASE udistrital_core_db
   TO core_app;
-- ddl-end --

-- object: grant_2cbf3aac5f | type: PERMISSION --
GRANT CONNECT
   ON DATABASE udistrital_core_db
   TO academica_app;
-- ddl-end --

-- object: grant_1124c18ebf | type: PERMISSION --
GRANT CREATE,USAGE
   ON SCHEMA core
   TO admin_core;
-- ddl-end --

-- object: grant_7e9d68641c | type: PERMISSION --
GRANT USAGE
   ON SCHEMA core
   TO crud_user;
-- ddl-end --

-- object: grant_fa1047f203 | type: PERMISSION --
GRANT USAGE
   ON SCHEMA core
   TO core_role;
-- ddl-end --

-- object: grant_a288e8b165 | type: PERMISSION --
GRANT CREATE,USAGE
   ON SCHEMA financiera
   TO admin_core;
-- ddl-end --

-- object: grant_c41cbec276 | type: PERMISSION --
GRANT USAGE
   ON SCHEMA financiera
   TO crud_user;
-- ddl-end --

-- object: grant_7746928eb2 | type: PERMISSION --
GRANT USAGE
   ON SCHEMA financiera
   TO financiera_role;
-- ddl-end --

-- object: grant_70366957a9 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE financiera.apropiacion
   TO admin_core;
-- ddl-end --

-- object: grant_ccf4dfbd61 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE financiera.apropiacion
   TO crud_user;
-- ddl-end --

-- object: grant_f3063017a1 | type: PERMISSION --
GRANT SELECT
   ON TABLE financiera.apropiacion
   TO financiera_role;
-- ddl-end --

-- object: grant_41b384f419 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE financiera.fuente_financiamiento
   TO admin_core;
-- ddl-end --

-- object: grant_79c973890b | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE financiera.fuente_financiamiento
   TO crud_user;
-- ddl-end --

-- object: grant_44da8e63fa | type: PERMISSION --
GRANT SELECT,INSERT
   ON TABLE financiera.fuente_financiamiento
   TO financiera_role;
-- ddl-end --

-- object: grant_48b8eeb881 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE financiera.disponibilidad
   TO admin_core;
-- ddl-end --

-- object: grant_b38a8538b1 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE financiera.disponibilidad
   TO crud_user;
-- ddl-end --

-- object: grant_196ebcdf4f | type: PERMISSION --
GRANT SELECT,INSERT
   ON TABLE financiera.disponibilidad
   TO financiera_role;
-- ddl-end --

-- object: grant_8369770541 | type: PERMISSION --
GRANT CREATE,USAGE
   ON SCHEMA administrativa
   TO admin_core;
-- ddl-end --

-- object: grant_18172c7cdb | type: PERMISSION --
GRANT USAGE
   ON SCHEMA administrativa
   TO crud_user;
-- ddl-end --

-- object: grant_a8ea21b134 | type: PERMISSION --
GRANT USAGE
   ON SCHEMA administrativa
   TO administrativa_role;
-- ddl-end --

-- object: grant_1ba5ab1a0d | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE administrativa.necesidad
   TO admin_core;
-- ddl-end --

-- object: grant_bf45c6df8d | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE administrativa.necesidad
   TO crud_user;
-- ddl-end --

-- object: grant_2d323b1f07 | type: PERMISSION --
GRANT SELECT,INSERT
   ON TABLE administrativa.necesidad
   TO administrativa_role;
-- ddl-end --

-- object: grant_34aee4a7ab | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE administrativa.estado_necesidad
   TO admin_core;
-- ddl-end --

-- object: grant_2effcc541a | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE administrativa.estado_necesidad
   TO crud_user;
-- ddl-end --

-- object: grant_2d17a9b496 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE administrativa.actividad_solicitud_necesidad
   TO admin_core;
-- ddl-end --

-- object: grant_f8ed91de4e | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE administrativa.actividad_solicitud_necesidad
   TO crud_user;
-- ddl-end --

-- object: grant_e260b72603 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE administrativa.especificacion_tecnica
   TO admin_core;
-- ddl-end --

-- object: grant_45a291c49b | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE administrativa.especificacion_tecnica
   TO crud_user;
-- ddl-end --

-- object: grant_35ed913286 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE administrativa.requisito_minimo
   TO admin_core;
-- ddl-end --

-- object: grant_155b615791 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE administrativa.requisito_minimo
   TO crud_user;
-- ddl-end --

-- object: grant_cf814291bb | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE administrativa.marco_legal
   TO admin_core;
-- ddl-end --

-- object: grant_e3d31acdc5 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE administrativa.marco_legal
   TO crud_user;
-- ddl-end --

-- object: grant_dfdc0f65e2 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE administrativa.fuente_financiacion_rubro_necesidad
   TO admin_core;
-- ddl-end --

-- object: grant_9053dcb514 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE administrativa.fuente_financiacion_rubro_necesidad
   TO crud_user;
-- ddl-end --

-- object: grant_7b0b5fa3aa | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE administrativa.marco_legal_necesidad
   TO admin_core;
-- ddl-end --

-- object: grant_a85071a4e7 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE administrativa.marco_legal_necesidad
   TO crud_user;
-- ddl-end --

-- object: grant_eecfeffb01 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE administrativa.modalidad_seleccion
   TO admin_core;
-- ddl-end --

-- object: grant_d657e0e5f7 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE administrativa.modalidad_seleccion
   TO crud_user;
-- ddl-end --

-- object: grant_7d52d2c7ab | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE administrativa.tipo_financiacion_necesidad
   TO admin_core;
-- ddl-end --

-- object: grant_1504dee88f | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE administrativa.tipo_financiacion_necesidad
   TO crud_user;
-- ddl-end --

-- object: grant_7c67ca90c8 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE administrativa.actividad_economica_necesidad
   TO admin_core;
-- ddl-end --

-- object: grant_d0871904f9 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE administrativa.actividad_economica_necesidad
   TO crud_user;
-- ddl-end --

-- object: grant_5906edc082 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE financiera.unidad_ejecutora
   TO admin_core;
-- ddl-end --

-- object: grant_161e30a0c6 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE financiera.unidad_ejecutora
   TO crud_user;
-- ddl-end --

-- object: grant_ff5026e0a4 | type: PERMISSION --
GRANT SELECT
   ON TABLE financiera.unidad_ejecutora
   TO financiera_role;
-- ddl-end --

-- object: grant_fdf063b97d | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE financiera.fuente_financiamiento_apropiacion
   TO admin_core;
-- ddl-end --

-- object: grant_5a56d5221e | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE financiera.fuente_financiamiento_apropiacion
   TO crud_user;
-- ddl-end --

-- object: grant_98e46fe5da | type: PERMISSION --
GRANT SELECT,INSERT
   ON TABLE financiera.fuente_financiamiento_apropiacion
   TO financiera_role;
-- ddl-end --

-- object: grant_fba0bf34c1 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE administrativa.tipo_contrato_necesidad
   TO admin_core;
-- ddl-end --

-- object: grant_d4e1cd124b | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE administrativa.tipo_contrato_necesidad
   TO crud_user;
-- ddl-end --

-- object: grant_7ec2efd579 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE administrativa.solicitud_disponibilidad
   TO admin_core;
-- ddl-end --

-- object: grant_08f5bc173e | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE administrativa.solicitud_disponibilidad
   TO crud_user;
-- ddl-end --

-- object: grant_38cb08415e | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE administrativa.actividad_especifica
   TO admin_core;
-- ddl-end --

-- object: grant_f39dbc17f9 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE administrativa.actividad_especifica
   TO crud_user;
-- ddl-end --

-- object: grant_ec761858bd | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE administrativa.dependencia_necesidad
   TO admin_core;
-- ddl-end --

-- object: grant_cfa86e0e89 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE administrativa.dependencia_necesidad
   TO crud_user;
-- ddl-end --

-- object: grant_ad772ce868 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE administrativa.necesidad_rechazada
   TO admin_core;
-- ddl-end --

-- object: grant_03521f6c5d | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE administrativa.necesidad_rechazada
   TO crud_user;
-- ddl-end --

-- object: grant_f5412585f6 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE core.jefe_dependencia
   TO admin_core;
-- ddl-end --

-- object: grant_4c2157c668 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE core.jefe_dependencia
   TO crud_user;
-- ddl-end --

-- object: grant_33f80ac55a | type: PERMISSION --
GRANT SELECT
   ON TABLE core.jefe_dependencia
   TO core_role;
-- ddl-end --

-- object: grant_292863e705 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE core.ordenador_gasto
   TO admin_core;
-- ddl-end --

-- object: grant_43dc11e977 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE core.ordenador_gasto
   TO crud_user;
-- ddl-end --

-- object: grant_f56df4b82f | type: PERMISSION --
GRANT SELECT
   ON TABLE core.ordenador_gasto
   TO core_role;
-- ddl-end --

-- object: grant_1308563c1e | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE administrativa.detalle_servicio_necesidad
   TO admin_core;
-- ddl-end --

-- object: grant_1cc146ceea | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE administrativa.detalle_servicio_necesidad
   TO crud_user;
-- ddl-end --

-- object: grant_f071d2e2f1 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE administrativa.estado_preliquidacion
   TO admin_core;
-- ddl-end --

-- object: grant_5b03385c58 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE administrativa.estado_preliquidacion
   TO crud_user;
-- ddl-end --

-- object: grant_0dc42c4e0f | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE administrativa.tipo_necesidad
   TO admin_core;
-- ddl-end --

-- object: grant_a5c63e3360 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE administrativa.tipo_necesidad
   TO crud_user;
-- ddl-end --

-- object: grant_99be493a5c | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE administrativa.necesidad_proceso_externo
   TO admin_core;
-- ddl-end --

-- object: grant_8512b00b30 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE administrativa.necesidad_proceso_externo
   TO crud_user;
-- ddl-end --

-- object: grant_dbd2c5fde5 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE core.actividad_economica
   TO admin_core;
-- ddl-end --

-- object: grant_9153265da7 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE core.actividad_economica
   TO crud_user;
-- ddl-end --

-- object: grant_ed018a8a26 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE financiera.estado_apropiacion
   TO admin_core;
-- ddl-end --

-- object: grant_aaa48c771c | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE financiera.estado_apropiacion
   TO crud_user;
-- ddl-end --

-- object: grant_32c2854170 | type: PERMISSION --
GRANT SELECT
   ON TABLE financiera.estado_apropiacion
   TO financiera_role;
-- ddl-end --

-- object: grant_c6287c284f | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE financiera.rubro
   TO admin_core;
-- ddl-end --

-- object: grant_236c090c23 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE financiera.rubro
   TO crud_user;
-- ddl-end --

-- object: grant_8ddd34f8a1 | type: PERMISSION --
GRANT SELECT
   ON TABLE financiera.rubro
   TO financiera_role;
-- ddl-end --

-- object: grant_47e678348e | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE financiera.estado_disponibilidad
   TO admin_core;
-- ddl-end --

-- object: grant_ccbd86f453 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE financiera.estado_disponibilidad
   TO crud_user;
-- ddl-end --

-- object: grant_382cf21a38 | type: PERMISSION --
GRANT SELECT
   ON TABLE financiera.estado_disponibilidad
   TO financiera_role;
-- ddl-end --

-- object: grant_ab465ad2fd | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE financiera.entidad
   TO admin_core;
-- ddl-end --

-- object: grant_29b265bf6a | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE financiera.entidad
   TO crud_user;
-- ddl-end --

-- object: grant_7f48dae013 | type: PERMISSION --
GRANT SELECT
   ON TABLE financiera.entidad
   TO financiera_role;
-- ddl-end --

-- object: grant_203dfd4eb1 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE core.clasificacion_ciiu
   TO admin_core;
-- ddl-end --

-- object: grant_3c77bda692 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE core.clasificacion_ciiu
   TO crud_user;
-- ddl-end --

-- object: grant_39b71bc253 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE financiera.tipo_fuente_financiamiento
   TO admin_core;
-- ddl-end --

-- object: grant_80d2727c1c | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE
   ON TABLE financiera.tipo_fuente_financiamiento
   TO crud_user;
-- ddl-end --

-- object: grant_59944d9fd3 | type: PERMISSION --
GRANT SELECT
   ON TABLE financiera.tipo_fuente_financiamiento
   TO financiera_role;
-- ddl-end --


