--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

-- Started on 2022-05-17 11:21:51

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 832 (class 1247 OID 16607)
-- Name: categ_oatmeal; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.categ_oatmeal AS ENUM (
    'oatmeal',
    'sweets',
    'drinks',
    'For baby goats',
    'For the herd'
);


ALTER TYPE public.categ_oatmeal OWNER TO postgres;

--
-- TOC entry 841 (class 1247 OID 16647)
-- Name: categ_ovaz; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.categ_ovaz AS ENUM (
    'oatmeal',
    'sweets',
    'drinks',
    'For baby goats',
    'For the herd'
);


ALTER TYPE public.categ_ovaz OWNER TO postgres;

--
-- TOC entry 847 (class 1247 OID 16670)
-- Name: roluri; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.roluri AS ENUM (
    'admin',
    'moderator',
    'comun'
);


ALTER TYPE public.roluri OWNER TO postgres;

--
-- TOC entry 844 (class 1247 OID 16658)
-- Name: tip_produse; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tip_produse AS ENUM (
    'soy milk',
    'coconut milk',
    'almond milk',
    'rice milk',
    'other'
);


ALTER TYPE public.tip_produse OWNER TO postgres;

--
-- TOC entry 835 (class 1247 OID 16618)
-- Name: tipuri_produse; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tipuri_produse AS ENUM (
    'soy milk',
    'coconut milk',
    'almond milk',
    'rice milk',
    'other'
);


ALTER TYPE public.tipuri_produse OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 16692)
-- Name: accesari; Type: TABLE; Schema: public; Owner: postgres
--
DROP TABLE public.accesari;
CREATE TABLE public.accesari (
    id integer NOT NULL,
    ip character varying(100) NOT NULL,
    user_id integer,
    pagina character varying(500) NOT NULL,
    data_accesare timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.accesari OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16691)
-- Name: accesari_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accesari_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accesari_id_seq OWNER TO postgres;

--
-- TOC entry 3375 (class 0 OID 0)
-- Dependencies: 215
-- Name: accesari_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accesari_id_seq OWNED BY public.accesari.id;


--
-- TOC entry 212 (class 1259 OID 16630)
-- Name: ovaz; Type: TABLE; Schema: public; Owner: postgres
--
DROP TABLE public.ovaz;
CREATE TABLE public.ovaz (
    id integer NOT NULL,
    nume character varying(50) NOT NULL,
    descriere text,
    pret numeric(8,2) NOT NULL,
    gramaj integer NOT NULL,
    calorii integer NOT NULL,
    tip_produs public.tipuri_produse DEFAULT 'other'::public.tipuri_produse,
    categorie public.categ_oatmeal DEFAULT 'oatmeal'::public.categ_oatmeal,
    ingrediente character varying[],
    added_sugar boolean DEFAULT false NOT NULL,
    imagine character varying(300),
    data_adaugare timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT ovaz_calorii_check CHECK ((calorii >= 0)),
    CONSTRAINT ovaz_gramaj_check CHECK ((gramaj >= 0))
);


ALTER TABLE public.ovaz OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16629)
-- Name: ovaz_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ovaz_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ovaz_id_seq OWNER TO postgres;

--
-- TOC entry 3378 (class 0 OID 0)
-- Dependencies: 211
-- Name: ovaz_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ovaz_id_seq OWNED BY public.ovaz.id;


--
-- TOC entry 210 (class 1259 OID 16397)
-- Name: produse; Type: TABLE; Schema: public; Owner: postgres
--
DROP TABLE public.produse;

CREATE TABLE public.produse (
    id integer NOT NULL,
    nume character varying(100) NOT NULL,
    pret double precision DEFAULT 10 NOT NULL
);


ALTER TABLE public.produse OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16396)
-- Name: produse_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.produse ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.produse_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 214 (class 1259 OID 16678)
-- Name: utilizatori; Type: TABLE; Schema: public; Owner: postgres
--
DROP TABLE public.utilizatori;
CREATE TABLE public.utilizatori (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    nume character varying(100) NOT NULL,
    prenume character varying(100) NOT NULL,
    parola character varying(500) NOT NULL,
    rol public.roluri DEFAULT 'comun'::public.roluri NOT NULL,
    email character varying(100) NOT NULL,
    culoare_chat character varying(50) DEFAULT 'black'::character varying NOT NULL,
    data_adaugare timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    cod1 character varying(100),
    confirmat_mail boolean DEFAULT false,
    telefon character varying(12),
    photo_path character varying(500),
    cod2 character varying(100)
);


