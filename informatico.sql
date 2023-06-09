-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 1.0.4
-- PostgreSQL version: 15.0
-- Project Site: pgmodeler.io
-- Model Author: ---
-- -- object: pg_database_owner | type: ROLE --
-- -- DROP ROLE IF EXISTS pg_database_owner;
-- CREATE ROLE pg_database_owner WITH 
-- 	INHERIT
-- 	 PASSWORD '********';
-- -- ddl-end --
-- 
-- object: pgexercises | type: ROLE --
-- DROP ROLE IF EXISTS pgexercises;
CREATE ROLE pgexercises WITH 
	SUPERUSER
	CREATEDB
	CREATEROLE
	INHERIT
	LOGIN
	 PASSWORD '********';
-- ddl-end --


-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: informaticos | type: DATABASE --
-- DROP DATABASE IF EXISTS informaticos;
CREATE DATABASE informaticos
	ENCODING = 'UTF8'
	LC_COLLATE = 'Spanish_United States.1252'
	LC_CTYPE = 'Spanish_United States.1252'
	TABLESPACE = pg_default
	OWNER = postgres;
-- ddl-end --


-- object: public.proyecto | type: TABLE --
-- DROP TABLE IF EXISTS public.proyecto CASCADE;
CREATE TABLE public.proyecto (
	codigo integer NOT NULL,
	nombre character varying(100) NOT NULL,
	cliente character varying(100) NOT NULL,
	descripcion character varying(255),
	presupuesto numeric(10,2),
	horas_totales_estimadas integer,
	fecha_inicio date,
	fecha_fin date,
	CONSTRAINT proyecto_pkey PRIMARY KEY (codigo)
);
-- ddl-end --
ALTER TABLE public.proyecto OWNER TO postgres;
-- ddl-end --

-- object: public.fase | type: TABLE --
-- DROP TABLE IF EXISTS public.fase CASCADE;
CREATE TABLE public.fase (
	codigo integer NOT NULL,
	codigo_proyecto integer,
	nombre character varying(100) NOT NULL,
	fecha_comienzo date,
	fecha_fin date,
	estado character varying(20),
	CONSTRAINT fase_pkey PRIMARY KEY (codigo)
);
-- ddl-end --
ALTER TABLE public.fase OWNER TO postgres;
-- ddl-end --

-- object: public.empleado | type: TABLE --
-- DROP TABLE IF EXISTS public.empleado CASCADE;
CREATE TABLE public.empleado (
	codigo integer NOT NULL,
	dni character varying(20) NOT NULL,
	nombre character varying(100) NOT NULL,
	direccion character varying(255),
	titulacion character varying(100),
	anios_experiencia integer,
	CONSTRAINT empleado_pkey PRIMARY KEY (codigo)
);
-- ddl-end --
ALTER TABLE public.empleado OWNER TO postgres;
-- ddl-end --

-- object: public.jefeproyecto | type: TABLE --
-- DROP TABLE IF EXISTS public.jefeproyecto CASCADE;
CREATE TABLE public.jefeproyecto (
	codigo_proyecto integer NOT NULL,
	codigo_empleado integer,
	dedicacion_total_horas integer,
	coste_euros numeric(10,2),
	CONSTRAINT jefeproyecto_pkey PRIMARY KEY (codigo_proyecto)
);
-- ddl-end --
ALTER TABLE public.jefeproyecto OWNER TO postgres;
-- ddl-end --

-- object: public.informatico | type: TABLE --
-- DROP TABLE IF EXISTS public.informatico CASCADE;
CREATE TABLE public.informatico (
	codigo_empleado integer NOT NULL,
	tipo character varying(20),
	CONSTRAINT informatico_pkey PRIMARY KEY (codigo_empleado)
);
-- ddl-end --
ALTER TABLE public.informatico OWNER TO postgres;
-- ddl-end --

-- object: public.programador | type: TABLE --
-- DROP TABLE IF EXISTS public.programador CASCADE;
CREATE TABLE public.programador (
	codigo_empleado integer NOT NULL,
	CONSTRAINT programador_pkey PRIMARY KEY (codigo_empleado)
);
-- ddl-end --
ALTER TABLE public.programador OWNER TO postgres;
-- ddl-end --

-- object: public.lenguaje | type: TABLE --
-- DROP TABLE IF EXISTS public.lenguaje CASCADE;
CREATE TABLE public.lenguaje (
	codigo_programador integer,
	nombre character varying(100) NOT NULL

);
-- ddl-end --
ALTER TABLE public.lenguaje OWNER TO postgres;
-- ddl-end --

