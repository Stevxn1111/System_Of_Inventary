--
-- PostgreSQL database dump
--

\restrict b0oYIwCZCPA9EpezgPIqFrm2RuAmz6SViPquhp9faXF2Ga2ZpiQCzqNC1PocGdY

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-05-01 17:11:47

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 16390)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    idcliente integer NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100),
    identificacion character varying(15) NOT NULL,
    telefono character varying(11),
    direccion character varying(100),
    correo character varying(50) NOT NULL,
    contrasena character varying(255) NOT NULL
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16389)
-- Name: cliente_idcliente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cliente_idcliente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cliente_idcliente_seq OWNER TO postgres;

--
-- TOC entry 5064 (class 0 OID 0)
-- Dependencies: 219
-- Name: cliente_idcliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cliente_idcliente_seq OWNED BY public.cliente.idcliente;


--
-- TOC entry 228 (class 1259 OID 16476)
-- Name: detalle_factura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_factura (
    iddetalle integer NOT NULL,
    idfactura integer NOT NULL,
    idproducto integer NOT NULL,
    cantidad integer NOT NULL,
    precio_unitario numeric(10,2) NOT NULL,
    subtotal numeric(10,2) NOT NULL
);


ALTER TABLE public.detalle_factura OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16475)
-- Name: detalle_factura_iddetalle_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalle_factura_iddetalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.detalle_factura_iddetalle_seq OWNER TO postgres;

--
-- TOC entry 5065 (class 0 OID 0)
-- Dependencies: 227
-- Name: detalle_factura_iddetalle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalle_factura_iddetalle_seq OWNED BY public.detalle_factura.iddetalle;


--
-- TOC entry 226 (class 1259 OID 16453)
-- Name: factura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.factura (
    idfactura integer NOT NULL,
    numero_factura character varying(50) NOT NULL,
    fecha date NOT NULL,
    idcliente integer NOT NULL,
    total numeric(10,2) NOT NULL,
    impuesto_total numeric(10,2) NOT NULL,
    estado character varying(50) NOT NULL,
    archivo_xml text,
    archivo_pdf text
);


ALTER TABLE public.factura OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16452)
-- Name: factura_idfactura_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.factura_idfactura_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.factura_idfactura_seq OWNER TO postgres;

--
-- TOC entry 5066 (class 0 OID 0)
-- Dependencies: 225
-- Name: factura_idfactura_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.factura_idfactura_seq OWNED BY public.factura.idfactura;


--
-- TOC entry 222 (class 1259 OID 16426)
-- Name: producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.producto (
    idproducto integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion character varying(200),
    precio numeric(10,2) NOT NULL,
    impuesto numeric(5,2) NOT NULL
);


ALTER TABLE public.producto OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16425)
-- Name: producto_idproducto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.producto_idproducto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.producto_idproducto_seq OWNER TO postgres;

--
-- TOC entry 5067 (class 0 OID 0)
-- Dependencies: 221
-- Name: producto_idproducto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.producto_idproducto_seq OWNED BY public.producto.idproducto;


--
-- TOC entry 224 (class 1259 OID 16437)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    idusuario integer NOT NULL,
    nombre character varying(100) NOT NULL,
    correo character varying(100) NOT NULL,
    contrasena character varying(255) NOT NULL,
    rol character varying(50) NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16436)
-- Name: usuario_idusuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_idusuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_idusuario_seq OWNER TO postgres;

--
-- TOC entry 5068 (class 0 OID 0)
-- Dependencies: 223
-- Name: usuario_idusuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_idusuario_seq OWNED BY public.usuario.idusuario;


--
-- TOC entry 4876 (class 2604 OID 16393)
-- Name: cliente idcliente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente ALTER COLUMN idcliente SET DEFAULT nextval('public.cliente_idcliente_seq'::regclass);


--
-- TOC entry 4880 (class 2604 OID 16479)
-- Name: detalle_factura iddetalle; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_factura ALTER COLUMN iddetalle SET DEFAULT nextval('public.detalle_factura_iddetalle_seq'::regclass);


--
-- TOC entry 4879 (class 2604 OID 16456)
-- Name: factura idfactura; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura ALTER COLUMN idfactura SET DEFAULT nextval('public.factura_idfactura_seq'::regclass);


--
-- TOC entry 4877 (class 2604 OID 16429)
-- Name: producto idproducto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto ALTER COLUMN idproducto SET DEFAULT nextval('public.producto_idproducto_seq'::regclass);


