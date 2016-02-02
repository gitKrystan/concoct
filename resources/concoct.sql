--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

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
\.


--
-- Name: categories_ingredients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('categories_ingredients_id_seq', 1, false);


--
-- Data for Name: combinations; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY combinations (ingredient_id, complement_id) FROM stdin;
\.


--
-- Data for Name: ingredients; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY ingredients (id, name, created_at, updated_at) FROM stdin;
\.


--
-- Name: ingredients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('ingredients_id_seq', 2, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY schema_migrations (version) FROM stdin;
20160201185327
20160201185500
20160201185754
20160201223626
\.


--
-- PostgreSQL database dump complete
--