-- object: public.producto | type: TABLE --
-- DROP TABLE IF EXISTS public.producto CASCADE;
CREATE TABLE public.producto (
	codigo integer NOT NULL,
	codigo_fase integer,
	nombre character varying(100) NOT NULL,
	descripcion character varying(255),
	finalizado boolean,
	responsable_analista integer,
	CONSTRAINT producto_pkey PRIMARY KEY (codigo)
);
-- ddl-end --
ALTER TABLE public.producto OWNER TO postgres;
-- ddl-end --

-- object: public.software | type: TABLE --
-- DROP TABLE IF EXISTS public.software CASCADE;
CREATE TABLE public.software (
	codigo_producto integer NOT NULL,
	tipo character varying(100) NOT NULL,
	CONSTRAINT software_pkey PRIMARY KEY (codigo_producto)
);
-- ddl-end --
ALTER TABLE public.software OWNER TO postgres;
-- ddl-end --

-- object: public.prototipo | type: TABLE --
-- DROP TABLE IF EXISTS public.prototipo CASCADE;
CREATE TABLE public.prototipo (
	codigo_producto integer NOT NULL,
	version integer,
	ubicacion character varying(255),
	CONSTRAINT prototipo_pkey PRIMARY KEY (codigo_producto)
);
-- ddl-end --
ALTER TABLE public.prototipo OWNER TO postgres;
-- ddl-end --

-- object: public.recurso | type: TABLE --
-- DROP TABLE IF EXISTS public.recurso CASCADE;
CREATE TABLE public.recurso (
	codigo integer NOT NULL,
	nombre character varying(100) NOT NULL,
	descripcion character varying(255),
	tipo character varying(20),
	periodo_utilizacion integer,
	codigo_fase integer,
	CONSTRAINT recurso_pkey PRIMARY KEY (codigo)
);
-- ddl-end --
ALTER TABLE public.recurso OWNER TO postgres;
-- ddl-end --

-- object: public.gasto | type: TABLE --
-- DROP TABLE IF EXISTS public.gasto CASCADE;
CREATE TABLE public.gasto (
	codigo integer NOT NULL,
	descripcion character varying(255),
	fecha date,
	importe numeric(10,2),
	tipo character varying(100),
	codigo_proyecto integer,
	CONSTRAINT gasto_pkey PRIMARY KEY (codigo)
);
-- ddl-end --
ALTER TABLE public.gasto OWNER TO postgres;
-- ddl-end --

-- object: public.relacionproyecto | type: TABLE --
-- DROP TABLE IF EXISTS public.relacionproyecto CASCADE;
CREATE TABLE public.relacionproyecto (
	codigo_proyecto1 integer NOT NULL,
	codigo_proyecto2 integer NOT NULL,
	CONSTRAINT relacionproyecto_pkey PRIMARY KEY (codigo_proyecto1,codigo_proyecto2)
);
-- ddl-end --
ALTER TABLE public.relacionproyecto OWNER TO postgres;
-- ddl-end --