ALTER TABLE public.utilizatori OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16677)
-- Name: utilizatori_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.utilizatori_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.utilizatori_id_seq OWNER TO postgres;

--
-- TOC entry 3383 (class 0 OID 0)
-- Dependencies: 213
-- Name: utilizatori_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.utilizatori_id_seq OWNED BY public.utilizatori.id;


--
-- TOC entry 3207 (class 2604 OID 16695)
-- Name: accesari id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accesari ALTER COLUMN id SET DEFAULT nextval('public.accesari_id_seq'::regclass);


--
-- TOC entry 3195 (class 2604 OID 16633)
-- Name: ovaz id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ovaz ALTER COLUMN id SET DEFAULT nextval('public.ovaz_id_seq'::regclass);


--
-- TOC entry 3202 (class 2604 OID 16681)
-- Name: utilizatori id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilizatori ALTER COLUMN id SET DEFAULT nextval('public.utilizatori_id_seq'::regclass);


--
-- TOC entry 3368 (class 0 OID 16692)
-- Dependencies: 216
-- Data for Name: accesari; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.accesari (id, ip, user_id, pagina, data_accesare) VALUES (541, '::1', NULL, '/inregistrare', '2022-05-17 11:06:59.392292');
INSERT INTO public.accesari (id, ip, user_id, pagina, data_accesare) VALUES (542, '::1', NULL, '/index', '2022-05-17 11:09:19.749917');
INSERT INTO public.accesari (id, ip, user_id, pagina, data_accesare) VALUES (543, '::1', NULL, '/index', '2022-05-17 11:09:55.635697');
INSERT INTO public.accesari (id, ip, user_id, pagina, data_accesare) VALUES (544, '::1', NULL, '/index', '2022-05-17 11:10:10.312711');


