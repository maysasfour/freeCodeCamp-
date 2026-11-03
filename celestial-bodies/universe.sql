--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text NOT NULL,
    age_in_millions_of_years integer,
    distance_from_earth numeric,
    is_spherical boolean
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: galaxy_type; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy_type (
    galaxy_type_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.galaxy_type OWNER TO freecodecamp;

--
-- Name: galaxy_type_galaxy_type_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_type_galaxy_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_type_galaxy_type_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_type_galaxy_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_type_galaxy_type_id_seq OWNED BY public.galaxy_type.galaxy_type_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(100) NOT NULL,
    planet_id integer NOT NULL,
    radius_km numeric,
    is_spherical boolean NOT NULL
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(100) NOT NULL,
    star_id integer NOT NULL,
    description text,
    has_life boolean NOT NULL,
    radius_km numeric
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(100) NOT NULL,
    galaxy_id integer NOT NULL,
    temperature_kelvin integer,
    age_in_millions_of_years numeric,
    is_spherical boolean
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: galaxy_type galaxy_type_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_type ALTER COLUMN galaxy_type_id SET DEFAULT nextval('public.galaxy_type_galaxy_type_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 'Our barred spiral galaxy', 13600, 0, false);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 'A neighboring spiral galaxy', 10000, 2537000, false);
INSERT INTO public.galaxy VALUES (3, 'Triangulum', 'A Local Group spiral galaxy', 10000, 2730000, false);
INSERT INTO public.galaxy VALUES (4, 'Large Magellanic Cloud', 'A nearby satellite galaxy', 1100, 163000, false);
INSERT INTO public.galaxy VALUES (5, 'Small Magellanic Cloud', 'An irregular satellite galaxy', 6500, 200000, false);
INSERT INTO public.galaxy VALUES (6, 'Messier 87', 'A giant elliptical galaxy', 13200, 53500000, true);


--
-- Data for Name: galaxy_type; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy_type VALUES (1, 'Spiral', 'Rotating disks with spiral arms');
INSERT INTO public.galaxy_type VALUES (2, 'Elliptical', 'Smooth ellipsoidal distributions of stars');
INSERT INTO public.galaxy_type VALUES (3, 'Irregular', 'Galaxies without a regular shape');


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Moon', 3, 1737.4, true);
INSERT INTO public.moon VALUES (2, 'Phobos', 4, 11.3, false);
INSERT INTO public.moon VALUES (3, 'Deimos', 4, 6.2, false);
INSERT INTO public.moon VALUES (4, 'Io', 5, 1821.6, true);
INSERT INTO public.moon VALUES (5, 'Europa', 5, 1560.8, true);
INSERT INTO public.moon VALUES (6, 'Ganymede', 5, 2634.1, true);
INSERT INTO public.moon VALUES (7, 'Callisto', 5, 2410.3, true);
INSERT INTO public.moon VALUES (8, 'Amalthea', 5, 83.5, false);
INSERT INTO public.moon VALUES (9, 'Titan', 6, 2574.7, true);
INSERT INTO public.moon VALUES (10, 'Enceladus', 6, 252.1, true);
INSERT INTO public.moon VALUES (11, 'Mimas', 6, 198.2, true);
INSERT INTO public.moon VALUES (12, 'Tethys', 6, 531.1, true);
INSERT INTO public.moon VALUES (13, 'Dione', 6, 561.4, true);
INSERT INTO public.moon VALUES (14, 'Rhea', 6, 763.8, true);
INSERT INTO public.moon VALUES (15, 'Iapetus', 6, 734.5, true);
INSERT INTO public.moon VALUES (16, 'Miranda', 7, 235.8, true);
INSERT INTO public.moon VALUES (17, 'Ariel', 7, 578.9, true);
INSERT INTO public.moon VALUES (18, 'Umbriel', 7, 584.7, true);
INSERT INTO public.moon VALUES (19, 'Titania', 7, 788.9, true);
INSERT INTO public.moon VALUES (20, 'Oberon', 7, 761.4, true);
INSERT INTO public.moon VALUES (21, 'Triton', 8, 1353.4, true);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mercury', 1, 'Rocky inner planet', false, 2439.7);
INSERT INTO public.planet VALUES (2, 'Venus', 1, 'Rocky planet with a dense atmosphere', false, 6051.8);
INSERT INTO public.planet VALUES (3, 'Earth', 1, 'Our home planet', true, 6371);
INSERT INTO public.planet VALUES (4, 'Mars', 1, 'Rocky red planet', false, 3389.5);
INSERT INTO public.planet VALUES (5, 'Jupiter', 1, 'Gas giant', false, 69911);
INSERT INTO public.planet VALUES (6, 'Saturn', 1, 'Ringed gas giant', false, 58232);
INSERT INTO public.planet VALUES (7, 'Uranus', 1, 'Ice giant', false, 25362);
INSERT INTO public.planet VALUES (8, 'Neptune', 1, 'Distant ice giant', false, 24622);
INSERT INTO public.planet VALUES (9, 'Proxima Centauri b', 2, 'Nearby exoplanet', false, NULL);
INSERT INTO public.planet VALUES (10, 'TRAPPIST-1 b', 3, 'Rocky exoplanet', false, NULL);
INSERT INTO public.planet VALUES (11, 'TRAPPIST-1 c', 3, 'Rocky exoplanet', false, NULL);
INSERT INTO public.planet VALUES (12, 'TRAPPIST-1 d', 3, 'Rocky exoplanet', false, NULL);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 1, 5772, 4600, true);
INSERT INTO public.star VALUES (2, 'Proxima Centauri', 1, 3042, 4850, true);
INSERT INTO public.star VALUES (3, 'TRAPPIST-1', 1, 2566, 7600, true);
INSERT INTO public.star VALUES (4, 'Sirius', 1, 9940, 242, true);
INSERT INTO public.star VALUES (5, 'Betelgeuse', 1, 3500, 8, true);
INSERT INTO public.star VALUES (6, 'Vega', 1, 9602, 455, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: galaxy_type_galaxy_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_type_galaxy_type_id_seq', 3, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 21, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: galaxy_type galaxy_type_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_type
    ADD CONSTRAINT galaxy_type_name_key UNIQUE (name);


--
-- Name: galaxy_type galaxy_type_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_type
    ADD CONSTRAINT galaxy_type_pkey PRIMARY KEY (galaxy_type_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

