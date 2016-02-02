--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: Guest; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE categories OWNER TO "Guest";

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE categories_id_seq OWNER TO "Guest";

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: categories_ingredients; Type: TABLE; Schema: public; Owner: Guest; Tablespace: 
--

CREATE TABLE categories_ingredients (
    id integer NOT NULL,
    category_id integer,
    ingredient_id integer
);


ALTER TABLE categories_ingredients OWNER TO "Guest";

--
-- Name: categories_ingredients_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE categories_ingredients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE categories_ingredients_id_seq OWNER TO "Guest";

--
-- Name: categories_ingredients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE categories_ingredients_id_seq OWNED BY categories_ingredients.id;


--
-- Name: ingredients; Type: TABLE; Schema: public; Owner: Guest; Tablespace: 
--

CREATE TABLE ingredients (
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE ingredients OWNER TO "Guest";

--
-- Name: ingredients_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE ingredients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ingredients_id_seq OWNER TO "Guest";

--
-- Name: ingredients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE ingredients_id_seq OWNED BY ingredients.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: Guest; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO "Guest";

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY categories_ingredients ALTER COLUMN id SET DEFAULT nextval('categories_ingredients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY ingredients ALTER COLUMN id SET DEFAULT nextval('ingredients_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY categories (id, name, created_at, updated_at) FROM stdin;
1	Primary	\N	\N
2	Secondary	\N	\N
3	Sweetener	\N	\N
4	Acid	\N	\N
5	Mixer	\N	\N
6	Garnish	\N	\N
7	Aromatic	\N	\N
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('categories_id_seq', 7, true);


--
-- Data for Name: categories_ingredients; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY categories_ingredients (id, category_id, ingredient_id) FROM stdin;
15	3	19
\.


--
-- Name: categories_ingredients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('categories_ingredients_id_seq', 15, true);


--
-- Data for Name: ingredients; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY ingredients (id, name, created_at, updated_at) FROM stdin;
1	Testing	2016-02-01 21:49:24.30768	2016-02-01 21:49:24.30768
2	Testing Ingredient	2016-02-01 21:53:47.70244	2016-02-01 21:53:47.70244
3	Testing Ingredient 2	2016-02-01 22:17:17.21696	2016-02-01 22:17:17.21696
4	Testing Ingredient 2	2016-02-01 22:18:00.830031	2016-02-01 22:18:00.830031
5	Test	2016-02-01 22:39:34.077063	2016-02-01 22:39:34.077063
6	Test2	2016-02-01 22:40:06.98243	2016-02-01 22:40:06.98243
7	Blah	2016-02-01 22:51:45.57225	2016-02-01 22:51:45.57225
8	Rum	2016-02-01 22:56:30.101545	2016-02-01 22:56:30.101545
9	Whiskey	2016-02-01 22:59:27.948178	2016-02-01 22:59:27.948178
10	Vodka	2016-02-01 23:10:31.988981	2016-02-01 23:10:31.988981
11	Vodka	2016-02-01 23:10:54.83763	2016-02-01 23:10:54.83763
12	Absinthe	2016-02-01 23:17:52.973429	2016-02-01 23:17:52.973429
13	Water	2016-02-01 23:19:50.358791	2016-02-01 23:19:50.358791
14	Water	2016-02-01 23:19:52.869218	2016-02-01 23:19:52.869218
15	Water	2016-02-01 23:20:56.79725	2016-02-01 23:20:56.79725
16	Water	2016-02-01 23:25:34.829273	2016-02-01 23:25:34.829273
17	Water	2016-02-01 23:26:01.461145	2016-02-01 23:26:01.461145
18	Water	2016-02-01 23:26:07.68519	2016-02-01 23:26:07.68519
19	Juice	2016-02-01 23:33:36.966266	2016-02-01 23:33:36.966266
20	Ruym	2016-02-01 23:42:33.989073	2016-02-01 23:42:33.989073
21	Rum	2016-02-01 23:42:42.766128	2016-02-01 23:42:42.766128
\.


--
-- Name: ingredients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('ingredients_id_seq', 21, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY schema_migrations (version) FROM stdin;
20160201185327
20160201185500
20160201185754
\.


--
-- Name: categories_ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: Guest; Tablespace: 
--

ALTER TABLE ONLY categories_ingredients
    ADD CONSTRAINT categories_ingredients_pkey PRIMARY KEY (id);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: Guest; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: Guest; Tablespace: 
--

ALTER TABLE ONLY ingredients
    ADD CONSTRAINT ingredients_pkey PRIMARY KEY (id);


--
-- Name: index_categories_ingredients_on_category_id; Type: INDEX; Schema: public; Owner: Guest; Tablespace: 
--

CREATE INDEX index_categories_ingredients_on_category_id ON categories_ingredients USING btree (category_id);


--
-- Name: index_categories_ingredients_on_ingredient_id; Type: INDEX; Schema: public; Owner: Guest; Tablespace: 
--

CREATE INDEX index_categories_ingredients_on_ingredient_id ON categories_ingredients USING btree (ingredient_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: Guest; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: epicodus
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM epicodus;
GRANT ALL ON SCHEMA public TO epicodus;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