--
-- TOC entry 3364 (class 0 OID 16630)
-- Dependencies: 212
-- Data for Name: ovaz; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ovaz (id, nume, descriere, pret, gramaj, calorii, tip_produs, categorie, ingrediente, added_sugar, imagine, data_adaugare) VALUES (4, 'Berries and cream oatmeal', 'Oatmeal with berries and cream', 15.00, 300, 236, 'coconut milk', 'oatmeal', '{"fine oat flakes","coconut milk",honey,raspberries,cranberries,blueberries,strawberries}', false, 'oat_cream.jpg', '2022-04-03 02:37:27.645676');
INSERT INTO public.ovaz (id, nume, descriere, pret, gramaj, calorii, tip_produs, categorie, ingrediente, added_sugar, imagine, data_adaugare) VALUES (14, 'Raspberry and carrot oatmeal puree', 'Healthy and tasty fruit puree for the little ones', 10.00, 150, 102, 'almond milk', 'For baby goats', '{"fine oat flakes","almond milk",raspberries,honey,carrot}', false, 'baby_carrot.jpg', '2022-04-03 02:37:27.645676');
INSERT INTO public.ovaz (id, nume, descriere, pret, gramaj, calorii, tip_produs, categorie, ingrediente, added_sugar, imagine, data_adaugare) VALUES (16, 'Family pack 10+3 oatmeal', 'Promotional package created espacially for everyone to enjoy our goodies', 150.00, 250, 620, 'other', 'For the herd', '{}', true, 'oat10.jpg', '2022-04-03 02:37:27.645676');
INSERT INTO public.ovaz (id, nume, descriere, pret, gramaj, calorii, tip_produs, categorie, ingrediente, added_sugar, imagine, data_adaugare) VALUES (1, 'Strawberry jam oatmeal', 'Oatmeal with strawberry jam', 15.00, 300, 170, 'soy milk', 'oatmeal', '{"fine oat flakes","soy milk",honey,"homemade strawberry jam"}', false, 'strawberry-oat.jpg', '2022-04-03 02:37:27.645676');
INSERT INTO public.ovaz (id, nume, descriere, pret, gramaj, calorii, tip_produs, categorie, ingrediente, added_sugar, imagine, data_adaugare) VALUES (2, 'Peanutbutter oatmeal', 'Oatmeal with peanutbutter', 15.00, 300, 200, 'almond milk', 'oatmeal', '{"fine oat flakes","almond milk",honey,dates,"chocolate topping","creamy peanutbutter"}', true, 'peanut-oat.jpg', '2022-04-03 02:37:27.645676');
INSERT INTO public.ovaz (id, nume, descriere, pret, gramaj, calorii, tip_produs, categorie, ingrediente, added_sugar, imagine, data_adaugare) VALUES (3, 'Honey-walnut oatmeal', 'Oatmeal with honey and walnuts', 15.00, 300, 186, 'rice milk', 'oatmeal', '{"fine oat flakes","rice milk",honey,walnuts,dates,hazelnuts}', false, 'nut-oat.jpg', '2022-04-03 02:37:27.645676');
INSERT INTO public.ovaz (id, nume, descriere, pret, gramaj, calorii, tip_produs, categorie, ingrediente, added_sugar, imagine, data_adaugare) VALUES (5, 'Tiramisu oatmeal', 'Oatmeal with tiramisu flavour', 15.00, 300, 203, 'almond milk', 'oatmeal', '{"fine oat flakes","almond milk",honey,"coffee esence",cacao}', false, 'tiramisu-oat.jpg', '2022-04-03 02:37:27.645676');
INSERT INTO public.ovaz (id, nume, descriere, pret, gramaj, calorii, tip_produs, categorie, ingrediente, added_sugar, imagine, data_adaugare) VALUES (6, 'Orange and raisin oatmeal', 'Oatmeal with orange and raisins', 15.00, 300, 195, 'soy milk', 'oatmeal', '{"fine oat flakes","soy milk",honey,orange,raisins}', false, 'orange-oat.jpg', '2022-04-03 02:37:27.645676');
INSERT INTO public.ovaz (id, nume, descriere, pret, gramaj, calorii, tip_produs, categorie, ingrediente, added_sugar, imagine, data_adaugare) VALUES (7, 'Strawberry lemonade', 'Refreshing lemonade with freshly squeezed fruits', 10.00, 500, 37, 'other', 'drinks', '{water,sugar,"strawberries juice","lemon juice"}', true, 'pink-lemonade.jpg', '2022-04-03 02:37:27.645676');
INSERT INTO public.ovaz (id, nume, descriere, pret, gramaj, calorii, tip_produs, categorie, ingrediente, added_sugar, imagine, data_adaugare) VALUES (8, 'Mint lemonade', 'Refreshing lemonade with freshly squeezed fruits', 10.00, 500, 41, 'other', 'drinks', '{water,sugar,"lemon juice","mint leaves"}', true, 'lemonade.jpg', '2022-04-03 02:37:27.645676');
INSERT INTO public.ovaz (id, nume, descriere, pret, gramaj, calorii, tip_produs, categorie, ingrediente, added_sugar, imagine, data_adaugare) VALUES (9, 'Mango and strawberry smoothie', 'Creamy smoothie made from carefully frozen fruits', 10.00, 300, 106, 'soy milk', 'drinks', '{"soy milk",mango,strawberries,"lemon juice"}', false, 'pink-smoothie.jpg', '2022-04-03 02:37:27.645676');
INSERT INTO public.ovaz (id, nume, descriere, pret, gramaj, calorii, tip_produs, categorie, ingrediente, added_sugar, imagine, data_adaugare) VALUES (10, 'Pina colada smoothie', 'Creamy smoothie made from carefully frozen fruits', 10.00, 300, 110, 'coconut milk', 'drinks', '{"coconut milk",coconut,honey,water,ananas}', false, 'pina-colada.jpg', '2022-04-03 02:37:27.645676');
INSERT INTO public.ovaz (id, nume, descriere, pret, gramaj, calorii, tip_produs, categorie, ingrediente, added_sugar, imagine, data_adaugare) VALUES (11, 'Banana oatmeal puree', 'Healthy and tasty fruit puree for the little ones', 10.00, 150, 103, 'soy milk', 'For baby goats', '{"fine oat flakes","soy milk",banana,honey}', false, 'banana-baby.jpg', '2022-04-03 02:37:27.645676');
INSERT INTO public.ovaz (id, nume, descriere, pret, gramaj, calorii, tip_produs, categorie, ingrediente, added_sugar, imagine, data_adaugare) VALUES (12, 'Apple and Banana oatmeal puree', 'Healthy and tasty fruit puree for the little ones', 10.00, 150, 97, 'rice milk', 'For baby goats', '{"fine oat flakes","rice milk",banana,honey,apples}', false, 'apple-baby.jpg', '2022-04-03 02:37:27.645676');
INSERT INTO public.ovaz (id, nume, descriere, pret, gramaj, calorii, tip_produs, categorie, ingrediente, added_sugar, imagine, data_adaugare) VALUES (13, 'Berries oatmeal puree', 'Healthy and tasty fruit puree for the little ones', 10.00, 150, 100, 'rice milk', 'For baby goats', '{"fine oat flakes",honey,raspberries,cranberries,blueberries,strawberries}', false, 'berry-baby.jpg', '2022-04-03 02:37:27.645676');
INSERT INTO public.ovaz (id, nume, descriere, pret, gramaj, calorii, tip_produs, categorie, ingrediente, added_sugar, imagine, data_adaugare) VALUES (15, 'Family pack 4+1 oatmeal', 'Promotional package created espacially for everyone to enjoy our goodies', 60.00, 1500, 1000, 'other', 'For the herd', '{}', true, 'oat4.jpg', '2022-04-03 02:37:27.645676');
INSERT INTO public.ovaz (id, nume, descriere, pret, gramaj, calorii, tip_produs, categorie, ingrediente, added_sugar, imagine, data_adaugare) VALUES (17, 'Family pack 7 oatmeal + 2 sweets', 'Promotional package created espacially for everyone to enjoy our goodies', 110.00, 250, 620, 'other', 'For the herd', '{}', true, 'oat7.jpg
', '2022-04-03 02:37:27.645676');
INSERT INTO public.ovaz (id, nume, descriere, pret, gramaj, calorii, tip_produs, categorie, ingrediente, added_sugar, imagine, data_adaugare) VALUES (18, 'Family pack "the G-OAT experience', 'Biggest promotional package created espacially for everyone to enjoy our goodies', 250.00, 2500, 2050, 'other', 'For the herd', '{}', true, 'experience.jpg', '2022-04-03 02:37:27.645676');


--
-- TOC entry 3362 (class 0 OID 16397)
-- Dependencies: 210
-- Data for Name: produse; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.produse (id, nume, pret) OVERRIDING SYSTEM VALUE VALUES (1, 'monitor', 500);
INSERT INTO public.produse (id, nume, pret) OVERRIDING SYSTEM VALUE VALUES (2, 'covrig', 10);
INSERT INTO public.produse (id, nume, pret) OVERRIDING SYSTEM VALUE VALUES (3, 'mouse', 150);
INSERT INTO public.produse (id, nume, pret) OVERRIDING SYSTEM VALUE VALUES (4, 'bomboana', 5);
INSERT INTO public.produse (id, nume, pret) OVERRIDING SYSTEM VALUE VALUES (5, 'marker', 10);


--
-- TOC entry 3366 (class 0 OID 16678)
-- Dependencies: 214
-- Data for Name: utilizatori; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.utilizatori (id, username, nume, prenume, parola, rol, email, culoare_chat, data_adaugare, cod1, confirmat_mail, telefon, photo_path, cod2) VALUES (18, 'david', 'david', 'david', 'c44bc6f9e92993526e6e7081b4c81823cc84fcdf37b458072535648a5cca013d0f3ad20d3055399b8a95a9b02b020a4b52585f5ef8948450d1106debe0faafbe', 'comun', 'davidpatranjel24@gmail.com', 'black', '2022-05-12 00:36:06.008499', 'h6AA9W41U38Ck2zl8hzIgkM4aY9sVd8VnrIFmz391bid5YLZwK', true, '0785284130', NULL, '1652304965970');
INSERT INTO public.utilizatori (id, username, nume, prenume, parola, rol, email, culoare_chat, data_adaugare, cod1, confirmat_mail, telefon, photo_path, cod2) VALUES (19, 'david2', 'david', 'david', '4536b126ba9b3645247b2696a81b66d43f9160092b3d51e4c13c4b58b246307a6ad4a45645c17549e71e97d9ccf36da40622f2217153485f73c96104d6ed57d8', 'comun', 'davidpatranjel24@gmail.com', 'green', '2022-05-12 00:41:45.423349', 'AGRYNVt464OsqaH3YvlAqRC0Iff6IOvkdPMVEYVtm9PCyAuAzd', false, '0785284130', NULL, '1652305305386');
INSERT INTO public.utilizatori (id, username, nume, prenume, parola, rol, email, culoare_chat, data_adaugare, cod1, confirmat_mail, telefon, photo_path, cod2) VALUES (22, 'david5', 'david', 'david', 'adc6487db2678a2cfebcc1dd5d3397b300d122f42fbf2bdc5154fb20544259446df7a88c91f26e074f83bcde48779d8d995885f2c147420495da16cfb4b1495f', 'comun', 'davidpatranjel24@gmail.com', 'black', '2022-05-12 00:53:23.834758', '8jjYb270GmDKkTU4pLxwfPeIo7e7gUEyj5S9Hfr6Zr7Uy4JEbg', false, '+40785284130', NULL, '1652306003796');
INSERT INTO public.utilizatori (id, username, nume, prenume, parola, rol, email, culoare_chat, data_adaugare, cod1, confirmat_mail, telefon, photo_path, cod2) VALUES (24, 'admin1', 'admin', 'admin', 'ee4d63042159141c7b9ad1d8a415b4ccda3ca1e5c87001f8c1ab43175f1960c58ecf64ecec405d3610071c8066e1bb99653a90c2c83900ad96eade7b97bb3169', 'admin', 'davidpatranjel24@gmail.com', 'green', '2022-05-12 01:18:24.38074', '4d2b0F5iUSZ4FEoqvTPIutaS3urqZVkTxnQX7VGVCREuq5kXdi', true, '0785284130', NULL, '1652307504343');
INSERT INTO public.utilizatori (id, username, nume, prenume, parola, rol, email, culoare_chat, data_adaugare, cod1, confirmat_mail, telefon, photo_path, cod2) VALUES (21, 'david4', 'david', 'david', '0c845bda874594c7880e9c00ccf9ccd687e17b61810ed8688da40fbe8e7c93e0f33f8d165b457451f818bba7168fda89cd1fa97c8aec892a0be82a83b65997b9', 'comun', 'davidpatranjel24@gmail.com', 'black', '2022-05-12 00:44:59.057023', 'lBdC0SzYqPhhWdggSIi2sxsX6THVJ0RuIN3nh52LCViZsi86Jx', true, '0785284130', NULL, '1652305499014');
INSERT INTO public.utilizatori (id, username, nume, prenume, parola, rol, email, culoare_chat, data_adaugare, cod1, confirmat_mail, telefon, photo_path, cod2) VALUES (20, 'david3', 'david', 'david', '126a8ce026046c00f69d220a1c15c9f20851b76373dc2f739c46a17831e79dee4e6ec57582a2192d86d46bc8af72d1d27921062dffb2a919adb8d87dae7514af', 'comun', 'davidpatranjel24@gmail.com', 'black', '2022-05-12 00:43:10.684068', 'JT3tlDnVNwavSLusayYdxZGzRzFY1rEwshN4HcYFIQ6WfrEaza', false, '0785284130', NULL, '1652305390644');
INSERT INTO public.utilizatori (id, username, nume, prenume, parola, rol, email, culoare_chat, data_adaugare, cod1, confirmat_mail, telefon, photo_path, cod2) VALUES (23, 'david6', 'david', 'david', 'e3b013426e203fa5f10491890360407fc8742fbaf359ec5bfaca24260f1fcf93ff63e2ad2cca5d3d1d03800a170d21813033cdbf2793446cf681d3eb889f57e0', 'comun', 'davidpatranjel24@gmail.com', 'black', '2022-05-12 00:56:57.633378', 'LoztrmBUN7GZsBEpAiUfDTYjH4mDWgtBe9VHX1YZrdVwqGQsJV', true, '0785284130', NULL, '1652306217586');
INSERT INTO public.utilizatori (id, username, nume, prenume, parola, rol, email, culoare_chat, data_adaugare, cod1, confirmat_mail, telefon, photo_path, cod2) VALUES (25, 'david10', 'david', 'david', '0bed126c26e0a3fd684b21318c05ed1979dd1fd4def9291b8419cc9deff83f1b19ce9549b87e1d7e7a6e1526f4a4095723665d60f0f8cf2f8bae7724bbc54141', 'comun', 'davidpatranjel24@gmail.com', 'black', '2022-05-16 18:52:32.376436', 'zs9NHHj96niUVa3v7q2SSpsNux2bo1d3C9rpDxPunotOgEe8m9', true, '078528413', NULL, '1652716352320');
INSERT INTO public.utilizatori (id, username, nume, prenume, parola, rol, email, culoare_chat, data_adaugare, cod1, confirmat_mail, telefon, photo_path, cod2) VALUES (26, 'david11', 'david', 'david', 'd93f66b5df1e8f6b2b0f89b770a291e70e65a4dd1ca5f85918ab78a2e9fa15fd8980cfc137f5eae445e5ff16b68e8fb51ace4720ef4a5c57743a7956580356dd', 'comun', 'davidpatranjel24@gmail.com', 'black', '2022-05-17 10:51:36.373355', 'xuISdnbC2kYcS11HzgLORVYEyNVMLqhCiEW3jfgSHupAtW41iM', false, '0785284130', NULL, '1652773896314');
INSERT INTO public.utilizatori (id, username, nume, prenume, parola, rol, email, culoare_chat, data_adaugare, cod1, confirmat_mail, telefon, photo_path, cod2) VALUES (27, 'david12', 'david', 'david', 'e34cdeb279f7c6c54fe7aacab3867382327ea6854f610fb6e974c7031407a82b1874937f0a0addb9e76af1e55a9f9af4862625382803068df8f8d192b275ed7a', 'comun', 'davidpatranjel24@gmail.com', 'black', '2022-05-17 11:09:09.911892', 'cGBjDtNu9HHzBokO0gbEb2BHcCg77ZxTorPUlgPCPdBr9H19Of', false, '+0785284130', NULL, '1652774949839');


--
-- TOC entry 3385 (class 0 OID 0)
-- Dependencies: 215
-- Name: accesari_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accesari_id_seq', 544, true);


--
-- TOC entry 3386 (class 0 OID 0)
-- Dependencies: 211
-- Name: ovaz_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ovaz_id_seq', 18, true);


--
-- TOC entry 3387 (class 0 OID 0)
-- Dependencies: 209
-- Name: produse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produse_id_seq', 5, true);


--
-- TOC entry 3388 (class 0 OID 0)
-- Dependencies: 213
-- Name: utilizatori_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.utilizatori_id_seq', 27, true);


--
-- TOC entry 3220 (class 2606 OID 16700)
-- Name: accesari accesari_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accesari
    ADD CONSTRAINT accesari_pkey PRIMARY KEY (id);


--
-- TOC entry 3212 (class 2606 OID 16645)
-- Name: ovaz ovaz_nume_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ovaz
    ADD CONSTRAINT ovaz_nume_key UNIQUE (nume);


--
-- TOC entry 3214 (class 2606 OID 16643)
-- Name: ovaz ovaz_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ovaz
    ADD CONSTRAINT ovaz_pkey PRIMARY KEY (id);


--
-- TOC entry 3210 (class 2606 OID 16402)
-- Name: produse produse_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produse
    ADD CONSTRAINT produse_pkey PRIMARY KEY (id);


--
-- TOC entry 3216 (class 2606 OID 16688)
-- Name: utilizatori utilizatori_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilizatori
    ADD CONSTRAINT utilizatori_pkey PRIMARY KEY (id);


--
-- TOC entry 3218 (class 2606 OID 16690)
-- Name: utilizatori utilizatori_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilizatori
    ADD CONSTRAINT utilizatori_username_key UNIQUE (username);


--
-- TOC entry 3221 (class 2606 OID 16701)
-- Name: accesari accesari_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accesari
    ADD CONSTRAINT accesari_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.utilizatori(id);


--
-- TOC entry 3374 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE accesari; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.accesari TO lab1512;


--
-- TOC entry 3376 (class 0 OID 0)
-- Dependencies: 215
-- Name: SEQUENCE accesari_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.accesari_id_seq TO lab1512;


--
-- TOC entry 3377 (class 0 OID 0)
-- Dependencies: 212
-- Name: TABLE ovaz; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ovaz TO lab1512;


--
-- TOC entry 3379 (class 0 OID 0)
-- Dependencies: 211
-- Name: SEQUENCE ovaz_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.ovaz_id_seq TO lab1512;


--
-- TOC entry 3380 (class 0 OID 0)
-- Dependencies: 210
-- Name: TABLE produse; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.produse TO lab1512;


--
-- TOC entry 3381 (class 0 OID 0)
-- Dependencies: 209
-- Name: SEQUENCE produse_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.produse_id_seq TO lab1512;


--
-- TOC entry 3382 (class 0 OID 0)
-- Dependencies: 214
-- Name: TABLE utilizatori; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.utilizatori TO lab1512;


--
-- TOC entry 3384 (class 0 OID 0)
-- Dependencies: 213
-- Name: SEQUENCE utilizatori_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.utilizatori_id_seq TO lab1512;


-- Completed on 2022-05-17 11:21:51

--
-- PostgreSQL database dump complete
--