--
-- TOC entry 4878 (class 2604 OID 16440)
-- Name: usuario idusuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN idusuario SET DEFAULT nextval('public.usuario_idusuario_seq'::regclass);


--
-- TOC entry 5050 (class 0 OID 16390)
-- Dependencies: 220
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (idcliente, nombre, apellido, identificacion, telefono, direccion, correo, contrasena) FROM stdin;
\.


--
-- TOC entry 5058 (class 0 OID 16476)
-- Dependencies: 228
-- Data for Name: detalle_factura; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_factura (iddetalle, idfactura, idproducto, cantidad, precio_unitario, subtotal) FROM stdin;
\.


--
-- TOC entry 5056 (class 0 OID 16453)
-- Dependencies: 226
-- Data for Name: factura; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.factura (idfactura, numero_factura, fecha, idcliente, total, impuesto_total, estado, archivo_xml, archivo_pdf) FROM stdin;
\.


--
-- TOC entry 5052 (class 0 OID 16426)
-- Dependencies: 222
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.producto (idproducto, nombre, descripcion, precio, impuesto) FROM stdin;
\.


--
-- TOC entry 5054 (class 0 OID 16437)
-- Dependencies: 224
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (idusuario, nombre, correo, contrasena, rol) FROM stdin;
\.


--
-- TOC entry 5069 (class 0 OID 0)
-- Dependencies: 219
-- Name: cliente_idcliente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cliente_idcliente_seq', 1, false);


--
-- TOC entry 5070 (class 0 OID 0)
-- Dependencies: 227
-- Name: detalle_factura_iddetalle_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalle_factura_iddetalle_seq', 1, false);


--
-- TOC entry 5071 (class 0 OID 0)
-- Dependencies: 225
-- Name: factura_idfactura_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.factura_idfactura_seq', 1, false);


--
-- TOC entry 5072 (class 0 OID 0)
-- Dependencies: 221
-- Name: producto_idproducto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.producto_idproducto_seq', 1, false);


--
-- TOC entry 5073 (class 0 OID 0)
-- Dependencies: 223
-- Name: usuario_idusuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_idusuario_seq', 1, false);


--
-- TOC entry 4882 (class 2606 OID 16406)
-- Name: cliente cliente_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_correo_key UNIQUE (correo);


--
-- TOC entry 4884 (class 2606 OID 16404)
-- Name: cliente cliente_identificacion_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_identificacion_key UNIQUE (identificacion);


--
-- TOC entry 4886 (class 2606 OID 16402)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (idcliente);


--
-- TOC entry 4898 (class 2606 OID 16487)
-- Name: detalle_factura detalle_factura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_factura
    ADD CONSTRAINT detalle_factura_pkey PRIMARY KEY (iddetalle);


--
-- TOC entry 4894 (class 2606 OID 16469)
-- Name: factura factura_numero_factura_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_numero_factura_key UNIQUE (numero_factura);


--
-- TOC entry 4896 (class 2606 OID 16467)
-- Name: factura factura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_pkey PRIMARY KEY (idfactura);


--
-- TOC entry 4888 (class 2606 OID 16435)
-- Name: producto producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (idproducto);


--
-- TOC entry 4890 (class 2606 OID 16451)
-- Name: usuario usuario_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_correo_key UNIQUE (correo);


--
-- TOC entry 4892 (class 2606 OID 16449)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (idusuario);


--
-- TOC entry 4900 (class 2606 OID 16488)
-- Name: detalle_factura detalle_factura_idfactura_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_factura
    ADD CONSTRAINT detalle_factura_idfactura_fkey FOREIGN KEY (idfactura) REFERENCES public.factura(idfactura);


--
-- TOC entry 4901 (class 2606 OID 16493)
-- Name: detalle_factura detalle_factura_idproducto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_factura
    ADD CONSTRAINT detalle_factura_idproducto_fkey FOREIGN KEY (idproducto) REFERENCES public.producto(idproducto);


--
-- TOC entry 4899 (class 2606 OID 16470)
-- Name: factura factura_idcliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_idcliente_fkey FOREIGN KEY (idcliente) REFERENCES public.cliente(idcliente);


-- Completed on 2026-05-01 17:11:47

--
-- PostgreSQL database dump complete
--

\unrestrict b0oYIwCZCPA9EpezgPIqFrm2RuAmz6SViPquhp9faXF2Ga2ZpiQCzqNC1PocGdY