-- object: fase_codigo_proyecto_fkey | type: CONSTRAINT --
-- ALTER TABLE public.fase DROP CONSTRAINT IF EXISTS fase_codigo_proyecto_fkey CASCADE;
ALTER TABLE public.fase ADD CONSTRAINT fase_codigo_proyecto_fkey FOREIGN KEY (codigo_proyecto)
REFERENCES public.proyecto (codigo) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: jefeproyecto_codigo_proyecto_fkey | type: CONSTRAINT --
-- ALTER TABLE public.jefeproyecto DROP CONSTRAINT IF EXISTS jefeproyecto_codigo_proyecto_fkey CASCADE;
ALTER TABLE public.jefeproyecto ADD CONSTRAINT jefeproyecto_codigo_proyecto_fkey FOREIGN KEY (codigo_proyecto)
REFERENCES public.proyecto (codigo) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: jefeproyecto_codigo_empleado_fkey | type: CONSTRAINT --
-- ALTER TABLE public.jefeproyecto DROP CONSTRAINT IF EXISTS jefeproyecto_codigo_empleado_fkey CASCADE;
ALTER TABLE public.jefeproyecto ADD CONSTRAINT jefeproyecto_codigo_empleado_fkey FOREIGN KEY (codigo_empleado)
REFERENCES public.empleado (codigo) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: informatico_codigo_empleado_fkey | type: CONSTRAINT --
-- ALTER TABLE public.informatico DROP CONSTRAINT IF EXISTS informatico_codigo_empleado_fkey CASCADE;
ALTER TABLE public.informatico ADD CONSTRAINT informatico_codigo_empleado_fkey FOREIGN KEY (codigo_empleado)
REFERENCES public.empleado (codigo) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: programador_codigo_empleado_fkey | type: CONSTRAINT --
-- ALTER TABLE public.programador DROP CONSTRAINT IF EXISTS programador_codigo_empleado_fkey CASCADE;
ALTER TABLE public.programador ADD CONSTRAINT programador_codigo_empleado_fkey FOREIGN KEY (codigo_empleado)
REFERENCES public.informatico (codigo_empleado) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: lenguaje_codigo_programador_fkey | type: CONSTRAINT --
-- ALTER TABLE public.lenguaje DROP CONSTRAINT IF EXISTS lenguaje_codigo_programador_fkey CASCADE;
ALTER TABLE public.lenguaje ADD CONSTRAINT lenguaje_codigo_programador_fkey FOREIGN KEY (codigo_programador)
REFERENCES public.programador (codigo_empleado) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: producto_codigo_fase_fkey | type: CONSTRAINT --
-- ALTER TABLE public.producto DROP CONSTRAINT IF EXISTS producto_codigo_fase_fkey CASCADE;
ALTER TABLE public.producto ADD CONSTRAINT producto_codigo_fase_fkey FOREIGN KEY (codigo_fase)
REFERENCES public.fase (codigo) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: producto_responsable_analista_fkey | type: CONSTRAINT --
-- ALTER TABLE public.producto DROP CONSTRAINT IF EXISTS producto_responsable_analista_fkey CASCADE;
ALTER TABLE public.producto ADD CONSTRAINT producto_responsable_analista_fkey FOREIGN KEY (responsable_analista)
REFERENCES public.informatico (codigo_empleado) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: software_codigo_producto_fkey | type: CONSTRAINT --
-- ALTER TABLE public.software DROP CONSTRAINT IF EXISTS software_codigo_producto_fkey CASCADE;
ALTER TABLE public.software ADD CONSTRAINT software_codigo_producto_fkey FOREIGN KEY (codigo_producto)
REFERENCES public.producto (codigo) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: prototipo_codigo_producto_fkey | type: CONSTRAINT --
-- ALTER TABLE public.prototipo DROP CONSTRAINT IF EXISTS prototipo_codigo_producto_fkey CASCADE;
ALTER TABLE public.prototipo ADD CONSTRAINT prototipo_codigo_producto_fkey FOREIGN KEY (codigo_producto)
REFERENCES public.producto (codigo) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: recurso_codigo_fase_fkey | type: CONSTRAINT --
-- ALTER TABLE public.recurso DROP CONSTRAINT IF EXISTS recurso_codigo_fase_fkey CASCADE;
ALTER TABLE public.recurso ADD CONSTRAINT recurso_codigo_fase_fkey FOREIGN KEY (codigo_fase)
REFERENCES public.fase (codigo) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: gasto_codigo_proyecto_fkey | type: CONSTRAINT --
-- ALTER TABLE public.gasto DROP CONSTRAINT IF EXISTS gasto_codigo_proyecto_fkey CASCADE;
ALTER TABLE public.gasto ADD CONSTRAINT gasto_codigo_proyecto_fkey FOREIGN KEY (codigo_proyecto)
REFERENCES public.proyecto (codigo) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: relacionproyecto_codigo_proyecto1_fkey | type: CONSTRAINT --
-- ALTER TABLE public.relacionproyecto DROP CONSTRAINT IF EXISTS relacionproyecto_codigo_proyecto1_fkey CASCADE;
ALTER TABLE public.relacionproyecto ADD CONSTRAINT relacionproyecto_codigo_proyecto1_fkey FOREIGN KEY (codigo_proyecto1)
REFERENCES public.proyecto (codigo) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: relacionproyecto_codigo_proyecto2_fkey | type: CONSTRAINT --
-- ALTER TABLE public.relacionproyecto DROP CONSTRAINT IF EXISTS relacionproyecto_codigo_proyecto2_fkey CASCADE;
ALTER TABLE public.relacionproyecto ADD CONSTRAINT relacionproyecto_codigo_proyecto2_fkey FOREIGN KEY (codigo_proyecto2)
REFERENCES public.proyecto (codigo) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "grant_CU_26541e8cda" | type: PERMISSION --
GRANT CREATE,USAGE
   ON SCHEMA public
   TO pg_database_owner;
-- ddl-end --

-- object: "grant_U_cd8e46e7b6" | type: PERMISSION --
GRANT USAGE
   ON SCHEMA public
   TO PUBLIC;
-- ddl-end --


