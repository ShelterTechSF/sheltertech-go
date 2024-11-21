--
-- PostgreSQL database dump
--
CREATE DATABASE askdarcel_development;
GRANT ALL PRIVILEGES ON DATABASE askdarcel_development TO postgres;
\c askdarcel_development
-- Dumped from database version 13.11 (Debian 13.11-1.pgdg120+1)
-- Dumped by pg_dump version 13.11 (Debian 13.11-1.pgdg120+1)

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
-- Name: accessibilities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accessibilities (
    id bigint NOT NULL,
    accessibility character varying,
    details character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.accessibilities OWNER TO postgres;

--
-- Name: accessibilities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accessibilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accessibilities_id_seq OWNER TO postgres;

--
-- Name: accessibilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accessibilities_id_seq OWNED BY public.accessibilities.id;


--
-- Name: addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.addresses (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    attention character varying,
    address_1 character varying NOT NULL,
    address_2 character varying,
    address_3 character varying,
    address_4 character varying,
    city character varying NOT NULL,
    state_province character varying NOT NULL,
    postal_code character varying NOT NULL,
    resource_id integer,
    latitude numeric,
    longitude numeric,
    online boolean,
    region character varying,
    name character varying,
    description text,
    transportation text
);


ALTER TABLE public.addresses OWNER TO postgres;

--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.addresses_id_seq OWNER TO postgres;

--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.addresses_id_seq OWNED BY public.addresses.id;


--
-- Name: addresses_services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.addresses_services (
    service_id integer NOT NULL,
    address_id integer NOT NULL
);


ALTER TABLE public.addresses_services OWNER TO postgres;

--
-- Name: admins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admins (
    id bigint NOT NULL,
    provider character varying DEFAULT 'email'::character varying NOT NULL,
    uid character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    email character varying,
    tokens json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.admins OWNER TO postgres;

--
-- Name: admins_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admins_id_seq OWNER TO postgres;

--
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admins_id_seq OWNED BY public.admins.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO postgres;

--
-- Name: bookmarks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bookmarks (
    id bigint NOT NULL,
    identifier character varying,
    date_value timestamp without time zone,
    id_value integer,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.bookmarks OWNER TO postgres;

--
-- Name: bookmarks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bookmarks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bookmarks_id_seq OWNER TO postgres;

--
-- Name: bookmarks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bookmarks_id_seq OWNED BY public.bookmarks.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    vocabulary character varying,
    featured boolean DEFAULT false
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: categories_keywords; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories_keywords (
    category_id integer NOT NULL,
    keyword_id integer NOT NULL
);


ALTER TABLE public.categories_keywords OWNER TO postgres;

--
-- Name: categories_resources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories_resources (
    category_id integer NOT NULL,
    resource_id integer NOT NULL
);


ALTER TABLE public.categories_resources OWNER TO postgres;

--
-- Name: categories_services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories_services (
    service_id integer NOT NULL,
    category_id integer NOT NULL,
    feature_rank integer
);


ALTER TABLE public.categories_services OWNER TO postgres;

--
-- Name: categories_sites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories_sites (
    category_id bigint NOT NULL,
    site_id bigint NOT NULL
);


ALTER TABLE public.categories_sites OWNER TO postgres;

--
-- Name: category_relationships; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category_relationships (
    parent_id integer NOT NULL,
    child_id integer NOT NULL,
    child_priority_rank integer
);


ALTER TABLE public.category_relationships OWNER TO postgres;

--
-- Name: change_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.change_requests (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    type character varying,
    object_id integer,
    status integer DEFAULT 0,
    action integer DEFAULT 1,
    resource_id integer
);


ALTER TABLE public.change_requests OWNER TO postgres;

--
-- Name: change_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.change_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.change_requests_id_seq OWNER TO postgres;

--
-- Name: change_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.change_requests_id_seq OWNED BY public.change_requests.id;


--
-- Name: contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contacts (
    id bigint NOT NULL,
    name character varying,
    title character varying,
    email character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    resource_id integer,
    service_id integer
);


ALTER TABLE public.contacts OWNER TO postgres;

--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contacts_id_seq OWNER TO postgres;

--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contacts_id_seq OWNED BY public.contacts.id;


--
-- Name: delayed_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.delayed_jobs (
    id integer NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    attempts integer DEFAULT 0 NOT NULL,
    handler text NOT NULL,
    last_error text,
    run_at timestamp without time zone,
    locked_at timestamp without time zone,
    failed_at timestamp without time zone,
    locked_by character varying,
    queue character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.delayed_jobs OWNER TO postgres;

--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.delayed_jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.delayed_jobs_id_seq OWNER TO postgres;

--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.delayed_jobs_id_seq OWNED BY public.delayed_jobs.id;


--
-- Name: documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documents (
    id bigint NOT NULL,
    name character varying,
    url character varying,
    description character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.documents OWNER TO postgres;

--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documents_id_seq OWNER TO postgres;

--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.documents_id_seq OWNED BY public.documents.id;


--
-- Name: documents_services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documents_services (
    service_id integer,
    document_id integer
);


ALTER TABLE public.documents_services OWNER TO postgres;

--
-- Name: eligibilities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eligibilities (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    feature_rank integer,
    is_parent boolean DEFAULT false
);


ALTER TABLE public.eligibilities OWNER TO postgres;

--
-- Name: eligibilities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eligibilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eligibilities_id_seq OWNER TO postgres;

--
-- Name: eligibilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eligibilities_id_seq OWNED BY public.eligibilities.id;


--
-- Name: eligibilities_services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eligibilities_services (
    service_id integer NOT NULL,
    eligibility_id integer NOT NULL
);


ALTER TABLE public.eligibilities_services OWNER TO postgres;

--
-- Name: eligibility_relationships; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eligibility_relationships (
    parent_id integer NOT NULL,
    child_id integer NOT NULL
);


ALTER TABLE public.eligibility_relationships OWNER TO postgres;

--
-- Name: feedbacks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feedbacks (
    id bigint NOT NULL,
    rating character varying NOT NULL,
    resource_id bigint,
    service_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.feedbacks OWNER TO postgres;

--
-- Name: feedbacks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.feedbacks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feedbacks_id_seq OWNER TO postgres;

--
-- Name: feedbacks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.feedbacks_id_seq OWNED BY public.feedbacks.id;


--
-- Name: field_changes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.field_changes (
    id bigint NOT NULL,
    field_name character varying,
    field_value character varying,
    change_request_id integer NOT NULL
);


ALTER TABLE public.field_changes OWNER TO postgres;

--
-- Name: field_changes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.field_changes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.field_changes_id_seq OWNER TO postgres;

--
-- Name: field_changes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.field_changes_id_seq OWNED BY public.field_changes.id;


--
-- Name: fundings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fundings (
    id bigint NOT NULL,
    source character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.fundings OWNER TO postgres;

--
-- Name: fundings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fundings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fundings_id_seq OWNER TO postgres;

--
-- Name: fundings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fundings_id_seq OWNED BY public.fundings.id;


--
-- Name: instructions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instructions (
    id bigint NOT NULL,
    instruction character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    service_id bigint
);


ALTER TABLE public.instructions OWNER TO postgres;

--
-- Name: instructions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.instructions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.instructions_id_seq OWNER TO postgres;

--
-- Name: instructions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.instructions_id_seq OWNED BY public.instructions.id;


--
-- Name: keywords; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keywords (
    id bigint NOT NULL,
    name character varying
);


ALTER TABLE public.keywords OWNER TO postgres;

--
-- Name: keywords_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.keywords_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.keywords_id_seq OWNER TO postgres;

--
-- Name: keywords_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.keywords_id_seq OWNED BY public.keywords.id;


--
-- Name: keywords_resources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keywords_resources (
    resource_id integer NOT NULL,
    keyword_id integer NOT NULL
);


ALTER TABLE public.keywords_resources OWNER TO postgres;

--
-- Name: keywords_services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keywords_services (
    service_id integer NOT NULL,
    keyword_id integer NOT NULL
);


ALTER TABLE public.keywords_services OWNER TO postgres;

--
-- Name: languages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.languages (
    id bigint NOT NULL,
    language character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.languages OWNER TO postgres;

--
-- Name: languages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.languages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.languages_id_seq OWNER TO postgres;

--
-- Name: languages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.languages_id_seq OWNED BY public.languages.id;


--
-- Name: news_articles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.news_articles (
    id bigint NOT NULL,
    headline character varying,
    effective_date timestamp without time zone,
    body character varying,
    priority integer,
    expiration_date timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    url character varying
);


ALTER TABLE public.news_articles OWNER TO postgres;

--
-- Name: news_articles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.news_articles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.news_articles_id_seq OWNER TO postgres;

--
-- Name: news_articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.news_articles_id_seq OWNED BY public.news_articles.id;


--
-- Name: notes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notes (
    id bigint NOT NULL,
    note text,
    resource_id integer,
    service_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.notes OWNER TO postgres;

--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notes_id_seq OWNER TO postgres;

--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notes_id_seq OWNED BY public.notes.id;


--
-- Name: phones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.phones (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    number character varying NOT NULL,
    service_type character varying NOT NULL,
    resource_id integer NOT NULL,
    description character varying,
    service_id integer,
    contact_id integer,
    language_id integer
);


ALTER TABLE public.phones OWNER TO postgres;

--
-- Name: phones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.phones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.phones_id_seq OWNER TO postgres;

--
-- Name: phones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.phones_id_seq OWNED BY public.phones.id;


--
-- Name: programs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.programs (
    id bigint NOT NULL,
    name character varying,
    alternate_name character varying,
    description character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    resource_id integer
);


ALTER TABLE public.programs OWNER TO postgres;

--
-- Name: programs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.programs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.programs_id_seq OWNER TO postgres;

--
-- Name: programs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.programs_id_seq OWNED BY public.programs.id;


--
-- Name: resources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resources (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying NOT NULL,
    short_description character varying,
    long_description text,
    website character varying,
    verified_at timestamp without time zone,
    email character varying,
    status integer,
    certified boolean DEFAULT false,
    alternate_name character varying,
    legal_status character varying,
    contact_id integer,
    funding_id integer,
    certified_at timestamp without time zone,
    featured boolean,
    source_attribution integer DEFAULT 0,
    internal_note text
);


ALTER TABLE public.resources OWNER TO postgres;

--
-- Name: resources_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.resources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.resources_id_seq OWNER TO postgres;

--
-- Name: resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.resources_id_seq OWNED BY public.resources.id;


--
-- Name: resources_sites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resources_sites (
    resource_id bigint NOT NULL,
    site_id bigint NOT NULL
);


ALTER TABLE public.resources_sites OWNER TO postgres;

--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    id bigint NOT NULL,
    review text,
    tags text[] DEFAULT '{}'::text[],
    feedback_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reviews_id_seq OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: schedule_days; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedule_days (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    day character varying NOT NULL,
    opens_at integer,
    closes_at integer,
    schedule_id integer NOT NULL,
    open_time time without time zone,
    open_day character varying,
    close_time time without time zone,
    close_day character varying
);


ALTER TABLE public.schedule_days OWNER TO postgres;

--
-- Name: schedule_days_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schedule_days_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schedule_days_id_seq OWNER TO postgres;

--
-- Name: schedule_days_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schedule_days_id_seq OWNED BY public.schedule_days.id;


--
-- Name: schedules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedules (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    resource_id integer,
    service_id integer,
    hours_known boolean DEFAULT true
);


ALTER TABLE public.schedules OWNER TO postgres;

--
-- Name: schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schedules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schedules_id_seq OWNER TO postgres;

--
-- Name: schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schedules_id_seq OWNED BY public.schedules.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.services (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying,
    long_description text,
    eligibility character varying,
    required_documents character varying,
    fee character varying,
    application_process text,
    resource_id integer,
    verified_at timestamp without time zone,
    email character varying,
    status integer,
    certified boolean DEFAULT false,
    program_id integer,
    interpretation_services character varying,
    url character varying,
    wait_time character varying,
    contact_id integer,
    funding_id integer,
    alternate_name character varying,
    certified_at timestamp without time zone,
    featured boolean,
    source_attribution integer DEFAULT 0,
    internal_note text,
    short_description character varying
);


ALTER TABLE public.services OWNER TO postgres;

--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.services_id_seq OWNER TO postgres;

--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


--
-- Name: sites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sites (
    id bigint NOT NULL,
    site_code character varying DEFAULT 'sfsg'::character varying
);


ALTER TABLE public.sites OWNER TO postgres;

--
-- Name: sites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sites_id_seq OWNER TO postgres;

--
-- Name: sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sites_id_seq OWNED BY public.sites.id;


--
-- Name: synonym_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.synonym_groups (
    id bigint NOT NULL,
    group_type integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.synonym_groups OWNER TO postgres;

--
-- Name: synonym_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.synonym_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.synonym_groups_id_seq OWNER TO postgres;

--
-- Name: synonym_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.synonym_groups_id_seq OWNED BY public.synonym_groups.id;


--
-- Name: synonyms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.synonyms (
    id bigint NOT NULL,
    word character varying,
    synonym_group_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.synonyms OWNER TO postgres;

--
-- Name: synonyms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.synonyms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.synonyms_id_seq OWNER TO postgres;

--
-- Name: synonyms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.synonyms_id_seq OWNED BY public.synonyms.id;


--
-- Name: texting_recipients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.texting_recipients (
    id bigint NOT NULL,
    recipient_name character varying,
    phone_number character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.texting_recipients OWNER TO postgres;

--
-- Name: texting_recipients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.texting_recipients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.texting_recipients_id_seq OWNER TO postgres;

--
-- Name: texting_recipients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.texting_recipients_id_seq OWNED BY public.texting_recipients.id;


--
-- Name: textings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.textings (
    id bigint NOT NULL,
    texting_recipient_id bigint NOT NULL,
    service_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.textings OWNER TO postgres;

--
-- Name: textings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.textings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.textings_id_seq OWNER TO postgres;

--
-- Name: textings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.textings_id_seq OWNED BY public.textings.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: volunteers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.volunteers (
    id bigint NOT NULL,
    description character varying,
    url character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    resource_id integer
);


ALTER TABLE public.volunteers OWNER TO postgres;

--
-- Name: volunteers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.volunteers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.volunteers_id_seq OWNER TO postgres;

--
-- Name: volunteers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.volunteers_id_seq OWNED BY public.volunteers.id;


--
-- Name: accessibilities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accessibilities ALTER COLUMN id SET DEFAULT nextval('public.accessibilities_id_seq'::regclass);


--
-- Name: addresses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses ALTER COLUMN id SET DEFAULT nextval('public.addresses_id_seq'::regclass);


--
-- Name: admins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins ALTER COLUMN id SET DEFAULT nextval('public.admins_id_seq'::regclass);


--
-- Name: bookmarks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookmarks ALTER COLUMN id SET DEFAULT nextval('public.bookmarks_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: change_requests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.change_requests ALTER COLUMN id SET DEFAULT nextval('public.change_requests_id_seq'::regclass);


--
-- Name: contacts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts ALTER COLUMN id SET DEFAULT nextval('public.contacts_id_seq'::regclass);


--
-- Name: delayed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delayed_jobs ALTER COLUMN id SET DEFAULT nextval('public.delayed_jobs_id_seq'::regclass);


--
-- Name: documents id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents ALTER COLUMN id SET DEFAULT nextval('public.documents_id_seq'::regclass);


--
-- Name: eligibilities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eligibilities ALTER COLUMN id SET DEFAULT nextval('public.eligibilities_id_seq'::regclass);


--
-- Name: feedbacks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedbacks ALTER COLUMN id SET DEFAULT nextval('public.feedbacks_id_seq'::regclass);


--
-- Name: field_changes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.field_changes ALTER COLUMN id SET DEFAULT nextval('public.field_changes_id_seq'::regclass);


--
-- Name: fundings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fundings ALTER COLUMN id SET DEFAULT nextval('public.fundings_id_seq'::regclass);


--
-- Name: instructions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructions ALTER COLUMN id SET DEFAULT nextval('public.instructions_id_seq'::regclass);


--
-- Name: keywords id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keywords ALTER COLUMN id SET DEFAULT nextval('public.keywords_id_seq'::regclass);


--
-- Name: languages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.languages ALTER COLUMN id SET DEFAULT nextval('public.languages_id_seq'::regclass);


--
-- Name: news_articles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_articles ALTER COLUMN id SET DEFAULT nextval('public.news_articles_id_seq'::regclass);


--
-- Name: notes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes ALTER COLUMN id SET DEFAULT nextval('public.notes_id_seq'::regclass);


--
-- Name: phones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phones ALTER COLUMN id SET DEFAULT nextval('public.phones_id_seq'::regclass);


--
-- Name: programs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.programs ALTER COLUMN id SET DEFAULT nextval('public.programs_id_seq'::regclass);


--
-- Name: resources id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources ALTER COLUMN id SET DEFAULT nextval('public.resources_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: schedule_days id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_days ALTER COLUMN id SET DEFAULT nextval('public.schedule_days_id_seq'::regclass);


--
-- Name: schedules id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedules ALTER COLUMN id SET DEFAULT nextval('public.schedules_id_seq'::regclass);


--
-- Name: services id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- Name: sites id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sites ALTER COLUMN id SET DEFAULT nextval('public.sites_id_seq'::regclass);


--
-- Name: synonym_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.synonym_groups ALTER COLUMN id SET DEFAULT nextval('public.synonym_groups_id_seq'::regclass);


--
-- Name: synonyms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.synonyms ALTER COLUMN id SET DEFAULT nextval('public.synonyms_id_seq'::regclass);


--
-- Name: texting_recipients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.texting_recipients ALTER COLUMN id SET DEFAULT nextval('public.texting_recipients_id_seq'::regclass);


--
-- Name: textings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.textings ALTER COLUMN id SET DEFAULT nextval('public.textings_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: volunteers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volunteers ALTER COLUMN id SET DEFAULT nextval('public.volunteers_id_seq'::regclass);


--
-- Data for Name: accessibilities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accessibilities (id, accessibility, details, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.addresses (id, created_at, updated_at, attention, address_1, address_2, address_3, address_4, city, state_province, postal_code, resource_id, latitude, longitude, online, region, name, description, transportation) FROM stdin;
1	2023-08-03 06:32:29.366631	2023-08-03 06:32:29.366631	Gaynelle Tremblay	8478 Collier Creek	Suite 156	\N	\N	East Selma	California	89700-4890	1	37.7823300145316	-122.395343813618	\N	\N	\N	\N	\N
2	2023-08-03 06:32:29.602661	2023-08-03 06:32:29.602661	Frederick Oberbrunner	3366 Durgan Falls	Suite 467	\N	\N	Port Raymonfort	Wisconsin	25437-6698	2	37.7893009384349	-122.39983020913	\N	\N	\N	\N	\N
3	2023-08-03 06:32:29.677857	2023-08-03 06:32:29.677857	Taisha Kuhlman DC	534 Morissette Port	Suite 557	\N	\N	New Juanfort	Delaware	04341-8521	3	37.7893276342793	-122.404055318703	\N	\N	\N	\N	\N
4	2023-08-03 06:32:29.747971	2023-08-03 06:32:29.747971	Spencer Koelpin	49357 Hessel Ranch	Suite 459	\N	\N	West Scott	Kentucky	51485-6069	4	37.7821886533393	-122.408419318768	\N	\N	\N	\N	\N
5	2023-08-03 06:32:29.803139	2023-08-03 06:32:29.803139	Rufus Schneider	36099 Jerde Field	Apt. 713	\N	\N	Framihaven	Nebraska	84357-0846	5	37.7876431123343	-122.39139681911	\N	\N	\N	\N	\N
6	2023-08-03 06:32:29.881426	2023-08-03 06:32:29.881426	Bradley Rau	81562 Eulah Station	Suite 297	\N	\N	Lanellshire	Maine	64072-6780	6	37.7837330397071	-122.399334259938	\N	\N	\N	\N	\N
7	2023-08-03 06:32:29.957728	2023-08-03 06:32:29.957728	Machelle Murazik	85153 Fabian Street	Apt. 953	\N	\N	Langoshton	Wisconsin	24255	7	37.7933313888189	-122.405547921684	\N	\N	\N	\N	\N
8	2023-08-03 06:32:30.034032	2023-08-03 06:32:30.034032	Fr. Noel Mante	188 Waelchi Camp	Apt. 175	\N	\N	Desmondfurt	New Hampshire	57734-7828	8	37.7818642947389	-122.393924311092	\N	\N	\N	\N	\N
9	2023-08-03 06:32:30.102768	2023-08-03 06:32:30.102768	Prof. Shayne Sipes	87712 Werner Garden	Suite 931	\N	\N	Lake Albinaside	Mississippi	05409	9	37.7890870756328	-122.396307159783	\N	\N	\N	\N	\N
10	2023-08-03 06:32:30.142699	2023-08-03 06:32:30.142699	Berry Gislason	4130 Elden Mills	Suite 305	\N	\N	West Soraya	North Carolina	77676-9741	10	37.7900791150433	-122.393203251072	\N	\N	\N	\N	\N
11	2023-08-03 06:32:30.193265	2023-08-03 06:32:30.193265	Annie Hand	96268 Regine Stream	Apt. 450	\N	\N	New Carolfurt	Ohio	61383-2497	11	37.7989770762004	-122.399176849721	\N	\N	\N	\N	\N
12	2023-08-03 06:32:30.269154	2023-08-03 06:32:30.269154	Ola Koepp	5494 Brant Mission	Apt. 444	\N	\N	New Derek	Georgia	53691	12	37.7966973144762	-122.407039500721	\N	\N	\N	\N	\N
13	2023-08-03 06:32:30.330903	2023-08-03 06:32:30.330903	Sharla Cassin	919 Dave Landing	Apt. 311	\N	\N	Karlmouth	Kentucky	91719	13	37.7873597553204	-122.394606095562	\N	\N	\N	\N	\N
14	2023-08-03 06:32:30.401476	2023-08-03 06:32:30.401476	Tom Ward	36843 Balistreri Harbor	Suite 538	\N	\N	Anthonyshire	Wyoming	11518-5933	14	37.7837776292597	-122.39457590346	\N	\N	\N	\N	\N
15	2023-08-03 06:32:30.448109	2023-08-03 06:32:30.448109	Rev. Genna Tillman	592 Florencio Locks	Apt. 321	\N	\N	Littelmouth	West Virginia	71200-2640	15	37.783530154471	-122.40927618372	\N	\N	\N	\N	\N
16	2023-08-03 06:32:30.489094	2023-08-03 06:32:30.489094	Kami Gleichner	70479 Bednar Prairie	Suite 193	\N	\N	Luciusfurt	New Jersey	75997-7993	16	37.7923434798309	-122.391934921066	\N	\N	\N	\N	\N
17	2023-08-03 06:32:30.533987	2023-08-03 06:32:30.533987	Clelia Corwin	27219 Ivey Drives	Suite 184	\N	\N	Boylemouth	West Virginia	65064-3150	17	37.7852507287946	-122.401491697483	\N	\N	\N	\N	\N
18	2023-08-03 06:32:30.60508	2023-08-03 06:32:30.60508	Annabel Marks	385 Gutkowski Parkway	Apt. 486	\N	\N	Grantmouth	Massachusetts	27671-8187	18	37.7879659547734	-122.399337772136	\N	\N	\N	\N	\N
19	2023-08-03 06:32:30.687285	2023-08-03 06:32:30.687285	Fr. Cameron Shanahan	634 Angie Trafficway	Suite 679	\N	\N	Auermouth	Virginia	46818	19	37.7913236082294	-122.399093019855	\N	\N	\N	\N	\N
20	2023-08-03 06:32:30.732073	2023-08-03 06:32:30.732073	Rashida Bernier	93484 Emeline Parkways	Apt. 215	\N	\N	South Sammy	Arkansas	82693-4567	20	37.7989558714121	-122.406278689609	\N	\N	\N	\N	\N
21	2023-08-03 06:32:30.799868	2023-08-03 06:32:30.799868	Maye Heidenreich	93967 Annetta Fork	Suite 257	\N	\N	West Karyn	Connecticut	91121-3871	21	37.7905890901955	-122.396768075618	\N	\N	\N	\N	\N
22	2023-08-03 06:32:30.841068	2023-08-03 06:32:30.841068	Jackie Hand	6611 Rohan Ranch	Suite 397	\N	\N	Lake Lynnmouth	Georgia	10521-1001	22	37.7975207156373	-122.393635539757	\N	\N	\N	\N	\N
23	2023-08-03 06:32:30.908949	2023-08-03 06:32:30.908949	Vernita Reynolds Jr.	2911 Dicki Via	Apt. 121	\N	\N	Kulasshire	Indiana	47547	23	37.7910635351565	-122.398760787837	\N	\N	\N	\N	\N
24	2023-08-03 06:32:30.98152	2023-08-03 06:32:30.98152	Heike Champlin	3065 Curtis Pass	Apt. 568	\N	\N	Cartershire	Nebraska	52589-0265	24	37.7880266766589	-122.397359520121	\N	\N	\N	\N	\N
25	2023-08-03 06:32:31.054949	2023-08-03 06:32:31.054949	Donella McDermott	8131 Dietrich Hill	Suite 866	\N	\N	East Louannetown	Iowa	84210	25	37.7975699778882	-122.393573996365	\N	\N	\N	\N	\N
26	2023-08-03 06:32:31.106857	2023-08-03 06:32:31.106857	Kira Lockman	8093 Bergnaum Meadows	Suite 706	\N	\N	New Raneefurt	Nevada	52780	26	37.7810673550853	-122.402200476452	\N	\N	\N	\N	\N
27	2023-08-03 06:32:31.157681	2023-08-03 06:32:31.157681	Jolyn Armstrong	885 Fisher Trace	Apt. 344	\N	\N	D'Amoreberg	Washington	98792-7000	27	37.782085903635	-122.396335007187	\N	\N	\N	\N	\N
28	2023-08-03 06:32:31.2108	2023-08-03 06:32:31.2108	Gov. Myron Heller	4683 Antonia Stravenue	Suite 836	\N	\N	Larsonland	Montana	81582	28	37.7870283116106	-122.407708428641	\N	\N	\N	\N	\N
29	2023-08-03 06:32:31.258032	2023-08-03 06:32:31.258032	Ashly Hermann	70994 Harris Motorway	Apt. 471	\N	\N	East Jarrod	Washington	43187-9004	29	37.7850616473966	-122.398498314744	\N	\N	\N	\N	\N
30	2023-08-03 06:32:31.304643	2023-08-03 06:32:31.304643	Sage McLaughlin	63101 Merilyn Via	Apt. 203	\N	\N	Julianmouth	New Mexico	60035-6719	30	37.7927773653466	-122.396360500546	\N	\N	\N	\N	\N
31	2023-08-03 06:32:31.349043	2023-08-03 06:32:31.349043	Sen. Dania Yundt	887 Bruno Key	Suite 899	\N	\N	West Chara	Washington	74201-4460	31	37.79017329729	-122.408363823035	\N	\N	\N	\N	\N
32	2023-08-03 06:32:31.42143	2023-08-03 06:32:31.42143	Jewell Bogisich	778 Eda Point	Apt. 781	\N	\N	West Rosetteport	West Virginia	45057	32	37.7955894626007	-122.40166811084	\N	\N	\N	\N	\N
33	2023-08-03 06:32:31.467504	2023-08-03 06:32:31.467504	Rep. Jerrie Wolf	102 Frederica Light	Apt. 515	\N	\N	Bradfordhaven	New Hampshire	09602	33	37.788686063229	-122.40310573348	\N	\N	\N	\N	\N
34	2023-08-03 06:32:31.514344	2023-08-03 06:32:31.514344	Cornell Ledner	4858 Sanford Gateway	Suite 402	\N	\N	West Emiliohaven	Ohio	52203	34	37.7894819398539	-122.403728481002	\N	\N	\N	\N	\N
35	2023-08-03 06:32:31.584365	2023-08-03 06:32:31.584365	Germaine Weissnat	88985 Trinidad Islands	Apt. 392	\N	\N	Jeromyfort	Idaho	89395	35	37.7845641923222	-122.401630162141	\N	\N	\N	\N	\N
36	2023-08-03 06:32:31.635135	2023-08-03 06:32:31.635135	Deeann Doyle	484 Gleichner Trail	Apt. 536	\N	\N	Marvelfort	California	24329	36	37.7901319272498	-122.409694665518	\N	\N	\N	\N	\N
37	2023-08-03 06:32:31.686196	2023-08-03 06:32:31.686196	Emilio Leuschke	9042 Domingo Village	Suite 333	\N	\N	East Sarai	New Jersey	54333	37	37.7983666544814	-122.391164738434	\N	\N	\N	\N	\N
38	2023-08-03 06:32:31.730706	2023-08-03 06:32:31.730706	Alonso Hansen	3159 Victor Mews	Suite 952	\N	\N	West Cristal	Hawaii	20577-0202	38	37.7931459704647	-122.407549428666	\N	\N	\N	\N	\N
39	2023-08-03 06:32:31.781934	2023-08-03 06:32:31.781934	Palmer Hills	1924 Mann Street	Suite 422	\N	\N	Delphineton	Kansas	56031-3696	39	37.7990255937532	-122.395298319351	\N	\N	\N	\N	\N
40	2023-08-03 06:32:31.832183	2023-08-03 06:32:31.832183	Venus McKenzie	828 Carrol Ramp	Apt. 388	\N	\N	East Teraberg	Alabama	04829-7256	40	37.7923231359545	-122.397747090519	\N	\N	\N	\N	\N
41	2023-08-03 06:32:31.883505	2023-08-03 06:32:31.883505	Delcie Simonis	339 Digna Place	Apt. 496	\N	\N	Kimberliport	Maine	58057-3179	41	37.7899655590469	-122.403006364458	\N	\N	\N	\N	\N
42	2023-08-03 06:32:31.931356	2023-08-03 06:32:31.931356	Eugene Schamberger	1287 Antoine Ports	Apt. 505	\N	\N	New Newton	Minnesota	80680-4229	42	37.7998553926036	-122.402249682435	\N	\N	\N	\N	\N
43	2023-08-03 06:32:32.005021	2023-08-03 06:32:32.005021	Lisabeth Baumbach	571 Deonna Tunnel	Apt. 198	\N	\N	Martinfurt	Louisiana	13930-9286	43	37.7827636343142	-122.392844971215	\N	\N	\N	\N	\N
44	2023-08-03 06:32:32.046869	2023-08-03 06:32:32.046869	Dia Wehner	65994 Torp Ramp	Suite 325	\N	\N	Prosaccoshire	Alaska	13329	44	37.7887553065862	-122.400738408249	\N	\N	\N	\N	\N
45	2023-08-03 06:32:32.097427	2023-08-03 06:32:32.097427	Britni Rempel V	8581 Norbert Mews	Apt. 727	\N	\N	North Elvin	South Dakota	07161-6039	45	37.786952794795	-122.403244598688	\N	\N	\N	\N	\N
46	2023-08-03 06:32:32.163928	2023-08-03 06:32:32.163928	Sen. Bryanna Kuhn	9654 Prince Drives	Suite 311	\N	\N	Hungtown	Nebraska	13632-7277	46	37.7858157037812	-122.403217570098	\N	\N	\N	\N	\N
47	2023-08-03 06:32:32.210378	2023-08-03 06:32:32.210378	Beatris Dibbert	944 Hahn Bypass	Apt. 313	\N	\N	South Jannetbury	Oregon	80197	47	37.780126367668	-122.407860600746	\N	\N	\N	\N	\N
48	2023-08-03 06:32:32.283444	2023-08-03 06:32:32.283444	Mr. Scotty Nader	5598 Jamal Isle	Suite 633	\N	\N	Ashleyburgh	Florida	18002-9769	48	37.789789304633	-122.407664035499	\N	\N	\N	\N	\N
49	2023-08-03 06:32:32.328448	2023-08-03 06:32:32.328448	Jina Ruecker	8790 Vincent Trace	Suite 905	\N	\N	Port Jesus	Maine	38690-0409	49	37.799254093582	-122.391620414041	\N	\N	\N	\N	\N
50	2023-08-03 06:32:32.377463	2023-08-03 06:32:32.377463	Gov. Omer Adams	4640 Nada Creek	Apt. 333	\N	\N	East Jasonville	Delaware	15988	50	37.7958399874593	-122.399537087835	\N	\N	\N	\N	\N
51	2023-08-03 06:32:32.42883	2023-08-03 06:32:32.42883	Zulema Spinka	26653 Vanita Forest	Suite 868	\N	\N	Lake Vincetown	Hawaii	10658	51	37.791951975594	-122.40537987003	\N	\N	\N	\N	\N
52	2023-08-03 06:32:32.506034	2023-08-03 06:32:32.506034	Lisa Bartell	64253 Arianna Vista	Apt. 656	\N	\N	Mortonburgh	Maine	90522-6177	52	37.7976947034318	-122.400106509445	\N	\N	\N	\N	\N
53	2023-08-03 06:32:32.578302	2023-08-03 06:32:32.578302	Rev. Zora Gorczany	83149 Rippin Ford	Suite 684	\N	\N	Naderport	Indiana	31414	53	37.7989835600509	-122.396458010144	\N	\N	\N	\N	\N
54	2023-08-03 06:32:32.648288	2023-08-03 06:32:32.648288	Gregg Pfeffer	2926 Predovic Mills	Suite 550	\N	\N	Susannahbury	South Dakota	79226-9182	54	37.7916183743989	-122.403292849606	\N	\N	\N	\N	\N
55	2023-08-03 06:32:32.694191	2023-08-03 06:32:32.694191	Krystin Jast	75483 Geri Wall	Suite 746	\N	\N	North Antonioborough	Louisiana	78983-3145	55	37.7991239752341	-122.402483666301	\N	\N	\N	\N	\N
56	2023-08-03 06:32:32.76796	2023-08-03 06:32:32.76796	Thanh Orn	9147 Mei Cape	Apt. 783	\N	\N	Port Doyleport	Washington	78301	56	37.7833473986177	-122.392116770197	\N	\N	\N	\N	\N
57	2023-08-03 06:32:32.849034	2023-08-03 06:32:32.849034	Raye Torp	8842 Bert Junction	Apt. 617	\N	\N	Aufderharfurt	Maine	84891	57	37.7816424368338	-122.397775847418	\N	\N	\N	\N	\N
58	2023-08-03 06:32:32.900438	2023-08-03 06:32:32.900438	Laurie Ernser DO	129 Loraine Cliff	Apt. 749	\N	\N	West Frank	Alabama	36090-7048	58	37.7963002892852	-122.407153889556	\N	\N	\N	\N	\N
59	2023-08-03 06:32:32.971044	2023-08-03 06:32:32.971044	Scottie Mayer IV	13953 Fadel Burgs	Apt. 744	\N	\N	Port Erwin	Delaware	79383	59	37.7859759116254	-122.400350768526	\N	\N	\N	\N	\N
60	2023-08-03 06:32:33.035014	2023-08-03 06:32:33.035014	Anjelica Lind V	5061 Ryan Cliffs	Suite 889	\N	\N	McClureton	West Virginia	87960	60	37.7851120124249	-122.398599478273	\N	\N	\N	\N	\N
61	2023-08-03 06:32:33.102367	2023-08-03 06:32:33.102367	Sen. Raymond Kunze	3128 Hamill Mountain	Suite 904	\N	\N	Port Jimmie	Idaho	32161	61	37.7995525370098	-122.396385877044	\N	\N	\N	\N	\N
62	2023-08-03 06:32:33.188522	2023-08-03 06:32:33.188522	Newton Hudson	3406 Toy Knolls	Apt. 848	\N	\N	West Lacyfurt	Wyoming	60069-7629	62	37.7912452293525	-122.408891688717	\N	\N	\N	\N	\N
63	2023-08-03 06:32:33.270742	2023-08-03 06:32:33.270742	Malcom Stroman Ret.	313 Jacobi Trail	Suite 277	\N	\N	Langland	Indiana	61609	63	37.7966635750068	-122.408780122909	\N	\N	\N	\N	\N
64	2023-08-03 06:32:33.316643	2023-08-03 06:32:33.316643	Warner Mayert	7613 Jestine River	Suite 154	\N	\N	North Soonton	Kentucky	64721	64	37.7879741001006	-122.408670923346	\N	\N	\N	\N	\N
65	2023-08-03 06:32:33.386895	2023-08-03 06:32:33.386895	Sheldon Terry	614 Kittie Ports	Apt. 852	\N	\N	New Vanside	Mississippi	57170	65	37.7977938860809	-122.402119413601	\N	\N	\N	\N	\N
66	2023-08-03 06:32:33.462712	2023-08-03 06:32:33.462712	Daren Pfannerstill	15233 Clare Rest	Suite 141	\N	\N	West Tommymouth	Indiana	47893	66	37.7910129852257	-122.408738722643	\N	\N	\N	\N	\N
67	2023-08-03 06:32:33.519302	2023-08-03 06:32:33.519302	Sana Jaskolski	2678 Cummerata Square	Suite 230	\N	\N	Brittaneyshire	Oregon	28520-1286	67	37.7808094993394	-122.390249748299	\N	\N	\N	\N	\N
68	2023-08-03 06:32:33.57111	2023-08-03 06:32:33.57111	Emilio Jones MD	1342 Mariano Avenue	Apt. 251	\N	\N	Nienowborough	Kentucky	40631-3703	68	37.7809502403778	-122.40534837918	\N	\N	\N	\N	\N
69	2023-08-03 06:32:33.648009	2023-08-03 06:32:33.648009	Brad Watsica	4976 Nigel Walk	Apt. 372	\N	\N	Port Miyokohaven	Hawaii	71674-1809	69	37.7854148731564	-122.406948138492	\N	\N	\N	\N	\N
70	2023-08-03 06:32:33.701682	2023-08-03 06:32:33.701682	Julio Rolfson	5600 Jayson Knolls	Suite 437	\N	\N	Jarredhaven	Ohio	86504-5011	70	37.7888372387408	-122.408071102544	\N	\N	\N	\N	\N
71	2023-08-03 06:32:33.778306	2023-08-03 06:32:33.778306	Kazuko Lehner	9081 Grady Park	Apt. 560	\N	\N	Mannfurt	Virginia	04874	71	37.7919269336223	-122.404641237835	\N	\N	\N	\N	\N
72	2023-08-03 06:32:33.85553	2023-08-03 06:32:33.85553	Nakesha Ruecker	24735 Parisian Bypass	Suite 775	\N	\N	New Boris	Pennsylvania	11562	72	37.7886612744464	-122.409165098663	\N	\N	\N	\N	\N
73	2023-08-03 06:32:33.905389	2023-08-03 06:32:33.905389	Meryl Aufderhar	5872 Schneider Pine	Apt. 284	\N	\N	Galenmouth	California	70276-0364	73	37.7832357964014	-122.404594033142	\N	\N	\N	\N	\N
74	2023-08-03 06:32:33.985877	2023-08-03 06:32:33.985877	Shonna Altenwerth	710 Block Fords	Apt. 900	\N	\N	South Darius	Montana	51839	74	37.7836994000254	-122.393521658696	\N	\N	\N	\N	\N
75	2023-08-03 06:32:34.063373	2023-08-03 06:32:34.063373	Duncan Boyer	349 Ruby Inlet	Suite 977	\N	\N	Haneton	South Carolina	46321-4804	75	37.7820429283642	-122.392398839158	\N	\N	\N	\N	\N
76	2023-08-03 06:32:34.139473	2023-08-03 06:32:34.139473	Deangelo Morissette	4940 Jerry Run	Apt. 386	\N	\N	Schultzland	Mississippi	88125-1227	76	37.7969733806785	-122.392173426266	\N	\N	\N	\N	\N
77	2023-08-03 06:32:34.192498	2023-08-03 06:32:34.192498	Harrison Stark	71182 Rolfson Tunnel	Apt. 940	\N	\N	Stiedemannbury	Alaska	35878-9593	77	37.7986810763797	-122.39546337323	\N	\N	\N	\N	\N
78	2023-08-03 06:32:34.246395	2023-08-03 06:32:34.246395	Dr. Sharee Shields	738 Clifford Landing	Suite 467	\N	\N	Rohanside	New Mexico	83183	78	37.783168939617	-122.391725568137	\N	\N	\N	\N	\N
79	2023-08-03 06:32:34.324255	2023-08-03 06:32:34.324255	Cole Corwin	2708 Mandie Tunnel	Suite 199	\N	\N	Port Edisonmouth	Colorado	41721	79	37.7897593759886	-122.403187888976	\N	\N	\N	\N	\N
80	2023-08-03 06:32:34.402647	2023-08-03 06:32:34.402647	Damian Reichel	6075 Tyesha Cliff	Apt. 222	\N	\N	New Lieselotteville	Texas	91135	80	37.7871609461646	-122.406854004896	\N	\N	\N	\N	\N
81	2023-08-03 06:32:34.473546	2023-08-03 06:32:34.473546	Deane Davis	96529 Hayden Hills	Apt. 760	\N	\N	Bruenstad	Alaska	72192	81	37.7950856906448	-122.392197037421	\N	\N	\N	\N	\N
82	2023-08-03 06:32:34.524869	2023-08-03 06:32:34.524869	Jere Von	19635 Dickinson Harbors	Suite 297	\N	\N	Vonmouth	Alabama	20865	82	37.7924164312948	-122.404350077378	\N	\N	\N	\N	\N
83	2023-08-03 06:32:34.603658	2023-08-03 06:32:34.603658	Cary Hauck VM	498 Elbert Ramp	Apt. 441	\N	\N	Thurmanberg	Arkansas	37343	83	37.7891295071505	-122.400281831212	\N	\N	\N	\N	\N
84	2023-08-03 06:32:34.65099	2023-08-03 06:32:34.65099	Darrick Schmidt	104 Rodriguez Branch	Apt. 166	\N	\N	West Jeremy	South Dakota	53511-5661	84	37.7907054244022	-122.408546368864	\N	\N	\N	\N	\N
85	2023-08-03 06:32:34.710736	2023-08-03 06:32:34.710736	Pres. Benedict Blick	928 Marcelino Haven	Apt. 378	\N	\N	West Bernardville	Iowa	66653	85	37.7977693267674	-122.390665102187	\N	\N	\N	\N	\N
86	2023-08-03 06:32:34.768399	2023-08-03 06:32:34.768399	Darren Gutmann DO	1108 Schumm Greens	Apt. 199	\N	\N	East Verlieburgh	Illinois	19423-5770	86	37.7861980332783	-122.396904219593	\N	\N	\N	\N	\N
87	2023-08-03 06:32:34.843318	2023-08-03 06:32:34.843318	Honey Goldner	9409 Kirk Trail	Suite 835	\N	\N	Dellafurt	New York	37145-5501	87	37.7929541802604	-122.405013446034	\N	\N	\N	\N	\N
88	2023-08-03 06:32:34.914162	2023-08-03 06:32:34.914162	The Hon. Corey O'Connell	58411 Jefferson Pike	Apt. 936	\N	\N	Eusebiachester	Wisconsin	56803-2039	88	37.7960214745546	-122.408053386305	\N	\N	\N	\N	\N
89	2023-08-03 06:32:35.052484	2023-08-03 06:32:35.052484	Msgr. Matilde Nienow	41939 Harvey Loaf	Suite 167	\N	\N	North Jeanna	New Jersey	18962	89	37.7824431990492	-122.407315808241	\N	\N	\N	\N	\N
90	2023-08-03 06:32:35.10236	2023-08-03 06:32:35.10236	Rashida Mosciski	7648 Ritchie Road	Apt. 351	\N	\N	New Benito	Wisconsin	61336-4094	90	37.7885485659121	-122.405754873795	\N	\N	\N	\N	\N
91	2023-08-03 06:32:35.177573	2023-08-03 06:32:35.177573	Debera Nienow	996 Luise Corners	Apt. 445	\N	\N	Esthertown	Minnesota	13466	91	37.7965984089113	-122.390141104563	\N	\N	\N	\N	\N
92	2023-08-03 06:32:35.274104	2023-08-03 06:32:35.274104	Lino Reilly	5387 Pei Walks	Apt. 508	\N	\N	Quincystad	California	94612-5072	92	37.7984478101334	-122.409539288084	\N	\N	\N	\N	\N
93	2023-08-03 06:32:35.343679	2023-08-03 06:32:35.343679	Brigette Rutherford	88691 Helena Falls	Apt. 329	\N	\N	South Mario	Arkansas	56558	93	37.7837727079021	-122.391759044322	\N	\N	\N	\N	\N
94	2023-08-03 06:32:35.423595	2023-08-03 06:32:35.423595	Msgr. Dwight Jacobson	86452 Dylan Club	Suite 115	\N	\N	Ikeburgh	Iowa	33147	94	37.7841833011546	-122.396721592444	\N	\N	\N	\N	\N
95	2023-08-03 06:32:35.525719	2023-08-03 06:32:35.525719	Jerry Stanton	6837 Pansy Avenue	Suite 734	\N	\N	Hodkiewiczfurt	Illinois	15847	95	37.7906748878095	-122.404154410052	\N	\N	\N	\N	\N
96	2023-08-03 06:32:35.57677	2023-08-03 06:32:35.57677	Msgr. Riva O'Keefe	676 Juliann Camp	Apt. 593	\N	\N	Raefurt	Florida	22982	96	37.7880324608778	-122.398533741805	\N	\N	\N	\N	\N
97	2023-08-03 06:32:35.623738	2023-08-03 06:32:35.623738	Rev. Sally Adams	30125 Emmerich Fields	Apt. 186	\N	\N	Port Alanville	Hawaii	47652	97	37.7850840785033	-122.390115627429	\N	\N	\N	\N	\N
98	2023-08-03 06:32:35.71371	2023-08-03 06:32:35.71371	Carolee Bogan IV	209 Pansy Lodge	Apt. 279	\N	\N	North Lawrence	Florida	60763-9171	98	37.7931991222105	-122.409343419477	\N	\N	\N	\N	\N
99	2023-08-03 06:32:35.762898	2023-08-03 06:32:35.762898	Vernon Gutmann II	47398 Marquardt Squares	Apt. 446	\N	\N	Port Wan	Maryland	81625	99	37.7866718270698	-122.399108392238	\N	\N	\N	\N	\N
100	2023-08-03 06:32:35.833609	2023-08-03 06:32:35.833609	Chasity Toy	441 Napoleon Course	Suite 595	\N	\N	East Latashiamouth	Georgia	86761-4588	100	37.7913971536128	-122.393023821503	\N	\N	\N	\N	\N
101	2023-08-03 06:32:35.887322	2023-08-03 06:32:35.887322	Earline Waters	566 Remedios Gardens	Suite 161	\N	\N	South Antonialand	Oregon	46813	101	37.7804126239337	-122.408239184205	\N	\N	\N	\N	\N
102	2023-08-03 06:32:35.930462	2023-08-03 06:32:35.930462	Pinkie Stark	455 Wehner Skyway	Apt. 692	\N	\N	Vandervortfurt	Louisiana	93787-9217	102	37.7802804108289	-122.40841649859	\N	\N	\N	\N	\N
103	2023-08-03 06:32:36.002944	2023-08-03 06:32:36.002944	Amb. Donnetta Schaefer	8335 Satterfield Vista	Apt. 531	\N	\N	New Danaview	Arkansas	64029-3460	103	37.7936189863766	-122.403918960607	\N	\N	\N	\N	\N
104	2023-08-03 06:32:36.053725	2023-08-03 06:32:36.053725	Leon Bayer	52160 Myles Forest	Apt. 484	\N	\N	Sebastianville	Louisiana	06704-9633	104	37.7845816635512	-122.395197642996	\N	\N	\N	\N	\N
105	2023-08-03 06:32:36.10107	2023-08-03 06:32:36.10107	Chae Rempel	539 Connelly Motorway	Apt. 113	\N	\N	Harberside	South Dakota	62783	105	37.7911935358399	-122.40816947994	\N	\N	\N	\N	\N
106	2023-08-03 06:32:36.172833	2023-08-03 06:32:36.172833	Marth Blanda	216 Benny Ford	Suite 512	\N	\N	West Deeport	Nebraska	28956-2465	106	37.7891438823982	-122.395465733861	\N	\N	\N	\N	\N
107	2023-08-03 06:32:36.217077	2023-08-03 06:32:36.217077	Ms. Toby Runolfsdottir	615 Monahan Stravenue	Suite 380	\N	\N	West Lidafort	Michigan	60827-3842	107	37.7982048447826	-122.398478249496	\N	\N	\N	\N	\N
108	2023-08-03 06:32:36.26803	2023-08-03 06:32:36.26803	Luciana West	5215 McClure Shore	Suite 579	\N	\N	Port Blanch	Wyoming	13721	108	37.7806880936975	-122.398810592129	\N	\N	\N	\N	\N
109	2023-08-03 06:32:36.31544	2023-08-03 06:32:36.31544	Marcelene Langworth	750 Greenholt Squares	Suite 550	\N	\N	South Chetport	Georgia	58962-4800	109	37.7863519984102	-122.398085299863	\N	\N	\N	\N	\N
110	2023-08-03 06:32:36.364207	2023-08-03 06:32:36.364207	Amb. Benito Reilly	640 Rodney Mount	Suite 872	\N	\N	Lake Devorahside	Michigan	48352	110	37.7824540893132	-122.398118560001	\N	\N	\N	\N	\N
111	2023-08-03 06:32:36.430458	2023-08-03 06:32:36.430458	Yong Murphy	5630 Leffler Stream	Apt. 592	\N	\N	West Dot	Kansas	55179	111	37.7892265299355	-122.409201251635	\N	\N	\N	\N	\N
112	2023-08-03 06:32:36.478399	2023-08-03 06:32:36.478399	Mckenzie Ferry	6669 Gregg Turnpike	Suite 362	\N	\N	Doyleton	Louisiana	11400	112	37.7934912943524	-122.402500104518	\N	\N	\N	\N	\N
113	2023-08-03 06:32:36.595375	2023-08-03 06:32:36.595375	Houston Kassulke	23256 Sipes Court	Suite 509	\N	\N	South Marcelofurt	Indiana	46572-2044	113	37.794073651436	-122.40263367075	\N	\N	\N	\N	\N
114	2023-08-03 06:32:36.65322	2023-08-03 06:32:36.65322	Mr. Kennith Fritsch	5516 Purdy Extension	Apt. 920	\N	\N	Eddamouth	South Carolina	15231-4405	114	37.7826080134746	-122.396118738179	\N	\N	\N	\N	\N
115	2023-08-03 06:32:36.703589	2023-08-03 06:32:36.703589	Fr. Andrew Jakubowski	203 Rene Knolls	Apt. 864	\N	\N	Lake Sanfordberg	Wisconsin	14292	115	37.7927148470455	-122.393213600755	\N	\N	\N	\N	\N
116	2023-08-03 06:32:36.765732	2023-08-03 06:32:36.765732	Noel Fadel	570 Gayle Throughway	Apt. 494	\N	\N	Jarrodmouth	Missouri	40049	116	37.7943981992934	-122.408749511937	\N	\N	\N	\N	\N
117	2023-08-03 06:32:36.824612	2023-08-03 06:32:36.824612	Erwin Brown DC	9853 Zula Junction	Suite 131	\N	\N	Lake Dongstad	Maryland	16963	117	37.7886742207476	-122.399967053662	\N	\N	\N	\N	\N
118	2023-08-03 06:32:36.877801	2023-08-03 06:32:36.877801	Maris Carroll DVM	76641 Fritsch Street	Suite 264	\N	\N	Kreigerhaven	Maine	72379	118	37.7932985649117	-122.390972299304	\N	\N	\N	\N	\N
119	2023-08-03 06:32:36.93414	2023-08-03 06:32:36.93414	Tonita Bechtelar	6503 Boyle Cliff	Apt. 881	\N	\N	Port Linneaton	Mississippi	67382-2645	119	37.7952695056531	-122.39713655223	\N	\N	\N	\N	\N
120	2023-08-03 06:32:36.991584	2023-08-03 06:32:36.991584	Fermin Mueller	7851 Kreiger Corners	Apt. 763	\N	\N	North Zenia	Indiana	95340-5728	120	37.7829973352226	-122.398208669541	\N	\N	\N	\N	\N
121	2023-08-03 06:32:37.050773	2023-08-03 06:32:37.050773	Rickie O'Keefe DO	900 Johnson Locks	Suite 969	\N	\N	Port Tianna	Arizona	18319-5075	121	37.7904845340539	-122.402343495142	\N	\N	\N	\N	\N
122	2023-08-03 06:32:37.146094	2023-08-03 06:32:37.146094	Thea Cole	135 Hodkiewicz Plain	Apt. 224	\N	\N	Naderchester	Colorado	28945-2377	122	37.7849150022935	-122.401657532507	\N	\N	\N	\N	\N
123	2023-08-03 06:32:37.240526	2023-08-03 06:32:37.240526	Cheyenne Christiansen	61509 Farrell Crescent	Suite 475	\N	\N	West Scott	Idaho	66038	123	37.7848267677364	-122.399755862084	\N	\N	\N	\N	\N
124	2023-08-03 06:32:37.31964	2023-08-03 06:32:37.31964	Cory McCullough	81912 Raina Drives	Apt. 229	\N	\N	Torphytown	Wyoming	99057-7378	124	37.7903507831342	-122.397962993449	\N	\N	\N	\N	\N
125	2023-08-03 06:32:37.393768	2023-08-03 06:32:37.393768	Aleta Corwin	305 Carter Track	Apt. 473	\N	\N	New Orlandoville	Louisiana	72690-9667	125	37.7814553636428	-122.393489015967	\N	\N	\N	\N	\N
126	2023-08-03 06:32:37.442645	2023-08-03 06:32:37.442645	Jeanice Effertz	94840 Harvey Streets	Apt. 849	\N	\N	Baumbachside	Kansas	52322-6574	126	37.7986724541945	-122.398229587764	\N	\N	\N	\N	\N
127	2023-08-03 06:32:37.493789	2023-08-03 06:32:37.493789	Garnet Mraz	8650 Kling Common	Apt. 610	\N	\N	Port Jameshire	Maine	40167-9357	127	37.7946675698504	-122.40867535494	\N	\N	\N	\N	\N
128	2023-08-03 06:32:37.541517	2023-08-03 06:32:37.541517	Joleen Rodriguez CPA	27274 Catarina Forge	Suite 679	\N	\N	Lake Olivermouth	Maine	52983	128	37.7900511762101	-122.409549525662	\N	\N	\N	\N	\N
129	2023-08-03 06:32:37.591243	2023-08-03 06:32:37.591243	Gov. Dayle Hettinger	46423 Reichert Forest	Suite 178	\N	\N	Omershire	Utah	61486	129	37.782820081857	-122.402957884569	\N	\N	\N	\N	\N
130	2023-08-03 06:32:37.670749	2023-08-03 06:32:37.670749	Glenn Will	5961 Emilie Village	Apt. 644	\N	\N	Mertzberg	Rhode Island	20381-9693	130	37.7959823963879	-122.396948618247	\N	\N	\N	\N	\N
131	2023-08-03 06:32:37.718112	2023-08-03 06:32:37.718112	Nikia Hansen	877 Deena Circle	Apt. 844	\N	\N	Lubowitzbury	Ohio	33964	131	37.7989834165807	-122.406433198833	\N	\N	\N	\N	\N
132	2023-08-03 06:32:37.761942	2023-08-03 06:32:37.761942	Lawrence Morar	4157 Clement Crescent	Suite 516	\N	\N	Craigbury	Wisconsin	80672	132	37.7937393819007	-122.392037449062	\N	\N	\N	\N	\N
133	2023-08-03 06:32:37.813376	2023-08-03 06:32:37.813376	Andreas Hauck	208 Micheal Ridge	Apt. 194	\N	\N	Port Olive	Rhode Island	53257	133	37.799289212322	-122.397263642667	\N	\N	\N	\N	\N
134	2023-08-03 06:32:37.881064	2023-08-03 06:32:37.881064	Taina Von II	382 Sauer Terrace	Suite 424	\N	\N	Catheymouth	Georgia	33516-4742	134	37.7901947147797	-122.408771503889	\N	\N	\N	\N	\N
135	2023-08-03 06:32:37.94838	2023-08-03 06:32:37.94838	Jimmie Lindgren	6031 Kirlin Garden	Apt. 138	\N	\N	East Scotty	North Dakota	01297	135	37.7974205337335	-122.405541379687	\N	\N	\N	\N	\N
136	2023-08-03 06:32:37.998825	2023-08-03 06:32:37.998825	Ellsworth Harris II	147 Kihn Glen	Suite 450	\N	\N	North Kiersten	South Dakota	24379-5905	136	37.7980950232815	-122.392926140897	\N	\N	\N	\N	\N
137	2023-08-03 06:32:38.052289	2023-08-03 06:32:38.052289	Jimmie Hermann	8130 Harley Grove	Apt. 542	\N	\N	Lannystad	Ohio	04296	137	37.7816489490677	-122.394934985221	\N	\N	\N	\N	\N
138	2023-08-03 06:32:38.167803	2023-08-03 06:32:38.167803	Fabian Skiles IV	8977 Grady Trail	Apt. 908	\N	\N	Yukville	Minnesota	61926	138	37.7909979170156	-122.396818144124	\N	\N	\N	\N	\N
139	2023-08-03 06:32:38.245521	2023-08-03 06:32:38.245521	Zoe Hackett Ret.	3914 Catalina Glens	Suite 603	\N	\N	North Elva	Arizona	32045	139	37.7928906042041	-122.392336657877	\N	\N	\N	\N	\N
140	2023-08-03 06:32:38.327818	2023-08-03 06:32:38.327818	Valentine Will	613 Micheal Harbors	Suite 102	\N	\N	South Preston	West Virginia	71478	140	37.7881970738168	-122.399137446418	\N	\N	\N	\N	\N
141	2023-08-03 06:32:38.379092	2023-08-03 06:32:38.379092	Palmer Price	12671 Dion Ford	Suite 177	\N	\N	Barttown	Tennessee	45670-4434	141	37.797630249455	-122.405762189103	\N	\N	\N	\N	\N
142	2023-08-03 06:32:38.426063	2023-08-03 06:32:38.426063	Marlo Bergnaum	4062 Beer Radial	Suite 408	\N	\N	New Antonia	Alabama	04992	142	37.7800010788081	-122.394532103707	\N	\N	\N	\N	\N
143	2023-08-03 06:32:38.504663	2023-08-03 06:32:38.504663	Ismael Ritchie	23129 Eddie Plaza	Apt. 961	\N	\N	Alexanderhaven	Arizona	04578	143	37.793759080134	-122.392543102879	\N	\N	\N	\N	\N
144	2023-08-03 06:32:38.55439	2023-08-03 06:32:38.55439	Luz Rempel	675 Hermiston Shoals	Suite 374	\N	\N	West Shoshana	Ohio	82537	144	37.7974952130057	-122.404865209064	\N	\N	\N	\N	\N
145	2023-08-03 06:32:38.605567	2023-08-03 06:32:38.605567	Laila Baumbach	6065 Jerry Drive	Apt. 825	\N	\N	Port Tom	Mississippi	86060-8627	145	37.7959069240297	-122.401035332796	\N	\N	\N	\N	\N
146	2023-08-03 06:32:38.656936	2023-08-03 06:32:38.656936	Rose Rolfson	6719 Tillman Valley	Suite 688	\N	\N	Jacksonmouth	Wisconsin	75915-1905	146	37.7834487604358	-122.398221496027	\N	\N	\N	\N	\N
147	2023-08-03 06:32:38.731633	2023-08-03 06:32:38.731633	Ms. Gaston Kirlin	10064 Dino Ville	Apt. 266	\N	\N	Scottshire	Indiana	42844-8400	147	37.7935391624622	-122.399956624602	\N	\N	\N	\N	\N
148	2023-08-03 06:32:38.80022	2023-08-03 06:32:38.80022	Kenneth Reynolds	4594 Alaine Rapids	Apt. 469	\N	\N	McLaughlinshire	Alabama	79782-0760	148	37.7841319574266	-122.393505133915	\N	\N	\N	\N	\N
149	2023-08-03 06:32:38.851808	2023-08-03 06:32:38.851808	Dr. Oscar Monahan	77548 Judi Cliffs	Suite 721	\N	\N	Schambergerview	Michigan	86886	149	37.7805895494919	-122.39521292325	\N	\N	\N	\N	\N
150	2023-08-03 06:32:39.492304	2023-08-03 06:32:39.492304	Virgilio Towne III	17404 Feeney Plains	Suite 903	\N	\N	West Julesmouth	Connecticut	69424-3161	150	37.7855375998063	-122.408440696758	\N	\N	\N	\N	\N
151	2023-08-03 06:32:39.532124	2023-08-03 06:32:39.532124	Aurelio Batz PhD	64247 Tuan Unions	Suite 819	\N	\N	East Kaneshamouth	New Jersey	86333	151	37.7879718459922	-122.393262537342	\N	\N	\N	\N	\N
152	2023-08-03 06:32:39.567288	2023-08-03 06:32:39.567288	Brice Heaney	2163 Veum Parkways	Suite 897	\N	\N	North Lenitabury	South Dakota	03001-1804	152	37.7817191357043	-122.409475360714	\N	\N	\N	\N	\N
153	2023-08-03 06:32:39.603415	2023-08-03 06:32:39.603415	Lavelle Reinger JD	9497 Schultz Route	Suite 922	\N	\N	McCulloughport	Wyoming	60534	153	37.7820364168746	-122.4049467143	\N	\N	\N	\N	\N
154	2023-08-03 06:32:39.640093	2023-08-03 06:32:39.640093	Russell Weimann	57596 Friesen Brook	Suite 691	\N	\N	Flatleyville	Wyoming	61456-9742	154	37.7818772631201	-122.405519826678	\N	\N	\N	\N	\N
155	2023-08-03 06:32:39.709115	2023-08-03 06:32:39.709115	Teodoro Mraz JD	1599 Padberg Overpass	Apt. 975	\N	\N	Ellistown	Virginia	45629-5286	155	37.7956925501771	-122.399579028261	\N	\N	\N	\N	\N
156	2023-08-03 06:32:39.751462	2023-08-03 06:32:39.751462	Lamar Heathcote Esq.	4809 Ratke Vista	Suite 249	\N	\N	Port Kelle	Idaho	85392	156	37.788803135147	-122.408408724435	\N	\N	\N	\N	\N
157	2023-08-03 06:32:39.792462	2023-08-03 06:32:39.792462	Rosendo Bernhard DO	650 Israel Glens	Apt. 374	\N	\N	Lake Erwin	Wisconsin	82461	157	37.7854253908316	-122.400921552604	\N	\N	\N	\N	\N
158	2023-08-03 06:32:39.826781	2023-08-03 06:32:39.826781	Modesto Hand	5171 Lacy Meadows	Suite 204	\N	\N	Concepcionberg	Arkansas	45467	158	37.7913356605243	-122.390342146759	\N	\N	\N	\N	\N
159	2023-08-03 06:32:39.872865	2023-08-03 06:32:39.872865	Luciano Schmeler	9537 Shanahan Turnpike	Apt. 825	\N	\N	Tremblayhaven	Washington	66183-2456	159	37.7895237127353	-122.392583935788	\N	\N	\N	\N	\N
160	2023-08-03 06:32:39.906887	2023-08-03 06:32:39.906887	Sandy Rodriguez	978 Dibbert Locks	Suite 312	\N	\N	West Raymon	North Carolina	04365-8576	160	37.7860859633854	-122.409264820589	\N	\N	\N	\N	\N
161	2023-08-03 06:32:39.945804	2023-08-03 06:32:39.945804	Keshia Champlin	7214 Carmina Run	Suite 125	\N	\N	Altenwerthchester	Delaware	47269-7612	161	37.7974069164913	-122.406394654569	\N	\N	\N	\N	\N
162	2023-08-03 06:32:39.990182	2023-08-03 06:32:39.990182	Ms. Latisha Glover	75403 Lashandra Street	Apt. 734	\N	\N	New Davidhaven	Kansas	35644	162	37.780831489489	-122.404319750733	\N	\N	\N	\N	\N
163	2023-08-03 06:32:40.023013	2023-08-03 06:32:40.023013	Son Langosh I	163 White Loop	Suite 267	\N	\N	West Eloiseport	Massachusetts	17884	163	37.7859936532683	-122.397883689666	\N	\N	\N	\N	\N
164	2023-08-03 06:32:40.068851	2023-08-03 06:32:40.068851	Lanny Crona	204 Hunter Turnpike	Apt. 117	\N	\N	Deonnastad	South Dakota	40252-7192	164	37.7860540412418	-122.392512448175	\N	\N	\N	\N	\N
165	2023-08-03 06:32:40.122058	2023-08-03 06:32:40.122058	Pres. Deonna Collins	4749 Stehr Terrace	Suite 796	\N	\N	DuBuquestad	North Dakota	62242	165	37.7905922307078	-122.397244367352	\N	\N	\N	\N	\N
166	2023-08-03 06:32:40.165255	2023-08-03 06:32:40.165255	Jesusa Lehner	3194 Johnson Pass	Apt. 184	\N	\N	East Bari	Florida	35529-8361	166	37.7985677217344	-122.403549484494	\N	\N	\N	\N	\N
167	2023-08-03 06:32:40.206514	2023-08-03 06:32:40.206514	Willene Trantow V	62993 Champlin Locks	Suite 409	\N	\N	Julietaville	Colorado	78567-7110	167	37.7927161172588	-122.400934967294	\N	\N	\N	\N	\N
168	2023-08-03 06:32:40.249844	2023-08-03 06:32:40.249844	Mr. Marvin Corkery	634 Kelsey Plain	Apt. 946	\N	\N	Port Jason	West Virginia	76088-2370	168	37.7994499676661	-122.400032339241	\N	\N	\N	\N	\N
169	2023-08-03 06:32:40.286645	2023-08-03 06:32:40.286645	Pres. Belia Krajcik	420 Nolan Stream	Suite 594	\N	\N	Gottliebfurt	Nevada	73799-8217	169	37.7988582914132	-122.396994682067	\N	\N	\N	\N	\N
170	2023-08-03 06:32:40.328531	2023-08-03 06:32:40.328531	Loura Cormier	7387 Wilderman Islands	Suite 554	\N	\N	Sipesbury	Arizona	20724-9609	170	37.7996908891929	-122.399245962853	\N	\N	\N	\N	\N
171	2023-08-03 06:32:40.365801	2023-08-03 06:32:40.365801	Brady Mann	46517 Schaden Brook	Suite 581	\N	\N	West Billie	Massachusetts	39979-4269	171	37.781998575452	-122.409841978307	\N	\N	\N	\N	\N
172	2023-08-03 06:32:40.402874	2023-08-03 06:32:40.402874	Eunice Monahan	3069 Koelpin Circles	Suite 883	\N	\N	Port Dejaside	New Mexico	89957-4854	172	37.7837037854237	-122.406530223763	\N	\N	\N	\N	\N
173	2023-08-03 06:32:40.447944	2023-08-03 06:32:40.447944	Gabriel Kunde	38331 Roberto Circles	Suite 392	\N	\N	New Willenaland	Delaware	04939	173	37.7861998512134	-122.391466438179	\N	\N	\N	\N	\N
174	2023-08-03 06:32:40.488548	2023-08-03 06:32:40.488548	Larry Mitchell DVM	1416 Lawrence Islands	Apt. 979	\N	\N	South Ernieberg	Alaska	66106	174	37.792329802238	-122.406833297105	\N	\N	\N	\N	\N
175	2023-08-03 06:32:40.528333	2023-08-03 06:32:40.528333	Brock Auer	995 Abernathy Estates	Suite 615	\N	\N	Schulistfurt	Delaware	76808-6839	175	37.7813708526723	-122.406849518598	\N	\N	\N	\N	\N
176	2023-08-03 06:32:40.573823	2023-08-03 06:32:40.573823	Lavette Kreiger	3617 Coleman Mission	Apt. 445	\N	\N	Mullerton	Minnesota	66186	176	37.7968456142663	-122.407907423874	\N	\N	\N	\N	\N
177	2023-08-03 06:32:40.64079	2023-08-03 06:32:40.64079	Particia West	228 Letisha Crossing	Suite 232	\N	\N	Mitchellland	Louisiana	56409-6131	177	37.7909229433751	-122.39260005512	\N	\N	\N	\N	\N
178	2023-08-03 06:32:40.682638	2023-08-03 06:32:40.682638	Fredia Cruickshank	801 Towanda Parkways	Apt. 110	\N	\N	Lake Forrest	Colorado	58856	178	37.7884886659027	-122.400875021125	\N	\N	\N	\N	\N
179	2023-08-03 06:32:40.724129	2023-08-03 06:32:40.724129	Burton Metz	1751 Leffler Skyway	Apt. 877	\N	\N	North Ivanachester	New Hampshire	34698	179	37.7809290631771	-122.394842192255	\N	\N	\N	\N	\N
180	2023-08-03 06:32:40.765753	2023-08-03 06:32:40.765753	Andre Ratke	815 Stamm Plains	Apt. 426	\N	\N	East Kory	Kansas	74578-9134	180	37.7968610349495	-122.39668314462	\N	\N	\N	\N	\N
181	2023-08-03 06:32:40.80425	2023-08-03 06:32:40.80425	Catheryn Schuppe	2602 Frederica Throughway	Suite 748	\N	\N	Willview	Washington	30430-5429	181	37.7958769484858	-122.406743733311	\N	\N	\N	\N	\N
182	2023-08-03 06:32:40.847637	2023-08-03 06:32:40.847637	Ronald Willms	48720 Meri Run	Suite 346	\N	\N	North Hyon	Colorado	50277	182	37.7942734151302	-122.392358415388	\N	\N	\N	\N	\N
183	2023-08-03 06:32:40.885853	2023-08-03 06:32:40.885853	Maxine Gerhold	96955 Beahan Mews	Apt. 216	\N	\N	South Otis	Kansas	01145-1065	183	37.7963784971978	-122.406152724241	\N	\N	\N	\N	\N
184	2023-08-03 06:32:40.926348	2023-08-03 06:32:40.926348	Lavern Harvey Sr.	491 Ardis Gateway	Apt. 452	\N	\N	Lefflerport	New Mexico	04201-6159	184	37.7813743717414	-122.390466871586	\N	\N	\N	\N	\N
185	2023-08-03 06:32:40.966048	2023-08-03 06:32:40.966048	Gov. Amada Trantow	52124 Wisoky Spur	Apt. 211	\N	\N	Wardburgh	Hawaii	84500	185	37.7994404216017	-122.405772188489	\N	\N	\N	\N	\N
186	2023-08-03 06:32:41.006108	2023-08-03 06:32:41.006108	Tamica Mueller	71492 Brenton Hills	Suite 467	\N	\N	Stanfordberg	Maryland	92521-5147	186	37.780625119471	-122.40117502401	\N	\N	\N	\N	\N
187	2023-08-03 06:32:41.043319	2023-08-03 06:32:41.043319	Stanton Zieme	313 Marietta Camp	Suite 344	\N	\N	Carrollside	Utah	63021	187	37.7840328742292	-122.393981284014	\N	\N	\N	\N	\N
\.


--
-- Data for Name: addresses_services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.addresses_services (service_id, address_id) FROM stdin;
\.


--
-- Data for Name: admins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admins (id, provider, uid, encrypted_password, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, email, tokens, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2023-08-03 06:32:27.871332	2023-08-03 06:32:27.871332
schema_sha1	92ab30c788a76104bf95d23770fb455fb3c71179	2023-08-03 06:32:27.874674	2023-08-03 06:32:27.874674
\.


--
-- Data for Name: bookmarks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bookmarks (id, identifier, date_value, id_value, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, created_at, updated_at, name, top_level, vocabulary, featured) FROM stdin;
2	2023-08-03 06:32:28.431804	2023-08-03 06:32:28.431804	Immediate Safety	f	\N	f
3	2023-08-03 06:32:28.433225	2023-08-03 06:32:28.433225	Help Escape Violence	f	\N	f
4	2023-08-03 06:32:28.43462	2023-08-03 06:32:28.43462	Psychiatric Emergency Services	f	\N	f
6	2023-08-03 06:32:28.437524	2023-08-03 06:32:28.437524	Food Delivery	f	\N	f
7	2023-08-03 06:32:28.438752	2023-08-03 06:32:28.438752	Food Pantry	f	\N	f
8	2023-08-03 06:32:28.43999	2023-08-03 06:32:28.43999	Free Meals	f	\N	f
9	2023-08-03 06:32:28.441285	2023-08-03 06:32:28.441285	Food Benefits	f	\N	f
10	2023-08-03 06:32:28.44246	2023-08-03 06:32:28.44246	Help Pay for Food	f	\N	f
13	2023-08-03 06:32:28.446212	2023-08-03 06:32:28.446212	Help Pay For Housing	f	\N	f
14	2023-08-03 06:32:28.447412	2023-08-03 06:32:28.447412	Help Pay for Housing	f	\N	f
15	2023-08-03 06:32:28.448598	2023-08-03 06:32:28.448598	Help Pay for Utilities	f	\N	f
16	2023-08-03 06:32:28.449953	2023-08-03 06:32:28.449953	Help Pay for Internet or Phone	f	\N	f
17	2023-08-03 06:32:28.45123	2023-08-03 06:32:28.45123	Home & Renters Insurance	f	\N	f
18	2023-08-03 06:32:28.452446	2023-08-03 06:32:28.452446	Housing Vouchers	f	\N	f
19	2023-08-03 06:32:28.453705	2023-08-03 06:32:28.453705	Long-Term Housing	f	\N	f
20	2023-08-03 06:32:28.454907	2023-08-03 06:32:28.454907	Assisted Living	f	\N	f
21	2023-08-03 06:32:28.456156	2023-08-03 06:32:28.456156	Independent Living	f	\N	f
22	2023-08-03 06:32:28.457522	2023-08-03 06:32:28.457522	Nursing Home	f	\N	f
23	2023-08-03 06:32:28.458758	2023-08-03 06:32:28.458758	Public Housing	f	\N	f
24	2023-08-03 06:32:28.460062	2023-08-03 06:32:28.460062	Safe Housing	f	\N	f
25	2023-08-03 06:32:28.461321	2023-08-03 06:32:28.461321	Short-Term Housing	f	\N	f
26	2023-08-03 06:32:28.462777	2023-08-03 06:32:28.462777	Sober Living	f	\N	f
28	2023-08-03 06:32:28.465221	2023-08-03 06:32:28.465221	Clothes for School	f	\N	f
29	2023-08-03 06:32:28.466514	2023-08-03 06:32:28.466514	Clothes for Work	f	\N	f
30	2023-08-03 06:32:28.467914	2023-08-03 06:32:28.467914	Clothing Vouchers	f	\N	f
31	2023-08-03 06:32:28.46918	2023-08-03 06:32:28.46918	Home Goods	f	\N	f
32	2023-08-03 06:32:28.470434	2023-08-03 06:32:28.470434	Medical Supplies	f	\N	f
33	2023-08-03 06:32:28.471717	2023-08-03 06:32:28.471717	Personal Safety	f	\N	f
35	2023-08-03 06:32:28.474214	2023-08-03 06:32:28.474214	Bus Passes	f	\N	f
36	2023-08-03 06:32:28.475553	2023-08-03 06:32:28.475553	Help Pay for Transit	f	\N	f
38	2023-08-03 06:32:28.478198	2023-08-03 06:32:28.478198	Addiction & Recovery	f	\N	f
39	2023-08-03 06:32:28.479475	2023-08-03 06:32:28.479475	Dental Care	f	\N	f
40	2023-08-03 06:32:28.480661	2023-08-03 06:32:28.480661	Health Education	f	\N	f
41	2023-08-03 06:32:28.481913	2023-08-03 06:32:28.481913	Daily Life Skills	f	\N	f
42	2023-08-03 06:32:28.483183	2023-08-03 06:32:28.483183	Disease Management	f	\N	f
43	2023-08-03 06:32:28.484424	2023-08-03 06:32:28.484424	Family Planning	f	\N	f
44	2023-08-03 06:32:28.485862	2023-08-03 06:32:28.485862	Nutrition Education	f	\N	f
45	2023-08-03 06:32:28.48714	2023-08-03 06:32:28.48714	Parenting Education	f	\N	f
46	2023-08-03 06:32:28.488369	2023-08-03 06:32:28.488369	Sex Education	f	\N	f
47	2023-08-03 06:32:28.489707	2023-08-03 06:32:28.489707	Understand Disability	f	\N	f
48	2023-08-03 06:32:28.491153	2023-08-03 06:32:28.491153	Understand Mental Health	f	\N	f
49	2023-08-03 06:32:28.492395	2023-08-03 06:32:28.492395	Help Pay for Healthcare	f	\N	f
50	2023-08-03 06:32:28.493629	2023-08-03 06:32:28.493629	Disability Benefits	f	\N	f
51	2023-08-03 06:32:28.494921	2023-08-03 06:32:28.494921	Discounted Healthcare	f	\N	f
52	2023-08-03 06:32:28.4962	2023-08-03 06:32:28.4962	Health Insurance	f	\N	f
53	2023-08-03 06:32:28.497427	2023-08-03 06:32:28.497427	Prescription Assistance	f	\N	f
54	2023-08-03 06:32:28.498847	2023-08-03 06:32:28.498847	Transportation for Healthcare	f	\N	f
55	2023-08-03 06:32:28.500123	2023-08-03 06:32:28.500123	Medical Care	f	\N	f
56	2023-08-03 06:32:28.50134	2023-08-03 06:32:28.50134	Primary Care	f	\N	f
57	2023-08-03 06:32:28.502611	2023-08-03 06:32:28.502611	Birth Control	f	\N	f
58	2023-08-03 06:32:28.503812	2023-08-03 06:32:28.503812	Checkup & Test	f	\N	f
59	2023-08-03 06:32:28.505003	2023-08-03 06:32:28.505003	Disability Screening	f	\N	f
60	2023-08-03 06:32:28.506186	2023-08-03 06:32:28.506186	Disease Screening	f	\N	f
61	2023-08-03 06:32:28.507423	2023-08-03 06:32:28.507423	Hearing Tests	f	\N	f
62	2023-08-03 06:32:28.508694	2023-08-03 06:32:28.508694	Mental Health Evaluation	f	\N	f
63	2023-08-03 06:32:28.509959	2023-08-03 06:32:28.509959	Pregnancy Tests	f	\N	f
64	2023-08-03 06:32:28.511231	2023-08-03 06:32:28.511231	Fertility	f	\N	f
65	2023-08-03 06:32:28.512457	2023-08-03 06:32:28.512457	Maternity Care	f	\N	f
66	2023-08-03 06:32:28.513603	2023-08-03 06:32:28.513603	Personal Hygiene	f	\N	f
67	2023-08-03 06:32:28.514775	2023-08-03 06:32:28.514775	Postnatal Care	f	\N	f
68	2023-08-03 06:32:28.515995	2023-08-03 06:32:28.515995	Prevent & Treat	f	\N	f
69	2023-08-03 06:32:28.517393	2023-08-03 06:32:28.517393	Counseling	f	\N	f
70	2023-08-03 06:32:28.518651	2023-08-03 06:32:28.518651	HIV Treatment	f	\N	f
71	2023-08-03 06:32:28.519866	2023-08-03 06:32:28.519866	Pain Management	f	\N	f
72	2023-08-03 06:32:28.521035	2023-08-03 06:32:28.521035	Physical Therapy	f	\N	f
73	2023-08-03 06:32:28.522206	2023-08-03 06:32:28.522206	Specialized Therapy	f	\N	f
74	2023-08-03 06:32:28.523436	2023-08-03 06:32:28.523436	Vaccinations	f	\N	f
75	2023-08-03 06:32:28.524656	2023-08-03 06:32:28.524656	Mental Health Care	f	\N	f
76	2023-08-03 06:32:28.525856	2023-08-03 06:32:28.525856	Anger Management	f	\N	f
77	2023-08-03 06:32:28.527065	2023-08-03 06:32:28.527065	Bereavement	f	\N	f
78	2023-08-03 06:32:28.528555	2023-08-03 06:32:28.528555	Group Therapy	f	\N	f
79	2023-08-03 06:32:28.529743	2023-08-03 06:32:28.529743	Substance Abuse Counseling	f	\N	f
80	2023-08-03 06:32:28.531258	2023-08-03 06:32:28.531258	Family Counseling	f	\N	f
81	2023-08-03 06:32:28.532476	2023-08-03 06:32:28.532476	Individual Counseling	f	\N	f
82	2023-08-03 06:32:28.533763	2023-08-03 06:32:28.533763	Medicatons for Mental Health	f	\N	f
83	2023-08-03 06:32:28.535017	2023-08-03 06:32:28.535017	Drug Testing	f	\N	f
84	2023-08-03 06:32:28.536295	2023-08-03 06:32:28.536295	Hospice	f	\N	f
85	2023-08-03 06:32:28.537591	2023-08-03 06:32:28.537591	Vision Care	f	\N	f
87	2023-08-03 06:32:28.540063	2023-08-03 06:32:28.540063	Government Benefits	f	\N	f
88	2023-08-03 06:32:28.541298	2023-08-03 06:32:28.541298	Retirement Benefits	f	\N	f
89	2023-08-03 06:32:28.542562	2023-08-03 06:32:28.542562	Understand Government Programs	f	\N	f
90	2023-08-03 06:32:28.543971	2023-08-03 06:32:28.543971	Unemployment Benefits	f	\N	f
91	2023-08-03 06:32:28.545257	2023-08-03 06:32:28.545257	Financial Education	f	\N	f
92	2023-08-03 06:32:28.546556	2023-08-03 06:32:28.546556	Insurance	f	\N	f
93	2023-08-03 06:32:28.54781	2023-08-03 06:32:28.54781	Tax Preparation	f	\N	f
95	2023-08-03 06:32:28.550231	2023-08-03 06:32:28.550231	Daytime Care	f	\N	f
96	2023-08-03 06:32:28.551471	2023-08-03 06:32:28.551471	Adult Daycare	f	\N	f
97	2023-08-03 06:32:28.552667	2023-08-03 06:32:28.552667	After School Care	f	\N	f
98	2023-08-03 06:32:28.553831	2023-08-03 06:32:28.553831	Before School Care	f	\N	f
99	2023-08-03 06:32:28.555008	2023-08-03 06:32:28.555008	Childcare	f	\N	f
100	2023-08-03 06:32:28.556201	2023-08-03 06:32:28.556201	Help Find Childcare	f	\N	f
101	2023-08-03 06:32:28.55758	2023-08-03 06:32:28.55758	Help Pay for Childcare	f	\N	f
102	2023-08-03 06:32:28.558862	2023-08-03 06:32:28.558862	Day Camp	f	\N	f
103	2023-08-03 06:32:28.56007	2023-08-03 06:32:28.56007	Preschool	f	\N	f
104	2023-08-03 06:32:28.561262	2023-08-03 06:32:28.561262	Recreation	f	\N	f
105	2023-08-03 06:32:28.562518	2023-08-03 06:32:28.562518	Relief for Caregivers	f	\N	f
106	2023-08-03 06:32:28.56772	2023-08-03 06:32:28.56772	End-of-Life Care	f	\N	f
107	2023-08-03 06:32:28.568981	2023-08-03 06:32:28.568981	Navigating the System	f	\N	f
108	2023-08-03 06:32:28.571187	2023-08-03 06:32:28.571187	Help Fill out Forms	f	\N	f
109	2023-08-03 06:32:28.572468	2023-08-03 06:32:28.572468	Help Find Housing	f	\N	f
110	2023-08-03 06:32:28.573749	2023-08-03 06:32:28.573749	Help Find School	f	\N	f
5	2023-08-03 06:32:28.436246	2023-08-03 06:32:28.686702	Food	t	\N	f
27	2023-08-03 06:32:28.463987	2023-08-03 06:32:28.690083	Goods	t	\N	f
34	2023-08-03 06:32:28.472951	2023-08-03 06:32:28.691824	Transit	t	\N	f
37	2023-08-03 06:32:28.476955	2023-08-03 06:32:28.693476	Health	t	\N	f
86	2023-08-03 06:32:28.538839	2023-08-03 06:32:28.695054	Money	t	\N	f
94	2023-08-03 06:32:28.549027	2023-08-03 06:32:28.6968	Care	t	\N	f
11	2023-08-03 06:32:28.443697	2023-08-03 06:32:28.721545	Housing	t	\N	t
111	2023-08-03 06:32:28.574991	2023-08-03 06:32:28.574991	Help Find Work	f	\N	f
112	2023-08-03 06:32:28.576764	2023-08-03 06:32:28.576764	Support Network	f	\N	f
113	2023-08-03 06:32:28.577993	2023-08-03 06:32:28.577993	Help Hotlines	f	\N	f
114	2023-08-03 06:32:28.579223	2023-08-03 06:32:28.579223	Home Visiting	f	\N	f
115	2023-08-03 06:32:28.58041	2023-08-03 06:32:28.58041	In-Home Support	f	\N	f
116	2023-08-03 06:32:28.581604	2023-08-03 06:32:28.581604	Mentoring	f	\N	f
117	2023-08-03 06:32:28.582837	2023-08-03 06:32:28.582837	One-on-One Support	f	\N	f
118	2023-08-03 06:32:28.584065	2023-08-03 06:32:28.584065	Peer Support	f	\N	f
119	2023-08-03 06:32:28.585259	2023-08-03 06:32:28.585259	Spiritual Support	f	\N	f
120	2023-08-03 06:32:28.586404	2023-08-03 06:32:28.586404	Support Groups	f	\N	f
121	2023-08-03 06:32:28.587575	2023-08-03 06:32:28.587575	12-Step	f	\N	f
122	2023-08-03 06:32:28.588932	2023-08-03 06:32:28.588932	Virtual Support	f	\N	f
124	2023-08-03 06:32:28.591337	2023-08-03 06:32:28.591337	Help Pay for School	f	\N	f
125	2023-08-03 06:32:28.592513	2023-08-03 06:32:28.592513	Books	f	\N	f
126	2023-08-03 06:32:28.59369	2023-08-03 06:32:28.59369	Financial Aid & Loans	f	\N	f
127	2023-08-03 06:32:28.594878	2023-08-03 06:32:28.594878	Transportation for School	f	\N	f
128	2023-08-03 06:32:28.596155	2023-08-03 06:32:28.596155	Supplies for School	f	\N	f
129	2023-08-03 06:32:28.597417	2023-08-03 06:32:28.597417	More Education	f	\N	f
130	2023-08-03 06:32:28.598628	2023-08-03 06:32:28.598628	Alternative Education	f	\N	f
131	2023-08-03 06:32:28.600186	2023-08-03 06:32:28.600186	English as a Second Language (ESL)	f	\N	f
132	2023-08-03 06:32:28.601396	2023-08-03 06:32:28.601396	Foreign Languages	f	\N	f
133	2023-08-03 06:32:28.602723	2023-08-03 06:32:28.602723	GED/High-School Equivalency	f	\N	f
134	2023-08-03 06:32:28.603916	2023-08-03 06:32:28.603916	Supported Employment	f	\N	f
135	2023-08-03 06:32:28.605093	2023-08-03 06:32:28.605093	Special Education	f	\N	f
136	2023-08-03 06:32:28.606337	2023-08-03 06:32:28.606337	Tutoring	f	\N	f
137	2023-08-03 06:32:28.607519	2023-08-03 06:32:28.607519	Screening & Exams	f	\N	f
138	2023-08-03 06:32:28.60868	2023-08-03 06:32:28.60868	Citizenship & Immigration	f	\N	f
139	2023-08-03 06:32:28.609841	2023-08-03 06:32:28.609841	Skills & Training	f	\N	f
140	2023-08-03 06:32:28.611049	2023-08-03 06:32:28.611049	Basic Literacy	f	\N	f
141	2023-08-03 06:32:28.612254	2023-08-03 06:32:28.612254	Computer Class	f	\N	f
142	2023-08-03 06:32:28.613425	2023-08-03 06:32:28.613425	Interview Training	f	\N	f
143	2023-08-03 06:32:28.614578	2023-08-03 06:32:28.614578	Resume Development	f	\N	f
144	2023-08-03 06:32:28.615697	2023-08-03 06:32:28.615697	Skills Assessment	f	\N	f
145	2023-08-03 06:32:28.616872	2023-08-03 06:32:28.616872	Specialized Training	f	\N	f
147	2023-08-03 06:32:28.619232	2023-08-03 06:32:28.619232	Job Placement	f	\N	f
148	2023-08-03 06:32:28.620471	2023-08-03 06:32:28.620471	Help Pay for Work Expenses	f	\N	f
149	2023-08-03 06:32:28.621815	2023-08-03 06:32:28.621815	Workplace Rights	f	\N	f
151	2023-08-03 06:32:28.624281	2023-08-03 06:32:28.624281	Advocacy & Legal Aid	f	\N	f
152	2023-08-03 06:32:28.625535	2023-08-03 06:32:28.625535	Discrimination & Civil Rights	f	\N	f
153	2023-08-03 06:32:28.62671	2023-08-03 06:32:28.62671	Guardianship	f	\N	f
154	2023-08-03 06:32:28.628186	2023-08-03 06:32:28.628186	Identification Recovery	f	\N	f
155	2023-08-03 06:32:28.629443	2023-08-03 06:32:28.629443	Mediation	f	\N	f
156	2023-08-03 06:32:28.630634	2023-08-03 06:32:28.630634	Notary	f	\N	f
157	2023-08-03 06:32:28.631817	2023-08-03 06:32:28.631817	Representation	f	\N	f
158	2023-08-03 06:32:28.633006	2023-08-03 06:32:28.633006	Translation & Interpretation	f	\N	f
160	2023-08-03 06:32:28.635327	2023-08-03 06:32:28.635327	Hygiene	f	\N	f
161	2023-08-03 06:32:28.636652	2023-08-03 06:32:28.636652	Toilet	f	\N	f
162	2023-08-03 06:32:28.637993	2023-08-03 06:32:28.637993	Shower	f	\N	f
163	2023-08-03 06:32:28.639166	2023-08-03 06:32:28.639166	Hygiene Supplies	f	\N	f
164	2023-08-03 06:32:28.640381	2023-08-03 06:32:28.640381	Waste Disposal	f	\N	f
165	2023-08-03 06:32:28.641825	2023-08-03 06:32:28.641825	Water	f	\N	f
166	2023-08-03 06:32:28.643037	2023-08-03 06:32:28.643037	Storage	f	\N	f
167	2023-08-03 06:32:28.64428	2023-08-03 06:32:28.64428	Drug Related Services	f	\N	f
168	2023-08-03 06:32:28.645499	2023-08-03 06:32:28.645499	Government Homelessness Services	f	\N	f
169	2023-08-03 06:32:28.646927	2023-08-03 06:32:28.646927	Technology	f	\N	f
170	2023-08-03 06:32:28.648128	2023-08-03 06:32:28.648128	Wifi Access	f	\N	f
171	2023-08-03 06:32:28.649416	2023-08-03 06:32:28.649416	Computer Access	f	\N	f
172	2023-08-03 06:32:28.650681	2023-08-03 06:32:28.650681	Smartphones	f	\N	f
173	2023-08-03 06:32:28.651892	2023-08-03 06:32:28.651892	Family Shelters	f	\N	f
174	2023-08-03 06:32:28.653064	2023-08-03 06:32:28.653064	Domestic Violence Shelters	f	\N	f
176	2023-08-03 06:32:28.655598	2023-08-03 06:32:28.655598	Housing/Tenants Rights	f	\N	f
179	2023-08-03 06:32:28.65914	2023-08-03 06:32:28.65914	End of Life Care	f	\N	f
180	2023-08-03 06:32:28.660341	2023-08-03 06:32:28.660341	Home Delivered Meals	f	\N	f
181	2023-08-03 06:32:28.661534	2023-08-03 06:32:28.661534	Senior Centers	f	\N	f
182	2023-08-03 06:32:28.662702	2023-08-03 06:32:28.662702	Congregate Meals	f	\N	f
183	2023-08-03 06:32:28.663856	2023-08-03 06:32:28.663856	Housing Rights	f	\N	f
185	2023-08-03 06:32:28.666202	2023-08-03 06:32:28.666202	Legal Representation	f	\N	f
187	2023-08-03 06:32:28.668855	2023-08-03 06:32:28.668855	Legal Services	f	\N	f
188	2023-08-03 06:32:28.669996	2023-08-03 06:32:28.669996	Domestic Violence Hotlines	f	\N	f
189	2023-08-03 06:32:28.671178	2023-08-03 06:32:28.671178	Re-entry Services	f	\N	f
190	2023-08-03 06:32:28.672348	2023-08-03 06:32:28.672348	Clean Slate	f	\N	f
191	2023-08-03 06:32:28.673571	2023-08-03 06:32:28.673571	Probation and Parole	f	\N	f
1	2023-08-03 06:32:28.429432	2023-08-03 06:32:28.684539	Emergency	t	\N	f
123	2023-08-03 06:32:28.590111	2023-08-03 06:32:28.698353	Education	t	\N	f
146	2023-08-03 06:32:28.618049	2023-08-03 06:32:28.700038	Work	t	\N	f
159	2023-08-03 06:32:28.634187	2023-08-03 06:32:28.703321	Homelessness Essentials	t	\N	f
177	2023-08-03 06:32:28.656794	2023-08-03 06:32:28.704848	Youth	t	\N	f
178	2023-08-03 06:32:28.657953	2023-08-03 06:32:28.706437	Seniors	t	\N	f
184	2023-08-03 06:32:28.665034	2023-08-03 06:32:28.708135	Domestic Violence	t	\N	f
186	2023-08-03 06:32:28.667603	2023-08-03 06:32:28.710063	Prison/Jail Related Services	t	\N	f
192	2023-08-03 06:32:28.674805	2023-08-03 06:32:28.711653	MOHCD Funded Services	t	\N	f
175	2023-08-03 06:32:28.654414	2023-08-03 06:32:28.713328	Eviction Defense	t	\N	f
12	2023-08-03 06:32:28.445011	2023-08-03 06:32:28.714852	Temporary Shelter	t	\N	f
196	2023-08-03 06:32:28.68023	2023-08-03 06:32:28.716538	sffamilies	t	\N	f
197	2023-08-03 06:32:28.682115	2023-08-03 06:32:28.718252	Covid Shelter	t	\N	f
193	2023-08-03 06:32:28.67602	2023-08-03 06:32:28.719899	Basic Needs & Shelter	f	\N	t
194	2023-08-03 06:32:28.677238	2023-08-03 06:32:28.723346	Health & Medical	f	\N	t
195	2023-08-03 06:32:28.678457	2023-08-03 06:32:28.725064	Employment	f	\N	t
150	2023-08-03 06:32:28.623056	2023-08-03 06:32:28.726676	Legal	t	\N	t
234	2023-08-03 06:32:38.847071	2023-08-03 06:32:38.847071	Test_Category_Top_Level	t	\N	f
1000001	2023-08-03 06:32:39.486462	2023-08-03 06:32:39.486462	Covid-food	f	\N	f
1000002	2023-08-03 06:32:39.63412	2023-08-03 06:32:39.63412	Covid-hygiene	f	\N	f
198	2023-08-03 06:32:39.635375	2023-08-03 06:32:39.635375	Portable Toilets and Hand-Washing Stations	f	\N	f
199	2023-08-03 06:32:39.704021	2023-08-03 06:32:39.704021	Hygiene kits	f	\N	f
200	2023-08-03 06:32:39.746619	2023-08-03 06:32:39.746619	Showers	f	\N	f
201	2023-08-03 06:32:39.78774	2023-08-03 06:32:39.78774	Laundry	f	\N	f
202	2023-08-03 06:32:39.82193	2023-08-03 06:32:39.82193	Clothing	f	\N	f
203	2023-08-03 06:32:39.868141	2023-08-03 06:32:39.868141	Diaper Bank	f	\N	f
1000003	2023-08-03 06:32:39.901068	2023-08-03 06:32:39.901068	Covid-finance	f	\N	f
204	2023-08-03 06:32:39.902178	2023-08-03 06:32:39.902178	Emergency Financial Assistance	f	\N	f
205	2023-08-03 06:32:39.941164	2023-08-03 06:32:39.941164	Financial Assistance for Living Expenses	f	\N	f
206	2023-08-03 06:32:39.984976	2023-08-03 06:32:39.984976	Unemployment Insurance-based Benefit Payments	f	\N	f
207	2023-08-03 06:32:40.01853	2023-08-03 06:32:40.01853	Job Assistance	f	\N	f
1000004	2023-08-03 06:32:40.062809	2023-08-03 06:32:40.062809	Covid-housing	f	\N	f
208	2023-08-03 06:32:40.06409	2023-08-03 06:32:40.06409	My landlord gave me an eviction notice and I need legal help	f	\N	f
209	2023-08-03 06:32:40.117391	2023-08-03 06:32:40.117391	My landlord told me I would get evicted and I need advice	f	\N	f
210	2023-08-03 06:32:40.160579	2023-08-03 06:32:40.160579	I have not been able to pay my rent and I do not know what to do	f	\N	f
211	2023-08-03 06:32:40.201522	2023-08-03 06:32:40.201522	I am not getting along with my neighbor(s) and /or my landlord and I need advice	f	\N	f
1000005	2023-08-03 06:32:40.243972	2023-08-03 06:32:40.243972	Covid-health	f	\N	f
212	2023-08-03 06:32:40.245083	2023-08-03 06:32:40.245083	Coronavirus (COVID-19) Testing	f	\N	f
213	2023-08-03 06:32:40.28214	2023-08-03 06:32:40.28214	Coronavirus-Related Urgent Care	f	\N	f
214	2023-08-03 06:32:40.32369	2023-08-03 06:32:40.32369	Other Medical Services	f	\N	f
215	2023-08-03 06:32:40.361293	2023-08-03 06:32:40.361293	Mental Health Urgent Care	f	\N	f
216	2023-08-03 06:32:40.398021	2023-08-03 06:32:40.398021	Other Mental Health Services	f	\N	f
1000006	2023-08-03 06:32:40.441768	2023-08-03 06:32:40.441768	Covid-domesticviolence	f	\N	f
217	2023-08-03 06:32:40.442988	2023-08-03 06:32:40.442988	Temporary Shelter for Women	f	\N	f
218	2023-08-03 06:32:40.483893	2023-08-03 06:32:40.483893	Transitional Housing for Women	f	\N	f
219	2023-08-03 06:32:40.523619	2023-08-03 06:32:40.523619	Legal Assistance	f	\N	f
220	2023-08-03 06:32:40.568135	2023-08-03 06:32:40.568135	Domestic Violence Counseling	f	\N	f
1000007	2023-08-03 06:32:40.634341	2023-08-03 06:32:40.634341	Covid-internet	f	\N	f
221	2023-08-03 06:32:40.635693	2023-08-03 06:32:40.635693	Computer and Internet Access	f	\N	f
222	2023-08-03 06:32:40.677917	2023-08-03 06:32:40.677917	Computer Classes	f	\N	f
223	2023-08-03 06:32:40.719641	2023-08-03 06:32:40.719641	Cell phone Services	f	\N	f
1000008	2023-08-03 06:32:40.759633	2023-08-03 06:32:40.759633	Covid-lgbtqa	f	\N	f
224	2023-08-03 06:32:40.760823	2023-08-03 06:32:40.760823	Housing Assistance	f	\N	f
225	2023-08-03 06:32:40.799512	2023-08-03 06:32:40.799512	Legal Assistance 	f	\N	f
226	2023-08-03 06:32:40.842826	2023-08-03 06:32:40.842826	Youth Services	f	\N	f
227	2023-08-03 06:32:40.881369	2023-08-03 06:32:40.881369	Counseling Assistance	f	\N	f
228	2023-08-03 06:32:40.921149	2023-08-03 06:32:40.921149	General Help	f	\N	f
1000010	2023-08-03 06:32:40.960353	2023-08-03 06:32:40.960353	Covid-shelter	f	\N	f
229	2023-08-03 06:32:40.961546	2023-08-03 06:32:40.961546	We are a family and we need shelter	f	\N	f
230	2023-08-03 06:32:41.001328	2023-08-03 06:32:41.001328	I am someone between 18-24 years old in need of shelter	f	\N	f
231	2023-08-03 06:32:41.038633	2023-08-03 06:32:41.038633	I am a single adult and I need shelter	f	\N	f
\.


--
-- Data for Name: categories_keywords; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories_keywords (category_id, keyword_id) FROM stdin;
\.


--
-- Data for Name: categories_resources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories_resources (category_id, resource_id) FROM stdin;
177	1
112	1
26	2
159	3
68	3
178	4
10	5
192	6
86	7
24	7
197	9
118	10
196	11
97	11
5	12
123	13
20	13
146	14
163	15
94	16
86	17
82	17
192	20
60	20
11	21
34	23
175	24
93	24
155	25
33	26
74	28
196	29
14	30
178	31
8	35
150	36
42	37
178	38
121	38
25	40
37	41
186	42
172	42
178	45
37	45
192	46
84	47
137	48
8	49
11	50
98	50
186	51
112	51
11	52
34	54
146	55
150	55
159	56
142	56
126	57
34	58
37	59
149	60
11	62
34	64
96	64
79	65
86	66
164	66
94	67
18	67
45	68
195	69
1	70
93	70
66	72
175	74
1	75
192	78
86	78
123	79
66	79
178	80
184	82
145	82
82	83
178	84
9	84
67	85
27	87
150	89
34	91
123	92
178	93
142	93
27	94
37	95
27	96
146	97
79	97
38	98
123	99
12	100
86	101
27	102
78	104
123	106
111	106
184	107
11	110
5	111
184	112
82	112
27	113
36	114
177	115
1	117
109	121
37	122
196	123
64	123
105	125
94	126
7	126
123	127
133	128
11	129
11	130
11	131
11	132
193	133
193	134
193	135
193	136
194	137
194	138
194	139
194	140
195	141
195	142
195	143
195	144
150	145
150	146
150	147
150	148
234	149
1000001	150
1000001	151
1000001	152
1000001	153
198	154
199	155
200	156
201	157
202	158
203	159
204	160
205	161
206	162
207	163
208	164
209	165
210	166
211	167
212	168
213	169
214	170
215	171
216	172
217	173
218	174
219	175
220	176
221	177
222	178
223	179
224	180
225	181
226	182
227	183
228	184
229	185
230	186
231	187
\.


--
-- Data for Name: categories_services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories_services (service_id, category_id, feature_rank) FROM stdin;
1	177	\N
1	112	\N
2	177	\N
2	112	\N
3	26	\N
4	26	\N
5	159	\N
5	68	\N
6	159	\N
6	68	\N
7	178	\N
8	10	\N
9	10	\N
10	192	\N
11	192	\N
12	86	\N
12	24	\N
13	86	\N
13	24	\N
16	197	\N
17	118	\N
18	196	\N
18	97	\N
19	196	\N
19	97	\N
20	5	\N
21	5	\N
22	123	\N
22	20	\N
23	123	\N
23	20	\N
24	146	\N
25	163	\N
26	94	\N
27	86	\N
27	82	\N
28	86	\N
28	82	\N
32	192	\N
32	60	\N
33	192	\N
33	60	\N
37	34	\N
38	34	\N
39	175	\N
39	93	\N
40	175	\N
40	93	\N
41	155	\N
42	33	\N
44	74	\N
45	196	\N
46	14	\N
47	178	\N
48	178	\N
53	8	\N
55	42	\N
56	178	\N
56	121	\N
58	25	\N
59	37	\N
60	186	\N
60	172	\N
61	186	\N
61	172	\N
64	178	\N
64	37	\N
65	178	\N
65	37	\N
66	192	\N
67	84	\N
68	84	\N
69	137	\N
70	8	\N
71	98	\N
72	186	\N
72	112	\N
73	186	\N
73	112	\N
74	11	\N
75	11	\N
78	34	\N
79	146	\N
80	146	\N
80	150	\N
81	159	\N
81	142	\N
82	159	\N
82	142	\N
83	126	\N
84	34	\N
85	34	\N
86	37	\N
87	37	\N
88	149	\N
89	149	\N
92	11	\N
93	11	\N
95	34	\N
95	96	\N
96	34	\N
96	96	\N
97	79	\N
98	79	\N
99	86	\N
99	164	\N
100	94	\N
100	18	\N
101	45	\N
102	45	\N
104	1	\N
104	93	\N
105	1	\N
105	93	\N
108	66	\N
111	175	\N
112	175	\N
113	1	\N
114	1	\N
117	192	\N
117	86	\N
118	192	\N
118	86	\N
119	123	\N
119	66	\N
120	123	\N
120	66	\N
121	178	\N
122	178	\N
124	184	\N
124	145	\N
125	184	\N
125	145	\N
126	82	\N
127	178	\N
127	9	\N
128	67	\N
131	27	\N
134	150	\N
137	34	\N
138	34	\N
139	123	\N
140	178	\N
140	142	\N
141	27	\N
142	27	\N
143	37	\N
144	27	\N
145	146	\N
145	79	\N
146	146	\N
146	79	\N
147	38	\N
148	123	\N
149	123	\N
150	12	\N
151	86	\N
152	27	\N
153	27	\N
155	78	\N
157	123	\N
157	111	\N
158	184	\N
161	11	\N
162	11	\N
163	5	\N
164	184	\N
164	82	\N
165	184	\N
165	82	\N
166	27	\N
167	36	\N
168	177	\N
170	1	\N
174	109	\N
175	109	\N
176	37	\N
177	37	\N
178	196	\N
178	64	\N
179	196	\N
179	64	\N
182	105	\N
183	94	\N
183	7	\N
184	123	\N
185	133	\N
186	11	\N
187	11	\N
188	11	\N
189	11	\N
190	11	\N
34	11	1
71	11	2
193	193	\N
194	193	\N
195	193	\N
196	193	\N
191	193	1
192	193	2
199	194	\N
200	194	\N
201	194	\N
202	194	\N
203	194	\N
197	194	1
198	194	2
205	195	\N
206	195	\N
207	195	\N
208	195	\N
103	195	1
204	195	2
209	150	\N
210	150	\N
211	150	\N
212	150	\N
213	150	\N
214	150	\N
54	150	1
79	150	2
215	234	\N
216	1000001	\N
217	1000001	\N
218	1000001	\N
219	1000001	\N
220	198	\N
220	1000002	\N
221	199	\N
221	1000002	\N
222	200	\N
222	1000002	\N
223	201	\N
223	1000002	\N
224	202	\N
224	1000002	\N
225	203	\N
225	1000002	\N
226	204	\N
226	1000003	\N
227	205	\N
227	1000003	\N
228	206	\N
228	1000003	\N
229	207	\N
229	1000003	\N
230	208	\N
230	1000004	\N
231	209	\N
231	1000004	\N
232	210	\N
232	1000004	\N
233	211	\N
233	1000004	\N
234	212	\N
234	1000005	\N
235	213	\N
235	1000005	\N
236	214	\N
236	1000005	\N
237	215	\N
237	1000005	\N
238	216	\N
238	1000005	\N
239	217	\N
239	1000006	\N
240	218	\N
240	1000006	\N
241	219	\N
241	1000006	\N
242	220	\N
242	1000006	\N
243	221	\N
243	1000007	\N
244	222	\N
244	1000007	\N
245	223	\N
245	1000007	\N
246	224	\N
246	1000008	\N
247	225	\N
247	1000008	\N
248	226	\N
248	1000008	\N
249	227	\N
249	1000008	\N
250	228	\N
250	1000008	\N
251	229	\N
251	1000010	\N
252	230	\N
252	1000010	\N
253	231	\N
253	1000010	\N
\.


--
-- Data for Name: categories_sites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories_sites (category_id, site_id) FROM stdin;
\.


--
-- Data for Name: category_relationships; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category_relationships (parent_id, child_id, child_priority_rank) FROM stdin;
150	185	\N
150	187	\N
150	191	\N
1000002	198	\N
1000002	199	\N
1000002	200	\N
1000002	201	\N
1000002	202	\N
1000002	203	\N
1000003	204	\N
1000003	205	\N
1000003	206	\N
1000003	207	\N
1000004	208	\N
1000004	209	\N
1000004	210	\N
1000004	211	\N
1000005	212	\N
1000005	213	\N
1000005	214	\N
1000005	215	\N
1000005	216	\N
1000006	217	\N
1000006	218	\N
1000006	219	\N
1000006	220	\N
1000007	221	\N
1000007	222	\N
1000007	223	\N
1000008	224	\N
1000008	225	\N
1000008	226	\N
1000008	227	\N
1000008	228	\N
1000010	229	\N
1000010	230	\N
1000010	231	\N
\.


--
-- Data for Name: change_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.change_requests (id, created_at, updated_at, type, object_id, status, action, resource_id) FROM stdin;
1	2023-08-03 06:32:29.55581	2023-08-03 06:32:29.55581	ResourceChangeRequest	1	0	1	\N
2	2023-08-03 06:32:29.589942	2023-08-03 06:32:29.589942	ResourceChangeRequest	1	0	1	\N
3	2023-08-03 06:32:29.645827	2023-08-03 06:32:29.645827	ResourceChangeRequest	2	0	1	\N
4	2023-08-03 06:32:29.669507	2023-08-03 06:32:29.669507	ResourceChangeRequest	2	0	1	\N
5	2023-08-03 06:32:29.715254	2023-08-03 06:32:29.715254	ResourceChangeRequest	3	0	1	\N
6	2023-08-03 06:32:29.740704	2023-08-03 06:32:29.740704	ResourceChangeRequest	3	0	1	\N
7	2023-08-03 06:32:29.792233	2023-08-03 06:32:29.792233	ResourceChangeRequest	4	0	1	\N
8	2023-08-03 06:32:29.848472	2023-08-03 06:32:29.848472	ResourceChangeRequest	5	0	1	\N
9	2023-08-03 06:32:29.871376	2023-08-03 06:32:29.871376	ResourceChangeRequest	5	0	1	\N
10	2023-08-03 06:32:29.921241	2023-08-03 06:32:29.921241	ResourceChangeRequest	6	0	1	\N
11	2023-08-03 06:32:29.947086	2023-08-03 06:32:29.947086	ResourceChangeRequest	6	0	1	\N
12	2023-08-03 06:32:30.004212	2023-08-03 06:32:30.004212	ResourceChangeRequest	7	0	1	\N
13	2023-08-03 06:32:30.026847	2023-08-03 06:32:30.026847	ResourceChangeRequest	7	0	1	\N
14	2023-08-03 06:32:30.069192	2023-08-03 06:32:30.069192	ResourceChangeRequest	8	0	1	\N
15	2023-08-03 06:32:30.093919	2023-08-03 06:32:30.093919	ResourceChangeRequest	8	0	1	\N
16	2023-08-03 06:32:30.134189	2023-08-03 06:32:30.134189	ResourceChangeRequest	9	0	1	\N
17	2023-08-03 06:32:30.184046	2023-08-03 06:32:30.184046	ResourceChangeRequest	10	0	1	\N
18	2023-08-03 06:32:30.237708	2023-08-03 06:32:30.237708	ResourceChangeRequest	11	0	1	\N
19	2023-08-03 06:32:30.261363	2023-08-03 06:32:30.261363	ResourceChangeRequest	11	0	1	\N
20	2023-08-03 06:32:30.30136	2023-08-03 06:32:30.30136	ResourceChangeRequest	12	0	1	\N
21	2023-08-03 06:32:30.323105	2023-08-03 06:32:30.323105	ResourceChangeRequest	12	0	1	\N
22	2023-08-03 06:32:30.369032	2023-08-03 06:32:30.369032	ResourceChangeRequest	13	0	1	\N
23	2023-08-03 06:32:30.393747	2023-08-03 06:32:30.393747	ResourceChangeRequest	13	0	1	\N
24	2023-08-03 06:32:30.440687	2023-08-03 06:32:30.440687	ResourceChangeRequest	14	0	1	\N
25	2023-08-03 06:32:30.481249	2023-08-03 06:32:30.481249	ResourceChangeRequest	15	0	1	\N
26	2023-08-03 06:32:30.525955	2023-08-03 06:32:30.525955	ResourceChangeRequest	16	0	1	\N
27	2023-08-03 06:32:30.568058	2023-08-03 06:32:30.568058	ResourceChangeRequest	17	0	1	\N
28	2023-08-03 06:32:30.596974	2023-08-03 06:32:30.596974	ResourceChangeRequest	17	0	1	\N
29	2023-08-03 06:32:30.656085	2023-08-03 06:32:30.656085	ResourceChangeRequest	18	0	1	\N
30	2023-08-03 06:32:30.68016	2023-08-03 06:32:30.68016	ResourceChangeRequest	18	0	1	\N
31	2023-08-03 06:32:30.723452	2023-08-03 06:32:30.723452	ResourceChangeRequest	19	0	1	\N
32	2023-08-03 06:32:30.770091	2023-08-03 06:32:30.770091	ResourceChangeRequest	20	0	1	\N
33	2023-08-03 06:32:30.792504	2023-08-03 06:32:30.792504	ResourceChangeRequest	20	0	1	\N
34	2023-08-03 06:32:30.834281	2023-08-03 06:32:30.834281	ResourceChangeRequest	21	0	1	\N
35	2023-08-03 06:32:30.879392	2023-08-03 06:32:30.879392	ResourceChangeRequest	22	0	1	\N
36	2023-08-03 06:32:30.901396	2023-08-03 06:32:30.901396	ResourceChangeRequest	22	0	1	\N
37	2023-08-03 06:32:30.945203	2023-08-03 06:32:30.945203	ResourceChangeRequest	23	0	1	\N
38	2023-08-03 06:32:30.972668	2023-08-03 06:32:30.972668	ResourceChangeRequest	23	0	1	\N
39	2023-08-03 06:32:31.017467	2023-08-03 06:32:31.017467	ResourceChangeRequest	24	0	1	\N
40	2023-08-03 06:32:31.044096	2023-08-03 06:32:31.044096	ResourceChangeRequest	24	0	1	\N
41	2023-08-03 06:32:31.098759	2023-08-03 06:32:31.098759	ResourceChangeRequest	25	0	1	\N
42	2023-08-03 06:32:31.150419	2023-08-03 06:32:31.150419	ResourceChangeRequest	26	0	1	\N
43	2023-08-03 06:32:31.202415	2023-08-03 06:32:31.202415	ResourceChangeRequest	27	0	1	\N
44	2023-08-03 06:32:31.249229	2023-08-03 06:32:31.249229	ResourceChangeRequest	28	0	1	\N
45	2023-08-03 06:32:31.295939	2023-08-03 06:32:31.295939	ResourceChangeRequest	29	0	1	\N
46	2023-08-03 06:32:31.340983	2023-08-03 06:32:31.340983	ResourceChangeRequest	30	0	1	\N
47	2023-08-03 06:32:31.385703	2023-08-03 06:32:31.385703	ResourceChangeRequest	31	0	1	\N
48	2023-08-03 06:32:31.413526	2023-08-03 06:32:31.413526	ResourceChangeRequest	31	0	1	\N
49	2023-08-03 06:32:31.46025	2023-08-03 06:32:31.46025	ResourceChangeRequest	32	0	1	\N
50	2023-08-03 06:32:31.507266	2023-08-03 06:32:31.507266	ResourceChangeRequest	33	0	1	\N
51	2023-08-03 06:32:31.554454	2023-08-03 06:32:31.554454	ResourceChangeRequest	34	0	1	\N
52	2023-08-03 06:32:31.576364	2023-08-03 06:32:31.576364	ResourceChangeRequest	34	0	1	\N
53	2023-08-03 06:32:31.62711	2023-08-03 06:32:31.62711	ResourceChangeRequest	35	0	1	\N
54	2023-08-03 06:32:31.678387	2023-08-03 06:32:31.678387	ResourceChangeRequest	36	0	1	\N
55	2023-08-03 06:32:31.721716	2023-08-03 06:32:31.721716	ResourceChangeRequest	37	0	1	\N
56	2023-08-03 06:32:31.774658	2023-08-03 06:32:31.774658	ResourceChangeRequest	38	0	1	\N
57	2023-08-03 06:32:31.823828	2023-08-03 06:32:31.823828	ResourceChangeRequest	39	0	1	\N
58	2023-08-03 06:32:31.874839	2023-08-03 06:32:31.874839	ResourceChangeRequest	40	0	1	\N
59	2023-08-03 06:32:31.922339	2023-08-03 06:32:31.922339	ResourceChangeRequest	41	0	1	\N
60	2023-08-03 06:32:31.969651	2023-08-03 06:32:31.969651	ResourceChangeRequest	42	0	1	\N
61	2023-08-03 06:32:31.997773	2023-08-03 06:32:31.997773	ResourceChangeRequest	42	0	1	\N
62	2023-08-03 06:32:32.040169	2023-08-03 06:32:32.040169	ResourceChangeRequest	43	0	1	\N
63	2023-08-03 06:32:32.088456	2023-08-03 06:32:32.088456	ResourceChangeRequest	44	0	1	\N
64	2023-08-03 06:32:32.135654	2023-08-03 06:32:32.135654	ResourceChangeRequest	45	0	1	\N
65	2023-08-03 06:32:32.155539	2023-08-03 06:32:32.155539	ResourceChangeRequest	45	0	1	\N
66	2023-08-03 06:32:32.202441	2023-08-03 06:32:32.202441	ResourceChangeRequest	46	0	1	\N
67	2023-08-03 06:32:32.247373	2023-08-03 06:32:32.247373	ResourceChangeRequest	47	0	1	\N
68	2023-08-03 06:32:32.275175	2023-08-03 06:32:32.275175	ResourceChangeRequest	47	0	1	\N
69	2023-08-03 06:32:32.319948	2023-08-03 06:32:32.319948	ResourceChangeRequest	48	0	1	\N
70	2023-08-03 06:32:32.368861	2023-08-03 06:32:32.368861	ResourceChangeRequest	49	0	1	\N
71	2023-08-03 06:32:32.420147	2023-08-03 06:32:32.420147	ResourceChangeRequest	50	0	1	\N
72	2023-08-03 06:32:32.473929	2023-08-03 06:32:32.473929	ResourceChangeRequest	51	0	1	\N
73	2023-08-03 06:32:32.497718	2023-08-03 06:32:32.497718	ResourceChangeRequest	51	0	1	\N
74	2023-08-03 06:32:32.544562	2023-08-03 06:32:32.544562	ResourceChangeRequest	52	0	1	\N
75	2023-08-03 06:32:32.57077	2023-08-03 06:32:32.57077	ResourceChangeRequest	52	0	1	\N
76	2023-08-03 06:32:32.61599	2023-08-03 06:32:32.61599	ResourceChangeRequest	53	0	1	\N
77	2023-08-03 06:32:32.640264	2023-08-03 06:32:32.640264	ResourceChangeRequest	53	0	1	\N
78	2023-08-03 06:32:32.685148	2023-08-03 06:32:32.685148	ResourceChangeRequest	54	0	1	\N
79	2023-08-03 06:32:32.735735	2023-08-03 06:32:32.735735	ResourceChangeRequest	55	0	1	\N
80	2023-08-03 06:32:32.758795	2023-08-03 06:32:32.758795	ResourceChangeRequest	55	0	1	\N
81	2023-08-03 06:32:32.813865	2023-08-03 06:32:32.813865	ResourceChangeRequest	56	0	1	\N
82	2023-08-03 06:32:32.840427	2023-08-03 06:32:32.840427	ResourceChangeRequest	56	0	1	\N
83	2023-08-03 06:32:32.892012	2023-08-03 06:32:32.892012	ResourceChangeRequest	57	0	1	\N
84	2023-08-03 06:32:32.937429	2023-08-03 06:32:32.937429	ResourceChangeRequest	58	0	1	\N
85	2023-08-03 06:32:32.963481	2023-08-03 06:32:32.963481	ResourceChangeRequest	58	0	1	\N
86	2023-08-03 06:32:33.004126	2023-08-03 06:32:33.004126	ResourceChangeRequest	59	0	1	\N
87	2023-08-03 06:32:33.027364	2023-08-03 06:32:33.027364	ResourceChangeRequest	59	0	1	\N
88	2023-08-03 06:32:33.06797	2023-08-03 06:32:33.06797	ResourceChangeRequest	60	0	1	\N
89	2023-08-03 06:32:33.093324	2023-08-03 06:32:33.093324	ResourceChangeRequest	60	0	1	\N
90	2023-08-03 06:32:33.149224	2023-08-03 06:32:33.149224	ResourceChangeRequest	61	0	1	\N
91	2023-08-03 06:32:33.179002	2023-08-03 06:32:33.179002	ResourceChangeRequest	61	0	1	\N
92	2023-08-03 06:32:33.230885	2023-08-03 06:32:33.230885	ResourceChangeRequest	62	0	1	\N
93	2023-08-03 06:32:33.262041	2023-08-03 06:32:33.262041	ResourceChangeRequest	62	0	1	\N
94	2023-08-03 06:32:33.307561	2023-08-03 06:32:33.307561	ResourceChangeRequest	63	0	1	\N
95	2023-08-03 06:32:33.358134	2023-08-03 06:32:33.358134	ResourceChangeRequest	64	0	1	\N
96	2023-08-03 06:32:33.377665	2023-08-03 06:32:33.377665	ResourceChangeRequest	64	0	1	\N
97	2023-08-03 06:32:33.426839	2023-08-03 06:32:33.426839	ResourceChangeRequest	65	0	1	\N
98	2023-08-03 06:32:33.453211	2023-08-03 06:32:33.453211	ResourceChangeRequest	65	0	1	\N
99	2023-08-03 06:32:33.510085	2023-08-03 06:32:33.510085	ResourceChangeRequest	66	0	1	\N
100	2023-08-03 06:32:33.563224	2023-08-03 06:32:33.563224	ResourceChangeRequest	67	0	1	\N
101	2023-08-03 06:32:33.612863	2023-08-03 06:32:33.612863	ResourceChangeRequest	68	0	1	\N
102	2023-08-03 06:32:33.639904	2023-08-03 06:32:33.639904	ResourceChangeRequest	68	0	1	\N
103	2023-08-03 06:32:33.692379	2023-08-03 06:32:33.692379	ResourceChangeRequest	69	0	1	\N
104	2023-08-03 06:32:33.748925	2023-08-03 06:32:33.748925	ResourceChangeRequest	70	0	1	\N
105	2023-08-03 06:32:33.77085	2023-08-03 06:32:33.77085	ResourceChangeRequest	70	0	1	\N
106	2023-08-03 06:32:33.824157	2023-08-03 06:32:33.824157	ResourceChangeRequest	71	0	1	\N
107	2023-08-03 06:32:33.847031	2023-08-03 06:32:33.847031	ResourceChangeRequest	71	0	1	\N
108	2023-08-03 06:32:33.897863	2023-08-03 06:32:33.897863	ResourceChangeRequest	72	0	1	\N
109	2023-08-03 06:32:33.946647	2023-08-03 06:32:33.946647	ResourceChangeRequest	73	0	1	\N
110	2023-08-03 06:32:33.97705	2023-08-03 06:32:33.97705	ResourceChangeRequest	73	0	1	\N
111	2023-08-03 06:32:34.027599	2023-08-03 06:32:34.027599	ResourceChangeRequest	74	0	1	\N
112	2023-08-03 06:32:34.054963	2023-08-03 06:32:34.054963	ResourceChangeRequest	74	0	1	\N
113	2023-08-03 06:32:34.103479	2023-08-03 06:32:34.103479	ResourceChangeRequest	75	0	1	\N
114	2023-08-03 06:32:34.131602	2023-08-03 06:32:34.131602	ResourceChangeRequest	75	0	1	\N
115	2023-08-03 06:32:34.184563	2023-08-03 06:32:34.184563	ResourceChangeRequest	76	0	1	\N
116	2023-08-03 06:32:34.237096	2023-08-03 06:32:34.237096	ResourceChangeRequest	77	0	1	\N
117	2023-08-03 06:32:34.291845	2023-08-03 06:32:34.291845	ResourceChangeRequest	78	0	1	\N
118	2023-08-03 06:32:34.314991	2023-08-03 06:32:34.314991	ResourceChangeRequest	78	0	1	\N
119	2023-08-03 06:32:34.366555	2023-08-03 06:32:34.366555	ResourceChangeRequest	79	0	1	\N
120	2023-08-03 06:32:34.394256	2023-08-03 06:32:34.394256	ResourceChangeRequest	79	0	1	\N
121	2023-08-03 06:32:34.440385	2023-08-03 06:32:34.440385	ResourceChangeRequest	80	0	1	\N
122	2023-08-03 06:32:34.466395	2023-08-03 06:32:34.466395	ResourceChangeRequest	80	0	1	\N
123	2023-08-03 06:32:34.515168	2023-08-03 06:32:34.515168	ResourceChangeRequest	81	0	1	\N
124	2023-08-03 06:32:34.567427	2023-08-03 06:32:34.567427	ResourceChangeRequest	82	0	1	\N
125	2023-08-03 06:32:34.595421	2023-08-03 06:32:34.595421	ResourceChangeRequest	82	0	1	\N
126	2023-08-03 06:32:34.642348	2023-08-03 06:32:34.642348	ResourceChangeRequest	83	0	1	\N
127	2023-08-03 06:32:34.701954	2023-08-03 06:32:34.701954	ResourceChangeRequest	84	0	1	\N
128	2023-08-03 06:32:34.759945	2023-08-03 06:32:34.759945	ResourceChangeRequest	85	0	1	\N
129	2023-08-03 06:32:34.81208	2023-08-03 06:32:34.81208	ResourceChangeRequest	86	0	1	\N
130	2023-08-03 06:32:34.834189	2023-08-03 06:32:34.834189	ResourceChangeRequest	86	0	1	\N
131	2023-08-03 06:32:34.903583	2023-08-03 06:32:34.903583	ResourceChangeRequest	87	0	1	\N
132	2023-08-03 06:32:35.008449	2023-08-03 06:32:35.008449	ResourceChangeRequest	88	0	1	\N
133	2023-08-03 06:32:35.042577	2023-08-03 06:32:35.042577	ResourceChangeRequest	88	0	1	\N
134	2023-08-03 06:32:35.094831	2023-08-03 06:32:35.094831	ResourceChangeRequest	89	0	1	\N
135	2023-08-03 06:32:35.139675	2023-08-03 06:32:35.139675	ResourceChangeRequest	90	0	1	\N
136	2023-08-03 06:32:35.167393	2023-08-03 06:32:35.167393	ResourceChangeRequest	90	0	1	\N
137	2023-08-03 06:32:35.240838	2023-08-03 06:32:35.240838	ResourceChangeRequest	91	0	1	\N
138	2023-08-03 06:32:35.265985	2023-08-03 06:32:35.265985	ResourceChangeRequest	91	0	1	\N
139	2023-08-03 06:32:35.332056	2023-08-03 06:32:35.332056	ResourceChangeRequest	92	0	1	\N
140	2023-08-03 06:32:35.414235	2023-08-03 06:32:35.414235	ResourceChangeRequest	93	0	1	\N
141	2023-08-03 06:32:35.481749	2023-08-03 06:32:35.481749	ResourceChangeRequest	94	0	1	\N
142	2023-08-03 06:32:35.516335	2023-08-03 06:32:35.516335	ResourceChangeRequest	94	0	1	\N
143	2023-08-03 06:32:35.568269	2023-08-03 06:32:35.568269	ResourceChangeRequest	95	0	1	\N
144	2023-08-03 06:32:35.614132	2023-08-03 06:32:35.614132	ResourceChangeRequest	96	0	1	\N
145	2023-08-03 06:32:35.675331	2023-08-03 06:32:35.675331	ResourceChangeRequest	97	0	1	\N
146	2023-08-03 06:32:35.705066	2023-08-03 06:32:35.705066	ResourceChangeRequest	97	0	1	\N
147	2023-08-03 06:32:35.754448	2023-08-03 06:32:35.754448	ResourceChangeRequest	98	0	1	\N
148	2023-08-03 06:32:35.797338	2023-08-03 06:32:35.797338	ResourceChangeRequest	99	0	1	\N
149	2023-08-03 06:32:35.825142	2023-08-03 06:32:35.825142	ResourceChangeRequest	99	0	1	\N
150	2023-08-03 06:32:35.878888	2023-08-03 06:32:35.878888	ResourceChangeRequest	100	0	1	\N
151	2023-08-03 06:32:35.92147	2023-08-03 06:32:35.92147	ResourceChangeRequest	101	0	1	\N
152	2023-08-03 06:32:35.970977	2023-08-03 06:32:35.970977	ResourceChangeRequest	102	0	1	\N
153	2023-08-03 06:32:35.995362	2023-08-03 06:32:35.995362	ResourceChangeRequest	102	0	1	\N
154	2023-08-03 06:32:36.045574	2023-08-03 06:32:36.045574	ResourceChangeRequest	103	0	1	\N
155	2023-08-03 06:32:36.093956	2023-08-03 06:32:36.093956	ResourceChangeRequest	104	0	1	\N
156	2023-08-03 06:32:36.160775	2023-08-03 06:32:36.160775	ResourceChangeRequest	105	0	1	\N
157	2023-08-03 06:32:36.208508	2023-08-03 06:32:36.208508	ResourceChangeRequest	106	0	1	\N
158	2023-08-03 06:32:36.259984	2023-08-03 06:32:36.259984	ResourceChangeRequest	107	0	1	\N
159	2023-08-03 06:32:36.307438	2023-08-03 06:32:36.307438	ResourceChangeRequest	108	0	1	\N
160	2023-08-03 06:32:36.356139	2023-08-03 06:32:36.356139	ResourceChangeRequest	109	0	1	\N
161	2023-08-03 06:32:36.397032	2023-08-03 06:32:36.397032	ResourceChangeRequest	110	0	1	\N
162	2023-08-03 06:32:36.421875	2023-08-03 06:32:36.421875	ResourceChangeRequest	110	0	1	\N
163	2023-08-03 06:32:36.468903	2023-08-03 06:32:36.468903	ResourceChangeRequest	111	0	1	\N
164	2023-08-03 06:32:36.546399	2023-08-03 06:32:36.546399	ResourceChangeRequest	112	0	1	\N
165	2023-08-03 06:32:36.586585	2023-08-03 06:32:36.586585	ResourceChangeRequest	112	0	1	\N
166	2023-08-03 06:32:36.645022	2023-08-03 06:32:36.645022	ResourceChangeRequest	113	0	1	\N
167	2023-08-03 06:32:36.695709	2023-08-03 06:32:36.695709	ResourceChangeRequest	114	0	1	\N
168	2023-08-03 06:32:36.754358	2023-08-03 06:32:36.754358	ResourceChangeRequest	115	0	1	\N
169	2023-08-03 06:32:36.814694	2023-08-03 06:32:36.814694	ResourceChangeRequest	116	0	1	\N
170	2023-08-03 06:32:36.868919	2023-08-03 06:32:36.868919	ResourceChangeRequest	117	0	1	\N
171	2023-08-03 06:32:36.923846	2023-08-03 06:32:36.923846	ResourceChangeRequest	118	0	1	\N
172	2023-08-03 06:32:36.980536	2023-08-03 06:32:36.980536	ResourceChangeRequest	119	0	1	\N
173	2023-08-03 06:32:37.040516	2023-08-03 06:32:37.040516	ResourceChangeRequest	120	0	1	\N
174	2023-08-03 06:32:37.102957	2023-08-03 06:32:37.102957	ResourceChangeRequest	121	0	1	\N
175	2023-08-03 06:32:37.135935	2023-08-03 06:32:37.135935	ResourceChangeRequest	121	0	1	\N
176	2023-08-03 06:32:37.195556	2023-08-03 06:32:37.195556	ResourceChangeRequest	122	0	1	\N
177	2023-08-03 06:32:37.228154	2023-08-03 06:32:37.228154	ResourceChangeRequest	122	0	1	\N
178	2023-08-03 06:32:37.283794	2023-08-03 06:32:37.283794	ResourceChangeRequest	123	0	1	\N
179	2023-08-03 06:32:37.311415	2023-08-03 06:32:37.311415	ResourceChangeRequest	123	0	1	\N
180	2023-08-03 06:32:37.362053	2023-08-03 06:32:37.362053	ResourceChangeRequest	124	0	1	\N
181	2023-08-03 06:32:37.385723	2023-08-03 06:32:37.385723	ResourceChangeRequest	124	0	1	\N
182	2023-08-03 06:32:37.433784	2023-08-03 06:32:37.433784	ResourceChangeRequest	125	0	1	\N
183	2023-08-03 06:32:37.48548	2023-08-03 06:32:37.48548	ResourceChangeRequest	126	0	1	\N
184	2023-08-03 06:32:37.53342	2023-08-03 06:32:37.53342	ResourceChangeRequest	127	0	1	\N
185	2023-08-03 06:32:37.582183	2023-08-03 06:32:37.582183	ResourceChangeRequest	128	0	1	\N
186	2023-08-03 06:32:37.633439	2023-08-03 06:32:37.633439	ResourceChangeRequest	129	0	1	\N
187	2023-08-03 06:32:37.662246	2023-08-03 06:32:37.662246	ResourceChangeRequest	129	0	1	\N
188	2023-08-03 06:32:37.710092	2023-08-03 06:32:37.710092	ResourceChangeRequest	130	0	1	\N
189	2023-08-03 06:32:37.754084	2023-08-03 06:32:37.754084	ResourceChangeRequest	131	0	1	\N
190	2023-08-03 06:32:37.802439	2023-08-03 06:32:37.802439	ResourceChangeRequest	132	0	1	\N
191	2023-08-03 06:32:37.849382	2023-08-03 06:32:37.849382	ResourceChangeRequest	133	0	1	\N
192	2023-08-03 06:32:37.872368	2023-08-03 06:32:37.872368	ResourceChangeRequest	133	0	1	\N
193	2023-08-03 06:32:37.914213	2023-08-03 06:32:37.914213	ResourceChangeRequest	134	0	1	\N
194	2023-08-03 06:32:37.9402	2023-08-03 06:32:37.9402	ResourceChangeRequest	134	0	1	\N
195	2023-08-03 06:32:37.99045	2023-08-03 06:32:37.99045	ResourceChangeRequest	135	0	1	\N
196	2023-08-03 06:32:38.039776	2023-08-03 06:32:38.039776	ResourceChangeRequest	136	0	1	\N
197	2023-08-03 06:32:38.118276	2023-08-03 06:32:38.118276	ResourceChangeRequest	137	0	1	\N
198	2023-08-03 06:32:38.159173	2023-08-03 06:32:38.159173	ResourceChangeRequest	137	0	1	\N
199	2023-08-03 06:32:38.208839	2023-08-03 06:32:38.208839	ResourceChangeRequest	138	0	1	\N
200	2023-08-03 06:32:38.23668	2023-08-03 06:32:38.23668	ResourceChangeRequest	138	0	1	\N
201	2023-08-03 06:32:38.289626	2023-08-03 06:32:38.289626	ResourceChangeRequest	139	0	1	\N
202	2023-08-03 06:32:38.3197	2023-08-03 06:32:38.3197	ResourceChangeRequest	139	0	1	\N
203	2023-08-03 06:32:38.368692	2023-08-03 06:32:38.368692	ResourceChangeRequest	140	0	1	\N
204	2023-08-03 06:32:38.417436	2023-08-03 06:32:38.417436	ResourceChangeRequest	141	0	1	\N
205	2023-08-03 06:32:38.4682	2023-08-03 06:32:38.4682	ResourceChangeRequest	142	0	1	\N
206	2023-08-03 06:32:38.496291	2023-08-03 06:32:38.496291	ResourceChangeRequest	142	0	1	\N
207	2023-08-03 06:32:38.54603	2023-08-03 06:32:38.54603	ResourceChangeRequest	143	0	1	\N
208	2023-08-03 06:32:38.595527	2023-08-03 06:32:38.595527	ResourceChangeRequest	144	0	1	\N
209	2023-08-03 06:32:38.648608	2023-08-03 06:32:38.648608	ResourceChangeRequest	145	0	1	\N
210	2023-08-03 06:32:38.698242	2023-08-03 06:32:38.698242	ResourceChangeRequest	146	0	1	\N
211	2023-08-03 06:32:38.723415	2023-08-03 06:32:38.723415	ResourceChangeRequest	146	0	1	\N
212	2023-08-03 06:32:38.766795	2023-08-03 06:32:38.766795	ResourceChangeRequest	147	0	1	\N
213	2023-08-03 06:32:38.791685	2023-08-03 06:32:38.791685	ResourceChangeRequest	147	0	1	\N
214	2023-08-03 06:32:38.840091	2023-08-03 06:32:38.840091	ResourceChangeRequest	148	0	1	\N
215	2023-08-03 06:32:38.887182	2023-08-03 06:32:38.887182	ResourceChangeRequest	149	0	1	\N
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contacts (id, name, title, email, created_at, updated_at, resource_id, service_id) FROM stdin;
\.


--
-- Data for Name: delayed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.delayed_jobs (id, priority, attempts, handler, last_error, run_at, locked_at, failed_at, locked_by, queue, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documents (id, name, url, description, created_at, updated_at) FROM stdin;
1	1	document_url	Some document	2023-08-03 06:32:29.517774	2023-08-03 06:32:29.517774
2	2	document_url	Some document	2023-08-03 06:32:29.585682	2023-08-03 06:32:29.585682
3	3	document_url	Some document	2023-08-03 06:32:29.634173	2023-08-03 06:32:29.634173
4	4	document_url	Some document	2023-08-03 06:32:29.665587	2023-08-03 06:32:29.665587
5	5	document_url	Some document	2023-08-03 06:32:29.71095	2023-08-03 06:32:29.71095
6	6	document_url	Some document	2023-08-03 06:32:29.736365	2023-08-03 06:32:29.736365
7	7	document_url	Some document	2023-08-03 06:32:29.786307	2023-08-03 06:32:29.786307
8	8	document_url	Some document	2023-08-03 06:32:29.843929	2023-08-03 06:32:29.843929
9	9	document_url	Some document	2023-08-03 06:32:29.867049	2023-08-03 06:32:29.867049
10	10	document_url	Some document	2023-08-03 06:32:29.916937	2023-08-03 06:32:29.916937
11	11	document_url	Some document	2023-08-03 06:32:29.941847	2023-08-03 06:32:29.941847
12	12	document_url	Some document	2023-08-03 06:32:29.99558	2023-08-03 06:32:29.99558
13	13	document_url	Some document	2023-08-03 06:32:30.022414	2023-08-03 06:32:30.022414
14	14	document_url	Some document	2023-08-03 06:32:30.064884	2023-08-03 06:32:30.064884
15	15	document_url	Some document	2023-08-03 06:32:30.089512	2023-08-03 06:32:30.089512
16	16	document_url	Some document	2023-08-03 06:32:30.129929	2023-08-03 06:32:30.129929
17	17	document_url	Some document	2023-08-03 06:32:30.179852	2023-08-03 06:32:30.179852
18	18	document_url	Some document	2023-08-03 06:32:30.233705	2023-08-03 06:32:30.233705
19	19	document_url	Some document	2023-08-03 06:32:30.257319	2023-08-03 06:32:30.257319
20	20	document_url	Some document	2023-08-03 06:32:30.296807	2023-08-03 06:32:30.296807
21	21	document_url	Some document	2023-08-03 06:32:30.318919	2023-08-03 06:32:30.318919
22	22	document_url	Some document	2023-08-03 06:32:30.364749	2023-08-03 06:32:30.364749
23	23	document_url	Some document	2023-08-03 06:32:30.389056	2023-08-03 06:32:30.389056
24	24	document_url	Some document	2023-08-03 06:32:30.436439	2023-08-03 06:32:30.436439
25	25	document_url	Some document	2023-08-03 06:32:30.476862	2023-08-03 06:32:30.476862
26	26	document_url	Some document	2023-08-03 06:32:30.52194	2023-08-03 06:32:30.52194
27	27	document_url	Some document	2023-08-03 06:32:30.563997	2023-08-03 06:32:30.563997
28	28	document_url	Some document	2023-08-03 06:32:30.592388	2023-08-03 06:32:30.592388
29	29	document_url	Some document	2023-08-03 06:32:30.651745	2023-08-03 06:32:30.651745
30	30	document_url	Some document	2023-08-03 06:32:30.676212	2023-08-03 06:32:30.676212
31	31	document_url	Some document	2023-08-03 06:32:30.719308	2023-08-03 06:32:30.719308
32	32	document_url	Some document	2023-08-03 06:32:30.766031	2023-08-03 06:32:30.766031
33	33	document_url	Some document	2023-08-03 06:32:30.788287	2023-08-03 06:32:30.788287
34	34	document_url	Some document	2023-08-03 06:32:30.830285	2023-08-03 06:32:30.830285
35	35	document_url	Some document	2023-08-03 06:32:30.875443	2023-08-03 06:32:30.875443
36	36	document_url	Some document	2023-08-03 06:32:30.897393	2023-08-03 06:32:30.897393
37	37	document_url	Some document	2023-08-03 06:32:30.940967	2023-08-03 06:32:30.940967
38	38	document_url	Some document	2023-08-03 06:32:30.968378	2023-08-03 06:32:30.968378
39	39	document_url	Some document	2023-08-03 06:32:31.013235	2023-08-03 06:32:31.013235
40	40	document_url	Some document	2023-08-03 06:32:31.03947	2023-08-03 06:32:31.03947
41	41	document_url	Some document	2023-08-03 06:32:31.094105	2023-08-03 06:32:31.094105
42	42	document_url	Some document	2023-08-03 06:32:31.145991	2023-08-03 06:32:31.145991
43	43	document_url	Some document	2023-08-03 06:32:31.198091	2023-08-03 06:32:31.198091
44	44	document_url	Some document	2023-08-03 06:32:31.244784	2023-08-03 06:32:31.244784
45	45	document_url	Some document	2023-08-03 06:32:31.29159	2023-08-03 06:32:31.29159
46	46	document_url	Some document	2023-08-03 06:32:31.336476	2023-08-03 06:32:31.336476
47	47	document_url	Some document	2023-08-03 06:32:31.381233	2023-08-03 06:32:31.381233
48	48	document_url	Some document	2023-08-03 06:32:31.409013	2023-08-03 06:32:31.409013
49	49	document_url	Some document	2023-08-03 06:32:31.455735	2023-08-03 06:32:31.455735
50	50	document_url	Some document	2023-08-03 06:32:31.502732	2023-08-03 06:32:31.502732
51	51	document_url	Some document	2023-08-03 06:32:31.549925	2023-08-03 06:32:31.549925
52	52	document_url	Some document	2023-08-03 06:32:31.571975	2023-08-03 06:32:31.571975
53	53	document_url	Some document	2023-08-03 06:32:31.622789	2023-08-03 06:32:31.622789
54	54	document_url	Some document	2023-08-03 06:32:31.673974	2023-08-03 06:32:31.673974
55	55	document_url	Some document	2023-08-03 06:32:31.717452	2023-08-03 06:32:31.717452
56	56	document_url	Some document	2023-08-03 06:32:31.770115	2023-08-03 06:32:31.770115
57	57	document_url	Some document	2023-08-03 06:32:31.819472	2023-08-03 06:32:31.819472
58	58	document_url	Some document	2023-08-03 06:32:31.87028	2023-08-03 06:32:31.87028
59	59	document_url	Some document	2023-08-03 06:32:31.917972	2023-08-03 06:32:31.917972
60	60	document_url	Some document	2023-08-03 06:32:31.965426	2023-08-03 06:32:31.965426
61	61	document_url	Some document	2023-08-03 06:32:31.993513	2023-08-03 06:32:31.993513
62	62	document_url	Some document	2023-08-03 06:32:32.035731	2023-08-03 06:32:32.035731
63	63	document_url	Some document	2023-08-03 06:32:32.083876	2023-08-03 06:32:32.083876
64	64	document_url	Some document	2023-08-03 06:32:32.131091	2023-08-03 06:32:32.131091
65	65	document_url	Some document	2023-08-03 06:32:32.151252	2023-08-03 06:32:32.151252
66	66	document_url	Some document	2023-08-03 06:32:32.197997	2023-08-03 06:32:32.197997
67	67	document_url	Some document	2023-08-03 06:32:32.242718	2023-08-03 06:32:32.242718
68	68	document_url	Some document	2023-08-03 06:32:32.270771	2023-08-03 06:32:32.270771
69	69	document_url	Some document	2023-08-03 06:32:32.315615	2023-08-03 06:32:32.315615
70	70	document_url	Some document	2023-08-03 06:32:32.364548	2023-08-03 06:32:32.364548
71	71	document_url	Some document	2023-08-03 06:32:32.415819	2023-08-03 06:32:32.415819
72	72	document_url	Some document	2023-08-03 06:32:32.46956	2023-08-03 06:32:32.46956
73	73	document_url	Some document	2023-08-03 06:32:32.493285	2023-08-03 06:32:32.493285
74	74	document_url	Some document	2023-08-03 06:32:32.539342	2023-08-03 06:32:32.539342
75	75	document_url	Some document	2023-08-03 06:32:32.565851	2023-08-03 06:32:32.565851
76	76	document_url	Some document	2023-08-03 06:32:32.611579	2023-08-03 06:32:32.611579
77	77	document_url	Some document	2023-08-03 06:32:32.636006	2023-08-03 06:32:32.636006
78	78	document_url	Some document	2023-08-03 06:32:32.680935	2023-08-03 06:32:32.680935
79	79	document_url	Some document	2023-08-03 06:32:32.731313	2023-08-03 06:32:32.731313
80	80	document_url	Some document	2023-08-03 06:32:32.754158	2023-08-03 06:32:32.754158
81	81	document_url	Some document	2023-08-03 06:32:32.809304	2023-08-03 06:32:32.809304
82	82	document_url	Some document	2023-08-03 06:32:32.836141	2023-08-03 06:32:32.836141
83	83	document_url	Some document	2023-08-03 06:32:32.887633	2023-08-03 06:32:32.887633
84	84	document_url	Some document	2023-08-03 06:32:32.932944	2023-08-03 06:32:32.932944
85	85	document_url	Some document	2023-08-03 06:32:32.958956	2023-08-03 06:32:32.958956
86	86	document_url	Some document	2023-08-03 06:32:32.999643	2023-08-03 06:32:32.999643
87	87	document_url	Some document	2023-08-03 06:32:33.022709	2023-08-03 06:32:33.022709
88	88	document_url	Some document	2023-08-03 06:32:33.063566	2023-08-03 06:32:33.063566
89	89	document_url	Some document	2023-08-03 06:32:33.088351	2023-08-03 06:32:33.088351
90	90	document_url	Some document	2023-08-03 06:32:33.144093	2023-08-03 06:32:33.144093
91	91	document_url	Some document	2023-08-03 06:32:33.174166	2023-08-03 06:32:33.174166
92	92	document_url	Some document	2023-08-03 06:32:33.226255	2023-08-03 06:32:33.226255
93	93	document_url	Some document	2023-08-03 06:32:33.256977	2023-08-03 06:32:33.256977
94	94	document_url	Some document	2023-08-03 06:32:33.3029	2023-08-03 06:32:33.3029
95	95	document_url	Some document	2023-08-03 06:32:33.352949	2023-08-03 06:32:33.352949
96	96	document_url	Some document	2023-08-03 06:32:33.372632	2023-08-03 06:32:33.372632
97	97	document_url	Some document	2023-08-03 06:32:33.422082	2023-08-03 06:32:33.422082
98	98	document_url	Some document	2023-08-03 06:32:33.448603	2023-08-03 06:32:33.448603
99	99	document_url	Some document	2023-08-03 06:32:33.504868	2023-08-03 06:32:33.504868
100	100	document_url	Some document	2023-08-03 06:32:33.558749	2023-08-03 06:32:33.558749
101	101	document_url	Some document	2023-08-03 06:32:33.608198	2023-08-03 06:32:33.608198
102	102	document_url	Some document	2023-08-03 06:32:33.635272	2023-08-03 06:32:33.635272
103	103	document_url	Some document	2023-08-03 06:32:33.685393	2023-08-03 06:32:33.685393
104	104	document_url	Some document	2023-08-03 06:32:33.744209	2023-08-03 06:32:33.744209
105	105	document_url	Some document	2023-08-03 06:32:33.766551	2023-08-03 06:32:33.766551
106	106	document_url	Some document	2023-08-03 06:32:33.819692	2023-08-03 06:32:33.819692
107	107	document_url	Some document	2023-08-03 06:32:33.842708	2023-08-03 06:32:33.842708
108	108	document_url	Some document	2023-08-03 06:32:33.893574	2023-08-03 06:32:33.893574
109	109	document_url	Some document	2023-08-03 06:32:33.941977	2023-08-03 06:32:33.941977
110	110	document_url	Some document	2023-08-03 06:32:33.972266	2023-08-03 06:32:33.972266
111	111	document_url	Some document	2023-08-03 06:32:34.023188	2023-08-03 06:32:34.023188
112	112	document_url	Some document	2023-08-03 06:32:34.050568	2023-08-03 06:32:34.050568
113	113	document_url	Some document	2023-08-03 06:32:34.098766	2023-08-03 06:32:34.098766
114	114	document_url	Some document	2023-08-03 06:32:34.126005	2023-08-03 06:32:34.126005
115	115	document_url	Some document	2023-08-03 06:32:34.17976	2023-08-03 06:32:34.17976
116	116	document_url	Some document	2023-08-03 06:32:34.232498	2023-08-03 06:32:34.232498
117	117	document_url	Some document	2023-08-03 06:32:34.287645	2023-08-03 06:32:34.287645
118	118	document_url	Some document	2023-08-03 06:32:34.310495	2023-08-03 06:32:34.310495
119	119	document_url	Some document	2023-08-03 06:32:34.362045	2023-08-03 06:32:34.362045
120	120	document_url	Some document	2023-08-03 06:32:34.389873	2023-08-03 06:32:34.389873
121	121	document_url	Some document	2023-08-03 06:32:34.43583	2023-08-03 06:32:34.43583
122	122	document_url	Some document	2023-08-03 06:32:34.461879	2023-08-03 06:32:34.461879
123	123	document_url	Some document	2023-08-03 06:32:34.510259	2023-08-03 06:32:34.510259
124	124	document_url	Some document	2023-08-03 06:32:34.562814	2023-08-03 06:32:34.562814
125	125	document_url	Some document	2023-08-03 06:32:34.590843	2023-08-03 06:32:34.590843
126	126	document_url	Some document	2023-08-03 06:32:34.637584	2023-08-03 06:32:34.637584
127	127	document_url	Some document	2023-08-03 06:32:34.697217	2023-08-03 06:32:34.697217
128	128	document_url	Some document	2023-08-03 06:32:34.754194	2023-08-03 06:32:34.754194
129	129	document_url	Some document	2023-08-03 06:32:34.807236	2023-08-03 06:32:34.807236
130	130	document_url	Some document	2023-08-03 06:32:34.829726	2023-08-03 06:32:34.829726
131	131	document_url	Some document	2023-08-03 06:32:34.897646	2023-08-03 06:32:34.897646
132	132	document_url	Some document	2023-08-03 06:32:35.001762	2023-08-03 06:32:35.001762
133	133	document_url	Some document	2023-08-03 06:32:35.037101	2023-08-03 06:32:35.037101
134	134	document_url	Some document	2023-08-03 06:32:35.090345	2023-08-03 06:32:35.090345
135	135	document_url	Some document	2023-08-03 06:32:35.135067	2023-08-03 06:32:35.135067
136	136	document_url	Some document	2023-08-03 06:32:35.161657	2023-08-03 06:32:35.161657
137	137	document_url	Some document	2023-08-03 06:32:35.23584	2023-08-03 06:32:35.23584
138	138	document_url	Some document	2023-08-03 06:32:35.261278	2023-08-03 06:32:35.261278
139	139	document_url	Some document	2023-08-03 06:32:35.325914	2023-08-03 06:32:35.325914
140	140	document_url	Some document	2023-08-03 06:32:35.408247	2023-08-03 06:32:35.408247
141	141	document_url	Some document	2023-08-03 06:32:35.476392	2023-08-03 06:32:35.476392
142	142	document_url	Some document	2023-08-03 06:32:35.51098	2023-08-03 06:32:35.51098
143	143	document_url	Some document	2023-08-03 06:32:35.563681	2023-08-03 06:32:35.563681
144	144	document_url	Some document	2023-08-03 06:32:35.609192	2023-08-03 06:32:35.609192
145	145	document_url	Some document	2023-08-03 06:32:35.670429	2023-08-03 06:32:35.670429
146	146	document_url	Some document	2023-08-03 06:32:35.700179	2023-08-03 06:32:35.700179
147	147	document_url	Some document	2023-08-03 06:32:35.749728	2023-08-03 06:32:35.749728
148	148	document_url	Some document	2023-08-03 06:32:35.792789	2023-08-03 06:32:35.792789
149	149	document_url	Some document	2023-08-03 06:32:35.817365	2023-08-03 06:32:35.817365
150	150	document_url	Some document	2023-08-03 06:32:35.874503	2023-08-03 06:32:35.874503
151	151	document_url	Some document	2023-08-03 06:32:35.916907	2023-08-03 06:32:35.916907
152	152	document_url	Some document	2023-08-03 06:32:35.9664	2023-08-03 06:32:35.9664
153	153	document_url	Some document	2023-08-03 06:32:35.990943	2023-08-03 06:32:35.990943
154	154	document_url	Some document	2023-08-03 06:32:36.041172	2023-08-03 06:32:36.041172
155	155	document_url	Some document	2023-08-03 06:32:36.08958	2023-08-03 06:32:36.08958
156	156	document_url	Some document	2023-08-03 06:32:36.154368	2023-08-03 06:32:36.154368
157	157	document_url	Some document	2023-08-03 06:32:36.204032	2023-08-03 06:32:36.204032
158	158	document_url	Some document	2023-08-03 06:32:36.255219	2023-08-03 06:32:36.255219
159	159	document_url	Some document	2023-08-03 06:32:36.302609	2023-08-03 06:32:36.302609
160	160	document_url	Some document	2023-08-03 06:32:36.351761	2023-08-03 06:32:36.351761
161	161	document_url	Some document	2023-08-03 06:32:36.392538	2023-08-03 06:32:36.392538
162	162	document_url	Some document	2023-08-03 06:32:36.417177	2023-08-03 06:32:36.417177
163	163	document_url	Some document	2023-08-03 06:32:36.464318	2023-08-03 06:32:36.464318
164	164	document_url	Some document	2023-08-03 06:32:36.540546	2023-08-03 06:32:36.540546
165	165	document_url	Some document	2023-08-03 06:32:36.579633	2023-08-03 06:32:36.579633
166	166	document_url	Some document	2023-08-03 06:32:36.640523	2023-08-03 06:32:36.640523
167	167	document_url	Some document	2023-08-03 06:32:36.691127	2023-08-03 06:32:36.691127
168	168	document_url	Some document	2023-08-03 06:32:36.748808	2023-08-03 06:32:36.748808
169	169	document_url	Some document	2023-08-03 06:32:36.80948	2023-08-03 06:32:36.80948
170	170	document_url	Some document	2023-08-03 06:32:36.861252	2023-08-03 06:32:36.861252
171	171	document_url	Some document	2023-08-03 06:32:36.917841	2023-08-03 06:32:36.917841
172	172	document_url	Some document	2023-08-03 06:32:36.973202	2023-08-03 06:32:36.973202
173	173	document_url	Some document	2023-08-03 06:32:37.03501	2023-08-03 06:32:37.03501
174	174	document_url	Some document	2023-08-03 06:32:37.096864	2023-08-03 06:32:37.096864
175	175	document_url	Some document	2023-08-03 06:32:37.129402	2023-08-03 06:32:37.129402
176	176	document_url	Some document	2023-08-03 06:32:37.190618	2023-08-03 06:32:37.190618
177	177	document_url	Some document	2023-08-03 06:32:37.223234	2023-08-03 06:32:37.223234
178	178	document_url	Some document	2023-08-03 06:32:37.279041	2023-08-03 06:32:37.279041
179	179	document_url	Some document	2023-08-03 06:32:37.306323	2023-08-03 06:32:37.306323
180	180	document_url	Some document	2023-08-03 06:32:37.357172	2023-08-03 06:32:37.357172
181	181	document_url	Some document	2023-08-03 06:32:37.380907	2023-08-03 06:32:37.380907
182	182	document_url	Some document	2023-08-03 06:32:37.429295	2023-08-03 06:32:37.429295
183	183	document_url	Some document	2023-08-03 06:32:37.481112	2023-08-03 06:32:37.481112
184	184	document_url	Some document	2023-08-03 06:32:37.528976	2023-08-03 06:32:37.528976
185	185	document_url	Some document	2023-08-03 06:32:37.577516	2023-08-03 06:32:37.577516
186	186	document_url	Some document	2023-08-03 06:32:37.62903	2023-08-03 06:32:37.62903
187	187	document_url	Some document	2023-08-03 06:32:37.657215	2023-08-03 06:32:37.657215
188	188	document_url	Some document	2023-08-03 06:32:37.705666	2023-08-03 06:32:37.705666
189	189	document_url	Some document	2023-08-03 06:32:37.749748	2023-08-03 06:32:37.749748
190	190	document_url	Some document	2023-08-03 06:32:37.797789	2023-08-03 06:32:37.797789
191	191	document_url	Some document	2023-08-03 06:32:37.845119	2023-08-03 06:32:37.845119
192	192	document_url	Some document	2023-08-03 06:32:37.866708	2023-08-03 06:32:37.866708
193	193	document_url	Some document	2023-08-03 06:32:37.909883	2023-08-03 06:32:37.909883
194	194	document_url	Some document	2023-08-03 06:32:37.935977	2023-08-03 06:32:37.935977
195	195	document_url	Some document	2023-08-03 06:32:37.985983	2023-08-03 06:32:37.985983
196	196	document_url	Some document	2023-08-03 06:32:38.034041	2023-08-03 06:32:38.034041
197	197	document_url	Some document	2023-08-03 06:32:38.112965	2023-08-03 06:32:38.112965
198	198	document_url	Some document	2023-08-03 06:32:38.154033	2023-08-03 06:32:38.154033
199	199	document_url	Some document	2023-08-03 06:32:38.204332	2023-08-03 06:32:38.204332
200	200	document_url	Some document	2023-08-03 06:32:38.232194	2023-08-03 06:32:38.232194
201	201	document_url	Some document	2023-08-03 06:32:38.284863	2023-08-03 06:32:38.284863
202	202	document_url	Some document	2023-08-03 06:32:38.314911	2023-08-03 06:32:38.314911
203	203	document_url	Some document	2023-08-03 06:32:38.364124	2023-08-03 06:32:38.364124
204	204	document_url	Some document	2023-08-03 06:32:38.412775	2023-08-03 06:32:38.412775
205	205	document_url	Some document	2023-08-03 06:32:38.463538	2023-08-03 06:32:38.463538
206	206	document_url	Some document	2023-08-03 06:32:38.491686	2023-08-03 06:32:38.491686
207	207	document_url	Some document	2023-08-03 06:32:38.541502	2023-08-03 06:32:38.541502
208	208	document_url	Some document	2023-08-03 06:32:38.590427	2023-08-03 06:32:38.590427
209	209	document_url	Some document	2023-08-03 06:32:38.643955	2023-08-03 06:32:38.643955
210	210	document_url	Some document	2023-08-03 06:32:38.693529	2023-08-03 06:32:38.693529
211	211	document_url	Some document	2023-08-03 06:32:38.718853	2023-08-03 06:32:38.718853
212	212	document_url	Some document	2023-08-03 06:32:38.762545	2023-08-03 06:32:38.762545
213	213	document_url	Some document	2023-08-03 06:32:38.787293	2023-08-03 06:32:38.787293
214	214	document_url	Some document	2023-08-03 06:32:38.835256	2023-08-03 06:32:38.835256
\.


--
-- Data for Name: documents_services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documents_services (service_id, document_id) FROM stdin;
1	1
2	2
3	3
4	4
5	5
6	6
7	7
8	8
9	9
10	10
11	11
12	12
13	13
14	14
15	15
16	16
17	17
18	18
19	19
20	20
21	21
22	22
23	23
24	24
25	25
26	26
27	27
28	28
29	29
30	30
31	31
32	32
33	33
34	34
35	35
36	36
37	37
38	38
39	39
40	40
41	41
42	42
43	43
44	44
45	45
46	46
47	47
48	48
49	49
50	50
51	51
52	52
53	53
54	54
55	55
56	56
57	57
58	58
59	59
60	60
61	61
62	62
63	63
64	64
65	65
66	66
67	67
68	68
69	69
70	70
71	71
72	72
73	73
74	74
75	75
76	76
77	77
78	78
79	79
80	80
81	81
82	82
83	83
84	84
85	85
86	86
87	87
88	88
89	89
90	90
91	91
92	92
93	93
94	94
95	95
96	96
97	97
98	98
99	99
100	100
101	101
102	102
103	103
104	104
105	105
106	106
107	107
108	108
109	109
110	110
111	111
112	112
113	113
114	114
115	115
116	116
117	117
118	118
119	119
120	120
121	121
122	122
123	123
124	124
125	125
126	126
127	127
128	128
129	129
130	130
131	131
132	132
133	133
134	134
135	135
136	136
137	137
138	138
139	139
140	140
141	141
142	142
143	143
144	144
145	145
146	146
147	147
148	148
149	149
150	150
151	151
152	152
153	153
154	154
155	155
156	156
157	157
158	158
159	159
160	160
161	161
162	162
163	163
164	164
165	165
166	166
167	167
168	168
169	169
170	170
171	171
172	172
173	173
174	174
175	175
176	176
177	177
178	178
179	179
180	180
181	181
182	182
183	183
184	184
185	185
186	186
187	187
188	188
189	189
190	190
191	191
192	192
193	193
194	194
195	195
196	196
197	197
198	198
199	199
200	200
201	201
202	202
203	203
204	204
205	205
206	206
207	207
208	208
209	209
210	210
211	211
212	212
213	213
214	214
\.


--
-- Data for Name: eligibilities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eligibilities (id, name, created_at, updated_at, feature_rank, is_parent) FROM stdin;
1	Seniors (55+ years old)	2023-08-03 06:32:38.894888	2023-08-03 06:32:38.894888	1	f
2	Veterans	2023-08-03 06:32:38.963359	2023-08-03 06:32:38.963359	2	f
3	Families	2023-08-03 06:32:38.995249	2023-08-03 06:32:38.995249	3	f
4	Transition Aged Youth	2023-08-03 06:32:39.015926	2023-08-03 06:32:39.015926	4	f
5	Re-Entry	2023-08-03 06:32:39.060886	2023-08-03 06:32:39.060886	5	f
6	Immigrants	2023-08-03 06:32:39.094073	2023-08-03 06:32:39.094073	6	f
8	Near Homeless	2023-08-03 06:32:39.121571	2023-08-03 06:32:39.121571	\N	f
9	LGBTQ	2023-08-03 06:32:39.132762	2023-08-03 06:32:39.132762	\N	f
10	Alzheimers	2023-08-03 06:32:39.143835	2023-08-03 06:32:39.143835	\N	f
13	Low-Income	2023-08-03 06:32:39.176626	2023-08-03 06:32:39.176626	\N	f
7	Foster Youth	2023-08-03 06:32:39.110608	2023-08-03 06:32:39.188235	\N	t
11	Homeless	2023-08-03 06:32:39.154477	2023-08-03 06:32:39.198072	\N	t
12	Disabled	2023-08-03 06:32:39.165608	2023-08-03 06:32:39.201109	\N	t
\.


--
-- Data for Name: eligibilities_services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eligibilities_services (service_id, eligibility_id) FROM stdin;
177	1
17	1
84	1
156	1
64	1
116	1
198	1
162	1
26	1
211	1
46	1
127	1
146	1
154	1
73	1
163	1
186	1
213	1
135	1
169	1
15	1
174	1
19	1
164	1
184	2
167	2
131	2
127	2
121	2
157	2
198	2
215	2
19	2
95	2
151	2
210	2
26	2
179	2
155	2
29	2
156	2
134	3
77	3
155	3
132	3
115	3
127	3
168	3
114	3
143	4
150	4
14	4
32	4
4	4
9	4
115	4
54	4
129	4
162	4
122	4
96	4
38	4
190	4
30	4
191	4
182	4
171	4
34	4
179	4
128	4
10	4
2	4
154	4
108	5
160	5
152	5
32	5
215	5
174	5
126	5
159	5
29	5
199	5
139	5
204	5
116	5
38	5
137	5
156	5
170	5
28	6
123	6
125	6
64	6
156	6
100	6
71	6
127	6
199	7
145	7
191	7
153	7
170	7
197	8
64	8
38	8
134	8
178	8
29	9
44	9
127	9
189	9
32	9
163	10
12	10
41	10
106	10
152	10
92	11
107	11
99	11
129	11
80	11
21	12
116	12
156	12
72	12
77	12
187	13
43	13
44	13
143	13
136	13
216	12
217	1
218	3
219	11
\.


--
-- Data for Name: eligibility_relationships; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eligibility_relationships (parent_id, child_id) FROM stdin;
7	6
11	8
12	2
\.


--
-- Data for Name: feedbacks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.feedbacks (id, rating, resource_id, service_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: field_changes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.field_changes (id, field_name, field_value, change_request_id) FROM stdin;
1	name	Hudson and Sons	1
2	long_description	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	1
3	name	Sporer-DuBuque	2
4	long_description	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	2
5	name	Renner Inc	3
6	long_description	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	3
7	name	Sporer, Schamberger and Schaefer	4
8	long_description	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	4
9	name	Orn-Simonis	5
10	long_description	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	5
11	name	Koepp and Sons	6
12	long_description	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	6
13	name	Lebsack, Rau and Rowe	7
14	long_description	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	7
15	name	Morar, Kreiger and Haag	8
16	long_description	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	8
17	name	Dicki and Sons	9
18	long_description	Serves lunch Monday and Wednesday. Dinner available all days.\n	9
19	name	Daniel-Franecki	10
20	long_description	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	10
21	name	Wisozk Inc	11
22	long_description	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	11
23	name	Runolfsson-Block	12
24	long_description	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	12
25	name	Smith LLC	13
26	long_description	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	13
27	name	Dibbert, Murray and Hettinger	14
28	long_description	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	14
29	name	Donnelly LLC	15
30	long_description	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	15
31	name	Ondricka-Jakubowski	16
32	long_description	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	16
33	name	Kuhic, McGlynn and Medhurst	17
34	long_description	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	17
35	name	Champlin LLC	18
36	long_description	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	18
37	name	Hansen-Blanda	19
38	long_description	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	19
39	name	Kreiger Group	20
40	long_description	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	20
41	name	Torphy-Bailey	21
42	long_description	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	21
43	name	Balistreri-Gleichner	22
44	long_description	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	22
45	name	Wyman Inc	23
46	long_description	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	23
47	name	DuBuque-Douglas	24
48	long_description	Weekly food pantry (Thursday).\n	24
49	name	Cole and Sons	25
50	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	25
51	name	Koepp-Lynch	26
52	long_description	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	26
53	name	Schroeder-Rice	27
54	long_description	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	27
55	name	Raynor-Yundt	28
56	long_description	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	28
57	name	Dach LLC	29
58	long_description	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	29
59	name	Metz Inc	30
60	long_description	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	30
61	name	Mohr-Hammes	31
62	long_description	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	31
63	name	Mueller, Herman and Corwin	32
64	long_description	Serves lunch Monday and Wednesday. Dinner available all days.\n	32
65	name	Rodriguez-Boehm	33
66	long_description	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	33
67	name	Pagac Inc	34
68	long_description	Weekly food pantry (Thursday).\n	34
69	name	Rogahn, Bashirian and D'Amore	35
70	long_description	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	35
71	name	Swift, Lowe and Hettinger	36
72	long_description	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	36
73	name	Pacocha-O'Reilly	37
74	long_description	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	37
75	name	Nolan-Ryan	38
76	long_description	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	38
77	name	Mohr, Kshlerin and Glover	39
78	long_description	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	39
79	name	Schmidt, Steuber and Parisian	40
80	long_description	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	40
81	name	Schaden, Kuhic and Roberts	41
82	long_description	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	41
83	name	Rau, Ferry and Nitzsche	42
84	long_description	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	42
85	name	Pagac-Reinger	43
135	name	Jacobson, Bogan and Kulas	68
136	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	68
137	name	Johns-Lubowitz	69
86	long_description	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	43
87	name	Kihn and Sons	44
88	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	44
89	name	Nitzsche Group	45
90	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	45
91	name	Schaden, Feest and Pfeffer	46
92	long_description	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	46
93	name	Kovacek-Hoppe	47
94	long_description	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	47
95	name	Bode Group	48
96	long_description	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	48
97	name	Hills and Sons	49
98	long_description	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	49
99	name	Rippin-Bayer	50
100	long_description	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	50
101	name	Littel-Steuber	51
102	long_description	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	51
103	name	Turner Group	52
104	long_description	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	52
105	name	Treutel-O'Kon	53
106	long_description	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	53
107	name	Pfannerstill, Hansen and Swaniawski	54
108	long_description	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	54
109	name	Corkery, Simonis and Hilpert	55
110	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	55
111	name	Rippin, Kuphal and Conroy	56
112	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	56
113	name	Lehner and Sons	57
114	long_description	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	57
115	name	Waters Inc	58
116	long_description	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	58
117	name	Pfannerstill-Aufderhar	59
118	long_description	A place to shower on Tuesday through Saturday.\n	59
119	name	Stokes and Sons	60
120	long_description	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	60
121	name	Block and Sons	61
122	long_description	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	61
123	name	Beier-Balistreri	62
124	long_description	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	62
125	name	Brekke, Casper and Stamm	63
126	long_description	Weekly food pantry (Thursday).\n	63
127	name	Lakin, Heaney and Kirlin	64
128	long_description	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	64
129	name	Strosin-Lakin	65
130	long_description	A place to shower on Tuesday through Saturday.\n	65
131	name	Rosenbaum Group	66
132	long_description	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	66
133	name	Crona-O'Reilly	67
134	long_description	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	67
138	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	69
139	name	Orn Inc	70
140	long_description	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	70
141	name	Schuster and Sons	71
142	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	71
143	name	Franecki, Kuhic and Botsford	72
144	long_description	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	72
145	name	Rodriguez, Romaguera and Raynor	73
146	long_description	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	73
147	name	Runolfsdottir, Jakubowski and Schiller	74
148	long_description	Serves lunch Monday and Wednesday. Dinner available all days.\n	74
149	name	Rau LLC	75
150	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	75
151	name	D'Amore-Hayes	76
152	long_description	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	76
153	name	Mraz-Klein	77
154	long_description	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	77
155	name	Kunze and Sons	78
156	long_description	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	78
157	name	Kertzmann, Conroy and Barton	79
158	long_description	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	79
159	name	Fritsch-Lehner	80
160	long_description	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	80
161	name	Nitzsche-Casper	81
162	long_description	Serves lunch Monday and Wednesday. Dinner available all days.\n	81
163	name	Littel and Sons	82
164	long_description	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	82
165	name	Hermann-Nienow	83
166	long_description	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	83
167	name	MacGyver, Lockman and Buckridge	84
168	long_description	Serves lunch Monday and Wednesday. Dinner available all days.\n	84
169	name	Russel, Ratke and Beier	85
170	long_description	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	85
171	name	Gottlieb and Sons	86
172	long_description	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	86
173	name	Metz, Brekke and Hammes	87
174	long_description	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	87
175	name	Corkery Group	88
176	long_description	Serves lunch Monday and Wednesday. Dinner available all days.\n	88
177	name	Kunze-Buckridge	89
178	long_description	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	89
179	name	Carter-Marquardt	90
180	long_description	A place to shower on Tuesday through Saturday.\n	90
181	name	O'Reilly Inc	91
182	long_description	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	91
183	name	Bernier LLC	92
184	long_description	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	92
185	name	Davis, Boehm and Prosacco	93
186	long_description	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	93
187	name	Kunde, Wisoky and O'Hara	94
188	long_description	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	94
189	name	Murphy-Price	95
370	long_description	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	185
190	long_description	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	95
191	name	Kemmer LLC	96
192	long_description	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	96
193	name	Boyle-Gerhold	97
194	long_description	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	97
195	name	Schimmel Group	98
196	long_description	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	98
197	name	Upton, Morissette and Oberbrunner	99
198	long_description	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	99
199	name	Mraz-Buckridge	100
200	long_description	A place to shower on Tuesday through Saturday.\n	100
201	name	Powlowski, Boyle and Mills	101
202	long_description	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	101
203	name	Hickle and Sons	102
204	long_description	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	102
205	name	Littel Inc	103
206	long_description	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	103
207	name	Dietrich-Hoeger	104
208	long_description	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	104
209	name	Veum-Bernier	105
210	long_description	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	105
211	name	Jenkins, Ward and Altenwerth	106
212	long_description	A place to shower on Tuesday through Saturday.\n	106
213	name	Cassin-Tillman	107
214	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	107
215	name	Oberbrunner-Hessel	108
216	long_description	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	108
217	name	Kilback LLC	109
218	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	109
219	name	Mayert, Kihn and Turcotte	110
220	long_description	Weekly food pantry (Thursday).\n	110
221	name	Heathcote Group	111
222	long_description	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	111
223	name	O'Keefe-O'Hara	112
224	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	112
225	name	Turcotte, Crona and Casper	113
226	long_description	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	113
227	name	Labadie, Oberbrunner and Okuneva	114
228	long_description	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	114
229	name	Quitzon-Hodkiewicz	115
230	long_description	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	115
231	name	Lang Group	116
232	long_description	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	116
233	name	Muller-Osinski	117
234	long_description	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	117
235	name	Ferry-Strosin	118
371	name	Rempel and Sons	186
236	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	118
237	name	Homenick, Bernier and Terry	119
238	long_description	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	119
239	name	Rosenbaum-Reichert	120
240	long_description	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	120
241	name	Wyman-Von	121
242	long_description	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	121
243	name	Cruickshank, Huels and Kassulke	122
244	long_description	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	122
245	name	Gorczany-Hermann	123
246	long_description	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	123
247	name	Stracke, Spencer and Lockman	124
248	long_description	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	124
249	name	Johnson, Labadie and Langworth	125
250	long_description	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	125
251	name	Volkman Group	126
252	long_description	Weekly food pantry (Thursday).\n	126
253	name	Bauch, Brown and Ullrich	127
254	long_description	Serves lunch Monday and Wednesday. Dinner available all days.\n	127
255	name	Mraz-Mertz	128
256	long_description	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	128
257	name	Mayer and Sons	129
258	long_description	A place to shower on Tuesday through Saturday.\n	129
259	name	Jast and Sons	130
260	long_description	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	130
261	name	Muller-Monahan	131
262	long_description	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	131
263	name	Klocko, Ratke and O'Conner	132
264	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	132
265	name	Kshlerin-Breitenberg	133
266	long_description	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	133
267	name	Simonis-Hartmann	134
268	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	134
269	name	Reichel, McDermott and Wisoky	135
270	long_description	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	135
271	name	Rutherford Group	136
272	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	136
273	name	Kemmer, Leannon and Thiel	137
274	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	137
275	name	Heaney, Boehm and Pfeffer	138
276	long_description	A place to shower on Tuesday through Saturday.\n	138
277	name	Hoppe and Sons	139
278	long_description	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	139
279	name	Blanda-Stroman	140
280	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	140
281	name	Emmerich, Berge and Runolfsson	141
282	long_description	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	141
283	name	Yundt-Reinger	142
284	long_description	A place to shower on Tuesday through Saturday.\n	142
285	name	Cartwright, Stokes and Schoen	143
286	long_description	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	143
287	name	Rosenbaum and Sons	144
288	long_description	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	144
289	name	Wilkinson Group	145
290	long_description	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	145
291	name	Rutherford, Kris and Stroman	146
292	long_description	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	146
293	name	Crooks-Okuneva	147
294	long_description	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	147
295	name	Langworth-Skiles	148
296	long_description	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	148
297	name	Wunsch and Sons	149
298	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	149
299	name	Romaguera Inc	150
300	long_description	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	150
301	name	Cartwright Inc	151
302	long_description	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	151
303	name	Jones-Schaden	152
304	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	152
305	name	Lebsack, Bartell and Strosin	153
306	long_description	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	153
307	name	Von and Sons	154
308	long_description	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	154
309	name	Carroll, Breitenberg and Conn	155
310	long_description	Serves lunch Monday and Wednesday. Dinner available all days.\n	155
311	name	Watsica Group	156
312	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	156
313	name	Leannon-Nitzsche	157
314	long_description	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	157
315	name	Ernser-Schuster	158
316	long_description	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	158
317	name	Turcotte, Hauck and Hammes	159
318	long_description	A place to shower on Tuesday through Saturday.\n	159
319	name	Aufderhar-Rodriguez	160
320	long_description	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	160
321	name	Aufderhar, Bauch and Runolfsdottir	161
322	long_description	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	161
323	name	Gutmann, Lemke and Hermiston	162
324	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	162
325	name	Waters-Rempel	163
372	long_description	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	186
373	name	Crist LLC	187
326	long_description	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	163
327	name	Rice-Reichel	164
328	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	164
329	name	Block, Barton and Bogan	165
330	long_description	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	165
331	name	Wunsch Group	166
332	long_description	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	166
333	name	Brown-Bernhard	167
334	long_description	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	167
335	name	Swaniawski Group	168
336	long_description	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	168
337	name	Hudson, Bogan and Rowe	169
338	long_description	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	169
339	name	Gutkowski, Williamson and Will	170
340	long_description	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	170
341	name	Hackett, Balistreri and White	171
342	long_description	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	171
343	name	Cronin, Orn and Jaskolski	172
344	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	172
345	name	Roberts-Mann	173
346	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	173
347	name	Hintz-Cole	174
348	long_description	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	174
349	name	Rippin-Maggio	175
350	long_description	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	175
351	name	Muller LLC	176
352	long_description	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	176
353	name	Hackett, O'Connell and Braun	177
354	long_description	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	177
355	name	Kreiger LLC	178
356	long_description	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	178
357	name	Leannon, Cruickshank and Kub	179
358	long_description	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	179
359	name	Thompson-Emard	180
360	long_description	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	180
361	name	Wilkinson-Strosin	181
362	long_description	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	181
363	name	Mosciski-Jakubowski	182
364	long_description	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	182
365	name	Larkin Inc	183
366	long_description	A place to shower on Tuesday through Saturday.\n	183
367	name	Jacobi, Bruen and Walsh	184
368	long_description	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	184
369	name	Robel, Stroman and Hermann	185
374	long_description	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	187
375	name	Bins and Sons	188
376	long_description	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	188
377	name	Koss-Dooley	189
378	long_description	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	189
379	name	Powlowski-Nikolaus	190
380	long_description	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	190
381	name	Kessler Inc	191
382	long_description	Serves lunch Monday and Wednesday. Dinner available all days.\n	191
383	name	Sanford LLC	192
384	long_description	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	192
385	name	Rippin-Kilback	193
386	long_description	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	193
387	name	Armstrong, Murray and Moen	194
388	long_description	Serves lunch Monday and Wednesday. Dinner available all days.\n	194
389	name	Mueller-O'Keefe	195
390	long_description	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	195
391	name	White-Auer	196
392	long_description	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	196
393	name	Kautzer, Abernathy and Mueller	197
394	long_description	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	197
395	name	Beatty, Swift and Harris	198
396	long_description	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	198
397	name	McCullough-Koelpin	199
398	long_description	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	199
399	name	Rath Group	200
400	long_description	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	200
401	name	Boyer, Nitzsche and Wyman	201
402	long_description	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	201
403	name	Heidenreich Inc	202
404	long_description	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	202
405	name	Langworth-Kuhn	203
406	long_description	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	203
407	name	Bechtelar-Rippin	204
408	long_description	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	204
409	name	Altenwerth-Hettinger	205
410	long_description	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	205
411	name	Lesch-Schaden	206
412	long_description	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	206
413	name	Auer, Jacobi and Kulas	207
414	long_description	Weekly food pantry (Thursday).\n	207
415	name	Kuhic, Ebert and Mueller	208
416	long_description	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	208
417	name	Walker, Corkery and Ortiz	209
418	long_description	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	209
419	name	Muller, Bruen and Vandervort	210
420	long_description	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	210
421	name	Braun Inc	211
422	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	211
423	name	Konopelski-Adams	212
424	long_description	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	212
425	name	Rohan and Sons	213
426	long_description	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	213
427	name	Jacobson, Keeling and Swaniawski	214
428	long_description	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	214
429	name	Boyer-Abshire	215
430	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	215
\.


--
-- Data for Name: fundings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fundings (id, source, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: instructions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instructions (id, instruction, created_at, updated_at, service_id) FROM stdin;
1	Instruction text goes here	2023-08-03 06:32:29.550806	2023-08-03 06:32:29.550806	1
2	Instruction text goes here	2023-08-03 06:32:29.588596	2023-08-03 06:32:29.588596	2
3	Instruction text goes here	2023-08-03 06:32:29.644393	2023-08-03 06:32:29.644393	3
4	Instruction text goes here	2023-08-03 06:32:29.668228	2023-08-03 06:32:29.668228	4
5	Instruction text goes here	2023-08-03 06:32:29.713767	2023-08-03 06:32:29.713767	5
6	Instruction text goes here	2023-08-03 06:32:29.739376	2023-08-03 06:32:29.739376	6
7	Instruction text goes here	2023-08-03 06:32:29.789992	2023-08-03 06:32:29.789992	7
8	Instruction text goes here	2023-08-03 06:32:29.847077	2023-08-03 06:32:29.847077	8
9	Instruction text goes here	2023-08-03 06:32:29.869862	2023-08-03 06:32:29.869862	9
10	Instruction text goes here	2023-08-03 06:32:29.919933	2023-08-03 06:32:29.919933	10
11	Instruction text goes here	2023-08-03 06:32:29.945145	2023-08-03 06:32:29.945145	11
12	Instruction text goes here	2023-08-03 06:32:30.002218	2023-08-03 06:32:30.002218	12
13	Instruction text goes here	2023-08-03 06:32:30.025535	2023-08-03 06:32:30.025535	13
14	Instruction text goes here	2023-08-03 06:32:30.067866	2023-08-03 06:32:30.067866	14
15	Instruction text goes here	2023-08-03 06:32:30.092601	2023-08-03 06:32:30.092601	15
16	Instruction text goes here	2023-08-03 06:32:30.132896	2023-08-03 06:32:30.132896	16
17	Instruction text goes here	2023-08-03 06:32:30.182737	2023-08-03 06:32:30.182737	17
18	Instruction text goes here	2023-08-03 06:32:30.236396	2023-08-03 06:32:30.236396	18
19	Instruction text goes here	2023-08-03 06:32:30.260108	2023-08-03 06:32:30.260108	19
20	Instruction text goes here	2023-08-03 06:32:30.2999	2023-08-03 06:32:30.2999	20
21	Instruction text goes here	2023-08-03 06:32:30.321616	2023-08-03 06:32:30.321616	21
22	Instruction text goes here	2023-08-03 06:32:30.36756	2023-08-03 06:32:30.36756	22
23	Instruction text goes here	2023-08-03 06:32:30.392276	2023-08-03 06:32:30.392276	23
24	Instruction text goes here	2023-08-03 06:32:30.439141	2023-08-03 06:32:30.439141	24
25	Instruction text goes here	2023-08-03 06:32:30.479845	2023-08-03 06:32:30.479845	25
26	Instruction text goes here	2023-08-03 06:32:30.524666	2023-08-03 06:32:30.524666	26
27	Instruction text goes here	2023-08-03 06:32:30.56673	2023-08-03 06:32:30.56673	27
28	Instruction text goes here	2023-08-03 06:32:30.595377	2023-08-03 06:32:30.595377	28
29	Instruction text goes here	2023-08-03 06:32:30.654724	2023-08-03 06:32:30.654724	29
30	Instruction text goes here	2023-08-03 06:32:30.67889	2023-08-03 06:32:30.67889	30
31	Instruction text goes here	2023-08-03 06:32:30.722059	2023-08-03 06:32:30.722059	31
32	Instruction text goes here	2023-08-03 06:32:30.768783	2023-08-03 06:32:30.768783	32
33	Instruction text goes here	2023-08-03 06:32:30.791148	2023-08-03 06:32:30.791148	33
34	Instruction text goes here	2023-08-03 06:32:30.832975	2023-08-03 06:32:30.832975	34
35	Instruction text goes here	2023-08-03 06:32:30.878138	2023-08-03 06:32:30.878138	35
36	Instruction text goes here	2023-08-03 06:32:30.90017	2023-08-03 06:32:30.90017	36
37	Instruction text goes here	2023-08-03 06:32:30.943689	2023-08-03 06:32:30.943689	37
38	Instruction text goes here	2023-08-03 06:32:30.971271	2023-08-03 06:32:30.971271	38
39	Instruction text goes here	2023-08-03 06:32:31.01613	2023-08-03 06:32:31.01613	39
40	Instruction text goes here	2023-08-03 06:32:31.04271	2023-08-03 06:32:31.04271	40
41	Instruction text goes here	2023-08-03 06:32:31.097317	2023-08-03 06:32:31.097317	41
42	Instruction text goes here	2023-08-03 06:32:31.14899	2023-08-03 06:32:31.14899	42
43	Instruction text goes here	2023-08-03 06:32:31.201032	2023-08-03 06:32:31.201032	43
44	Instruction text goes here	2023-08-03 06:32:31.247836	2023-08-03 06:32:31.247836	44
45	Instruction text goes here	2023-08-03 06:32:31.294533	2023-08-03 06:32:31.294533	45
46	Instruction text goes here	2023-08-03 06:32:31.339357	2023-08-03 06:32:31.339357	46
47	Instruction text goes here	2023-08-03 06:32:31.384308	2023-08-03 06:32:31.384308	47
48	Instruction text goes here	2023-08-03 06:32:31.412104	2023-08-03 06:32:31.412104	48
49	Instruction text goes here	2023-08-03 06:32:31.458708	2023-08-03 06:32:31.458708	49
50	Instruction text goes here	2023-08-03 06:32:31.505868	2023-08-03 06:32:31.505868	50
51	Instruction text goes here	2023-08-03 06:32:31.552878	2023-08-03 06:32:31.552878	51
52	Instruction text goes here	2023-08-03 06:32:31.574968	2023-08-03 06:32:31.574968	52
53	Instruction text goes here	2023-08-03 06:32:31.625717	2023-08-03 06:32:31.625717	53
54	Instruction text goes here	2023-08-03 06:32:31.676929	2023-08-03 06:32:31.676929	54
55	Instruction text goes here	2023-08-03 06:32:31.72033	2023-08-03 06:32:31.72033	55
56	Instruction text goes here	2023-08-03 06:32:31.773205	2023-08-03 06:32:31.773205	56
57	Instruction text goes here	2023-08-03 06:32:31.822445	2023-08-03 06:32:31.822445	57
58	Instruction text goes here	2023-08-03 06:32:31.873406	2023-08-03 06:32:31.873406	58
59	Instruction text goes here	2023-08-03 06:32:31.9209	2023-08-03 06:32:31.9209	59
60	Instruction text goes here	2023-08-03 06:32:31.968262	2023-08-03 06:32:31.968262	60
61	Instruction text goes here	2023-08-03 06:32:31.996386	2023-08-03 06:32:31.996386	61
62	Instruction text goes here	2023-08-03 06:32:32.038858	2023-08-03 06:32:32.038858	62
63	Instruction text goes here	2023-08-03 06:32:32.08703	2023-08-03 06:32:32.08703	63
64	Instruction text goes here	2023-08-03 06:32:32.134206	2023-08-03 06:32:32.134206	64
65	Instruction text goes here	2023-08-03 06:32:32.154088	2023-08-03 06:32:32.154088	65
66	Instruction text goes here	2023-08-03 06:32:32.201094	2023-08-03 06:32:32.201094	66
67	Instruction text goes here	2023-08-03 06:32:32.245901	2023-08-03 06:32:32.245901	67
68	Instruction text goes here	2023-08-03 06:32:32.273755	2023-08-03 06:32:32.273755	68
69	Instruction text goes here	2023-08-03 06:32:32.318581	2023-08-03 06:32:32.318581	69
70	Instruction text goes here	2023-08-03 06:32:32.367459	2023-08-03 06:32:32.367459	70
71	Instruction text goes here	2023-08-03 06:32:32.418742	2023-08-03 06:32:32.418742	71
72	Instruction text goes here	2023-08-03 06:32:32.472556	2023-08-03 06:32:32.472556	72
73	Instruction text goes here	2023-08-03 06:32:32.496314	2023-08-03 06:32:32.496314	73
74	Instruction text goes here	2023-08-03 06:32:32.543097	2023-08-03 06:32:32.543097	74
75	Instruction text goes here	2023-08-03 06:32:32.569353	2023-08-03 06:32:32.569353	75
76	Instruction text goes here	2023-08-03 06:32:32.61456	2023-08-03 06:32:32.61456	76
77	Instruction text goes here	2023-08-03 06:32:32.638946	2023-08-03 06:32:32.638946	77
78	Instruction text goes here	2023-08-03 06:32:32.68378	2023-08-03 06:32:32.68378	78
79	Instruction text goes here	2023-08-03 06:32:32.734328	2023-08-03 06:32:32.734328	79
80	Instruction text goes here	2023-08-03 06:32:32.757393	2023-08-03 06:32:32.757393	80
81	Instruction text goes here	2023-08-03 06:32:32.812452	2023-08-03 06:32:32.812452	81
82	Instruction text goes here	2023-08-03 06:32:32.839007	2023-08-03 06:32:32.839007	82
83	Instruction text goes here	2023-08-03 06:32:32.890649	2023-08-03 06:32:32.890649	83
84	Instruction text goes here	2023-08-03 06:32:32.935851	2023-08-03 06:32:32.935851	84
85	Instruction text goes here	2023-08-03 06:32:32.962145	2023-08-03 06:32:32.962145	85
86	Instruction text goes here	2023-08-03 06:32:33.002789	2023-08-03 06:32:33.002789	86
87	Instruction text goes here	2023-08-03 06:32:33.026017	2023-08-03 06:32:33.026017	87
88	Instruction text goes here	2023-08-03 06:32:33.066585	2023-08-03 06:32:33.066585	88
89	Instruction text goes here	2023-08-03 06:32:33.091694	2023-08-03 06:32:33.091694	89
90	Instruction text goes here	2023-08-03 06:32:33.147416	2023-08-03 06:32:33.147416	90
91	Instruction text goes here	2023-08-03 06:32:33.177306	2023-08-03 06:32:33.177306	91
92	Instruction text goes here	2023-08-03 06:32:33.229234	2023-08-03 06:32:33.229234	92
93	Instruction text goes here	2023-08-03 06:32:33.260218	2023-08-03 06:32:33.260218	93
94	Instruction text goes here	2023-08-03 06:32:33.306161	2023-08-03 06:32:33.306161	94
95	Instruction text goes here	2023-08-03 06:32:33.35668	2023-08-03 06:32:33.35668	95
96	Instruction text goes here	2023-08-03 06:32:33.375917	2023-08-03 06:32:33.375917	96
97	Instruction text goes here	2023-08-03 06:32:33.425311	2023-08-03 06:32:33.425311	97
98	Instruction text goes here	2023-08-03 06:32:33.451827	2023-08-03 06:32:33.451827	98
99	Instruction text goes here	2023-08-03 06:32:33.508046	2023-08-03 06:32:33.508046	99
100	Instruction text goes here	2023-08-03 06:32:33.561879	2023-08-03 06:32:33.561879	100
101	Instruction text goes here	2023-08-03 06:32:33.611207	2023-08-03 06:32:33.611207	101
102	Instruction text goes here	2023-08-03 06:32:33.63852	2023-08-03 06:32:33.63852	102
103	Instruction text goes here	2023-08-03 06:32:33.690745	2023-08-03 06:32:33.690745	103
104	Instruction text goes here	2023-08-03 06:32:33.747434	2023-08-03 06:32:33.747434	104
105	Instruction text goes here	2023-08-03 06:32:33.769494	2023-08-03 06:32:33.769494	105
106	Instruction text goes here	2023-08-03 06:32:33.822715	2023-08-03 06:32:33.822715	106
107	Instruction text goes here	2023-08-03 06:32:33.845688	2023-08-03 06:32:33.845688	107
108	Instruction text goes here	2023-08-03 06:32:33.896505	2023-08-03 06:32:33.896505	108
109	Instruction text goes here	2023-08-03 06:32:33.945106	2023-08-03 06:32:33.945106	109
110	Instruction text goes here	2023-08-03 06:32:33.975574	2023-08-03 06:32:33.975574	110
111	Instruction text goes here	2023-08-03 06:32:34.026196	2023-08-03 06:32:34.026196	111
112	Instruction text goes here	2023-08-03 06:32:34.053523	2023-08-03 06:32:34.053523	112
113	Instruction text goes here	2023-08-03 06:32:34.102134	2023-08-03 06:32:34.102134	113
114	Instruction text goes here	2023-08-03 06:32:34.129987	2023-08-03 06:32:34.129987	114
115	Instruction text goes here	2023-08-03 06:32:34.18313	2023-08-03 06:32:34.18313	115
116	Instruction text goes here	2023-08-03 06:32:34.235723	2023-08-03 06:32:34.235723	116
117	Instruction text goes here	2023-08-03 06:32:34.290516	2023-08-03 06:32:34.290516	117
118	Instruction text goes here	2023-08-03 06:32:34.313652	2023-08-03 06:32:34.313652	118
119	Instruction text goes here	2023-08-03 06:32:34.365129	2023-08-03 06:32:34.365129	119
120	Instruction text goes here	2023-08-03 06:32:34.392879	2023-08-03 06:32:34.392879	120
121	Instruction text goes here	2023-08-03 06:32:34.438918	2023-08-03 06:32:34.438918	121
122	Instruction text goes here	2023-08-03 06:32:34.464978	2023-08-03 06:32:34.464978	122
123	Instruction text goes here	2023-08-03 06:32:34.513555	2023-08-03 06:32:34.513555	123
124	Instruction text goes here	2023-08-03 06:32:34.566039	2023-08-03 06:32:34.566039	124
125	Instruction text goes here	2023-08-03 06:32:34.593988	2023-08-03 06:32:34.593988	125
126	Instruction text goes here	2023-08-03 06:32:34.640821	2023-08-03 06:32:34.640821	126
127	Instruction text goes here	2023-08-03 06:32:34.700515	2023-08-03 06:32:34.700515	127
128	Instruction text goes here	2023-08-03 06:32:34.75814	2023-08-03 06:32:34.75814	128
129	Instruction text goes here	2023-08-03 06:32:34.810561	2023-08-03 06:32:34.810561	129
130	Instruction text goes here	2023-08-03 06:32:34.832638	2023-08-03 06:32:34.832638	130
131	Instruction text goes here	2023-08-03 06:32:34.901609	2023-08-03 06:32:34.901609	131
132	Instruction text goes here	2023-08-03 06:32:35.005957	2023-08-03 06:32:35.005957	132
133	Instruction text goes here	2023-08-03 06:32:35.040823	2023-08-03 06:32:35.040823	133
134	Instruction text goes here	2023-08-03 06:32:35.09338	2023-08-03 06:32:35.09338	134
135	Instruction text goes here	2023-08-03 06:32:35.13824	2023-08-03 06:32:35.13824	135
136	Instruction text goes here	2023-08-03 06:32:35.165454	2023-08-03 06:32:35.165454	136
137	Instruction text goes here	2023-08-03 06:32:35.23935	2023-08-03 06:32:35.23935	137
138	Instruction text goes here	2023-08-03 06:32:35.264571	2023-08-03 06:32:35.264571	138
139	Instruction text goes here	2023-08-03 06:32:35.330237	2023-08-03 06:32:35.330237	139
140	Instruction text goes here	2023-08-03 06:32:35.412287	2023-08-03 06:32:35.412287	140
141	Instruction text goes here	2023-08-03 06:32:35.479721	2023-08-03 06:32:35.479721	141
142	Instruction text goes here	2023-08-03 06:32:35.514672	2023-08-03 06:32:35.514672	142
143	Instruction text goes here	2023-08-03 06:32:35.566836	2023-08-03 06:32:35.566836	143
144	Instruction text goes here	2023-08-03 06:32:35.612696	2023-08-03 06:32:35.612696	144
145	Instruction text goes here	2023-08-03 06:32:35.673669	2023-08-03 06:32:35.673669	145
146	Instruction text goes here	2023-08-03 06:32:35.703549	2023-08-03 06:32:35.703549	146
147	Instruction text goes here	2023-08-03 06:32:35.752835	2023-08-03 06:32:35.752835	147
148	Instruction text goes here	2023-08-03 06:32:35.795891	2023-08-03 06:32:35.795891	148
149	Instruction text goes here	2023-08-03 06:32:35.823693	2023-08-03 06:32:35.823693	149
150	Instruction text goes here	2023-08-03 06:32:35.877472	2023-08-03 06:32:35.877472	150
151	Instruction text goes here	2023-08-03 06:32:35.920133	2023-08-03 06:32:35.920133	151
152	Instruction text goes here	2023-08-03 06:32:35.969556	2023-08-03 06:32:35.969556	152
153	Instruction text goes here	2023-08-03 06:32:35.99397	2023-08-03 06:32:35.99397	153
154	Instruction text goes here	2023-08-03 06:32:36.044142	2023-08-03 06:32:36.044142	154
155	Instruction text goes here	2023-08-03 06:32:36.092612	2023-08-03 06:32:36.092612	155
156	Instruction text goes here	2023-08-03 06:32:36.15883	2023-08-03 06:32:36.15883	156
157	Instruction text goes here	2023-08-03 06:32:36.207098	2023-08-03 06:32:36.207098	157
158	Instruction text goes here	2023-08-03 06:32:36.258519	2023-08-03 06:32:36.258519	158
159	Instruction text goes here	2023-08-03 06:32:36.305873	2023-08-03 06:32:36.305873	159
160	Instruction text goes here	2023-08-03 06:32:36.354736	2023-08-03 06:32:36.354736	160
161	Instruction text goes here	2023-08-03 06:32:36.395563	2023-08-03 06:32:36.395563	161
162	Instruction text goes here	2023-08-03 06:32:36.420259	2023-08-03 06:32:36.420259	162
163	Instruction text goes here	2023-08-03 06:32:36.46747	2023-08-03 06:32:36.46747	163
164	Instruction text goes here	2023-08-03 06:32:36.544584	2023-08-03 06:32:36.544584	164
165	Instruction text goes here	2023-08-03 06:32:36.584797	2023-08-03 06:32:36.584797	165
166	Instruction text goes here	2023-08-03 06:32:36.643614	2023-08-03 06:32:36.643614	166
167	Instruction text goes here	2023-08-03 06:32:36.694336	2023-08-03 06:32:36.694336	167
168	Instruction text goes here	2023-08-03 06:32:36.752467	2023-08-03 06:32:36.752467	168
169	Instruction text goes here	2023-08-03 06:32:36.813009	2023-08-03 06:32:36.813009	169
170	Instruction text goes here	2023-08-03 06:32:36.866881	2023-08-03 06:32:36.866881	170
171	Instruction text goes here	2023-08-03 06:32:36.922146	2023-08-03 06:32:36.922146	171
172	Instruction text goes here	2023-08-03 06:32:36.97742	2023-08-03 06:32:36.97742	172
173	Instruction text goes here	2023-08-03 06:32:37.038726	2023-08-03 06:32:37.038726	173
174	Instruction text goes here	2023-08-03 06:32:37.100923	2023-08-03 06:32:37.100923	174
175	Instruction text goes here	2023-08-03 06:32:37.133979	2023-08-03 06:32:37.133979	175
176	Instruction text goes here	2023-08-03 06:32:37.193954	2023-08-03 06:32:37.193954	176
177	Instruction text goes here	2023-08-03 06:32:37.226599	2023-08-03 06:32:37.226599	177
178	Instruction text goes here	2023-08-03 06:32:37.282316	2023-08-03 06:32:37.282316	178
179	Instruction text goes here	2023-08-03 06:32:37.309805	2023-08-03 06:32:37.309805	179
180	Instruction text goes here	2023-08-03 06:32:37.360541	2023-08-03 06:32:37.360541	180
181	Instruction text goes here	2023-08-03 06:32:37.384273	2023-08-03 06:32:37.384273	181
182	Instruction text goes here	2023-08-03 06:32:37.432328	2023-08-03 06:32:37.432328	182
183	Instruction text goes here	2023-08-03 06:32:37.484119	2023-08-03 06:32:37.484119	183
184	Instruction text goes here	2023-08-03 06:32:37.53199	2023-08-03 06:32:37.53199	184
185	Instruction text goes here	2023-08-03 06:32:37.58064	2023-08-03 06:32:37.58064	185
186	Instruction text goes here	2023-08-03 06:32:37.63203	2023-08-03 06:32:37.63203	186
187	Instruction text goes here	2023-08-03 06:32:37.660434	2023-08-03 06:32:37.660434	187
188	Instruction text goes here	2023-08-03 06:32:37.708653	2023-08-03 06:32:37.708653	188
189	Instruction text goes here	2023-08-03 06:32:37.752728	2023-08-03 06:32:37.752728	189
190	Instruction text goes here	2023-08-03 06:32:37.801089	2023-08-03 06:32:37.801089	190
191	Instruction text goes here	2023-08-03 06:32:37.848002	2023-08-03 06:32:37.848002	191
192	Instruction text goes here	2023-08-03 06:32:37.870063	2023-08-03 06:32:37.870063	192
193	Instruction text goes here	2023-08-03 06:32:37.912799	2023-08-03 06:32:37.912799	193
194	Instruction text goes here	2023-08-03 06:32:37.938895	2023-08-03 06:32:37.938895	194
195	Instruction text goes here	2023-08-03 06:32:37.989067	2023-08-03 06:32:37.989067	195
196	Instruction text goes here	2023-08-03 06:32:38.037714	2023-08-03 06:32:38.037714	196
197	Instruction text goes here	2023-08-03 06:32:38.116644	2023-08-03 06:32:38.116644	197
198	Instruction text goes here	2023-08-03 06:32:38.157406	2023-08-03 06:32:38.157406	198
199	Instruction text goes here	2023-08-03 06:32:38.207436	2023-08-03 06:32:38.207436	199
200	Instruction text goes here	2023-08-03 06:32:38.235234	2023-08-03 06:32:38.235234	200
201	Instruction text goes here	2023-08-03 06:32:38.288125	2023-08-03 06:32:38.288125	201
202	Instruction text goes here	2023-08-03 06:32:38.31826	2023-08-03 06:32:38.31826	202
203	Instruction text goes here	2023-08-03 06:32:38.367283	2023-08-03 06:32:38.367283	203
204	Instruction text goes here	2023-08-03 06:32:38.415854	2023-08-03 06:32:38.415854	204
205	Instruction text goes here	2023-08-03 06:32:38.466667	2023-08-03 06:32:38.466667	205
206	Instruction text goes here	2023-08-03 06:32:38.494795	2023-08-03 06:32:38.494795	206
207	Instruction text goes here	2023-08-03 06:32:38.544642	2023-08-03 06:32:38.544642	207
208	Instruction text goes here	2023-08-03 06:32:38.593857	2023-08-03 06:32:38.593857	208
209	Instruction text goes here	2023-08-03 06:32:38.647252	2023-08-03 06:32:38.647252	209
210	Instruction text goes here	2023-08-03 06:32:38.696531	2023-08-03 06:32:38.696531	210
211	Instruction text goes here	2023-08-03 06:32:38.721792	2023-08-03 06:32:38.721792	211
212	Instruction text goes here	2023-08-03 06:32:38.765415	2023-08-03 06:32:38.765415	212
213	Instruction text goes here	2023-08-03 06:32:38.790207	2023-08-03 06:32:38.790207	213
214	Instruction text goes here	2023-08-03 06:32:38.838549	2023-08-03 06:32:38.838549	214
\.


--
-- Data for Name: keywords; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keywords (id, name) FROM stdin;
\.


--
-- Data for Name: keywords_resources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keywords_resources (resource_id, keyword_id) FROM stdin;
\.


--
-- Data for Name: keywords_services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keywords_services (service_id, keyword_id) FROM stdin;
\.


--
-- Data for Name: languages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.languages (id, language, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: news_articles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.news_articles (id, headline, effective_date, body, priority, expiration_date, created_at, updated_at, url) FROM stdin;
\.


--
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notes (id, note, resource_id, service_id, created_at, updated_at) FROM stdin;
1	Ad velit et. Velit repudiandae distinctio. Nemo odio dolores.	1	\N	2023-08-03 06:32:29.4462	2023-08-03 06:32:29.4462
2	Et ipsa voluptatem. Suscipit recusandae distinctio. Nobis id earum.	\N	1	2023-08-03 06:32:29.495339	2023-08-03 06:32:29.495339
3	Necessitatibus occaecati dolores. Voluptate est necessitatibus. Reprehenderit ipsum vitae.	\N	2	2023-08-03 06:32:29.570889	2023-08-03 06:32:29.570889
4	Ullam adipisci at. Aspernatur iste nihil. Nulla optio ab.	2	\N	2023-08-03 06:32:29.616823	2023-08-03 06:32:29.616823
5	Laborum debitis rerum. Numquam quibusdam error. Soluta blanditiis ut.	\N	3	2023-08-03 06:32:29.62197	2023-08-03 06:32:29.62197
6	Quibusdam unde et. Omnis voluptatibus fuga. Placeat quas molestiae.	\N	4	2023-08-03 06:32:29.653111	2023-08-03 06:32:29.653111
7	Ipsam consequatur doloremque. Sunt nobis illo. Est placeat qui.	3	\N	2023-08-03 06:32:29.693678	2023-08-03 06:32:29.693678
8	Enim adipisci sunt. Autem iste veritatis. Nesciunt est voluptas.	\N	5	2023-08-03 06:32:29.699601	2023-08-03 06:32:29.699601
9	Ullam error quod. Id sequi culpa. Eligendi perferendis corrupti.	\N	6	2023-08-03 06:32:29.722848	2023-08-03 06:32:29.722848
10	Quod eius suscipit. Autem quis ea. Possimus sint ab.	4	\N	2023-08-03 06:32:29.763024	2023-08-03 06:32:29.763024
11	Rerum error dolor. Eum quis mollitia. Id quia exercitationem.	\N	7	2023-08-03 06:32:29.7699	2023-08-03 06:32:29.7699
12	Veniam nemo omnis. Qui et aut. Et excepturi rerum.	5	\N	2023-08-03 06:32:29.821762	2023-08-03 06:32:29.821762
13	Incidunt vel ut. Vero minus quia. Quod velit asperiores.	\N	8	2023-08-03 06:32:29.829333	2023-08-03 06:32:29.829333
14	Dolores enim et. Nulla tenetur nobis. Delectus nostrum hic.	\N	9	2023-08-03 06:32:29.855792	2023-08-03 06:32:29.855792
15	Aliquid inventore pariatur. Blanditiis sit assumenda. Necessitatibus totam fugiat.	6	\N	2023-08-03 06:32:29.898768	2023-08-03 06:32:29.898768
16	Ea voluptates suscipit. Dolores in molestias. Ipsum at temporibus.	\N	10	2023-08-03 06:32:29.904521	2023-08-03 06:32:29.904521
17	Fugit et exercitationem. Molestiae et id. Rerum et id.	\N	11	2023-08-03 06:32:29.928614	2023-08-03 06:32:29.928614
18	Quod velit impedit. Eius iste illo. Debitis dolores accusamus.	7	\N	2023-08-03 06:32:29.975029	2023-08-03 06:32:29.975029
19	Occaecati ipsa quo. Qui itaque qui. Impedit voluptate vitae.	\N	12	2023-08-03 06:32:29.982798	2023-08-03 06:32:29.982798
20	Assumenda itaque asperiores. Labore libero voluptatem. Nesciunt fugiat non.	\N	13	2023-08-03 06:32:30.013291	2023-08-03 06:32:30.013291
21	Deleniti praesentium itaque. Dolore pariatur velit. Harum non sed.	8	\N	2023-08-03 06:32:30.046452	2023-08-03 06:32:30.046452
22	Et earum fugit. Sed nulla repudiandae. Sint unde error.	\N	14	2023-08-03 06:32:30.051034	2023-08-03 06:32:30.051034
23	Placeat sequi cupiditate. Enim neque repellat. Placeat distinctio possimus.	\N	15	2023-08-03 06:32:30.075936	2023-08-03 06:32:30.075936
24	Nulla magnam porro. Temporibus labore eum. Quia voluptas quidem.	9	\N	2023-08-03 06:32:30.114668	2023-08-03 06:32:30.114668
25	Quidem voluptatum adipisci. Tempore rem quisquam. Eum reprehenderit suscipit.	\N	16	2023-08-03 06:32:30.12001	2023-08-03 06:32:30.12001
26	Occaecati dolor sint. Nihil nobis assumenda. Sit iusto molestiae.	10	\N	2023-08-03 06:32:30.160344	2023-08-03 06:32:30.160344
27	Architecto earum inventore. Eum sequi velit. Ea illo qui.	\N	17	2023-08-03 06:32:30.1658	2023-08-03 06:32:30.1658
28	Ullam quia sunt. Assumenda minus consequatur. Eius accusantium voluptatem.	11	\N	2023-08-03 06:32:30.211466	2023-08-03 06:32:30.211466
29	Aut iste voluptas. Ratione minus ullam. Nemo in dolores.	\N	18	2023-08-03 06:32:30.220023	2023-08-03 06:32:30.220023
30	Debitis rerum maxime. Voluptatum sed dolor. Quia unde consequatur.	\N	19	2023-08-03 06:32:30.245475	2023-08-03 06:32:30.245475
31	Quae sit a. Voluptate et qui. Voluptate architecto dolorem.	12	\N	2023-08-03 06:32:30.279412	2023-08-03 06:32:30.279412
32	Pariatur voluptate adipisci. Quidem laboriosam saepe. Neque blanditiis molestiae.	\N	20	2023-08-03 06:32:30.284307	2023-08-03 06:32:30.284307
33	Eum ea enim. Temporibus facere maxime. Iusto incidunt aut.	\N	21	2023-08-03 06:32:30.3084	2023-08-03 06:32:30.3084
34	Dicta qui ut. Nulla sapiente nihil. Nihil cupiditate hic.	13	\N	2023-08-03 06:32:30.344738	2023-08-03 06:32:30.344738
35	Tenetur ratione laboriosam. At eos accusantium. Perferendis omnis placeat.	\N	22	2023-08-03 06:32:30.350383	2023-08-03 06:32:30.350383
36	Tempore quis temporibus. Vitae tempore est. Et et voluptatem.	\N	23	2023-08-03 06:32:30.376427	2023-08-03 06:32:30.376427
37	Est non iste. Tenetur at rem. Et eveniet modi.	14	\N	2023-08-03 06:32:30.419633	2023-08-03 06:32:30.419633
38	Quis qui sapiente. Ea omnis molestiae. Sed non nisi.	\N	24	2023-08-03 06:32:30.424466	2023-08-03 06:32:30.424466
39	Fuga ut cupiditate. Modi qui maiores. Voluptates maxime debitis.	15	\N	2023-08-03 06:32:30.461029	2023-08-03 06:32:30.461029
40	Corporis fuga dolorum. Cumque et et. Recusandae molestias repudiandae.	\N	25	2023-08-03 06:32:30.466168	2023-08-03 06:32:30.466168
41	Vel omnis voluptas. Unde id aut. Occaecati sed omnis.	16	\N	2023-08-03 06:32:30.507758	2023-08-03 06:32:30.507758
42	Ut aliquam aspernatur. Est ut nostrum. Voluptatem sed et.	\N	26	2023-08-03 06:32:30.512794	2023-08-03 06:32:30.512794
43	Nobis tenetur eos. Eum ipsa sed. Qui et incidunt.	17	\N	2023-08-03 06:32:30.548939	2023-08-03 06:32:30.548939
44	Accusamus aut qui. Et quos eligendi. Ea quod aperiam.	\N	27	2023-08-03 06:32:30.554499	2023-08-03 06:32:30.554499
45	Qui non autem. Et quos dicta. Qui magnam est.	\N	28	2023-08-03 06:32:30.57579	2023-08-03 06:32:30.57579
46	Debitis molestiae accusamus. Aut tenetur ab. Officiis quo ipsum.	18	\N	2023-08-03 06:32:30.630325	2023-08-03 06:32:30.630325
47	Quia aut illum. Qui fugiat voluptates. Natus doloribus est.	\N	29	2023-08-03 06:32:30.635802	2023-08-03 06:32:30.635802
48	Nobis suscipit repellendus. Aut vero corrupti. Aut nemo maiores.	\N	30	2023-08-03 06:32:30.664079	2023-08-03 06:32:30.664079
49	Reprehenderit dolores praesentium. Facere voluptas libero. Aut aut earum.	19	\N	2023-08-03 06:32:30.704078	2023-08-03 06:32:30.704078
50	Dolorem doloribus quam. Ullam nesciunt vel. Debitis aperiam animi.	\N	31	2023-08-03 06:32:30.708554	2023-08-03 06:32:30.708554
51	Voluptatem soluta fugiat. Autem cupiditate porro. Ratione eligendi quia.	20	\N	2023-08-03 06:32:30.744541	2023-08-03 06:32:30.744541
52	Nam reiciendis dolores. Facere mollitia aut. Placeat similique est.	\N	32	2023-08-03 06:32:30.749974	2023-08-03 06:32:30.749974
53	Est voluptatem et. Ipsam eum et. Voluptas atque quo.	\N	33	2023-08-03 06:32:30.777792	2023-08-03 06:32:30.777792
54	Nisi facere commodi. Id consequatur possimus. Mollitia dolore ab.	21	\N	2023-08-03 06:32:30.81105	2023-08-03 06:32:30.81105
55	Itaque dolorem doloribus. Maiores minima eum. Veritatis velit vero.	\N	34	2023-08-03 06:32:30.816218	2023-08-03 06:32:30.816218
56	Libero error consectetur. Qui est maxime. Porro quisquam iusto.	22	\N	2023-08-03 06:32:30.859011	2023-08-03 06:32:30.859011
57	Dolor a fugiat. Eos culpa rerum. Molestias deleniti nihil.	\N	35	2023-08-03 06:32:30.863407	2023-08-03 06:32:30.863407
58	Natus molestiae qui. Et repudiandae ut. Aut numquam doloribus.	\N	36	2023-08-03 06:32:30.885645	2023-08-03 06:32:30.885645
59	Reprehenderit quia maxime. Excepturi blanditiis temporibus. Eos reprehenderit officia.	23	\N	2023-08-03 06:32:30.921612	2023-08-03 06:32:30.921612
60	Quasi nobis consectetur. Explicabo ut veritatis. Possimus voluptates voluptatem.	\N	37	2023-08-03 06:32:30.926455	2023-08-03 06:32:30.926455
61	Ut perferendis enim. Et est delectus. Incidunt eum enim.	\N	38	2023-08-03 06:32:30.952218	2023-08-03 06:32:30.952218
62	Numquam pariatur velit. Consequatur quis ea. Dignissimos et aperiam.	24	\N	2023-08-03 06:32:30.99768	2023-08-03 06:32:30.99768
63	Saepe similique ipsam. Autem consequatur suscipit. Nisi nostrum qui.	\N	39	2023-08-03 06:32:31.003542	2023-08-03 06:32:31.003542
64	Quod enim deserunt. Placeat et rerum. Minus qui placeat.	\N	40	2023-08-03 06:32:31.025628	2023-08-03 06:32:31.025628
65	Minus aperiam ratione. Necessitatibus vitae explicabo. Saepe aspernatur maxime.	25	\N	2023-08-03 06:32:31.069802	2023-08-03 06:32:31.069802
66	Velit impedit sit. Voluptas expedita quos. Distinctio totam temporibus.	\N	41	2023-08-03 06:32:31.07499	2023-08-03 06:32:31.07499
67	Dolor vel quidem. Libero voluptatem possimus. Ea quis minima.	26	\N	2023-08-03 06:32:31.125403	2023-08-03 06:32:31.125403
68	Quibusdam quaerat doloremque. Non reiciendis hic. Atque autem corporis.	\N	42	2023-08-03 06:32:31.13059	2023-08-03 06:32:31.13059
69	Quisquam impedit et. Enim aliquid et. Voluptas quo aut.	27	\N	2023-08-03 06:32:31.177032	2023-08-03 06:32:31.177032
70	Velit et similique. Sit consequatur nostrum. Et illo aut.	\N	43	2023-08-03 06:32:31.181886	2023-08-03 06:32:31.181886
71	Necessitatibus est aut. Autem earum quasi. Rerum quis vel.	28	\N	2023-08-03 06:32:31.2276	2023-08-03 06:32:31.2276
72	Sit doloribus veritatis. Hic iste aperiam. Inventore molestiae occaecati.	\N	44	2023-08-03 06:32:31.23336	2023-08-03 06:32:31.23336
73	Est ex incidunt. Voluptatibus id quaerat. Quis ea molestiae.	29	\N	2023-08-03 06:32:31.275919	2023-08-03 06:32:31.275919
74	Placeat incidunt repudiandae. Quaerat quod ut. Reprehenderit quo sit.	\N	45	2023-08-03 06:32:31.281262	2023-08-03 06:32:31.281262
75	Modi hic nam. Laborum placeat et. Fuga asperiores distinctio.	30	\N	2023-08-03 06:32:31.315748	2023-08-03 06:32:31.315748
76	Id at fuga. Doloribus totam reiciendis. Sint similique ea.	\N	46	2023-08-03 06:32:31.320905	2023-08-03 06:32:31.320905
77	Voluptatem molestiae soluta. Voluptatem quae ut. Alias earum harum.	31	\N	2023-08-03 06:32:31.364598	2023-08-03 06:32:31.364598
78	Quas qui veniam. Ab aut consequatur. Sed architecto sit.	\N	47	2023-08-03 06:32:31.36985	2023-08-03 06:32:31.36985
79	Sapiente vitae ut. Recusandae consequuntur ea. Sit dolorem voluptatem.	\N	48	2023-08-03 06:32:31.393317	2023-08-03 06:32:31.393317
80	Aut ad qui. Veniam sequi ratione. Cupiditate ad id.	32	\N	2023-08-03 06:32:31.439528	2023-08-03 06:32:31.439528
81	Praesentium aut officiis. Incidunt labore id. Eos soluta exercitationem.	\N	49	2023-08-03 06:32:31.444255	2023-08-03 06:32:31.444255
82	Et et tenetur. Voluptatem ut commodi. Ipsum temporibus et.	33	\N	2023-08-03 06:32:31.485873	2023-08-03 06:32:31.485873
83	Vel accusamus ipsa. Eveniet corporis est. Est totam et.	\N	50	2023-08-03 06:32:31.489972	2023-08-03 06:32:31.489972
84	Reprehenderit vitae similique. Molestiae maiores exercitationem. Iure ex aut.	34	\N	2023-08-03 06:32:31.534104	2023-08-03 06:32:31.534104
85	Perspiciatis esse quisquam. Fuga id fugit. Ea dolore dicta.	\N	51	2023-08-03 06:32:31.53853	2023-08-03 06:32:31.53853
86	Odio hic beatae. Et consequatur veritatis. Ducimus error repellat.	\N	52	2023-08-03 06:32:31.560715	2023-08-03 06:32:31.560715
87	Consequatur qui qui. Quis nobis incidunt. Laboriosam magni voluptatem.	35	\N	2023-08-03 06:32:31.603284	2023-08-03 06:32:31.603284
88	Qui rerum aperiam. Dolorem corporis quas. Minus ad omnis.	\N	53	2023-08-03 06:32:31.608614	2023-08-03 06:32:31.608614
89	Qui rerum officia. Rem enim animi. Nihil sint et.	36	\N	2023-08-03 06:32:31.65318	2023-08-03 06:32:31.65318
90	Omnis labore optio. Culpa molestias nemo. Voluptatem asperiores tenetur.	\N	54	2023-08-03 06:32:31.658716	2023-08-03 06:32:31.658716
91	Optio dolores enim. Sit non et. Maxime omnis perferendis.	37	\N	2023-08-03 06:32:31.699811	2023-08-03 06:32:31.699811
92	Illum debitis ab. Natus cupiditate ipsum. Deserunt reprehenderit animi.	\N	55	2023-08-03 06:32:31.704993	2023-08-03 06:32:31.704993
93	Aut dicta laudantium. Inventore quis quaerat. Assumenda necessitatibus perspiciatis.	38	\N	2023-08-03 06:32:31.749184	2023-08-03 06:32:31.749184
94	Eum eveniet voluptates. Quidem saepe voluptatem. Placeat eum repellendus.	\N	56	2023-08-03 06:32:31.754978	2023-08-03 06:32:31.754978
95	Aut facere quibusdam. Quae nihil delectus. Molestiae dolore aliquam.	39	\N	2023-08-03 06:32:31.801846	2023-08-03 06:32:31.801846
96	Excepturi dolorem dolore. Debitis porro et. Consequatur asperiores quidem.	\N	57	2023-08-03 06:32:31.806593	2023-08-03 06:32:31.806593
97	Provident quisquam quaerat. Ea quod ad. Quam repudiandae debitis.	40	\N	2023-08-03 06:32:31.851644	2023-08-03 06:32:31.851644
98	Aut et quo. Suscipit velit expedita. Pariatur est non.	\N	58	2023-08-03 06:32:31.857108	2023-08-03 06:32:31.857108
99	Qui tempore quia. Nobis quo eum. Ut accusantium sunt.	41	\N	2023-08-03 06:32:31.895604	2023-08-03 06:32:31.895604
100	Est magnam at. Magnam est aut. Neque distinctio illo.	\N	59	2023-08-03 06:32:31.900822	2023-08-03 06:32:31.900822
101	Sit enim cum. Omnis vel minus. Inventore dolorem molestiae.	42	\N	2023-08-03 06:32:31.946238	2023-08-03 06:32:31.946238
102	Corrupti consectetur ut. Et vitae error. Eveniet quos adipisci.	\N	60	2023-08-03 06:32:31.952157	2023-08-03 06:32:31.952157
103	Hic id consectetur. Consequatur et error. Natus est qui.	\N	61	2023-08-03 06:32:31.977951	2023-08-03 06:32:31.977951
104	Eius voluptatem modi. Saepe numquam praesentium. Odio et non.	43	\N	2023-08-03 06:32:32.017209	2023-08-03 06:32:32.017209
105	Laboriosam omnis esse. Iusto natus autem. Nostrum voluptatibus amet.	\N	62	2023-08-03 06:32:32.021396	2023-08-03 06:32:32.021396
106	Saepe et eligendi. Maxime laudantium eius. Consequatur in harum.	44	\N	2023-08-03 06:32:32.066159	2023-08-03 06:32:32.066159
107	Assumenda aliquid dolor. Accusantium voluptatibus repellendus. Facere odio eos.	\N	63	2023-08-03 06:32:32.070303	2023-08-03 06:32:32.070303
108	Voluptas facilis quo. Eum quidem officiis. Non inventore qui.	45	\N	2023-08-03 06:32:32.11068	2023-08-03 06:32:32.11068
109	Ratione qui sequi. Iste cumque quisquam. Porro quam id.	\N	64	2023-08-03 06:32:32.116865	2023-08-03 06:32:32.116865
110	Beatae repellendus esse. Nisi eaque et. Occaecati aperiam itaque.	\N	65	2023-08-03 06:32:32.143867	2023-08-03 06:32:32.143867
111	Ut qui magni. Fugit dolorem debitis. Eaque et id.	46	\N	2023-08-03 06:32:32.180206	2023-08-03 06:32:32.180206
112	Impedit dolores vel. Est mollitia consequatur. Dolorum repudiandae consequatur.	\N	66	2023-08-03 06:32:32.185267	2023-08-03 06:32:32.185267
113	Inventore id dolorem. Quasi vero sed. Enim tempora dolore.	47	\N	2023-08-03 06:32:32.227199	2023-08-03 06:32:32.227199
114	Sed optio unde. Vel in laborum. Ut dolor tenetur.	\N	67	2023-08-03 06:32:32.232335	2023-08-03 06:32:32.232335
115	Sint assumenda vel. Omnis sit nulla. Ab mollitia harum.	\N	68	2023-08-03 06:32:32.25487	2023-08-03 06:32:32.25487
116	Praesentium nemo itaque. Impedit soluta sequi. Repellat dolore placeat.	48	\N	2023-08-03 06:32:32.298697	2023-08-03 06:32:32.298697
117	Earum quo aut. Incidunt nihil fugiat. Incidunt est necessitatibus.	\N	69	2023-08-03 06:32:32.304287	2023-08-03 06:32:32.304287
118	Quis minus non. Nemo placeat quae. Voluptatem voluptas corporis.	49	\N	2023-08-03 06:32:32.346094	2023-08-03 06:32:32.346094
119	Nesciunt rerum et. Minima itaque numquam. Aut voluptatem aut.	\N	70	2023-08-03 06:32:32.351295	2023-08-03 06:32:32.351295
120	Consectetur voluptas unde. Veniam itaque odio. Fugit eveniet itaque.	50	\N	2023-08-03 06:32:32.398315	2023-08-03 06:32:32.398315
121	Assumenda animi modi. Et aut nostrum. Error ab nemo.	\N	71	2023-08-03 06:32:32.404139	2023-08-03 06:32:32.404139
122	Commodi qui delectus. Molestias vero quo. Dolorem est fuga.	51	\N	2023-08-03 06:32:32.448026	2023-08-03 06:32:32.448026
123	Doloremque possimus corporis. Quidem et nihil. Nihil eos est.	\N	72	2023-08-03 06:32:32.454143	2023-08-03 06:32:32.454143
124	Corporis ut sed. Numquam voluptatibus est. Doloribus quisquam consequatur.	\N	73	2023-08-03 06:32:32.481924	2023-08-03 06:32:32.481924
125	Et explicabo rerum. Necessitatibus ratione dolorum. Fuga facilis itaque.	52	\N	2023-08-03 06:32:32.522382	2023-08-03 06:32:32.522382
126	Aperiam totam dolores. At rerum et. Praesentium adipisci vitae.	\N	74	2023-08-03 06:32:32.527623	2023-08-03 06:32:32.527623
127	Explicabo fuga quo. Quos recusandae nesciunt. Magnam omnis sit.	\N	75	2023-08-03 06:32:32.551963	2023-08-03 06:32:32.551963
128	Praesentium veritatis odit. Vero aut voluptatum. Amet harum quibusdam.	53	\N	2023-08-03 06:32:32.594344	2023-08-03 06:32:32.594344
129	Rerum harum eveniet. Rem id nesciunt. Aut rerum tempora.	\N	76	2023-08-03 06:32:32.598761	2023-08-03 06:32:32.598761
130	Repellendus dolores nisi. Voluptas rerum dolorem. Sunt sequi architecto.	\N	77	2023-08-03 06:32:32.622691	2023-08-03 06:32:32.622691
131	Hic et non. Est delectus beatae. Assumenda ipsum accusamus.	54	\N	2023-08-03 06:32:32.665739	2023-08-03 06:32:32.665739
132	Pariatur et dolor. Numquam est illo. Molestias eum tenetur.	\N	78	2023-08-03 06:32:32.671024	2023-08-03 06:32:32.671024
133	Nostrum itaque dolorem. Ipsa quam harum. Alias distinctio qui.	55	\N	2023-08-03 06:32:32.711956	2023-08-03 06:32:32.711956
134	Et quisquam pariatur. Qui maxime quo. Odit est sed.	\N	79	2023-08-03 06:32:32.718137	2023-08-03 06:32:32.718137
135	Ipsa et maxime. Doloremque libero sunt. Natus ut aut.	\N	80	2023-08-03 06:32:32.744328	2023-08-03 06:32:32.744328
136	Consectetur est et. Numquam magni eaque. Autem iste qui.	56	\N	2023-08-03 06:32:32.79031	2023-08-03 06:32:32.79031
137	Sed velit aut. Omnis enim autem. Optio sint consequuntur.	\N	81	2023-08-03 06:32:32.7963	2023-08-03 06:32:32.7963
138	Tempore suscipit distinctio. Odio et eligendi. Nam doloremque autem.	\N	82	2023-08-03 06:32:32.822118	2023-08-03 06:32:32.822118
139	Aut aspernatur libero. Voluptatibus sint deleniti. Non voluptatem eaque.	57	\N	2023-08-03 06:32:32.870519	2023-08-03 06:32:32.870519
140	Autem laudantium aut. Nulla quidem velit. Voluptatem inventore eos.	\N	83	2023-08-03 06:32:32.87624	2023-08-03 06:32:32.87624
141	Totam molestiae aut. Aliquid laudantium nulla. Vitae aliquam earum.	58	\N	2023-08-03 06:32:32.916574	2023-08-03 06:32:32.916574
142	Voluptatem et ea. Recusandae aspernatur explicabo. Quo minus dolor.	\N	84	2023-08-03 06:32:32.921518	2023-08-03 06:32:32.921518
143	Eius voluptatibus voluptas. Dignissimos eos eaque. Et vitae dignissimos.	\N	85	2023-08-03 06:32:32.945002	2023-08-03 06:32:32.945002
144	Nesciunt veritatis dolorem. Facere consequatur qui. Beatae et fugiat.	59	\N	2023-08-03 06:32:32.981551	2023-08-03 06:32:32.981551
145	Libero minus iste. Esse tempora nihil. Quia sit quisquam.	\N	86	2023-08-03 06:32:32.986896	2023-08-03 06:32:32.986896
146	Quibusdam cum et. Dolorem explicabo veniam. Voluptas optio exercitationem.	\N	87	2023-08-03 06:32:33.011331	2023-08-03 06:32:33.011331
147	Dicta eveniet tempore. Qui sapiente aut. Eligendi expedita omnis.	60	\N	2023-08-03 06:32:33.048668	2023-08-03 06:32:33.048668
148	Ipsam quaerat nihil. Provident ipsum amet. Iste tenetur voluptatem.	\N	88	2023-08-03 06:32:33.054374	2023-08-03 06:32:33.054374
149	Atque rerum omnis. Ullam suscipit reiciendis. Eveniet itaque ducimus.	\N	89	2023-08-03 06:32:33.075469	2023-08-03 06:32:33.075469
150	Maiores cupiditate minima. Iste ex autem. Ullam impedit nobis.	61	\N	2023-08-03 06:32:33.123375	2023-08-03 06:32:33.123375
151	Voluptatem sint voluptates. Ex error ipsum. Iure eos nesciunt.	\N	90	2023-08-03 06:32:33.128677	2023-08-03 06:32:33.128677
152	Voluptatem nihil beatae. Illo ut est. Dignissimos velit inventore.	\N	91	2023-08-03 06:32:33.157451	2023-08-03 06:32:33.157451
153	Tenetur odio odit. Qui quibusdam exercitationem. Minima laboriosam quidem.	62	\N	2023-08-03 06:32:33.210059	2023-08-03 06:32:33.210059
154	Aspernatur placeat maiores. Nobis ex vero. Adipisci quo unde.	\N	92	2023-08-03 06:32:33.215659	2023-08-03 06:32:33.215659
155	Illo sequi enim. Quas beatae rerum. Et ea autem.	\N	93	2023-08-03 06:32:33.239451	2023-08-03 06:32:33.239451
156	Laborum sequi cupiditate. Asperiores necessitatibus earum. Voluptatem sunt voluptates.	63	\N	2023-08-03 06:32:33.285294	2023-08-03 06:32:33.285294
157	Laudantium quo amet. Asperiores et qui. Et non rem.	\N	94	2023-08-03 06:32:33.289792	2023-08-03 06:32:33.289792
158	Deserunt suscipit corrupti. Qui quod et. Est blanditiis rerum.	64	\N	2023-08-03 06:32:33.3323	2023-08-03 06:32:33.3323
159	Similique asperiores iusto. Vel sit ut. Illum amet et.	\N	95	2023-08-03 06:32:33.338466	2023-08-03 06:32:33.338466
160	Ratione id est. Accusantium quae ab. Sunt sint in.	\N	96	2023-08-03 06:32:33.366558	2023-08-03 06:32:33.366558
161	Nam sint non. Dolore odio et. Ad accusantium quam.	65	\N	2023-08-03 06:32:33.405721	2023-08-03 06:32:33.405721
162	Occaecati labore inventore. Incidunt ut in. Eos omnis magnam.	\N	97	2023-08-03 06:32:33.411827	2023-08-03 06:32:33.411827
163	Ut enim quisquam. Et rerum est. Quae aut accusamus.	\N	98	2023-08-03 06:32:33.434839	2023-08-03 06:32:33.434839
164	Nihil quasi illo. Itaque unde enim. Quis ut esse.	66	\N	2023-08-03 06:32:33.484893	2023-08-03 06:32:33.484893
165	Rerum exercitationem nostrum. Adipisci voluptatum unde. Necessitatibus fugit nostrum.	\N	99	2023-08-03 06:32:33.491225	2023-08-03 06:32:33.491225
166	Voluptatem et amet. Saepe voluptatem a. Qui possimus quia.	67	\N	2023-08-03 06:32:33.539614	2023-08-03 06:32:33.539614
167	Cumque sit excepturi. Eum quae amet. Numquam aut et.	\N	100	2023-08-03 06:32:33.545803	2023-08-03 06:32:33.545803
168	Facere consequatur pariatur. Perferendis et ratione. Quaerat necessitatibus aut.	68	\N	2023-08-03 06:32:33.590944	2023-08-03 06:32:33.590944
169	Mollitia ut nulla. In quidem eum. Temporibus minima accusantium.	\N	101	2023-08-03 06:32:33.596553	2023-08-03 06:32:33.596553
170	Inventore earum sunt. Enim voluptatem provident. Autem aut doloremque.	\N	102	2023-08-03 06:32:33.620783	2023-08-03 06:32:33.620783
171	Maxime natus velit. Et explicabo ex. Ex sapiente in.	69	\N	2023-08-03 06:32:33.665033	2023-08-03 06:32:33.665033
172	Molestiae cupiditate similique. Temporibus ratione voluptate. In atque ex.	\N	103	2023-08-03 06:32:33.670175	2023-08-03 06:32:33.670175
173	Iure ut minima. Tempora recusandae illo. Aut quo fuga.	70	\N	2023-08-03 06:32:33.722948	2023-08-03 06:32:33.722948
174	Debitis autem omnis. Repellat explicabo mollitia. Eaque mollitia iste.	\N	104	2023-08-03 06:32:33.729311	2023-08-03 06:32:33.729311
175	Excepturi rerum alias. Aut maiores animi. Eius ad voluptatem.	\N	105	2023-08-03 06:32:33.757609	2023-08-03 06:32:33.757609
176	Quo impedit qui. Qui et occaecati. Eum labore sapiente.	71	\N	2023-08-03 06:32:33.801198	2023-08-03 06:32:33.801198
177	Ut eos labore. Voluptatem molestias corporis. Consequatur pariatur quidem.	\N	106	2023-08-03 06:32:33.805959	2023-08-03 06:32:33.805959
178	Dolor placeat repudiandae. Perspiciatis nostrum porro. Totam ad alias.	\N	107	2023-08-03 06:32:33.831169	2023-08-03 06:32:33.831169
179	Doloremque rerum et. Suscipit aspernatur libero. Autem dolores molestiae.	72	\N	2023-08-03 06:32:33.874639	2023-08-03 06:32:33.874639
180	Consequatur ad quia. Omnis laboriosam dolor. Enim earum placeat.	\N	108	2023-08-03 06:32:33.880395	2023-08-03 06:32:33.880395
181	Cumque architecto neque. Aliquid debitis nostrum. Voluptatem et est.	73	\N	2023-08-03 06:32:33.923928	2023-08-03 06:32:33.923928
182	Commodi odit cum. Quibusdam dolorem necessitatibus. Velit doloribus possimus.	\N	109	2023-08-03 06:32:33.928443	2023-08-03 06:32:33.928443
183	Sint ut harum. Dicta in esse. Iste omnis quisquam.	\N	110	2023-08-03 06:32:33.953579	2023-08-03 06:32:33.953579
184	Ut tempora at. Sint eaque est. Possimus ipsum totam.	74	\N	2023-08-03 06:32:34.004611	2023-08-03 06:32:34.004611
185	Sit voluptatem veritatis. Qui impedit debitis. Quo tempore quibusdam.	\N	111	2023-08-03 06:32:34.010181	2023-08-03 06:32:34.010181
186	Et cupiditate modi. Consequatur cum accusantium. Voluptatem ut odio.	\N	112	2023-08-03 06:32:34.034965	2023-08-03 06:32:34.034965
187	Voluptas rerum ex. Maiores laboriosam ullam. Commodi quae et.	75	\N	2023-08-03 06:32:34.079949	2023-08-03 06:32:34.079949
188	Cumque quas sit. Beatae perferendis adipisci. Modi nobis aut.	\N	113	2023-08-03 06:32:34.085282	2023-08-03 06:32:34.085282
189	Unde quia sit. Esse molestiae consectetur. Et sint id.	\N	114	2023-08-03 06:32:34.11111	2023-08-03 06:32:34.11111
190	Ratione nihil dolor. Rerum quibusdam modi. Fuga animi voluptatem.	76	\N	2023-08-03 06:32:34.160279	2023-08-03 06:32:34.160279
191	Est ut provident. Iste necessitatibus maiores. Impedit hic iste.	\N	115	2023-08-03 06:32:34.165675	2023-08-03 06:32:34.165675
192	Ea vel maxime. Omnis consequuntur dicta. Et nesciunt ea.	77	\N	2023-08-03 06:32:34.212517	2023-08-03 06:32:34.212517
193	Autem dolor eveniet. Illo et voluptatem. Id veritatis magnam.	\N	116	2023-08-03 06:32:34.217586	2023-08-03 06:32:34.217586
194	Voluptatem consequatur provident. Ipsum esse consequatur. Molestias dolor ad.	78	\N	2023-08-03 06:32:34.264327	2023-08-03 06:32:34.264327
195	Accusantium voluptas voluptatum. Repudiandae commodi est. Et sint qui.	\N	117	2023-08-03 06:32:34.270465	2023-08-03 06:32:34.270465
196	Et velit ut. Quo laborum incidunt. Aut quia et.	\N	118	2023-08-03 06:32:34.30046	2023-08-03 06:32:34.30046
197	Eos assumenda qui. Porro non at. Inventore nihil cumque.	79	\N	2023-08-03 06:32:34.3428	2023-08-03 06:32:34.3428
198	Repellat eos ea. A amet sed. Dicta omnis ratione.	\N	119	2023-08-03 06:32:34.349021	2023-08-03 06:32:34.349021
199	Aperiam accusamus et. Nihil consequuntur quidem. Iure dolorem rerum.	\N	120	2023-08-03 06:32:34.374995	2023-08-03 06:32:34.374995
200	Aut sunt eos. Iure magnam eligendi. Ut ab unde.	80	\N	2023-08-03 06:32:34.419506	2023-08-03 06:32:34.419506
201	Qui est repudiandae. Delectus veniam labore. Voluptas aut non.	\N	121	2023-08-03 06:32:34.42525	2023-08-03 06:32:34.42525
202	Eligendi incidunt ipsum. A est molestiae. Porro voluptas sapiente.	\N	122	2023-08-03 06:32:34.448347	2023-08-03 06:32:34.448347
203	Eveniet laudantium quia. Molestiae eos unde. Inventore quibusdam commodi.	81	\N	2023-08-03 06:32:34.491747	2023-08-03 06:32:34.491747
204	Aliquam dolorum voluptatum. Eaque fugiat eveniet. Tenetur blanditiis quia.	\N	123	2023-08-03 06:32:34.49608	2023-08-03 06:32:34.49608
205	Quos dolorem reprehenderit. Animi iure ut. Voluptatem aut aliquam.	82	\N	2023-08-03 06:32:34.540323	2023-08-03 06:32:34.540323
206	Et ut optio. Natus blanditiis laborum. Nemo et fuga.	\N	124	2023-08-03 06:32:34.546406	2023-08-03 06:32:34.546406
207	Et omnis aut. Odit vel eveniet. Aut tempore iusto.	\N	125	2023-08-03 06:32:34.575551	2023-08-03 06:32:34.575551
208	Reiciendis sed saepe. Nihil dolore voluptatem. Itaque neque enim.	83	\N	2023-08-03 06:32:34.619188	2023-08-03 06:32:34.619188
209	Et est labore. Aperiam magni et. Veniam voluptas quisquam.	\N	126	2023-08-03 06:32:34.624525	2023-08-03 06:32:34.624525
210	Cum facere omnis. Similique iste voluptas. Omnis ipsum nisi.	84	\N	2023-08-03 06:32:34.673621	2023-08-03 06:32:34.673621
211	Doloremque saepe suscipit. Nobis sunt enim. Doloribus ut qui.	\N	127	2023-08-03 06:32:34.680424	2023-08-03 06:32:34.680424
212	Maiores rem ut. Deleniti ipsam tempore. Atque voluptas at.	85	\N	2023-08-03 06:32:34.73201	2023-08-03 06:32:34.73201
213	Laudantium est repudiandae. Amet sed veritatis. Nemo eveniet et.	\N	128	2023-08-03 06:32:34.737266	2023-08-03 06:32:34.737266
214	Voluptatem placeat velit. Iure distinctio magni. Ex perferendis enim.	86	\N	2023-08-03 06:32:34.784904	2023-08-03 06:32:34.784904
215	Optio sed ex. Minima tempore ratione. Expedita optio ut.	\N	129	2023-08-03 06:32:34.790201	2023-08-03 06:32:34.790201
216	Totam eum voluptate. Consequuntur earum eius. Aut et accusantium.	\N	130	2023-08-03 06:32:34.819038	2023-08-03 06:32:34.819038
217	Amet et error. Saepe in ducimus. Qui et necessitatibus.	87	\N	2023-08-03 06:32:34.865648	2023-08-03 06:32:34.865648
218	Accusantium id autem. Quaerat esse velit. Est quasi mollitia.	\N	131	2023-08-03 06:32:34.872245	2023-08-03 06:32:34.872245
219	Facere qui saepe. Velit praesentium dolor. Dolores quisquam optio.	88	\N	2023-08-03 06:32:34.971634	2023-08-03 06:32:34.971634
220	Ea aut assumenda. Doloribus adipisci consequatur. Laudantium alias eum.	\N	132	2023-08-03 06:32:34.97825	2023-08-03 06:32:34.97825
221	Sed blanditiis labore. Odio mollitia dignissimos. Voluptates tempore dolorem.	\N	133	2023-08-03 06:32:35.019516	2023-08-03 06:32:35.019516
222	Numquam consequatur minima. Et reprehenderit ut. Et a est.	89	\N	2023-08-03 06:32:35.07209	2023-08-03 06:32:35.07209
223	Neque sed maiores. Molestiae totam nulla. Repellendus expedita laborum.	\N	134	2023-08-03 06:32:35.078019	2023-08-03 06:32:35.078019
224	Deserunt impedit distinctio. Aperiam tempore officiis. Ut harum modi.	90	\N	2023-08-03 06:32:35.120978	2023-08-03 06:32:35.120978
225	Distinctio ullam sunt. Sed sint dolor. Saepe hic et.	\N	135	2023-08-03 06:32:35.125332	2023-08-03 06:32:35.125332
226	Corporis aperiam voluptas. Eum consequuntur iusto. Eius velit cumque.	\N	136	2023-08-03 06:32:35.147021	2023-08-03 06:32:35.147021
227	Accusamus eos laudantium. Quam ut asperiores. Beatae molestiae sapiente.	91	\N	2023-08-03 06:32:35.201034	2023-08-03 06:32:35.201034
228	Inventore ea esse. Saepe neque et. Tempora voluptatem voluptatem.	\N	137	2023-08-03 06:32:35.217129	2023-08-03 06:32:35.217129
229	Asperiores porro quia. Quia doloremque tempore. Ducimus minima eaque.	\N	138	2023-08-03 06:32:35.248443	2023-08-03 06:32:35.248443
230	Et ut iure. Exercitationem possimus sint. Quia itaque totam.	92	\N	2023-08-03 06:32:35.29265	2023-08-03 06:32:35.29265
231	Ea quas in. Blanditiis alias omnis. Rerum nihil nam.	\N	139	2023-08-03 06:32:35.300225	2023-08-03 06:32:35.300225
232	Odit voluptates perspiciatis. Error asperiores quidem. Deleniti qui aut.	93	\N	2023-08-03 06:32:35.364173	2023-08-03 06:32:35.364173
233	Molestias amet dicta. Sed tempora accusamus. In aliquam sint.	\N	140	2023-08-03 06:32:35.375765	2023-08-03 06:32:35.375765
234	Sed ex assumenda. Perspiciatis autem tempora. Impedit explicabo consequatur.	94	\N	2023-08-03 06:32:35.447881	2023-08-03 06:32:35.447881
235	Enim itaque nihil. Quae qui reiciendis. Deleniti autem sit.	\N	141	2023-08-03 06:32:35.459004	2023-08-03 06:32:35.459004
236	Nihil voluptatem quibusdam. Libero laboriosam aut. Sed enim consequatur.	\N	142	2023-08-03 06:32:35.491913	2023-08-03 06:32:35.491913
237	Perferendis odit molestias. Veniam commodi voluptatem. Et incidunt voluptatem.	95	\N	2023-08-03 06:32:35.542778	2023-08-03 06:32:35.542778
238	Veniam modi inventore. Et repellendus incidunt. Debitis architecto dolor.	\N	143	2023-08-03 06:32:35.548735	2023-08-03 06:32:35.548735
239	Incidunt provident dignissimos. Ut eveniet enim. Dolor reiciendis et.	96	\N	2023-08-03 06:32:35.593217	2023-08-03 06:32:35.593217
240	Omnis ut atque. Consequatur aut dolore. Maiores et voluptatibus.	\N	144	2023-08-03 06:32:35.598944	2023-08-03 06:32:35.598944
241	Mollitia sint occaecati. Ut in architecto. Consequuntur voluptas eveniet.	97	\N	2023-08-03 06:32:35.648788	2023-08-03 06:32:35.648788
242	Culpa sequi harum. Eius dolores porro. Rerum quae omnis.	\N	145	2023-08-03 06:32:35.655608	2023-08-03 06:32:35.655608
243	Eligendi odio reprehenderit. Sint perspiciatis voluptatem. Eligendi eveniet qui.	\N	146	2023-08-03 06:32:35.684401	2023-08-03 06:32:35.684401
244	Cum accusantium voluptas. Et sit quisquam. Doloremque molestiae id.	98	\N	2023-08-03 06:32:35.729815	2023-08-03 06:32:35.729815
245	Rerum ut repudiandae. Laudantium qui similique. Autem explicabo aperiam.	\N	147	2023-08-03 06:32:35.735379	2023-08-03 06:32:35.735379
246	Neque et dolore. Ea sunt aut. Sint unde molestiae.	99	\N	2023-08-03 06:32:35.778315	2023-08-03 06:32:35.778315
247	Sed et voluptas. Odio ut cum. Et deleniti consequuntur.	\N	148	2023-08-03 06:32:35.783752	2023-08-03 06:32:35.783752
248	Aut voluptas adipisci. Tenetur porro qui. Dolor maiores voluptatem.	\N	149	2023-08-03 06:32:35.805342	2023-08-03 06:32:35.805342
249	Officiis iure est. Est possimus eaque. Sint voluptatibus occaecati.	100	\N	2023-08-03 06:32:35.857502	2023-08-03 06:32:35.857502
250	Consectetur et distinctio. Officiis id similique. Quis est quaerat.	\N	150	2023-08-03 06:32:35.862893	2023-08-03 06:32:35.862893
251	Qui id iusto. Expedita qui voluptatum. Optio aliquam non.	101	\N	2023-08-03 06:32:35.903982	2023-08-03 06:32:35.903982
252	Voluptates doloribus recusandae. Harum qui tempore. Cumque eum assumenda.	\N	151	2023-08-03 06:32:35.9095	2023-08-03 06:32:35.9095
253	Aut magnam deserunt. Animi saepe neque. Nam sit et.	102	\N	2023-08-03 06:32:35.948658	2023-08-03 06:32:35.948658
254	Eveniet harum a. Cumque eum sit. Quia totam quam.	\N	152	2023-08-03 06:32:35.954052	2023-08-03 06:32:35.954052
255	Voluptas nam minima. Et dolore nihil. Voluptatem voluptatum laudantium.	\N	153	2023-08-03 06:32:35.978888	2023-08-03 06:32:35.978888
256	Quo porro fugiat. Deleniti inventore rerum. Nihil repellendus magni.	103	\N	2023-08-03 06:32:36.021157	2023-08-03 06:32:36.021157
257	Et voluptas debitis. Error eos sapiente. Deserunt at rerum.	\N	154	2023-08-03 06:32:36.025554	2023-08-03 06:32:36.025554
258	Nulla corrupti sit. Ratione corrupti cupiditate. Rem corrupti ullam.	104	\N	2023-08-03 06:32:36.068659	2023-08-03 06:32:36.068659
259	Quae quisquam est. Excepturi animi consequuntur. Rerum aperiam quis.	\N	155	2023-08-03 06:32:36.074071	2023-08-03 06:32:36.074071
260	A ut qui. Excepturi non et. Neque laborum sit.	105	\N	2023-08-03 06:32:36.131187	2023-08-03 06:32:36.131187
261	Qui qui et. Eos illum hic. Mollitia quia rerum.	\N	156	2023-08-03 06:32:36.139456	2023-08-03 06:32:36.139456
262	Assumenda aut sunt. Distinctio doloremque pariatur. Quasi possimus quia.	106	\N	2023-08-03 06:32:36.191923	2023-08-03 06:32:36.191923
263	Ut est ut. Incidunt fugit soluta. Dolorum provident deserunt.	\N	157	2023-08-03 06:32:36.198045	2023-08-03 06:32:36.198045
264	Et laudantium iusto. Explicabo veniam beatae. Similique fugit sed.	107	\N	2023-08-03 06:32:36.235246	2023-08-03 06:32:36.235246
265	Eveniet harum repudiandae. Magni ullam earum. Quis alias officiis.	\N	158	2023-08-03 06:32:36.240889	2023-08-03 06:32:36.240889
266	Aut aspernatur tenetur. Quisquam ducimus nam. Neque nulla iste.	108	\N	2023-08-03 06:32:36.284981	2023-08-03 06:32:36.284981
267	Eligendi non dolorem. Tempora quos voluptate. Error dolores ut.	\N	159	2023-08-03 06:32:36.289222	2023-08-03 06:32:36.289222
268	Aut sequi rerum. Reiciendis repudiandae a. Est magnam quasi.	109	\N	2023-08-03 06:32:36.336199	2023-08-03 06:32:36.336199
269	Ea et sed. Architecto ab placeat. Dolorem perferendis modi.	\N	160	2023-08-03 06:32:36.341094	2023-08-03 06:32:36.341094
270	Non soluta eaque. Autem sit nihil. Ipsa est officiis.	110	\N	2023-08-03 06:32:36.381307	2023-08-03 06:32:36.381307
271	Autem exercitationem necessitatibus. Repellendus laudantium atque. Quia voluptatum sit.	\N	161	2023-08-03 06:32:36.386541	2023-08-03 06:32:36.386541
272	Doloribus sed quaerat. Itaque ut possimus. Voluptatibus voluptatum qui.	\N	162	2023-08-03 06:32:36.406646	2023-08-03 06:32:36.406646
273	Quia perspiciatis deserunt. Temporibus est eos. Ea et ut.	111	\N	2023-08-03 06:32:36.450004	2023-08-03 06:32:36.450004
274	Quis quibusdam sed. Voluptas qui aut. Eos qui officiis.	\N	163	2023-08-03 06:32:36.45536	2023-08-03 06:32:36.45536
275	Recusandae reprehenderit et. Expedita aut eius. Et ea consequatur.	112	\N	2023-08-03 06:32:36.496514	2023-08-03 06:32:36.496514
276	Nemo amet laborum. Placeat libero saepe. Nulla minima dicta.	\N	164	2023-08-03 06:32:36.504317	2023-08-03 06:32:36.504317
277	Odit sed velit. Omnis molestiae voluptate. Quisquam adipisci ut.	\N	165	2023-08-03 06:32:36.559457	2023-08-03 06:32:36.559457
278	Eaque quisquam consequuntur. Aliquid commodi libero. Voluptatibus aliquam quibusdam.	113	\N	2023-08-03 06:32:36.616883	2023-08-03 06:32:36.616883
279	Esse qui aliquid. Eaque in adipisci. Explicabo id totam.	\N	166	2023-08-03 06:32:36.624885	2023-08-03 06:32:36.624885
280	Veritatis nulla consequuntur. Ex repellendus eaque. Rerum qui est.	114	\N	2023-08-03 06:32:36.671077	2023-08-03 06:32:36.671077
281	Doloribus atque nihil. Tenetur aperiam laudantium. Libero beatae ut.	\N	167	2023-08-03 06:32:36.676449	2023-08-03 06:32:36.676449
282	Ad est sit. Consequatur ut exercitationem. Ut facilis in.	115	\N	2023-08-03 06:32:36.715874	2023-08-03 06:32:36.715874
283	Delectus qui sunt. Dolores quod aliquid. Vel et ratione.	\N	168	2023-08-03 06:32:36.721533	2023-08-03 06:32:36.721533
284	Aut dolorem ut. Placeat recusandae aperiam. Facere quia consequatur.	116	\N	2023-08-03 06:32:36.785342	2023-08-03 06:32:36.785342
285	Quas sequi odio. Voluptas sed hic. Cumque reiciendis nesciunt.	\N	169	2023-08-03 06:32:36.791285	2023-08-03 06:32:36.791285
286	Maxime adipisci similique. Sint et sed. Iusto ea mollitia.	117	\N	2023-08-03 06:32:36.837784	2023-08-03 06:32:36.837784
287	Earum aut temporibus. Mollitia praesentium labore. Quas voluptates commodi.	\N	170	2023-08-03 06:32:36.844262	2023-08-03 06:32:36.844262
288	Nostrum ipsa sequi. Hic inventore qui. Sequi consectetur atque.	118	\N	2023-08-03 06:32:36.898012	2023-08-03 06:32:36.898012
289	Nam beatae et. Ut et eveniet. Consectetur molestias voluptates.	\N	171	2023-08-03 06:32:36.903012	2023-08-03 06:32:36.903012
290	Similique iste dolor. Minus omnis beatae. Accusamus non eum.	119	\N	2023-08-03 06:32:36.953373	2023-08-03 06:32:36.953373
291	Sit qui voluptates. Facilis perspiciatis dolorem. Eos asperiores atque.	\N	172	2023-08-03 06:32:36.958582	2023-08-03 06:32:36.958582
292	Cumque eos provident. Quod et fugit. Ipsa laboriosam praesentium.	120	\N	2023-08-03 06:32:37.014064	2023-08-03 06:32:37.014064
293	Adipisci omnis sed. Laudantium et eaque. Aut minima illum.	\N	173	2023-08-03 06:32:37.019853	2023-08-03 06:32:37.019853
294	Ipsum enim sunt. Necessitatibus ut est. Expedita dolorem sit.	121	\N	2023-08-03 06:32:37.071151	2023-08-03 06:32:37.071151
295	Dolore quia sed. Expedita qui quasi. Aut aut ut.	\N	174	2023-08-03 06:32:37.077367	2023-08-03 06:32:37.077367
296	Et quasi modi. Quia dolorem non. Quo eos voluptatem.	\N	175	2023-08-03 06:32:37.116546	2023-08-03 06:32:37.116546
297	Ut ratione consequatur. Quia aperiam aut. Omnis neque quia.	122	\N	2023-08-03 06:32:37.166592	2023-08-03 06:32:37.166592
298	Eum veritatis dolorem. Veniam voluptas debitis. Tempore libero voluptatem.	\N	176	2023-08-03 06:32:37.172415	2023-08-03 06:32:37.172415
299	Deserunt recusandae corrupti. Ullam doloremque dicta. Nam quo sit.	\N	177	2023-08-03 06:32:37.20397	2023-08-03 06:32:37.20397
300	Eos perferendis deleniti. Laborum recusandae in. Id amet voluptatem.	123	\N	2023-08-03 06:32:37.256118	2023-08-03 06:32:37.256118
301	Aperiam non facere. Ipsam molestias et. Voluptatum excepturi minus.	\N	178	2023-08-03 06:32:37.262691	2023-08-03 06:32:37.262691
302	Sed neque voluptatem. Sed earum voluptas. Excepturi praesentium ab.	\N	179	2023-08-03 06:32:37.292399	2023-08-03 06:32:37.292399
303	Deleniti ipsum fuga. Magni qui odit. Voluptas odit dolore.	124	\N	2023-08-03 06:32:37.336716	2023-08-03 06:32:37.336716
304	Quibusdam earum soluta. Aut dolore saepe. Consequatur iure nihil.	\N	180	2023-08-03 06:32:37.341508	2023-08-03 06:32:37.341508
305	A consequatur eum. Explicabo libero porro. Atque at error.	\N	181	2023-08-03 06:32:37.368776	2023-08-03 06:32:37.368776
306	Aliquam expedita animi. Similique unde voluptatum. Molestiae veritatis autem.	125	\N	2023-08-03 06:32:37.410881	2023-08-03 06:32:37.410881
307	Dicta amet laudantium. Quam eos dolor. Consectetur similique tenetur.	\N	182	2023-08-03 06:32:37.416472	2023-08-03 06:32:37.416472
308	Totam sed quod. Fuga accusantium totam. Nulla consequatur fuga.	126	\N	2023-08-03 06:32:37.462096	2023-08-03 06:32:37.462096
309	Possimus ab quam. Doloremque officiis necessitatibus. Explicabo ea aut.	\N	183	2023-08-03 06:32:37.468141	2023-08-03 06:32:37.468141
310	Iure omnis voluptas. Et itaque rerum. Ut ea molestias.	127	\N	2023-08-03 06:32:37.511874	2023-08-03 06:32:37.511874
311	In ut quia. Harum mollitia quisquam. Dolor omnis et.	\N	184	2023-08-03 06:32:37.517384	2023-08-03 06:32:37.517384
312	Dolorem ut minima. Ipsam quod rerum. Omnis voluptatem illum.	128	\N	2023-08-03 06:32:37.556961	2023-08-03 06:32:37.556961
313	Laborum ea enim. In molestias nulla. Consequatur rem quia.	\N	185	2023-08-03 06:32:37.562582	2023-08-03 06:32:37.562582
314	Quae aut ducimus. Est laboriosam vel. Beatae magni vero.	129	\N	2023-08-03 06:32:37.61084	2023-08-03 06:32:37.61084
315	Reiciendis dolores nulla. Eum impedit cupiditate. Qui voluptatem voluptas.	\N	186	2023-08-03 06:32:37.618384	2023-08-03 06:32:37.618384
316	Sint aliquid voluptatem. Sit ab perspiciatis. Nam sed id.	\N	187	2023-08-03 06:32:37.64093	2023-08-03 06:32:37.64093
317	Delectus voluptas et. Sed fuga nemo. Adipisci et qui.	130	\N	2023-08-03 06:32:37.689062	2023-08-03 06:32:37.689062
318	Dolor iste corrupti. Repellat explicabo et. Ipsam repudiandae alias.	\N	188	2023-08-03 06:32:37.694269	2023-08-03 06:32:37.694269
319	Maxime earum tempore. Labore ut ab. Veniam sed sunt.	131	\N	2023-08-03 06:32:37.732869	2023-08-03 06:32:37.732869
320	Optio possimus rerum. Qui omnis sunt. Eaque fuga aliquam.	\N	189	2023-08-03 06:32:37.738303	2023-08-03 06:32:37.738303
321	Dolore ut quis. Laboriosam minus hic. Quo voluptatibus sit.	132	\N	2023-08-03 06:32:37.779202	2023-08-03 06:32:37.779202
322	Et non ea. Debitis libero et. Quidem debitis ipsa.	\N	190	2023-08-03 06:32:37.784575	2023-08-03 06:32:37.784575
323	Nostrum sed facere. Qui eveniet quis. Dolores at rerum.	133	\N	2023-08-03 06:32:37.828511	2023-08-03 06:32:37.828511
324	Aliquid omnis omnis. Iste non nisi. Tempore reiciendis delectus.	\N	191	2023-08-03 06:32:37.833621	2023-08-03 06:32:37.833621
325	Nobis voluptatum nam. Et necessitatibus voluptatem. Sit libero consequuntur.	\N	192	2023-08-03 06:32:37.856965	2023-08-03 06:32:37.856965
326	Tempora deleniti debitis. Excepturi quis velit. Facilis quibusdam sapiente.	134	\N	2023-08-03 06:32:37.895885	2023-08-03 06:32:37.895885
327	Distinctio dolore sed. Et corrupti qui. Nihil eligendi facilis.	\N	193	2023-08-03 06:32:37.900993	2023-08-03 06:32:37.900993
328	Corrupti quia minima. Numquam sed eveniet. Deleniti accusantium quasi.	\N	194	2023-08-03 06:32:37.921573	2023-08-03 06:32:37.921573
329	Quis ad rerum. Ex fuga nisi. Asperiores vitae repellat.	135	\N	2023-08-03 06:32:37.966454	2023-08-03 06:32:37.966454
330	Eius rerum sed. Ut esse et. Itaque excepturi ipsam.	\N	195	2023-08-03 06:32:37.971788	2023-08-03 06:32:37.971788
331	Sequi necessitatibus dolor. Praesentium perspiciatis odio. Tempora id adipisci.	136	\N	2023-08-03 06:32:38.014699	2023-08-03 06:32:38.014699
332	Et et ipsum. Voluptas ullam amet. Est dolor et.	\N	196	2023-08-03 06:32:38.02039	2023-08-03 06:32:38.02039
333	Est et eum. Dolorum in eveniet. Temporibus mollitia libero.	137	\N	2023-08-03 06:32:38.078294	2023-08-03 06:32:38.078294
334	Cum voluptates similique. Reprehenderit magni unde. Consequatur magnam dolor.	\N	197	2023-08-03 06:32:38.084437	2023-08-03 06:32:38.084437
335	Et unde asperiores. Exercitationem pariatur sunt. Aut sed optio.	\N	198	2023-08-03 06:32:38.127131	2023-08-03 06:32:38.127131
336	Aut ea quisquam. Nobis ad voluptates. Porro possimus error.	138	\N	2023-08-03 06:32:38.185781	2023-08-03 06:32:38.185781
337	Dolores est accusantium. Nam adipisci ipsam. Vitae quibusdam quidem.	\N	199	2023-08-03 06:32:38.191149	2023-08-03 06:32:38.191149
338	Et ex quam. Ut quaerat nihil. Earum pariatur tenetur.	\N	200	2023-08-03 06:32:38.216993	2023-08-03 06:32:38.216993
339	Aut quo aspernatur. Voluptate itaque voluptatem. Autem veritatis repellendus.	139	\N	2023-08-03 06:32:38.26232	2023-08-03 06:32:38.26232
340	Accusamus consectetur non. Eum sit culpa. Quia sit quod.	\N	201	2023-08-03 06:32:38.267984	2023-08-03 06:32:38.267984
341	Illum voluptas impedit. Sit iure magni. Molestiae ducimus voluptatum.	\N	202	2023-08-03 06:32:38.297844	2023-08-03 06:32:38.297844
342	Quia maiores doloremque. Fugiat officiis quasi. Quos ab et.	140	\N	2023-08-03 06:32:38.347082	2023-08-03 06:32:38.347082
343	Consequatur ratione alias. Qui consequatur non. Aut ipsum quae.	\N	203	2023-08-03 06:32:38.352502	2023-08-03 06:32:38.352502
344	Recusandae sunt sed. Esse rerum quia. Voluptatem in laudantium.	141	\N	2023-08-03 06:32:38.395352	2023-08-03 06:32:38.395352
345	Optio vero aut. Quis beatae aliquid. Dignissimos ut soluta.	\N	204	2023-08-03 06:32:38.401032	2023-08-03 06:32:38.401032
346	Vel est quia. Iusto atque praesentium. In cupiditate odio.	142	\N	2023-08-03 06:32:38.448155	2023-08-03 06:32:38.448155
347	Nulla suscipit maiores. Ipsum necessitatibus quia. Excepturi adipisci autem.	\N	205	2023-08-03 06:32:38.453367	2023-08-03 06:32:38.453367
348	Vero ullam consequatur. Eos quidem perferendis. Quia est explicabo.	\N	206	2023-08-03 06:32:38.476115	2023-08-03 06:32:38.476115
349	Id iure ut. Unde amet totam. Ipsa quas sint.	143	\N	2023-08-03 06:32:38.522209	2023-08-03 06:32:38.522209
350	Voluptates aut dolorum. Repudiandae consequatur recusandae. Et aut amet.	\N	207	2023-08-03 06:32:38.528521	2023-08-03 06:32:38.528521
351	Et impedit doloremque. Quae repellendus qui. Ut ratione non.	144	\N	2023-08-03 06:32:38.569634	2023-08-03 06:32:38.569634
352	Ut optio voluptates. Voluptatem sint occaecati. Aut quos eveniet.	\N	208	2023-08-03 06:32:38.574992	2023-08-03 06:32:38.574992
353	Neque quaerat magni. Et et blanditiis. Sit nobis voluptas.	145	\N	2023-08-03 06:32:38.621388	2023-08-03 06:32:38.621388
354	Eum perferendis explicabo. Vel ut praesentium. Architecto nemo aut.	\N	209	2023-08-03 06:32:38.626815	2023-08-03 06:32:38.626815
355	Debitis reprehenderit quos. Ducimus in eos. Esse dicta qui.	146	\N	2023-08-03 06:32:38.673152	2023-08-03 06:32:38.673152
356	Veritatis rem voluptas. Dolor sed voluptatem. Qui molestias sint.	\N	210	2023-08-03 06:32:38.678582	2023-08-03 06:32:38.678582
357	Molestiae praesentium consequatur. Nobis voluptatem nihil. Blanditiis eligendi cumque.	\N	211	2023-08-03 06:32:38.705799	2023-08-03 06:32:38.705799
358	Deleniti officiis id. Neque architecto eveniet. Consequatur a aut.	147	\N	2023-08-03 06:32:38.745599	2023-08-03 06:32:38.745599
359	Eos ut porro. Reiciendis quia voluptatem. Eos minima id.	\N	212	2023-08-03 06:32:38.751141	2023-08-03 06:32:38.751141
360	Quisquam iste sit. Enim ad rerum. Praesentium libero aliquid.	\N	213	2023-08-03 06:32:38.77438	2023-08-03 06:32:38.77438
361	Ea sequi et. Commodi molestias laudantium. In et voluptatem.	148	\N	2023-08-03 06:32:38.816768	2023-08-03 06:32:38.816768
362	Id facilis exercitationem. Tenetur et non. Dolores qui voluptate.	\N	214	2023-08-03 06:32:38.822084	2023-08-03 06:32:38.822084
363	Sed qui culpa. Voluptatum distinctio vel. Unde iure ut.	149	\N	2023-08-03 06:32:38.867018	2023-08-03 06:32:38.867018
364	Inventore id consequatur. Delectus ut ducimus. Ratione totam occaecati.	\N	215	2023-08-03 06:32:38.87239	2023-08-03 06:32:38.87239
365	Veniam excepturi voluptatibus. Rerum nisi sit. Et aut praesentium.	150	\N	2023-08-03 06:32:39.508477	2023-08-03 06:32:39.508477
366	Possimus dignissimos dolorum. Veritatis iusto asperiores. Et natus culpa.	\N	216	2023-08-03 06:32:39.513857	2023-08-03 06:32:39.513857
367	Distinctio dolores adipisci. Quia deleniti quae. Eos sint dolor.	151	\N	2023-08-03 06:32:39.542606	2023-08-03 06:32:39.542606
368	Consequuntur sed omnis. Eveniet architecto distinctio. Voluptatem minima exercitationem.	\N	217	2023-08-03 06:32:39.548001	2023-08-03 06:32:39.548001
369	Aliquam ullam delectus. Voluptatem perferendis exercitationem. Repellat esse autem.	152	\N	2023-08-03 06:32:39.583837	2023-08-03 06:32:39.583837
370	Nihil quia explicabo. Consequatur libero commodi. Eveniet incidunt corporis.	\N	218	2023-08-03 06:32:39.589003	2023-08-03 06:32:39.589003
371	Tempora autem qui. Dolorem eveniet in. Iste excepturi et.	153	\N	2023-08-03 06:32:39.619267	2023-08-03 06:32:39.619267
372	Natus et sint. Dolorem esse in. Excepturi natus ex.	\N	219	2023-08-03 06:32:39.624634	2023-08-03 06:32:39.624634
373	Officiis amet fuga. Cupiditate et repudiandae. Eaque consectetur sint.	154	\N	2023-08-03 06:32:39.660591	2023-08-03 06:32:39.660591
374	Et harum incidunt. Neque voluptas vel. Qui repudiandae esse.	\N	220	2023-08-03 06:32:39.669538	2023-08-03 06:32:39.669538
375	Dolor eos aut. Et expedita ullam. Aut distinctio unde.	155	\N	2023-08-03 06:32:39.727806	2023-08-03 06:32:39.727806
376	Assumenda fugit accusantium. Ab magni rerum. Suscipit magnam dolores.	\N	221	2023-08-03 06:32:39.733154	2023-08-03 06:32:39.733154
377	Consequuntur debitis non. Quis omnis quas. Magni dolores sed.	156	\N	2023-08-03 06:32:39.765579	2023-08-03 06:32:39.765579
378	Omnis quis perferendis. Esse temporibus sit. Dicta vitae nihil.	\N	222	2023-08-03 06:32:39.770836	2023-08-03 06:32:39.770836
379	Est tenetur sint. Dolor debitis numquam. Officia eos dolorum.	157	\N	2023-08-03 06:32:39.806743	2023-08-03 06:32:39.806743
380	Veniam rerum officiis. Ducimus quaerat asperiores. Nesciunt quis veniam.	\N	223	2023-08-03 06:32:39.811827	2023-08-03 06:32:39.811827
381	Officiis inventore dolorem. Nemo soluta vel. Reprehenderit ipsum hic.	158	\N	2023-08-03 06:32:39.847959	2023-08-03 06:32:39.847959
382	Id dolor explicabo. Ab perspiciatis impedit. Rerum voluptas et.	\N	224	2023-08-03 06:32:39.853265	2023-08-03 06:32:39.853265
383	Vitae iusto aut. Eveniet debitis voluptas. Nulla deserunt rerum.	159	\N	2023-08-03 06:32:39.88423	2023-08-03 06:32:39.88423
384	Sapiente quia aut. Voluptatem facere aliquid. Rerum deleniti harum.	\N	225	2023-08-03 06:32:39.889415	2023-08-03 06:32:39.889415
385	Est consequatur temporibus. Est corporis enim. Quidem eligendi rerum.	160	\N	2023-08-03 06:32:39.920732	2023-08-03 06:32:39.920732
386	Esse consectetur temporibus. Quibusdam quo eos. Vel ullam atque.	\N	226	2023-08-03 06:32:39.925783	2023-08-03 06:32:39.925783
387	Sit aperiam aliquid. Voluptatibus soluta reiciendis. Doloremque deserunt vero.	161	\N	2023-08-03 06:32:39.964258	2023-08-03 06:32:39.964258
388	Ut autem non. Facilis voluptatem iure. Dignissimos et eos.	\N	227	2023-08-03 06:32:39.969281	2023-08-03 06:32:39.969281
389	Qui velit maiores. Dolor nobis velit. Odio itaque nihil.	162	\N	2023-08-03 06:32:40.00152	2023-08-03 06:32:40.00152
390	In non eius. Ut laborum consequatur. Et occaecati aut.	\N	228	2023-08-03 06:32:40.00644	2023-08-03 06:32:40.00644
391	Debitis explicabo in. Iste nemo porro. Et maiores quas.	163	\N	2023-08-03 06:32:40.039939	2023-08-03 06:32:40.039939
392	Id omnis consequatur. Ipsam dicta non. Consequatur excepturi fugit.	\N	229	2023-08-03 06:32:40.044934	2023-08-03 06:32:40.044934
393	Repudiandae asperiores laudantium. Beatae facere distinctio. Voluptatibus possimus eaque.	164	\N	2023-08-03 06:32:40.090589	2023-08-03 06:32:40.090589
394	Unde reprehenderit minima. Optio praesentium beatae. Et ratione perferendis.	\N	230	2023-08-03 06:32:40.09579	2023-08-03 06:32:40.09579
395	Error ullam dicta. A non soluta. Sapiente incidunt non.	165	\N	2023-08-03 06:32:40.140003	2023-08-03 06:32:40.140003
396	Eum aut iste. Aut placeat perspiciatis. Excepturi ea est.	\N	231	2023-08-03 06:32:40.145201	2023-08-03 06:32:40.145201
397	Laborum dolores reiciendis. Iusto ut et. Recusandae quasi incidunt.	166	\N	2023-08-03 06:32:40.181956	2023-08-03 06:32:40.181956
398	Labore facilis reiciendis. Est ut quos. Nesciunt a quo.	\N	232	2023-08-03 06:32:40.187125	2023-08-03 06:32:40.187125
399	Optio voluptas aut. Est similique in. Autem et aut.	167	\N	2023-08-03 06:32:40.220541	2023-08-03 06:32:40.220541
400	Illum officiis quae. Sunt corrupti nulla. Nisi et dolor.	\N	233	2023-08-03 06:32:40.225536	2023-08-03 06:32:40.225536
401	Veniam molestias dolores. Explicabo aperiam assumenda. Aut exercitationem assumenda.	168	\N	2023-08-03 06:32:40.265297	2023-08-03 06:32:40.265297
402	Sint in quis. Quia cumque incidunt. Quasi vel tempore.	\N	234	2023-08-03 06:32:40.270396	2023-08-03 06:32:40.270396
403	Molestiae officiis mollitia. Nulla cum architecto. Illum tempora aut.	169	\N	2023-08-03 06:32:40.303778	2023-08-03 06:32:40.303778
404	Ipsa nam tempore. Repellendus qui mollitia. Laboriosam delectus aliquid.	\N	235	2023-08-03 06:32:40.308857	2023-08-03 06:32:40.308857
405	Dolores amet inventore. Quia voluptatem quia. Necessitatibus suscipit sed.	170	\N	2023-08-03 06:32:40.341746	2023-08-03 06:32:40.341746
406	Cum ut doloribus. Iste est autem. Doloribus reprehenderit eius.	\N	236	2023-08-03 06:32:40.346848	2023-08-03 06:32:40.346848
407	Maxime voluptatem sit. Recusandae ipsum et. Dolorem officia quia.	171	\N	2023-08-03 06:32:40.38231	2023-08-03 06:32:40.38231
408	Est qui adipisci. Blanditiis tempora est. Repellendus neque error.	\N	237	2023-08-03 06:32:40.387416	2023-08-03 06:32:40.387416
409	Itaque qui maiores. Distinctio expedita rem. Et nesciunt repudiandae.	172	\N	2023-08-03 06:32:40.419554	2023-08-03 06:32:40.419554
410	Quia quasi labore. Aperiam minus velit. Amet temporibus consequuntur.	\N	238	2023-08-03 06:32:40.424474	2023-08-03 06:32:40.424474
411	Et quisquam velit. Saepe ea quasi. Nihil ex illo.	173	\N	2023-08-03 06:32:40.461195	2023-08-03 06:32:40.461195
412	Hic quia cum. Sed laborum blanditiis. Expedita necessitatibus commodi.	\N	239	2023-08-03 06:32:40.46611	2023-08-03 06:32:40.46611
413	Dolor commodi similique. Voluptatibus quod corrupti. Consequatur et maiores.	174	\N	2023-08-03 06:32:40.506586	2023-08-03 06:32:40.506586
414	Omnis voluptas id. Et natus omnis. Ut rerum omnis.	\N	240	2023-08-03 06:32:40.511455	2023-08-03 06:32:40.511455
415	Sunt quidem et. Ipsum molestiae ex. Molestias sunt error.	175	\N	2023-08-03 06:32:40.5445	2023-08-03 06:32:40.5445
416	In quas sint. Totam sunt excepturi. Quaerat necessitatibus non.	\N	241	2023-08-03 06:32:40.54963	2023-08-03 06:32:40.54963
417	Enim a eum. Velit est dolore. Earum aut adipisci.	176	\N	2023-08-03 06:32:40.601336	2023-08-03 06:32:40.601336
418	Ut aspernatur qui. Architecto eos quia. Reprehenderit assumenda sit.	\N	242	2023-08-03 06:32:40.607724	2023-08-03 06:32:40.607724
419	Et animi et. Numquam rerum est. Eos deserunt consectetur.	177	\N	2023-08-03 06:32:40.655418	2023-08-03 06:32:40.655418
420	Voluptatem repellendus reprehenderit. Libero dolorem numquam. Unde officiis voluptate.	\N	243	2023-08-03 06:32:40.660596	2023-08-03 06:32:40.660596
421	Ut quos officia. Consequatur eveniet magni. Rem maiores rerum.	178	\N	2023-08-03 06:32:40.69804	2023-08-03 06:32:40.69804
422	Id minima provident. Commodi voluptas aspernatur. Quisquam cum maiores.	\N	244	2023-08-03 06:32:40.703	2023-08-03 06:32:40.703
423	Non quam rerum. Et itaque eius. Quasi ut nesciunt.	179	\N	2023-08-03 06:32:40.742664	2023-08-03 06:32:40.742664
424	Dolores est neque. Est quae qui. Distinctio eligendi est.	\N	245	2023-08-03 06:32:40.747582	2023-08-03 06:32:40.747582
425	Ducimus nam hic. Ipsa aut earum. Perspiciatis quod voluptatem.	180	\N	2023-08-03 06:32:40.781204	2023-08-03 06:32:40.781204
426	Id consequatur quasi. Et mollitia aut. Omnis voluptate asperiores.	\N	246	2023-08-03 06:32:40.786142	2023-08-03 06:32:40.786142
427	Harum neque id. Ut in blanditiis. Deserunt sed autem.	181	\N	2023-08-03 06:32:40.819543	2023-08-03 06:32:40.819543
428	Est laborum earum. Ad neque dicta. Autem voluptatibus quis.	\N	247	2023-08-03 06:32:40.824384	2023-08-03 06:32:40.824384
429	Ut exercitationem qui. Ea id et. Sit architecto sunt.	182	\N	2023-08-03 06:32:40.860561	2023-08-03 06:32:40.860561
430	Voluptate non vitae. Debitis voluptatibus et. Ad et eius.	\N	248	2023-08-03 06:32:40.865724	2023-08-03 06:32:40.865724
431	Totam aperiam consectetur. Dolore facere quidem. Dignissimos cupiditate nostrum.	183	\N	2023-08-03 06:32:40.901355	2023-08-03 06:32:40.901355
432	Consequuntur architecto veritatis. Ea est optio. Beatae enim repellendus.	\N	249	2023-08-03 06:32:40.906302	2023-08-03 06:32:40.906302
433	Ipsum numquam reiciendis. Fuga dolores eligendi. Ipsum officia dignissimos.	184	\N	2023-08-03 06:32:40.939274	2023-08-03 06:32:40.939274
434	Consequatur atque dolor. Et reprehenderit et. Ut provident dolor.	\N	250	2023-08-03 06:32:40.944067	2023-08-03 06:32:40.944067
435	Animi illo vitae. Neque eveniet rem. Aperiam quaerat quo.	185	\N	2023-08-03 06:32:40.981308	2023-08-03 06:32:40.981308
436	Expedita corrupti molestiae. Id et est. Quia natus nesciunt.	\N	251	2023-08-03 06:32:40.986447	2023-08-03 06:32:40.986447
437	Sunt sit facilis. Sint enim aliquam. Rem exercitationem qui.	186	\N	2023-08-03 06:32:41.018705	2023-08-03 06:32:41.018705
438	Dolorem aliquam natus. Aut alias corporis. Consectetur sit quis.	\N	252	2023-08-03 06:32:41.023939	2023-08-03 06:32:41.023939
439	Molestiae rerum minima. Et explicabo recusandae. Est et nesciunt.	187	\N	2023-08-03 06:32:41.057606	2023-08-03 06:32:41.057606
440	Ea qui laborum. Mollitia voluptatum aut. Harum beatae et.	\N	253	2023-08-03 06:32:41.062971	2023-08-03 06:32:41.062971
\.


--
-- Data for Name: phones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.phones (id, created_at, updated_at, number, service_type, resource_id, description, service_id, contact_id, language_id) FROM stdin;
1	2023-08-03 06:32:29.395864	2023-08-03 06:32:29.395864	+16308505982;ext=7601	Business	1	\N	\N	\N	\N
2	2023-08-03 06:32:29.604782	2023-08-03 06:32:29.604782	+19108170781;ext=4322	Business	2	\N	\N	\N	\N
3	2023-08-03 06:32:29.680129	2023-08-03 06:32:29.680129	+14798017802	Business	3	\N	\N	\N	\N
4	2023-08-03 06:32:29.750951	2023-08-03 06:32:29.750951	+16418700866	Business	4	\N	\N	\N	\N
5	2023-08-03 06:32:29.805752	2023-08-03 06:32:29.805752	+19376269970;ext=2622	Business	5	\N	\N	\N	\N
6	2023-08-03 06:32:29.883808	2023-08-03 06:32:29.883808	+17812085587	Business	6	\N	\N	\N	\N
7	2023-08-03 06:32:29.96008	2023-08-03 06:32:29.96008	+19784431470	Business	7	\N	\N	\N	\N
8	2023-08-03 06:32:30.036723	2023-08-03 06:32:30.036723	+12104089540;ext=6850	Business	8	\N	\N	\N	\N
9	2023-08-03 06:32:30.10497	2023-08-03 06:32:30.10497	+14125511400	Business	9	\N	\N	\N	\N
10	2023-08-03 06:32:30.144942	2023-08-03 06:32:30.144942	+13198080306	Business	10	\N	\N	\N	\N
11	2023-08-03 06:32:30.195578	2023-08-03 06:32:30.195578	+18137073867;ext=3641	Business	11	\N	\N	\N	\N
12	2023-08-03 06:32:30.271311	2023-08-03 06:32:30.271311	+19738573226	Business	12	\N	\N	\N	\N
13	2023-08-03 06:32:30.332978	2023-08-03 06:32:30.332978	+17654437348;ext=6885	Business	13	\N	\N	\N	\N
14	2023-08-03 06:32:30.403628	2023-08-03 06:32:30.403628	+14029736996	Business	14	\N	\N	\N	\N
15	2023-08-03 06:32:30.450274	2023-08-03 06:32:30.450274	+18303078146	Business	15	\N	\N	\N	\N
16	2023-08-03 06:32:30.491731	2023-08-03 06:32:30.491731	+15075127984;ext=5530	Business	16	\N	\N	\N	\N
17	2023-08-03 06:32:30.53609	2023-08-03 06:32:30.53609	+16035125234;ext=9030	Business	17	\N	\N	\N	\N
18	2023-08-03 06:32:30.60777	2023-08-03 06:32:30.60777	+12086601882;ext=3419	Business	18	\N	\N	\N	\N
19	2023-08-03 06:32:30.689392	2023-08-03 06:32:30.689392	+13612348564	Business	19	\N	\N	\N	\N
20	2023-08-03 06:32:30.734165	2023-08-03 06:32:30.734165	+17164245909	Business	20	\N	\N	\N	\N
21	2023-08-03 06:32:30.802132	2023-08-03 06:32:30.802132	+18304340044;ext=5243	Business	21	\N	\N	\N	\N
22	2023-08-03 06:32:30.84313	2023-08-03 06:32:30.84313	+12399564702;ext=3426	Business	22	\N	\N	\N	\N
23	2023-08-03 06:32:30.911194	2023-08-03 06:32:30.911194	+18307066047	Business	23	\N	\N	\N	\N
24	2023-08-03 06:32:30.9838	2023-08-03 06:32:30.9838	+16023602957;ext=8638	Business	24	\N	\N	\N	\N
25	2023-08-03 06:32:31.05733	2023-08-03 06:32:31.05733	+18609093130;ext=3765	Business	25	\N	\N	\N	\N
26	2023-08-03 06:32:31.109332	2023-08-03 06:32:31.109332	+18132602107	Business	26	\N	\N	\N	\N
27	2023-08-03 06:32:31.160316	2023-08-03 06:32:31.160316	+18482299606;ext=7909	Business	27	\N	\N	\N	\N
28	2023-08-03 06:32:31.213402	2023-08-03 06:32:31.213402	+16158640005	Business	28	\N	\N	\N	\N
29	2023-08-03 06:32:31.260362	2023-08-03 06:32:31.260362	+19416148899;ext=0065	Business	29	\N	\N	\N	\N
30	2023-08-03 06:32:31.307011	2023-08-03 06:32:31.307011	+15187017294;ext=2344	Business	30	\N	\N	\N	\N
31	2023-08-03 06:32:31.351322	2023-08-03 06:32:31.351322	+15409854969;ext=8672	Business	31	\N	\N	\N	\N
32	2023-08-03 06:32:31.423636	2023-08-03 06:32:31.423636	+19103866047;ext=6119	Business	32	\N	\N	\N	\N
33	2023-08-03 06:32:31.46989	2023-08-03 06:32:31.46989	+17635519058;ext=6294	Business	33	\N	\N	\N	\N
34	2023-08-03 06:32:31.51672	2023-08-03 06:32:31.51672	+12188451992	Business	34	\N	\N	\N	\N
35	2023-08-03 06:32:31.586582	2023-08-03 06:32:31.586582	+12313396894;ext=6016	Business	35	\N	\N	\N	\N
36	2023-08-03 06:32:31.637354	2023-08-03 06:32:31.637354	+17037069664;ext=1489	Business	36	\N	\N	\N	\N
37	2023-08-03 06:32:31.688408	2023-08-03 06:32:31.688408	+13175716667;ext=6752	Business	37	\N	\N	\N	\N
38	2023-08-03 06:32:31.732848	2023-08-03 06:32:31.732848	+18627546782;ext=6401	Business	38	\N	\N	\N	\N
39	2023-08-03 06:32:31.784343	2023-08-03 06:32:31.784343	+13365647544;ext=2694	Business	39	\N	\N	\N	\N
40	2023-08-03 06:32:31.834447	2023-08-03 06:32:31.834447	+17316418362	Business	40	\N	\N	\N	\N
41	2023-08-03 06:32:31.885773	2023-08-03 06:32:31.885773	+18308629526;ext=7984	Business	41	\N	\N	\N	\N
42	2023-08-03 06:32:31.933812	2023-08-03 06:32:31.933812	+14078031557;ext=0450	Business	42	\N	\N	\N	\N
43	2023-08-03 06:32:32.007246	2023-08-03 06:32:32.007246	+15407723111;ext=5177	Business	43	\N	\N	\N	\N
44	2023-08-03 06:32:32.048996	2023-08-03 06:32:32.048996	+12077138485;ext=4172	Business	44	\N	\N	\N	\N
45	2023-08-03 06:32:32.099856	2023-08-03 06:32:32.099856	+19414345289;ext=3066	Business	45	\N	\N	\N	\N
46	2023-08-03 06:32:32.166262	2023-08-03 06:32:32.166262	+14793132841	Business	46	\N	\N	\N	\N
47	2023-08-03 06:32:32.212809	2023-08-03 06:32:32.212809	+17707406949;ext=7745	Business	47	\N	\N	\N	\N
48	2023-08-03 06:32:32.285583	2023-08-03 06:32:32.285583	+13362173226;ext=1137	Business	48	\N	\N	\N	\N
49	2023-08-03 06:32:32.330909	2023-08-03 06:32:32.330909	+13157060737	Business	49	\N	\N	\N	\N
50	2023-08-03 06:32:32.379972	2023-08-03 06:32:32.379972	+12066619210;ext=6608	Business	50	\N	\N	\N	\N
51	2023-08-03 06:32:32.430998	2023-08-03 06:32:32.430998	+13048035059;ext=7859	Business	51	\N	\N	\N	\N
52	2023-08-03 06:32:32.508296	2023-08-03 06:32:32.508296	+15678135590;ext=0085	Business	52	\N	\N	\N	\N
53	2023-08-03 06:32:32.58081	2023-08-03 06:32:32.58081	+19369106996;ext=9823	Business	53	\N	\N	\N	\N
54	2023-08-03 06:32:32.650517	2023-08-03 06:32:32.650517	+19142122818;ext=8002	Business	54	\N	\N	\N	\N
55	2023-08-03 06:32:32.696437	2023-08-03 06:32:32.696437	+19193308556	Business	55	\N	\N	\N	\N
56	2023-08-03 06:32:32.772537	2023-08-03 06:32:32.772537	+15046018650;ext=3037	Business	56	\N	\N	\N	\N
57	2023-08-03 06:32:32.851364	2023-08-03 06:32:32.851364	+12548645683	Business	57	\N	\N	\N	\N
58	2023-08-03 06:32:32.902707	2023-08-03 06:32:32.902707	+14129092910;ext=7189	Business	58	\N	\N	\N	\N
59	2023-08-03 06:32:32.973205	2023-08-03 06:32:32.973205	+14806079587	Business	59	\N	\N	\N	\N
60	2023-08-03 06:32:33.037483	2023-08-03 06:32:33.037483	+17545671642	Business	60	\N	\N	\N	\N
61	2023-08-03 06:32:33.105708	2023-08-03 06:32:33.105708	+15012701823	Business	61	\N	\N	\N	\N
62	2023-08-03 06:32:33.191005	2023-08-03 06:32:33.191005	+14788039447;ext=7683	Business	62	\N	\N	\N	\N
63	2023-08-03 06:32:33.27314	2023-08-03 06:32:33.27314	+12142564532;ext=3067	Business	63	\N	\N	\N	\N
64	2023-08-03 06:32:33.319176	2023-08-03 06:32:33.319176	+15613378505;ext=9884	Business	64	\N	\N	\N	\N
65	2023-08-03 06:32:33.389481	2023-08-03 06:32:33.389481	+17703521191	Business	65	\N	\N	\N	\N
66	2023-08-03 06:32:33.465081	2023-08-03 06:32:33.465081	+15175173157;ext=1986	Business	66	\N	\N	\N	\N
67	2023-08-03 06:32:33.522017	2023-08-03 06:32:33.522017	+18154709274	Business	67	\N	\N	\N	\N
68	2023-08-03 06:32:33.573614	2023-08-03 06:32:33.573614	+19252692810;ext=4701	Business	68	\N	\N	\N	\N
69	2023-08-03 06:32:33.650544	2023-08-03 06:32:33.650544	+17754706649	Business	69	\N	\N	\N	\N
70	2023-08-03 06:32:33.704157	2023-08-03 06:32:33.704157	+17135178539	Business	70	\N	\N	\N	\N
71	2023-08-03 06:32:33.780743	2023-08-03 06:32:33.780743	+16196177278;ext=5840	Business	71	\N	\N	\N	\N
72	2023-08-03 06:32:33.857855	2023-08-03 06:32:33.857855	+16267164835;ext=8440	Business	72	\N	\N	\N	\N
73	2023-08-03 06:32:33.90801	2023-08-03 06:32:33.90801	+16165070284;ext=9796	Business	73	\N	\N	\N	\N
74	2023-08-03 06:32:33.988292	2023-08-03 06:32:33.988292	+17852258165	Business	74	\N	\N	\N	\N
75	2023-08-03 06:32:34.065763	2023-08-03 06:32:34.065763	+19785807257	Business	75	\N	\N	\N	\N
76	2023-08-03 06:32:34.141746	2023-08-03 06:32:34.141746	+12626261383;ext=5048	Business	76	\N	\N	\N	\N
77	2023-08-03 06:32:34.194848	2023-08-03 06:32:34.194848	+17278138425	Business	77	\N	\N	\N	\N
78	2023-08-03 06:32:34.248735	2023-08-03 06:32:34.248735	+16098285426;ext=3358	Business	78	\N	\N	\N	\N
79	2023-08-03 06:32:34.326526	2023-08-03 06:32:34.326526	+19477088179	Business	79	\N	\N	\N	\N
80	2023-08-03 06:32:34.404928	2023-08-03 06:32:34.404928	+13372341557;ext=3364	Business	80	\N	\N	\N	\N
81	2023-08-03 06:32:34.476043	2023-08-03 06:32:34.476043	+18594848749;ext=5137	Business	81	\N	\N	\N	\N
82	2023-08-03 06:32:34.527504	2023-08-03 06:32:34.527504	+17028785980	Business	82	\N	\N	\N	\N
83	2023-08-03 06:32:34.605887	2023-08-03 06:32:34.605887	+12349317484	Business	83	\N	\N	\N	\N
84	2023-08-03 06:32:34.654459	2023-08-03 06:32:34.654459	+15209105402;ext=4077	Business	84	\N	\N	\N	\N
85	2023-08-03 06:32:34.713045	2023-08-03 06:32:34.713045	+18144707197	Business	85	\N	\N	\N	\N
86	2023-08-03 06:32:34.771223	2023-08-03 06:32:34.771223	+15634644600	Business	86	\N	\N	\N	\N
87	2023-08-03 06:32:34.846514	2023-08-03 06:32:34.846514	+15167049062;ext=1929	Business	87	\N	\N	\N	\N
88	2023-08-03 06:32:34.917824	2023-08-03 06:32:34.917824	+18175512026	Business	88	\N	\N	\N	\N
89	2023-08-03 06:32:35.055031	2023-08-03 06:32:35.055031	+19403176389;ext=5530	Business	89	\N	\N	\N	\N
90	2023-08-03 06:32:35.105147	2023-08-03 06:32:35.105147	+15676418482;ext=7411	Business	90	\N	\N	\N	\N
91	2023-08-03 06:32:35.180201	2023-08-03 06:32:35.180201	+17168183058	Business	91	\N	\N	\N	\N
92	2023-08-03 06:32:35.276376	2023-08-03 06:32:35.276376	+13307741865;ext=4831	Business	92	\N	\N	\N	\N
93	2023-08-03 06:32:35.34741	2023-08-03 06:32:35.34741	+19183184259	Business	93	\N	\N	\N	\N
94	2023-08-03 06:32:35.426362	2023-08-03 06:32:35.426362	+13012705075;ext=3063	Business	94	\N	\N	\N	\N
95	2023-08-03 06:32:35.52814	2023-08-03 06:32:35.52814	+17028040339;ext=4660	Business	95	\N	\N	\N	\N
96	2023-08-03 06:32:35.579456	2023-08-03 06:32:35.579456	+12125709369;ext=9342	Business	96	\N	\N	\N	\N
97	2023-08-03 06:32:35.631657	2023-08-03 06:32:35.631657	+17069105684	Business	97	\N	\N	\N	\N
98	2023-08-03 06:32:35.716449	2023-08-03 06:32:35.716449	+12626011630	Business	98	\N	\N	\N	\N
99	2023-08-03 06:32:35.765186	2023-08-03 06:32:35.765186	+12019795152;ext=7700	Business	99	\N	\N	\N	\N
100	2023-08-03 06:32:35.835853	2023-08-03 06:32:35.835853	+18126037251	Business	100	\N	\N	\N	\N
101	2023-08-03 06:32:35.889663	2023-08-03 06:32:35.889663	+13344702436;ext=2887	Business	101	\N	\N	\N	\N
102	2023-08-03 06:32:35.932916	2023-08-03 06:32:35.932916	+18585030636	Business	102	\N	\N	\N	\N
103	2023-08-03 06:32:36.005191	2023-08-03 06:32:36.005191	+19127188511;ext=9792	Business	103	\N	\N	\N	\N
104	2023-08-03 06:32:36.055913	2023-08-03 06:32:36.055913	+19522245466	Business	104	\N	\N	\N	\N
105	2023-08-03 06:32:36.103311	2023-08-03 06:32:36.103311	+12132072610;ext=6893	Business	105	\N	\N	\N	\N
106	2023-08-03 06:32:36.175929	2023-08-03 06:32:36.175929	+18652769146;ext=1994	Business	106	\N	\N	\N	\N
107	2023-08-03 06:32:36.219534	2023-08-03 06:32:36.219534	+13194237849;ext=3660	Business	107	\N	\N	\N	\N
108	2023-08-03 06:32:36.270323	2023-08-03 06:32:36.270323	+12702085633	Business	108	\N	\N	\N	\N
109	2023-08-03 06:32:36.317882	2023-08-03 06:32:36.317882	+12192058357	Business	109	\N	\N	\N	\N
110	2023-08-03 06:32:36.366485	2023-08-03 06:32:36.366485	+15122810429;ext=7093	Business	110	\N	\N	\N	\N
111	2023-08-03 06:32:36.433126	2023-08-03 06:32:36.433126	+18134343446	Business	111	\N	\N	\N	\N
112	2023-08-03 06:32:36.480825	2023-08-03 06:32:36.480825	+19376361936;ext=1743	Business	112	\N	\N	\N	\N
113	2023-08-03 06:32:36.597833	2023-08-03 06:32:36.597833	+13216105017;ext=2113	Business	113	\N	\N	\N	\N
114	2023-08-03 06:32:36.655735	2023-08-03 06:32:36.655735	+16362255825;ext=6846	Business	114	\N	\N	\N	\N
115	2023-08-03 06:32:36.705985	2023-08-03 06:32:36.705985	+13233219320;ext=9012	Business	115	\N	\N	\N	\N
116	2023-08-03 06:32:36.768817	2023-08-03 06:32:36.768817	+18185710814	Business	116	\N	\N	\N	\N
117	2023-08-03 06:32:36.827506	2023-08-03 06:32:36.827506	+12819281194;ext=4594	Business	117	\N	\N	\N	\N
118	2023-08-03 06:32:36.880714	2023-08-03 06:32:36.880714	+16364150507	Business	118	\N	\N	\N	\N
119	2023-08-03 06:32:36.937252	2023-08-03 06:32:36.937252	+16033125112;ext=4818	Business	119	\N	\N	\N	\N
120	2023-08-03 06:32:36.994867	2023-08-03 06:32:36.994867	+15512402883	Business	120	\N	\N	\N	\N
121	2023-08-03 06:32:37.053338	2023-08-03 06:32:37.053338	+19796176825;ext=8771	Business	121	\N	\N	\N	\N
122	2023-08-03 06:32:37.148632	2023-08-03 06:32:37.148632	+12038313491	Business	122	\N	\N	\N	\N
123	2023-08-03 06:32:37.243587	2023-08-03 06:32:37.243587	+17855706893	Business	123	\N	\N	\N	\N
124	2023-08-03 06:32:37.322223	2023-08-03 06:32:37.322223	+17815628717	Business	124	\N	\N	\N	\N
125	2023-08-03 06:32:37.396174	2023-08-03 06:32:37.396174	+19494459073;ext=1183	Business	125	\N	\N	\N	\N
126	2023-08-03 06:32:37.444982	2023-08-03 06:32:37.444982	+18314158054	Business	126	\N	\N	\N	\N
127	2023-08-03 06:32:37.49634	2023-08-03 06:32:37.49634	+14102768512	Business	127	\N	\N	\N	\N
128	2023-08-03 06:32:37.543736	2023-08-03 06:32:37.543736	+12037148361;ext=1725	Business	128	\N	\N	\N	\N
129	2023-08-03 06:32:37.593932	2023-08-03 06:32:37.593932	+16148012703	Business	129	\N	\N	\N	\N
130	2023-08-03 06:32:37.673017	2023-08-03 06:32:37.673017	+12697122048	Business	130	\N	\N	\N	\N
131	2023-08-03 06:32:37.720306	2023-08-03 06:32:37.720306	+17196194141	Business	131	\N	\N	\N	\N
132	2023-08-03 06:32:37.764235	2023-08-03 06:32:37.764235	+19498598733	Business	132	\N	\N	\N	\N
133	2023-08-03 06:32:37.815856	2023-08-03 06:32:37.815856	+15157077500	Business	133	\N	\N	\N	\N
134	2023-08-03 06:32:37.88335	2023-08-03 06:32:37.88335	+18507340479	Business	134	\N	\N	\N	\N
135	2023-08-03 06:32:37.950644	2023-08-03 06:32:37.950644	+17859716863	Business	135	\N	\N	\N	\N
136	2023-08-03 06:32:38.00117	2023-08-03 06:32:38.00117	+17742690527;ext=0370	Business	136	\N	\N	\N	\N
137	2023-08-03 06:32:38.056306	2023-08-03 06:32:38.056306	+16024082742;ext=2409	Business	137	\N	\N	\N	\N
138	2023-08-03 06:32:38.170373	2023-08-03 06:32:38.170373	+13072280387	Business	138	\N	\N	\N	\N
139	2023-08-03 06:32:38.247916	2023-08-03 06:32:38.247916	+18129250118;ext=6570	Business	139	\N	\N	\N	\N
140	2023-08-03 06:32:38.330295	2023-08-03 06:32:38.330295	+12282532297	Business	140	\N	\N	\N	\N
141	2023-08-03 06:32:38.381366	2023-08-03 06:32:38.381366	+13392134582	Business	141	\N	\N	\N	\N
142	2023-08-03 06:32:38.428419	2023-08-03 06:32:38.428419	+13158121412;ext=5091	Business	142	\N	\N	\N	\N
143	2023-08-03 06:32:38.506995	2023-08-03 06:32:38.506995	+15418169510	Business	143	\N	\N	\N	\N
144	2023-08-03 06:32:38.556916	2023-08-03 06:32:38.556916	+17245109384;ext=6726	Business	144	\N	\N	\N	\N
145	2023-08-03 06:32:38.608129	2023-08-03 06:32:38.608129	+16126512841;ext=0266	Business	145	\N	\N	\N	\N
146	2023-08-03 06:32:38.65967	2023-08-03 06:32:38.65967	+19184083681	Business	146	\N	\N	\N	\N
147	2023-08-03 06:32:38.733903	2023-08-03 06:32:38.733903	+15627652475;ext=3092	Business	147	\N	\N	\N	\N
148	2023-08-03 06:32:38.802668	2023-08-03 06:32:38.802668	+19153144947	Business	148	\N	\N	\N	\N
149	2023-08-03 06:32:38.854079	2023-08-03 06:32:38.854079	+14097639344;ext=6236	Business	149	\N	\N	\N	\N
150	2023-08-03 06:32:39.494724	2023-08-03 06:32:39.494724	+18584148016;ext=8690	Business	150	\N	\N	\N	\N
151	2023-08-03 06:32:39.534243	2023-08-03 06:32:39.534243	+16162257621;ext=0441	Business	151	\N	\N	\N	\N
152	2023-08-03 06:32:39.569414	2023-08-03 06:32:39.569414	+12402602964;ext=5101	Business	152	\N	\N	\N	\N
153	2023-08-03 06:32:39.605695	2023-08-03 06:32:39.605695	+16129756155	Business	153	\N	\N	\N	\N
154	2023-08-03 06:32:39.642251	2023-08-03 06:32:39.642251	+19562109743;ext=3112	Business	154	\N	\N	\N	\N
155	2023-08-03 06:32:39.711394	2023-08-03 06:32:39.711394	+16464707330;ext=3341	Business	155	\N	\N	\N	\N
156	2023-08-03 06:32:39.753598	2023-08-03 06:32:39.753598	+18595085362	Business	156	\N	\N	\N	\N
157	2023-08-03 06:32:39.794998	2023-08-03 06:32:39.794998	+19522078775	Business	157	\N	\N	\N	\N
158	2023-08-03 06:32:39.828888	2023-08-03 06:32:39.828888	+13102171607;ext=6568	Business	158	\N	\N	\N	\N
159	2023-08-03 06:32:39.874908	2023-08-03 06:32:39.874908	+15092348144	Business	159	\N	\N	\N	\N
160	2023-08-03 06:32:39.909039	2023-08-03 06:32:39.909039	+15403144773;ext=7627	Business	160	\N	\N	\N	\N
161	2023-08-03 06:32:39.947922	2023-08-03 06:32:39.947922	+13475031381	Business	161	\N	\N	\N	\N
162	2023-08-03 06:32:39.992356	2023-08-03 06:32:39.992356	+17172025409;ext=9265	Business	162	\N	\N	\N	\N
163	2023-08-03 06:32:40.025304	2023-08-03 06:32:40.025304	+17637861431;ext=2295	Business	163	\N	\N	\N	\N
164	2023-08-03 06:32:40.070987	2023-08-03 06:32:40.070987	+14099716795	Business	164	\N	\N	\N	\N
165	2023-08-03 06:32:40.124177	2023-08-03 06:32:40.124177	+14069858344	Business	165	\N	\N	\N	\N
166	2023-08-03 06:32:40.167641	2023-08-03 06:32:40.167641	+19285100870;ext=6106	Business	166	\N	\N	\N	\N
167	2023-08-03 06:32:40.208701	2023-08-03 06:32:40.208701	+12142128799;ext=0914	Business	167	\N	\N	\N	\N
168	2023-08-03 06:32:40.251968	2023-08-03 06:32:40.251968	+13209703363;ext=3164	Business	168	\N	\N	\N	\N
169	2023-08-03 06:32:40.288814	2023-08-03 06:32:40.288814	+14102280869;ext=7582	Business	169	\N	\N	\N	\N
170	2023-08-03 06:32:40.330732	2023-08-03 06:32:40.330732	+12532083125;ext=6223	Business	170	\N	\N	\N	\N
171	2023-08-03 06:32:40.367872	2023-08-03 06:32:40.367872	+16072171836	Business	171	\N	\N	\N	\N
172	2023-08-03 06:32:40.404933	2023-08-03 06:32:40.404933	+15209085101;ext=0157	Business	172	\N	\N	\N	\N
173	2023-08-03 06:32:40.450049	2023-08-03 06:32:40.450049	+17129179962	Business	173	\N	\N	\N	\N
174	2023-08-03 06:32:40.490642	2023-08-03 06:32:40.490642	+15512699304	Business	174	\N	\N	\N	\N
175	2023-08-03 06:32:40.5304	2023-08-03 06:32:40.5304	+19498171468;ext=5912	Business	175	\N	\N	\N	\N
176	2023-08-03 06:32:40.577365	2023-08-03 06:32:40.577365	+19289704254;ext=5333	Business	176	\N	\N	\N	\N
177	2023-08-03 06:32:40.643206	2023-08-03 06:32:40.643206	+15672142477	Business	177	\N	\N	\N	\N
178	2023-08-03 06:32:40.684696	2023-08-03 06:32:40.684696	+15514099614;ext=0917	Business	178	\N	\N	\N	\N
179	2023-08-03 06:32:40.726331	2023-08-03 06:32:40.726331	+16067246724;ext=0531	Business	179	\N	\N	\N	\N
180	2023-08-03 06:32:40.768173	2023-08-03 06:32:40.768173	+19403101385	Business	180	\N	\N	\N	\N
181	2023-08-03 06:32:40.806364	2023-08-03 06:32:40.806364	+19255598154;ext=3986	Business	181	\N	\N	\N	\N
182	2023-08-03 06:32:40.850037	2023-08-03 06:32:40.850037	+13129159827;ext=8071	Business	182	\N	\N	\N	\N
183	2023-08-03 06:32:40.888114	2023-08-03 06:32:40.888114	+16016464579;ext=1457	Business	183	\N	\N	\N	\N
184	2023-08-03 06:32:40.928449	2023-08-03 06:32:40.928449	+12769142842;ext=2765	Business	184	\N	\N	\N	\N
185	2023-08-03 06:32:40.968112	2023-08-03 06:32:40.968112	+14232245029	Business	185	\N	\N	\N	\N
186	2023-08-03 06:32:41.008197	2023-08-03 06:32:41.008197	+17313364900	Business	186	\N	\N	\N	\N
187	2023-08-03 06:32:41.045615	2023-08-03 06:32:41.045615	+19475124434	Business	187	\N	\N	\N	\N
\.


--
-- Data for Name: programs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.programs (id, name, alternate_name, description, created_at, updated_at, resource_id) FROM stdin;
\.


--
-- Data for Name: resources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resources (id, created_at, updated_at, name, short_description, long_description, website, verified_at, email, status, certified, alternate_name, legal_status, contact_id, funding_id, certified_at, featured, source_attribution, internal_note) FROM stdin;
1	2023-08-03 06:32:29.350355	2023-08-03 06:32:29.568242	Dibbert, Hickle and Feil	Magnam ab voluptate quo.	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	http://crooks.io/elden	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
2	2023-08-03 06:32:29.600087	2023-08-03 06:32:29.651306	Luettgen LLC	Provident vel veniam eaque.	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	http://brown-okuneva.org/hue	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
3	2023-08-03 06:32:29.674718	2023-08-03 06:32:29.720731	Abbott-Reinger	Culpa ut nemo provident.	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	http://schmidt-padberg.net/stanford.olson	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
4	2023-08-03 06:32:29.745495	2023-08-03 06:32:29.767837	Welch, Bode and Kerluke		A place to shower on Tuesday through Saturday.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
5	2023-08-03 06:32:29.799676	2023-08-03 06:32:29.853942	Bechtelar, Keebler and Nikolaus		Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	http://terry-jast.io/haydee	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
6	2023-08-03 06:32:29.876976	2023-08-03 06:32:29.92686	Homenick, Hane and Conn	Eligendi omnis cupiditate ad.	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	http://runolfsdottir.biz/everette.cremin	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
7	2023-08-03 06:32:29.95411	2023-08-03 06:32:30.011039	Kozey, Schoen and Wilderman	Officiis occaecati dolorum numquam.	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
8	2023-08-03 06:32:30.031667	2023-08-03 06:32:30.074553	Howe-Schinner	Dolorem qui non amet.	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
31	2023-08-03 06:32:31.346396	2023-08-03 06:32:31.391533	Marvin, Rogahn and Wehner	Eum nulla quis sit.	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	http://halvorson.com/randell_zboncak	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
32	2023-08-03 06:32:31.418981	2023-08-03 06:32:31.443029	Spinka, Strosin and Feest	Alias corrupti est nisi.	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	http://nitzsche.io/kendall_welch	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
33	2023-08-03 06:32:31.46533	2023-08-03 06:32:31.488776	Kihn Group		Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	http://heller-kuhn.com/stan	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
34	2023-08-03 06:32:31.512266	2023-08-03 06:32:31.559473	Turcotte Inc	Dolorem amet consequatur vero.	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	http://homenick-feil.io/ruben.mante	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
35	2023-08-03 06:32:31.58179	2023-08-03 06:32:31.606877	O'Conner Inc		A place to shower on Tuesday through Saturday.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
36	2023-08-03 06:32:31.632583	2023-08-03 06:32:31.656915	Lindgren-Stiedemann	Officiis qui aspernatur labore.	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	http://nikolaus.io/julene.sporer	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
37	2023-08-03 06:32:31.683543	2023-08-03 06:32:31.703031	Witting Inc		Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
38	2023-08-03 06:32:31.727385	2023-08-03 06:32:31.752823	Bode, Harber and Leannon	Alias odio cupiditate nulla.	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	http://kihn.biz/bulah_mante	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
39	2023-08-03 06:32:31.779746	2023-08-03 06:32:31.80503	Quitzon LLC	Autem non aut incidunt.	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
40	2023-08-03 06:32:31.829239	2023-08-03 06:32:31.855107	Lesch-Williamson	Debitis cumque quis libero.	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	http://mertz.co/phillip	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
41	2023-08-03 06:32:31.880376	2023-08-03 06:32:31.899026	Wilkinson, Waelchi and Dibbert	Harum dolores ex fuga.	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	http://tremblay-mcdermott.co/irina	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
42	2023-08-03 06:32:31.928001	2023-08-03 06:32:31.975722	Lind-O'Kon		Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	http://rau.info/vicente	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
43	2023-08-03 06:32:32.002856	2023-08-03 06:32:32.020169	Parker, Hahn and Dickens		Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
44	2023-08-03 06:32:32.044926	2023-08-03 06:32:32.069086	Cremin and Sons	Tempora aut voluptas id.	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
45	2023-08-03 06:32:32.094231	2023-08-03 06:32:32.141661	Kulas Group		First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	http://streich-hilpert.name/jonathan	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
88	2023-08-03 06:32:34.91076	2023-08-03 06:32:35.017285	Mraz-Roberts	Quia minima et et.	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
9	2023-08-03 06:32:30.099413	2023-08-03 06:32:30.118201	Sanford-Parisian	Quod beatae laudantium similique.	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	http://cartwright-rempel.info/rogelio_bechtelar	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
10	2023-08-03 06:32:30.139725	2023-08-03 06:32:30.16395	Feil LLC		Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	http://morissette-stamm.net/reid	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
11	2023-08-03 06:32:30.189732	2023-08-03 06:32:30.243336	Dickinson, Wehner and Auer		Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	http://brekke-white.net/enoch_kuvalis	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
12	2023-08-03 06:32:30.266665	2023-08-03 06:32:30.306705	Denesik Group	Saepe quasi minima qui.	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	http://rohan-reynolds.co/kristofer_hammes	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
13	2023-08-03 06:32:30.327991	2023-08-03 06:32:30.37428	Jacobson Group		Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
14	2023-08-03 06:32:30.398971	2023-08-03 06:32:30.422765	Treutel Inc		1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	http://fadel-ullrich.biz/arlene	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
15	2023-08-03 06:32:30.445455	2023-08-03 06:32:30.464452	Deckow-Berge		Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
16	2023-08-03 06:32:30.486515	2023-08-03 06:32:30.51097	Ortiz Inc		Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	http://monahan.biz/ira_legros	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
17	2023-08-03 06:32:30.531002	2023-08-03 06:32:30.57361	Rath and Sons	Qui ut qui molestias.	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
18	2023-08-03 06:32:30.602898	2023-08-03 06:32:30.662651	Runolfsdottir-Baumbach		Serves lunch Monday and Wednesday. Dinner available all days.\n	http://howell.io/freddie	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
19	2023-08-03 06:32:30.685223	2023-08-03 06:32:30.707235	Mosciski, Torp and Wuckert	Nemo autem ut minima.	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	http://roberts.biz/hans	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
20	2023-08-03 06:32:30.728925	2023-08-03 06:32:30.775577	Jaskolski-Grimes		Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	http://mosciski.net/madeleine_white	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
21	2023-08-03 06:32:30.797286	2023-08-03 06:32:30.814356	Johnston, Champlin and Volkman	Labore dolorem sequi hic.	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
22	2023-08-03 06:32:30.839067	2023-08-03 06:32:30.884216	Mayer-Graham	Culpa quo aperiam deleniti.	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	http://beier-mcdermott.io/audrey	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
23	2023-08-03 06:32:30.906564	2023-08-03 06:32:30.95047	Davis, Waelchi and Hyatt	Impedit necessitatibus in voluptatem.	Serves lunch Monday and Wednesday. Dinner available all days.\n	http://huel.biz/emery	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
24	2023-08-03 06:32:30.978164	2023-08-03 06:32:31.023392	Prosacco, Bins and Cummings	Doloremque odio consectetur explicabo.	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	http://connelly.io/burt	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
25	2023-08-03 06:32:31.052305	2023-08-03 06:32:31.073251	Dare-Harris		Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
26	2023-08-03 06:32:31.104242	2023-08-03 06:32:31.128766	Beahan, Pacocha and Powlowski	Nihil enim illum numquam.	Weekly food pantry (Thursday).\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
27	2023-08-03 06:32:31.155398	2023-08-03 06:32:31.18047	Marvin, Buckridge and Hagenes		First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
28	2023-08-03 06:32:31.208186	2023-08-03 06:32:31.23127	Dach-Christiansen		Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	http://kemmer-padberg.net/tari_medhurst	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
29	2023-08-03 06:32:31.255068	2023-08-03 06:32:31.279297	Torphy, Greenholt and Daugherty	Earum rerum consequatur explicabo.	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	http://klein-frami.info/frida.daugherty	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
30	2023-08-03 06:32:31.301653	2023-08-03 06:32:31.319116	Harris-Bogan	Voluptate aut ut porro.	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	http://willms.name/shirley	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
46	2023-08-03 06:32:32.160808	2023-08-03 06:32:32.183539	Schultz-Kulas		Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	http://hayes.co/mercy	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
47	2023-08-03 06:32:32.207836	2023-08-03 06:32:32.253098	Okuneva, Lemke and Jakubowski		Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
48	2023-08-03 06:32:32.280759	2023-08-03 06:32:32.302421	Harris-Goldner		Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	http://runolfsson.com/cleveland.yundt	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
49	2023-08-03 06:32:32.325408	2023-08-03 06:32:32.349475	Borer, Gleason and Stiedemann	Facilis corporis occaecati consequatur.	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	http://treutel.net/jacalyn	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
50	2023-08-03 06:32:32.374293	2023-08-03 06:32:32.401997	Fritsch-Trantow		Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	http://wyman.com/lessie	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
51	2023-08-03 06:32:32.425564	2023-08-03 06:32:32.479644	Kuhlman-Brown	Ad quae et quia.	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	http://kutch.name/maude	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
52	2023-08-03 06:32:32.503118	2023-08-03 06:32:32.550171	Goldner-Padberg		1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	http://hermiston.co/calvin_heaney	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
53	2023-08-03 06:32:32.576199	2023-08-03 06:32:32.6214	Beahan LLC	Similique tenetur aut earum.	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	http://windler.co/raymundo	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
54	2023-08-03 06:32:32.645743	2023-08-03 06:32:32.669255	Emard, McDermott and Wisoky	Sint aut provident non.	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	http://green.io/elmo	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
55	2023-08-03 06:32:32.69061	2023-08-03 06:32:32.741727	Buckridge Group		A place to shower on Tuesday through Saturday.\n	http://botsford.com/jacquelin_oconner	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
56	2023-08-03 06:32:32.764485	2023-08-03 06:32:32.819568	Schuppe, White and Schroeder		Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	http://hauck-herman.info/nieves.dooley	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
57	2023-08-03 06:32:32.84605	2023-08-03 06:32:32.87429	Kohler, Wilkinson and Doyle		Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	http://walsh-mitchell.biz/mercedez.auer	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
58	2023-08-03 06:32:32.897375	2023-08-03 06:32:32.942865	Herman-Green	Omnis amet tenetur quam.	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	http://runolfsson-murazik.name/donnie	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
59	2023-08-03 06:32:32.968504	2023-08-03 06:32:33.009525	Goodwin, Mayer and Ullrich		Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
60	2023-08-03 06:32:33.032436	2023-08-03 06:32:33.073659	Moore-Rath		Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
61	2023-08-03 06:32:33.099592	2023-08-03 06:32:33.155838	Parisian-Zieme	Debitis distinctio nam ut.	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	http://schowalter-friesen.com/randolph.kub	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
62	2023-08-03 06:32:33.18564	2023-08-03 06:32:33.237523	O'Hara Group	Earum similique omnis maxime.	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	http://pfannerstill.io/susan_mclaughlin	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
63	2023-08-03 06:32:33.268389	2023-08-03 06:32:33.288514	Kreiger, Goodwin and Adams	Omnis nobis minus atque.	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	http://zboncak.io/benjamin	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
64	2023-08-03 06:32:33.313557	2023-08-03 06:32:33.364249	Carroll Group	Dicta amet nihil sit.	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	http://koepp.net/divina	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
65	2023-08-03 06:32:33.38377	2023-08-03 06:32:33.432902	Klein, Reichert and Daugherty		Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
87	2023-08-03 06:32:34.840417	2023-08-03 06:32:34.869671	Brakus, Nikolaus and Hagenes		Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	http://west-thompson.info/armand_buckridge	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
66	2023-08-03 06:32:33.459389	2023-08-03 06:32:33.488926	Harber Group		Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
67	2023-08-03 06:32:33.515793	2023-08-03 06:32:33.54343	Fritsch and Sons		Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
68	2023-08-03 06:32:33.568243	2023-08-03 06:32:33.618703	Runolfsson LLC		Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
69	2023-08-03 06:32:33.645166	2023-08-03 06:32:33.668381	Hessel-Abernathy		Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
70	2023-08-03 06:32:33.69829	2023-08-03 06:32:33.755156	Schneider and Sons	Laudantium dolore corporis odit.	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	http://gutmann-berge.com/glennie	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
71	2023-08-03 06:32:33.776138	2023-08-03 06:32:33.829757	Yundt LLC		Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
72	2023-08-03 06:32:33.85268	2023-08-03 06:32:33.878343	Heidenreich Inc	Ab qui dolores quaerat.	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
73	2023-08-03 06:32:33.903226	2023-08-03 06:32:33.952191	Cummings-Olson	Excepturi aut quo praesentium.	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	http://kassulke.biz/marco_dooley	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
74	2023-08-03 06:32:33.983185	2023-08-03 06:32:34.033202	Harris, Durgan and Renner		Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	http://murphy.name/deanne	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
75	2023-08-03 06:32:34.06066	2023-08-03 06:32:34.109349	Corkery-Quigley	Quaerat provident natus earum.	A place to shower on Tuesday through Saturday.\n	http://koelpin.biz/antone	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
76	2023-08-03 06:32:34.137286	2023-08-03 06:32:34.163991	Mosciski-Nader	Magnam eos qui maiores.	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	http://kunde.com/isadora	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
77	2023-08-03 06:32:34.190047	2023-08-03 06:32:34.215901	Schiller, Cremin and Stanton		A place to shower on Tuesday through Saturday.\n	http://franecki.co/willa_dicki	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
78	2023-08-03 06:32:34.242774	2023-08-03 06:32:34.298128	Pagac, Pagac and Leannon	Magnam vel optio a.	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
79	2023-08-03 06:32:34.321135	2023-08-03 06:32:34.372662	Kilback Group	Accusamus pariatur nesciunt et.	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	http://kunde-morar.co/mari	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
80	2023-08-03 06:32:34.399974	2023-08-03 06:32:34.446232	Howe LLC		Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	http://wiza.org/arlie	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
81	2023-08-03 06:32:34.471477	2023-08-03 06:32:34.494833	Murazik-Murphy	Suscipit sunt esse a.	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	http://fay-tillman.net/rogelio.littel	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
82	2023-08-03 06:32:34.521395	2023-08-03 06:32:34.573181	Wiza Group		1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	http://hane.info/vito	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
83	2023-08-03 06:32:34.600988	2023-08-03 06:32:34.622756	O'Keefe, Corkery and Rice	In non expedita porro.	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	http://trantow.net/magda_rippin	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
84	2023-08-03 06:32:34.647991	2023-08-03 06:32:34.677464	Stoltenberg-Rolfson	Ex consequatur quaerat deleniti.	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
85	2023-08-03 06:32:34.707921	2023-08-03 06:32:34.735378	Feest, Gibson and Murray	Facere unde maxime voluptas.	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	http://connelly.net/lesli	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
86	2023-08-03 06:32:34.765976	2023-08-03 06:32:34.81773	Dooley, Kub and Smitham	Architecto nesciunt culpa accusamus.	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	http://nikolaus.net/britt_swaniawski	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
89	2023-08-03 06:32:35.049213	2023-08-03 06:32:35.075791	Schimmel-Beahan	Consectetur ut nisi ea.	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
90	2023-08-03 06:32:35.10011	2023-08-03 06:32:35.145567	Jenkins-Swift	Non velit iure consectetur.	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
91	2023-08-03 06:32:35.174467	2023-08-03 06:32:35.246609	Crist, Kulas and Wyman	Consequuntur rem et quidem.	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
92	2023-08-03 06:32:35.271381	2023-08-03 06:32:35.297639	Langworth-Blanda	Eius voluptate molestiae a.	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
93	2023-08-03 06:32:35.339195	2023-08-03 06:32:35.369421	Macejkovic-Mertz	Cumque quae dignissimos recusandae.	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
94	2023-08-03 06:32:35.420529	2023-08-03 06:32:35.489334	Mertz, Mitchell and Collier	Tempore velit repellendus accusantium.	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
95	2023-08-03 06:32:35.522516	2023-08-03 06:32:35.546578	Bernier, Daugherty and Rowe		Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	http://bartell.co/cletus	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
96	2023-08-03 06:32:35.573896	2023-08-03 06:32:35.59712	Vandervort-Considine		Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	http://schulist-bednar.biz/rhett.schumm	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
97	2023-08-03 06:32:35.620266	2023-08-03 06:32:35.681843	Hand LLC		Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	http://dicki.biz/todd	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
98	2023-08-03 06:32:35.710736	2023-08-03 06:32:35.733381	Bayer-Larson	Recusandae beatae eum ut.	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
99	2023-08-03 06:32:35.759931	2023-08-03 06:32:35.803326	Breitenberg, Mills and Kshlerin		Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	http://rodriguez.co/rikki	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
100	2023-08-03 06:32:35.830941	2023-08-03 06:32:35.861074	Predovic and Sons		Weekly food pantry (Thursday).\n	http://dickinson.net/carita_thiel	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
101	2023-08-03 06:32:35.884665	2023-08-03 06:32:35.907731	Robel-Bernhard	Deleniti voluptatem incidunt accusamus.	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
102	2023-08-03 06:32:35.927776	2023-08-03 06:32:35.977002	Terry Group	Facere qui distinctio quis.	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	http://beatty.biz/bruce	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
103	2023-08-03 06:32:36.000791	2023-08-03 06:32:36.024322	Cartwright, Breitenberg and Bechtelar	Ipsam nobis fugit qui.	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	http://stracke-kihn.io/jackie.streich	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
104	2023-08-03 06:32:36.051061	2023-08-03 06:32:36.0723	Tillman and Sons	Adipisci sit hic quam.	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	http://prosacco.com/rafael.moore	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
105	2023-08-03 06:32:36.098945	2023-08-03 06:32:36.137802	Ritchie, Hoeger and Stroman	Culpa ratione quia exercitationem.	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
106	2023-08-03 06:32:36.168265	2023-08-03 06:32:36.195807	Bayer, Nikolaus and Conroy	Rem molestiae quidem molestiae.	Weekly food pantry (Thursday).\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
107	2023-08-03 06:32:36.214151	2023-08-03 06:32:36.238741	Casper, Klein and Veum		1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	http://mohr-jakubowski.co/darwin.tillman	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
108	2023-08-03 06:32:36.265906	2023-08-03 06:32:36.287954	Davis, Goldner and Brown	Repellat est laudantium veniam.	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	http://conroy.info/reid.howe	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
109	2023-08-03 06:32:36.313142	2023-08-03 06:32:36.339452	Grady, Kunde and Goyette	Porro praesentium quia voluptatem.	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
110	2023-08-03 06:32:36.361308	2023-08-03 06:32:36.404323	Tremblay-Wyman	Et deserunt non consectetur.	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
111	2023-08-03 06:32:36.427588	2023-08-03 06:32:36.453531	Kiehn, Koelpin and Stokes	Sed omnis et esse.	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	http://schmidt.biz/rolando_fisher	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
112	2023-08-03 06:32:36.475145	2023-08-03 06:32:36.556023	McLaughlin, Thiel and Swift	Dolores non consequatur dolorem.	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
113	2023-08-03 06:32:36.592502	2023-08-03 06:32:36.622843	McKenzie-Luettgen	Sed quae ipsum ut.	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
114	2023-08-03 06:32:36.650407	2023-08-03 06:32:36.674642	Labadie Group	Praesentium autem consequatur distinctio.	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
115	2023-08-03 06:32:36.700933	2023-08-03 06:32:36.719516	Heidenreich-Kulas		Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
116	2023-08-03 06:32:36.762866	2023-08-03 06:32:36.789655	Moore Group		The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
117	2023-08-03 06:32:36.821304	2023-08-03 06:32:36.842067	Rogahn-Reichel		First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	http://runolfsson.co/rickey	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
118	2023-08-03 06:32:36.875359	2023-08-03 06:32:36.901681	Nikolaus Inc	Velit est velit in.	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
119	2023-08-03 06:32:36.930915	2023-08-03 06:32:36.957016	Gorczany, Kilback and Heathcote	Neque voluptatem nobis eos.	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	http://west.co/aurora	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
120	2023-08-03 06:32:36.988569	2023-08-03 06:32:37.018254	Ferry-Howell		1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	http://wilkinson.biz/anita_turner	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
121	2023-08-03 06:32:37.04743	2023-08-03 06:32:37.114437	Adams-Lynch	Qui ad eum provident.	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
122	2023-08-03 06:32:37.142837	2023-08-03 06:32:37.201798	Fritsch, Ondricka and Cruickshank		Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
123	2023-08-03 06:32:37.237005	2023-08-03 06:32:37.289979	Huels, Schuster and Crist		Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
124	2023-08-03 06:32:37.317294	2023-08-03 06:32:37.367411	Tromp and Sons	Temporibus explicabo quidem illo.	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
125	2023-08-03 06:32:37.391024	2023-08-03 06:32:37.414619	Schoen and Sons		A place to shower on Tuesday through Saturday.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
126	2023-08-03 06:32:37.439572	2023-08-03 06:32:37.465739	Olson-Stark	Dolore consequatur rerum quam.	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
127	2023-08-03 06:32:37.491031	2023-08-03 06:32:37.515528	Kohler, Bartell and Larson		Weekly food pantry (Thursday).\n	http://swift-steuber.name/terrence.heidenreich	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
128	2023-08-03 06:32:37.538614	2023-08-03 06:32:37.560763	Heller-Fritsch	Velit nam molestiae neque.	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
129	2023-08-03 06:32:37.58844	2023-08-03 06:32:37.639141	Beahan and Sons		Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	http://macejkovic-mayer.info/darren	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
130	2023-08-03 06:32:37.667992	2023-08-03 06:32:37.69248	Ryan, Doyle and Prosacco	Cum non qui consequatur.	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
131	2023-08-03 06:32:37.715501	2023-08-03 06:32:37.736411	Kuhlman, Ullrich and Bayer		First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
132	2023-08-03 06:32:37.759144	2023-08-03 06:32:37.782785	Stroman Inc		A place to shower on Tuesday through Saturday.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
133	2023-08-03 06:32:37.810789	2023-08-03 06:32:37.8552	Watsica, Mraz and Moore	Iste quisquam assumenda fugiat.	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	http://goldner.info/hank	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
134	2023-08-03 06:32:37.877998	2023-08-03 06:32:37.919783	McCullough Inc		The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	http://johns-herzog.info/trevor	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
135	2023-08-03 06:32:37.945854	2023-08-03 06:32:37.970031	Mohr and Sons	Magnam nam qui nulla.	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	http://strosin-mclaughlin.com/victorina	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
136	2023-08-03 06:32:37.99608	2023-08-03 06:32:38.018175	McDermott and Sons	Est consequatur qui maxime.	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
137	2023-08-03 06:32:38.048888	2023-08-03 06:32:38.124667	Abshire, Halvorson and Rath		A place to shower on Tuesday through Saturday.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
138	2023-08-03 06:32:38.164997	2023-08-03 06:32:38.21497	Jakubowski and Sons	Dicta consequatur assumenda adipisci.	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	http://ortiz.biz/dustin	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
139	2023-08-03 06:32:38.242593	2023-08-03 06:32:38.295777	Flatley, Krajcik and Hudson	Nam maxime omnis ea.	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
140	2023-08-03 06:32:38.325132	2023-08-03 06:32:38.350708	Wunsch Group	Corrupti et omnis quae.	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
141	2023-08-03 06:32:38.376099	2023-08-03 06:32:38.399155	Abshire-Miller		Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	http://kling.io/bud	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
142	2023-08-03 06:32:38.423194	2023-08-03 06:32:38.474231	Feil-Bins	Ea alias reiciendis quae.	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
143	2023-08-03 06:32:38.501891	2023-08-03 06:32:38.526279	Ortiz-Koch	Qui ea sed quod.	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
144	2023-08-03 06:32:38.551655	2023-08-03 06:32:38.573153	D'Amore Group	Dolorum aliquam dicta omnis.	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	http://wilkinson.com/lina_kris	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
145	2023-08-03 06:32:38.60281	2023-08-03 06:32:38.624975	Kirlin Group	Rerum natus laudantium aut.	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
146	2023-08-03 06:32:38.654086	2023-08-03 06:32:38.703937	Tillman, Reynolds and Torp	Minima quas laboriosam non.	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
147	2023-08-03 06:32:38.72886	2023-08-03 06:32:38.772591	Schuster Inc	Accusantium voluptate quae laudantium.	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	http://rempel-beahan.info/matt	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
148	2023-08-03 06:32:38.797235	2023-08-03 06:32:38.820258	McDermott-Bahringer		Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
149	2023-08-03 06:32:38.848942	2023-08-03 06:32:38.870465	A Test Resource	I am a short description of a resource.	I am a long description of a resource.	www.fakewebsite.org	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
150	2023-08-03 06:32:39.489551	2023-08-03 06:32:39.511997	Gerhold, Bartoletti and Runte	Est delectus voluptatem libero.	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	http://ruecker-batz.co/abdul.grant	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
151	2023-08-03 06:32:39.529472	2023-08-03 06:32:39.546074	Hilpert LLC	Et id voluptatibus illum.	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	http://ryan.net/kiyoko	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
152	2023-08-03 06:32:39.564751	2023-08-03 06:32:39.587327	Streich and Sons	Et fuga dolor ut.	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	http://nicolas-walker.net/hollis	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
153	2023-08-03 06:32:39.601013	2023-08-03 06:32:39.622915	Gerhold-Fahey	Doloribus neque iusto qui.	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	http://simonis.io/columbus.feest	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
154	2023-08-03 06:32:39.637576	2023-08-03 06:32:39.663848	Funk Group	Eum non eum commodi.	A place to shower on Tuesday through Saturday.\n	http://oreilly.io/elliot_hudson	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
155	2023-08-03 06:32:39.706302	2023-08-03 06:32:39.731408	Schaefer-Grady	A fugiat repellat possimus.	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	http://gottlieb-langworth.org/mirta_ledner	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
156	2023-08-03 06:32:39.748778	2023-08-03 06:32:39.769071	Ebert-Konopelski	Quod aliquid enim pariatur.	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	http://schmeler-stroman.biz/harris	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
157	2023-08-03 06:32:39.789912	2023-08-03 06:32:39.809996	Hamill, Kris and Casper	Perspiciatis aspernatur laborum occaecati.	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	http://oconnell-abbott.info/karan.cassin	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
158	2023-08-03 06:32:39.824156	2023-08-03 06:32:39.851444	Schaden LLC	Dolorem nihil cupiditate aliquid.	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	http://schmidt.net/kareem_ziemann	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
159	2023-08-03 06:32:39.870396	2023-08-03 06:32:39.887507	Rohan, Johnston and Satterfield	Veritatis fugiat deserunt voluptatem.	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	http://ledner.name/stepanie	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
160	2023-08-03 06:32:39.904162	2023-08-03 06:32:39.924104	O'Conner, Breitenberg and Simonis	Placeat quaerat sit quia.	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	http://schmidt.info/hershel	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
161	2023-08-03 06:32:39.943262	2023-08-03 06:32:39.967562	Marquardt-Ryan	Praesentium repellat nobis assumenda.	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	http://lubowitz-crist.co/shad.schaefer	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
162	2023-08-03 06:32:39.987484	2023-08-03 06:32:40.004764	Mante-Bernhard	Dolor voluptatem ratione quam.	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	http://shields.co/merrilee_bogisich	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
163	2023-08-03 06:32:40.02061	2023-08-03 06:32:40.043247	Gulgowski-Monahan	Hic maiores et aut.	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	http://deckow.org/exie	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
164	2023-08-03 06:32:40.066218	2023-08-03 06:32:40.094027	Jacobi-Goyette	Esse ea libero aut.	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	http://schaefer.biz/sang	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
165	2023-08-03 06:32:40.119473	2023-08-03 06:32:40.143285	Ziemann, Schroeder and Abernathy	Quaerat consequatur est nihil.	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	http://hermann.biz/stephen.okon	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
166	2023-08-03 06:32:40.16277	2023-08-03 06:32:40.185278	Ward, Bayer and Okuneva	Vitae rerum velit quis.	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	http://gislason.info/cliff.erdman	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
167	2023-08-03 06:32:40.203852	2023-08-03 06:32:40.223848	Satterfield, Kovacek and Shields	Recusandae aut ad cum.	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	http://haag.info/ben_breitenberg	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
168	2023-08-03 06:32:40.24714	2023-08-03 06:32:40.268747	Ledner, Buckridge and Hayes	Ea nemo delectus autem.	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	http://kemmer.name/eleonor_mcglynn	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
169	2023-08-03 06:32:40.28422	2023-08-03 06:32:40.30704	Dooley, Torp and VonRueden	Placeat eum laudantium dolores.	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	http://schuppe.co/dessie_conn	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
170	2023-08-03 06:32:40.32587	2023-08-03 06:32:40.34512	Renner-Glover	Ut eos deserunt quidem.	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	http://hoeger.biz/wilhelmina.schmidt	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
171	2023-08-03 06:32:40.363348	2023-08-03 06:32:40.385735	Hoeger-Kemmer	Sed suscipit laudantium ipsa.	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	http://jerde.co/damion.morissette	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
172	2023-08-03 06:32:40.40012	2023-08-03 06:32:40.422773	Murazik, Spencer and Daugherty	Illo sed ut magnam.	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	http://spencer.name/ina_bosco	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
173	2023-08-03 06:32:40.445334	2023-08-03 06:32:40.464422	Gorczany, Waelchi and Welch	Non laudantium fugiat est.	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	http://larkin.name/maura.yost	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
174	2023-08-03 06:32:40.485988	2023-08-03 06:32:40.509772	Windler, McDermott and Kovacek	Repellendus neque perspiciatis tempora.	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	http://parisian-lubowitz.biz/les	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
175	2023-08-03 06:32:40.525743	2023-08-03 06:32:40.547775	Jaskolski and Sons	Animi unde nobis excepturi.	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	http://hettinger.info/abel_botsford	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
176	2023-08-03 06:32:40.570971	2023-08-03 06:32:40.60566	Rippin Inc	Ut et repellendus impedit.	Serves lunch Monday and Wednesday. Dinner available all days.\n	http://herman.org/harriette.bashirian	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
177	2023-08-03 06:32:40.638045	2023-08-03 06:32:40.658895	Hodkiewicz-Schmitt	Ea inventore qui explicabo.	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	http://stark.co/esther	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
178	2023-08-03 06:32:40.679975	2023-08-03 06:32:40.701307	Hickle Group	Officiis est praesentium sint.	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	http://gorczany-wolff.net/kraig	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
179	2023-08-03 06:32:40.721715	2023-08-03 06:32:40.745903	Purdy-Rutherford	Voluptas unde sunt sint.	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	http://schmidt.io/stevie.nikolaus	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
180	2023-08-03 06:32:40.762929	2023-08-03 06:32:40.784476	Conn and Sons	Aut nihil autem veritatis.	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	http://witting.name/desirae_oberbrunner	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
181	2023-08-03 06:32:40.80152	2023-08-03 06:32:40.822746	Mills-Orn	Atque quod minus soluta.	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	http://braun-romaguera.co/fabian_howell	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
182	2023-08-03 06:32:40.84505	2023-08-03 06:32:40.864007	Runolfsson-Veum	Amet at omnis necessitatibus.	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	http://glover.name/lovella.paucek	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
183	2023-08-03 06:32:40.883388	2023-08-03 06:32:40.904564	Bradtke Inc	Aperiam omnis sit atque.	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	http://kunze.co/chelsey	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
184	2023-08-03 06:32:40.923776	2023-08-03 06:32:40.942391	Cruickshank-Beier	Impedit ipsam harum non.	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	http://beatty.net/dorian.simonis	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
185	2023-08-03 06:32:40.963642	2023-08-03 06:32:40.984772	Champlin, Langosh and McLaughlin	Quis ad quo quas.	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	http://barrows.com/justin.kirlin	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
186	2023-08-03 06:32:41.003576	2023-08-03 06:32:41.022188	Spinka, Reinger and Terry	Minima quis voluptas aliquam.	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	http://goldner.biz/moshe	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
187	2023-08-03 06:32:41.040774	2023-08-03 06:32:41.061191	Rippin, Bashirian and Mayert	Neque ullam aut tempore.	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	http://reichert-wilderman.com/ji	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
\.


--
-- Data for Name: resources_sites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resources_sites (resource_id, site_id) FROM stdin;
1	2
2	1
2	2
3	1
4	2
5	1
6	2
7	1
8	2
31	1
31	2
32	1
32	2
33	1
34	2
35	1
36	1
37	1
37	2
38	1
39	2
40	2
41	1
41	2
42	1
42	2
43	2
44	1
44	2
45	1
45	2
88	2
9	1
9	2
10	2
11	2
12	2
13	1
13	2
14	2
15	2
16	1
17	1
17	2
18	2
19	2
20	2
21	1
22	1
23	1
23	2
24	2
25	2
26	2
27	1
28	1
29	2
30	1
46	1
46	2
47	1
48	2
49	1
49	2
50	1
50	2
51	1
51	2
52	2
53	1
53	2
54	1
54	2
55	1
55	2
56	1
57	2
58	1
59	1
59	2
60	1
61	2
62	2
63	1
63	2
64	1
65	1
87	2
66	1
66	2
67	1
67	2
68	1
69	2
70	1
70	2
71	1
72	2
73	1
73	2
74	1
75	1
76	1
77	2
78	1
79	1
80	2
81	1
82	1
83	1
84	1
85	1
85	2
86	2
89	2
90	2
91	1
92	2
93	2
94	2
95	1
96	1
97	2
98	1
98	2
99	1
99	2
100	1
101	1
101	2
102	1
102	2
103	1
104	1
105	1
106	1
107	1
108	2
109	1
109	2
110	2
111	1
112	2
113	1
113	2
114	2
115	1
116	1
116	2
117	1
117	2
118	2
119	2
120	1
120	2
121	2
122	1
123	1
124	2
125	1
126	1
127	2
128	2
129	1
130	2
131	1
132	2
133	1
134	1
135	1
135	2
136	1
137	2
138	1
138	2
139	1
139	2
140	2
141	1
142	1
143	1
143	2
144	1
145	2
146	1
147	1
147	2
148	1
149	1
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (id, review, tags, feedback_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schedule_days; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedule_days (id, created_at, updated_at, day, opens_at, closes_at, schedule_id, open_time, open_day, close_time, close_day) FROM stdin;
1	2023-08-03 06:32:29.423352	2023-08-03 06:32:29.423352	Monday	700	2315	1	\N	\N	\N	\N
2	2023-08-03 06:32:29.42502	2023-08-03 06:32:29.42502	Tuesday	1745	345	1	\N	\N	\N	\N
3	2023-08-03 06:32:29.426403	2023-08-03 06:32:29.426403	Wednesday	1130	1900	1	\N	\N	\N	\N
4	2023-08-03 06:32:29.427665	2023-08-03 06:32:29.427665	Wednesday	2015	2300	1	\N	\N	\N	\N
5	2023-08-03 06:32:29.429247	2023-08-03 06:32:29.429247	Thursday	200	900	1	\N	\N	\N	\N
6	2023-08-03 06:32:29.430507	2023-08-03 06:32:29.430507	Thursday	1015	2030	1	\N	\N	\N	\N
7	2023-08-03 06:32:29.431785	2023-08-03 06:32:29.431785	Friday	730	1545	1	\N	\N	\N	\N
8	2023-08-03 06:32:29.433054	2023-08-03 06:32:29.433054	Saturday	615	1615	1	\N	\N	\N	\N
9	2023-08-03 06:32:29.434316	2023-08-03 06:32:29.434316	Sunday	2145	230	1	\N	\N	\N	\N
10	2023-08-03 06:32:29.50717	2023-08-03 06:32:29.50717	Tuesday	1030	1245	2	\N	\N	\N	\N
11	2023-08-03 06:32:29.508509	2023-08-03 06:32:29.508509	Tuesday	1345	100	2	\N	\N	\N	\N
12	2023-08-03 06:32:29.509882	2023-08-03 06:32:29.509882	Thursday	845	1600	2	\N	\N	\N	\N
13	2023-08-03 06:32:29.511204	2023-08-03 06:32:29.511204	Friday	1000	1830	2	\N	\N	\N	\N
14	2023-08-03 06:32:29.51254	2023-08-03 06:32:29.51254	Saturday	830	1215	2	\N	\N	\N	\N
15	2023-08-03 06:32:29.51398	2023-08-03 06:32:29.51398	Saturday	1330	1500	2	\N	\N	\N	\N
16	2023-08-03 06:32:29.573682	2023-08-03 06:32:29.573682	Monday	1530	330	3	\N	\N	\N	\N
17	2023-08-03 06:32:29.575018	2023-08-03 06:32:29.575018	Tuesday	1445	145	3	\N	\N	\N	\N
18	2023-08-03 06:32:29.576337	2023-08-03 06:32:29.576337	Wednesday	730	1815	3	\N	\N	\N	\N
19	2023-08-03 06:32:29.577663	2023-08-03 06:32:29.577663	Thursday	615	1445	3	\N	\N	\N	\N
20	2023-08-03 06:32:29.578974	2023-08-03 06:32:29.578974	Friday	515	1615	3	\N	\N	\N	\N
21	2023-08-03 06:32:29.580357	2023-08-03 06:32:29.580357	Friday	1645	400	3	\N	\N	\N	\N
22	2023-08-03 06:32:29.581902	2023-08-03 06:32:29.581902	Saturday	100	1300	3	\N	\N	\N	\N
23	2023-08-03 06:32:29.583167	2023-08-03 06:32:29.583167	Saturday	1715	2230	3	\N	\N	\N	\N
24	2023-08-03 06:32:29.584438	2023-08-03 06:32:29.584438	Sunday	845	1700	3	\N	\N	\N	\N
25	2023-08-03 06:32:29.60854	2023-08-03 06:32:29.60854	Monday	45	100	4	\N	\N	\N	\N
26	2023-08-03 06:32:29.610096	2023-08-03 06:32:29.610096	Monday	800	1330	4	\N	\N	\N	\N
27	2023-08-03 06:32:29.611415	2023-08-03 06:32:29.611415	Wednesday	45	1400	4	\N	\N	\N	\N
28	2023-08-03 06:32:29.612695	2023-08-03 06:32:29.612695	Wednesday	1945	30	4	\N	\N	\N	\N
29	2023-08-03 06:32:29.614112	2023-08-03 06:32:29.614112	Sunday	445	530	4	\N	\N	\N	\N
30	2023-08-03 06:32:29.61539	2023-08-03 06:32:29.61539	Sunday	845	1630	4	\N	\N	\N	\N
31	2023-08-03 06:32:29.624563	2023-08-03 06:32:29.624563	Monday	800	1800	5	\N	\N	\N	\N
32	2023-08-03 06:32:29.625908	2023-08-03 06:32:29.625908	Tuesday	30	215	5	\N	\N	\N	\N
33	2023-08-03 06:32:29.627157	2023-08-03 06:32:29.627157	Tuesday	930	1115	5	\N	\N	\N	\N
34	2023-08-03 06:32:29.628513	2023-08-03 06:32:29.628513	Friday	615	1400	5	\N	\N	\N	\N
35	2023-08-03 06:32:29.62986	2023-08-03 06:32:29.62986	Saturday	200	400	5	\N	\N	\N	\N
36	2023-08-03 06:32:29.631305	2023-08-03 06:32:29.631305	Saturday	1415	1615	5	\N	\N	\N	\N
37	2023-08-03 06:32:29.632612	2023-08-03 06:32:29.632612	Sunday	800	1400	5	\N	\N	\N	\N
38	2023-08-03 06:32:29.656221	2023-08-03 06:32:29.656221	Monday	545	700	6	\N	\N	\N	\N
39	2023-08-03 06:32:29.657585	2023-08-03 06:32:29.657585	Monday	1215	2215	6	\N	\N	\N	\N
40	2023-08-03 06:32:29.658938	2023-08-03 06:32:29.658938	Tuesday	2230	230	6	\N	\N	\N	\N
41	2023-08-03 06:32:29.66023	2023-08-03 06:32:29.66023	Wednesday	815	2045	6	\N	\N	\N	\N
42	2023-08-03 06:32:29.661531	2023-08-03 06:32:29.661531	Thursday	930	2330	6	\N	\N	\N	\N
43	2023-08-03 06:32:29.662868	2023-08-03 06:32:29.662868	Saturday	930	1445	6	\N	\N	\N	\N
44	2023-08-03 06:32:29.664151	2023-08-03 06:32:29.664151	Sunday	845	1830	6	\N	\N	\N	\N
45	2023-08-03 06:32:29.683934	2023-08-03 06:32:29.683934	Monday	830	900	7	\N	\N	\N	\N
46	2023-08-03 06:32:29.685336	2023-08-03 06:32:29.685336	Monday	1645	2300	7	\N	\N	\N	\N
47	2023-08-03 06:32:29.686646	2023-08-03 06:32:29.686646	Tuesday	915	1700	7	\N	\N	\N	\N
48	2023-08-03 06:32:29.688024	2023-08-03 06:32:29.688024	Wednesday	600	2130	7	\N	\N	\N	\N
49	2023-08-03 06:32:29.689586	2023-08-03 06:32:29.689586	Friday	1415	130	7	\N	\N	\N	\N
50	2023-08-03 06:32:29.690911	2023-08-03 06:32:29.690911	Saturday	2000	330	7	\N	\N	\N	\N
51	2023-08-03 06:32:29.692154	2023-08-03 06:32:29.692154	Sunday	930	2130	7	\N	\N	\N	\N
52	2023-08-03 06:32:29.702581	2023-08-03 06:32:29.702581	Monday	915	2030	8	\N	\N	\N	\N
53	2023-08-03 06:32:29.704208	2023-08-03 06:32:29.704208	Wednesday	830	1845	8	\N	\N	\N	\N
54	2023-08-03 06:32:29.705738	2023-08-03 06:32:29.705738	Thursday	1130	1545	8	\N	\N	\N	\N
55	2023-08-03 06:32:29.707049	2023-08-03 06:32:29.707049	Thursday	1715	1815	8	\N	\N	\N	\N
56	2023-08-03 06:32:29.708362	2023-08-03 06:32:29.708362	Friday	630	1930	8	\N	\N	\N	\N
57	2023-08-03 06:32:29.709661	2023-08-03 06:32:29.709661	Saturday	1400	200	8	\N	\N	\N	\N
58	2023-08-03 06:32:29.72562	2023-08-03 06:32:29.72562	Monday	130	430	9	\N	\N	\N	\N
59	2023-08-03 06:32:29.727056	2023-08-03 06:32:29.727056	Monday	1100	1445	9	\N	\N	\N	\N
60	2023-08-03 06:32:29.728401	2023-08-03 06:32:29.728401	Tuesday	945	2330	9	\N	\N	\N	\N
61	2023-08-03 06:32:29.729737	2023-08-03 06:32:29.729737	Wednesday	845	2030	9	\N	\N	\N	\N
62	2023-08-03 06:32:29.731083	2023-08-03 06:32:29.731083	Thursday	830	2000	9	\N	\N	\N	\N
63	2023-08-03 06:32:29.732424	2023-08-03 06:32:29.732424	Friday	900	1615	9	\N	\N	\N	\N
64	2023-08-03 06:32:29.733784	2023-08-03 06:32:29.733784	Saturday	800	2345	9	\N	\N	\N	\N
65	2023-08-03 06:32:29.735117	2023-08-03 06:32:29.735117	Sunday	915	1945	9	\N	\N	\N	\N
66	2023-08-03 06:32:29.756043	2023-08-03 06:32:29.756043	Tuesday	845	1545	10	\N	\N	\N	\N
67	2023-08-03 06:32:29.757521	2023-08-03 06:32:29.757521	Wednesday	600	1600	10	\N	\N	\N	\N
68	2023-08-03 06:32:29.759193	2023-08-03 06:32:29.759193	Thursday	615	2115	10	\N	\N	\N	\N
69	2023-08-03 06:32:29.760951	2023-08-03 06:32:29.760951	Friday	630	1915	10	\N	\N	\N	\N
70	2023-08-03 06:32:29.773291	2023-08-03 06:32:29.773291	Monday	645	1515	11	\N	\N	\N	\N
71	2023-08-03 06:32:29.774858	2023-08-03 06:32:29.774858	Tuesday	715	1815	11	\N	\N	\N	\N
72	2023-08-03 06:32:29.776767	2023-08-03 06:32:29.776767	Wednesday	745	1830	11	\N	\N	\N	\N
73	2023-08-03 06:32:29.778454	2023-08-03 06:32:29.778454	Thursday	1945	100	11	\N	\N	\N	\N
74	2023-08-03 06:32:29.780476	2023-08-03 06:32:29.780476	Saturday	145	445	11	\N	\N	\N	\N
75	2023-08-03 06:32:29.782685	2023-08-03 06:32:29.782685	Saturday	2115	30	11	\N	\N	\N	\N
76	2023-08-03 06:32:29.784722	2023-08-03 06:32:29.784722	Sunday	1630	130	11	\N	\N	\N	\N
77	2023-08-03 06:32:29.810269	2023-08-03 06:32:29.810269	Monday	1000	1815	12	\N	\N	\N	\N
78	2023-08-03 06:32:29.812238	2023-08-03 06:32:29.812238	Thursday	845	1930	12	\N	\N	\N	\N
79	2023-08-03 06:32:29.814049	2023-08-03 06:32:29.814049	Friday	845	1745	12	\N	\N	\N	\N
80	2023-08-03 06:32:29.816048	2023-08-03 06:32:29.816048	Saturday	630	1815	12	\N	\N	\N	\N
81	2023-08-03 06:32:29.817594	2023-08-03 06:32:29.817594	Saturday	2145	2230	12	\N	\N	\N	\N
82	2023-08-03 06:32:29.819944	2023-08-03 06:32:29.819944	Sunday	630	1515	12	\N	\N	\N	\N
83	2023-08-03 06:32:29.833429	2023-08-03 06:32:29.833429	Monday	1000	1545	13	\N	\N	\N	\N
84	2023-08-03 06:32:29.83527	2023-08-03 06:32:29.83527	Tuesday	145	445	13	\N	\N	\N	\N
85	2023-08-03 06:32:29.837224	2023-08-03 06:32:29.837224	Tuesday	545	2030	13	\N	\N	\N	\N
86	2023-08-03 06:32:29.83891	2023-08-03 06:32:29.83891	Wednesday	700	2000	13	\N	\N	\N	\N
87	2023-08-03 06:32:29.840721	2023-08-03 06:32:29.840721	Thursday	815	1445	13	\N	\N	\N	\N
88	2023-08-03 06:32:29.842291	2023-08-03 06:32:29.842291	Friday	700	2015	13	\N	\N	\N	\N
89	2023-08-03 06:32:29.859017	2023-08-03 06:32:29.859017	Monday	730	2000	14	\N	\N	\N	\N
90	2023-08-03 06:32:29.860388	2023-08-03 06:32:29.860388	Tuesday	945	2245	14	\N	\N	\N	\N
91	2023-08-03 06:32:29.861687	2023-08-03 06:32:29.861687	Wednesday	730	2230	14	\N	\N	\N	\N
92	2023-08-03 06:32:29.863122	2023-08-03 06:32:29.863122	Thursday	2200	115	14	\N	\N	\N	\N
93	2023-08-03 06:32:29.864456	2023-08-03 06:32:29.864456	Saturday	100	330	14	\N	\N	\N	\N
94	2023-08-03 06:32:29.86577	2023-08-03 06:32:29.86577	Saturday	1415	1845	14	\N	\N	\N	\N
95	2023-08-03 06:32:29.887844	2023-08-03 06:32:29.887844	Monday	2145	230	15	\N	\N	\N	\N
96	2023-08-03 06:32:29.889245	2023-08-03 06:32:29.889245	Tuesday	1915	100	15	\N	\N	\N	\N
97	2023-08-03 06:32:29.890537	2023-08-03 06:32:29.890537	Wednesday	745	1930	15	\N	\N	\N	\N
98	2023-08-03 06:32:29.891798	2023-08-03 06:32:29.891798	Thursday	1715	345	15	\N	\N	\N	\N
99	2023-08-03 06:32:29.893139	2023-08-03 06:32:29.893139	Friday	830	1415	15	\N	\N	\N	\N
100	2023-08-03 06:32:29.894608	2023-08-03 06:32:29.894608	Saturday	0	1130	15	\N	\N	\N	\N
101	2023-08-03 06:32:29.895883	2023-08-03 06:32:29.895883	Saturday	1445	2300	15	\N	\N	\N	\N
102	2023-08-03 06:32:29.907405	2023-08-03 06:32:29.907405	Monday	800	1945	16	\N	\N	\N	\N
103	2023-08-03 06:32:29.908771	2023-08-03 06:32:29.908771	Tuesday	1845	300	16	\N	\N	\N	\N
104	2023-08-03 06:32:29.910328	2023-08-03 06:32:29.910328	Wednesday	945	1815	16	\N	\N	\N	\N
105	2023-08-03 06:32:29.911727	2023-08-03 06:32:29.911727	Thursday	1545	200	16	\N	\N	\N	\N
106	2023-08-03 06:32:29.913144	2023-08-03 06:32:29.913144	Saturday	630	2145	16	\N	\N	\N	\N
107	2023-08-03 06:32:29.914379	2023-08-03 06:32:29.914379	Saturday	2215	2300	16	\N	\N	\N	\N
108	2023-08-03 06:32:29.915665	2023-08-03 06:32:29.915665	Sunday	945	2015	16	\N	\N	\N	\N
109	2023-08-03 06:32:29.931536	2023-08-03 06:32:29.931536	Monday	615	2100	17	\N	\N	\N	\N
110	2023-08-03 06:32:29.933343	2023-08-03 06:32:29.933343	Tuesday	145	1015	17	\N	\N	\N	\N
111	2023-08-03 06:32:29.935027	2023-08-03 06:32:29.935027	Tuesday	1530	2400	17	\N	\N	\N	\N
112	2023-08-03 06:32:29.936536	2023-08-03 06:32:29.936536	Wednesday	845	2030	17	\N	\N	\N	\N
113	2023-08-03 06:32:29.93789	2023-08-03 06:32:29.93789	Thursday	830	2030	17	\N	\N	\N	\N
114	2023-08-03 06:32:29.939241	2023-08-03 06:32:29.939241	Friday	715	2230	17	\N	\N	\N	\N
115	2023-08-03 06:32:29.940581	2023-08-03 06:32:29.940581	Saturday	900	1900	17	\N	\N	\N	\N
116	2023-08-03 06:32:29.964317	2023-08-03 06:32:29.964317	Tuesday	2015	100	18	\N	\N	\N	\N
117	2023-08-03 06:32:29.96615	2023-08-03 06:32:29.96615	Wednesday	945	2230	18	\N	\N	\N	\N
118	2023-08-03 06:32:29.967779	2023-08-03 06:32:29.967779	Thursday	245	645	18	\N	\N	\N	\N
119	2023-08-03 06:32:29.96978	2023-08-03 06:32:29.96978	Thursday	2215	145	18	\N	\N	\N	\N
120	2023-08-03 06:32:29.971376	2023-08-03 06:32:29.971376	Friday	645	2300	18	\N	\N	\N	\N
121	2023-08-03 06:32:29.972688	2023-08-03 06:32:29.972688	Saturday	730	2315	18	\N	\N	\N	\N
122	2023-08-03 06:32:29.985767	2023-08-03 06:32:29.985767	Monday	700	2100	19	\N	\N	\N	\N
123	2023-08-03 06:32:29.987152	2023-08-03 06:32:29.987152	Tuesday	715	1930	19	\N	\N	\N	\N
124	2023-08-03 06:32:29.988481	2023-08-03 06:32:29.988481	Wednesday	900	1945	19	\N	\N	\N	\N
125	2023-08-03 06:32:29.989874	2023-08-03 06:32:29.989874	Friday	615	715	19	\N	\N	\N	\N
126	2023-08-03 06:32:29.991249	2023-08-03 06:32:29.991249	Friday	1015	1945	19	\N	\N	\N	\N
127	2023-08-03 06:32:29.992891	2023-08-03 06:32:29.992891	Saturday	815	2215	19	\N	\N	\N	\N
128	2023-08-03 06:32:29.994189	2023-08-03 06:32:29.994189	Sunday	945	1930	19	\N	\N	\N	\N
129	2023-08-03 06:32:30.016004	2023-08-03 06:32:30.016004	Tuesday	900	1845	20	\N	\N	\N	\N
130	2023-08-03 06:32:30.017422	2023-08-03 06:32:30.017422	Wednesday	1530	2015	20	\N	\N	\N	\N
131	2023-08-03 06:32:30.018673	2023-08-03 06:32:30.018673	Wednesday	2330	1200	20	\N	\N	\N	\N
132	2023-08-03 06:32:30.019912	2023-08-03 06:32:30.019912	Friday	645	1600	20	\N	\N	\N	\N
133	2023-08-03 06:32:30.021136	2023-08-03 06:32:30.021136	Sunday	745	1615	20	\N	\N	\N	\N
134	2023-08-03 06:32:30.040688	2023-08-03 06:32:30.040688	Tuesday	1515	115	21	\N	\N	\N	\N
135	2023-08-03 06:32:30.042164	2023-08-03 06:32:30.042164	Wednesday	1830	300	21	\N	\N	\N	\N
136	2023-08-03 06:32:30.043579	2023-08-03 06:32:30.043579	Thursday	630	2200	21	\N	\N	\N	\N
137	2023-08-03 06:32:30.044898	2023-08-03 06:32:30.044898	Sunday	900	1430	21	\N	\N	\N	\N
138	2023-08-03 06:32:30.053836	2023-08-03 06:32:30.053836	Monday	345	715	22	\N	\N	\N	\N
139	2023-08-03 06:32:30.055177	2023-08-03 06:32:30.055177	Monday	1345	330	22	\N	\N	\N	\N
140	2023-08-03 06:32:30.056592	2023-08-03 06:32:30.056592	Tuesday	1400	200	22	\N	\N	\N	\N
141	2023-08-03 06:32:30.05786	2023-08-03 06:32:30.05786	Wednesday	700	2315	22	\N	\N	\N	\N
142	2023-08-03 06:32:30.05922	2023-08-03 06:32:30.05922	Thursday	200	530	22	\N	\N	\N	\N
143	2023-08-03 06:32:30.060781	2023-08-03 06:32:30.060781	Thursday	1100	1900	22	\N	\N	\N	\N
144	2023-08-03 06:32:30.062088	2023-08-03 06:32:30.062088	Saturday	645	1700	22	\N	\N	\N	\N
145	2023-08-03 06:32:30.0635	2023-08-03 06:32:30.0635	Sunday	830	1645	22	\N	\N	\N	\N
146	2023-08-03 06:32:30.078646	2023-08-03 06:32:30.078646	Monday	900	2100	23	\N	\N	\N	\N
147	2023-08-03 06:32:30.080052	2023-08-03 06:32:30.080052	Tuesday	800	1500	23	\N	\N	\N	\N
148	2023-08-03 06:32:30.081474	2023-08-03 06:32:30.081474	Thursday	330	1630	23	\N	\N	\N	\N
149	2023-08-03 06:32:30.082866	2023-08-03 06:32:30.082866	Thursday	1700	2245	23	\N	\N	\N	\N
150	2023-08-03 06:32:30.084266	2023-08-03 06:32:30.084266	Friday	600	1400	23	\N	\N	\N	\N
151	2023-08-03 06:32:30.086193	2023-08-03 06:32:30.086193	Saturday	2300	315	23	\N	\N	\N	\N
152	2023-08-03 06:32:30.087983	2023-08-03 06:32:30.087983	Sunday	1400	300	23	\N	\N	\N	\N
153	2023-08-03 06:32:30.108801	2023-08-03 06:32:30.108801	Wednesday	815	1745	24	\N	\N	\N	\N
154	2023-08-03 06:32:30.110202	2023-08-03 06:32:30.110202	Friday	1000	1415	24	\N	\N	\N	\N
155	2023-08-03 06:32:30.111739	2023-08-03 06:32:30.111739	Saturday	830	2300	24	\N	\N	\N	\N
156	2023-08-03 06:32:30.113129	2023-08-03 06:32:30.113129	Sunday	700	1630	24	\N	\N	\N	\N
157	2023-08-03 06:32:30.122765	2023-08-03 06:32:30.122765	Monday	2245	345	25	\N	\N	\N	\N
158	2023-08-03 06:32:30.124367	2023-08-03 06:32:30.124367	Tuesday	645	1615	25	\N	\N	\N	\N
159	2023-08-03 06:32:30.12585	2023-08-03 06:32:30.12585	Wednesday	45	530	25	\N	\N	\N	\N
160	2023-08-03 06:32:30.127155	2023-08-03 06:32:30.127155	Wednesday	1745	1800	25	\N	\N	\N	\N
161	2023-08-03 06:32:30.128602	2023-08-03 06:32:30.128602	Friday	615	1745	25	\N	\N	\N	\N
162	2023-08-03 06:32:30.148792	2023-08-03 06:32:30.148792	Monday	715	1730	26	\N	\N	\N	\N
163	2023-08-03 06:32:30.150462	2023-08-03 06:32:30.150462	Tuesday	945	1845	26	\N	\N	\N	\N
164	2023-08-03 06:32:30.151761	2023-08-03 06:32:30.151761	Wednesday	600	1600	26	\N	\N	\N	\N
165	2023-08-03 06:32:30.153149	2023-08-03 06:32:30.153149	Thursday	730	2000	26	\N	\N	\N	\N
166	2023-08-03 06:32:30.154535	2023-08-03 06:32:30.154535	Friday	15	900	26	\N	\N	\N	\N
167	2023-08-03 06:32:30.155895	2023-08-03 06:32:30.155895	Friday	915	2115	26	\N	\N	\N	\N
168	2023-08-03 06:32:30.157439	2023-08-03 06:32:30.157439	Saturday	930	1415	26	\N	\N	\N	\N
169	2023-08-03 06:32:30.158787	2023-08-03 06:32:30.158787	Sunday	800	1400	26	\N	\N	\N	\N
170	2023-08-03 06:32:30.168537	2023-08-03 06:32:30.168537	Monday	845	1730	27	\N	\N	\N	\N
171	2023-08-03 06:32:30.169936	2023-08-03 06:32:30.169936	Tuesday	945	2300	27	\N	\N	\N	\N
172	2023-08-03 06:32:30.171408	2023-08-03 06:32:30.171408	Wednesday	700	1130	27	\N	\N	\N	\N
173	2023-08-03 06:32:30.172795	2023-08-03 06:32:30.172795	Wednesday	1515	430	27	\N	\N	\N	\N
174	2023-08-03 06:32:30.174352	2023-08-03 06:32:30.174352	Thursday	600	2245	27	\N	\N	\N	\N
175	2023-08-03 06:32:30.175758	2023-08-03 06:32:30.175758	Saturday	1000	1245	27	\N	\N	\N	\N
176	2023-08-03 06:32:30.177154	2023-08-03 06:32:30.177154	Saturday	1345	1415	27	\N	\N	\N	\N
177	2023-08-03 06:32:30.178464	2023-08-03 06:32:30.178464	Sunday	615	1430	27	\N	\N	\N	\N
178	2023-08-03 06:32:30.199702	2023-08-03 06:32:30.199702	Monday	400	1500	28	\N	\N	\N	\N
179	2023-08-03 06:32:30.201141	2023-08-03 06:32:30.201141	Monday	2315	2345	28	\N	\N	\N	\N
180	2023-08-03 06:32:30.202621	2023-08-03 06:32:30.202621	Tuesday	545	730	28	\N	\N	\N	\N
181	2023-08-03 06:32:30.204145	2023-08-03 06:32:30.204145	Tuesday	1500	1545	28	\N	\N	\N	\N
182	2023-08-03 06:32:30.205646	2023-08-03 06:32:30.205646	Wednesday	930	1930	28	\N	\N	\N	\N
183	2023-08-03 06:32:30.207021	2023-08-03 06:32:30.207021	Friday	715	1545	28	\N	\N	\N	\N
184	2023-08-03 06:32:30.208454	2023-08-03 06:32:30.208454	Saturday	615	1600	28	\N	\N	\N	\N
185	2023-08-03 06:32:30.209831	2023-08-03 06:32:30.209831	Sunday	815	1915	28	\N	\N	\N	\N
186	2023-08-03 06:32:30.222733	2023-08-03 06:32:30.222733	Monday	730	1545	29	\N	\N	\N	\N
187	2023-08-03 06:32:30.224168	2023-08-03 06:32:30.224168	Tuesday	1615	315	29	\N	\N	\N	\N
188	2023-08-03 06:32:30.225514	2023-08-03 06:32:30.225514	Wednesday	2230	200	29	\N	\N	\N	\N
189	2023-08-03 06:32:30.226852	2023-08-03 06:32:30.226852	Thursday	215	730	29	\N	\N	\N	\N
190	2023-08-03 06:32:30.228483	2023-08-03 06:32:30.228483	Thursday	1245	1445	29	\N	\N	\N	\N
191	2023-08-03 06:32:30.22986	2023-08-03 06:32:30.22986	Friday	0	115	29	\N	\N	\N	\N
192	2023-08-03 06:32:30.231171	2023-08-03 06:32:30.231171	Friday	515	2245	29	\N	\N	\N	\N
193	2023-08-03 06:32:30.232456	2023-08-03 06:32:30.232456	Sunday	800	1745	29	\N	\N	\N	\N
194	2023-08-03 06:32:30.248083	2023-08-03 06:32:30.248083	Monday	130	215	30	\N	\N	\N	\N
195	2023-08-03 06:32:30.249305	2023-08-03 06:32:30.249305	Monday	1130	1345	30	\N	\N	\N	\N
196	2023-08-03 06:32:30.250578	2023-08-03 06:32:30.250578	Tuesday	900	1715	30	\N	\N	\N	\N
197	2023-08-03 06:32:30.252139	2023-08-03 06:32:30.252139	Wednesday	1615	300	30	\N	\N	\N	\N
198	2023-08-03 06:32:30.253411	2023-08-03 06:32:30.253411	Thursday	1000	1645	30	\N	\N	\N	\N
199	2023-08-03 06:32:30.2548	2023-08-03 06:32:30.2548	Sunday	45	1500	30	\N	\N	\N	\N
200	2023-08-03 06:32:30.256082	2023-08-03 06:32:30.256082	Sunday	1830	1945	30	\N	\N	\N	\N
201	2023-08-03 06:32:30.275123	2023-08-03 06:32:30.275123	Wednesday	2200	215	31	\N	\N	\N	\N
202	2023-08-03 06:32:30.276452	2023-08-03 06:32:30.276452	Friday	1915	300	31	\N	\N	\N	\N
203	2023-08-03 06:32:30.277794	2023-08-03 06:32:30.277794	Sunday	2145	130	31	\N	\N	\N	\N
204	2023-08-03 06:32:30.28754	2023-08-03 06:32:30.28754	Monday	830	1600	32	\N	\N	\N	\N
205	2023-08-03 06:32:30.288885	2023-08-03 06:32:30.288885	Tuesday	700	2345	32	\N	\N	\N	\N
206	2023-08-03 06:32:30.290274	2023-08-03 06:32:30.290274	Wednesday	930	2215	32	\N	\N	\N	\N
207	2023-08-03 06:32:30.291561	2023-08-03 06:32:30.291561	Thursday	815	1400	32	\N	\N	\N	\N
208	2023-08-03 06:32:30.292858	2023-08-03 06:32:30.292858	Saturday	715	2245	32	\N	\N	\N	\N
209	2023-08-03 06:32:30.294232	2023-08-03 06:32:30.294232	Sunday	100	1515	32	\N	\N	\N	\N
210	2023-08-03 06:32:30.295524	2023-08-03 06:32:30.295524	Sunday	1730	1800	32	\N	\N	\N	\N
211	2023-08-03 06:32:30.311295	2023-08-03 06:32:30.311295	Monday	2230	230	33	\N	\N	\N	\N
212	2023-08-03 06:32:30.312656	2023-08-03 06:32:30.312656	Tuesday	615	2330	33	\N	\N	\N	\N
213	2023-08-03 06:32:30.3139	2023-08-03 06:32:30.3139	Wednesday	600	2230	33	\N	\N	\N	\N
214	2023-08-03 06:32:30.315137	2023-08-03 06:32:30.315137	Thursday	815	1700	33	\N	\N	\N	\N
215	2023-08-03 06:32:30.316383	2023-08-03 06:32:30.316383	Friday	830	1715	33	\N	\N	\N	\N
216	2023-08-03 06:32:30.317655	2023-08-03 06:32:30.317655	Sunday	700	1800	33	\N	\N	\N	\N
217	2023-08-03 06:32:30.336914	2023-08-03 06:32:30.336914	Monday	1645	100	34	\N	\N	\N	\N
218	2023-08-03 06:32:30.338257	2023-08-03 06:32:30.338257	Wednesday	700	2330	34	\N	\N	\N	\N
219	2023-08-03 06:32:30.339558	2023-08-03 06:32:30.339558	Thursday	645	1945	34	\N	\N	\N	\N
220	2023-08-03 06:32:30.340801	2023-08-03 06:32:30.340801	Friday	700	2000	34	\N	\N	\N	\N
221	2023-08-03 06:32:30.342026	2023-08-03 06:32:30.342026	Saturday	815	2345	34	\N	\N	\N	\N
222	2023-08-03 06:32:30.343307	2023-08-03 06:32:30.343307	Sunday	630	1815	34	\N	\N	\N	\N
223	2023-08-03 06:32:30.353108	2023-08-03 06:32:30.353108	Monday	630	2200	35	\N	\N	\N	\N
224	2023-08-03 06:32:30.354388	2023-08-03 06:32:30.354388	Tuesday	745	1530	35	\N	\N	\N	\N
225	2023-08-03 06:32:30.355685	2023-08-03 06:32:30.355685	Wednesday	630	2300	35	\N	\N	\N	\N
226	2023-08-03 06:32:30.357186	2023-08-03 06:32:30.357186	Thursday	730	2200	35	\N	\N	\N	\N
227	2023-08-03 06:32:30.358399	2023-08-03 06:32:30.358399	Thursday	2300	2330	35	\N	\N	\N	\N
228	2023-08-03 06:32:30.359713	2023-08-03 06:32:30.359713	Friday	915	2000	35	\N	\N	\N	\N
229	2023-08-03 06:32:30.360999	2023-08-03 06:32:30.360999	Saturday	1415	400	35	\N	\N	\N	\N
230	2023-08-03 06:32:30.362277	2023-08-03 06:32:30.362277	Sunday	545	800	35	\N	\N	\N	\N
231	2023-08-03 06:32:30.363513	2023-08-03 06:32:30.363513	Sunday	1445	1845	35	\N	\N	\N	\N
232	2023-08-03 06:32:30.379203	2023-08-03 06:32:30.379203	Monday	615	1430	36	\N	\N	\N	\N
233	2023-08-03 06:32:30.380814	2023-08-03 06:32:30.380814	Tuesday	1915	230	36	\N	\N	\N	\N
234	2023-08-03 06:32:30.382131	2023-08-03 06:32:30.382131	Wednesday	830	2200	36	\N	\N	\N	\N
235	2023-08-03 06:32:30.383507	2023-08-03 06:32:30.383507	Friday	945	1600	36	\N	\N	\N	\N
236	2023-08-03 06:32:30.384854	2023-08-03 06:32:30.384854	Saturday	1600	345	36	\N	\N	\N	\N
237	2023-08-03 06:32:30.386204	2023-08-03 06:32:30.386204	Sunday	15	445	36	\N	\N	\N	\N
238	2023-08-03 06:32:30.387536	2023-08-03 06:32:30.387536	Sunday	645	815	36	\N	\N	\N	\N
239	2023-08-03 06:32:30.407667	2023-08-03 06:32:30.407667	Monday	1400	215	37	\N	\N	\N	\N
240	2023-08-03 06:32:30.408946	2023-08-03 06:32:30.408946	Wednesday	600	1715	37	\N	\N	\N	\N
241	2023-08-03 06:32:30.410278	2023-08-03 06:32:30.410278	Thursday	1215	1745	37	\N	\N	\N	\N
242	2023-08-03 06:32:30.411564	2023-08-03 06:32:30.411564	Thursday	1900	415	37	\N	\N	\N	\N
243	2023-08-03 06:32:30.412854	2023-08-03 06:32:30.412854	Friday	200	1015	37	\N	\N	\N	\N
244	2023-08-03 06:32:30.414109	2023-08-03 06:32:30.414109	Friday	1500	1615	37	\N	\N	\N	\N
245	2023-08-03 06:32:30.415436	2023-08-03 06:32:30.415436	Saturday	845	945	37	\N	\N	\N	\N
246	2023-08-03 06:32:30.416925	2023-08-03 06:32:30.416925	Saturday	1200	1545	37	\N	\N	\N	\N
247	2023-08-03 06:32:30.418172	2023-08-03 06:32:30.418172	Sunday	845	1415	37	\N	\N	\N	\N
248	2023-08-03 06:32:30.427053	2023-08-03 06:32:30.427053	Monday	400	1745	38	\N	\N	\N	\N
249	2023-08-03 06:32:30.428533	2023-08-03 06:32:30.428533	Monday	1930	245	38	\N	\N	\N	\N
250	2023-08-03 06:32:30.429841	2023-08-03 06:32:30.429841	Tuesday	615	1915	38	\N	\N	\N	\N
251	2023-08-03 06:32:30.431156	2023-08-03 06:32:30.431156	Wednesday	2030	330	38	\N	\N	\N	\N
252	2023-08-03 06:32:30.432601	2023-08-03 06:32:30.432601	Thursday	1415	400	38	\N	\N	\N	\N
253	2023-08-03 06:32:30.433946	2023-08-03 06:32:30.433946	Friday	500	1500	38	\N	\N	\N	\N
254	2023-08-03 06:32:30.435186	2023-08-03 06:32:30.435186	Friday	1730	2130	38	\N	\N	\N	\N
255	2023-08-03 06:32:30.454298	2023-08-03 06:32:30.454298	Monday	1345	1400	39	\N	\N	\N	\N
256	2023-08-03 06:32:30.455579	2023-08-03 06:32:30.455579	Monday	2015	2245	39	\N	\N	\N	\N
257	2023-08-03 06:32:30.456992	2023-08-03 06:32:30.456992	Tuesday	1000	1845	39	\N	\N	\N	\N
258	2023-08-03 06:32:30.458308	2023-08-03 06:32:30.458308	Friday	700	2315	39	\N	\N	\N	\N
259	2023-08-03 06:32:30.459585	2023-08-03 06:32:30.459585	Saturday	815	1630	39	\N	\N	\N	\N
260	2023-08-03 06:32:30.468812	2023-08-03 06:32:30.468812	Monday	1930	400	40	\N	\N	\N	\N
261	2023-08-03 06:32:30.470148	2023-08-03 06:32:30.470148	Tuesday	945	1700	40	\N	\N	\N	\N
262	2023-08-03 06:32:30.471464	2023-08-03 06:32:30.471464	Wednesday	1615	245	40	\N	\N	\N	\N
263	2023-08-03 06:32:30.472797	2023-08-03 06:32:30.472797	Thursday	730	1830	40	\N	\N	\N	\N
264	2023-08-03 06:32:30.474087	2023-08-03 06:32:30.474087	Friday	1000	1530	40	\N	\N	\N	\N
265	2023-08-03 06:32:30.475389	2023-08-03 06:32:30.475389	Sunday	615	2145	40	\N	\N	\N	\N
266	2023-08-03 06:32:30.498425	2023-08-03 06:32:30.498425	Monday	415	645	41	\N	\N	\N	\N
267	2023-08-03 06:32:30.499698	2023-08-03 06:32:30.499698	Monday	1445	2130	41	\N	\N	\N	\N
268	2023-08-03 06:32:30.500943	2023-08-03 06:32:30.500943	Tuesday	930	1945	41	\N	\N	\N	\N
269	2023-08-03 06:32:30.502211	2023-08-03 06:32:30.502211	Wednesday	1000	1745	41	\N	\N	\N	\N
270	2023-08-03 06:32:30.50345	2023-08-03 06:32:30.50345	Thursday	1600	230	41	\N	\N	\N	\N
271	2023-08-03 06:32:30.504985	2023-08-03 06:32:30.504985	Friday	2300	245	41	\N	\N	\N	\N
272	2023-08-03 06:32:30.506265	2023-08-03 06:32:30.506265	Sunday	1500	130	41	\N	\N	\N	\N
273	2023-08-03 06:32:30.515356	2023-08-03 06:32:30.515356	Monday	715	1945	42	\N	\N	\N	\N
274	2023-08-03 06:32:30.51695	2023-08-03 06:32:30.51695	Wednesday	630	1700	42	\N	\N	\N	\N
275	2023-08-03 06:32:30.518239	2023-08-03 06:32:30.518239	Thursday	815	1515	42	\N	\N	\N	\N
276	2023-08-03 06:32:30.519466	2023-08-03 06:32:30.519466	Saturday	615	1600	42	\N	\N	\N	\N
277	2023-08-03 06:32:30.520728	2023-08-03 06:32:30.520728	Sunday	645	1600	42	\N	\N	\N	\N
278	2023-08-03 06:32:30.539984	2023-08-03 06:32:30.539984	Monday	800	1700	43	\N	\N	\N	\N
279	2023-08-03 06:32:30.541227	2023-08-03 06:32:30.541227	Monday	1945	630	43	\N	\N	\N	\N
280	2023-08-03 06:32:30.542507	2023-08-03 06:32:30.542507	Wednesday	2130	100	43	\N	\N	\N	\N
281	2023-08-03 06:32:30.543756	2023-08-03 06:32:30.543756	Thursday	815	2400	43	\N	\N	\N	\N
282	2023-08-03 06:32:30.545008	2023-08-03 06:32:30.545008	Friday	630	2215	43	\N	\N	\N	\N
283	2023-08-03 06:32:30.546286	2023-08-03 06:32:30.546286	Saturday	430	2015	43	\N	\N	\N	\N
284	2023-08-03 06:32:30.547533	2023-08-03 06:32:30.547533	Saturday	2115	2145	43	\N	\N	\N	\N
285	2023-08-03 06:32:30.557212	2023-08-03 06:32:30.557212	Monday	1715	130	44	\N	\N	\N	\N
286	2023-08-03 06:32:30.558542	2023-08-03 06:32:30.558542	Tuesday	745	1415	44	\N	\N	\N	\N
287	2023-08-03 06:32:30.559867	2023-08-03 06:32:30.559867	Thursday	615	2345	44	\N	\N	\N	\N
288	2023-08-03 06:32:30.56124	2023-08-03 06:32:30.56124	Friday	1945	330	44	\N	\N	\N	\N
289	2023-08-03 06:32:30.562741	2023-08-03 06:32:30.562741	Sunday	800	1400	44	\N	\N	\N	\N
290	2023-08-03 06:32:30.578344	2023-08-03 06:32:30.578344	Monday	815	1745	45	\N	\N	\N	\N
291	2023-08-03 06:32:30.579685	2023-08-03 06:32:30.579685	Wednesday	300	900	45	\N	\N	\N	\N
292	2023-08-03 06:32:30.580972	2023-08-03 06:32:30.580972	Wednesday	930	1045	45	\N	\N	\N	\N
293	2023-08-03 06:32:30.582317	2023-08-03 06:32:30.582317	Thursday	815	1845	45	\N	\N	\N	\N
294	2023-08-03 06:32:30.583588	2023-08-03 06:32:30.583588	Thursday	2100	315	45	\N	\N	\N	\N
295	2023-08-03 06:32:30.58494	2023-08-03 06:32:30.58494	Friday	1230	1300	45	\N	\N	\N	\N
296	2023-08-03 06:32:30.586476	2023-08-03 06:32:30.586476	Friday	1515	2400	45	\N	\N	\N	\N
297	2023-08-03 06:32:30.588032	2023-08-03 06:32:30.588032	Saturday	915	1900	45	\N	\N	\N	\N
298	2023-08-03 06:32:30.589806	2023-08-03 06:32:30.589806	Sunday	800	1230	45	\N	\N	\N	\N
299	2023-08-03 06:32:30.591109	2023-08-03 06:32:30.591109	Sunday	1515	2030	45	\N	\N	\N	\N
300	2023-08-03 06:32:30.612757	2023-08-03 06:32:30.612757	Monday	915	2400	46	\N	\N	\N	\N
301	2023-08-03 06:32:30.614716	2023-08-03 06:32:30.614716	Tuesday	1745	1800	46	\N	\N	\N	\N
302	2023-08-03 06:32:30.616392	2023-08-03 06:32:30.616392	Tuesday	2145	200	46	\N	\N	\N	\N
303	2023-08-03 06:32:30.618793	2023-08-03 06:32:30.618793	Wednesday	845	1615	46	\N	\N	\N	\N
304	2023-08-03 06:32:30.62246	2023-08-03 06:32:30.62246	Thursday	230	945	46	\N	\N	\N	\N
305	2023-08-03 06:32:30.625179	2023-08-03 06:32:30.625179	Thursday	1200	1430	46	\N	\N	\N	\N
306	2023-08-03 06:32:30.626873	2023-08-03 06:32:30.626873	Saturday	1930	315	46	\N	\N	\N	\N
307	2023-08-03 06:32:30.628623	2023-08-03 06:32:30.628623	Sunday	815	2115	46	\N	\N	\N	\N
308	2023-08-03 06:32:30.639455	2023-08-03 06:32:30.639455	Tuesday	30	1200	47	\N	\N	\N	\N
309	2023-08-03 06:32:30.641465	2023-08-03 06:32:30.641465	Tuesday	1330	1415	47	\N	\N	\N	\N
310	2023-08-03 06:32:30.643256	2023-08-03 06:32:30.643256	Wednesday	1000	1015	47	\N	\N	\N	\N
311	2023-08-03 06:32:30.644654	2023-08-03 06:32:30.644654	Wednesday	1230	2400	47	\N	\N	\N	\N
312	2023-08-03 06:32:30.646057	2023-08-03 06:32:30.646057	Thursday	730	1700	47	\N	\N	\N	\N
313	2023-08-03 06:32:30.647702	2023-08-03 06:32:30.647702	Friday	745	1600	47	\N	\N	\N	\N
314	2023-08-03 06:32:30.649043	2023-08-03 06:32:30.649043	Sunday	1600	1615	47	\N	\N	\N	\N
315	2023-08-03 06:32:30.6504	2023-08-03 06:32:30.6504	Sunday	1630	2200	47	\N	\N	\N	\N
316	2023-08-03 06:32:30.667093	2023-08-03 06:32:30.667093	Monday	345	1815	48	\N	\N	\N	\N
317	2023-08-03 06:32:30.668439	2023-08-03 06:32:30.668439	Monday	2000	2315	48	\N	\N	\N	\N
318	2023-08-03 06:32:30.6697	2023-08-03 06:32:30.6697	Wednesday	615	2400	48	\N	\N	\N	\N
319	2023-08-03 06:32:30.670979	2023-08-03 06:32:30.670979	Thursday	645	1930	48	\N	\N	\N	\N
320	2023-08-03 06:32:30.672329	2023-08-03 06:32:30.672329	Friday	1315	1600	48	\N	\N	\N	\N
321	2023-08-03 06:32:30.673726	2023-08-03 06:32:30.673726	Friday	1800	900	48	\N	\N	\N	\N
322	2023-08-03 06:32:30.674994	2023-08-03 06:32:30.674994	Sunday	730	2115	48	\N	\N	\N	\N
323	2023-08-03 06:32:30.693005	2023-08-03 06:32:30.693005	Monday	1830	300	49	\N	\N	\N	\N
324	2023-08-03 06:32:30.694323	2023-08-03 06:32:30.694323	Tuesday	515	1215	49	\N	\N	\N	\N
325	2023-08-03 06:32:30.69561	2023-08-03 06:32:30.69561	Tuesday	1715	2130	49	\N	\N	\N	\N
326	2023-08-03 06:32:30.697107	2023-08-03 06:32:30.697107	Wednesday	645	1730	49	\N	\N	\N	\N
327	2023-08-03 06:32:30.698383	2023-08-03 06:32:30.698383	Thursday	700	2300	49	\N	\N	\N	\N
328	2023-08-03 06:32:30.699724	2023-08-03 06:32:30.699724	Friday	745	1545	49	\N	\N	\N	\N
329	2023-08-03 06:32:30.701039	2023-08-03 06:32:30.701039	Saturday	600	2145	49	\N	\N	\N	\N
330	2023-08-03 06:32:30.702558	2023-08-03 06:32:30.702558	Sunday	815	2030	49	\N	\N	\N	\N
331	2023-08-03 06:32:30.711237	2023-08-03 06:32:30.711237	Tuesday	815	1830	50	\N	\N	\N	\N
332	2023-08-03 06:32:30.712631	2023-08-03 06:32:30.712631	Wednesday	830	845	50	\N	\N	\N	\N
333	2023-08-03 06:32:30.713907	2023-08-03 06:32:30.713907	Wednesday	1115	2100	50	\N	\N	\N	\N
334	2023-08-03 06:32:30.715208	2023-08-03 06:32:30.715208	Thursday	815	2115	50	\N	\N	\N	\N
335	2023-08-03 06:32:30.716524	2023-08-03 06:32:30.716524	Saturday	745	1415	50	\N	\N	\N	\N
336	2023-08-03 06:32:30.71782	2023-08-03 06:32:30.71782	Sunday	1000	1700	50	\N	\N	\N	\N
337	2023-08-03 06:32:30.737795	2023-08-03 06:32:30.737795	Monday	1615	230	51	\N	\N	\N	\N
338	2023-08-03 06:32:30.739133	2023-08-03 06:32:30.739133	Wednesday	645	2400	51	\N	\N	\N	\N
339	2023-08-03 06:32:30.740354	2023-08-03 06:32:30.740354	Thursday	900	1630	51	\N	\N	\N	\N
340	2023-08-03 06:32:30.741594	2023-08-03 06:32:30.741594	Saturday	2300	215	51	\N	\N	\N	\N
341	2023-08-03 06:32:30.743066	2023-08-03 06:32:30.743066	Sunday	845	1400	51	\N	\N	\N	\N
342	2023-08-03 06:32:30.752634	2023-08-03 06:32:30.752634	Monday	1330	1845	52	\N	\N	\N	\N
343	2023-08-03 06:32:30.753863	2023-08-03 06:32:30.753863	Monday	2330	845	52	\N	\N	\N	\N
344	2023-08-03 06:32:30.755546	2023-08-03 06:32:30.755546	Tuesday	645	1415	52	\N	\N	\N	\N
345	2023-08-03 06:32:30.756813	2023-08-03 06:32:30.756813	Wednesday	1445	245	52	\N	\N	\N	\N
346	2023-08-03 06:32:30.758117	2023-08-03 06:32:30.758117	Thursday	1945	345	52	\N	\N	\N	\N
347	2023-08-03 06:32:30.759415	2023-08-03 06:32:30.759415	Friday	415	515	52	\N	\N	\N	\N
348	2023-08-03 06:32:30.760686	2023-08-03 06:32:30.760686	Friday	1430	2000	52	\N	\N	\N	\N
349	2023-08-03 06:32:30.762095	2023-08-03 06:32:30.762095	Saturday	515	530	52	\N	\N	\N	\N
350	2023-08-03 06:32:30.763349	2023-08-03 06:32:30.763349	Saturday	1530	2315	52	\N	\N	\N	\N
351	2023-08-03 06:32:30.764574	2023-08-03 06:32:30.764574	Sunday	745	2330	52	\N	\N	\N	\N
352	2023-08-03 06:32:30.780813	2023-08-03 06:32:30.780813	Monday	0	745	53	\N	\N	\N	\N
353	2023-08-03 06:32:30.782108	2023-08-03 06:32:30.782108	Monday	900	1015	53	\N	\N	\N	\N
354	2023-08-03 06:32:30.783388	2023-08-03 06:32:30.783388	Tuesday	800	2200	53	\N	\N	\N	\N
355	2023-08-03 06:32:30.784649	2023-08-03 06:32:30.784649	Thursday	815	1845	53	\N	\N	\N	\N
356	2023-08-03 06:32:30.785871	2023-08-03 06:32:30.785871	Saturday	815	2400	53	\N	\N	\N	\N
357	2023-08-03 06:32:30.787083	2023-08-03 06:32:30.787083	Sunday	800	1400	53	\N	\N	\N	\N
358	2023-08-03 06:32:30.805758	2023-08-03 06:32:30.805758	Tuesday	600	1730	54	\N	\N	\N	\N
359	2023-08-03 06:32:30.807064	2023-08-03 06:32:30.807064	Wednesday	1000	2300	54	\N	\N	\N	\N
360	2023-08-03 06:32:30.808317	2023-08-03 06:32:30.808317	Thursday	730	2315	54	\N	\N	\N	\N
361	2023-08-03 06:32:30.809628	2023-08-03 06:32:30.809628	Saturday	730	2215	54	\N	\N	\N	\N
362	2023-08-03 06:32:30.818774	2023-08-03 06:32:30.818774	Monday	1600	345	55	\N	\N	\N	\N
363	2023-08-03 06:32:30.8201	2023-08-03 06:32:30.8201	Tuesday	800	1615	55	\N	\N	\N	\N
364	2023-08-03 06:32:30.821389	2023-08-03 06:32:30.821389	Wednesday	615	1545	55	\N	\N	\N	\N
365	2023-08-03 06:32:30.822653	2023-08-03 06:32:30.822653	Thursday	600	1345	55	\N	\N	\N	\N
366	2023-08-03 06:32:30.823856	2023-08-03 06:32:30.823856	Thursday	1415	1700	55	\N	\N	\N	\N
367	2023-08-03 06:32:30.825091	2023-08-03 06:32:30.825091	Friday	845	2315	55	\N	\N	\N	\N
368	2023-08-03 06:32:30.826511	2023-08-03 06:32:30.826511	Saturday	915	1515	55	\N	\N	\N	\N
369	2023-08-03 06:32:30.827785	2023-08-03 06:32:30.827785	Sunday	100	415	55	\N	\N	\N	\N
370	2023-08-03 06:32:30.829028	2023-08-03 06:32:30.829028	Sunday	1015	2100	55	\N	\N	\N	\N
371	2023-08-03 06:32:30.846768	2023-08-03 06:32:30.846768	Monday	845	1845	56	\N	\N	\N	\N
372	2023-08-03 06:32:30.848057	2023-08-03 06:32:30.848057	Tuesday	830	2215	56	\N	\N	\N	\N
373	2023-08-03 06:32:30.849583	2023-08-03 06:32:30.849583	Wednesday	700	1200	56	\N	\N	\N	\N
374	2023-08-03 06:32:30.850814	2023-08-03 06:32:30.850814	Wednesday	1730	2030	56	\N	\N	\N	\N
375	2023-08-03 06:32:30.852242	2023-08-03 06:32:30.852242	Thursday	815	830	56	\N	\N	\N	\N
376	2023-08-03 06:32:30.854676	2023-08-03 06:32:30.854676	Thursday	1630	1930	56	\N	\N	\N	\N
377	2023-08-03 06:32:30.856169	2023-08-03 06:32:30.856169	Friday	430	445	56	\N	\N	\N	\N
378	2023-08-03 06:32:30.857467	2023-08-03 06:32:30.857467	Friday	1045	1130	56	\N	\N	\N	\N
379	2023-08-03 06:32:30.866019	2023-08-03 06:32:30.866019	Tuesday	615	1830	57	\N	\N	\N	\N
380	2023-08-03 06:32:30.867355	2023-08-03 06:32:30.867355	Wednesday	100	1015	57	\N	\N	\N	\N
381	2023-08-03 06:32:30.868658	2023-08-03 06:32:30.868658	Wednesday	1515	2015	57	\N	\N	\N	\N
382	2023-08-03 06:32:30.869963	2023-08-03 06:32:30.869963	Thursday	730	1745	57	\N	\N	\N	\N
383	2023-08-03 06:32:30.871463	2023-08-03 06:32:30.871463	Friday	215	245	57	\N	\N	\N	\N
384	2023-08-03 06:32:30.872753	2023-08-03 06:32:30.872753	Friday	500	700	57	\N	\N	\N	\N
385	2023-08-03 06:32:30.874181	2023-08-03 06:32:30.874181	Saturday	915	1530	57	\N	\N	\N	\N
386	2023-08-03 06:32:30.888196	2023-08-03 06:32:30.888196	Monday	845	2300	58	\N	\N	\N	\N
387	2023-08-03 06:32:30.889486	2023-08-03 06:32:30.889486	Tuesday	630	1730	58	\N	\N	\N	\N
388	2023-08-03 06:32:30.890787	2023-08-03 06:32:30.890787	Wednesday	0	830	58	\N	\N	\N	\N
389	2023-08-03 06:32:30.892	2023-08-03 06:32:30.892	Wednesday	1600	1845	58	\N	\N	\N	\N
390	2023-08-03 06:32:30.893298	2023-08-03 06:32:30.893298	Thursday	615	2400	58	\N	\N	\N	\N
391	2023-08-03 06:32:30.894626	2023-08-03 06:32:30.894626	Friday	1600	245	58	\N	\N	\N	\N
392	2023-08-03 06:32:30.895951	2023-08-03 06:32:30.895951	Sunday	2215	315	58	\N	\N	\N	\N
393	2023-08-03 06:32:30.914797	2023-08-03 06:32:30.914797	Monday	545	830	59	\N	\N	\N	\N
394	2023-08-03 06:32:30.916036	2023-08-03 06:32:30.916036	Monday	1215	2200	59	\N	\N	\N	\N
395	2023-08-03 06:32:30.917348	2023-08-03 06:32:30.917348	Tuesday	915	2330	59	\N	\N	\N	\N
396	2023-08-03 06:32:30.918627	2023-08-03 06:32:30.918627	Friday	815	1900	59	\N	\N	\N	\N
397	2023-08-03 06:32:30.919913	2023-08-03 06:32:30.919913	Sunday	945	1515	59	\N	\N	\N	\N
398	2023-08-03 06:32:30.929212	2023-08-03 06:32:30.929212	Monday	930	2045	60	\N	\N	\N	\N
399	2023-08-03 06:32:30.9305	2023-08-03 06:32:30.9305	Tuesday	815	1700	60	\N	\N	\N	\N
400	2023-08-03 06:32:30.931878	2023-08-03 06:32:30.931878	Wednesday	130	1545	60	\N	\N	\N	\N
401	2023-08-03 06:32:30.933341	2023-08-03 06:32:30.933341	Wednesday	1615	1645	60	\N	\N	\N	\N
402	2023-08-03 06:32:30.934689	2023-08-03 06:32:30.934689	Thursday	15	145	60	\N	\N	\N	\N
403	2023-08-03 06:32:30.935927	2023-08-03 06:32:30.935927	Thursday	815	945	60	\N	\N	\N	\N
404	2023-08-03 06:32:30.937237	2023-08-03 06:32:30.937237	Friday	1615	130	60	\N	\N	\N	\N
405	2023-08-03 06:32:30.9385	2023-08-03 06:32:30.9385	Saturday	1530	230	60	\N	\N	\N	\N
406	2023-08-03 06:32:30.939734	2023-08-03 06:32:30.939734	Sunday	930	2000	60	\N	\N	\N	\N
407	2023-08-03 06:32:30.954882	2023-08-03 06:32:30.954882	Monday	200	400	61	\N	\N	\N	\N
408	2023-08-03 06:32:30.956149	2023-08-03 06:32:30.956149	Monday	1400	1800	61	\N	\N	\N	\N
409	2023-08-03 06:32:30.95771	2023-08-03 06:32:30.95771	Tuesday	445	500	61	\N	\N	\N	\N
410	2023-08-03 06:32:30.959049	2023-08-03 06:32:30.959049	Tuesday	1745	230	61	\N	\N	\N	\N
411	2023-08-03 06:32:30.960363	2023-08-03 06:32:30.960363	Wednesday	700	1900	61	\N	\N	\N	\N
412	2023-08-03 06:32:30.961658	2023-08-03 06:32:30.961658	Thursday	800	2000	61	\N	\N	\N	\N
413	2023-08-03 06:32:30.963015	2023-08-03 06:32:30.963015	Friday	615	2000	61	\N	\N	\N	\N
414	2023-08-03 06:32:30.964304	2023-08-03 06:32:30.964304	Saturday	300	315	61	\N	\N	\N	\N
415	2023-08-03 06:32:30.965555	2023-08-03 06:32:30.965555	Saturday	715	915	61	\N	\N	\N	\N
416	2023-08-03 06:32:30.966854	2023-08-03 06:32:30.966854	Sunday	730	1800	61	\N	\N	\N	\N
417	2023-08-03 06:32:30.987676	2023-08-03 06:32:30.987676	Monday	615	2100	62	\N	\N	\N	\N
418	2023-08-03 06:32:30.989017	2023-08-03 06:32:30.989017	Tuesday	945	1800	62	\N	\N	\N	\N
419	2023-08-03 06:32:30.990393	2023-08-03 06:32:30.990393	Thursday	145	1530	62	\N	\N	\N	\N
420	2023-08-03 06:32:30.991794	2023-08-03 06:32:30.991794	Thursday	1630	2100	62	\N	\N	\N	\N
421	2023-08-03 06:32:30.993299	2023-08-03 06:32:30.993299	Friday	830	1615	62	\N	\N	\N	\N
422	2023-08-03 06:32:30.994688	2023-08-03 06:32:30.994688	Saturday	915	1600	62	\N	\N	\N	\N
423	2023-08-03 06:32:30.996131	2023-08-03 06:32:30.996131	Sunday	2015	300	62	\N	\N	\N	\N
424	2023-08-03 06:32:31.006415	2023-08-03 06:32:31.006415	Monday	745	2115	63	\N	\N	\N	\N
425	2023-08-03 06:32:31.007815	2023-08-03 06:32:31.007815	Wednesday	715	2230	63	\N	\N	\N	\N
426	2023-08-03 06:32:31.009242	2023-08-03 06:32:31.009242	Thursday	930	1845	63	\N	\N	\N	\N
427	2023-08-03 06:32:31.01055	2023-08-03 06:32:31.01055	Friday	630	2130	63	\N	\N	\N	\N
428	2023-08-03 06:32:31.0119	2023-08-03 06:32:31.0119	Sunday	845	1945	63	\N	\N	\N	\N
429	2023-08-03 06:32:31.028322	2023-08-03 06:32:31.028322	Monday	930	1730	64	\N	\N	\N	\N
430	2023-08-03 06:32:31.029782	2023-08-03 06:32:31.029782	Tuesday	1445	400	64	\N	\N	\N	\N
431	2023-08-03 06:32:31.031366	2023-08-03 06:32:31.031366	Wednesday	1600	300	64	\N	\N	\N	\N
432	2023-08-03 06:32:31.032715	2023-08-03 06:32:31.032715	Thursday	1915	100	64	\N	\N	\N	\N
433	2023-08-03 06:32:31.034048	2023-08-03 06:32:31.034048	Friday	830	1600	64	\N	\N	\N	\N
434	2023-08-03 06:32:31.035372	2023-08-03 06:32:31.035372	Saturday	645	2345	64	\N	\N	\N	\N
435	2023-08-03 06:32:31.036765	2023-08-03 06:32:31.036765	Sunday	645	830	64	\N	\N	\N	\N
436	2023-08-03 06:32:31.038074	2023-08-03 06:32:31.038074	Sunday	1030	1500	64	\N	\N	\N	\N
437	2023-08-03 06:32:31.061088	2023-08-03 06:32:31.061088	Monday	230	1000	65	\N	\N	\N	\N
438	2023-08-03 06:32:31.062409	2023-08-03 06:32:31.062409	Monday	1245	2330	65	\N	\N	\N	\N
439	2023-08-03 06:32:31.063731	2023-08-03 06:32:31.063731	Wednesday	645	2215	65	\N	\N	\N	\N
440	2023-08-03 06:32:31.065035	2023-08-03 06:32:31.065035	Friday	900	2100	65	\N	\N	\N	\N
441	2023-08-03 06:32:31.066371	2023-08-03 06:32:31.066371	Saturday	900	1515	65	\N	\N	\N	\N
442	2023-08-03 06:32:31.067702	2023-08-03 06:32:31.067702	Sunday	1930	300	65	\N	\N	\N	\N
443	2023-08-03 06:32:31.077834	2023-08-03 06:32:31.077834	Monday	2145	200	66	\N	\N	\N	\N
444	2023-08-03 06:32:31.079311	2023-08-03 06:32:31.079311	Tuesday	1045	1100	66	\N	\N	\N	\N
445	2023-08-03 06:32:31.080565	2023-08-03 06:32:31.080565	Tuesday	1700	615	66	\N	\N	\N	\N
446	2023-08-03 06:32:31.082093	2023-08-03 06:32:31.082093	Wednesday	500	945	66	\N	\N	\N	\N
447	2023-08-03 06:32:31.083468	2023-08-03 06:32:31.083468	Wednesday	1100	115	66	\N	\N	\N	\N
448	2023-08-03 06:32:31.084812	2023-08-03 06:32:31.084812	Thursday	745	1700	66	\N	\N	\N	\N
449	2023-08-03 06:32:31.08623	2023-08-03 06:32:31.08623	Friday	1145	1615	66	\N	\N	\N	\N
450	2023-08-03 06:32:31.087521	2023-08-03 06:32:31.087521	Friday	1800	2230	66	\N	\N	\N	\N
451	2023-08-03 06:32:31.089239	2023-08-03 06:32:31.089239	Saturday	600	930	66	\N	\N	\N	\N
452	2023-08-03 06:32:31.090862	2023-08-03 06:32:31.090862	Saturday	1830	1900	66	\N	\N	\N	\N
453	2023-08-03 06:32:31.092419	2023-08-03 06:32:31.092419	Sunday	2200	200	66	\N	\N	\N	\N
454	2023-08-03 06:32:31.113525	2023-08-03 06:32:31.113525	Monday	900	1100	67	\N	\N	\N	\N
455	2023-08-03 06:32:31.114905	2023-08-03 06:32:31.114905	Monday	1430	2330	67	\N	\N	\N	\N
456	2023-08-03 06:32:31.116366	2023-08-03 06:32:31.116366	Tuesday	830	1800	67	\N	\N	\N	\N
457	2023-08-03 06:32:31.117824	2023-08-03 06:32:31.117824	Wednesday	745	1645	67	\N	\N	\N	\N
458	2023-08-03 06:32:31.119244	2023-08-03 06:32:31.119244	Wednesday	1700	2145	67	\N	\N	\N	\N
459	2023-08-03 06:32:31.120945	2023-08-03 06:32:31.120945	Thursday	815	1830	67	\N	\N	\N	\N
460	2023-08-03 06:32:31.122415	2023-08-03 06:32:31.122415	Friday	2030	330	67	\N	\N	\N	\N
461	2023-08-03 06:32:31.123867	2023-08-03 06:32:31.123867	Sunday	730	1430	67	\N	\N	\N	\N
462	2023-08-03 06:32:31.133861	2023-08-03 06:32:31.133861	Tuesday	645	1615	68	\N	\N	\N	\N
463	2023-08-03 06:32:31.135296	2023-08-03 06:32:31.135296	Wednesday	1030	1045	68	\N	\N	\N	\N
464	2023-08-03 06:32:31.136647	2023-08-03 06:32:31.136647	Wednesday	1415	1945	68	\N	\N	\N	\N
465	2023-08-03 06:32:31.1382	2023-08-03 06:32:31.1382	Thursday	600	745	68	\N	\N	\N	\N
466	2023-08-03 06:32:31.139634	2023-08-03 06:32:31.139634	Thursday	1600	1830	68	\N	\N	\N	\N
467	2023-08-03 06:32:31.141131	2023-08-03 06:32:31.141131	Friday	1415	230	68	\N	\N	\N	\N
468	2023-08-03 06:32:31.142715	2023-08-03 06:32:31.142715	Saturday	300	330	68	\N	\N	\N	\N
469	2023-08-03 06:32:31.144181	2023-08-03 06:32:31.144181	Saturday	1100	1315	68	\N	\N	\N	\N
470	2023-08-03 06:32:31.164496	2023-08-03 06:32:31.164496	Monday	715	1715	69	\N	\N	\N	\N
471	2023-08-03 06:32:31.165971	2023-08-03 06:32:31.165971	Wednesday	930	1400	69	\N	\N	\N	\N
472	2023-08-03 06:32:31.167459	2023-08-03 06:32:31.167459	Wednesday	1545	2300	69	\N	\N	\N	\N
473	2023-08-03 06:32:31.168923	2023-08-03 06:32:31.168923	Thursday	745	1015	69	\N	\N	\N	\N
474	2023-08-03 06:32:31.170402	2023-08-03 06:32:31.170402	Thursday	2230	645	69	\N	\N	\N	\N
475	2023-08-03 06:32:31.172403	2023-08-03 06:32:31.172403	Friday	2300	115	69	\N	\N	\N	\N
476	2023-08-03 06:32:31.173901	2023-08-03 06:32:31.173901	Saturday	730	2400	69	\N	\N	\N	\N
477	2023-08-03 06:32:31.175357	2023-08-03 06:32:31.175357	Sunday	845	1915	69	\N	\N	\N	\N
478	2023-08-03 06:32:31.184874	2023-08-03 06:32:31.184874	Monday	615	2215	70	\N	\N	\N	\N
479	2023-08-03 06:32:31.186616	2023-08-03 06:32:31.186616	Tuesday	1530	300	70	\N	\N	\N	\N
480	2023-08-03 06:32:31.188058	2023-08-03 06:32:31.188058	Thursday	530	930	70	\N	\N	\N	\N
481	2023-08-03 06:32:31.189416	2023-08-03 06:32:31.189416	Thursday	1130	2030	70	\N	\N	\N	\N
482	2023-08-03 06:32:31.190778	2023-08-03 06:32:31.190778	Friday	1000	1645	70	\N	\N	\N	\N
483	2023-08-03 06:32:31.192169	2023-08-03 06:32:31.192169	Saturday	215	1500	70	\N	\N	\N	\N
484	2023-08-03 06:32:31.193548	2023-08-03 06:32:31.193548	Saturday	1930	2130	70	\N	\N	\N	\N
485	2023-08-03 06:32:31.194987	2023-08-03 06:32:31.194987	Sunday	1230	1615	70	\N	\N	\N	\N
486	2023-08-03 06:32:31.196415	2023-08-03 06:32:31.196415	Sunday	1900	2300	70	\N	\N	\N	\N
487	2023-08-03 06:32:31.217291	2023-08-03 06:32:31.217291	Monday	1245	2045	71	\N	\N	\N	\N
488	2023-08-03 06:32:31.21875	2023-08-03 06:32:31.21875	Monday	2115	45	71	\N	\N	\N	\N
489	2023-08-03 06:32:31.220173	2023-08-03 06:32:31.220173	Tuesday	630	1400	71	\N	\N	\N	\N
490	2023-08-03 06:32:31.221578	2023-08-03 06:32:31.221578	Thursday	915	2230	71	\N	\N	\N	\N
491	2023-08-03 06:32:31.223024	2023-08-03 06:32:31.223024	Friday	630	1645	71	\N	\N	\N	\N
492	2023-08-03 06:32:31.224661	2023-08-03 06:32:31.224661	Saturday	600	2330	71	\N	\N	\N	\N
493	2023-08-03 06:32:31.226081	2023-08-03 06:32:31.226081	Sunday	930	1515	71	\N	\N	\N	\N
494	2023-08-03 06:32:31.236242	2023-08-03 06:32:31.236242	Monday	800	1930	72	\N	\N	\N	\N
495	2023-08-03 06:32:31.237868	2023-08-03 06:32:31.237868	Tuesday	600	1600	72	\N	\N	\N	\N
496	2023-08-03 06:32:31.239244	2023-08-03 06:32:31.239244	Thursday	1500	315	72	\N	\N	\N	\N
497	2023-08-03 06:32:31.240665	2023-08-03 06:32:31.240665	Friday	600	1945	72	\N	\N	\N	\N
498	2023-08-03 06:32:31.241986	2023-08-03 06:32:31.241986	Saturday	600	1630	72	\N	\N	\N	\N
499	2023-08-03 06:32:31.243377	2023-08-03 06:32:31.243377	Sunday	945	1930	72	\N	\N	\N	\N
500	2023-08-03 06:32:31.264428	2023-08-03 06:32:31.264428	Tuesday	900	1930	73	\N	\N	\N	\N
501	2023-08-03 06:32:31.265913	2023-08-03 06:32:31.265913	Wednesday	615	2200	73	\N	\N	\N	\N
502	2023-08-03 06:32:31.267341	2023-08-03 06:32:31.267341	Thursday	0	30	73	\N	\N	\N	\N
503	2023-08-03 06:32:31.268702	2023-08-03 06:32:31.268702	Thursday	1945	2330	73	\N	\N	\N	\N
504	2023-08-03 06:32:31.270123	2023-08-03 06:32:31.270123	Friday	830	1100	73	\N	\N	\N	\N
505	2023-08-03 06:32:31.271472	2023-08-03 06:32:31.271472	Friday	1615	1700	73	\N	\N	\N	\N
506	2023-08-03 06:32:31.272823	2023-08-03 06:32:31.272823	Saturday	1645	145	73	\N	\N	\N	\N
507	2023-08-03 06:32:31.274146	2023-08-03 06:32:31.274146	Sunday	2130	130	73	\N	\N	\N	\N
508	2023-08-03 06:32:31.284295	2023-08-03 06:32:31.284295	Monday	1045	1130	74	\N	\N	\N	\N
509	2023-08-03 06:32:31.285694	2023-08-03 06:32:31.285694	Monday	1930	845	74	\N	\N	\N	\N
510	2023-08-03 06:32:31.287142	2023-08-03 06:32:31.287142	Tuesday	2045	315	74	\N	\N	\N	\N
511	2023-08-03 06:32:31.288782	2023-08-03 06:32:31.288782	Friday	915	1500	74	\N	\N	\N	\N
512	2023-08-03 06:32:31.290194	2023-08-03 06:32:31.290194	Saturday	1515	215	74	\N	\N	\N	\N
513	2023-08-03 06:32:31.310975	2023-08-03 06:32:31.310975	Monday	945	1515	75	\N	\N	\N	\N
514	2023-08-03 06:32:31.312423	2023-08-03 06:32:31.312423	Tuesday	645	2115	75	\N	\N	\N	\N
515	2023-08-03 06:32:31.313854	2023-08-03 06:32:31.313854	Saturday	830	1730	75	\N	\N	\N	\N
516	2023-08-03 06:32:31.323786	2023-08-03 06:32:31.323786	Monday	1815	345	76	\N	\N	\N	\N
517	2023-08-03 06:32:31.325187	2023-08-03 06:32:31.325187	Tuesday	900	1145	76	\N	\N	\N	\N
518	2023-08-03 06:32:31.326551	2023-08-03 06:32:31.326551	Tuesday	2045	2230	76	\N	\N	\N	\N
519	2023-08-03 06:32:31.328167	2023-08-03 06:32:31.328167	Wednesday	615	2100	76	\N	\N	\N	\N
520	2023-08-03 06:32:31.329509	2023-08-03 06:32:31.329509	Friday	900	2230	76	\N	\N	\N	\N
521	2023-08-03 06:32:31.330924	2023-08-03 06:32:31.330924	Saturday	1615	2145	76	\N	\N	\N	\N
522	2023-08-03 06:32:31.332281	2023-08-03 06:32:31.332281	Saturday	2215	730	76	\N	\N	\N	\N
523	2023-08-03 06:32:31.33377	2023-08-03 06:32:31.33377	Sunday	830	1000	76	\N	\N	\N	\N
524	2023-08-03 06:32:31.335112	2023-08-03 06:32:31.335112	Sunday	1015	1700	76	\N	\N	\N	\N
525	2023-08-03 06:32:31.355676	2023-08-03 06:32:31.355676	Monday	815	1730	77	\N	\N	\N	\N
526	2023-08-03 06:32:31.357107	2023-08-03 06:32:31.357107	Tuesday	745	1915	77	\N	\N	\N	\N
527	2023-08-03 06:32:31.358566	2023-08-03 06:32:31.358566	Thursday	745	1745	77	\N	\N	\N	\N
528	2023-08-03 06:32:31.360054	2023-08-03 06:32:31.360054	Friday	645	1600	77	\N	\N	\N	\N
529	2023-08-03 06:32:31.361531	2023-08-03 06:32:31.361531	Friday	2245	545	77	\N	\N	\N	\N
530	2023-08-03 06:32:31.362998	2023-08-03 06:32:31.362998	Saturday	2045	145	77	\N	\N	\N	\N
531	2023-08-03 06:32:31.372656	2023-08-03 06:32:31.372656	Wednesday	915	2100	78	\N	\N	\N	\N
532	2023-08-03 06:32:31.374013	2023-08-03 06:32:31.374013	Thursday	915	1600	78	\N	\N	\N	\N
533	2023-08-03 06:32:31.375405	2023-08-03 06:32:31.375405	Friday	630	1545	78	\N	\N	\N	\N
534	2023-08-03 06:32:31.376862	2023-08-03 06:32:31.376862	Saturday	515	745	78	\N	\N	\N	\N
535	2023-08-03 06:32:31.378459	2023-08-03 06:32:31.378459	Saturday	2100	2200	78	\N	\N	\N	\N
536	2023-08-03 06:32:31.379868	2023-08-03 06:32:31.379868	Sunday	600	1900	78	\N	\N	\N	\N
537	2023-08-03 06:32:31.396238	2023-08-03 06:32:31.396238	Monday	315	415	79	\N	\N	\N	\N
538	2023-08-03 06:32:31.397608	2023-08-03 06:32:31.397608	Monday	1715	1900	79	\N	\N	\N	\N
539	2023-08-03 06:32:31.399049	2023-08-03 06:32:31.399049	Tuesday	530	1345	79	\N	\N	\N	\N
540	2023-08-03 06:32:31.400444	2023-08-03 06:32:31.400444	Tuesday	1700	2345	79	\N	\N	\N	\N
541	2023-08-03 06:32:31.401801	2023-08-03 06:32:31.401801	Wednesday	930	2230	79	\N	\N	\N	\N
542	2023-08-03 06:32:31.403344	2023-08-03 06:32:31.403344	Thursday	800	2245	79	\N	\N	\N	\N
543	2023-08-03 06:32:31.404826	2023-08-03 06:32:31.404826	Friday	2145	115	79	\N	\N	\N	\N
544	2023-08-03 06:32:31.406167	2023-08-03 06:32:31.406167	Saturday	700	1745	79	\N	\N	\N	\N
545	2023-08-03 06:32:31.407596	2023-08-03 06:32:31.407596	Sunday	645	1945	79	\N	\N	\N	\N
546	2023-08-03 06:32:31.427562	2023-08-03 06:32:31.427562	Monday	900	1830	80	\N	\N	\N	\N
547	2023-08-03 06:32:31.429011	2023-08-03 06:32:31.429011	Tuesday	930	2115	80	\N	\N	\N	\N
548	2023-08-03 06:32:31.430679	2023-08-03 06:32:31.430679	Thursday	15	345	80	\N	\N	\N	\N
549	2023-08-03 06:32:31.432066	2023-08-03 06:32:31.432066	Thursday	1415	2015	80	\N	\N	\N	\N
550	2023-08-03 06:32:31.433501	2023-08-03 06:32:31.433501	Friday	745	2330	80	\N	\N	\N	\N
551	2023-08-03 06:32:31.434943	2023-08-03 06:32:31.434943	Saturday	830	1115	80	\N	\N	\N	\N
552	2023-08-03 06:32:31.436433	2023-08-03 06:32:31.436433	Saturday	1345	1500	80	\N	\N	\N	\N
553	2023-08-03 06:32:31.437894	2023-08-03 06:32:31.437894	Sunday	745	1830	80	\N	\N	\N	\N
554	2023-08-03 06:32:31.447066	2023-08-03 06:32:31.447066	Monday	2045	245	81	\N	\N	\N	\N
555	2023-08-03 06:32:31.448453	2023-08-03 06:32:31.448453	Tuesday	745	1530	81	\N	\N	\N	\N
556	2023-08-03 06:32:31.449903	2023-08-03 06:32:31.449903	Thursday	830	1745	81	\N	\N	\N	\N
557	2023-08-03 06:32:31.451336	2023-08-03 06:32:31.451336	Friday	615	1445	81	\N	\N	\N	\N
558	2023-08-03 06:32:31.452738	2023-08-03 06:32:31.452738	Saturday	2015	100	81	\N	\N	\N	\N
559	2023-08-03 06:32:31.45432	2023-08-03 06:32:31.45432	Sunday	1000	2215	81	\N	\N	\N	\N
560	2023-08-03 06:32:31.47391	2023-08-03 06:32:31.47391	Monday	115	630	82	\N	\N	\N	\N
561	2023-08-03 06:32:31.475347	2023-08-03 06:32:31.475347	Monday	1545	2215	82	\N	\N	\N	\N
562	2023-08-03 06:32:31.476749	2023-08-03 06:32:31.476749	Tuesday	745	1600	82	\N	\N	\N	\N
563	2023-08-03 06:32:31.478115	2023-08-03 06:32:31.478115	Thursday	545	1715	82	\N	\N	\N	\N
564	2023-08-03 06:32:31.479962	2023-08-03 06:32:31.479962	Thursday	1800	2245	82	\N	\N	\N	\N
565	2023-08-03 06:32:31.481595	2023-08-03 06:32:31.481595	Friday	330	2100	82	\N	\N	\N	\N
566	2023-08-03 06:32:31.482966	2023-08-03 06:32:31.482966	Friday	2215	145	82	\N	\N	\N	\N
567	2023-08-03 06:32:31.484328	2023-08-03 06:32:31.484328	Saturday	630	1445	82	\N	\N	\N	\N
568	2023-08-03 06:32:31.492922	2023-08-03 06:32:31.492922	Monday	645	1815	83	\N	\N	\N	\N
569	2023-08-03 06:32:31.494264	2023-08-03 06:32:31.494264	Tuesday	600	2115	83	\N	\N	\N	\N
570	2023-08-03 06:32:31.495621	2023-08-03 06:32:31.495621	Wednesday	900	2045	83	\N	\N	\N	\N
571	2023-08-03 06:32:31.497074	2023-08-03 06:32:31.497074	Thursday	700	1830	83	\N	\N	\N	\N
572	2023-08-03 06:32:31.498498	2023-08-03 06:32:31.498498	Friday	830	1400	83	\N	\N	\N	\N
573	2023-08-03 06:32:31.499907	2023-08-03 06:32:31.499907	Saturday	930	1500	83	\N	\N	\N	\N
574	2023-08-03 06:32:31.501412	2023-08-03 06:32:31.501412	Sunday	1900	100	83	\N	\N	\N	\N
575	2023-08-03 06:32:31.52059	2023-08-03 06:32:31.52059	Monday	815	1800	84	\N	\N	\N	\N
576	2023-08-03 06:32:31.521989	2023-08-03 06:32:31.521989	Tuesday	800	1545	84	\N	\N	\N	\N
577	2023-08-03 06:32:31.523462	2023-08-03 06:32:31.523462	Wednesday	915	2300	84	\N	\N	\N	\N
578	2023-08-03 06:32:31.525068	2023-08-03 06:32:31.525068	Thursday	600	800	84	\N	\N	\N	\N
579	2023-08-03 06:32:31.526523	2023-08-03 06:32:31.526523	Thursday	1245	2230	84	\N	\N	\N	\N
580	2023-08-03 06:32:31.527965	2023-08-03 06:32:31.527965	Friday	415	645	84	\N	\N	\N	\N
581	2023-08-03 06:32:31.529644	2023-08-03 06:32:31.529644	Friday	815	2045	84	\N	\N	\N	\N
582	2023-08-03 06:32:31.531044	2023-08-03 06:32:31.531044	Saturday	645	1400	84	\N	\N	\N	\N
583	2023-08-03 06:32:31.532467	2023-08-03 06:32:31.532467	Sunday	2130	200	84	\N	\N	\N	\N
584	2023-08-03 06:32:31.54157	2023-08-03 06:32:31.54157	Monday	1515	200	85	\N	\N	\N	\N
585	2023-08-03 06:32:31.542951	2023-08-03 06:32:31.542951	Wednesday	600	2100	85	\N	\N	\N	\N
586	2023-08-03 06:32:31.544316	2023-08-03 06:32:31.544316	Friday	45	315	85	\N	\N	\N	\N
587	2023-08-03 06:32:31.545687	2023-08-03 06:32:31.545687	Friday	1815	15	85	\N	\N	\N	\N
588	2023-08-03 06:32:31.547142	2023-08-03 06:32:31.547142	Saturday	730	2315	85	\N	\N	\N	\N
589	2023-08-03 06:32:31.548578	2023-08-03 06:32:31.548578	Sunday	630	1430	85	\N	\N	\N	\N
590	2023-08-03 06:32:31.563442	2023-08-03 06:32:31.563442	Monday	900	2045	86	\N	\N	\N	\N
591	2023-08-03 06:32:31.564811	2023-08-03 06:32:31.564811	Tuesday	930	1700	86	\N	\N	\N	\N
592	2023-08-03 06:32:31.566388	2023-08-03 06:32:31.566388	Wednesday	630	1830	86	\N	\N	\N	\N
593	2023-08-03 06:32:31.567789	2023-08-03 06:32:31.567789	Thursday	2100	145	86	\N	\N	\N	\N
594	2023-08-03 06:32:31.569144	2023-08-03 06:32:31.569144	Saturday	830	1845	86	\N	\N	\N	\N
595	2023-08-03 06:32:31.570582	2023-08-03 06:32:31.570582	Sunday	915	1615	86	\N	\N	\N	\N
596	2023-08-03 06:32:31.590377	2023-08-03 06:32:31.590377	Monday	700	1900	87	\N	\N	\N	\N
597	2023-08-03 06:32:31.591956	2023-08-03 06:32:31.591956	Tuesday	745	845	87	\N	\N	\N	\N
598	2023-08-03 06:32:31.593356	2023-08-03 06:32:31.593356	Tuesday	1845	2215	87	\N	\N	\N	\N
599	2023-08-03 06:32:31.594799	2023-08-03 06:32:31.594799	Wednesday	945	1630	87	\N	\N	\N	\N
600	2023-08-03 06:32:31.596151	2023-08-03 06:32:31.596151	Wednesday	1830	2115	87	\N	\N	\N	\N
601	2023-08-03 06:32:31.59753	2023-08-03 06:32:31.59753	Thursday	800	1400	87	\N	\N	\N	\N
602	2023-08-03 06:32:31.598865	2023-08-03 06:32:31.598865	Friday	815	2030	87	\N	\N	\N	\N
603	2023-08-03 06:32:31.600186	2023-08-03 06:32:31.600186	Saturday	830	2145	87	\N	\N	\N	\N
604	2023-08-03 06:32:31.601706	2023-08-03 06:32:31.601706	Sunday	830	2330	87	\N	\N	\N	\N
605	2023-08-03 06:32:31.611364	2023-08-03 06:32:31.611364	Tuesday	945	1415	88	\N	\N	\N	\N
606	2023-08-03 06:32:31.612809	2023-08-03 06:32:31.612809	Wednesday	130	445	88	\N	\N	\N	\N
607	2023-08-03 06:32:31.614164	2023-08-03 06:32:31.614164	Wednesday	2200	2330	88	\N	\N	\N	\N
608	2023-08-03 06:32:31.61562	2023-08-03 06:32:31.61562	Thursday	900	1845	88	\N	\N	\N	\N
609	2023-08-03 06:32:31.617356	2023-08-03 06:32:31.617356	Friday	1600	345	88	\N	\N	\N	\N
610	2023-08-03 06:32:31.61874	2023-08-03 06:32:31.61874	Saturday	745	2215	88	\N	\N	\N	\N
611	2023-08-03 06:32:31.620126	2023-08-03 06:32:31.620126	Sunday	515	700	88	\N	\N	\N	\N
612	2023-08-03 06:32:31.621476	2023-08-03 06:32:31.621476	Sunday	1100	2400	88	\N	\N	\N	\N
613	2023-08-03 06:32:31.641328	2023-08-03 06:32:31.641328	Monday	915	1815	89	\N	\N	\N	\N
614	2023-08-03 06:32:31.643124	2023-08-03 06:32:31.643124	Tuesday	1715	145	89	\N	\N	\N	\N
615	2023-08-03 06:32:31.644553	2023-08-03 06:32:31.644553	Wednesday	315	645	89	\N	\N	\N	\N
616	2023-08-03 06:32:31.645903	2023-08-03 06:32:31.645903	Wednesday	1530	1845	89	\N	\N	\N	\N
617	2023-08-03 06:32:31.647222	2023-08-03 06:32:31.647222	Thursday	1000	2400	89	\N	\N	\N	\N
618	2023-08-03 06:32:31.64867	2023-08-03 06:32:31.64867	Friday	1415	1500	89	\N	\N	\N	\N
619	2023-08-03 06:32:31.650094	2023-08-03 06:32:31.650094	Friday	2230	1015	89	\N	\N	\N	\N
620	2023-08-03 06:32:31.651585	2023-08-03 06:32:31.651585	Saturday	700	2345	89	\N	\N	\N	\N
621	2023-08-03 06:32:31.661975	2023-08-03 06:32:31.661975	Monday	900	1430	90	\N	\N	\N	\N
622	2023-08-03 06:32:31.663418	2023-08-03 06:32:31.663418	Tuesday	615	1545	90	\N	\N	\N	\N
623	2023-08-03 06:32:31.66486	2023-08-03 06:32:31.66486	Wednesday	2045	230	90	\N	\N	\N	\N
624	2023-08-03 06:32:31.666452	2023-08-03 06:32:31.666452	Thursday	1915	330	90	\N	\N	\N	\N
625	2023-08-03 06:32:31.668197	2023-08-03 06:32:31.668197	Friday	345	930	90	\N	\N	\N	\N
626	2023-08-03 06:32:31.669629	2023-08-03 06:32:31.669629	Friday	1815	2400	90	\N	\N	\N	\N
627	2023-08-03 06:32:31.671127	2023-08-03 06:32:31.671127	Sunday	500	600	90	\N	\N	\N	\N
628	2023-08-03 06:32:31.672544	2023-08-03 06:32:31.672544	Sunday	700	2215	90	\N	\N	\N	\N
629	2023-08-03 06:32:31.692604	2023-08-03 06:32:31.692604	Monday	2130	245	91	\N	\N	\N	\N
630	2023-08-03 06:32:31.693995	2023-08-03 06:32:31.693995	Tuesday	1000	1945	91	\N	\N	\N	\N
631	2023-08-03 06:32:31.695505	2023-08-03 06:32:31.695505	Thursday	130	1030	91	\N	\N	\N	\N
632	2023-08-03 06:32:31.696934	2023-08-03 06:32:31.696934	Thursday	1630	2245	91	\N	\N	\N	\N
633	2023-08-03 06:32:31.698293	2023-08-03 06:32:31.698293	Friday	800	2115	91	\N	\N	\N	\N
634	2023-08-03 06:32:31.707792	2023-08-03 06:32:31.707792	Monday	600	1615	92	\N	\N	\N	\N
635	2023-08-03 06:32:31.709232	2023-08-03 06:32:31.709232	Tuesday	30	330	92	\N	\N	\N	\N
636	2023-08-03 06:32:31.710574	2023-08-03 06:32:31.710574	Tuesday	1800	2400	92	\N	\N	\N	\N
637	2023-08-03 06:32:31.711909	2023-08-03 06:32:31.711909	Wednesday	615	2100	92	\N	\N	\N	\N
638	2023-08-03 06:32:31.71325	2023-08-03 06:32:31.71325	Friday	2215	245	92	\N	\N	\N	\N
639	2023-08-03 06:32:31.714556	2023-08-03 06:32:31.714556	Saturday	1000	2000	92	\N	\N	\N	\N
640	2023-08-03 06:32:31.71606	2023-08-03 06:32:31.71606	Sunday	730	2315	92	\N	\N	\N	\N
641	2023-08-03 06:32:31.736558	2023-08-03 06:32:31.736558	Monday	230	1100	93	\N	\N	\N	\N
642	2023-08-03 06:32:31.73797	2023-08-03 06:32:31.73797	Monday	1145	1415	93	\N	\N	\N	\N
643	2023-08-03 06:32:31.739263	2023-08-03 06:32:31.739263	Tuesday	745	2300	93	\N	\N	\N	\N
644	2023-08-03 06:32:31.74066	2023-08-03 06:32:31.74066	Wednesday	745	2345	93	\N	\N	\N	\N
645	2023-08-03 06:32:31.742217	2023-08-03 06:32:31.742217	Thursday	1415	145	93	\N	\N	\N	\N
646	2023-08-03 06:32:31.743619	2023-08-03 06:32:31.743619	Friday	115	1015	93	\N	\N	\N	\N
647	2023-08-03 06:32:31.744962	2023-08-03 06:32:31.744962	Friday	1315	2130	93	\N	\N	\N	\N
648	2023-08-03 06:32:31.746295	2023-08-03 06:32:31.746295	Saturday	630	2100	93	\N	\N	\N	\N
649	2023-08-03 06:32:31.747694	2023-08-03 06:32:31.747694	Sunday	830	2230	93	\N	\N	\N	\N
650	2023-08-03 06:32:31.7577	2023-08-03 06:32:31.7577	Tuesday	900	1715	94	\N	\N	\N	\N
651	2023-08-03 06:32:31.75915	2023-08-03 06:32:31.75915	Wednesday	800	1415	94	\N	\N	\N	\N
652	2023-08-03 06:32:31.760534	2023-08-03 06:32:31.760534	Thursday	1100	1200	94	\N	\N	\N	\N
653	2023-08-03 06:32:31.761888	2023-08-03 06:32:31.761888	Thursday	1545	1815	94	\N	\N	\N	\N
654	2023-08-03 06:32:31.763453	2023-08-03 06:32:31.763453	Friday	915	2200	94	\N	\N	\N	\N
655	2023-08-03 06:32:31.76582	2023-08-03 06:32:31.76582	Saturday	745	2315	94	\N	\N	\N	\N
656	2023-08-03 06:32:31.767402	2023-08-03 06:32:31.767402	Sunday	645	2045	94	\N	\N	\N	\N
657	2023-08-03 06:32:31.768761	2023-08-03 06:32:31.768761	Sunday	2130	2145	94	\N	\N	\N	\N
658	2023-08-03 06:32:31.788279	2023-08-03 06:32:31.788279	Monday	1000	2100	95	\N	\N	\N	\N
659	2023-08-03 06:32:31.789708	2023-08-03 06:32:31.789708	Tuesday	845	1645	95	\N	\N	\N	\N
660	2023-08-03 06:32:31.791884	2023-08-03 06:32:31.791884	Wednesday	30	245	95	\N	\N	\N	\N
661	2023-08-03 06:32:31.793627	2023-08-03 06:32:31.793627	Wednesday	645	2130	95	\N	\N	\N	\N
662	2023-08-03 06:32:31.795029	2023-08-03 06:32:31.795029	Thursday	715	1530	95	\N	\N	\N	\N
663	2023-08-03 06:32:31.796388	2023-08-03 06:32:31.796388	Friday	800	1400	95	\N	\N	\N	\N
664	2023-08-03 06:32:31.797821	2023-08-03 06:32:31.797821	Saturday	930	1615	95	\N	\N	\N	\N
665	2023-08-03 06:32:31.799303	2023-08-03 06:32:31.799303	Sunday	900	1745	95	\N	\N	\N	\N
666	2023-08-03 06:32:31.80952	2023-08-03 06:32:31.80952	Monday	930	1615	96	\N	\N	\N	\N
667	2023-08-03 06:32:31.810924	2023-08-03 06:32:31.810924	Wednesday	745	2200	96	\N	\N	\N	\N
668	2023-08-03 06:32:31.812309	2023-08-03 06:32:31.812309	Thursday	845	2015	96	\N	\N	\N	\N
669	2023-08-03 06:32:31.813676	2023-08-03 06:32:31.813676	Friday	1000	1715	96	\N	\N	\N	\N
670	2023-08-03 06:32:31.815097	2023-08-03 06:32:31.815097	Saturday	415	1000	96	\N	\N	\N	\N
671	2023-08-03 06:32:31.816446	2023-08-03 06:32:31.816446	Saturday	1730	2245	96	\N	\N	\N	\N
672	2023-08-03 06:32:31.817896	2023-08-03 06:32:31.817896	Sunday	1630	200	96	\N	\N	\N	\N
673	2023-08-03 06:32:31.838221	2023-08-03 06:32:31.838221	Monday	2030	315	97	\N	\N	\N	\N
674	2023-08-03 06:32:31.839563	2023-08-03 06:32:31.839563	Tuesday	800	1800	97	\N	\N	\N	\N
675	2023-08-03 06:32:31.840925	2023-08-03 06:32:31.840925	Wednesday	245	430	97	\N	\N	\N	\N
676	2023-08-03 06:32:31.842327	2023-08-03 06:32:31.842327	Wednesday	715	930	97	\N	\N	\N	\N
677	2023-08-03 06:32:31.844095	2023-08-03 06:32:31.844095	Thursday	645	715	97	\N	\N	\N	\N
678	2023-08-03 06:32:31.845692	2023-08-03 06:32:31.845692	Thursday	1100	1830	97	\N	\N	\N	\N
679	2023-08-03 06:32:31.847178	2023-08-03 06:32:31.847178	Saturday	415	1530	97	\N	\N	\N	\N
680	2023-08-03 06:32:31.848636	2023-08-03 06:32:31.848636	Saturday	1630	2045	97	\N	\N	\N	\N
681	2023-08-03 06:32:31.85005	2023-08-03 06:32:31.85005	Sunday	730	2015	97	\N	\N	\N	\N
682	2023-08-03 06:32:31.860074	2023-08-03 06:32:31.860074	Monday	615	1745	98	\N	\N	\N	\N
683	2023-08-03 06:32:31.861545	2023-08-03 06:32:31.861545	Tuesday	1830	230	98	\N	\N	\N	\N
684	2023-08-03 06:32:31.862923	2023-08-03 06:32:31.862923	Wednesday	630	2130	98	\N	\N	\N	\N
685	2023-08-03 06:32:31.8644	2023-08-03 06:32:31.8644	Thursday	45	600	98	\N	\N	\N	\N
686	2023-08-03 06:32:31.865821	2023-08-03 06:32:31.865821	Thursday	745	1530	98	\N	\N	\N	\N
687	2023-08-03 06:32:31.867267	2023-08-03 06:32:31.867267	Saturday	730	1430	98	\N	\N	\N	\N
688	2023-08-03 06:32:31.868708	2023-08-03 06:32:31.868708	Sunday	1600	330	98	\N	\N	\N	\N
689	2023-08-03 06:32:31.889609	2023-08-03 06:32:31.889609	Tuesday	1000	1430	99	\N	\N	\N	\N
690	2023-08-03 06:32:31.891016	2023-08-03 06:32:31.891016	Thursday	845	1830	99	\N	\N	\N	\N
691	2023-08-03 06:32:31.892387	2023-08-03 06:32:31.892387	Friday	730	2000	99	\N	\N	\N	\N
692	2023-08-03 06:32:31.893822	2023-08-03 06:32:31.893822	Sunday	815	1430	99	\N	\N	\N	\N
693	2023-08-03 06:32:31.903797	2023-08-03 06:32:31.903797	Monday	630	2215	100	\N	\N	\N	\N
694	2023-08-03 06:32:31.905551	2023-08-03 06:32:31.905551	Tuesday	945	2100	100	\N	\N	\N	\N
695	2023-08-03 06:32:31.906973	2023-08-03 06:32:31.906973	Wednesday	1645	230	100	\N	\N	\N	\N
696	2023-08-03 06:32:31.90872	2023-08-03 06:32:31.90872	Thursday	745	1630	100	\N	\N	\N	\N
697	2023-08-03 06:32:31.910145	2023-08-03 06:32:31.910145	Friday	915	2045	100	\N	\N	\N	\N
698	2023-08-03 06:32:31.911575	2023-08-03 06:32:31.911575	Saturday	830	2300	100	\N	\N	\N	\N
699	2023-08-03 06:32:31.915137	2023-08-03 06:32:31.915137	Sunday	1015	1030	100	\N	\N	\N	\N
700	2023-08-03 06:32:31.916626	2023-08-03 06:32:31.916626	Sunday	1645	2015	100	\N	\N	\N	\N
701	2023-08-03 06:32:31.937885	2023-08-03 06:32:31.937885	Monday	615	1630	101	\N	\N	\N	\N
702	2023-08-03 06:32:31.939285	2023-08-03 06:32:31.939285	Tuesday	215	1230	101	\N	\N	\N	\N
703	2023-08-03 06:32:31.940656	2023-08-03 06:32:31.940656	Tuesday	1915	2130	101	\N	\N	\N	\N
704	2023-08-03 06:32:31.942036	2023-08-03 06:32:31.942036	Wednesday	1000	1945	101	\N	\N	\N	\N
705	2023-08-03 06:32:31.943358	2023-08-03 06:32:31.943358	Thursday	630	1600	101	\N	\N	\N	\N
706	2023-08-03 06:32:31.944738	2023-08-03 06:32:31.944738	Sunday	715	1945	101	\N	\N	\N	\N
707	2023-08-03 06:32:31.955052	2023-08-03 06:32:31.955052	Tuesday	45	700	102	\N	\N	\N	\N
708	2023-08-03 06:32:31.956433	2023-08-03 06:32:31.956433	Tuesday	1115	0	102	\N	\N	\N	\N
709	2023-08-03 06:32:31.958101	2023-08-03 06:32:31.958101	Wednesday	630	2315	102	\N	\N	\N	\N
710	2023-08-03 06:32:31.959588	2023-08-03 06:32:31.959588	Thursday	1815	300	102	\N	\N	\N	\N
711	2023-08-03 06:32:31.961019	2023-08-03 06:32:31.961019	Friday	845	2145	102	\N	\N	\N	\N
712	2023-08-03 06:32:31.962677	2023-08-03 06:32:31.962677	Saturday	2030	400	102	\N	\N	\N	\N
713	2023-08-03 06:32:31.964055	2023-08-03 06:32:31.964055	Sunday	830	1800	102	\N	\N	\N	\N
714	2023-08-03 06:32:31.980777	2023-08-03 06:32:31.980777	Monday	1400	245	103	\N	\N	\N	\N
715	2023-08-03 06:32:31.982205	2023-08-03 06:32:31.982205	Tuesday	600	1815	103	\N	\N	\N	\N
716	2023-08-03 06:32:31.983648	2023-08-03 06:32:31.983648	Thursday	100	415	103	\N	\N	\N	\N
717	2023-08-03 06:32:31.985029	2023-08-03 06:32:31.985029	Thursday	700	1000	103	\N	\N	\N	\N
718	2023-08-03 06:32:31.98651	2023-08-03 06:32:31.98651	Friday	745	1015	103	\N	\N	\N	\N
719	2023-08-03 06:32:31.988163	2023-08-03 06:32:31.988163	Friday	1100	1715	103	\N	\N	\N	\N
720	2023-08-03 06:32:31.989479	2023-08-03 06:32:31.989479	Saturday	630	2030	103	\N	\N	\N	\N
721	2023-08-03 06:32:31.990872	2023-08-03 06:32:31.990872	Sunday	145	1330	103	\N	\N	\N	\N
722	2023-08-03 06:32:31.992191	2023-08-03 06:32:31.992191	Sunday	1515	2200	103	\N	\N	\N	\N
723	2023-08-03 06:32:32.01127	2023-08-03 06:32:32.01127	Monday	600	2130	104	\N	\N	\N	\N
724	2023-08-03 06:32:32.013005	2023-08-03 06:32:32.013005	Thursday	730	1430	104	\N	\N	\N	\N
725	2023-08-03 06:32:32.014355	2023-08-03 06:32:32.014355	Friday	1000	1700	104	\N	\N	\N	\N
726	2023-08-03 06:32:32.015725	2023-08-03 06:32:32.015725	Sunday	730	1900	104	\N	\N	\N	\N
727	2023-08-03 06:32:32.024138	2023-08-03 06:32:32.024138	Monday	630	2200	105	\N	\N	\N	\N
728	2023-08-03 06:32:32.025775	2023-08-03 06:32:32.025775	Tuesday	800	1545	105	\N	\N	\N	\N
729	2023-08-03 06:32:32.027187	2023-08-03 06:32:32.027187	Wednesday	200	515	105	\N	\N	\N	\N
730	2023-08-03 06:32:32.02847	2023-08-03 06:32:32.02847	Wednesday	1400	2215	105	\N	\N	\N	\N
731	2023-08-03 06:32:32.030103	2023-08-03 06:32:32.030103	Friday	245	1045	105	\N	\N	\N	\N
732	2023-08-03 06:32:32.031477	2023-08-03 06:32:32.031477	Friday	1300	2200	105	\N	\N	\N	\N
733	2023-08-03 06:32:32.032905	2023-08-03 06:32:32.032905	Sunday	1000	1930	105	\N	\N	\N	\N
734	2023-08-03 06:32:32.034322	2023-08-03 06:32:32.034322	Sunday	2330	645	105	\N	\N	\N	\N
735	2023-08-03 06:32:32.053146	2023-08-03 06:32:32.053146	Monday	130	145	106	\N	\N	\N	\N
736	2023-08-03 06:32:32.054577	2023-08-03 06:32:32.054577	Monday	1415	2000	106	\N	\N	\N	\N
737	2023-08-03 06:32:32.055967	2023-08-03 06:32:32.055967	Tuesday	445	715	106	\N	\N	\N	\N
738	2023-08-03 06:32:32.057331	2023-08-03 06:32:32.057331	Tuesday	2045	2200	106	\N	\N	\N	\N
739	2023-08-03 06:32:32.058756	2023-08-03 06:32:32.058756	Wednesday	930	2215	106	\N	\N	\N	\N
740	2023-08-03 06:32:32.06025	2023-08-03 06:32:32.06025	Thursday	730	1900	106	\N	\N	\N	\N
741	2023-08-03 06:32:32.061946	2023-08-03 06:32:32.061946	Friday	715	1500	106	\N	\N	\N	\N
742	2023-08-03 06:32:32.063325	2023-08-03 06:32:32.063325	Saturday	915	2145	106	\N	\N	\N	\N
743	2023-08-03 06:32:32.064675	2023-08-03 06:32:32.064675	Sunday	615	1530	106	\N	\N	\N	\N
744	2023-08-03 06:32:32.073024	2023-08-03 06:32:32.073024	Monday	730	1600	107	\N	\N	\N	\N
745	2023-08-03 06:32:32.074614	2023-08-03 06:32:32.074614	Tuesday	745	1400	107	\N	\N	\N	\N
746	2023-08-03 06:32:32.075888	2023-08-03 06:32:32.075888	Wednesday	1000	1430	107	\N	\N	\N	\N
747	2023-08-03 06:32:32.077169	2023-08-03 06:32:32.077169	Thursday	930	1915	107	\N	\N	\N	\N
748	2023-08-03 06:32:32.078518	2023-08-03 06:32:32.078518	Friday	615	1600	107	\N	\N	\N	\N
749	2023-08-03 06:32:32.07993	2023-08-03 06:32:32.07993	Saturday	15	45	107	\N	\N	\N	\N
750	2023-08-03 06:32:32.081219	2023-08-03 06:32:32.081219	Saturday	615	2100	107	\N	\N	\N	\N
751	2023-08-03 06:32:32.082586	2023-08-03 06:32:32.082586	Sunday	830	1815	107	\N	\N	\N	\N
752	2023-08-03 06:32:32.103626	2023-08-03 06:32:32.103626	Monday	600	1600	108	\N	\N	\N	\N
753	2023-08-03 06:32:32.105005	2023-08-03 06:32:32.105005	Wednesday	745	1745	108	\N	\N	\N	\N
754	2023-08-03 06:32:32.106384	2023-08-03 06:32:32.106384	Thursday	1600	245	108	\N	\N	\N	\N
755	2023-08-03 06:32:32.107757	2023-08-03 06:32:32.107757	Friday	615	1845	108	\N	\N	\N	\N
756	2023-08-03 06:32:32.10914	2023-08-03 06:32:32.10914	Sunday	2145	215	108	\N	\N	\N	\N
757	2023-08-03 06:32:32.119817	2023-08-03 06:32:32.119817	Tuesday	945	1045	109	\N	\N	\N	\N
758	2023-08-03 06:32:32.121201	2023-08-03 06:32:32.121201	Tuesday	2400	815	109	\N	\N	\N	\N
759	2023-08-03 06:32:32.122642	2023-08-03 06:32:32.122642	Wednesday	245	1115	109	\N	\N	\N	\N
760	2023-08-03 06:32:32.124161	2023-08-03 06:32:32.124161	Wednesday	1445	1945	109	\N	\N	\N	\N
761	2023-08-03 06:32:32.12557	2023-08-03 06:32:32.12557	Thursday	830	1445	109	\N	\N	\N	\N
762	2023-08-03 06:32:32.126957	2023-08-03 06:32:32.126957	Friday	815	2200	109	\N	\N	\N	\N
763	2023-08-03 06:32:32.128323	2023-08-03 06:32:32.128323	Saturday	2245	100	109	\N	\N	\N	\N
764	2023-08-03 06:32:32.129732	2023-08-03 06:32:32.129732	Sunday	600	2315	109	\N	\N	\N	\N
765	2023-08-03 06:32:32.146699	2023-08-03 06:32:32.146699	Monday	845	2115	110	\N	\N	\N	\N
766	2023-08-03 06:32:32.148065	2023-08-03 06:32:32.148065	Wednesday	630	1930	110	\N	\N	\N	\N
767	2023-08-03 06:32:32.149432	2023-08-03 06:32:32.149432	Thursday	2230	200	110	\N	\N	\N	\N
768	2023-08-03 06:32:32.170138	2023-08-03 06:32:32.170138	Monday	330	445	111	\N	\N	\N	\N
769	2023-08-03 06:32:32.171553	2023-08-03 06:32:32.171553	Monday	1030	1900	111	\N	\N	\N	\N
770	2023-08-03 06:32:32.172919	2023-08-03 06:32:32.172919	Tuesday	715	1830	111	\N	\N	\N	\N
771	2023-08-03 06:32:32.174356	2023-08-03 06:32:32.174356	Wednesday	630	1800	111	\N	\N	\N	\N
772	2023-08-03 06:32:32.175918	2023-08-03 06:32:32.175918	Thursday	745	2230	111	\N	\N	\N	\N
773	2023-08-03 06:32:32.177261	2023-08-03 06:32:32.177261	Friday	915	1900	111	\N	\N	\N	\N
774	2023-08-03 06:32:32.178638	2023-08-03 06:32:32.178638	Sunday	945	1530	111	\N	\N	\N	\N
775	2023-08-03 06:32:32.188292	2023-08-03 06:32:32.188292	Monday	745	1745	112	\N	\N	\N	\N
776	2023-08-03 06:32:32.189682	2023-08-03 06:32:32.189682	Tuesday	2045	145	112	\N	\N	\N	\N
777	2023-08-03 06:32:32.191125	2023-08-03 06:32:32.191125	Wednesday	45	645	112	\N	\N	\N	\N
778	2023-08-03 06:32:32.192518	2023-08-03 06:32:32.192518	Wednesday	1145	2245	112	\N	\N	\N	\N
779	2023-08-03 06:32:32.193889	2023-08-03 06:32:32.193889	Thursday	845	2215	112	\N	\N	\N	\N
780	2023-08-03 06:32:32.195243	2023-08-03 06:32:32.195243	Saturday	645	1415	112	\N	\N	\N	\N
781	2023-08-03 06:32:32.19665	2023-08-03 06:32:32.19665	Sunday	700	2015	112	\N	\N	\N	\N
782	2023-08-03 06:32:32.216903	2023-08-03 06:32:32.216903	Monday	545	1345	113	\N	\N	\N	\N
783	2023-08-03 06:32:32.218402	2023-08-03 06:32:32.218402	Monday	1630	2315	113	\N	\N	\N	\N
784	2023-08-03 06:32:32.219764	2023-08-03 06:32:32.219764	Tuesday	715	1415	113	\N	\N	\N	\N
785	2023-08-03 06:32:32.221196	2023-08-03 06:32:32.221196	Wednesday	615	1815	113	\N	\N	\N	\N
786	2023-08-03 06:32:32.222614	2023-08-03 06:32:32.222614	Thursday	630	1830	113	\N	\N	\N	\N
787	2023-08-03 06:32:32.223989	2023-08-03 06:32:32.223989	Friday	2015	230	113	\N	\N	\N	\N
788	2023-08-03 06:32:32.225596	2023-08-03 06:32:32.225596	Saturday	715	1945	113	\N	\N	\N	\N
789	2023-08-03 06:32:32.235297	2023-08-03 06:32:32.235297	Monday	915	1645	114	\N	\N	\N	\N
790	2023-08-03 06:32:32.236896	2023-08-03 06:32:32.236896	Tuesday	645	1600	114	\N	\N	\N	\N
791	2023-08-03 06:32:32.238291	2023-08-03 06:32:32.238291	Wednesday	900	2045	114	\N	\N	\N	\N
792	2023-08-03 06:32:32.239744	2023-08-03 06:32:32.239744	Friday	815	2030	114	\N	\N	\N	\N
793	2023-08-03 06:32:32.241301	2023-08-03 06:32:32.241301	Saturday	745	2245	114	\N	\N	\N	\N
794	2023-08-03 06:32:32.257692	2023-08-03 06:32:32.257692	Monday	815	1900	115	\N	\N	\N	\N
795	2023-08-03 06:32:32.259124	2023-08-03 06:32:32.259124	Tuesday	730	2030	115	\N	\N	\N	\N
796	2023-08-03 06:32:32.260557	2023-08-03 06:32:32.260557	Wednesday	215	1530	115	\N	\N	\N	\N
797	2023-08-03 06:32:32.261919	2023-08-03 06:32:32.261919	Wednesday	1815	1845	115	\N	\N	\N	\N
798	2023-08-03 06:32:32.263784	2023-08-03 06:32:32.263784	Thursday	300	930	115	\N	\N	\N	\N
799	2023-08-03 06:32:32.265133	2023-08-03 06:32:32.265133	Thursday	945	2145	115	\N	\N	\N	\N
800	2023-08-03 06:32:32.266561	2023-08-03 06:32:32.266561	Friday	1700	330	115	\N	\N	\N	\N
801	2023-08-03 06:32:32.26797	2023-08-03 06:32:32.26797	Saturday	645	1830	115	\N	\N	\N	\N
802	2023-08-03 06:32:32.269426	2023-08-03 06:32:32.269426	Sunday	630	2130	115	\N	\N	\N	\N
803	2023-08-03 06:32:32.289948	2023-08-03 06:32:32.289948	Wednesday	630	1645	116	\N	\N	\N	\N
804	2023-08-03 06:32:32.291421	2023-08-03 06:32:32.291421	Friday	1100	1700	116	\N	\N	\N	\N
805	2023-08-03 06:32:32.292731	2023-08-03 06:32:32.292731	Friday	1815	1845	116	\N	\N	\N	\N
806	2023-08-03 06:32:32.294256	2023-08-03 06:32:32.294256	Saturday	1445	145	116	\N	\N	\N	\N
807	2023-08-03 06:32:32.295718	2023-08-03 06:32:32.295718	Sunday	745	1615	116	\N	\N	\N	\N
808	2023-08-03 06:32:32.297086	2023-08-03 06:32:32.297086	Sunday	1645	345	116	\N	\N	\N	\N
809	2023-08-03 06:32:32.30714	2023-08-03 06:32:32.30714	Monday	830	2130	117	\N	\N	\N	\N
810	2023-08-03 06:32:32.308532	2023-08-03 06:32:32.308532	Tuesday	630	2330	117	\N	\N	\N	\N
811	2023-08-03 06:32:32.309902	2023-08-03 06:32:32.309902	Wednesday	600	1730	117	\N	\N	\N	\N
812	2023-08-03 06:32:32.311249	2023-08-03 06:32:32.311249	Thursday	900	1615	117	\N	\N	\N	\N
813	2023-08-03 06:32:32.312624	2023-08-03 06:32:32.312624	Saturday	1700	400	117	\N	\N	\N	\N
814	2023-08-03 06:32:32.314216	2023-08-03 06:32:32.314216	Sunday	815	1845	117	\N	\N	\N	\N
815	2023-08-03 06:32:32.334833	2023-08-03 06:32:32.334833	Monday	2200	400	118	\N	\N	\N	\N
816	2023-08-03 06:32:32.336209	2023-08-03 06:32:32.336209	Tuesday	115	345	118	\N	\N	\N	\N
817	2023-08-03 06:32:32.337582	2023-08-03 06:32:32.337582	Tuesday	615	2100	118	\N	\N	\N	\N
818	2023-08-03 06:32:32.338926	2023-08-03 06:32:32.338926	Wednesday	715	1445	118	\N	\N	\N	\N
819	2023-08-03 06:32:32.340499	2023-08-03 06:32:32.340499	Thursday	915	1545	118	\N	\N	\N	\N
820	2023-08-03 06:32:32.341874	2023-08-03 06:32:32.341874	Friday	930	2030	118	\N	\N	\N	\N
821	2023-08-03 06:32:32.343272	2023-08-03 06:32:32.343272	Saturday	945	1915	118	\N	\N	\N	\N
822	2023-08-03 06:32:32.344645	2023-08-03 06:32:32.344645	Sunday	730	1600	118	\N	\N	\N	\N
823	2023-08-03 06:32:32.354497	2023-08-03 06:32:32.354497	Monday	1930	215	119	\N	\N	\N	\N
824	2023-08-03 06:32:32.356012	2023-08-03 06:32:32.356012	Tuesday	600	1615	119	\N	\N	\N	\N
825	2023-08-03 06:32:32.357372	2023-08-03 06:32:32.357372	Wednesday	615	1815	119	\N	\N	\N	\N
826	2023-08-03 06:32:32.358776	2023-08-03 06:32:32.358776	Thursday	715	1615	119	\N	\N	\N	\N
827	2023-08-03 06:32:32.360119	2023-08-03 06:32:32.360119	Thursday	2045	2300	119	\N	\N	\N	\N
828	2023-08-03 06:32:32.361549	2023-08-03 06:32:32.361549	Friday	630	1615	119	\N	\N	\N	\N
829	2023-08-03 06:32:32.362897	2023-08-03 06:32:32.362897	Saturday	2115	330	119	\N	\N	\N	\N
830	2023-08-03 06:32:32.384014	2023-08-03 06:32:32.384014	Monday	700	1630	120	\N	\N	\N	\N
831	2023-08-03 06:32:32.385396	2023-08-03 06:32:32.385396	Tuesday	830	1645	120	\N	\N	\N	\N
832	2023-08-03 06:32:32.38698	2023-08-03 06:32:32.38698	Wednesday	615	1530	120	\N	\N	\N	\N
833	2023-08-03 06:32:32.388339	2023-08-03 06:32:32.388339	Thursday	1815	300	120	\N	\N	\N	\N
834	2023-08-03 06:32:32.38992	2023-08-03 06:32:32.38992	Friday	800	1130	120	\N	\N	\N	\N
835	2023-08-03 06:32:32.391198	2023-08-03 06:32:32.391198	Friday	2230	500	120	\N	\N	\N	\N
836	2023-08-03 06:32:32.392592	2023-08-03 06:32:32.392592	Saturday	1630	1700	120	\N	\N	\N	\N
837	2023-08-03 06:32:32.39393	2023-08-03 06:32:32.39393	Saturday	2130	1200	120	\N	\N	\N	\N
838	2023-08-03 06:32:32.395383	2023-08-03 06:32:32.395383	Sunday	915	1215	120	\N	\N	\N	\N
839	2023-08-03 06:32:32.396759	2023-08-03 06:32:32.396759	Sunday	1315	1730	120	\N	\N	\N	\N
840	2023-08-03 06:32:32.407173	2023-08-03 06:32:32.407173	Monday	900	1530	121	\N	\N	\N	\N
841	2023-08-03 06:32:32.408682	2023-08-03 06:32:32.408682	Wednesday	600	1715	121	\N	\N	\N	\N
842	2023-08-03 06:32:32.410153	2023-08-03 06:32:32.410153	Friday	615	1700	121	\N	\N	\N	\N
843	2023-08-03 06:32:32.411479	2023-08-03 06:32:32.411479	Saturday	915	1745	121	\N	\N	\N	\N
844	2023-08-03 06:32:32.412971	2023-08-03 06:32:32.412971	Sunday	530	945	121	\N	\N	\N	\N
845	2023-08-03 06:32:32.414527	2023-08-03 06:32:32.414527	Sunday	1130	330	121	\N	\N	\N	\N
846	2023-08-03 06:32:32.434773	2023-08-03 06:32:32.434773	Monday	2000	215	122	\N	\N	\N	\N
847	2023-08-03 06:32:32.436164	2023-08-03 06:32:32.436164	Tuesday	115	215	122	\N	\N	\N	\N
848	2023-08-03 06:32:32.437548	2023-08-03 06:32:32.437548	Tuesday	1245	1500	122	\N	\N	\N	\N
849	2023-08-03 06:32:32.43898	2023-08-03 06:32:32.43898	Wednesday	815	1230	122	\N	\N	\N	\N
850	2023-08-03 06:32:32.440556	2023-08-03 06:32:32.440556	Wednesday	1445	1530	122	\N	\N	\N	\N
851	2023-08-03 06:32:32.442094	2023-08-03 06:32:32.442094	Thursday	700	2215	122	\N	\N	\N	\N
852	2023-08-03 06:32:32.44347	2023-08-03 06:32:32.44347	Saturday	915	1745	122	\N	\N	\N	\N
853	2023-08-03 06:32:32.444963	2023-08-03 06:32:32.444963	Sunday	745	1445	122	\N	\N	\N	\N
854	2023-08-03 06:32:32.446463	2023-08-03 06:32:32.446463	Sunday	2045	345	122	\N	\N	\N	\N
855	2023-08-03 06:32:32.456948	2023-08-03 06:32:32.456948	Monday	730	2115	123	\N	\N	\N	\N
856	2023-08-03 06:32:32.458403	2023-08-03 06:32:32.458403	Tuesday	0	1630	123	\N	\N	\N	\N
857	2023-08-03 06:32:32.459749	2023-08-03 06:32:32.459749	Tuesday	1945	2015	123	\N	\N	\N	\N
858	2023-08-03 06:32:32.461109	2023-08-03 06:32:32.461109	Wednesday	700	2145	123	\N	\N	\N	\N
859	2023-08-03 06:32:32.462449	2023-08-03 06:32:32.462449	Thursday	715	2015	123	\N	\N	\N	\N
860	2023-08-03 06:32:32.463771	2023-08-03 06:32:32.463771	Friday	945	1800	123	\N	\N	\N	\N
861	2023-08-03 06:32:32.465351	2023-08-03 06:32:32.465351	Saturday	1315	1415	123	\N	\N	\N	\N
862	2023-08-03 06:32:32.466727	2023-08-03 06:32:32.466727	Saturday	1515	2300	123	\N	\N	\N	\N
863	2023-08-03 06:32:32.468172	2023-08-03 06:32:32.468172	Sunday	730	1830	123	\N	\N	\N	\N
864	2023-08-03 06:32:32.484745	2023-08-03 06:32:32.484745	Monday	1815	200	124	\N	\N	\N	\N
865	2023-08-03 06:32:32.48613	2023-08-03 06:32:32.48613	Tuesday	1000	1845	124	\N	\N	\N	\N
866	2023-08-03 06:32:32.487578	2023-08-03 06:32:32.487578	Wednesday	830	1645	124	\N	\N	\N	\N
867	2023-08-03 06:32:32.488994	2023-08-03 06:32:32.488994	Thursday	1200	1945	124	\N	\N	\N	\N
868	2023-08-03 06:32:32.490497	2023-08-03 06:32:32.490497	Thursday	2130	30	124	\N	\N	\N	\N
869	2023-08-03 06:32:32.491919	2023-08-03 06:32:32.491919	Friday	700	2145	124	\N	\N	\N	\N
870	2023-08-03 06:32:32.512263	2023-08-03 06:32:32.512263	Monday	745	1530	125	\N	\N	\N	\N
871	2023-08-03 06:32:32.513649	2023-08-03 06:32:32.513649	Wednesday	115	645	125	\N	\N	\N	\N
872	2023-08-03 06:32:32.514981	2023-08-03 06:32:32.514981	Wednesday	1515	1830	125	\N	\N	\N	\N
873	2023-08-03 06:32:32.516655	2023-08-03 06:32:32.516655	Thursday	330	1200	125	\N	\N	\N	\N
874	2023-08-03 06:32:32.51802	2023-08-03 06:32:32.51802	Thursday	1415	2330	125	\N	\N	\N	\N
875	2023-08-03 06:32:32.519516	2023-08-03 06:32:32.519516	Saturday	630	2400	125	\N	\N	\N	\N
876	2023-08-03 06:32:32.52085	2023-08-03 06:32:32.52085	Sunday	1000	2400	125	\N	\N	\N	\N
877	2023-08-03 06:32:32.530789	2023-08-03 06:32:32.530789	Tuesday	530	1015	126	\N	\N	\N	\N
878	2023-08-03 06:32:32.53221	2023-08-03 06:32:32.53221	Tuesday	2100	330	126	\N	\N	\N	\N
879	2023-08-03 06:32:32.533658	2023-08-03 06:32:32.533658	Thursday	615	1430	126	\N	\N	\N	\N
880	2023-08-03 06:32:32.535027	2023-08-03 06:32:32.535027	Friday	845	1645	126	\N	\N	\N	\N
881	2023-08-03 06:32:32.536505	2023-08-03 06:32:32.536505	Sunday	315	945	126	\N	\N	\N	\N
882	2023-08-03 06:32:32.537969	2023-08-03 06:32:32.537969	Sunday	1430	2215	126	\N	\N	\N	\N
883	2023-08-03 06:32:32.554813	2023-08-03 06:32:32.554813	Monday	730	2145	127	\N	\N	\N	\N
884	2023-08-03 06:32:32.556426	2023-08-03 06:32:32.556426	Wednesday	1530	1545	127	\N	\N	\N	\N
885	2023-08-03 06:32:32.557767	2023-08-03 06:32:32.557767	Wednesday	1700	2215	127	\N	\N	\N	\N
886	2023-08-03 06:32:32.559124	2023-08-03 06:32:32.559124	Thursday	630	2015	127	\N	\N	\N	\N
887	2023-08-03 06:32:32.560513	2023-08-03 06:32:32.560513	Friday	245	1800	127	\N	\N	\N	\N
888	2023-08-03 06:32:32.561839	2023-08-03 06:32:32.561839	Friday	2315	45	127	\N	\N	\N	\N
889	2023-08-03 06:32:32.563134	2023-08-03 06:32:32.563134	Saturday	930	1500	127	\N	\N	\N	\N
890	2023-08-03 06:32:32.564522	2023-08-03 06:32:32.564522	Sunday	930	1815	127	\N	\N	\N	\N
891	2023-08-03 06:32:32.584635	2023-08-03 06:32:32.584635	Monday	800	2045	128	\N	\N	\N	\N
892	2023-08-03 06:32:32.585994	2023-08-03 06:32:32.585994	Tuesday	830	1545	128	\N	\N	\N	\N
893	2023-08-03 06:32:32.587385	2023-08-03 06:32:32.587385	Wednesday	245	1130	128	\N	\N	\N	\N
894	2023-08-03 06:32:32.588673	2023-08-03 06:32:32.588673	Wednesday	1430	1530	128	\N	\N	\N	\N
895	2023-08-03 06:32:32.59005	2023-08-03 06:32:32.59005	Friday	600	1500	128	\N	\N	\N	\N
896	2023-08-03 06:32:32.591388	2023-08-03 06:32:32.591388	Saturday	830	1515	128	\N	\N	\N	\N
897	2023-08-03 06:32:32.592909	2023-08-03 06:32:32.592909	Sunday	1445	230	128	\N	\N	\N	\N
898	2023-08-03 06:32:32.601687	2023-08-03 06:32:32.601687	Monday	645	1830	129	\N	\N	\N	\N
899	2023-08-03 06:32:32.603048	2023-08-03 06:32:32.603048	Wednesday	615	1645	129	\N	\N	\N	\N
900	2023-08-03 06:32:32.604611	2023-08-03 06:32:32.604611	Thursday	700	715	129	\N	\N	\N	\N
901	2023-08-03 06:32:32.605908	2023-08-03 06:32:32.605908	Thursday	1945	630	129	\N	\N	\N	\N
902	2023-08-03 06:32:32.607225	2023-08-03 06:32:32.607225	Friday	730	1515	129	\N	\N	\N	\N
903	2023-08-03 06:32:32.60863	2023-08-03 06:32:32.60863	Saturday	745	1730	129	\N	\N	\N	\N
904	2023-08-03 06:32:32.610034	2023-08-03 06:32:32.610034	Sunday	2115	245	129	\N	\N	\N	\N
905	2023-08-03 06:32:32.625737	2023-08-03 06:32:32.625737	Monday	1445	245	130	\N	\N	\N	\N
906	2023-08-03 06:32:32.627211	2023-08-03 06:32:32.627211	Tuesday	1845	315	130	\N	\N	\N	\N
907	2023-08-03 06:32:32.628605	2023-08-03 06:32:32.628605	Wednesday	915	2145	130	\N	\N	\N	\N
908	2023-08-03 06:32:32.630552	2023-08-03 06:32:32.630552	Thursday	130	945	130	\N	\N	\N	\N
909	2023-08-03 06:32:32.631908	2023-08-03 06:32:32.631908	Thursday	1600	1715	130	\N	\N	\N	\N
910	2023-08-03 06:32:32.633239	2023-08-03 06:32:32.633239	Friday	615	1645	130	\N	\N	\N	\N
911	2023-08-03 06:32:32.634644	2023-08-03 06:32:32.634644	Sunday	1945	145	130	\N	\N	\N	\N
912	2023-08-03 06:32:32.65477	2023-08-03 06:32:32.65477	Monday	815	2200	131	\N	\N	\N	\N
913	2023-08-03 06:32:32.656141	2023-08-03 06:32:32.656141	Tuesday	615	1545	131	\N	\N	\N	\N
914	2023-08-03 06:32:32.657551	2023-08-03 06:32:32.657551	Wednesday	615	1300	131	\N	\N	\N	\N
915	2023-08-03 06:32:32.658914	2023-08-03 06:32:32.658914	Wednesday	2100	2115	131	\N	\N	\N	\N
916	2023-08-03 06:32:32.66027	2023-08-03 06:32:32.66027	Thursday	345	2030	131	\N	\N	\N	\N
917	2023-08-03 06:32:32.661595	2023-08-03 06:32:32.661595	Thursday	2200	245	131	\N	\N	\N	\N
918	2023-08-03 06:32:32.66294	2023-08-03 06:32:32.66294	Friday	615	2230	131	\N	\N	\N	\N
919	2023-08-03 06:32:32.664253	2023-08-03 06:32:32.664253	Sunday	945	1630	131	\N	\N	\N	\N
920	2023-08-03 06:32:32.673861	2023-08-03 06:32:32.673861	Monday	815	1400	132	\N	\N	\N	\N
921	2023-08-03 06:32:32.675261	2023-08-03 06:32:32.675261	Tuesday	745	1445	132	\N	\N	\N	\N
922	2023-08-03 06:32:32.676609	2023-08-03 06:32:32.676609	Wednesday	1400	130	132	\N	\N	\N	\N
923	2023-08-03 06:32:32.677986	2023-08-03 06:32:32.677986	Thursday	900	2300	132	\N	\N	\N	\N
924	2023-08-03 06:32:32.679547	2023-08-03 06:32:32.679547	Friday	630	2200	132	\N	\N	\N	\N
925	2023-08-03 06:32:32.700388	2023-08-03 06:32:32.700388	Monday	930	1000	133	\N	\N	\N	\N
926	2023-08-03 06:32:32.701828	2023-08-03 06:32:32.701828	Monday	2330	2400	133	\N	\N	\N	\N
927	2023-08-03 06:32:32.703253	2023-08-03 06:32:32.703253	Tuesday	830	2130	133	\N	\N	\N	\N
928	2023-08-03 06:32:32.704662	2023-08-03 06:32:32.704662	Wednesday	745	2030	133	\N	\N	\N	\N
929	2023-08-03 06:32:32.70629	2023-08-03 06:32:32.70629	Thursday	845	1845	133	\N	\N	\N	\N
930	2023-08-03 06:32:32.707642	2023-08-03 06:32:32.707642	Friday	845	1600	133	\N	\N	\N	\N
931	2023-08-03 06:32:32.708998	2023-08-03 06:32:32.708998	Saturday	615	2030	133	\N	\N	\N	\N
932	2023-08-03 06:32:32.710395	2023-08-03 06:32:32.710395	Sunday	930	2300	133	\N	\N	\N	\N
933	2023-08-03 06:32:32.721136	2023-08-03 06:32:32.721136	Monday	845	2100	134	\N	\N	\N	\N
934	2023-08-03 06:32:32.722529	2023-08-03 06:32:32.722529	Wednesday	715	1615	134	\N	\N	\N	\N
935	2023-08-03 06:32:32.723998	2023-08-03 06:32:32.723998	Thursday	400	1745	134	\N	\N	\N	\N
936	2023-08-03 06:32:32.725401	2023-08-03 06:32:32.725401	Thursday	2115	2345	134	\N	\N	\N	\N
937	2023-08-03 06:32:32.72686	2023-08-03 06:32:32.72686	Friday	615	1630	134	\N	\N	\N	\N
938	2023-08-03 06:32:32.728269	2023-08-03 06:32:32.728269	Saturday	700	1600	134	\N	\N	\N	\N
939	2023-08-03 06:32:32.729686	2023-08-03 06:32:32.729686	Sunday	745	2145	134	\N	\N	\N	\N
940	2023-08-03 06:32:32.747139	2023-08-03 06:32:32.747139	Monday	700	2245	135	\N	\N	\N	\N
941	2023-08-03 06:32:32.748481	2023-08-03 06:32:32.748481	Wednesday	700	1800	135	\N	\N	\N	\N
942	2023-08-03 06:32:32.749859	2023-08-03 06:32:32.749859	Thursday	900	1815	135	\N	\N	\N	\N
943	2023-08-03 06:32:32.751186	2023-08-03 06:32:32.751186	Saturday	1000	1930	135	\N	\N	\N	\N
944	2023-08-03 06:32:32.75275	2023-08-03 06:32:32.75275	Sunday	715	2100	135	\N	\N	\N	\N
945	2023-08-03 06:32:32.776807	2023-08-03 06:32:32.776807	Monday	600	745	136	\N	\N	\N	\N
946	2023-08-03 06:32:32.778334	2023-08-03 06:32:32.778334	Monday	1245	245	136	\N	\N	\N	\N
947	2023-08-03 06:32:32.779783	2023-08-03 06:32:32.779783	Tuesday	630	1515	136	\N	\N	\N	\N
948	2023-08-03 06:32:32.781264	2023-08-03 06:32:32.781264	Wednesday	945	1700	136	\N	\N	\N	\N
949	2023-08-03 06:32:32.782791	2023-08-03 06:32:32.782791	Thursday	345	1630	136	\N	\N	\N	\N
950	2023-08-03 06:32:32.78425	2023-08-03 06:32:32.78425	Thursday	1815	2215	136	\N	\N	\N	\N
951	2023-08-03 06:32:32.785866	2023-08-03 06:32:32.785866	Friday	945	2245	136	\N	\N	\N	\N
952	2023-08-03 06:32:32.78723	2023-08-03 06:32:32.78723	Saturday	1000	1415	136	\N	\N	\N	\N
953	2023-08-03 06:32:32.788608	2023-08-03 06:32:32.788608	Sunday	615	1530	136	\N	\N	\N	\N
954	2023-08-03 06:32:32.799435	2023-08-03 06:32:32.799435	Monday	915	2015	137	\N	\N	\N	\N
955	2023-08-03 06:32:32.800812	2023-08-03 06:32:32.800812	Wednesday	930	1845	137	\N	\N	\N	\N
956	2023-08-03 06:32:32.802152	2023-08-03 06:32:32.802152	Thursday	945	1500	137	\N	\N	\N	\N
957	2023-08-03 06:32:32.80355	2023-08-03 06:32:32.80355	Friday	930	2015	137	\N	\N	\N	\N
958	2023-08-03 06:32:32.804981	2023-08-03 06:32:32.804981	Saturday	1100	1415	137	\N	\N	\N	\N
959	2023-08-03 06:32:32.806377	2023-08-03 06:32:32.806377	Saturday	2215	715	137	\N	\N	\N	\N
960	2023-08-03 06:32:32.807836	2023-08-03 06:32:32.807836	Sunday	2245	400	137	\N	\N	\N	\N
961	2023-08-03 06:32:32.825086	2023-08-03 06:32:32.825086	Tuesday	845	2400	138	\N	\N	\N	\N
962	2023-08-03 06:32:32.826512	2023-08-03 06:32:32.826512	Wednesday	100	1245	138	\N	\N	\N	\N
963	2023-08-03 06:32:32.827831	2023-08-03 06:32:32.827831	Wednesday	1515	2115	138	\N	\N	\N	\N
964	2023-08-03 06:32:32.829146	2023-08-03 06:32:32.829146	Thursday	815	2315	138	\N	\N	\N	\N
965	2023-08-03 06:32:32.830576	2023-08-03 06:32:32.830576	Friday	115	515	138	\N	\N	\N	\N
966	2023-08-03 06:32:32.831836	2023-08-03 06:32:32.831836	Friday	1630	2130	138	\N	\N	\N	\N
967	2023-08-03 06:32:32.833203	2023-08-03 06:32:32.833203	Saturday	1445	400	138	\N	\N	\N	\N
968	2023-08-03 06:32:32.834556	2023-08-03 06:32:32.834556	Sunday	2030	200	138	\N	\N	\N	\N
969	2023-08-03 06:32:32.855512	2023-08-03 06:32:32.855512	Monday	330	1830	139	\N	\N	\N	\N
970	2023-08-03 06:32:32.856955	2023-08-03 06:32:32.856955	Monday	2130	2345	139	\N	\N	\N	\N
971	2023-08-03 06:32:32.858453	2023-08-03 06:32:32.858453	Tuesday	330	515	139	\N	\N	\N	\N
972	2023-08-03 06:32:32.859882	2023-08-03 06:32:32.859882	Tuesday	715	1045	139	\N	\N	\N	\N
973	2023-08-03 06:32:32.861697	2023-08-03 06:32:32.861697	Wednesday	1215	1245	139	\N	\N	\N	\N
974	2023-08-03 06:32:32.863102	2023-08-03 06:32:32.863102	Wednesday	1330	2400	139	\N	\N	\N	\N
975	2023-08-03 06:32:32.864535	2023-08-03 06:32:32.864535	Thursday	1845	315	139	\N	\N	\N	\N
976	2023-08-03 06:32:32.866015	2023-08-03 06:32:32.866015	Friday	1645	115	139	\N	\N	\N	\N
977	2023-08-03 06:32:32.867474	2023-08-03 06:32:32.867474	Saturday	715	1430	139	\N	\N	\N	\N
978	2023-08-03 06:32:32.868905	2023-08-03 06:32:32.868905	Sunday	830	1745	139	\N	\N	\N	\N
979	2023-08-03 06:32:32.879389	2023-08-03 06:32:32.879389	Monday	700	1615	140	\N	\N	\N	\N
980	2023-08-03 06:32:32.880853	2023-08-03 06:32:32.880853	Tuesday	2030	200	140	\N	\N	\N	\N
981	2023-08-03 06:32:32.88223	2023-08-03 06:32:32.88223	Thursday	1415	200	140	\N	\N	\N	\N
982	2023-08-03 06:32:32.88365	2023-08-03 06:32:32.88365	Friday	845	1730	140	\N	\N	\N	\N
983	2023-08-03 06:32:32.885027	2023-08-03 06:32:32.885027	Saturday	1800	200	140	\N	\N	\N	\N
984	2023-08-03 06:32:32.906597	2023-08-03 06:32:32.906597	Monday	645	1830	141	\N	\N	\N	\N
985	2023-08-03 06:32:32.90797	2023-08-03 06:32:32.90797	Tuesday	815	2000	141	\N	\N	\N	\N
986	2023-08-03 06:32:32.909348	2023-08-03 06:32:32.909348	Wednesday	15	630	141	\N	\N	\N	\N
987	2023-08-03 06:32:32.910681	2023-08-03 06:32:32.910681	Wednesday	1130	1430	141	\N	\N	\N	\N
988	2023-08-03 06:32:32.912329	2023-08-03 06:32:32.912329	Friday	945	1645	141	\N	\N	\N	\N
989	2023-08-03 06:32:32.913739	2023-08-03 06:32:32.913739	Saturday	600	1545	141	\N	\N	\N	\N
990	2023-08-03 06:32:32.915074	2023-08-03 06:32:32.915074	Sunday	600	1730	141	\N	\N	\N	\N
991	2023-08-03 06:32:32.92468	2023-08-03 06:32:32.92468	Monday	845	2230	142	\N	\N	\N	\N
992	2023-08-03 06:32:32.926141	2023-08-03 06:32:32.926141	Tuesday	745	2100	142	\N	\N	\N	\N
993	2023-08-03 06:32:32.927534	2023-08-03 06:32:32.927534	Wednesday	630	2200	142	\N	\N	\N	\N
994	2023-08-03 06:32:32.92887	2023-08-03 06:32:32.92887	Thursday	815	2130	142	\N	\N	\N	\N
995	2023-08-03 06:32:32.930263	2023-08-03 06:32:32.930263	Friday	1545	330	142	\N	\N	\N	\N
996	2023-08-03 06:32:32.931596	2023-08-03 06:32:32.931596	Sunday	745	1645	142	\N	\N	\N	\N
997	2023-08-03 06:32:32.947824	2023-08-03 06:32:32.947824	Tuesday	915	1515	143	\N	\N	\N	\N
998	2023-08-03 06:32:32.949434	2023-08-03 06:32:32.949434	Wednesday	715	745	143	\N	\N	\N	\N
999	2023-08-03 06:32:32.950731	2023-08-03 06:32:32.950731	Wednesday	2000	2045	143	\N	\N	\N	\N
1000	2023-08-03 06:32:32.95212	2023-08-03 06:32:32.95212	Thursday	0	230	143	\N	\N	\N	\N
1001	2023-08-03 06:32:32.953406	2023-08-03 06:32:32.953406	Thursday	1000	1700	143	\N	\N	\N	\N
1002	2023-08-03 06:32:32.954859	2023-08-03 06:32:32.954859	Saturday	830	2045	143	\N	\N	\N	\N
1003	2023-08-03 06:32:32.956267	2023-08-03 06:32:32.956267	Sunday	215	445	143	\N	\N	\N	\N
1004	2023-08-03 06:32:32.95763	2023-08-03 06:32:32.95763	Sunday	815	1630	143	\N	\N	\N	\N
1005	2023-08-03 06:32:32.977221	2023-08-03 06:32:32.977221	Thursday	830	2345	144	\N	\N	\N	\N
1006	2023-08-03 06:32:32.978612	2023-08-03 06:32:32.978612	Saturday	2100	245	144	\N	\N	\N	\N
1007	2023-08-03 06:32:32.980003	2023-08-03 06:32:32.980003	Sunday	630	2100	144	\N	\N	\N	\N
1008	2023-08-03 06:32:32.989727	2023-08-03 06:32:32.989727	Monday	1000	1400	145	\N	\N	\N	\N
1009	2023-08-03 06:32:32.991118	2023-08-03 06:32:32.991118	Tuesday	1645	215	145	\N	\N	\N	\N
1010	2023-08-03 06:32:32.992467	2023-08-03 06:32:32.992467	Thursday	1730	400	145	\N	\N	\N	\N
1011	2023-08-03 06:32:32.993811	2023-08-03 06:32:32.993811	Friday	600	1715	145	\N	\N	\N	\N
1012	2023-08-03 06:32:32.995223	2023-08-03 06:32:32.995223	Saturday	400	530	145	\N	\N	\N	\N
1013	2023-08-03 06:32:32.996578	2023-08-03 06:32:32.996578	Saturday	700	15	145	\N	\N	\N	\N
1014	2023-08-03 06:32:32.997977	2023-08-03 06:32:32.997977	Sunday	700	2345	145	\N	\N	\N	\N
1015	2023-08-03 06:32:33.014313	2023-08-03 06:32:33.014313	Tuesday	1700	315	146	\N	\N	\N	\N
1016	2023-08-03 06:32:33.015637	2023-08-03 06:32:33.015637	Wednesday	830	2245	146	\N	\N	\N	\N
1017	2023-08-03 06:32:33.016965	2023-08-03 06:32:33.016965	Thursday	645	1645	146	\N	\N	\N	\N
1018	2023-08-03 06:32:33.018405	2023-08-03 06:32:33.018405	Friday	915	1745	146	\N	\N	\N	\N
1019	2023-08-03 06:32:33.019804	2023-08-03 06:32:33.019804	Saturday	630	1900	146	\N	\N	\N	\N
1020	2023-08-03 06:32:33.021189	2023-08-03 06:32:33.021189	Sunday	715	1845	146	\N	\N	\N	\N
1021	2023-08-03 06:32:33.041386	2023-08-03 06:32:33.041386	Monday	1000	2215	147	\N	\N	\N	\N
1022	2023-08-03 06:32:33.042795	2023-08-03 06:32:33.042795	Wednesday	900	2045	147	\N	\N	\N	\N
1023	2023-08-03 06:32:33.044226	2023-08-03 06:32:33.044226	Friday	630	715	147	\N	\N	\N	\N
1024	2023-08-03 06:32:33.045633	2023-08-03 06:32:33.045633	Friday	945	1045	147	\N	\N	\N	\N
1025	2023-08-03 06:32:33.047039	2023-08-03 06:32:33.047039	Saturday	645	1845	147	\N	\N	\N	\N
1026	2023-08-03 06:32:33.057271	2023-08-03 06:32:33.057271	Monday	715	1545	148	\N	\N	\N	\N
1027	2023-08-03 06:32:33.05875	2023-08-03 06:32:33.05875	Wednesday	630	2345	148	\N	\N	\N	\N
1028	2023-08-03 06:32:33.060211	2023-08-03 06:32:33.060211	Saturday	715	2145	148	\N	\N	\N	\N
1029	2023-08-03 06:32:33.061921	2023-08-03 06:32:33.061921	Sunday	645	1645	148	\N	\N	\N	\N
1030	2023-08-03 06:32:33.078595	2023-08-03 06:32:33.078595	Monday	1430	115	149	\N	\N	\N	\N
1031	2023-08-03 06:32:33.080007	2023-08-03 06:32:33.080007	Wednesday	1445	315	149	\N	\N	\N	\N
1032	2023-08-03 06:32:33.08139	2023-08-03 06:32:33.08139	Thursday	1000	2145	149	\N	\N	\N	\N
1033	2023-08-03 06:32:33.082746	2023-08-03 06:32:33.082746	Friday	945	2230	149	\N	\N	\N	\N
1034	2023-08-03 06:32:33.084157	2023-08-03 06:32:33.084157	Saturday	815	2145	149	\N	\N	\N	\N
1035	2023-08-03 06:32:33.085495	2023-08-03 06:32:33.085495	Sunday	345	1545	149	\N	\N	\N	\N
1036	2023-08-03 06:32:33.086822	2023-08-03 06:32:33.086822	Sunday	1845	2200	149	\N	\N	\N	\N
1037	2023-08-03 06:32:33.110232	2023-08-03 06:32:33.110232	Tuesday	615	2200	150	\N	\N	\N	\N
1038	2023-08-03 06:32:33.111909	2023-08-03 06:32:33.111909	Wednesday	900	2130	150	\N	\N	\N	\N
1039	2023-08-03 06:32:33.113861	2023-08-03 06:32:33.113861	Thursday	100	345	150	\N	\N	\N	\N
1040	2023-08-03 06:32:33.115569	2023-08-03 06:32:33.115569	Thursday	1030	1745	150	\N	\N	\N	\N
1041	2023-08-03 06:32:33.117197	2023-08-03 06:32:33.117197	Friday	1200	1815	150	\N	\N	\N	\N
1042	2023-08-03 06:32:33.118619	2023-08-03 06:32:33.118619	Friday	1930	830	150	\N	\N	\N	\N
1043	2023-08-03 06:32:33.120343	2023-08-03 06:32:33.120343	Saturday	715	1700	150	\N	\N	\N	\N
1044	2023-08-03 06:32:33.121809	2023-08-03 06:32:33.121809	Sunday	645	2245	150	\N	\N	\N	\N
1045	2023-08-03 06:32:33.132623	2023-08-03 06:32:33.132623	Monday	1000	1715	151	\N	\N	\N	\N
1046	2023-08-03 06:32:33.134771	2023-08-03 06:32:33.134771	Tuesday	630	1715	151	\N	\N	\N	\N
1047	2023-08-03 06:32:33.136484	2023-08-03 06:32:33.136484	Wednesday	730	1600	151	\N	\N	\N	\N
1048	2023-08-03 06:32:33.138022	2023-08-03 06:32:33.138022	Thursday	830	2100	151	\N	\N	\N	\N
1049	2023-08-03 06:32:33.139447	2023-08-03 06:32:33.139447	Friday	1000	1830	151	\N	\N	\N	\N
1050	2023-08-03 06:32:33.140905	2023-08-03 06:32:33.140905	Saturday	845	1830	151	\N	\N	\N	\N
1051	2023-08-03 06:32:33.14247	2023-08-03 06:32:33.14247	Sunday	715	2215	151	\N	\N	\N	\N
1052	2023-08-03 06:32:33.160973	2023-08-03 06:32:33.160973	Monday	900	2045	152	\N	\N	\N	\N
1053	2023-08-03 06:32:33.162722	2023-08-03 06:32:33.162722	Tuesday	1230	2045	152	\N	\N	\N	\N
1054	2023-08-03 06:32:33.164804	2023-08-03 06:32:33.164804	Tuesday	2130	2145	152	\N	\N	\N	\N
1055	2023-08-03 06:32:33.166534	2023-08-03 06:32:33.166534	Wednesday	915	1400	152	\N	\N	\N	\N
1056	2023-08-03 06:32:33.168211	2023-08-03 06:32:33.168211	Thursday	945	1415	152	\N	\N	\N	\N
1057	2023-08-03 06:32:33.169835	2023-08-03 06:32:33.169835	Friday	1730	215	152	\N	\N	\N	\N
1058	2023-08-03 06:32:33.171344	2023-08-03 06:32:33.171344	Saturday	1000	1615	152	\N	\N	\N	\N
1059	2023-08-03 06:32:33.172742	2023-08-03 06:32:33.172742	Sunday	730	1545	152	\N	\N	\N	\N
1060	2023-08-03 06:32:33.196026	2023-08-03 06:32:33.196026	Tuesday	2000	200	153	\N	\N	\N	\N
1061	2023-08-03 06:32:33.197607	2023-08-03 06:32:33.197607	Wednesday	715	1915	153	\N	\N	\N	\N
1062	2023-08-03 06:32:33.199113	2023-08-03 06:32:33.199113	Thursday	930	1515	153	\N	\N	\N	\N
1063	2023-08-03 06:32:33.200766	2023-08-03 06:32:33.200766	Friday	745	2015	153	\N	\N	\N	\N
1064	2023-08-03 06:32:33.202664	2023-08-03 06:32:33.202664	Saturday	845	1215	153	\N	\N	\N	\N
1065	2023-08-03 06:32:33.204378	2023-08-03 06:32:33.204378	Saturday	1830	2315	153	\N	\N	\N	\N
1066	2023-08-03 06:32:33.205996	2023-08-03 06:32:33.205996	Sunday	30	515	153	\N	\N	\N	\N
1067	2023-08-03 06:32:33.207872	2023-08-03 06:32:33.207872	Sunday	615	745	153	\N	\N	\N	\N
1068	2023-08-03 06:32:33.218702	2023-08-03 06:32:33.218702	Monday	1000	1515	154	\N	\N	\N	\N
1069	2023-08-03 06:32:33.220242	2023-08-03 06:32:33.220242	Wednesday	715	1430	154	\N	\N	\N	\N
1070	2023-08-03 06:32:33.221698	2023-08-03 06:32:33.221698	Thursday	1900	145	154	\N	\N	\N	\N
1071	2023-08-03 06:32:33.223298	2023-08-03 06:32:33.223298	Friday	600	1730	154	\N	\N	\N	\N
1072	2023-08-03 06:32:33.224725	2023-08-03 06:32:33.224725	Saturday	1515	115	154	\N	\N	\N	\N
1073	2023-08-03 06:32:33.242719	2023-08-03 06:32:33.242719	Monday	1745	1930	155	\N	\N	\N	\N
1074	2023-08-03 06:32:33.244209	2023-08-03 06:32:33.244209	Monday	2000	1645	155	\N	\N	\N	\N
1075	2023-08-03 06:32:33.245658	2023-08-03 06:32:33.245658	Tuesday	830	1530	155	\N	\N	\N	\N
1076	2023-08-03 06:32:33.247303	2023-08-03 06:32:33.247303	Wednesday	915	1445	155	\N	\N	\N	\N
1077	2023-08-03 06:32:33.2494	2023-08-03 06:32:33.2494	Thursday	430	545	155	\N	\N	\N	\N
1078	2023-08-03 06:32:33.251083	2023-08-03 06:32:33.251083	Thursday	630	900	155	\N	\N	\N	\N
1079	2023-08-03 06:32:33.252585	2023-08-03 06:32:33.252585	Friday	900	1845	155	\N	\N	\N	\N
1080	2023-08-03 06:32:33.254051	2023-08-03 06:32:33.254051	Saturday	830	1600	155	\N	\N	\N	\N
1081	2023-08-03 06:32:33.255519	2023-08-03 06:32:33.255519	Sunday	1845	130	155	\N	\N	\N	\N
1082	2023-08-03 06:32:33.277405	2023-08-03 06:32:33.277405	Tuesday	700	1700	156	\N	\N	\N	\N
1083	2023-08-03 06:32:33.279065	2023-08-03 06:32:33.279065	Wednesday	1645	100	156	\N	\N	\N	\N
1084	2023-08-03 06:32:33.280554	2023-08-03 06:32:33.280554	Thursday	1930	115	156	\N	\N	\N	\N
1085	2023-08-03 06:32:33.28195	2023-08-03 06:32:33.28195	Saturday	930	1615	156	\N	\N	\N	\N
1086	2023-08-03 06:32:33.283555	2023-08-03 06:32:33.283555	Sunday	615	2115	156	\N	\N	\N	\N
1087	2023-08-03 06:32:33.293003	2023-08-03 06:32:33.293003	Monday	715	1845	157	\N	\N	\N	\N
1088	2023-08-03 06:32:33.294445	2023-08-03 06:32:33.294445	Tuesday	915	2300	157	\N	\N	\N	\N
1089	2023-08-03 06:32:33.295854	2023-08-03 06:32:33.295854	Wednesday	730	1600	157	\N	\N	\N	\N
1090	2023-08-03 06:32:33.297194	2023-08-03 06:32:33.297194	Wednesday	1845	2300	157	\N	\N	\N	\N
1091	2023-08-03 06:32:33.298668	2023-08-03 06:32:33.298668	Friday	945	1845	157	\N	\N	\N	\N
1092	2023-08-03 06:32:33.3001	2023-08-03 06:32:33.3001	Saturday	930	1930	157	\N	\N	\N	\N
1093	2023-08-03 06:32:33.301535	2023-08-03 06:32:33.301535	Sunday	1815	130	157	\N	\N	\N	\N
1094	2023-08-03 06:32:33.323102	2023-08-03 06:32:33.323102	Monday	1730	230	158	\N	\N	\N	\N
1095	2023-08-03 06:32:33.32461	2023-08-03 06:32:33.32461	Wednesday	1000	1400	158	\N	\N	\N	\N
1096	2023-08-03 06:32:33.326118	2023-08-03 06:32:33.326118	Friday	830	2045	158	\N	\N	\N	\N
1097	2023-08-03 06:32:33.32765	2023-08-03 06:32:33.32765	Saturday	245	730	158	\N	\N	\N	\N
1098	2023-08-03 06:32:33.329046	2023-08-03 06:32:33.329046	Saturday	1230	2230	158	\N	\N	\N	\N
1099	2023-08-03 06:32:33.330694	2023-08-03 06:32:33.330694	Sunday	930	2045	158	\N	\N	\N	\N
1100	2023-08-03 06:32:33.341417	2023-08-03 06:32:33.341417	Tuesday	145	1230	159	\N	\N	\N	\N
1101	2023-08-03 06:32:33.342816	2023-08-03 06:32:33.342816	Tuesday	1345	2000	159	\N	\N	\N	\N
1102	2023-08-03 06:32:33.344482	2023-08-03 06:32:33.344482	Wednesday	615	1230	159	\N	\N	\N	\N
1103	2023-08-03 06:32:33.345833	2023-08-03 06:32:33.345833	Wednesday	2315	115	159	\N	\N	\N	\N
1104	2023-08-03 06:32:33.347352	2023-08-03 06:32:33.347352	Thursday	630	2000	159	\N	\N	\N	\N
1105	2023-08-03 06:32:33.348763	2023-08-03 06:32:33.348763	Friday	1000	1600	159	\N	\N	\N	\N
1106	2023-08-03 06:32:33.350153	2023-08-03 06:32:33.350153	Saturday	645	2000	159	\N	\N	\N	\N
1107	2023-08-03 06:32:33.351582	2023-08-03 06:32:33.351582	Sunday	630	2345	159	\N	\N	\N	\N
1108	2023-08-03 06:32:33.369402	2023-08-03 06:32:33.369402	Tuesday	930	2345	160	\N	\N	\N	\N
1109	2023-08-03 06:32:33.371163	2023-08-03 06:32:33.371163	Sunday	1730	215	160	\N	\N	\N	\N
1110	2023-08-03 06:32:33.393644	2023-08-03 06:32:33.393644	Monday	845	1745	161	\N	\N	\N	\N
1111	2023-08-03 06:32:33.395093	2023-08-03 06:32:33.395093	Tuesday	800	1500	161	\N	\N	\N	\N
1112	2023-08-03 06:32:33.396499	2023-08-03 06:32:33.396499	Wednesday	230	330	161	\N	\N	\N	\N
1113	2023-08-03 06:32:33.397972	2023-08-03 06:32:33.397972	Wednesday	1300	2045	161	\N	\N	\N	\N
1114	2023-08-03 06:32:33.399826	2023-08-03 06:32:33.399826	Thursday	830	2215	161	\N	\N	\N	\N
1115	2023-08-03 06:32:33.401233	2023-08-03 06:32:33.401233	Saturday	630	1600	161	\N	\N	\N	\N
1116	2023-08-03 06:32:33.402682	2023-08-03 06:32:33.402682	Sunday	30	415	161	\N	\N	\N	\N
1117	2023-08-03 06:32:33.404165	2023-08-03 06:32:33.404165	Sunday	745	2100	161	\N	\N	\N	\N
1118	2023-08-03 06:32:33.415756	2023-08-03 06:32:33.415756	Monday	900	1945	162	\N	\N	\N	\N
1119	2023-08-03 06:32:33.417433	2023-08-03 06:32:33.417433	Tuesday	930	1715	162	\N	\N	\N	\N
1120	2023-08-03 06:32:33.419166	2023-08-03 06:32:33.419166	Friday	1600	145	162	\N	\N	\N	\N
1121	2023-08-03 06:32:33.420651	2023-08-03 06:32:33.420651	Sunday	715	2300	162	\N	\N	\N	\N
1122	2023-08-03 06:32:33.437749	2023-08-03 06:32:33.437749	Monday	945	2030	163	\N	\N	\N	\N
1123	2023-08-03 06:32:33.439213	2023-08-03 06:32:33.439213	Tuesday	845	2245	163	\N	\N	\N	\N
1124	2023-08-03 06:32:33.440955	2023-08-03 06:32:33.440955	Wednesday	730	1300	163	\N	\N	\N	\N
1125	2023-08-03 06:32:33.442323	2023-08-03 06:32:33.442323	Wednesday	1630	2130	163	\N	\N	\N	\N
1126	2023-08-03 06:32:33.443983	2023-08-03 06:32:33.443983	Thursday	630	1945	163	\N	\N	\N	\N
1127	2023-08-03 06:32:33.445678	2023-08-03 06:32:33.445678	Saturday	930	1945	163	\N	\N	\N	\N
1128	2023-08-03 06:32:33.447179	2023-08-03 06:32:33.447179	Sunday	915	1945	163	\N	\N	\N	\N
1129	2023-08-03 06:32:33.469716	2023-08-03 06:32:33.469716	Monday	915	1930	164	\N	\N	\N	\N
1130	2023-08-03 06:32:33.471205	2023-08-03 06:32:33.471205	Tuesday	615	2245	164	\N	\N	\N	\N
1131	2023-08-03 06:32:33.47287	2023-08-03 06:32:33.47287	Wednesday	830	2030	164	\N	\N	\N	\N
1132	2023-08-03 06:32:33.474276	2023-08-03 06:32:33.474276	Thursday	430	930	164	\N	\N	\N	\N
1133	2023-08-03 06:32:33.475906	2023-08-03 06:32:33.475906	Thursday	1515	2345	164	\N	\N	\N	\N
1134	2023-08-03 06:32:33.477553	2023-08-03 06:32:33.477553	Friday	645	730	164	\N	\N	\N	\N
1135	2023-08-03 06:32:33.479231	2023-08-03 06:32:33.479231	Friday	2115	2330	164	\N	\N	\N	\N
1136	2023-08-03 06:32:33.48141	2023-08-03 06:32:33.48141	Saturday	845	1900	164	\N	\N	\N	\N
1137	2023-08-03 06:32:33.48313	2023-08-03 06:32:33.48313	Sunday	915	1700	164	\N	\N	\N	\N
1138	2023-08-03 06:32:33.494165	2023-08-03 06:32:33.494165	Monday	2030	330	165	\N	\N	\N	\N
1139	2023-08-03 06:32:33.4959	2023-08-03 06:32:33.4959	Tuesday	830	2200	165	\N	\N	\N	\N
1140	2023-08-03 06:32:33.497374	2023-08-03 06:32:33.497374	Thursday	830	2345	165	\N	\N	\N	\N
1141	2023-08-03 06:32:33.498955	2023-08-03 06:32:33.498955	Friday	215	600	165	\N	\N	\N	\N
1142	2023-08-03 06:32:33.500477	2023-08-03 06:32:33.500477	Friday	1230	1945	165	\N	\N	\N	\N
1143	2023-08-03 06:32:33.50199	2023-08-03 06:32:33.50199	Saturday	600	2400	165	\N	\N	\N	\N
1144	2023-08-03 06:32:33.503439	2023-08-03 06:32:33.503439	Sunday	900	2000	165	\N	\N	\N	\N
1145	2023-08-03 06:32:33.526137	2023-08-03 06:32:33.526137	Monday	1800	100	166	\N	\N	\N	\N
1146	2023-08-03 06:32:33.527559	2023-08-03 06:32:33.527559	Tuesday	830	1930	166	\N	\N	\N	\N
1147	2023-08-03 06:32:33.529106	2023-08-03 06:32:33.529106	Wednesday	230	445	166	\N	\N	\N	\N
1148	2023-08-03 06:32:33.530703	2023-08-03 06:32:33.530703	Wednesday	2045	2230	166	\N	\N	\N	\N
1149	2023-08-03 06:32:33.532149	2023-08-03 06:32:33.532149	Thursday	930	2400	166	\N	\N	\N	\N
1150	2023-08-03 06:32:33.533637	2023-08-03 06:32:33.533637	Friday	645	1415	166	\N	\N	\N	\N
1151	2023-08-03 06:32:33.535294	2023-08-03 06:32:33.535294	Saturday	915	1445	166	\N	\N	\N	\N
1152	2023-08-03 06:32:33.536701	2023-08-03 06:32:33.536701	Sunday	145	945	166	\N	\N	\N	\N
1153	2023-08-03 06:32:33.538046	2023-08-03 06:32:33.538046	Sunday	1000	1100	166	\N	\N	\N	\N
1154	2023-08-03 06:32:33.548972	2023-08-03 06:32:33.548972	Monday	400	1315	167	\N	\N	\N	\N
1155	2023-08-03 06:32:33.550486	2023-08-03 06:32:33.550486	Monday	1545	1945	167	\N	\N	\N	\N
1156	2023-08-03 06:32:33.551916	2023-08-03 06:32:33.551916	Tuesday	845	2045	167	\N	\N	\N	\N
1157	2023-08-03 06:32:33.553265	2023-08-03 06:32:33.553265	Wednesday	745	1715	167	\N	\N	\N	\N
1158	2023-08-03 06:32:33.554693	2023-08-03 06:32:33.554693	Thursday	1645	100	167	\N	\N	\N	\N
1159	2023-08-03 06:32:33.556059	2023-08-03 06:32:33.556059	Friday	945	1630	167	\N	\N	\N	\N
1160	2023-08-03 06:32:33.557427	2023-08-03 06:32:33.557427	Sunday	700	1630	167	\N	\N	\N	\N
1161	2023-08-03 06:32:33.577775	2023-08-03 06:32:33.577775	Monday	900	1515	168	\N	\N	\N	\N
1162	2023-08-03 06:32:33.579408	2023-08-03 06:32:33.579408	Tuesday	900	1430	168	\N	\N	\N	\N
1163	2023-08-03 06:32:33.581204	2023-08-03 06:32:33.581204	Wednesday	830	1400	168	\N	\N	\N	\N
1164	2023-08-03 06:32:33.582742	2023-08-03 06:32:33.582742	Wednesday	1615	2400	168	\N	\N	\N	\N
1165	2023-08-03 06:32:33.584451	2023-08-03 06:32:33.584451	Friday	245	1415	168	\N	\N	\N	\N
1166	2023-08-03 06:32:33.585994	2023-08-03 06:32:33.585994	Friday	1745	100	168	\N	\N	\N	\N
1167	2023-08-03 06:32:33.587902	2023-08-03 06:32:33.587902	Saturday	915	2330	168	\N	\N	\N	\N
1168	2023-08-03 06:32:33.589335	2023-08-03 06:32:33.589335	Sunday	1000	1545	168	\N	\N	\N	\N
1169	2023-08-03 06:32:33.599896	2023-08-03 06:32:33.599896	Monday	1515	145	169	\N	\N	\N	\N
1170	2023-08-03 06:32:33.601336	2023-08-03 06:32:33.601336	Tuesday	630	2300	169	\N	\N	\N	\N
1171	2023-08-03 06:32:33.602727	2023-08-03 06:32:33.602727	Wednesday	700	2200	169	\N	\N	\N	\N
1172	2023-08-03 06:32:33.604095	2023-08-03 06:32:33.604095	Friday	1830	345	169	\N	\N	\N	\N
1173	2023-08-03 06:32:33.605484	2023-08-03 06:32:33.605484	Saturday	900	1715	169	\N	\N	\N	\N
1174	2023-08-03 06:32:33.606853	2023-08-03 06:32:33.606853	Sunday	845	1415	169	\N	\N	\N	\N
1175	2023-08-03 06:32:33.623862	2023-08-03 06:32:33.623862	Monday	600	2045	170	\N	\N	\N	\N
1176	2023-08-03 06:32:33.625617	2023-08-03 06:32:33.625617	Tuesday	1815	315	170	\N	\N	\N	\N
1177	2023-08-03 06:32:33.627007	2023-08-03 06:32:33.627007	Wednesday	700	2015	170	\N	\N	\N	\N
1178	2023-08-03 06:32:33.628423	2023-08-03 06:32:33.628423	Thursday	1000	1400	170	\N	\N	\N	\N
1179	2023-08-03 06:32:33.629754	2023-08-03 06:32:33.629754	Thursday	1930	2300	170	\N	\N	\N	\N
1180	2023-08-03 06:32:33.631133	2023-08-03 06:32:33.631133	Friday	900	2245	170	\N	\N	\N	\N
1181	2023-08-03 06:32:33.632456	2023-08-03 06:32:33.632456	Saturday	2200	400	170	\N	\N	\N	\N
1182	2023-08-03 06:32:33.633879	2023-08-03 06:32:33.633879	Sunday	945	2200	170	\N	\N	\N	\N
1183	2023-08-03 06:32:33.65475	2023-08-03 06:32:33.65475	Monday	745	2200	171	\N	\N	\N	\N
1184	2023-08-03 06:32:33.656222	2023-08-03 06:32:33.656222	Tuesday	2115	215	171	\N	\N	\N	\N
1185	2023-08-03 06:32:33.657753	2023-08-03 06:32:33.657753	Wednesday	1545	100	171	\N	\N	\N	\N
1186	2023-08-03 06:32:33.659181	2023-08-03 06:32:33.659181	Thursday	615	2015	171	\N	\N	\N	\N
1187	2023-08-03 06:32:33.660559	2023-08-03 06:32:33.660559	Friday	845	2300	171	\N	\N	\N	\N
1188	2023-08-03 06:32:33.661945	2023-08-03 06:32:33.661945	Saturday	830	2200	171	\N	\N	\N	\N
1189	2023-08-03 06:32:33.663481	2023-08-03 06:32:33.663481	Sunday	745	1430	171	\N	\N	\N	\N
1190	2023-08-03 06:32:33.673034	2023-08-03 06:32:33.673034	Monday	30	230	172	\N	\N	\N	\N
1191	2023-08-03 06:32:33.674526	2023-08-03 06:32:33.674526	Monday	730	1730	172	\N	\N	\N	\N
1192	2023-08-03 06:32:33.676211	2023-08-03 06:32:33.676211	Tuesday	715	2000	172	\N	\N	\N	\N
1193	2023-08-03 06:32:33.677723	2023-08-03 06:32:33.677723	Wednesday	145	800	172	\N	\N	\N	\N
1194	2023-08-03 06:32:33.679204	2023-08-03 06:32:33.679204	Wednesday	930	1800	172	\N	\N	\N	\N
1195	2023-08-03 06:32:33.680732	2023-08-03 06:32:33.680732	Thursday	400	1830	172	\N	\N	\N	\N
1196	2023-08-03 06:32:33.682111	2023-08-03 06:32:33.682111	Thursday	1845	2030	172	\N	\N	\N	\N
1197	2023-08-03 06:32:33.683777	2023-08-03 06:32:33.683777	Sunday	830	2145	172	\N	\N	\N	\N
1198	2023-08-03 06:32:33.708756	2023-08-03 06:32:33.708756	Monday	900	2200	173	\N	\N	\N	\N
1199	2023-08-03 06:32:33.710434	2023-08-03 06:32:33.710434	Tuesday	330	1030	173	\N	\N	\N	\N
1200	2023-08-03 06:32:33.712007	2023-08-03 06:32:33.712007	Tuesday	1245	215	173	\N	\N	\N	\N
1201	2023-08-03 06:32:33.713609	2023-08-03 06:32:33.713609	Wednesday	0	1845	173	\N	\N	\N	\N
1202	2023-08-03 06:32:33.715009	2023-08-03 06:32:33.715009	Wednesday	2100	2200	173	\N	\N	\N	\N
1203	2023-08-03 06:32:33.716684	2023-08-03 06:32:33.716684	Thursday	845	1630	173	\N	\N	\N	\N
1204	2023-08-03 06:32:33.718298	2023-08-03 06:32:33.718298	Friday	1830	130	173	\N	\N	\N	\N
1205	2023-08-03 06:32:33.719969	2023-08-03 06:32:33.719969	Saturday	645	2130	173	\N	\N	\N	\N
1206	2023-08-03 06:32:33.721359	2023-08-03 06:32:33.721359	Sunday	700	1945	173	\N	\N	\N	\N
1207	2023-08-03 06:32:33.732477	2023-08-03 06:32:33.732477	Monday	815	1515	174	\N	\N	\N	\N
1208	2023-08-03 06:32:33.734143	2023-08-03 06:32:33.734143	Tuesday	445	945	174	\N	\N	\N	\N
1209	2023-08-03 06:32:33.735665	2023-08-03 06:32:33.735665	Tuesday	1315	2030	174	\N	\N	\N	\N
1210	2023-08-03 06:32:33.737098	2023-08-03 06:32:33.737098	Wednesday	845	2000	174	\N	\N	\N	\N
1211	2023-08-03 06:32:33.738588	2023-08-03 06:32:33.738588	Thursday	745	1800	174	\N	\N	\N	\N
1212	2023-08-03 06:32:33.739981	2023-08-03 06:32:33.739981	Friday	645	1545	174	\N	\N	\N	\N
1213	2023-08-03 06:32:33.741394	2023-08-03 06:32:33.741394	Saturday	230	430	174	\N	\N	\N	\N
1214	2023-08-03 06:32:33.74283	2023-08-03 06:32:33.74283	Saturday	515	2315	174	\N	\N	\N	\N
1215	2023-08-03 06:32:33.760684	2023-08-03 06:32:33.760684	Tuesday	2100	145	175	\N	\N	\N	\N
1216	2023-08-03 06:32:33.762106	2023-08-03 06:32:33.762106	Wednesday	945	1515	175	\N	\N	\N	\N
1217	2023-08-03 06:32:33.763577	2023-08-03 06:32:33.763577	Friday	2115	315	175	\N	\N	\N	\N
1218	2023-08-03 06:32:33.765014	2023-08-03 06:32:33.765014	Saturday	730	2030	175	\N	\N	\N	\N
1219	2023-08-03 06:32:33.785484	2023-08-03 06:32:33.785484	Monday	615	645	176	\N	\N	\N	\N
1220	2023-08-03 06:32:33.787354	2023-08-03 06:32:33.787354	Monday	1215	2100	176	\N	\N	\N	\N
1221	2023-08-03 06:32:33.788832	2023-08-03 06:32:33.788832	Tuesday	900	2215	176	\N	\N	\N	\N
1222	2023-08-03 06:32:33.790388	2023-08-03 06:32:33.790388	Wednesday	830	1845	176	\N	\N	\N	\N
1223	2023-08-03 06:32:33.791945	2023-08-03 06:32:33.791945	Thursday	715	2045	176	\N	\N	\N	\N
1224	2023-08-03 06:32:33.793484	2023-08-03 06:32:33.793484	Friday	900	1200	176	\N	\N	\N	\N
1225	2023-08-03 06:32:33.794921	2023-08-03 06:32:33.794921	Friday	1545	2015	176	\N	\N	\N	\N
1226	2023-08-03 06:32:33.796405	2023-08-03 06:32:33.796405	Saturday	30	445	176	\N	\N	\N	\N
1227	2023-08-03 06:32:33.797804	2023-08-03 06:32:33.797804	Saturday	1100	1545	176	\N	\N	\N	\N
1228	2023-08-03 06:32:33.799532	2023-08-03 06:32:33.799532	Sunday	600	1500	176	\N	\N	\N	\N
1229	2023-08-03 06:32:33.809222	2023-08-03 06:32:33.809222	Monday	900	1500	177	\N	\N	\N	\N
1230	2023-08-03 06:32:33.810745	2023-08-03 06:32:33.810745	Tuesday	1245	1715	177	\N	\N	\N	\N
1231	2023-08-03 06:32:33.812439	2023-08-03 06:32:33.812439	Tuesday	2215	30	177	\N	\N	\N	\N
1232	2023-08-03 06:32:33.814009	2023-08-03 06:32:33.814009	Friday	615	1000	177	\N	\N	\N	\N
1233	2023-08-03 06:32:33.815372	2023-08-03 06:32:33.815372	Friday	2345	330	177	\N	\N	\N	\N
1234	2023-08-03 06:32:33.816851	2023-08-03 06:32:33.816851	Saturday	845	1430	177	\N	\N	\N	\N
1235	2023-08-03 06:32:33.818291	2023-08-03 06:32:33.818291	Sunday	930	2145	177	\N	\N	\N	\N
1236	2023-08-03 06:32:33.834022	2023-08-03 06:32:33.834022	Monday	730	2300	178	\N	\N	\N	\N
1237	2023-08-03 06:32:33.83552	2023-08-03 06:32:33.83552	Thursday	830	1815	178	\N	\N	\N	\N
1238	2023-08-03 06:32:33.836938	2023-08-03 06:32:33.836938	Friday	100	445	178	\N	\N	\N	\N
1239	2023-08-03 06:32:33.838546	2023-08-03 06:32:33.838546	Friday	2345	2400	178	\N	\N	\N	\N
1240	2023-08-03 06:32:33.839911	2023-08-03 06:32:33.839911	Saturday	615	1600	178	\N	\N	\N	\N
1241	2023-08-03 06:32:33.841308	2023-08-03 06:32:33.841308	Sunday	930	2115	178	\N	\N	\N	\N
1242	2023-08-03 06:32:33.861816	2023-08-03 06:32:33.861816	Monday	930	1600	179	\N	\N	\N	\N
1243	2023-08-03 06:32:33.863436	2023-08-03 06:32:33.863436	Tuesday	345	945	179	\N	\N	\N	\N
1244	2023-08-03 06:32:33.864846	2023-08-03 06:32:33.864846	Tuesday	2330	200	179	\N	\N	\N	\N
1245	2023-08-03 06:32:33.866231	2023-08-03 06:32:33.866231	Wednesday	2145	230	179	\N	\N	\N	\N
1246	2023-08-03 06:32:33.867622	2023-08-03 06:32:33.867622	Thursday	100	345	179	\N	\N	\N	\N
1247	2023-08-03 06:32:33.869024	2023-08-03 06:32:33.869024	Thursday	745	1945	179	\N	\N	\N	\N
1248	2023-08-03 06:32:33.870408	2023-08-03 06:32:33.870408	Friday	900	1730	179	\N	\N	\N	\N
1249	2023-08-03 06:32:33.871836	2023-08-03 06:32:33.871836	Saturday	815	1815	179	\N	\N	\N	\N
1250	2023-08-03 06:32:33.87312	2023-08-03 06:32:33.87312	Sunday	745	1745	179	\N	\N	\N	\N
1251	2023-08-03 06:32:33.883552	2023-08-03 06:32:33.883552	Monday	1515	1630	180	\N	\N	\N	\N
1252	2023-08-03 06:32:33.884961	2023-08-03 06:32:33.884961	Monday	1645	1015	180	\N	\N	\N	\N
1253	2023-08-03 06:32:33.886435	2023-08-03 06:32:33.886435	Tuesday	930	1715	180	\N	\N	\N	\N
1254	2023-08-03 06:32:33.88808	2023-08-03 06:32:33.88808	Friday	600	1000	180	\N	\N	\N	\N
1255	2023-08-03 06:32:33.889442	2023-08-03 06:32:33.889442	Friday	1730	2000	180	\N	\N	\N	\N
1256	2023-08-03 06:32:33.89081	2023-08-03 06:32:33.89081	Saturday	2145	100	180	\N	\N	\N	\N
1257	2023-08-03 06:32:33.892203	2023-08-03 06:32:33.892203	Sunday	900	1900	180	\N	\N	\N	\N
1258	2023-08-03 06:32:33.912191	2023-08-03 06:32:33.912191	Monday	0	245	181	\N	\N	\N	\N
1259	2023-08-03 06:32:33.913777	2023-08-03 06:32:33.913777	Monday	900	1945	181	\N	\N	\N	\N
1260	2023-08-03 06:32:33.915208	2023-08-03 06:32:33.915208	Tuesday	2245	300	181	\N	\N	\N	\N
1261	2023-08-03 06:32:33.91668	2023-08-03 06:32:33.91668	Wednesday	145	215	181	\N	\N	\N	\N
1262	2023-08-03 06:32:33.918113	2023-08-03 06:32:33.918113	Wednesday	1130	1445	181	\N	\N	\N	\N
1263	2023-08-03 06:32:33.919558	2023-08-03 06:32:33.919558	Friday	530	815	181	\N	\N	\N	\N
1264	2023-08-03 06:32:33.920917	2023-08-03 06:32:33.920917	Friday	1530	2145	181	\N	\N	\N	\N
1265	2023-08-03 06:32:33.922279	2023-08-03 06:32:33.922279	Sunday	900	1800	181	\N	\N	\N	\N
1266	2023-08-03 06:32:33.931435	2023-08-03 06:32:33.931435	Monday	100	1045	182	\N	\N	\N	\N
1267	2023-08-03 06:32:33.932975	2023-08-03 06:32:33.932975	Monday	1900	2245	182	\N	\N	\N	\N
1268	2023-08-03 06:32:33.934548	2023-08-03 06:32:33.934548	Wednesday	1900	145	182	\N	\N	\N	\N
1269	2023-08-03 06:32:33.936143	2023-08-03 06:32:33.936143	Thursday	1745	315	182	\N	\N	\N	\N
1270	2023-08-03 06:32:33.937585	2023-08-03 06:32:33.937585	Saturday	200	345	182	\N	\N	\N	\N
1271	2023-08-03 06:32:33.939209	2023-08-03 06:32:33.939209	Saturday	1045	1800	182	\N	\N	\N	\N
1272	2023-08-03 06:32:33.940613	2023-08-03 06:32:33.940613	Sunday	700	1545	182	\N	\N	\N	\N
1273	2023-08-03 06:32:33.956382	2023-08-03 06:32:33.956382	Monday	630	1415	183	\N	\N	\N	\N
1274	2023-08-03 06:32:33.957779	2023-08-03 06:32:33.957779	Tuesday	815	1430	183	\N	\N	\N	\N
1275	2023-08-03 06:32:33.959213	2023-08-03 06:32:33.959213	Wednesday	645	1715	183	\N	\N	\N	\N
1276	2023-08-03 06:32:33.960808	2023-08-03 06:32:33.960808	Thursday	600	830	183	\N	\N	\N	\N
1277	2023-08-03 06:32:33.962241	2023-08-03 06:32:33.962241	Thursday	845	1115	183	\N	\N	\N	\N
1278	2023-08-03 06:32:33.963872	2023-08-03 06:32:33.963872	Friday	945	1845	183	\N	\N	\N	\N
1279	2023-08-03 06:32:33.965785	2023-08-03 06:32:33.965785	Saturday	530	2030	183	\N	\N	\N	\N
1280	2023-08-03 06:32:33.967344	2023-08-03 06:32:33.967344	Saturday	2300	2345	183	\N	\N	\N	\N
1281	2023-08-03 06:32:33.969017	2023-08-03 06:32:33.969017	Sunday	400	900	183	\N	\N	\N	\N
1282	2023-08-03 06:32:33.970665	2023-08-03 06:32:33.970665	Sunday	1130	230	183	\N	\N	\N	\N
1283	2023-08-03 06:32:33.992477	2023-08-03 06:32:33.992477	Monday	715	2130	184	\N	\N	\N	\N
1284	2023-08-03 06:32:33.994202	2023-08-03 06:32:33.994202	Tuesday	2215	115	184	\N	\N	\N	\N
1285	2023-08-03 06:32:33.995665	2023-08-03 06:32:33.995665	Wednesday	900	2000	184	\N	\N	\N	\N
1286	2023-08-03 06:32:33.997152	2023-08-03 06:32:33.997152	Thursday	600	1845	184	\N	\N	\N	\N
1287	2023-08-03 06:32:33.998601	2023-08-03 06:32:33.998601	Friday	900	1615	184	\N	\N	\N	\N
1288	2023-08-03 06:32:34.000129	2023-08-03 06:32:34.000129	Saturday	1045	1415	184	\N	\N	\N	\N
1289	2023-08-03 06:32:34.00151	2023-08-03 06:32:34.00151	Saturday	1815	200	184	\N	\N	\N	\N
1290	2023-08-03 06:32:34.003008	2023-08-03 06:32:34.003008	Sunday	630	1545	184	\N	\N	\N	\N
1291	2023-08-03 06:32:34.01305	2023-08-03 06:32:34.01305	Monday	930	1800	185	\N	\N	\N	\N
1292	2023-08-03 06:32:34.014582	2023-08-03 06:32:34.014582	Tuesday	130	200	185	\N	\N	\N	\N
1293	2023-08-03 06:32:34.016016	2023-08-03 06:32:34.016016	Tuesday	230	2000	185	\N	\N	\N	\N
1294	2023-08-03 06:32:34.017474	2023-08-03 06:32:34.017474	Wednesday	1700	245	185	\N	\N	\N	\N
1295	2023-08-03 06:32:34.018818	2023-08-03 06:32:34.018818	Thursday	1615	245	185	\N	\N	\N	\N
1296	2023-08-03 06:32:34.020481	2023-08-03 06:32:34.020481	Saturday	845	1600	185	\N	\N	\N	\N
1297	2023-08-03 06:32:34.021848	2023-08-03 06:32:34.021848	Sunday	830	2315	185	\N	\N	\N	\N
1298	2023-08-03 06:32:34.039018	2023-08-03 06:32:34.039018	Monday	1745	1930	186	\N	\N	\N	\N
1299	2023-08-03 06:32:34.040573	2023-08-03 06:32:34.040573	Monday	2330	1730	186	\N	\N	\N	\N
1300	2023-08-03 06:32:34.042111	2023-08-03 06:32:34.042111	Tuesday	400	500	186	\N	\N	\N	\N
1301	2023-08-03 06:32:34.043581	2023-08-03 06:32:34.043581	Tuesday	1815	2230	186	\N	\N	\N	\N
1302	2023-08-03 06:32:34.044928	2023-08-03 06:32:34.044928	Wednesday	715	1830	186	\N	\N	\N	\N
1303	2023-08-03 06:32:34.046537	2023-08-03 06:32:34.046537	Thursday	2230	200	186	\N	\N	\N	\N
1304	2023-08-03 06:32:34.047896	2023-08-03 06:32:34.047896	Friday	845	2130	186	\N	\N	\N	\N
1305	2023-08-03 06:32:34.04922	2023-08-03 06:32:34.04922	Friday	2315	2330	186	\N	\N	\N	\N
1306	2023-08-03 06:32:34.069917	2023-08-03 06:32:34.069917	Monday	700	2015	187	\N	\N	\N	\N
1307	2023-08-03 06:32:34.071324	2023-08-03 06:32:34.071324	Tuesday	915	1945	187	\N	\N	\N	\N
1308	2023-08-03 06:32:34.072755	2023-08-03 06:32:34.072755	Wednesday	730	800	187	\N	\N	\N	\N
1309	2023-08-03 06:32:34.074127	2023-08-03 06:32:34.074127	Wednesday	1730	2000	187	\N	\N	\N	\N
1310	2023-08-03 06:32:34.075565	2023-08-03 06:32:34.075565	Thursday	745	2230	187	\N	\N	\N	\N
1311	2023-08-03 06:32:34.076971	2023-08-03 06:32:34.076971	Friday	1000	2215	187	\N	\N	\N	\N
1312	2023-08-03 06:32:34.078411	2023-08-03 06:32:34.078411	Saturday	600	1945	187	\N	\N	\N	\N
1313	2023-08-03 06:32:34.088226	2023-08-03 06:32:34.088226	Monday	1000	2145	188	\N	\N	\N	\N
1314	2023-08-03 06:32:34.089665	2023-08-03 06:32:34.089665	Tuesday	1945	130	188	\N	\N	\N	\N
1315	2023-08-03 06:32:34.091197	2023-08-03 06:32:34.091197	Wednesday	515	830	188	\N	\N	\N	\N
1316	2023-08-03 06:32:34.092677	2023-08-03 06:32:34.092677	Wednesday	915	1645	188	\N	\N	\N	\N
1317	2023-08-03 06:32:34.094137	2023-08-03 06:32:34.094137	Thursday	715	2145	188	\N	\N	\N	\N
1318	2023-08-03 06:32:34.095865	2023-08-03 06:32:34.095865	Friday	1445	145	188	\N	\N	\N	\N
1319	2023-08-03 06:32:34.097358	2023-08-03 06:32:34.097358	Sunday	1000	2230	188	\N	\N	\N	\N
1320	2023-08-03 06:32:34.114212	2023-08-03 06:32:34.114212	Monday	845	2115	189	\N	\N	\N	\N
1321	2023-08-03 06:32:34.115665	2023-08-03 06:32:34.115665	Tuesday	945	1745	189	\N	\N	\N	\N
1322	2023-08-03 06:32:34.117164	2023-08-03 06:32:34.117164	Wednesday	200	645	189	\N	\N	\N	\N
1323	2023-08-03 06:32:34.118642	2023-08-03 06:32:34.118642	Wednesday	1045	2045	189	\N	\N	\N	\N
1324	2023-08-03 06:32:34.120118	2023-08-03 06:32:34.120118	Thursday	800	1730	189	\N	\N	\N	\N
1325	2023-08-03 06:32:34.121562	2023-08-03 06:32:34.121562	Friday	930	2200	189	\N	\N	\N	\N
1326	2023-08-03 06:32:34.123168	2023-08-03 06:32:34.123168	Saturday	2045	100	189	\N	\N	\N	\N
1327	2023-08-03 06:32:34.124598	2023-08-03 06:32:34.124598	Sunday	1700	230	189	\N	\N	\N	\N
1328	2023-08-03 06:32:34.146372	2023-08-03 06:32:34.146372	Monday	1130	1545	190	\N	\N	\N	\N
1329	2023-08-03 06:32:34.147979	2023-08-03 06:32:34.147979	Monday	2245	930	190	\N	\N	\N	\N
1330	2023-08-03 06:32:34.149422	2023-08-03 06:32:34.149422	Tuesday	630	1930	190	\N	\N	\N	\N
1331	2023-08-03 06:32:34.151072	2023-08-03 06:32:34.151072	Wednesday	545	615	190	\N	\N	\N	\N
1332	2023-08-03 06:32:34.152585	2023-08-03 06:32:34.152585	Wednesday	800	1200	190	\N	\N	\N	\N
1333	2023-08-03 06:32:34.154191	2023-08-03 06:32:34.154191	Thursday	1915	100	190	\N	\N	\N	\N
1334	2023-08-03 06:32:34.155749	2023-08-03 06:32:34.155749	Friday	715	2145	190	\N	\N	\N	\N
1335	2023-08-03 06:32:34.157167	2023-08-03 06:32:34.157167	Saturday	2215	315	190	\N	\N	\N	\N
1336	2023-08-03 06:32:34.158676	2023-08-03 06:32:34.158676	Sunday	645	2345	190	\N	\N	\N	\N
1337	2023-08-03 06:32:34.169024	2023-08-03 06:32:34.169024	Monday	930	1645	191	\N	\N	\N	\N
1338	2023-08-03 06:32:34.170797	2023-08-03 06:32:34.170797	Tuesday	845	915	191	\N	\N	\N	\N
1339	2023-08-03 06:32:34.172251	2023-08-03 06:32:34.172251	Tuesday	2130	2300	191	\N	\N	\N	\N
1340	2023-08-03 06:32:34.173737	2023-08-03 06:32:34.173737	Wednesday	615	2330	191	\N	\N	\N	\N
1341	2023-08-03 06:32:34.175152	2023-08-03 06:32:34.175152	Thursday	800	1415	191	\N	\N	\N	\N
1342	2023-08-03 06:32:34.17684	2023-08-03 06:32:34.17684	Friday	1800	115	191	\N	\N	\N	\N
1343	2023-08-03 06:32:34.178255	2023-08-03 06:32:34.178255	Saturday	730	1630	191	\N	\N	\N	\N
1344	2023-08-03 06:32:34.198677	2023-08-03 06:32:34.198677	Monday	1000	1415	192	\N	\N	\N	\N
1345	2023-08-03 06:32:34.200079	2023-08-03 06:32:34.200079	Tuesday	200	945	192	\N	\N	\N	\N
1346	2023-08-03 06:32:34.201467	2023-08-03 06:32:34.201467	Tuesday	2030	2145	192	\N	\N	\N	\N
1347	2023-08-03 06:32:34.203065	2023-08-03 06:32:34.203065	Wednesday	730	1945	192	\N	\N	\N	\N
1348	2023-08-03 06:32:34.204959	2023-08-03 06:32:34.204959	Thursday	315	815	192	\N	\N	\N	\N
1349	2023-08-03 06:32:34.206386	2023-08-03 06:32:34.206386	Thursday	1000	1130	192	\N	\N	\N	\N
1350	2023-08-03 06:32:34.207871	2023-08-03 06:32:34.207871	Friday	945	2015	192	\N	\N	\N	\N
1351	2023-08-03 06:32:34.209293	2023-08-03 06:32:34.209293	Saturday	845	1300	192	\N	\N	\N	\N
1352	2023-08-03 06:32:34.210772	2023-08-03 06:32:34.210772	Saturday	1830	700	192	\N	\N	\N	\N
1353	2023-08-03 06:32:34.220738	2023-08-03 06:32:34.220738	Monday	900	1515	193	\N	\N	\N	\N
1354	2023-08-03 06:32:34.222281	2023-08-03 06:32:34.222281	Tuesday	900	1630	193	\N	\N	\N	\N
1355	2023-08-03 06:32:34.223768	2023-08-03 06:32:34.223768	Wednesday	630	1930	193	\N	\N	\N	\N
1356	2023-08-03 06:32:34.225277	2023-08-03 06:32:34.225277	Thursday	830	1415	193	\N	\N	\N	\N
1357	2023-08-03 06:32:34.226857	2023-08-03 06:32:34.226857	Friday	630	1145	193	\N	\N	\N	\N
1358	2023-08-03 06:32:34.228219	2023-08-03 06:32:34.228219	Friday	1715	2115	193	\N	\N	\N	\N
1359	2023-08-03 06:32:34.229598	2023-08-03 06:32:34.229598	Saturday	630	1400	193	\N	\N	\N	\N
1360	2023-08-03 06:32:34.231143	2023-08-03 06:32:34.231143	Sunday	745	1415	193	\N	\N	\N	\N
1361	2023-08-03 06:32:34.252686	2023-08-03 06:32:34.252686	Monday	830	1930	194	\N	\N	\N	\N
1362	2023-08-03 06:32:34.254075	2023-08-03 06:32:34.254075	Tuesday	1000	2315	194	\N	\N	\N	\N
1363	2023-08-03 06:32:34.255498	2023-08-03 06:32:34.255498	Thursday	815	1415	194	\N	\N	\N	\N
1364	2023-08-03 06:32:34.257233	2023-08-03 06:32:34.257233	Thursday	1445	2400	194	\N	\N	\N	\N
1365	2023-08-03 06:32:34.258647	2023-08-03 06:32:34.258647	Friday	1045	1100	194	\N	\N	\N	\N
1366	2023-08-03 06:32:34.259964	2023-08-03 06:32:34.259964	Friday	1630	1730	194	\N	\N	\N	\N
1367	2023-08-03 06:32:34.261407	2023-08-03 06:32:34.261407	Saturday	630	1915	194	\N	\N	\N	\N
1368	2023-08-03 06:32:34.262811	2023-08-03 06:32:34.262811	Sunday	1500	130	194	\N	\N	\N	\N
1369	2023-08-03 06:32:34.27335	2023-08-03 06:32:34.27335	Monday	1000	2245	195	\N	\N	\N	\N
1370	2023-08-03 06:32:34.274768	2023-08-03 06:32:34.274768	Tuesday	1115	1500	195	\N	\N	\N	\N
1371	2023-08-03 06:32:34.276177	2023-08-03 06:32:34.276177	Tuesday	1600	1730	195	\N	\N	\N	\N
1372	2023-08-03 06:32:34.277619	2023-08-03 06:32:34.277619	Thursday	230	730	195	\N	\N	\N	\N
1373	2023-08-03 06:32:34.279018	2023-08-03 06:32:34.279018	Thursday	845	1400	195	\N	\N	\N	\N
1374	2023-08-03 06:32:34.280419	2023-08-03 06:32:34.280419	Friday	730	2115	195	\N	\N	\N	\N
1375	2023-08-03 06:32:34.282028	2023-08-03 06:32:34.282028	Saturday	215	345	195	\N	\N	\N	\N
1376	2023-08-03 06:32:34.283398	2023-08-03 06:32:34.283398	Saturday	845	1400	195	\N	\N	\N	\N
1377	2023-08-03 06:32:34.284812	2023-08-03 06:32:34.284812	Sunday	130	230	195	\N	\N	\N	\N
1378	2023-08-03 06:32:34.286203	2023-08-03 06:32:34.286203	Sunday	515	1115	195	\N	\N	\N	\N
1379	2023-08-03 06:32:34.303391	2023-08-03 06:32:34.303391	Monday	615	2100	196	\N	\N	\N	\N
1380	2023-08-03 06:32:34.304773	2023-08-03 06:32:34.304773	Tuesday	600	2130	196	\N	\N	\N	\N
1381	2023-08-03 06:32:34.306158	2023-08-03 06:32:34.306158	Thursday	715	2000	196	\N	\N	\N	\N
1382	2023-08-03 06:32:34.307736	2023-08-03 06:32:34.307736	Saturday	1645	315	196	\N	\N	\N	\N
1383	2023-08-03 06:32:34.309115	2023-08-03 06:32:34.309115	Sunday	830	1400	196	\N	\N	\N	\N
1384	2023-08-03 06:32:34.330822	2023-08-03 06:32:34.330822	Monday	145	2045	197	\N	\N	\N	\N
1385	2023-08-03 06:32:34.332238	2023-08-03 06:32:34.332238	Monday	2145	100	197	\N	\N	\N	\N
1386	2023-08-03 06:32:34.333969	2023-08-03 06:32:34.333969	Tuesday	745	2245	197	\N	\N	\N	\N
1387	2023-08-03 06:32:34.335419	2023-08-03 06:32:34.335419	Wednesday	830	1930	197	\N	\N	\N	\N
1388	2023-08-03 06:32:34.336834	2023-08-03 06:32:34.336834	Thursday	745	2300	197	\N	\N	\N	\N
1389	2023-08-03 06:32:34.338285	2023-08-03 06:32:34.338285	Friday	2230	100	197	\N	\N	\N	\N
1390	2023-08-03 06:32:34.339653	2023-08-03 06:32:34.339653	Saturday	800	2300	197	\N	\N	\N	\N
1391	2023-08-03 06:32:34.341061	2023-08-03 06:32:34.341061	Sunday	600	2300	197	\N	\N	\N	\N
1392	2023-08-03 06:32:34.351925	2023-08-03 06:32:34.351925	Tuesday	2115	330	198	\N	\N	\N	\N
1393	2023-08-03 06:32:34.353341	2023-08-03 06:32:34.353341	Wednesday	600	1900	198	\N	\N	\N	\N
1394	2023-08-03 06:32:34.354823	2023-08-03 06:32:34.354823	Friday	1715	2045	198	\N	\N	\N	\N
1395	2023-08-03 06:32:34.35639	2023-08-03 06:32:34.35639	Friday	2245	1415	198	\N	\N	\N	\N
1396	2023-08-03 06:32:34.357865	2023-08-03 06:32:34.357865	Saturday	645	1400	198	\N	\N	\N	\N
1397	2023-08-03 06:32:34.35935	2023-08-03 06:32:34.35935	Sunday	300	445	198	\N	\N	\N	\N
1398	2023-08-03 06:32:34.360709	2023-08-03 06:32:34.360709	Sunday	845	1130	198	\N	\N	\N	\N
1399	2023-08-03 06:32:34.377989	2023-08-03 06:32:34.377989	Monday	645	1945	199	\N	\N	\N	\N
1400	2023-08-03 06:32:34.379406	2023-08-03 06:32:34.379406	Wednesday	30	115	199	\N	\N	\N	\N
1401	2023-08-03 06:32:34.38083	2023-08-03 06:32:34.38083	Wednesday	345	1915	199	\N	\N	\N	\N
1402	2023-08-03 06:32:34.382327	2023-08-03 06:32:34.382327	Thursday	800	2215	199	\N	\N	\N	\N
1403	2023-08-03 06:32:34.384114	2023-08-03 06:32:34.384114	Friday	800	1415	199	\N	\N	\N	\N
1404	2023-08-03 06:32:34.385633	2023-08-03 06:32:34.385633	Saturday	945	1815	199	\N	\N	\N	\N
1405	2023-08-03 06:32:34.387089	2023-08-03 06:32:34.387089	Sunday	230	1300	199	\N	\N	\N	\N
1406	2023-08-03 06:32:34.38851	2023-08-03 06:32:34.38851	Sunday	1945	2400	199	\N	\N	\N	\N
1407	2023-08-03 06:32:34.409425	2023-08-03 06:32:34.409425	Monday	0	530	200	\N	\N	\N	\N
1408	2023-08-03 06:32:34.410927	2023-08-03 06:32:34.410927	Monday	700	2400	200	\N	\N	\N	\N
1409	2023-08-03 06:32:34.412396	2023-08-03 06:32:34.412396	Tuesday	745	1700	200	\N	\N	\N	\N
1410	2023-08-03 06:32:34.41377	2023-08-03 06:32:34.41377	Wednesday	815	1630	200	\N	\N	\N	\N
1411	2023-08-03 06:32:34.415122	2023-08-03 06:32:34.415122	Thursday	800	1415	200	\N	\N	\N	\N
1412	2023-08-03 06:32:34.416562	2023-08-03 06:32:34.416562	Saturday	830	2015	200	\N	\N	\N	\N
1413	2023-08-03 06:32:34.417935	2023-08-03 06:32:34.417935	Sunday	845	1500	200	\N	\N	\N	\N
1414	2023-08-03 06:32:34.428193	2023-08-03 06:32:34.428193	Monday	615	2315	201	\N	\N	\N	\N
1415	2023-08-03 06:32:34.429751	2023-08-03 06:32:34.429751	Tuesday	130	200	201	\N	\N	\N	\N
1416	2023-08-03 06:32:34.431155	2023-08-03 06:32:34.431155	Tuesday	930	1715	201	\N	\N	\N	\N
1417	2023-08-03 06:32:34.432615	2023-08-03 06:32:34.432615	Wednesday	2115	300	201	\N	\N	\N	\N
1418	2023-08-03 06:32:34.434123	2023-08-03 06:32:34.434123	Saturday	845	1900	201	\N	\N	\N	\N
1419	2023-08-03 06:32:34.451312	2023-08-03 06:32:34.451312	Monday	1000	2330	202	\N	\N	\N	\N
1420	2023-08-03 06:32:34.452853	2023-08-03 06:32:34.452853	Tuesday	930	2115	202	\N	\N	\N	\N
1421	2023-08-03 06:32:34.45443	2023-08-03 06:32:34.45443	Wednesday	615	730	202	\N	\N	\N	\N
1422	2023-08-03 06:32:34.455878	2023-08-03 06:32:34.455878	Wednesday	815	2000	202	\N	\N	\N	\N
1423	2023-08-03 06:32:34.457302	2023-08-03 06:32:34.457302	Thursday	1445	345	202	\N	\N	\N	\N
1424	2023-08-03 06:32:34.458754	2023-08-03 06:32:34.458754	Friday	1515	200	202	\N	\N	\N	\N
1425	2023-08-03 06:32:34.460229	2023-08-03 06:32:34.460229	Saturday	715	1430	202	\N	\N	\N	\N
1426	2023-08-03 06:32:34.480069	2023-08-03 06:32:34.480069	Wednesday	145	1945	203	\N	\N	\N	\N
1427	2023-08-03 06:32:34.481719	2023-08-03 06:32:34.481719	Wednesday	2200	2300	203	\N	\N	\N	\N
1428	2023-08-03 06:32:34.483066	2023-08-03 06:32:34.483066	Thursday	45	945	203	\N	\N	\N	\N
1429	2023-08-03 06:32:34.484512	2023-08-03 06:32:34.484512	Thursday	1730	1915	203	\N	\N	\N	\N
1430	2023-08-03 06:32:34.485927	2023-08-03 06:32:34.485927	Friday	1430	1930	203	\N	\N	\N	\N
1431	2023-08-03 06:32:34.487459	2023-08-03 06:32:34.487459	Friday	2145	330	203	\N	\N	\N	\N
1432	2023-08-03 06:32:34.488835	2023-08-03 06:32:34.488835	Saturday	1000	1900	203	\N	\N	\N	\N
1433	2023-08-03 06:32:34.490202	2023-08-03 06:32:34.490202	Sunday	830	1630	203	\N	\N	\N	\N
1434	2023-08-03 06:32:34.499188	2023-08-03 06:32:34.499188	Monday	1815	245	204	\N	\N	\N	\N
1435	2023-08-03 06:32:34.500604	2023-08-03 06:32:34.500604	Tuesday	1000	2345	204	\N	\N	\N	\N
1436	2023-08-03 06:32:34.501924	2023-08-03 06:32:34.501924	Wednesday	700	2015	204	\N	\N	\N	\N
1437	2023-08-03 06:32:34.503292	2023-08-03 06:32:34.503292	Thursday	530	1000	204	\N	\N	\N	\N
1438	2023-08-03 06:32:34.504629	2023-08-03 06:32:34.504629	Thursday	1315	2230	204	\N	\N	\N	\N
1439	2023-08-03 06:32:34.506041	2023-08-03 06:32:34.506041	Friday	1515	330	204	\N	\N	\N	\N
1440	2023-08-03 06:32:34.507485	2023-08-03 06:32:34.507485	Saturday	930	1645	204	\N	\N	\N	\N
1441	2023-08-03 06:32:34.508854	2023-08-03 06:32:34.508854	Sunday	1500	115	204	\N	\N	\N	\N
1442	2023-08-03 06:32:34.531623	2023-08-03 06:32:34.531623	Monday	730	2130	205	\N	\N	\N	\N
1443	2023-08-03 06:32:34.533066	2023-08-03 06:32:34.533066	Thursday	745	1000	205	\N	\N	\N	\N
1444	2023-08-03 06:32:34.534506	2023-08-03 06:32:34.534506	Thursday	1330	1915	205	\N	\N	\N	\N
1445	2023-08-03 06:32:34.535887	2023-08-03 06:32:34.535887	Friday	2100	400	205	\N	\N	\N	\N
1446	2023-08-03 06:32:34.537297	2023-08-03 06:32:34.537297	Saturday	715	1930	205	\N	\N	\N	\N
1447	2023-08-03 06:32:34.538809	2023-08-03 06:32:34.538809	Sunday	630	2030	205	\N	\N	\N	\N
1448	2023-08-03 06:32:34.549595	2023-08-03 06:32:34.549595	Monday	315	1145	206	\N	\N	\N	\N
1449	2023-08-03 06:32:34.551068	2023-08-03 06:32:34.551068	Monday	1800	2045	206	\N	\N	\N	\N
1450	2023-08-03 06:32:34.552723	2023-08-03 06:32:34.552723	Tuesday	915	2115	206	\N	\N	\N	\N
1451	2023-08-03 06:32:34.554131	2023-08-03 06:32:34.554131	Wednesday	915	1400	206	\N	\N	\N	\N
1452	2023-08-03 06:32:34.555588	2023-08-03 06:32:34.555588	Thursday	745	2130	206	\N	\N	\N	\N
1453	2023-08-03 06:32:34.557014	2023-08-03 06:32:34.557014	Friday	800	1630	206	\N	\N	\N	\N
1454	2023-08-03 06:32:34.558368	2023-08-03 06:32:34.558368	Friday	1800	700	206	\N	\N	\N	\N
1455	2023-08-03 06:32:34.559893	2023-08-03 06:32:34.559893	Saturday	915	1645	206	\N	\N	\N	\N
1456	2023-08-03 06:32:34.561332	2023-08-03 06:32:34.561332	Sunday	1830	215	206	\N	\N	\N	\N
1457	2023-08-03 06:32:34.578749	2023-08-03 06:32:34.578749	Monday	1000	1430	207	\N	\N	\N	\N
1458	2023-08-03 06:32:34.580231	2023-08-03 06:32:34.580231	Tuesday	700	1830	207	\N	\N	\N	\N
1459	2023-08-03 06:32:34.581649	2023-08-03 06:32:34.581649	Thursday	1530	100	207	\N	\N	\N	\N
1460	2023-08-03 06:32:34.585077	2023-08-03 06:32:34.585077	Friday	1000	1730	207	\N	\N	\N	\N
1461	2023-08-03 06:32:34.586602	2023-08-03 06:32:34.586602	Saturday	1045	2045	207	\N	\N	\N	\N
1462	2023-08-03 06:32:34.588114	2023-08-03 06:32:34.588114	Saturday	2130	2300	207	\N	\N	\N	\N
1463	2023-08-03 06:32:34.589532	2023-08-03 06:32:34.589532	Sunday	745	1900	207	\N	\N	\N	\N
1464	2023-08-03 06:32:34.609967	2023-08-03 06:32:34.609967	Monday	400	1215	208	\N	\N	\N	\N
1465	2023-08-03 06:32:34.611526	2023-08-03 06:32:34.611526	Monday	1730	2215	208	\N	\N	\N	\N
1466	2023-08-03 06:32:34.613044	2023-08-03 06:32:34.613044	Tuesday	930	2245	208	\N	\N	\N	\N
1467	2023-08-03 06:32:34.61455	2023-08-03 06:32:34.61455	Thursday	845	2045	208	\N	\N	\N	\N
1468	2023-08-03 06:32:34.61594	2023-08-03 06:32:34.61594	Friday	815	1645	208	\N	\N	\N	\N
1469	2023-08-03 06:32:34.617311	2023-08-03 06:32:34.617311	Sunday	845	2245	208	\N	\N	\N	\N
1470	2023-08-03 06:32:34.627323	2023-08-03 06:32:34.627323	Monday	600	2045	209	\N	\N	\N	\N
1471	2023-08-03 06:32:34.628714	2023-08-03 06:32:34.628714	Tuesday	615	2045	209	\N	\N	\N	\N
1472	2023-08-03 06:32:34.630024	2023-08-03 06:32:34.630024	Wednesday	1700	345	209	\N	\N	\N	\N
1473	2023-08-03 06:32:34.631465	2023-08-03 06:32:34.631465	Thursday	600	1730	209	\N	\N	\N	\N
1474	2023-08-03 06:32:34.63314	2023-08-03 06:32:34.63314	Friday	945	1730	209	\N	\N	\N	\N
1475	2023-08-03 06:32:34.63464	2023-08-03 06:32:34.63464	Sunday	600	1215	209	\N	\N	\N	\N
1476	2023-08-03 06:32:34.636088	2023-08-03 06:32:34.636088	Sunday	1745	2000	209	\N	\N	\N	\N
1477	2023-08-03 06:32:34.661896	2023-08-03 06:32:34.661896	Monday	630	1530	210	\N	\N	\N	\N
1478	2023-08-03 06:32:34.663438	2023-08-03 06:32:34.663438	Tuesday	900	1530	210	\N	\N	\N	\N
1479	2023-08-03 06:32:34.665	2023-08-03 06:32:34.665	Wednesday	1700	400	210	\N	\N	\N	\N
1480	2023-08-03 06:32:34.666476	2023-08-03 06:32:34.666476	Thursday	630	2345	210	\N	\N	\N	\N
1481	2023-08-03 06:32:34.667896	2023-08-03 06:32:34.667896	Friday	945	1315	210	\N	\N	\N	\N
1482	2023-08-03 06:32:34.669266	2023-08-03 06:32:34.669266	Friday	1445	1515	210	\N	\N	\N	\N
1483	2023-08-03 06:32:34.670726	2023-08-03 06:32:34.670726	Saturday	30	530	210	\N	\N	\N	\N
1484	2023-08-03 06:32:34.672084	2023-08-03 06:32:34.672084	Saturday	1700	2000	210	\N	\N	\N	\N
1485	2023-08-03 06:32:34.683992	2023-08-03 06:32:34.683992	Monday	630	1715	211	\N	\N	\N	\N
1486	2023-08-03 06:32:34.68574	2023-08-03 06:32:34.68574	Tuesday	200	345	211	\N	\N	\N	\N
1487	2023-08-03 06:32:34.687469	2023-08-03 06:32:34.687469	Tuesday	515	2245	211	\N	\N	\N	\N
1488	2023-08-03 06:32:34.689022	2023-08-03 06:32:34.689022	Wednesday	715	2030	211	\N	\N	\N	\N
1489	2023-08-03 06:32:34.690971	2023-08-03 06:32:34.690971	Thursday	815	2315	211	\N	\N	\N	\N
1490	2023-08-03 06:32:34.692686	2023-08-03 06:32:34.692686	Saturday	345	415	211	\N	\N	\N	\N
1491	2023-08-03 06:32:34.694182	2023-08-03 06:32:34.694182	Saturday	800	30	211	\N	\N	\N	\N
1492	2023-08-03 06:32:34.695748	2023-08-03 06:32:34.695748	Sunday	2000	400	211	\N	\N	\N	\N
1493	2023-08-03 06:32:34.717201	2023-08-03 06:32:34.717201	Monday	230	915	212	\N	\N	\N	\N
1494	2023-08-03 06:32:34.718836	2023-08-03 06:32:34.718836	Monday	1615	100	212	\N	\N	\N	\N
1495	2023-08-03 06:32:34.720298	2023-08-03 06:32:34.720298	Tuesday	930	1915	212	\N	\N	\N	\N
1496	2023-08-03 06:32:34.721827	2023-08-03 06:32:34.721827	Wednesday	815	2030	212	\N	\N	\N	\N
1497	2023-08-03 06:32:34.723202	2023-08-03 06:32:34.723202	Thursday	645	2245	212	\N	\N	\N	\N
1498	2023-08-03 06:32:34.724715	2023-08-03 06:32:34.724715	Friday	130	430	212	\N	\N	\N	\N
1499	2023-08-03 06:32:34.726202	2023-08-03 06:32:34.726202	Friday	545	1315	212	\N	\N	\N	\N
1500	2023-08-03 06:32:34.72761	2023-08-03 06:32:34.72761	Saturday	700	1215	212	\N	\N	\N	\N
1501	2023-08-03 06:32:34.72889	2023-08-03 06:32:34.72889	Saturday	2300	15	212	\N	\N	\N	\N
1502	2023-08-03 06:32:34.730245	2023-08-03 06:32:34.730245	Sunday	715	1745	212	\N	\N	\N	\N
1503	2023-08-03 06:32:34.740361	2023-08-03 06:32:34.740361	Monday	630	1545	213	\N	\N	\N	\N
1504	2023-08-03 06:32:34.741799	2023-08-03 06:32:34.741799	Monday	1930	330	213	\N	\N	\N	\N
1505	2023-08-03 06:32:34.743196	2023-08-03 06:32:34.743196	Wednesday	930	2300	213	\N	\N	\N	\N
1506	2023-08-03 06:32:34.745245	2023-08-03 06:32:34.745245	Thursday	700	1430	213	\N	\N	\N	\N
1507	2023-08-03 06:32:34.747143	2023-08-03 06:32:34.747143	Saturday	830	1515	213	\N	\N	\N	\N
1508	2023-08-03 06:32:34.7491	2023-08-03 06:32:34.7491	Sunday	815	2230	213	\N	\N	\N	\N
1509	2023-08-03 06:32:34.776441	2023-08-03 06:32:34.776441	Monday	830	1500	214	\N	\N	\N	\N
1510	2023-08-03 06:32:34.778333	2023-08-03 06:32:34.778333	Tuesday	645	1645	214	\N	\N	\N	\N
1511	2023-08-03 06:32:34.780177	2023-08-03 06:32:34.780177	Wednesday	700	1900	214	\N	\N	\N	\N
1512	2023-08-03 06:32:34.78163	2023-08-03 06:32:34.78163	Thursday	845	1700	214	\N	\N	\N	\N
1513	2023-08-03 06:32:34.783048	2023-08-03 06:32:34.783048	Saturday	600	2215	214	\N	\N	\N	\N
1514	2023-08-03 06:32:34.79315	2023-08-03 06:32:34.79315	Monday	745	2015	215	\N	\N	\N	\N
1515	2023-08-03 06:32:34.794842	2023-08-03 06:32:34.794842	Tuesday	715	1730	215	\N	\N	\N	\N
1516	2023-08-03 06:32:34.796262	2023-08-03 06:32:34.796262	Wednesday	715	2000	215	\N	\N	\N	\N
1517	2023-08-03 06:32:34.79772	2023-08-03 06:32:34.79772	Thursday	930	1700	215	\N	\N	\N	\N
1518	2023-08-03 06:32:34.799374	2023-08-03 06:32:34.799374	Friday	115	2000	215	\N	\N	\N	\N
1519	2023-08-03 06:32:34.800919	2023-08-03 06:32:34.800919	Friday	2245	2400	215	\N	\N	\N	\N
1520	2023-08-03 06:32:34.802554	2023-08-03 06:32:34.802554	Saturday	2230	315	215	\N	\N	\N	\N
1521	2023-08-03 06:32:34.804088	2023-08-03 06:32:34.804088	Sunday	300	1215	215	\N	\N	\N	\N
1522	2023-08-03 06:32:34.805614	2023-08-03 06:32:34.805614	Sunday	1630	200	215	\N	\N	\N	\N
1523	2023-08-03 06:32:34.822275	2023-08-03 06:32:34.822275	Monday	915	1400	216	\N	\N	\N	\N
1524	2023-08-03 06:32:34.823652	2023-08-03 06:32:34.823652	Thursday	900	2200	216	\N	\N	\N	\N
1525	2023-08-03 06:32:34.825419	2023-08-03 06:32:34.825419	Friday	15	1700	216	\N	\N	\N	\N
1526	2023-08-03 06:32:34.826898	2023-08-03 06:32:34.826898	Friday	1845	2215	216	\N	\N	\N	\N
1527	2023-08-03 06:32:34.828376	2023-08-03 06:32:34.828376	Sunday	1545	400	216	\N	\N	\N	\N
1528	2023-08-03 06:32:34.850956	2023-08-03 06:32:34.850956	Monday	915	2045	217	\N	\N	\N	\N
1529	2023-08-03 06:32:34.852407	2023-08-03 06:32:34.852407	Tuesday	830	1645	217	\N	\N	\N	\N
1530	2023-08-03 06:32:34.853843	2023-08-03 06:32:34.853843	Wednesday	900	1545	217	\N	\N	\N	\N
1531	2023-08-03 06:32:34.855257	2023-08-03 06:32:34.855257	Thursday	700	745	217	\N	\N	\N	\N
1532	2023-08-03 06:32:34.85662	2023-08-03 06:32:34.85662	Thursday	1800	130	217	\N	\N	\N	\N
1533	2023-08-03 06:32:34.858042	2023-08-03 06:32:34.858042	Friday	2100	330	217	\N	\N	\N	\N
1534	2023-08-03 06:32:34.859529	2023-08-03 06:32:34.859529	Saturday	615	1230	217	\N	\N	\N	\N
1535	2023-08-03 06:32:34.860873	2023-08-03 06:32:34.860873	Saturday	1945	530	217	\N	\N	\N	\N
1536	2023-08-03 06:32:34.862535	2023-08-03 06:32:34.862535	Sunday	615	645	217	\N	\N	\N	\N
1537	2023-08-03 06:32:34.863962	2023-08-03 06:32:34.863962	Sunday	1715	315	217	\N	\N	\N	\N
1538	2023-08-03 06:32:34.877749	2023-08-03 06:32:34.877749	Monday	600	1615	218	\N	\N	\N	\N
1539	2023-08-03 06:32:34.880273	2023-08-03 06:32:34.880273	Tuesday	1000	1545	218	\N	\N	\N	\N
1540	2023-08-03 06:32:34.882683	2023-08-03 06:32:34.882683	Wednesday	745	1400	218	\N	\N	\N	\N
1541	2023-08-03 06:32:34.884842	2023-08-03 06:32:34.884842	Friday	130	1630	218	\N	\N	\N	\N
1542	2023-08-03 06:32:34.887381	2023-08-03 06:32:34.887381	Friday	1945	2200	218	\N	\N	\N	\N
1543	2023-08-03 06:32:34.88971	2023-08-03 06:32:34.88971	Saturday	830	2315	218	\N	\N	\N	\N
1544	2023-08-03 06:32:34.895696	2023-08-03 06:32:34.895696	Sunday	1800	230	218	\N	\N	\N	\N
1545	2023-08-03 06:32:34.923745	2023-08-03 06:32:34.923745	Monday	1945	145	219	\N	\N	\N	\N
1546	2023-08-03 06:32:34.926027	2023-08-03 06:32:34.926027	Tuesday	115	745	219	\N	\N	\N	\N
1547	2023-08-03 06:32:34.933252	2023-08-03 06:32:34.933252	Tuesday	915	2115	219	\N	\N	\N	\N
1548	2023-08-03 06:32:34.951682	2023-08-03 06:32:34.951682	Wednesday	1400	1430	219	\N	\N	\N	\N
1549	2023-08-03 06:32:34.955054	2023-08-03 06:32:34.955054	Wednesday	1630	2230	219	\N	\N	\N	\N
1550	2023-08-03 06:32:34.957331	2023-08-03 06:32:34.957331	Thursday	715	1800	219	\N	\N	\N	\N
1551	2023-08-03 06:32:34.959401	2023-08-03 06:32:34.959401	Friday	230	330	219	\N	\N	\N	\N
1552	2023-08-03 06:32:34.961771	2023-08-03 06:32:34.961771	Friday	415	915	219	\N	\N	\N	\N
1553	2023-08-03 06:32:34.964045	2023-08-03 06:32:34.964045	Saturday	145	730	219	\N	\N	\N	\N
1554	2023-08-03 06:32:34.966732	2023-08-03 06:32:34.966732	Saturday	1315	1630	219	\N	\N	\N	\N
1555	2023-08-03 06:32:34.969531	2023-08-03 06:32:34.969531	Sunday	1945	145	219	\N	\N	\N	\N
1556	2023-08-03 06:32:34.982956	2023-08-03 06:32:34.982956	Monday	1115	1145	220	\N	\N	\N	\N
1557	2023-08-03 06:32:34.984813	2023-08-03 06:32:34.984813	Monday	1715	2100	220	\N	\N	\N	\N
1558	2023-08-03 06:32:34.986495	2023-08-03 06:32:34.986495	Tuesday	1245	1630	220	\N	\N	\N	\N
1559	2023-08-03 06:32:34.988376	2023-08-03 06:32:34.988376	Tuesday	1715	2330	220	\N	\N	\N	\N
1560	2023-08-03 06:32:34.990275	2023-08-03 06:32:34.990275	Thursday	715	815	220	\N	\N	\N	\N
1561	2023-08-03 06:32:34.992151	2023-08-03 06:32:34.992151	Thursday	1915	2045	220	\N	\N	\N	\N
1562	2023-08-03 06:32:34.994115	2023-08-03 06:32:34.994115	Friday	800	1515	220	\N	\N	\N	\N
1563	2023-08-03 06:32:34.995939	2023-08-03 06:32:34.995939	Saturday	800	1615	220	\N	\N	\N	\N
1564	2023-08-03 06:32:34.998279	2023-08-03 06:32:34.998279	Sunday	0	200	220	\N	\N	\N	\N
1565	2023-08-03 06:32:34.999984	2023-08-03 06:32:34.999984	Sunday	545	745	220	\N	\N	\N	\N
1566	2023-08-03 06:32:35.023772	2023-08-03 06:32:35.023772	Monday	830	2100	221	\N	\N	\N	\N
1567	2023-08-03 06:32:35.025831	2023-08-03 06:32:35.025831	Wednesday	1030	1300	221	\N	\N	\N	\N
1568	2023-08-03 06:32:35.027722	2023-08-03 06:32:35.027722	Wednesday	1445	1945	221	\N	\N	\N	\N
1569	2023-08-03 06:32:35.029418	2023-08-03 06:32:35.029418	Thursday	945	1400	221	\N	\N	\N	\N
1570	2023-08-03 06:32:35.031204	2023-08-03 06:32:35.031204	Friday	915	2400	221	\N	\N	\N	\N
1571	2023-08-03 06:32:35.033224	2023-08-03 06:32:35.033224	Saturday	915	1515	221	\N	\N	\N	\N
1572	2023-08-03 06:32:35.035288	2023-08-03 06:32:35.035288	Sunday	815	1900	221	\N	\N	\N	\N
1573	2023-08-03 06:32:35.059606	2023-08-03 06:32:35.059606	Monday	115	845	222	\N	\N	\N	\N
1574	2023-08-03 06:32:35.06115	2023-08-03 06:32:35.06115	Monday	1145	1600	222	\N	\N	\N	\N
1575	2023-08-03 06:32:35.062671	2023-08-03 06:32:35.062671	Tuesday	645	2000	222	\N	\N	\N	\N
1576	2023-08-03 06:32:35.064589	2023-08-03 06:32:35.064589	Wednesday	1800	215	222	\N	\N	\N	\N
1577	2023-08-03 06:32:35.066055	2023-08-03 06:32:35.066055	Thursday	1700	345	222	\N	\N	\N	\N
1578	2023-08-03 06:32:35.06754	2023-08-03 06:32:35.06754	Friday	800	2315	222	\N	\N	\N	\N
1579	2023-08-03 06:32:35.068969	2023-08-03 06:32:35.068969	Saturday	1915	345	222	\N	\N	\N	\N
1580	2023-08-03 06:32:35.070363	2023-08-03 06:32:35.070363	Sunday	1000	2245	222	\N	\N	\N	\N
1581	2023-08-03 06:32:35.081244	2023-08-03 06:32:35.081244	Monday	815	1630	223	\N	\N	\N	\N
1582	2023-08-03 06:32:35.082746	2023-08-03 06:32:35.082746	Tuesday	745	2030	223	\N	\N	\N	\N
1583	2023-08-03 06:32:35.084213	2023-08-03 06:32:35.084213	Wednesday	630	1745	223	\N	\N	\N	\N
1584	2023-08-03 06:32:35.085699	2023-08-03 06:32:35.085699	Thursday	615	1600	223	\N	\N	\N	\N
1585	2023-08-03 06:32:35.087189	2023-08-03 06:32:35.087189	Saturday	630	2115	223	\N	\N	\N	\N
1586	2023-08-03 06:32:35.088739	2023-08-03 06:32:35.088739	Sunday	615	1600	223	\N	\N	\N	\N
1587	2023-08-03 06:32:35.109268	2023-08-03 06:32:35.109268	Monday	715	1745	224	\N	\N	\N	\N
1588	2023-08-03 06:32:35.110671	2023-08-03 06:32:35.110671	Tuesday	1500	200	224	\N	\N	\N	\N
1589	2023-08-03 06:32:35.112152	2023-08-03 06:32:35.112152	Wednesday	1000	2045	224	\N	\N	\N	\N
1590	2023-08-03 06:32:35.113707	2023-08-03 06:32:35.113707	Thursday	915	1415	224	\N	\N	\N	\N
1591	2023-08-03 06:32:35.115061	2023-08-03 06:32:35.115061	Thursday	1700	530	224	\N	\N	\N	\N
1592	2023-08-03 06:32:35.116717	2023-08-03 06:32:35.116717	Friday	615	2000	224	\N	\N	\N	\N
1593	2023-08-03 06:32:35.118009	2023-08-03 06:32:35.118009	Saturday	745	2030	224	\N	\N	\N	\N
1594	2023-08-03 06:32:35.119331	2023-08-03 06:32:35.119331	Sunday	1930	215	224	\N	\N	\N	\N
1595	2023-08-03 06:32:35.128646	2023-08-03 06:32:35.128646	Monday	915	1500	225	\N	\N	\N	\N
1596	2023-08-03 06:32:35.130532	2023-08-03 06:32:35.130532	Friday	800	1945	225	\N	\N	\N	\N
1597	2023-08-03 06:32:35.132063	2023-08-03 06:32:35.132063	Saturday	645	1830	225	\N	\N	\N	\N
1598	2023-08-03 06:32:35.133585	2023-08-03 06:32:35.133585	Sunday	945	1430	225	\N	\N	\N	\N
1599	2023-08-03 06:32:35.1502	2023-08-03 06:32:35.1502	Monday	600	645	226	\N	\N	\N	\N
1600	2023-08-03 06:32:35.151619	2023-08-03 06:32:35.151619	Monday	1400	2200	226	\N	\N	\N	\N
1601	2023-08-03 06:32:35.153053	2023-08-03 06:32:35.153053	Tuesday	915	2145	226	\N	\N	\N	\N
1602	2023-08-03 06:32:35.154534	2023-08-03 06:32:35.154534	Thursday	800	1800	226	\N	\N	\N	\N
1603	2023-08-03 06:32:35.15677	2023-08-03 06:32:35.15677	Friday	1715	115	226	\N	\N	\N	\N
1604	2023-08-03 06:32:35.158576	2023-08-03 06:32:35.158576	Sunday	1100	1300	226	\N	\N	\N	\N
1605	2023-08-03 06:32:35.160174	2023-08-03 06:32:35.160174	Sunday	1945	830	226	\N	\N	\N	\N
1606	2023-08-03 06:32:35.184415	2023-08-03 06:32:35.184415	Monday	345	1415	227	\N	\N	\N	\N
1607	2023-08-03 06:32:35.185901	2023-08-03 06:32:35.185901	Monday	2030	2345	227	\N	\N	\N	\N
1608	2023-08-03 06:32:35.187567	2023-08-03 06:32:35.187567	Tuesday	1545	145	227	\N	\N	\N	\N
1609	2023-08-03 06:32:35.188938	2023-08-03 06:32:35.188938	Wednesday	945	2315	227	\N	\N	\N	\N
1610	2023-08-03 06:32:35.190374	2023-08-03 06:32:35.190374	Thursday	345	615	227	\N	\N	\N	\N
1611	2023-08-03 06:32:35.191848	2023-08-03 06:32:35.191848	Thursday	1130	2400	227	\N	\N	\N	\N
1612	2023-08-03 06:32:35.193264	2023-08-03 06:32:35.193264	Friday	1745	1900	227	\N	\N	\N	\N
1613	2023-08-03 06:32:35.194627	2023-08-03 06:32:35.194627	Friday	2400	1300	227	\N	\N	\N	\N
1614	2023-08-03 06:32:35.196048	2023-08-03 06:32:35.196048	Saturday	1000	2215	227	\N	\N	\N	\N
1615	2023-08-03 06:32:35.220858	2023-08-03 06:32:35.220858	Monday	830	2345	228	\N	\N	\N	\N
1616	2023-08-03 06:32:35.222458	2023-08-03 06:32:35.222458	Tuesday	445	730	228	\N	\N	\N	\N
1617	2023-08-03 06:32:35.223968	2023-08-03 06:32:35.223968	Tuesday	1300	1730	228	\N	\N	\N	\N
1618	2023-08-03 06:32:35.225638	2023-08-03 06:32:35.225638	Wednesday	915	1900	228	\N	\N	\N	\N
1619	2023-08-03 06:32:35.227119	2023-08-03 06:32:35.227119	Thursday	600	1715	228	\N	\N	\N	\N
1620	2023-08-03 06:32:35.228568	2023-08-03 06:32:35.228568	Thursday	1930	2130	228	\N	\N	\N	\N
1621	2023-08-03 06:32:35.230162	2023-08-03 06:32:35.230162	Friday	1600	200	228	\N	\N	\N	\N
1622	2023-08-03 06:32:35.23159	2023-08-03 06:32:35.23159	Saturday	100	545	228	\N	\N	\N	\N
1623	2023-08-03 06:32:35.233003	2023-08-03 06:32:35.233003	Saturday	745	1330	228	\N	\N	\N	\N
1624	2023-08-03 06:32:35.234393	2023-08-03 06:32:35.234393	Sunday	1000	1815	228	\N	\N	\N	\N
1625	2023-08-03 06:32:35.251278	2023-08-03 06:32:35.251278	Monday	1715	315	229	\N	\N	\N	\N
1626	2023-08-03 06:32:35.252853	2023-08-03 06:32:35.252853	Tuesday	430	1100	229	\N	\N	\N	\N
1627	2023-08-03 06:32:35.254212	2023-08-03 06:32:35.254212	Tuesday	1200	1900	229	\N	\N	\N	\N
1628	2023-08-03 06:32:35.255576	2023-08-03 06:32:35.255576	Wednesday	815	1445	229	\N	\N	\N	\N
1629	2023-08-03 06:32:35.257028	2023-08-03 06:32:35.257028	Friday	1000	2045	229	\N	\N	\N	\N
1630	2023-08-03 06:32:35.258417	2023-08-03 06:32:35.258417	Saturday	1915	130	229	\N	\N	\N	\N
1631	2023-08-03 06:32:35.25983	2023-08-03 06:32:35.25983	Sunday	645	1815	229	\N	\N	\N	\N
1632	2023-08-03 06:32:35.280868	2023-08-03 06:32:35.280868	Monday	715	1700	230	\N	\N	\N	\N
1633	2023-08-03 06:32:35.282498	2023-08-03 06:32:35.282498	Tuesday	945	2200	230	\N	\N	\N	\N
1634	2023-08-03 06:32:35.283991	2023-08-03 06:32:35.283991	Wednesday	800	1745	230	\N	\N	\N	\N
1635	2023-08-03 06:32:35.285465	2023-08-03 06:32:35.285465	Friday	1645	2100	230	\N	\N	\N	\N
1636	2023-08-03 06:32:35.287112	2023-08-03 06:32:35.287112	Friday	2245	2330	230	\N	\N	\N	\N
1637	2023-08-03 06:32:35.288757	2023-08-03 06:32:35.288757	Saturday	1915	300	230	\N	\N	\N	\N
1638	2023-08-03 06:32:35.290607	2023-08-03 06:32:35.290607	Sunday	730	1545	230	\N	\N	\N	\N
1639	2023-08-03 06:32:35.304361	2023-08-03 06:32:35.304361	Monday	945	1715	231	\N	\N	\N	\N
1640	2023-08-03 06:32:35.306463	2023-08-03 06:32:35.306463	Tuesday	1330	1445	231	\N	\N	\N	\N
1641	2023-08-03 06:32:35.309132	2023-08-03 06:32:35.309132	Tuesday	2030	545	231	\N	\N	\N	\N
1642	2023-08-03 06:32:35.311716	2023-08-03 06:32:35.311716	Wednesday	515	845	231	\N	\N	\N	\N
1643	2023-08-03 06:32:35.313497	2023-08-03 06:32:35.313497	Wednesday	1745	2315	231	\N	\N	\N	\N
1644	2023-08-03 06:32:35.315308	2023-08-03 06:32:35.315308	Friday	600	2230	231	\N	\N	\N	\N
1645	2023-08-03 06:32:35.317418	2023-08-03 06:32:35.317418	Saturday	800	1445	231	\N	\N	\N	\N
1646	2023-08-03 06:32:35.319399	2023-08-03 06:32:35.319399	Saturday	1645	2230	231	\N	\N	\N	\N
1647	2023-08-03 06:32:35.321415	2023-08-03 06:32:35.321415	Sunday	445	645	231	\N	\N	\N	\N
1648	2023-08-03 06:32:35.323832	2023-08-03 06:32:35.323832	Sunday	800	2300	231	\N	\N	\N	\N
1649	2023-08-03 06:32:35.35287	2023-08-03 06:32:35.35287	Wednesday	545	930	232	\N	\N	\N	\N
1650	2023-08-03 06:32:35.355405	2023-08-03 06:32:35.355405	Wednesday	1315	1930	232	\N	\N	\N	\N
1651	2023-08-03 06:32:35.357686	2023-08-03 06:32:35.357686	Friday	0	500	232	\N	\N	\N	\N
1652	2023-08-03 06:32:35.359685	2023-08-03 06:32:35.359685	Friday	1215	2345	232	\N	\N	\N	\N
1653	2023-08-03 06:32:35.361869	2023-08-03 06:32:35.361869	Sunday	815	1545	232	\N	\N	\N	\N
1654	2023-08-03 06:32:35.394404	2023-08-03 06:32:35.394404	Monday	900	2230	233	\N	\N	\N	\N
1655	2023-08-03 06:32:35.397475	2023-08-03 06:32:35.397475	Wednesday	630	1945	233	\N	\N	\N	\N
1656	2023-08-03 06:32:35.399633	2023-08-03 06:32:35.399633	Thursday	600	715	233	\N	\N	\N	\N
1657	2023-08-03 06:32:35.401916	2023-08-03 06:32:35.401916	Thursday	730	830	233	\N	\N	\N	\N
1658	2023-08-03 06:32:35.40452	2023-08-03 06:32:35.40452	Saturday	2130	130	233	\N	\N	\N	\N
1659	2023-08-03 06:32:35.4065	2023-08-03 06:32:35.4065	Sunday	830	2030	233	\N	\N	\N	\N
1660	2023-08-03 06:32:35.43151	2023-08-03 06:32:35.43151	Monday	615	1815	234	\N	\N	\N	\N
1661	2023-08-03 06:32:35.433466	2023-08-03 06:32:35.433466	Tuesday	645	1415	234	\N	\N	\N	\N
1662	2023-08-03 06:32:35.435877	2023-08-03 06:32:35.435877	Wednesday	800	2400	234	\N	\N	\N	\N
1663	2023-08-03 06:32:35.437775	2023-08-03 06:32:35.437775	Thursday	800	1000	234	\N	\N	\N	\N
1664	2023-08-03 06:32:35.439681	2023-08-03 06:32:35.439681	Thursday	2200	545	234	\N	\N	\N	\N
1665	2023-08-03 06:32:35.441836	2023-08-03 06:32:35.441836	Friday	600	1445	234	\N	\N	\N	\N
1666	2023-08-03 06:32:35.443586	2023-08-03 06:32:35.443586	Saturday	800	2000	234	\N	\N	\N	\N
1667	2023-08-03 06:32:35.445638	2023-08-03 06:32:35.445638	Sunday	800	2030	234	\N	\N	\N	\N
1668	2023-08-03 06:32:35.46317	2023-08-03 06:32:35.46317	Monday	330	500	235	\N	\N	\N	\N
1669	2023-08-03 06:32:35.465031	2023-08-03 06:32:35.465031	Monday	1145	1415	235	\N	\N	\N	\N
1670	2023-08-03 06:32:35.466979	2023-08-03 06:32:35.466979	Tuesday	615	1400	235	\N	\N	\N	\N
1671	2023-08-03 06:32:35.468942	2023-08-03 06:32:35.468942	Wednesday	2300	400	235	\N	\N	\N	\N
1672	2023-08-03 06:32:35.470882	2023-08-03 06:32:35.470882	Saturday	830	1830	235	\N	\N	\N	\N
1673	2023-08-03 06:32:35.472792	2023-08-03 06:32:35.472792	Sunday	500	1245	235	\N	\N	\N	\N
1674	2023-08-03 06:32:35.474609	2023-08-03 06:32:35.474609	Sunday	1300	115	235	\N	\N	\N	\N
1675	2023-08-03 06:32:35.49534	2023-08-03 06:32:35.49534	Monday	630	1415	236	\N	\N	\N	\N
1676	2023-08-03 06:32:35.496967	2023-08-03 06:32:35.496967	Tuesday	600	1915	236	\N	\N	\N	\N
1677	2023-08-03 06:32:35.499287	2023-08-03 06:32:35.499287	Wednesday	330	1345	236	\N	\N	\N	\N
1678	2023-08-03 06:32:35.502047	2023-08-03 06:32:35.502047	Wednesday	2045	2230	236	\N	\N	\N	\N
1679	2023-08-03 06:32:35.504299	2023-08-03 06:32:35.504299	Thursday	330	830	236	\N	\N	\N	\N
1680	2023-08-03 06:32:35.506027	2023-08-03 06:32:35.506027	Thursday	845	2215	236	\N	\N	\N	\N
1681	2023-08-03 06:32:35.507882	2023-08-03 06:32:35.507882	Friday	930	1545	236	\N	\N	\N	\N
1682	2023-08-03 06:32:35.509429	2023-08-03 06:32:35.509429	Saturday	930	1900	236	\N	\N	\N	\N
1683	2023-08-03 06:32:35.532253	2023-08-03 06:32:35.532253	Monday	915	2400	237	\N	\N	\N	\N
1684	2023-08-03 06:32:35.533769	2023-08-03 06:32:35.533769	Tuesday	930	1315	237	\N	\N	\N	\N
1685	2023-08-03 06:32:35.535127	2023-08-03 06:32:35.535127	Tuesday	1645	2200	237	\N	\N	\N	\N
1686	2023-08-03 06:32:35.53678	2023-08-03 06:32:35.53678	Wednesday	845	2230	237	\N	\N	\N	\N
1687	2023-08-03 06:32:35.538182	2023-08-03 06:32:35.538182	Thursday	1000	2200	237	\N	\N	\N	\N
1688	2023-08-03 06:32:35.53961	2023-08-03 06:32:35.53961	Friday	1445	100	237	\N	\N	\N	\N
1689	2023-08-03 06:32:35.541052	2023-08-03 06:32:35.541052	Saturday	830	2045	237	\N	\N	\N	\N
1690	2023-08-03 06:32:35.55194	2023-08-03 06:32:35.55194	Monday	630	1915	238	\N	\N	\N	\N
1691	2023-08-03 06:32:35.553442	2023-08-03 06:32:35.553442	Tuesday	745	1000	238	\N	\N	\N	\N
1692	2023-08-03 06:32:35.554962	2023-08-03 06:32:35.554962	Tuesday	1230	2015	238	\N	\N	\N	\N
1693	2023-08-03 06:32:35.556396	2023-08-03 06:32:35.556396	Thursday	745	915	238	\N	\N	\N	\N
1694	2023-08-03 06:32:35.557748	2023-08-03 06:32:35.557748	Thursday	1015	1645	238	\N	\N	\N	\N
1695	2023-08-03 06:32:35.559187	2023-08-03 06:32:35.559187	Friday	745	2300	238	\N	\N	\N	\N
1696	2023-08-03 06:32:35.560601	2023-08-03 06:32:35.560601	Saturday	830	1515	238	\N	\N	\N	\N
1697	2023-08-03 06:32:35.562288	2023-08-03 06:32:35.562288	Sunday	800	1915	238	\N	\N	\N	\N
1698	2023-08-03 06:32:35.584201	2023-08-03 06:32:35.584201	Tuesday	700	1915	239	\N	\N	\N	\N
1699	2023-08-03 06:32:35.585684	2023-08-03 06:32:35.585684	Wednesday	715	1430	239	\N	\N	\N	\N
1700	2023-08-03 06:32:35.587164	2023-08-03 06:32:35.587164	Thursday	830	2245	239	\N	\N	\N	\N
1701	2023-08-03 06:32:35.588775	2023-08-03 06:32:35.588775	Friday	830	2015	239	\N	\N	\N	\N
1702	2023-08-03 06:32:35.59018	2023-08-03 06:32:35.59018	Saturday	630	2015	239	\N	\N	\N	\N
1703	2023-08-03 06:32:35.59161	2023-08-03 06:32:35.59161	Sunday	1000	1615	239	\N	\N	\N	\N
1704	2023-08-03 06:32:35.601884	2023-08-03 06:32:35.601884	Tuesday	400	930	240	\N	\N	\N	\N
1705	2023-08-03 06:32:35.603539	2023-08-03 06:32:35.603539	Tuesday	1100	1115	240	\N	\N	\N	\N
1706	2023-08-03 06:32:35.605066	2023-08-03 06:32:35.605066	Wednesday	345	530	240	\N	\N	\N	\N
1707	2023-08-03 06:32:35.606412	2023-08-03 06:32:35.606412	Wednesday	915	1745	240	\N	\N	\N	\N
1708	2023-08-03 06:32:35.607792	2023-08-03 06:32:35.607792	Sunday	915	1445	240	\N	\N	\N	\N
1709	2023-08-03 06:32:35.635994	2023-08-03 06:32:35.635994	Monday	715	1830	241	\N	\N	\N	\N
1710	2023-08-03 06:32:35.637454	2023-08-03 06:32:35.637454	Tuesday	645	2115	241	\N	\N	\N	\N
1711	2023-08-03 06:32:35.638892	2023-08-03 06:32:35.638892	Thursday	345	1145	241	\N	\N	\N	\N
1712	2023-08-03 06:32:35.64026	2023-08-03 06:32:35.64026	Thursday	1730	2245	241	\N	\N	\N	\N
1713	2023-08-03 06:32:35.641781	2023-08-03 06:32:35.641781	Friday	845	1730	241	\N	\N	\N	\N
1714	2023-08-03 06:32:35.643371	2023-08-03 06:32:35.643371	Friday	1900	800	241	\N	\N	\N	\N
1715	2023-08-03 06:32:35.644826	2023-08-03 06:32:35.644826	Saturday	800	2300	241	\N	\N	\N	\N
1716	2023-08-03 06:32:35.646301	2023-08-03 06:32:35.646301	Sunday	845	1500	241	\N	\N	\N	\N
1717	2023-08-03 06:32:35.658815	2023-08-03 06:32:35.658815	Monday	830	1900	242	\N	\N	\N	\N
1718	2023-08-03 06:32:35.66054	2023-08-03 06:32:35.66054	Tuesday	745	2230	242	\N	\N	\N	\N
1719	2023-08-03 06:32:35.662045	2023-08-03 06:32:35.662045	Thursday	900	1415	242	\N	\N	\N	\N
1720	2023-08-03 06:32:35.665826	2023-08-03 06:32:35.665826	Friday	700	2200	242	\N	\N	\N	\N
1721	2023-08-03 06:32:35.667393	2023-08-03 06:32:35.667393	Saturday	2115	315	242	\N	\N	\N	\N
1722	2023-08-03 06:32:35.668948	2023-08-03 06:32:35.668948	Sunday	715	1915	242	\N	\N	\N	\N
1723	2023-08-03 06:32:35.687756	2023-08-03 06:32:35.687756	Tuesday	1945	330	243	\N	\N	\N	\N
1724	2023-08-03 06:32:35.68918	2023-08-03 06:32:35.68918	Wednesday	630	1700	243	\N	\N	\N	\N
1725	2023-08-03 06:32:35.690702	2023-08-03 06:32:35.690702	Thursday	345	530	243	\N	\N	\N	\N
1726	2023-08-03 06:32:35.692246	2023-08-03 06:32:35.692246	Thursday	630	1900	243	\N	\N	\N	\N
1727	2023-08-03 06:32:35.694009	2023-08-03 06:32:35.694009	Friday	245	600	243	\N	\N	\N	\N
1728	2023-08-03 06:32:35.695625	2023-08-03 06:32:35.695625	Friday	1100	2300	243	\N	\N	\N	\N
1729	2023-08-03 06:32:35.697244	2023-08-03 06:32:35.697244	Saturday	600	1415	243	\N	\N	\N	\N
1730	2023-08-03 06:32:35.698678	2023-08-03 06:32:35.698678	Saturday	2200	0	243	\N	\N	\N	\N
1731	2023-08-03 06:32:35.720652	2023-08-03 06:32:35.720652	Monday	645	1400	244	\N	\N	\N	\N
1732	2023-08-03 06:32:35.722359	2023-08-03 06:32:35.722359	Tuesday	730	1600	244	\N	\N	\N	\N
1733	2023-08-03 06:32:35.723929	2023-08-03 06:32:35.723929	Thursday	800	1315	244	\N	\N	\N	\N
1734	2023-08-03 06:32:35.725387	2023-08-03 06:32:35.725387	Thursday	2115	2200	244	\N	\N	\N	\N
1735	2023-08-03 06:32:35.726814	2023-08-03 06:32:35.726814	Friday	615	2045	244	\N	\N	\N	\N
1736	2023-08-03 06:32:35.728247	2023-08-03 06:32:35.728247	Sunday	645	2200	244	\N	\N	\N	\N
1737	2023-08-03 06:32:35.738286	2023-08-03 06:32:35.738286	Monday	700	2330	245	\N	\N	\N	\N
1738	2023-08-03 06:32:35.739773	2023-08-03 06:32:35.739773	Tuesday	2245	300	245	\N	\N	\N	\N
1739	2023-08-03 06:32:35.741225	2023-08-03 06:32:35.741225	Wednesday	1400	2015	245	\N	\N	\N	\N
1740	2023-08-03 06:32:35.742541	2023-08-03 06:32:35.742541	Wednesday	2130	1215	245	\N	\N	\N	\N
1741	2023-08-03 06:32:35.743973	2023-08-03 06:32:35.743973	Thursday	745	1415	245	\N	\N	\N	\N
1742	2023-08-03 06:32:35.745341	2023-08-03 06:32:35.745341	Friday	1000	1845	245	\N	\N	\N	\N
1743	2023-08-03 06:32:35.746965	2023-08-03 06:32:35.746965	Saturday	1915	400	245	\N	\N	\N	\N
1744	2023-08-03 06:32:35.748296	2023-08-03 06:32:35.748296	Sunday	730	2400	245	\N	\N	\N	\N
1745	2023-08-03 06:32:35.769109	2023-08-03 06:32:35.769109	Monday	1000	2045	246	\N	\N	\N	\N
1746	2023-08-03 06:32:35.770583	2023-08-03 06:32:35.770583	Tuesday	945	2115	246	\N	\N	\N	\N
1747	2023-08-03 06:32:35.772218	2023-08-03 06:32:35.772218	Wednesday	1000	1600	246	\N	\N	\N	\N
1748	2023-08-03 06:32:35.773713	2023-08-03 06:32:35.773713	Friday	615	2200	246	\N	\N	\N	\N
1749	2023-08-03 06:32:35.775238	2023-08-03 06:32:35.775238	Saturday	300	1015	246	\N	\N	\N	\N
1750	2023-08-03 06:32:35.776696	2023-08-03 06:32:35.776696	Saturday	1700	2030	246	\N	\N	\N	\N
1751	2023-08-03 06:32:35.787034	2023-08-03 06:32:35.787034	Wednesday	845	1730	247	\N	\N	\N	\N
1752	2023-08-03 06:32:35.788474	2023-08-03 06:32:35.788474	Friday	800	1445	247	\N	\N	\N	\N
1753	2023-08-03 06:32:35.789975	2023-08-03 06:32:35.789975	Saturday	515	1030	247	\N	\N	\N	\N
1754	2023-08-03 06:32:35.791389	2023-08-03 06:32:35.791389	Saturday	1100	2245	247	\N	\N	\N	\N
1755	2023-08-03 06:32:35.808292	2023-08-03 06:32:35.808292	Monday	915	1430	248	\N	\N	\N	\N
1756	2023-08-03 06:32:35.80975	2023-08-03 06:32:35.80975	Tuesday	730	2030	248	\N	\N	\N	\N
1757	2023-08-03 06:32:35.811276	2023-08-03 06:32:35.811276	Wednesday	745	2000	248	\N	\N	\N	\N
1758	2023-08-03 06:32:35.813057	2023-08-03 06:32:35.813057	Thursday	830	1400	248	\N	\N	\N	\N
1759	2023-08-03 06:32:35.814694	2023-08-03 06:32:35.814694	Friday	845	2215	248	\N	\N	\N	\N
1760	2023-08-03 06:32:35.816029	2023-08-03 06:32:35.816029	Sunday	730	2200	248	\N	\N	\N	\N
1761	2023-08-03 06:32:35.839964	2023-08-03 06:32:35.839964	Monday	315	930	249	\N	\N	\N	\N
1762	2023-08-03 06:32:35.841356	2023-08-03 06:32:35.841356	Monday	1600	1830	249	\N	\N	\N	\N
1763	2023-08-03 06:32:35.84291	2023-08-03 06:32:35.84291	Tuesday	815	1445	249	\N	\N	\N	\N
1764	2023-08-03 06:32:35.844366	2023-08-03 06:32:35.844366	Wednesday	730	1400	249	\N	\N	\N	\N
1765	2023-08-03 06:32:35.845803	2023-08-03 06:32:35.845803	Thursday	1030	1115	249	\N	\N	\N	\N
1766	2023-08-03 06:32:35.847215	2023-08-03 06:32:35.847215	Thursday	1345	2115	249	\N	\N	\N	\N
1767	2023-08-03 06:32:35.848638	2023-08-03 06:32:35.848638	Friday	545	800	249	\N	\N	\N	\N
1768	2023-08-03 06:32:35.850004	2023-08-03 06:32:35.850004	Friday	1015	1830	249	\N	\N	\N	\N
1769	2023-08-03 06:32:35.851464	2023-08-03 06:32:35.851464	Saturday	100	415	249	\N	\N	\N	\N
1770	2023-08-03 06:32:35.852895	2023-08-03 06:32:35.852895	Saturday	1200	1800	249	\N	\N	\N	\N
1771	2023-08-03 06:32:35.85455	2023-08-03 06:32:35.85455	Sunday	700	715	249	\N	\N	\N	\N
1772	2023-08-03 06:32:35.855897	2023-08-03 06:32:35.855897	Sunday	915	1800	249	\N	\N	\N	\N
1773	2023-08-03 06:32:35.865865	2023-08-03 06:32:35.865865	Monday	945	2045	250	\N	\N	\N	\N
1774	2023-08-03 06:32:35.867317	2023-08-03 06:32:35.867317	Tuesday	1630	115	250	\N	\N	\N	\N
1775	2023-08-03 06:32:35.868907	2023-08-03 06:32:35.868907	Wednesday	800	1630	250	\N	\N	\N	\N
1776	2023-08-03 06:32:35.870253	2023-08-03 06:32:35.870253	Thursday	700	1415	250	\N	\N	\N	\N
1777	2023-08-03 06:32:35.871643	2023-08-03 06:32:35.871643	Friday	900	2215	250	\N	\N	\N	\N
1778	2023-08-03 06:32:35.87301	2023-08-03 06:32:35.87301	Saturday	1915	145	250	\N	\N	\N	\N
1779	2023-08-03 06:32:35.89411	2023-08-03 06:32:35.89411	Monday	730	1445	251	\N	\N	\N	\N
1780	2023-08-03 06:32:35.89559	2023-08-03 06:32:35.89559	Tuesday	615	2300	251	\N	\N	\N	\N
1781	2023-08-03 06:32:35.896929	2023-08-03 06:32:35.896929	Wednesday	800	2215	251	\N	\N	\N	\N
1782	2023-08-03 06:32:35.898313	2023-08-03 06:32:35.898313	Thursday	700	2145	251	\N	\N	\N	\N
1783	2023-08-03 06:32:35.899701	2023-08-03 06:32:35.899701	Friday	745	1500	251	\N	\N	\N	\N
1784	2023-08-03 06:32:35.901053	2023-08-03 06:32:35.901053	Saturday	915	1800	251	\N	\N	\N	\N
1785	2023-08-03 06:32:35.902405	2023-08-03 06:32:35.902405	Sunday	645	1945	251	\N	\N	\N	\N
1786	2023-08-03 06:32:35.912532	2023-08-03 06:32:35.912532	Tuesday	700	1745	252	\N	\N	\N	\N
1787	2023-08-03 06:32:35.913939	2023-08-03 06:32:35.913939	Friday	945	2145	252	\N	\N	\N	\N
1788	2023-08-03 06:32:35.91547	2023-08-03 06:32:35.91547	Saturday	1530	330	252	\N	\N	\N	\N
1789	2023-08-03 06:32:35.936888	2023-08-03 06:32:35.936888	Monday	830	1745	253	\N	\N	\N	\N
1790	2023-08-03 06:32:35.938254	2023-08-03 06:32:35.938254	Tuesday	745	1945	253	\N	\N	\N	\N
1791	2023-08-03 06:32:35.939762	2023-08-03 06:32:35.939762	Thursday	30	1200	253	\N	\N	\N	\N
1792	2023-08-03 06:32:35.94113	2023-08-03 06:32:35.94113	Thursday	1300	2230	253	\N	\N	\N	\N
1793	2023-08-03 06:32:35.942713	2023-08-03 06:32:35.942713	Friday	0	30	253	\N	\N	\N	\N
1794	2023-08-03 06:32:35.944092	2023-08-03 06:32:35.944092	Friday	1215	2200	253	\N	\N	\N	\N
1795	2023-08-03 06:32:35.945724	2023-08-03 06:32:35.945724	Saturday	815	2130	253	\N	\N	\N	\N
1796	2023-08-03 06:32:35.947077	2023-08-03 06:32:35.947077	Sunday	930	1800	253	\N	\N	\N	\N
1797	2023-08-03 06:32:35.957106	2023-08-03 06:32:35.957106	Monday	800	1600	254	\N	\N	\N	\N
1798	2023-08-03 06:32:35.958904	2023-08-03 06:32:35.958904	Tuesday	830	1430	254	\N	\N	\N	\N
1799	2023-08-03 06:32:35.960415	2023-08-03 06:32:35.960415	Thursday	1515	315	254	\N	\N	\N	\N
1800	2023-08-03 06:32:35.961873	2023-08-03 06:32:35.961873	Friday	1930	230	254	\N	\N	\N	\N
1801	2023-08-03 06:32:35.963463	2023-08-03 06:32:35.963463	Saturday	730	1600	254	\N	\N	\N	\N
1802	2023-08-03 06:32:35.964974	2023-08-03 06:32:35.964974	Sunday	730	1715	254	\N	\N	\N	\N
1803	2023-08-03 06:32:35.981876	2023-08-03 06:32:35.981876	Monday	700	2215	255	\N	\N	\N	\N
1804	2023-08-03 06:32:35.98343	2023-08-03 06:32:35.98343	Tuesday	700	1430	255	\N	\N	\N	\N
1805	2023-08-03 06:32:35.984978	2023-08-03 06:32:35.984978	Thursday	900	1615	255	\N	\N	\N	\N
1806	2023-08-03 06:32:35.986777	2023-08-03 06:32:35.986777	Saturday	230	730	255	\N	\N	\N	\N
1807	2023-08-03 06:32:35.98816	2023-08-03 06:32:35.98816	Saturday	1445	1530	255	\N	\N	\N	\N
1808	2023-08-03 06:32:35.989528	2023-08-03 06:32:35.989528	Sunday	915	1700	255	\N	\N	\N	\N
1809	2023-08-03 06:32:36.009532	2023-08-03 06:32:36.009532	Tuesday	330	715	256	\N	\N	\N	\N
1810	2023-08-03 06:32:36.011008	2023-08-03 06:32:36.011008	Tuesday	815	1845	256	\N	\N	\N	\N
1811	2023-08-03 06:32:36.01261	2023-08-03 06:32:36.01261	Wednesday	730	1800	256	\N	\N	\N	\N
1812	2023-08-03 06:32:36.014071	2023-08-03 06:32:36.014071	Friday	1000	1345	256	\N	\N	\N	\N
1813	2023-08-03 06:32:36.015416	2023-08-03 06:32:36.015416	Friday	1945	2230	256	\N	\N	\N	\N
1814	2023-08-03 06:32:36.016855	2023-08-03 06:32:36.016855	Saturday	430	1715	256	\N	\N	\N	\N
1815	2023-08-03 06:32:36.018237	2023-08-03 06:32:36.018237	Saturday	1915	2115	256	\N	\N	\N	\N
1816	2023-08-03 06:32:36.019606	2023-08-03 06:32:36.019606	Sunday	1630	330	256	\N	\N	\N	\N
1817	2023-08-03 06:32:36.028422	2023-08-03 06:32:36.028422	Monday	930	2300	257	\N	\N	\N	\N
1818	2023-08-03 06:32:36.029876	2023-08-03 06:32:36.029876	Tuesday	730	915	257	\N	\N	\N	\N
1819	2023-08-03 06:32:36.031207	2023-08-03 06:32:36.031207	Tuesday	1215	1915	257	\N	\N	\N	\N
1820	2023-08-03 06:32:36.032692	2023-08-03 06:32:36.032692	Wednesday	430	1630	257	\N	\N	\N	\N
1821	2023-08-03 06:32:36.034132	2023-08-03 06:32:36.034132	Wednesday	1645	2215	257	\N	\N	\N	\N
1822	2023-08-03 06:32:36.035564	2023-08-03 06:32:36.035564	Thursday	100	500	257	\N	\N	\N	\N
1823	2023-08-03 06:32:36.037131	2023-08-03 06:32:36.037131	Thursday	1830	2400	257	\N	\N	\N	\N
1824	2023-08-03 06:32:36.038477	2023-08-03 06:32:36.038477	Friday	815	2215	257	\N	\N	\N	\N
1825	2023-08-03 06:32:36.039825	2023-08-03 06:32:36.039825	Saturday	915	1915	257	\N	\N	\N	\N
1826	2023-08-03 06:32:36.059732	2023-08-03 06:32:36.059732	Monday	630	1930	258	\N	\N	\N	\N
1827	2023-08-03 06:32:36.061383	2023-08-03 06:32:36.061383	Wednesday	245	315	258	\N	\N	\N	\N
1828	2023-08-03 06:32:36.062792	2023-08-03 06:32:36.062792	Wednesday	545	1930	258	\N	\N	\N	\N
1829	2023-08-03 06:32:36.064208	2023-08-03 06:32:36.064208	Friday	930	2000	258	\N	\N	\N	\N
1830	2023-08-03 06:32:36.065564	2023-08-03 06:32:36.065564	Saturday	945	2100	258	\N	\N	\N	\N
1831	2023-08-03 06:32:36.066892	2023-08-03 06:32:36.066892	Sunday	845	1700	258	\N	\N	\N	\N
1832	2023-08-03 06:32:36.077088	2023-08-03 06:32:36.077088	Monday	1130	1430	259	\N	\N	\N	\N
1833	2023-08-03 06:32:36.078425	2023-08-03 06:32:36.078425	Monday	1615	2215	259	\N	\N	\N	\N
1834	2023-08-03 06:32:36.079801	2023-08-03 06:32:36.079801	Tuesday	730	1045	259	\N	\N	\N	\N
1835	2023-08-03 06:32:36.081183	2023-08-03 06:32:36.081183	Tuesday	1300	530	259	\N	\N	\N	\N
1836	2023-08-03 06:32:36.082527	2023-08-03 06:32:36.082527	Wednesday	630	2130	259	\N	\N	\N	\N
1837	2023-08-03 06:32:36.083918	2023-08-03 06:32:36.083918	Thursday	645	1615	259	\N	\N	\N	\N
1838	2023-08-03 06:32:36.08551	2023-08-03 06:32:36.08551	Friday	1715	200	259	\N	\N	\N	\N
1839	2023-08-03 06:32:36.086883	2023-08-03 06:32:36.086883	Saturday	615	1545	259	\N	\N	\N	\N
1840	2023-08-03 06:32:36.088181	2023-08-03 06:32:36.088181	Saturday	1830	2115	259	\N	\N	\N	\N
1841	2023-08-03 06:32:36.107345	2023-08-03 06:32:36.107345	Monday	900	1630	260	\N	\N	\N	\N
1842	2023-08-03 06:32:36.108776	2023-08-03 06:32:36.108776	Tuesday	415	815	260	\N	\N	\N	\N
1843	2023-08-03 06:32:36.110416	2023-08-03 06:32:36.110416	Tuesday	1445	1900	260	\N	\N	\N	\N
1844	2023-08-03 06:32:36.111968	2023-08-03 06:32:36.111968	Wednesday	2230	145	260	\N	\N	\N	\N
1845	2023-08-03 06:32:36.113455	2023-08-03 06:32:36.113455	Thursday	515	615	260	\N	\N	\N	\N
1846	2023-08-03 06:32:36.114881	2023-08-03 06:32:36.114881	Thursday	1915	2230	260	\N	\N	\N	\N
1847	2023-08-03 06:32:36.1163	2023-08-03 06:32:36.1163	Friday	1615	300	260	\N	\N	\N	\N
1848	2023-08-03 06:32:36.117788	2023-08-03 06:32:36.117788	Saturday	600	1515	260	\N	\N	\N	\N
1849	2023-08-03 06:32:36.119809	2023-08-03 06:32:36.119809	Sunday	730	1745	260	\N	\N	\N	\N
1850	2023-08-03 06:32:36.143356	2023-08-03 06:32:36.143356	Monday	730	2345	261	\N	\N	\N	\N
1851	2023-08-03 06:32:36.145425	2023-08-03 06:32:36.145425	Thursday	730	1500	261	\N	\N	\N	\N
1852	2023-08-03 06:32:36.148102	2023-08-03 06:32:36.148102	Friday	645	1430	261	\N	\N	\N	\N
1853	2023-08-03 06:32:36.150056	2023-08-03 06:32:36.150056	Saturday	700	1615	261	\N	\N	\N	\N
1854	2023-08-03 06:32:36.151955	2023-08-03 06:32:36.151955	Sunday	1745	145	261	\N	\N	\N	\N
1855	2023-08-03 06:32:36.180711	2023-08-03 06:32:36.180711	Tuesday	900	1845	262	\N	\N	\N	\N
1856	2023-08-03 06:32:36.182438	2023-08-03 06:32:36.182438	Wednesday	715	2400	262	\N	\N	\N	\N
1857	2023-08-03 06:32:36.184014	2023-08-03 06:32:36.184014	Thursday	1645	200	262	\N	\N	\N	\N
1858	2023-08-03 06:32:36.185485	2023-08-03 06:32:36.185485	Friday	115	1315	262	\N	\N	\N	\N
1859	2023-08-03 06:32:36.18699	2023-08-03 06:32:36.18699	Friday	1415	2245	262	\N	\N	\N	\N
1860	2023-08-03 06:32:36.188697	2023-08-03 06:32:36.188697	Saturday	745	2315	262	\N	\N	\N	\N
1861	2023-08-03 06:32:36.190249	2023-08-03 06:32:36.190249	Sunday	700	1830	262	\N	\N	\N	\N
1862	2023-08-03 06:32:36.200971	2023-08-03 06:32:36.200971	Monday	630	1845	263	\N	\N	\N	\N
1863	2023-08-03 06:32:36.20267	2023-08-03 06:32:36.20267	Friday	1630	145	263	\N	\N	\N	\N
1864	2023-08-03 06:32:36.223446	2023-08-03 06:32:36.223446	Tuesday	930	1945	264	\N	\N	\N	\N
1865	2023-08-03 06:32:36.224836	2023-08-03 06:32:36.224836	Wednesday	930	1915	264	\N	\N	\N	\N
1866	2023-08-03 06:32:36.22637	2023-08-03 06:32:36.22637	Thursday	515	1400	264	\N	\N	\N	\N
1867	2023-08-03 06:32:36.228012	2023-08-03 06:32:36.228012	Thursday	1415	1600	264	\N	\N	\N	\N
1868	2023-08-03 06:32:36.229498	2023-08-03 06:32:36.229498	Friday	1815	315	264	\N	\N	\N	\N
1869	2023-08-03 06:32:36.230918	2023-08-03 06:32:36.230918	Saturday	130	300	264	\N	\N	\N	\N
1870	2023-08-03 06:32:36.232345	2023-08-03 06:32:36.232345	Saturday	930	1630	264	\N	\N	\N	\N
1871	2023-08-03 06:32:36.233731	2023-08-03 06:32:36.233731	Sunday	900	1430	264	\N	\N	\N	\N
1872	2023-08-03 06:32:36.243951	2023-08-03 06:32:36.243951	Monday	800	2000	265	\N	\N	\N	\N
1873	2023-08-03 06:32:36.245508	2023-08-03 06:32:36.245508	Wednesday	215	600	265	\N	\N	\N	\N
1874	2023-08-03 06:32:36.246943	2023-08-03 06:32:36.246943	Wednesday	1545	2115	265	\N	\N	\N	\N
1875	2023-08-03 06:32:36.248611	2023-08-03 06:32:36.248611	Thursday	2200	300	265	\N	\N	\N	\N
1876	2023-08-03 06:32:36.250593	2023-08-03 06:32:36.250593	Saturday	645	1645	265	\N	\N	\N	\N
1877	2023-08-03 06:32:36.274576	2023-08-03 06:32:36.274576	Monday	1415	145	266	\N	\N	\N	\N
1878	2023-08-03 06:32:36.275968	2023-08-03 06:32:36.275968	Tuesday	600	1730	266	\N	\N	\N	\N
1879	2023-08-03 06:32:36.277612	2023-08-03 06:32:36.277612	Wednesday	615	2015	266	\N	\N	\N	\N
1880	2023-08-03 06:32:36.279007	2023-08-03 06:32:36.279007	Thursday	1000	2230	266	\N	\N	\N	\N
1881	2023-08-03 06:32:36.280433	2023-08-03 06:32:36.280433	Friday	2015	215	266	\N	\N	\N	\N
1882	2023-08-03 06:32:36.281834	2023-08-03 06:32:36.281834	Saturday	615	1500	266	\N	\N	\N	\N
1883	2023-08-03 06:32:36.283415	2023-08-03 06:32:36.283415	Sunday	1800	345	266	\N	\N	\N	\N
1884	2023-08-03 06:32:36.292093	2023-08-03 06:32:36.292093	Monday	845	2245	267	\N	\N	\N	\N
1885	2023-08-03 06:32:36.293675	2023-08-03 06:32:36.293675	Tuesday	100	800	267	\N	\N	\N	\N
1886	2023-08-03 06:32:36.295127	2023-08-03 06:32:36.295127	Tuesday	1315	1645	267	\N	\N	\N	\N
1887	2023-08-03 06:32:36.296807	2023-08-03 06:32:36.296807	Wednesday	700	2330	267	\N	\N	\N	\N
1888	2023-08-03 06:32:36.298186	2023-08-03 06:32:36.298186	Thursday	1500	300	267	\N	\N	\N	\N
1889	2023-08-03 06:32:36.299589	2023-08-03 06:32:36.299589	Friday	600	2100	267	\N	\N	\N	\N
1890	2023-08-03 06:32:36.301076	2023-08-03 06:32:36.301076	Saturday	815	1830	267	\N	\N	\N	\N
1891	2023-08-03 06:32:36.322265	2023-08-03 06:32:36.322265	Monday	645	2000	268	\N	\N	\N	\N
1892	2023-08-03 06:32:36.324148	2023-08-03 06:32:36.324148	Tuesday	115	315	268	\N	\N	\N	\N
1893	2023-08-03 06:32:36.325759	2023-08-03 06:32:36.325759	Tuesday	730	1400	268	\N	\N	\N	\N
1894	2023-08-03 06:32:36.327338	2023-08-03 06:32:36.327338	Wednesday	1415	300	268	\N	\N	\N	\N
1895	2023-08-03 06:32:36.328843	2023-08-03 06:32:36.328843	Thursday	2030	230	268	\N	\N	\N	\N
1896	2023-08-03 06:32:36.330213	2023-08-03 06:32:36.330213	Friday	830	1415	268	\N	\N	\N	\N
1897	2023-08-03 06:32:36.331705	2023-08-03 06:32:36.331705	Saturday	615	2200	268	\N	\N	\N	\N
1898	2023-08-03 06:32:36.333352	2023-08-03 06:32:36.333352	Sunday	900	1230	268	\N	\N	\N	\N
1899	2023-08-03 06:32:36.334711	2023-08-03 06:32:36.334711	Sunday	1445	2330	268	\N	\N	\N	\N
1900	2023-08-03 06:32:36.344316	2023-08-03 06:32:36.344316	Monday	615	2345	269	\N	\N	\N	\N
1901	2023-08-03 06:32:36.34585	2023-08-03 06:32:36.34585	Wednesday	730	1830	269	\N	\N	\N	\N
1902	2023-08-03 06:32:36.347364	2023-08-03 06:32:36.347364	Thursday	645	1715	269	\N	\N	\N	\N
1903	2023-08-03 06:32:36.348906	2023-08-03 06:32:36.348906	Friday	830	1445	269	\N	\N	\N	\N
1904	2023-08-03 06:32:36.35039	2023-08-03 06:32:36.35039	Sunday	615	1900	269	\N	\N	\N	\N
1905	2023-08-03 06:32:36.370625	2023-08-03 06:32:36.370625	Tuesday	415	1530	270	\N	\N	\N	\N
1906	2023-08-03 06:32:36.372039	2023-08-03 06:32:36.372039	Tuesday	1715	200	270	\N	\N	\N	\N
1907	2023-08-03 06:32:36.373514	2023-08-03 06:32:36.373514	Wednesday	615	1715	270	\N	\N	\N	\N
1908	2023-08-03 06:32:36.3754	2023-08-03 06:32:36.3754	Thursday	15	200	270	\N	\N	\N	\N
1909	2023-08-03 06:32:36.376811	2023-08-03 06:32:36.376811	Thursday	1845	2200	270	\N	\N	\N	\N
1910	2023-08-03 06:32:36.378194	2023-08-03 06:32:36.378194	Saturday	2230	330	270	\N	\N	\N	\N
1911	2023-08-03 06:32:36.379689	2023-08-03 06:32:36.379689	Sunday	1000	2345	270	\N	\N	\N	\N
1912	2023-08-03 06:32:36.389675	2023-08-03 06:32:36.389675	Monday	1000	1815	271	\N	\N	\N	\N
1913	2023-08-03 06:32:36.391133	2023-08-03 06:32:36.391133	Saturday	700	2230	271	\N	\N	\N	\N
1914	2023-08-03 06:32:36.409773	2023-08-03 06:32:36.409773	Monday	645	1715	272	\N	\N	\N	\N
1915	2023-08-03 06:32:36.411238	2023-08-03 06:32:36.411238	Tuesday	600	1545	272	\N	\N	\N	\N
1916	2023-08-03 06:32:36.412679	2023-08-03 06:32:36.412679	Wednesday	600	1445	272	\N	\N	\N	\N
1917	2023-08-03 06:32:36.414089	2023-08-03 06:32:36.414089	Thursday	900	2345	272	\N	\N	\N	\N
1918	2023-08-03 06:32:36.415528	2023-08-03 06:32:36.415528	Saturday	815	1400	272	\N	\N	\N	\N
1919	2023-08-03 06:32:36.437211	2023-08-03 06:32:36.437211	Monday	845	1515	273	\N	\N	\N	\N
1920	2023-08-03 06:32:36.439053	2023-08-03 06:32:36.439053	Tuesday	1430	315	273	\N	\N	\N	\N
1921	2023-08-03 06:32:36.440635	2023-08-03 06:32:36.440635	Wednesday	1100	1245	273	\N	\N	\N	\N
1922	2023-08-03 06:32:36.44216	2023-08-03 06:32:36.44216	Wednesday	1400	1600	273	\N	\N	\N	\N
1923	2023-08-03 06:32:36.443625	2023-08-03 06:32:36.443625	Friday	330	1515	273	\N	\N	\N	\N
1924	2023-08-03 06:32:36.445301	2023-08-03 06:32:36.445301	Friday	1815	1945	273	\N	\N	\N	\N
1925	2023-08-03 06:32:36.446827	2023-08-03 06:32:36.446827	Saturday	1800	100	273	\N	\N	\N	\N
1926	2023-08-03 06:32:36.448281	2023-08-03 06:32:36.448281	Sunday	1415	245	273	\N	\N	\N	\N
1927	2023-08-03 06:32:36.45843	2023-08-03 06:32:36.45843	Monday	700	2030	274	\N	\N	\N	\N
1928	2023-08-03 06:32:36.460037	2023-08-03 06:32:36.460037	Friday	700	1730	274	\N	\N	\N	\N
1929	2023-08-03 06:32:36.461483	2023-08-03 06:32:36.461483	Saturday	630	1930	274	\N	\N	\N	\N
1930	2023-08-03 06:32:36.46297	2023-08-03 06:32:36.46297	Sunday	845	1545	274	\N	\N	\N	\N
1931	2023-08-03 06:32:36.485064	2023-08-03 06:32:36.485064	Monday	615	1430	275	\N	\N	\N	\N
1932	2023-08-03 06:32:36.486902	2023-08-03 06:32:36.486902	Tuesday	600	2100	275	\N	\N	\N	\N
1933	2023-08-03 06:32:36.488764	2023-08-03 06:32:36.488764	Wednesday	130	345	275	\N	\N	\N	\N
1934	2023-08-03 06:32:36.490998	2023-08-03 06:32:36.490998	Wednesday	545	1845	275	\N	\N	\N	\N
1935	2023-08-03 06:32:36.492849	2023-08-03 06:32:36.492849	Friday	1815	100	275	\N	\N	\N	\N
1936	2023-08-03 06:32:36.494526	2023-08-03 06:32:36.494526	Sunday	630	1745	275	\N	\N	\N	\N
1937	2023-08-03 06:32:36.511301	2023-08-03 06:32:36.511301	Monday	600	2000	276	\N	\N	\N	\N
1938	2023-08-03 06:32:36.516892	2023-08-03 06:32:36.516892	Tuesday	15	1200	276	\N	\N	\N	\N
1939	2023-08-03 06:32:36.521294	2023-08-03 06:32:36.521294	Tuesday	1300	2245	276	\N	\N	\N	\N
1940	2023-08-03 06:32:36.526033	2023-08-03 06:32:36.526033	Wednesday	645	1045	276	\N	\N	\N	\N
1941	2023-08-03 06:32:36.528162	2023-08-03 06:32:36.528162	Wednesday	1715	2330	276	\N	\N	\N	\N
1942	2023-08-03 06:32:36.529904	2023-08-03 06:32:36.529904	Thursday	930	1000	276	\N	\N	\N	\N
1943	2023-08-03 06:32:36.53157	2023-08-03 06:32:36.53157	Thursday	1015	615	276	\N	\N	\N	\N
1944	2023-08-03 06:32:36.533446	2023-08-03 06:32:36.533446	Friday	915	1515	276	\N	\N	\N	\N
1945	2023-08-03 06:32:36.535262	2023-08-03 06:32:36.535262	Saturday	630	1815	276	\N	\N	\N	\N
1946	2023-08-03 06:32:36.537049	2023-08-03 06:32:36.537049	Sunday	430	1215	276	\N	\N	\N	\N
1947	2023-08-03 06:32:36.538746	2023-08-03 06:32:36.538746	Sunday	1600	1645	276	\N	\N	\N	\N
1948	2023-08-03 06:32:36.567408	2023-08-03 06:32:36.567408	Monday	730	1715	277	\N	\N	\N	\N
1949	2023-08-03 06:32:36.569614	2023-08-03 06:32:36.569614	Tuesday	900	1415	277	\N	\N	\N	\N
1950	2023-08-03 06:32:36.571366	2023-08-03 06:32:36.571366	Wednesday	1715	200	277	\N	\N	\N	\N
1951	2023-08-03 06:32:36.573155	2023-08-03 06:32:36.573155	Thursday	815	1915	277	\N	\N	\N	\N
1952	2023-08-03 06:32:36.574809	2023-08-03 06:32:36.574809	Friday	2045	130	277	\N	\N	\N	\N
1953	2023-08-03 06:32:36.576471	2023-08-03 06:32:36.576471	Saturday	645	1645	277	\N	\N	\N	\N
1954	2023-08-03 06:32:36.578025	2023-08-03 06:32:36.578025	Sunday	630	2330	277	\N	\N	\N	\N
1955	2023-08-03 06:32:36.602196	2023-08-03 06:32:36.602196	Monday	700	2200	278	\N	\N	\N	\N
1956	2023-08-03 06:32:36.603798	2023-08-03 06:32:36.603798	Tuesday	600	1100	278	\N	\N	\N	\N
1957	2023-08-03 06:32:36.605251	2023-08-03 06:32:36.605251	Tuesday	1530	2145	278	\N	\N	\N	\N
1958	2023-08-03 06:32:36.606682	2023-08-03 06:32:36.606682	Wednesday	630	1715	278	\N	\N	\N	\N
1959	2023-08-03 06:32:36.608125	2023-08-03 06:32:36.608125	Thursday	630	1100	278	\N	\N	\N	\N
1960	2023-08-03 06:32:36.60953	2023-08-03 06:32:36.60953	Thursday	1730	2200	278	\N	\N	\N	\N
1961	2023-08-03 06:32:36.611186	2023-08-03 06:32:36.611186	Friday	2115	200	278	\N	\N	\N	\N
1962	2023-08-03 06:32:36.613584	2023-08-03 06:32:36.613584	Sunday	445	630	278	\N	\N	\N	\N
1963	2023-08-03 06:32:36.615083	2023-08-03 06:32:36.615083	Sunday	815	915	278	\N	\N	\N	\N
1964	2023-08-03 06:32:36.62819	2023-08-03 06:32:36.62819	Monday	630	2315	279	\N	\N	\N	\N
1965	2023-08-03 06:32:36.62967	2023-08-03 06:32:36.62967	Tuesday	1530	2000	279	\N	\N	\N	\N
1966	2023-08-03 06:32:36.631228	2023-08-03 06:32:36.631228	Tuesday	2115	2230	279	\N	\N	\N	\N
1967	2023-08-03 06:32:36.63268	2023-08-03 06:32:36.63268	Wednesday	845	1945	279	\N	\N	\N	\N
1968	2023-08-03 06:32:36.634071	2023-08-03 06:32:36.634071	Thursday	900	2000	279	\N	\N	\N	\N
1969	2023-08-03 06:32:36.635777	2023-08-03 06:32:36.635777	Saturday	230	545	279	\N	\N	\N	\N
1970	2023-08-03 06:32:36.637348	2023-08-03 06:32:36.637348	Saturday	1545	2215	279	\N	\N	\N	\N
1971	2023-08-03 06:32:36.638811	2023-08-03 06:32:36.638811	Sunday	915	2330	279	\N	\N	\N	\N
1972	2023-08-03 06:32:36.659751	2023-08-03 06:32:36.659751	Monday	645	2030	280	\N	\N	\N	\N
1973	2023-08-03 06:32:36.661483	2023-08-03 06:32:36.661483	Tuesday	615	715	280	\N	\N	\N	\N
1974	2023-08-03 06:32:36.663159	2023-08-03 06:32:36.663159	Tuesday	1830	1900	280	\N	\N	\N	\N
1975	2023-08-03 06:32:36.664688	2023-08-03 06:32:36.664688	Wednesday	1900	100	280	\N	\N	\N	\N
1976	2023-08-03 06:32:36.666227	2023-08-03 06:32:36.666227	Thursday	145	800	280	\N	\N	\N	\N
1977	2023-08-03 06:32:36.667943	2023-08-03 06:32:36.667943	Thursday	2015	2145	280	\N	\N	\N	\N
1978	2023-08-03 06:32:36.669459	2023-08-03 06:32:36.669459	Saturday	1615	215	280	\N	\N	\N	\N
1979	2023-08-03 06:32:36.679431	2023-08-03 06:32:36.679431	Monday	1545	145	281	\N	\N	\N	\N
1980	2023-08-03 06:32:36.681152	2023-08-03 06:32:36.681152	Tuesday	615	1745	281	\N	\N	\N	\N
1981	2023-08-03 06:32:36.682608	2023-08-03 06:32:36.682608	Thursday	1630	315	281	\N	\N	\N	\N
1982	2023-08-03 06:32:36.684097	2023-08-03 06:32:36.684097	Friday	500	1330	281	\N	\N	\N	\N
1983	2023-08-03 06:32:36.685535	2023-08-03 06:32:36.685535	Friday	1445	445	281	\N	\N	\N	\N
1984	2023-08-03 06:32:36.686958	2023-08-03 06:32:36.686958	Saturday	1815	145	281	\N	\N	\N	\N
1985	2023-08-03 06:32:36.68839	2023-08-03 06:32:36.68839	Sunday	215	915	281	\N	\N	\N	\N
1986	2023-08-03 06:32:36.689732	2023-08-03 06:32:36.689732	Sunday	1700	1715	281	\N	\N	\N	\N
1987	2023-08-03 06:32:36.70993	2023-08-03 06:32:36.70993	Monday	700	1900	282	\N	\N	\N	\N
1988	2023-08-03 06:32:36.711409	2023-08-03 06:32:36.711409	Tuesday	1730	230	282	\N	\N	\N	\N
1989	2023-08-03 06:32:36.712875	2023-08-03 06:32:36.712875	Friday	645	1700	282	\N	\N	\N	\N
1990	2023-08-03 06:32:36.714355	2023-08-03 06:32:36.714355	Saturday	745	2200	282	\N	\N	\N	\N
1991	2023-08-03 06:32:36.725178	2023-08-03 06:32:36.725178	Monday	815	1745	283	\N	\N	\N	\N
1992	2023-08-03 06:32:36.727138	2023-08-03 06:32:36.727138	Tuesday	630	1215	283	\N	\N	\N	\N
1993	2023-08-03 06:32:36.729573	2023-08-03 06:32:36.729573	Tuesday	1615	1800	283	\N	\N	\N	\N
1994	2023-08-03 06:32:36.732718	2023-08-03 06:32:36.732718	Wednesday	445	800	283	\N	\N	\N	\N
1995	2023-08-03 06:32:36.735189	2023-08-03 06:32:36.735189	Wednesday	1015	2230	283	\N	\N	\N	\N
1996	2023-08-03 06:32:36.737634	2023-08-03 06:32:36.737634	Thursday	1900	315	283	\N	\N	\N	\N
1997	2023-08-03 06:32:36.740204	2023-08-03 06:32:36.740204	Friday	945	2230	283	\N	\N	\N	\N
1998	2023-08-03 06:32:36.742594	2023-08-03 06:32:36.742594	Saturday	1945	100	283	\N	\N	\N	\N
1999	2023-08-03 06:32:36.745108	2023-08-03 06:32:36.745108	Sunday	1030	1600	283	\N	\N	\N	\N
2000	2023-08-03 06:32:36.747	2023-08-03 06:32:36.747	Sunday	1915	345	283	\N	\N	\N	\N
2001	2023-08-03 06:32:36.774461	2023-08-03 06:32:36.774461	Monday	45	300	284	\N	\N	\N	\N
2002	2023-08-03 06:32:36.776295	2023-08-03 06:32:36.776295	Monday	1430	1445	284	\N	\N	\N	\N
2003	2023-08-03 06:32:36.777999	2023-08-03 06:32:36.777999	Wednesday	600	2145	284	\N	\N	\N	\N
2004	2023-08-03 06:32:36.779715	2023-08-03 06:32:36.779715	Friday	700	1845	284	\N	\N	\N	\N
2005	2023-08-03 06:32:36.781428	2023-08-03 06:32:36.781428	Saturday	2300	330	284	\N	\N	\N	\N
2006	2023-08-03 06:32:36.783345	2023-08-03 06:32:36.783345	Sunday	1945	115	284	\N	\N	\N	\N
2007	2023-08-03 06:32:36.794918	2023-08-03 06:32:36.794918	Monday	745	2145	285	\N	\N	\N	\N
2008	2023-08-03 06:32:36.796894	2023-08-03 06:32:36.796894	Tuesday	730	1445	285	\N	\N	\N	\N
2009	2023-08-03 06:32:36.798692	2023-08-03 06:32:36.798692	Wednesday	415	500	285	\N	\N	\N	\N
2010	2023-08-03 06:32:36.800792	2023-08-03 06:32:36.800792	Wednesday	1800	115	285	\N	\N	\N	\N
2011	2023-08-03 06:32:36.802452	2023-08-03 06:32:36.802452	Thursday	700	1815	285	\N	\N	\N	\N
2012	2023-08-03 06:32:36.804495	2023-08-03 06:32:36.804495	Saturday	2045	300	285	\N	\N	\N	\N
2013	2023-08-03 06:32:36.806239	2023-08-03 06:32:36.806239	Sunday	200	445	285	\N	\N	\N	\N
2014	2023-08-03 06:32:36.807913	2023-08-03 06:32:36.807913	Sunday	1030	1130	285	\N	\N	\N	\N
2015	2023-08-03 06:32:36.832328	2023-08-03 06:32:36.832328	Friday	930	1815	286	\N	\N	\N	\N
2016	2023-08-03 06:32:36.834302	2023-08-03 06:32:36.834302	Saturday	930	2045	286	\N	\N	\N	\N
2017	2023-08-03 06:32:36.835965	2023-08-03 06:32:36.835965	Sunday	1900	145	286	\N	\N	\N	\N
2018	2023-08-03 06:32:36.848218	2023-08-03 06:32:36.848218	Tuesday	615	2200	287	\N	\N	\N	\N
2019	2023-08-03 06:32:36.850269	2023-08-03 06:32:36.850269	Wednesday	1930	130	287	\N	\N	\N	\N
2020	2023-08-03 06:32:36.853486	2023-08-03 06:32:36.853486	Thursday	1530	215	287	\N	\N	\N	\N
2021	2023-08-03 06:32:36.855579	2023-08-03 06:32:36.855579	Friday	915	1415	287	\N	\N	\N	\N
2022	2023-08-03 06:32:36.857461	2023-08-03 06:32:36.857461	Saturday	615	2330	287	\N	\N	\N	\N
2023	2023-08-03 06:32:36.859392	2023-08-03 06:32:36.859392	Sunday	930	1930	287	\N	\N	\N	\N
2024	2023-08-03 06:32:36.885936	2023-08-03 06:32:36.885936	Monday	1300	1915	288	\N	\N	\N	\N
2025	2023-08-03 06:32:36.888196	2023-08-03 06:32:36.888196	Monday	1930	2100	288	\N	\N	\N	\N
2026	2023-08-03 06:32:36.889949	2023-08-03 06:32:36.889949	Tuesday	830	1530	288	\N	\N	\N	\N
2027	2023-08-03 06:32:36.891764	2023-08-03 06:32:36.891764	Wednesday	715	2300	288	\N	\N	\N	\N
2028	2023-08-03 06:32:36.893372	2023-08-03 06:32:36.893372	Thursday	115	530	288	\N	\N	\N	\N
2029	2023-08-03 06:32:36.894798	2023-08-03 06:32:36.894798	Thursday	615	2315	288	\N	\N	\N	\N
2030	2023-08-03 06:32:36.896273	2023-08-03 06:32:36.896273	Saturday	900	1530	288	\N	\N	\N	\N
2031	2023-08-03 06:32:36.906164	2023-08-03 06:32:36.906164	Monday	2000	345	289	\N	\N	\N	\N
2032	2023-08-03 06:32:36.907731	2023-08-03 06:32:36.907731	Wednesday	900	2015	289	\N	\N	\N	\N
2033	2023-08-03 06:32:36.909238	2023-08-03 06:32:36.909238	Thursday	945	1730	289	\N	\N	\N	\N
2034	2023-08-03 06:32:36.910708	2023-08-03 06:32:36.910708	Friday	545	830	289	\N	\N	\N	\N
2035	2023-08-03 06:32:36.912172	2023-08-03 06:32:36.912172	Friday	1930	2330	289	\N	\N	\N	\N
2036	2023-08-03 06:32:36.91387	2023-08-03 06:32:36.91387	Saturday	745	1830	289	\N	\N	\N	\N
2037	2023-08-03 06:32:36.91528	2023-08-03 06:32:36.91528	Sunday	915	2100	289	\N	\N	\N	\N
2038	2023-08-03 06:32:36.942224	2023-08-03 06:32:36.942224	Monday	945	1745	290	\N	\N	\N	\N
2039	2023-08-03 06:32:36.944183	2023-08-03 06:32:36.944183	Tuesday	615	2200	290	\N	\N	\N	\N
2040	2023-08-03 06:32:36.946335	2023-08-03 06:32:36.946335	Wednesday	1800	200	290	\N	\N	\N	\N
2041	2023-08-03 06:32:36.948024	2023-08-03 06:32:36.948024	Thursday	800	1400	290	\N	\N	\N	\N
2042	2023-08-03 06:32:36.949732	2023-08-03 06:32:36.949732	Saturday	730	2100	290	\N	\N	\N	\N
2043	2023-08-03 06:32:36.951424	2023-08-03 06:32:36.951424	Sunday	830	1845	290	\N	\N	\N	\N
2044	2023-08-03 06:32:36.962845	2023-08-03 06:32:36.962845	Monday	615	1445	291	\N	\N	\N	\N
2045	2023-08-03 06:32:36.964958	2023-08-03 06:32:36.964958	Wednesday	830	2115	291	\N	\N	\N	\N
2046	2023-08-03 06:32:36.96684	2023-08-03 06:32:36.96684	Friday	715	1700	291	\N	\N	\N	\N
2047	2023-08-03 06:32:36.968893	2023-08-03 06:32:36.968893	Saturday	615	2115	291	\N	\N	\N	\N
2048	2023-08-03 06:32:36.971039	2023-08-03 06:32:36.971039	Sunday	1900	100	291	\N	\N	\N	\N
2049	2023-08-03 06:32:37.000228	2023-08-03 06:32:37.000228	Monday	500	630	292	\N	\N	\N	\N
2050	2023-08-03 06:32:37.001775	2023-08-03 06:32:37.001775	Monday	1415	1845	292	\N	\N	\N	\N
2051	2023-08-03 06:32:37.003495	2023-08-03 06:32:37.003495	Wednesday	715	1400	292	\N	\N	\N	\N
2052	2023-08-03 06:32:37.005292	2023-08-03 06:32:37.005292	Wednesday	2000	2015	292	\N	\N	\N	\N
2053	2023-08-03 06:32:37.006925	2023-08-03 06:32:37.006925	Thursday	215	1100	292	\N	\N	\N	\N
2054	2023-08-03 06:32:37.008768	2023-08-03 06:32:37.008768	Thursday	1200	2345	292	\N	\N	\N	\N
2055	2023-08-03 06:32:37.010412	2023-08-03 06:32:37.010412	Friday	1515	130	292	\N	\N	\N	\N
2056	2023-08-03 06:32:37.011918	2023-08-03 06:32:37.011918	Sunday	745	2030	292	\N	\N	\N	\N
2057	2023-08-03 06:32:37.023214	2023-08-03 06:32:37.023214	Monday	1300	1630	293	\N	\N	\N	\N
2058	2023-08-03 06:32:37.025049	2023-08-03 06:32:37.025049	Monday	1700	2145	293	\N	\N	\N	\N
2059	2023-08-03 06:32:37.026632	2023-08-03 06:32:37.026632	Tuesday	745	2345	293	\N	\N	\N	\N
2060	2023-08-03 06:32:37.028246	2023-08-03 06:32:37.028246	Thursday	600	1800	293	\N	\N	\N	\N
2061	2023-08-03 06:32:37.030086	2023-08-03 06:32:37.030086	Friday	745	2230	293	\N	\N	\N	\N
2062	2023-08-03 06:32:37.031772	2023-08-03 06:32:37.031772	Saturday	800	2045	293	\N	\N	\N	\N
2063	2023-08-03 06:32:37.033518	2023-08-03 06:32:37.033518	Sunday	2200	330	293	\N	\N	\N	\N
2064	2023-08-03 06:32:37.058456	2023-08-03 06:32:37.058456	Monday	2100	200	294	\N	\N	\N	\N
2065	2023-08-03 06:32:37.060081	2023-08-03 06:32:37.060081	Wednesday	930	1130	294	\N	\N	\N	\N
2066	2023-08-03 06:32:37.061714	2023-08-03 06:32:37.061714	Wednesday	1630	445	294	\N	\N	\N	\N
2067	2023-08-03 06:32:37.063637	2023-08-03 06:32:37.063637	Thursday	930	1630	294	\N	\N	\N	\N
2068	2023-08-03 06:32:37.065235	2023-08-03 06:32:37.065235	Friday	1515	330	294	\N	\N	\N	\N
2069	2023-08-03 06:32:37.066796	2023-08-03 06:32:37.066796	Saturday	615	1930	294	\N	\N	\N	\N
2070	2023-08-03 06:32:37.068237	2023-08-03 06:32:37.068237	Sunday	700	1030	294	\N	\N	\N	\N
2071	2023-08-03 06:32:37.069575	2023-08-03 06:32:37.069575	Sunday	1330	1400	294	\N	\N	\N	\N
2072	2023-08-03 06:32:37.080578	2023-08-03 06:32:37.080578	Tuesday	945	2345	295	\N	\N	\N	\N
2073	2023-08-03 06:32:37.082305	2023-08-03 06:32:37.082305	Wednesday	715	1515	295	\N	\N	\N	\N
2074	2023-08-03 06:32:37.083822	2023-08-03 06:32:37.083822	Thursday	345	1400	295	\N	\N	\N	\N
2075	2023-08-03 06:32:37.08537	2023-08-03 06:32:37.08537	Thursday	1715	1900	295	\N	\N	\N	\N
2076	2023-08-03 06:32:37.086873	2023-08-03 06:32:37.086873	Friday	2215	345	295	\N	\N	\N	\N
2077	2023-08-03 06:32:37.089482	2023-08-03 06:32:37.089482	Saturday	1000	1745	295	\N	\N	\N	\N
2078	2023-08-03 06:32:37.093069	2023-08-03 06:32:37.093069	Sunday	700	1730	295	\N	\N	\N	\N
2079	2023-08-03 06:32:37.095028	2023-08-03 06:32:37.095028	Sunday	2100	100	295	\N	\N	\N	\N
2080	2023-08-03 06:32:37.119875	2023-08-03 06:32:37.119875	Tuesday	500	830	296	\N	\N	\N	\N
2081	2023-08-03 06:32:37.121583	2023-08-03 06:32:37.121583	Tuesday	1145	2400	296	\N	\N	\N	\N
2082	2023-08-03 06:32:37.123558	2023-08-03 06:32:37.123558	Thursday	1830	230	296	\N	\N	\N	\N
2083	2023-08-03 06:32:37.125269	2023-08-03 06:32:37.125269	Friday	1515	100	296	\N	\N	\N	\N
2084	2023-08-03 06:32:37.127036	2023-08-03 06:32:37.127036	Saturday	930	1400	296	\N	\N	\N	\N
2085	2023-08-03 06:32:37.153214	2023-08-03 06:32:37.153214	Monday	400	830	297	\N	\N	\N	\N
2086	2023-08-03 06:32:37.154956	2023-08-03 06:32:37.154956	Monday	1545	2345	297	\N	\N	\N	\N
2087	2023-08-03 06:32:37.156636	2023-08-03 06:32:37.156636	Tuesday	830	1100	297	\N	\N	\N	\N
2088	2023-08-03 06:32:37.15811	2023-08-03 06:32:37.15811	Tuesday	1145	2345	297	\N	\N	\N	\N
2089	2023-08-03 06:32:37.159942	2023-08-03 06:32:37.159942	Wednesday	1545	245	297	\N	\N	\N	\N
2090	2023-08-03 06:32:37.161435	2023-08-03 06:32:37.161435	Thursday	930	2315	297	\N	\N	\N	\N
2091	2023-08-03 06:32:37.162983	2023-08-03 06:32:37.162983	Saturday	845	2215	297	\N	\N	\N	\N
2092	2023-08-03 06:32:37.164612	2023-08-03 06:32:37.164612	Sunday	830	2145	297	\N	\N	\N	\N
2093	2023-08-03 06:32:37.175968	2023-08-03 06:32:37.175968	Tuesday	15	545	298	\N	\N	\N	\N
2094	2023-08-03 06:32:37.177597	2023-08-03 06:32:37.177597	Tuesday	1630	2245	298	\N	\N	\N	\N
2095	2023-08-03 06:32:37.179157	2023-08-03 06:32:37.179157	Wednesday	1600	2115	298	\N	\N	\N	\N
2096	2023-08-03 06:32:37.180688	2023-08-03 06:32:37.180688	Wednesday	2145	515	298	\N	\N	\N	\N
2097	2023-08-03 06:32:37.18225	2023-08-03 06:32:37.18225	Thursday	930	1915	298	\N	\N	\N	\N
2098	2023-08-03 06:32:37.183825	2023-08-03 06:32:37.183825	Friday	930	2315	298	\N	\N	\N	\N
2099	2023-08-03 06:32:37.185324	2023-08-03 06:32:37.185324	Saturday	945	1545	298	\N	\N	\N	\N
2100	2023-08-03 06:32:37.186861	2023-08-03 06:32:37.186861	Sunday	315	1815	298	\N	\N	\N	\N
2101	2023-08-03 06:32:37.188887	2023-08-03 06:32:37.188887	Sunday	2015	0	298	\N	\N	\N	\N
2102	2023-08-03 06:32:37.207483	2023-08-03 06:32:37.207483	Monday	1500	200	299	\N	\N	\N	\N
2103	2023-08-03 06:32:37.209181	2023-08-03 06:32:37.209181	Tuesday	930	1900	299	\N	\N	\N	\N
2104	2023-08-03 06:32:37.210935	2023-08-03 06:32:37.210935	Wednesday	715	2330	299	\N	\N	\N	\N
2105	2023-08-03 06:32:37.212627	2023-08-03 06:32:37.212627	Thursday	0	930	299	\N	\N	\N	\N
2106	2023-08-03 06:32:37.214384	2023-08-03 06:32:37.214384	Thursday	1215	1615	299	\N	\N	\N	\N
2107	2023-08-03 06:32:37.216055	2023-08-03 06:32:37.216055	Friday	800	2030	299	\N	\N	\N	\N
2108	2023-08-03 06:32:37.217854	2023-08-03 06:32:37.217854	Saturday	830	1600	299	\N	\N	\N	\N
2109	2023-08-03 06:32:37.219633	2023-08-03 06:32:37.219633	Sunday	330	345	299	\N	\N	\N	\N
2110	2023-08-03 06:32:37.221401	2023-08-03 06:32:37.221401	Sunday	1530	1915	299	\N	\N	\N	\N
2111	2023-08-03 06:32:37.248101	2023-08-03 06:32:37.248101	Tuesday	815	2215	300	\N	\N	\N	\N
2112	2023-08-03 06:32:37.249962	2023-08-03 06:32:37.249962	Thursday	900	1915	300	\N	\N	\N	\N
2113	2023-08-03 06:32:37.251496	2023-08-03 06:32:37.251496	Friday	815	1600	300	\N	\N	\N	\N
2114	2023-08-03 06:32:37.252918	2023-08-03 06:32:37.252918	Saturday	630	1615	300	\N	\N	\N	\N
2115	2023-08-03 06:32:37.25442	2023-08-03 06:32:37.25442	Sunday	1530	330	300	\N	\N	\N	\N
2116	2023-08-03 06:32:37.26574	2023-08-03 06:32:37.26574	Monday	1515	400	301	\N	\N	\N	\N
2117	2023-08-03 06:32:37.267289	2023-08-03 06:32:37.267289	Tuesday	730	1745	301	\N	\N	\N	\N
2118	2023-08-03 06:32:37.268682	2023-08-03 06:32:37.268682	Tuesday	2215	2230	301	\N	\N	\N	\N
2119	2023-08-03 06:32:37.270097	2023-08-03 06:32:37.270097	Wednesday	730	2300	301	\N	\N	\N	\N
2120	2023-08-03 06:32:37.271535	2023-08-03 06:32:37.271535	Thursday	800	2145	301	\N	\N	\N	\N
2121	2023-08-03 06:32:37.27299	2023-08-03 06:32:37.27299	Friday	1045	1415	301	\N	\N	\N	\N
2122	2023-08-03 06:32:37.274445	2023-08-03 06:32:37.274445	Friday	2130	445	301	\N	\N	\N	\N
2123	2023-08-03 06:32:37.276153	2023-08-03 06:32:37.276153	Saturday	945	1900	301	\N	\N	\N	\N
2124	2023-08-03 06:32:37.277587	2023-08-03 06:32:37.277587	Sunday	630	2130	301	\N	\N	\N	\N
2125	2023-08-03 06:32:37.295327	2023-08-03 06:32:37.295327	Monday	700	1845	302	\N	\N	\N	\N
2126	2023-08-03 06:32:37.296873	2023-08-03 06:32:37.296873	Tuesday	1845	345	302	\N	\N	\N	\N
2127	2023-08-03 06:32:37.298362	2023-08-03 06:32:37.298362	Wednesday	945	1500	302	\N	\N	\N	\N
2128	2023-08-03 06:32:37.299886	2023-08-03 06:32:37.299886	Thursday	600	1700	302	\N	\N	\N	\N
2129	2023-08-03 06:32:37.301589	2023-08-03 06:32:37.301589	Saturday	1945	145	302	\N	\N	\N	\N
2130	2023-08-03 06:32:37.303151	2023-08-03 06:32:37.303151	Sunday	100	345	302	\N	\N	\N	\N
2131	2023-08-03 06:32:37.304781	2023-08-03 06:32:37.304781	Sunday	1145	1600	302	\N	\N	\N	\N
2132	2023-08-03 06:32:37.326573	2023-08-03 06:32:37.326573	Monday	745	1645	303	\N	\N	\N	\N
2133	2023-08-03 06:32:37.328152	2023-08-03 06:32:37.328152	Tuesday	2100	300	303	\N	\N	\N	\N
2134	2023-08-03 06:32:37.330003	2023-08-03 06:32:37.330003	Wednesday	630	1500	303	\N	\N	\N	\N
2135	2023-08-03 06:32:37.331572	2023-08-03 06:32:37.331572	Thursday	1645	215	303	\N	\N	\N	\N
2136	2023-08-03 06:32:37.333211	2023-08-03 06:32:37.333211	Friday	2045	130	303	\N	\N	\N	\N
2137	2023-08-03 06:32:37.334988	2023-08-03 06:32:37.334988	Sunday	800	1515	303	\N	\N	\N	\N
2138	2023-08-03 06:32:37.344891	2023-08-03 06:32:37.344891	Monday	630	2300	304	\N	\N	\N	\N
2139	2023-08-03 06:32:37.346532	2023-08-03 06:32:37.346532	Wednesday	1830	2145	304	\N	\N	\N	\N
2140	2023-08-03 06:32:37.347978	2023-08-03 06:32:37.347978	Wednesday	2315	1300	304	\N	\N	\N	\N
2141	2023-08-03 06:32:37.34942	2023-08-03 06:32:37.34942	Thursday	945	1615	304	\N	\N	\N	\N
2142	2023-08-03 06:32:37.350896	2023-08-03 06:32:37.350896	Friday	745	2245	304	\N	\N	\N	\N
2143	2023-08-03 06:32:37.352439	2023-08-03 06:32:37.352439	Saturday	800	930	304	\N	\N	\N	\N
2144	2023-08-03 06:32:37.353915	2023-08-03 06:32:37.353915	Saturday	1145	1530	304	\N	\N	\N	\N
2145	2023-08-03 06:32:37.355376	2023-08-03 06:32:37.355376	Sunday	630	1400	304	\N	\N	\N	\N
2146	2023-08-03 06:32:37.372276	2023-08-03 06:32:37.372276	Monday	900	2300	305	\N	\N	\N	\N
2147	2023-08-03 06:32:37.373713	2023-08-03 06:32:37.373713	Tuesday	715	1900	305	\N	\N	\N	\N
2148	2023-08-03 06:32:37.375174	2023-08-03 06:32:37.375174	Thursday	745	1515	305	\N	\N	\N	\N
2149	2023-08-03 06:32:37.3766	2023-08-03 06:32:37.3766	Friday	930	2245	305	\N	\N	\N	\N
2150	2023-08-03 06:32:37.378064	2023-08-03 06:32:37.378064	Saturday	615	1745	305	\N	\N	\N	\N
2151	2023-08-03 06:32:37.379506	2023-08-03 06:32:37.379506	Sunday	730	1545	305	\N	\N	\N	\N
2152	2023-08-03 06:32:37.400484	2023-08-03 06:32:37.400484	Monday	15	200	306	\N	\N	\N	\N
2153	2023-08-03 06:32:37.401909	2023-08-03 06:32:37.401909	Monday	600	2345	306	\N	\N	\N	\N
2154	2023-08-03 06:32:37.403346	2023-08-03 06:32:37.403346	Tuesday	845	1000	306	\N	\N	\N	\N
2155	2023-08-03 06:32:37.404722	2023-08-03 06:32:37.404722	Tuesday	1230	1415	306	\N	\N	\N	\N
2156	2023-08-03 06:32:37.406054	2023-08-03 06:32:37.406054	Wednesday	715	1515	306	\N	\N	\N	\N
2157	2023-08-03 06:32:37.407474	2023-08-03 06:32:37.407474	Friday	830	1700	306	\N	\N	\N	\N
2158	2023-08-03 06:32:37.40895	2023-08-03 06:32:37.40895	Saturday	2100	400	306	\N	\N	\N	\N
2159	2023-08-03 06:32:37.419417	2023-08-03 06:32:37.419417	Tuesday	600	2245	307	\N	\N	\N	\N
2160	2023-08-03 06:32:37.420819	2023-08-03 06:32:37.420819	Wednesday	815	1930	307	\N	\N	\N	\N
2161	2023-08-03 06:32:37.422206	2023-08-03 06:32:37.422206	Thursday	830	1745	307	\N	\N	\N	\N
2162	2023-08-03 06:32:37.423734	2023-08-03 06:32:37.423734	Friday	745	2045	307	\N	\N	\N	\N
2163	2023-08-03 06:32:37.42515	2023-08-03 06:32:37.42515	Saturday	730	800	307	\N	\N	\N	\N
2164	2023-08-03 06:32:37.426479	2023-08-03 06:32:37.426479	Saturday	1245	2215	307	\N	\N	\N	\N
2165	2023-08-03 06:32:37.427905	2023-08-03 06:32:37.427905	Sunday	730	1945	307	\N	\N	\N	\N
2166	2023-08-03 06:32:37.449146	2023-08-03 06:32:37.449146	Monday	2015	345	308	\N	\N	\N	\N
2167	2023-08-03 06:32:37.450593	2023-08-03 06:32:37.450593	Tuesday	0	515	308	\N	\N	\N	\N
2168	2023-08-03 06:32:37.451931	2023-08-03 06:32:37.451931	Tuesday	1300	1930	308	\N	\N	\N	\N
2169	2023-08-03 06:32:37.453314	2023-08-03 06:32:37.453314	Wednesday	600	2230	308	\N	\N	\N	\N
2170	2023-08-03 06:32:37.454737	2023-08-03 06:32:37.454737	Friday	500	1400	308	\N	\N	\N	\N
2171	2023-08-03 06:32:37.456093	2023-08-03 06:32:37.456093	Friday	2200	115	308	\N	\N	\N	\N
2172	2023-08-03 06:32:37.457559	2023-08-03 06:32:37.457559	Saturday	500	1015	308	\N	\N	\N	\N
2173	2023-08-03 06:32:37.458997	2023-08-03 06:32:37.458997	Saturday	1845	2145	308	\N	\N	\N	\N
2174	2023-08-03 06:32:37.460601	2023-08-03 06:32:37.460601	Sunday	845	1430	308	\N	\N	\N	\N
2175	2023-08-03 06:32:37.471118	2023-08-03 06:32:37.471118	Monday	645	1400	309	\N	\N	\N	\N
2176	2023-08-03 06:32:37.472589	2023-08-03 06:32:37.472589	Tuesday	2215	300	309	\N	\N	\N	\N
2177	2023-08-03 06:32:37.474198	2023-08-03 06:32:37.474198	Thursday	830	2045	309	\N	\N	\N	\N
2178	2023-08-03 06:32:37.475601	2023-08-03 06:32:37.475601	Friday	800	2030	309	\N	\N	\N	\N
2179	2023-08-03 06:32:37.477004	2023-08-03 06:32:37.477004	Saturday	445	715	309	\N	\N	\N	\N
2180	2023-08-03 06:32:37.47831	2023-08-03 06:32:37.47831	Saturday	1500	2345	309	\N	\N	\N	\N
2181	2023-08-03 06:32:37.479698	2023-08-03 06:32:37.479698	Sunday	815	1545	309	\N	\N	\N	\N
2182	2023-08-03 06:32:37.500435	2023-08-03 06:32:37.500435	Monday	445	1115	310	\N	\N	\N	\N
2183	2023-08-03 06:32:37.502061	2023-08-03 06:32:37.502061	Monday	1145	1400	310	\N	\N	\N	\N
2184	2023-08-03 06:32:37.50347	2023-08-03 06:32:37.50347	Wednesday	2115	400	310	\N	\N	\N	\N
2185	2023-08-03 06:32:37.504832	2023-08-03 06:32:37.504832	Thursday	1445	330	310	\N	\N	\N	\N
2186	2023-08-03 06:32:37.506202	2023-08-03 06:32:37.506202	Friday	845	1430	310	\N	\N	\N	\N
2187	2023-08-03 06:32:37.507626	2023-08-03 06:32:37.507626	Saturday	900	2130	310	\N	\N	\N	\N
2188	2023-08-03 06:32:37.509072	2023-08-03 06:32:37.509072	Sunday	700	745	310	\N	\N	\N	\N
2189	2023-08-03 06:32:37.510374	2023-08-03 06:32:37.510374	Sunday	1315	2345	310	\N	\N	\N	\N
2190	2023-08-03 06:32:37.520248	2023-08-03 06:32:37.520248	Tuesday	2115	100	311	\N	\N	\N	\N
2191	2023-08-03 06:32:37.521649	2023-08-03 06:32:37.521649	Wednesday	930	2230	311	\N	\N	\N	\N
2192	2023-08-03 06:32:37.523126	2023-08-03 06:32:37.523126	Thursday	800	1545	311	\N	\N	\N	\N
2193	2023-08-03 06:32:37.524586	2023-08-03 06:32:37.524586	Friday	700	2115	311	\N	\N	\N	\N
2194	2023-08-03 06:32:37.526206	2023-08-03 06:32:37.526206	Saturday	830	2330	311	\N	\N	\N	\N
2195	2023-08-03 06:32:37.527606	2023-08-03 06:32:37.527606	Sunday	2245	115	311	\N	\N	\N	\N
2196	2023-08-03 06:32:37.547712	2023-08-03 06:32:37.547712	Tuesday	500	530	312	\N	\N	\N	\N
2197	2023-08-03 06:32:37.549267	2023-08-03 06:32:37.549267	Tuesday	1215	1330	312	\N	\N	\N	\N
2198	2023-08-03 06:32:37.55078	2023-08-03 06:32:37.55078	Wednesday	730	2215	312	\N	\N	\N	\N
2199	2023-08-03 06:32:37.552563	2023-08-03 06:32:37.552563	Thursday	615	2045	312	\N	\N	\N	\N
2200	2023-08-03 06:32:37.554002	2023-08-03 06:32:37.554002	Friday	845	2245	312	\N	\N	\N	\N
2201	2023-08-03 06:32:37.555444	2023-08-03 06:32:37.555444	Saturday	745	2200	312	\N	\N	\N	\N
2202	2023-08-03 06:32:37.565834	2023-08-03 06:32:37.565834	Monday	845	2245	313	\N	\N	\N	\N
2203	2023-08-03 06:32:37.567226	2023-08-03 06:32:37.567226	Tuesday	915	1500	313	\N	\N	\N	\N
2204	2023-08-03 06:32:37.568584	2023-08-03 06:32:37.568584	Wednesday	745	1400	313	\N	\N	\N	\N
2205	2023-08-03 06:32:37.57006	2023-08-03 06:32:37.57006	Thursday	200	300	313	\N	\N	\N	\N
2206	2023-08-03 06:32:37.571434	2023-08-03 06:32:37.571434	Thursday	1600	1930	313	\N	\N	\N	\N
2207	2023-08-03 06:32:37.572839	2023-08-03 06:32:37.572839	Friday	1745	100	313	\N	\N	\N	\N
2208	2023-08-03 06:32:37.574349	2023-08-03 06:32:37.574349	Saturday	630	2115	313	\N	\N	\N	\N
2209	2023-08-03 06:32:37.57584	2023-08-03 06:32:37.57584	Sunday	1630	215	313	\N	\N	\N	\N
2210	2023-08-03 06:32:37.598129	2023-08-03 06:32:37.598129	Tuesday	645	2400	314	\N	\N	\N	\N
2211	2023-08-03 06:32:37.599739	2023-08-03 06:32:37.599739	Wednesday	700	1545	314	\N	\N	\N	\N
2212	2023-08-03 06:32:37.601259	2023-08-03 06:32:37.601259	Thursday	1630	200	314	\N	\N	\N	\N
2213	2023-08-03 06:32:37.602861	2023-08-03 06:32:37.602861	Friday	730	1715	314	\N	\N	\N	\N
2214	2023-08-03 06:32:37.604413	2023-08-03 06:32:37.604413	Friday	2030	2315	314	\N	\N	\N	\N
2215	2023-08-03 06:32:37.606193	2023-08-03 06:32:37.606193	Saturday	830	1030	314	\N	\N	\N	\N
2216	2023-08-03 06:32:37.607606	2023-08-03 06:32:37.607606	Saturday	1515	1545	314	\N	\N	\N	\N
2217	2023-08-03 06:32:37.609091	2023-08-03 06:32:37.609091	Sunday	745	2230	314	\N	\N	\N	\N
2218	2023-08-03 06:32:37.62162	2023-08-03 06:32:37.62162	Monday	230	415	315	\N	\N	\N	\N
2219	2023-08-03 06:32:37.623218	2023-08-03 06:32:37.623218	Monday	430	2400	315	\N	\N	\N	\N
2220	2023-08-03 06:32:37.624683	2023-08-03 06:32:37.624683	Thursday	845	1600	315	\N	\N	\N	\N
2221	2023-08-03 06:32:37.626092	2023-08-03 06:32:37.626092	Friday	2200	230	315	\N	\N	\N	\N
2222	2023-08-03 06:32:37.627616	2023-08-03 06:32:37.627616	Sunday	800	1945	315	\N	\N	\N	\N
2223	2023-08-03 06:32:37.643937	2023-08-03 06:32:37.643937	Tuesday	1000	1445	316	\N	\N	\N	\N
2224	2023-08-03 06:32:37.645333	2023-08-03 06:32:37.645333	Wednesday	800	2145	316	\N	\N	\N	\N
2225	2023-08-03 06:32:37.64679	2023-08-03 06:32:37.64679	Thursday	630	830	316	\N	\N	\N	\N
2226	2023-08-03 06:32:37.648796	2023-08-03 06:32:37.648796	Thursday	900	400	316	\N	\N	\N	\N
2227	2023-08-03 06:32:37.6502	2023-08-03 06:32:37.6502	Friday	615	1630	316	\N	\N	\N	\N
2228	2023-08-03 06:32:37.651608	2023-08-03 06:32:37.651608	Saturday	300	730	316	\N	\N	\N	\N
2229	2023-08-03 06:32:37.653018	2023-08-03 06:32:37.653018	Saturday	2100	2200	316	\N	\N	\N	\N
2230	2023-08-03 06:32:37.654473	2023-08-03 06:32:37.654473	Sunday	900	1930	316	\N	\N	\N	\N
2231	2023-08-03 06:32:37.655873	2023-08-03 06:32:37.655873	Sunday	2000	2315	316	\N	\N	\N	\N
2232	2023-08-03 06:32:37.677113	2023-08-03 06:32:37.677113	Monday	800	1900	317	\N	\N	\N	\N
2233	2023-08-03 06:32:37.678623	2023-08-03 06:32:37.678623	Tuesday	1615	300	317	\N	\N	\N	\N
2234	2023-08-03 06:32:37.680052	2023-08-03 06:32:37.680052	Wednesday	1845	100	317	\N	\N	\N	\N
2235	2023-08-03 06:32:37.681403	2023-08-03 06:32:37.681403	Thursday	745	2000	317	\N	\N	\N	\N
2236	2023-08-03 06:32:37.682874	2023-08-03 06:32:37.682874	Friday	30	1245	317	\N	\N	\N	\N
2237	2023-08-03 06:32:37.684299	2023-08-03 06:32:37.684299	Friday	1645	2000	317	\N	\N	\N	\N
2238	2023-08-03 06:32:37.685723	2023-08-03 06:32:37.685723	Saturday	845	2215	317	\N	\N	\N	\N
2239	2023-08-03 06:32:37.687521	2023-08-03 06:32:37.687521	Sunday	830	2015	317	\N	\N	\N	\N
2240	2023-08-03 06:32:37.697136	2023-08-03 06:32:37.697136	Monday	830	1400	318	\N	\N	\N	\N
2241	2023-08-03 06:32:37.698763	2023-08-03 06:32:37.698763	Tuesday	945	1945	318	\N	\N	\N	\N
2242	2023-08-03 06:32:37.700178	2023-08-03 06:32:37.700178	Wednesday	930	1930	318	\N	\N	\N	\N
2243	2023-08-03 06:32:37.701567	2023-08-03 06:32:37.701567	Thursday	2000	230	318	\N	\N	\N	\N
2244	2023-08-03 06:32:37.702892	2023-08-03 06:32:37.702892	Friday	830	2115	318	\N	\N	\N	\N
2245	2023-08-03 06:32:37.704289	2023-08-03 06:32:37.704289	Saturday	1930	215	318	\N	\N	\N	\N
2246	2023-08-03 06:32:37.724508	2023-08-03 06:32:37.724508	Monday	645	2015	319	\N	\N	\N	\N
2247	2023-08-03 06:32:37.72593	2023-08-03 06:32:37.72593	Tuesday	930	1845	319	\N	\N	\N	\N
2248	2023-08-03 06:32:37.727314	2023-08-03 06:32:37.727314	Thursday	915	2145	319	\N	\N	\N	\N
2249	2023-08-03 06:32:37.728709	2023-08-03 06:32:37.728709	Friday	1715	245	319	\N	\N	\N	\N
2250	2023-08-03 06:32:37.730028	2023-08-03 06:32:37.730028	Saturday	630	1615	319	\N	\N	\N	\N
2251	2023-08-03 06:32:37.731364	2023-08-03 06:32:37.731364	Sunday	2100	200	319	\N	\N	\N	\N
2252	2023-08-03 06:32:37.741231	2023-08-03 06:32:37.741231	Monday	800	1915	320	\N	\N	\N	\N
2253	2023-08-03 06:32:37.742602	2023-08-03 06:32:37.742602	Tuesday	600	1700	320	\N	\N	\N	\N
2254	2023-08-03 06:32:37.744158	2023-08-03 06:32:37.744158	Thursday	915	1800	320	\N	\N	\N	\N
2255	2023-08-03 06:32:37.745516	2023-08-03 06:32:37.745516	Friday	815	2300	320	\N	\N	\N	\N
2256	2023-08-03 06:32:37.74684	2023-08-03 06:32:37.74684	Saturday	815	1145	320	\N	\N	\N	\N
2257	2023-08-03 06:32:37.748388	2023-08-03 06:32:37.748388	Saturday	1845	2115	320	\N	\N	\N	\N
2258	2023-08-03 06:32:37.768428	2023-08-03 06:32:37.768428	Monday	930	1915	321	\N	\N	\N	\N
2259	2023-08-03 06:32:37.769842	2023-08-03 06:32:37.769842	Tuesday	630	1830	321	\N	\N	\N	\N
2260	2023-08-03 06:32:37.771206	2023-08-03 06:32:37.771206	Wednesday	1730	215	321	\N	\N	\N	\N
2261	2023-08-03 06:32:37.772596	2023-08-03 06:32:37.772596	Thursday	1400	330	321	\N	\N	\N	\N
2262	2023-08-03 06:32:37.774213	2023-08-03 06:32:37.774213	Friday	1915	400	321	\N	\N	\N	\N
2263	2023-08-03 06:32:37.775605	2023-08-03 06:32:37.775605	Saturday	745	2030	321	\N	\N	\N	\N
2264	2023-08-03 06:32:37.777564	2023-08-03 06:32:37.777564	Sunday	600	1930	321	\N	\N	\N	\N
2265	2023-08-03 06:32:37.787682	2023-08-03 06:32:37.787682	Monday	515	1945	322	\N	\N	\N	\N
2266	2023-08-03 06:32:37.789183	2023-08-03 06:32:37.789183	Monday	2015	2245	322	\N	\N	\N	\N
2267	2023-08-03 06:32:37.790661	2023-08-03 06:32:37.790661	Wednesday	1500	300	322	\N	\N	\N	\N
2268	2023-08-03 06:32:37.79221	2023-08-03 06:32:37.79221	Thursday	730	1430	322	\N	\N	\N	\N
2269	2023-08-03 06:32:37.793584	2023-08-03 06:32:37.793584	Friday	615	2200	322	\N	\N	\N	\N
2270	2023-08-03 06:32:37.79504	2023-08-03 06:32:37.79504	Saturday	815	2315	322	\N	\N	\N	\N
2271	2023-08-03 06:32:37.796425	2023-08-03 06:32:37.796425	Sunday	1000	1845	322	\N	\N	\N	\N
2272	2023-08-03 06:32:37.819716	2023-08-03 06:32:37.819716	Monday	930	1400	323	\N	\N	\N	\N
2273	2023-08-03 06:32:37.821179	2023-08-03 06:32:37.821179	Wednesday	215	400	323	\N	\N	\N	\N
2274	2023-08-03 06:32:37.822558	2023-08-03 06:32:37.822558	Wednesday	2330	200	323	\N	\N	\N	\N
2275	2023-08-03 06:32:37.823976	2023-08-03 06:32:37.823976	Thursday	2000	2200	323	\N	\N	\N	\N
2276	2023-08-03 06:32:37.825296	2023-08-03 06:32:37.825296	Thursday	2330	1630	323	\N	\N	\N	\N
2277	2023-08-03 06:32:37.826857	2023-08-03 06:32:37.826857	Saturday	630	2245	323	\N	\N	\N	\N
2278	2023-08-03 06:32:37.836477	2023-08-03 06:32:37.836477	Monday	715	1715	324	\N	\N	\N	\N
2279	2023-08-03 06:32:37.83792	2023-08-03 06:32:37.83792	Thursday	2200	330	324	\N	\N	\N	\N
2280	2023-08-03 06:32:37.839576	2023-08-03 06:32:37.839576	Friday	700	2015	324	\N	\N	\N	\N
2281	2023-08-03 06:32:37.841003	2023-08-03 06:32:37.841003	Saturday	1645	130	324	\N	\N	\N	\N
2282	2023-08-03 06:32:37.842424	2023-08-03 06:32:37.842424	Sunday	45	500	324	\N	\N	\N	\N
2283	2023-08-03 06:32:37.843778	2023-08-03 06:32:37.843778	Sunday	1215	1730	324	\N	\N	\N	\N
2284	2023-08-03 06:32:37.859803	2023-08-03 06:32:37.859803	Monday	745	1745	325	\N	\N	\N	\N
2285	2023-08-03 06:32:37.861211	2023-08-03 06:32:37.861211	Wednesday	1000	2200	325	\N	\N	\N	\N
2286	2023-08-03 06:32:37.862542	2023-08-03 06:32:37.862542	Friday	2230	400	325	\N	\N	\N	\N
2287	2023-08-03 06:32:37.863834	2023-08-03 06:32:37.863834	Saturday	845	2345	325	\N	\N	\N	\N
2288	2023-08-03 06:32:37.865374	2023-08-03 06:32:37.865374	Sunday	745	2130	325	\N	\N	\N	\N
2289	2023-08-03 06:32:37.887244	2023-08-03 06:32:37.887244	Monday	730	1900	326	\N	\N	\N	\N
2290	2023-08-03 06:32:37.888704	2023-08-03 06:32:37.888704	Tuesday	745	1415	326	\N	\N	\N	\N
2291	2023-08-03 06:32:37.890066	2023-08-03 06:32:37.890066	Thursday	2145	400	326	\N	\N	\N	\N
2292	2023-08-03 06:32:37.89164	2023-08-03 06:32:37.89164	Friday	930	2400	326	\N	\N	\N	\N
2293	2023-08-03 06:32:37.892991	2023-08-03 06:32:37.892991	Saturday	845	1600	326	\N	\N	\N	\N
2294	2023-08-03 06:32:37.894355	2023-08-03 06:32:37.894355	Sunday	700	1645	326	\N	\N	\N	\N
2295	2023-08-03 06:32:37.903969	2023-08-03 06:32:37.903969	Monday	945	2215	327	\N	\N	\N	\N
2296	2023-08-03 06:32:37.905651	2023-08-03 06:32:37.905651	Friday	930	1745	327	\N	\N	\N	\N
2297	2023-08-03 06:32:37.907086	2023-08-03 06:32:37.907086	Saturday	715	1530	327	\N	\N	\N	\N
2298	2023-08-03 06:32:37.908469	2023-08-03 06:32:37.908469	Sunday	945	2400	327	\N	\N	\N	\N
2299	2023-08-03 06:32:37.924424	2023-08-03 06:32:37.924424	Monday	1415	1815	328	\N	\N	\N	\N
2300	2023-08-03 06:32:37.925798	2023-08-03 06:32:37.925798	Monday	2400	1015	328	\N	\N	\N	\N
2301	2023-08-03 06:32:37.927287	2023-08-03 06:32:37.927287	Tuesday	1945	245	328	\N	\N	\N	\N
2302	2023-08-03 06:32:37.928717	2023-08-03 06:32:37.928717	Wednesday	845	1530	328	\N	\N	\N	\N
2303	2023-08-03 06:32:37.930512	2023-08-03 06:32:37.930512	Wednesday	1915	2030	328	\N	\N	\N	\N
2304	2023-08-03 06:32:37.931891	2023-08-03 06:32:37.931891	Thursday	2245	115	328	\N	\N	\N	\N
2305	2023-08-03 06:32:37.933295	2023-08-03 06:32:37.933295	Friday	715	1415	328	\N	\N	\N	\N
2306	2023-08-03 06:32:37.934664	2023-08-03 06:32:37.934664	Sunday	1900	315	328	\N	\N	\N	\N
2307	2023-08-03 06:32:37.954596	2023-08-03 06:32:37.954596	Monday	1000	2145	329	\N	\N	\N	\N
2308	2023-08-03 06:32:37.956398	2023-08-03 06:32:37.956398	Tuesday	1715	300	329	\N	\N	\N	\N
2309	2023-08-03 06:32:37.957908	2023-08-03 06:32:37.957908	Wednesday	930	1615	329	\N	\N	\N	\N
2310	2023-08-03 06:32:37.959325	2023-08-03 06:32:37.959325	Thursday	845	1415	329	\N	\N	\N	\N
2311	2023-08-03 06:32:37.960712	2023-08-03 06:32:37.960712	Friday	1630	1800	329	\N	\N	\N	\N
2312	2023-08-03 06:32:37.962099	2023-08-03 06:32:37.962099	Friday	2345	815	329	\N	\N	\N	\N
2313	2023-08-03 06:32:37.963582	2023-08-03 06:32:37.963582	Sunday	900	1215	329	\N	\N	\N	\N
2314	2023-08-03 06:32:37.964977	2023-08-03 06:32:37.964977	Sunday	1400	1530	329	\N	\N	\N	\N
2315	2023-08-03 06:32:37.974647	2023-08-03 06:32:37.974647	Monday	730	2215	330	\N	\N	\N	\N
2316	2023-08-03 06:32:37.976065	2023-08-03 06:32:37.976065	Tuesday	915	945	330	\N	\N	\N	\N
2317	2023-08-03 06:32:37.977442	2023-08-03 06:32:37.977442	Tuesday	1845	2400	330	\N	\N	\N	\N
2318	2023-08-03 06:32:37.978811	2023-08-03 06:32:37.978811	Wednesday	945	1600	330	\N	\N	\N	\N
2319	2023-08-03 06:32:37.980496	2023-08-03 06:32:37.980496	Friday	30	1015	330	\N	\N	\N	\N
2320	2023-08-03 06:32:37.981841	2023-08-03 06:32:37.981841	Friday	1500	1530	330	\N	\N	\N	\N
2321	2023-08-03 06:32:37.983293	2023-08-03 06:32:37.983293	Saturday	2030	400	330	\N	\N	\N	\N
2322	2023-08-03 06:32:37.984643	2023-08-03 06:32:37.984643	Sunday	845	2130	330	\N	\N	\N	\N
2323	2023-08-03 06:32:38.005394	2023-08-03 06:32:38.005394	Monday	700	1400	331	\N	\N	\N	\N
2324	2023-08-03 06:32:38.007115	2023-08-03 06:32:38.007115	Tuesday	1830	115	331	\N	\N	\N	\N
2325	2023-08-03 06:32:38.008653	2023-08-03 06:32:38.008653	Wednesday	730	1315	331	\N	\N	\N	\N
2326	2023-08-03 06:32:38.010121	2023-08-03 06:32:38.010121	Wednesday	1800	1900	331	\N	\N	\N	\N
2327	2023-08-03 06:32:38.011624	2023-08-03 06:32:38.011624	Saturday	615	1900	331	\N	\N	\N	\N
2328	2023-08-03 06:32:38.013076	2023-08-03 06:32:38.013076	Sunday	915	1500	331	\N	\N	\N	\N
2329	2023-08-03 06:32:38.023908	2023-08-03 06:32:38.023908	Monday	930	2315	332	\N	\N	\N	\N
2330	2023-08-03 06:32:38.025688	2023-08-03 06:32:38.025688	Tuesday	1215	1515	332	\N	\N	\N	\N
2331	2023-08-03 06:32:38.027319	2023-08-03 06:32:38.027319	Tuesday	1700	1815	332	\N	\N	\N	\N
2332	2023-08-03 06:32:38.028991	2023-08-03 06:32:38.028991	Friday	645	1600	332	\N	\N	\N	\N
2333	2023-08-03 06:32:38.03061	2023-08-03 06:32:38.03061	Saturday	1000	2015	332	\N	\N	\N	\N
2334	2023-08-03 06:32:38.032243	2023-08-03 06:32:38.032243	Sunday	1930	230	332	\N	\N	\N	\N
2335	2023-08-03 06:32:38.062919	2023-08-03 06:32:38.062919	Tuesday	1000	1445	333	\N	\N	\N	\N
2336	2023-08-03 06:32:38.064998	2023-08-03 06:32:38.064998	Tuesday	1900	2300	333	\N	\N	\N	\N
2337	2023-08-03 06:32:38.067966	2023-08-03 06:32:38.067966	Wednesday	630	1815	333	\N	\N	\N	\N
2338	2023-08-03 06:32:38.070008	2023-08-03 06:32:38.070008	Thursday	730	2230	333	\N	\N	\N	\N
2339	2023-08-03 06:32:38.07193	2023-08-03 06:32:38.07193	Friday	900	1445	333	\N	\N	\N	\N
2340	2023-08-03 06:32:38.073407	2023-08-03 06:32:38.073407	Friday	2230	2245	333	\N	\N	\N	\N
2341	2023-08-03 06:32:38.075008	2023-08-03 06:32:38.075008	Sunday	200	215	333	\N	\N	\N	\N
2342	2023-08-03 06:32:38.076436	2023-08-03 06:32:38.076436	Sunday	230	1530	333	\N	\N	\N	\N
2343	2023-08-03 06:32:38.0913	2023-08-03 06:32:38.0913	Monday	400	445	334	\N	\N	\N	\N
2344	2023-08-03 06:32:38.092812	2023-08-03 06:32:38.092812	Monday	1315	1915	334	\N	\N	\N	\N
2345	2023-08-03 06:32:38.098922	2023-08-03 06:32:38.098922	Tuesday	1945	145	334	\N	\N	\N	\N
2346	2023-08-03 06:32:38.108501	2023-08-03 06:32:38.108501	Wednesday	800	2330	334	\N	\N	\N	\N
2347	2023-08-03 06:32:38.110001	2023-08-03 06:32:38.110001	Thursday	715	2015	334	\N	\N	\N	\N
2348	2023-08-03 06:32:38.111497	2023-08-03 06:32:38.111497	Friday	830	2330	334	\N	\N	\N	\N
2349	2023-08-03 06:32:38.143245	2023-08-03 06:32:38.143245	Monday	900	2330	335	\N	\N	\N	\N
2350	2023-08-03 06:32:38.145056	2023-08-03 06:32:38.145056	Tuesday	1000	1730	335	\N	\N	\N	\N
2351	2023-08-03 06:32:38.146572	2023-08-03 06:32:38.146572	Wednesday	1000	1800	335	\N	\N	\N	\N
2352	2023-08-03 06:32:38.148003	2023-08-03 06:32:38.148003	Thursday	900	1830	335	\N	\N	\N	\N
2353	2023-08-03 06:32:38.149472	2023-08-03 06:32:38.149472	Friday	645	2330	335	\N	\N	\N	\N
2354	2023-08-03 06:32:38.151016	2023-08-03 06:32:38.151016	Saturday	830	1745	335	\N	\N	\N	\N
2355	2023-08-03 06:32:38.152517	2023-08-03 06:32:38.152517	Sunday	945	1900	335	\N	\N	\N	\N
2356	2023-08-03 06:32:38.174836	2023-08-03 06:32:38.174836	Monday	1000	2345	336	\N	\N	\N	\N
2357	2023-08-03 06:32:38.176346	2023-08-03 06:32:38.176346	Tuesday	230	745	336	\N	\N	\N	\N
2358	2023-08-03 06:32:38.177815	2023-08-03 06:32:38.177815	Tuesday	800	1030	336	\N	\N	\N	\N
2359	2023-08-03 06:32:38.179387	2023-08-03 06:32:38.179387	Thursday	700	2000	336	\N	\N	\N	\N
2360	2023-08-03 06:32:38.180901	2023-08-03 06:32:38.180901	Friday	1700	115	336	\N	\N	\N	\N
2361	2023-08-03 06:32:38.182363	2023-08-03 06:32:38.182363	Saturday	2015	115	336	\N	\N	\N	\N
2362	2023-08-03 06:32:38.183878	2023-08-03 06:32:38.183878	Sunday	1700	130	336	\N	\N	\N	\N
2363	2023-08-03 06:32:38.194042	2023-08-03 06:32:38.194042	Monday	2100	315	337	\N	\N	\N	\N
2364	2023-08-03 06:32:38.195531	2023-08-03 06:32:38.195531	Wednesday	215	1600	337	\N	\N	\N	\N
2365	2023-08-03 06:32:38.196919	2023-08-03 06:32:38.196919	Wednesday	1645	130	337	\N	\N	\N	\N
2366	2023-08-03 06:32:38.198584	2023-08-03 06:32:38.198584	Thursday	600	1730	337	\N	\N	\N	\N
2367	2023-08-03 06:32:38.200039	2023-08-03 06:32:38.200039	Friday	1415	245	337	\N	\N	\N	\N
2368	2023-08-03 06:32:38.201419	2023-08-03 06:32:38.201419	Saturday	915	2330	337	\N	\N	\N	\N
2369	2023-08-03 06:32:38.202845	2023-08-03 06:32:38.202845	Sunday	600	1700	337	\N	\N	\N	\N
2370	2023-08-03 06:32:38.220075	2023-08-03 06:32:38.220075	Monday	245	1115	338	\N	\N	\N	\N
2371	2023-08-03 06:32:38.221561	2023-08-03 06:32:38.221561	Monday	1430	2045	338	\N	\N	\N	\N
2372	2023-08-03 06:32:38.223103	2023-08-03 06:32:38.223103	Tuesday	845	1845	338	\N	\N	\N	\N
2373	2023-08-03 06:32:38.224725	2023-08-03 06:32:38.224725	Thursday	1600	245	338	\N	\N	\N	\N
2374	2023-08-03 06:32:38.226152	2023-08-03 06:32:38.226152	Friday	15	1700	338	\N	\N	\N	\N
2375	2023-08-03 06:32:38.227551	2023-08-03 06:32:38.227551	Friday	1800	2300	338	\N	\N	\N	\N
2376	2023-08-03 06:32:38.228999	2023-08-03 06:32:38.228999	Saturday	930	2100	338	\N	\N	\N	\N
2377	2023-08-03 06:32:38.230549	2023-08-03 06:32:38.230549	Sunday	645	1645	338	\N	\N	\N	\N
2378	2023-08-03 06:32:38.252098	2023-08-03 06:32:38.252098	Tuesday	400	900	339	\N	\N	\N	\N
2379	2023-08-03 06:32:38.253677	2023-08-03 06:32:38.253677	Tuesday	1045	1800	339	\N	\N	\N	\N
2380	2023-08-03 06:32:38.255092	2023-08-03 06:32:38.255092	Wednesday	1815	145	339	\N	\N	\N	\N
2381	2023-08-03 06:32:38.256462	2023-08-03 06:32:38.256462	Thursday	715	1600	339	\N	\N	\N	\N
2382	2023-08-03 06:32:38.257831	2023-08-03 06:32:38.257831	Friday	1415	130	339	\N	\N	\N	\N
2383	2023-08-03 06:32:38.259168	2023-08-03 06:32:38.259168	Saturday	930	2245	339	\N	\N	\N	\N
2384	2023-08-03 06:32:38.26059	2023-08-03 06:32:38.26059	Sunday	1000	1545	339	\N	\N	\N	\N
2385	2023-08-03 06:32:38.271011	2023-08-03 06:32:38.271011	Monday	645	1445	340	\N	\N	\N	\N
2386	2023-08-03 06:32:38.27254	2023-08-03 06:32:38.27254	Tuesday	1030	2115	340	\N	\N	\N	\N
2387	2023-08-03 06:32:38.274007	2023-08-03 06:32:38.274007	Tuesday	2345	715	340	\N	\N	\N	\N
2388	2023-08-03 06:32:38.275437	2023-08-03 06:32:38.275437	Wednesday	945	2245	340	\N	\N	\N	\N
2389	2023-08-03 06:32:38.277148	2023-08-03 06:32:38.277148	Friday	400	545	340	\N	\N	\N	\N
2390	2023-08-03 06:32:38.278731	2023-08-03 06:32:38.278731	Friday	815	2115	340	\N	\N	\N	\N
2391	2023-08-03 06:32:38.280416	2023-08-03 06:32:38.280416	Saturday	845	2345	340	\N	\N	\N	\N
2392	2023-08-03 06:32:38.281959	2023-08-03 06:32:38.281959	Sunday	830	1145	340	\N	\N	\N	\N
2393	2023-08-03 06:32:38.283413	2023-08-03 06:32:38.283413	Sunday	2115	2200	340	\N	\N	\N	\N
2394	2023-08-03 06:32:38.300791	2023-08-03 06:32:38.300791	Monday	600	2400	341	\N	\N	\N	\N
2395	2023-08-03 06:32:38.302225	2023-08-03 06:32:38.302225	Tuesday	1115	1245	341	\N	\N	\N	\N
2396	2023-08-03 06:32:38.303649	2023-08-03 06:32:38.303649	Tuesday	1930	100	341	\N	\N	\N	\N
2397	2023-08-03 06:32:38.30525	2023-08-03 06:32:38.30525	Wednesday	800	1430	341	\N	\N	\N	\N
2398	2023-08-03 06:32:38.306684	2023-08-03 06:32:38.306684	Thursday	115	845	341	\N	\N	\N	\N
2399	2023-08-03 06:32:38.308058	2023-08-03 06:32:38.308058	Thursday	1200	1230	341	\N	\N	\N	\N
2400	2023-08-03 06:32:38.309454	2023-08-03 06:32:38.309454	Friday	1000	1745	341	\N	\N	\N	\N
2401	2023-08-03 06:32:38.310873	2023-08-03 06:32:38.310873	Saturday	30	1245	341	\N	\N	\N	\N
2402	2023-08-03 06:32:38.312232	2023-08-03 06:32:38.312232	Saturday	1445	1845	341	\N	\N	\N	\N
2403	2023-08-03 06:32:38.313597	2023-08-03 06:32:38.313597	Sunday	845	1700	341	\N	\N	\N	\N
2404	2023-08-03 06:32:38.334154	2023-08-03 06:32:38.334154	Monday	845	900	342	\N	\N	\N	\N
2405	2023-08-03 06:32:38.335528	2023-08-03 06:32:38.335528	Monday	1830	315	342	\N	\N	\N	\N
2406	2023-08-03 06:32:38.33691	2023-08-03 06:32:38.33691	Wednesday	715	1445	342	\N	\N	\N	\N
2407	2023-08-03 06:32:38.338376	2023-08-03 06:32:38.338376	Thursday	945	1045	342	\N	\N	\N	\N
2408	2023-08-03 06:32:38.339715	2023-08-03 06:32:38.339715	Thursday	1300	1415	342	\N	\N	\N	\N
2409	2023-08-03 06:32:38.341053	2023-08-03 06:32:38.341053	Friday	645	1830	342	\N	\N	\N	\N
2410	2023-08-03 06:32:38.342704	2023-08-03 06:32:38.342704	Saturday	700	1845	342	\N	\N	\N	\N
2411	2023-08-03 06:32:38.344078	2023-08-03 06:32:38.344078	Sunday	145	715	342	\N	\N	\N	\N
2412	2023-08-03 06:32:38.345512	2023-08-03 06:32:38.345512	Sunday	1530	1715	342	\N	\N	\N	\N
2413	2023-08-03 06:32:38.355551	2023-08-03 06:32:38.355551	Monday	815	1745	343	\N	\N	\N	\N
2414	2023-08-03 06:32:38.356954	2023-08-03 06:32:38.356954	Tuesday	600	1530	343	\N	\N	\N	\N
2415	2023-08-03 06:32:38.358618	2023-08-03 06:32:38.358618	Wednesday	615	2030	343	\N	\N	\N	\N
2416	2023-08-03 06:32:38.359986	2023-08-03 06:32:38.359986	Thursday	1600	200	343	\N	\N	\N	\N
2417	2023-08-03 06:32:38.361415	2023-08-03 06:32:38.361415	Saturday	545	745	343	\N	\N	\N	\N
2418	2023-08-03 06:32:38.362773	2023-08-03 06:32:38.362773	Saturday	1100	1330	343	\N	\N	\N	\N
2419	2023-08-03 06:32:38.385248	2023-08-03 06:32:38.385248	Tuesday	1900	100	344	\N	\N	\N	\N
2420	2023-08-03 06:32:38.386649	2023-08-03 06:32:38.386649	Wednesday	430	2130	344	\N	\N	\N	\N
2421	2023-08-03 06:32:38.387996	2023-08-03 06:32:38.387996	Wednesday	2230	2300	344	\N	\N	\N	\N
2422	2023-08-03 06:32:38.38941	2023-08-03 06:32:38.38941	Thursday	700	1600	344	\N	\N	\N	\N
2423	2023-08-03 06:32:38.391069	2023-08-03 06:32:38.391069	Friday	715	1700	344	\N	\N	\N	\N
2424	2023-08-03 06:32:38.392424	2023-08-03 06:32:38.392424	Saturday	830	1830	344	\N	\N	\N	\N
2425	2023-08-03 06:32:38.393751	2023-08-03 06:32:38.393751	Sunday	815	2145	344	\N	\N	\N	\N
2426	2023-08-03 06:32:38.404126	2023-08-03 06:32:38.404126	Monday	715	1430	345	\N	\N	\N	\N
2427	2023-08-03 06:32:38.405607	2023-08-03 06:32:38.405607	Tuesday	945	2345	345	\N	\N	\N	\N
2428	2023-08-03 06:32:38.406999	2023-08-03 06:32:38.406999	Wednesday	600	1645	345	\N	\N	\N	\N
2429	2023-08-03 06:32:38.408454	2023-08-03 06:32:38.408454	Friday	45	745	345	\N	\N	\N	\N
2430	2023-08-03 06:32:38.409845	2023-08-03 06:32:38.409845	Friday	1830	2000	345	\N	\N	\N	\N
2431	2023-08-03 06:32:38.411341	2023-08-03 06:32:38.411341	Sunday	815	1445	345	\N	\N	\N	\N
2432	2023-08-03 06:32:38.432743	2023-08-03 06:32:38.432743	Monday	800	1415	346	\N	\N	\N	\N
2433	2023-08-03 06:32:38.434605	2023-08-03 06:32:38.434605	Monday	1645	415	346	\N	\N	\N	\N
2434	2023-08-03 06:32:38.436163	2023-08-03 06:32:38.436163	Tuesday	130	745	346	\N	\N	\N	\N
2435	2023-08-03 06:32:38.437693	2023-08-03 06:32:38.437693	Tuesday	1000	1030	346	\N	\N	\N	\N
2436	2023-08-03 06:32:38.43918	2023-08-03 06:32:38.43918	Wednesday	645	1515	346	\N	\N	\N	\N
2437	2023-08-03 06:32:38.440723	2023-08-03 06:32:38.440723	Friday	1030	1215	346	\N	\N	\N	\N
2438	2023-08-03 06:32:38.442086	2023-08-03 06:32:38.442086	Friday	1345	1415	346	\N	\N	\N	\N
2439	2023-08-03 06:32:38.443735	2023-08-03 06:32:38.443735	Saturday	1000	1500	346	\N	\N	\N	\N
2440	2023-08-03 06:32:38.445193	2023-08-03 06:32:38.445193	Sunday	400	530	346	\N	\N	\N	\N
2441	2023-08-03 06:32:38.446633	2023-08-03 06:32:38.446633	Sunday	1745	1915	346	\N	\N	\N	\N
2442	2023-08-03 06:32:38.456268	2023-08-03 06:32:38.456268	Tuesday	815	2345	347	\N	\N	\N	\N
2443	2023-08-03 06:32:38.457889	2023-08-03 06:32:38.457889	Thursday	930	2400	347	\N	\N	\N	\N
2444	2023-08-03 06:32:38.459385	2023-08-03 06:32:38.459385	Friday	645	2245	347	\N	\N	\N	\N
2445	2023-08-03 06:32:38.460862	2023-08-03 06:32:38.460862	Saturday	700	2015	347	\N	\N	\N	\N
2446	2023-08-03 06:32:38.462179	2023-08-03 06:32:38.462179	Sunday	745	2300	347	\N	\N	\N	\N
2447	2023-08-03 06:32:38.479501	2023-08-03 06:32:38.479501	Tuesday	930	1400	348	\N	\N	\N	\N
2448	2023-08-03 06:32:38.481068	2023-08-03 06:32:38.481068	Tuesday	1530	2130	348	\N	\N	\N	\N
2449	2023-08-03 06:32:38.482549	2023-08-03 06:32:38.482549	Wednesday	1945	130	348	\N	\N	\N	\N
2450	2023-08-03 06:32:38.484121	2023-08-03 06:32:38.484121	Thursday	645	1645	348	\N	\N	\N	\N
2451	2023-08-03 06:32:38.485823	2023-08-03 06:32:38.485823	Friday	30	130	348	\N	\N	\N	\N
2452	2023-08-03 06:32:38.487302	2023-08-03 06:32:38.487302	Friday	345	1815	348	\N	\N	\N	\N
2453	2023-08-03 06:32:38.488704	2023-08-03 06:32:38.488704	Saturday	645	2400	348	\N	\N	\N	\N
2454	2023-08-03 06:32:38.490153	2023-08-03 06:32:38.490153	Sunday	615	2300	348	\N	\N	\N	\N
2455	2023-08-03 06:32:38.511598	2023-08-03 06:32:38.511598	Monday	1715	130	349	\N	\N	\N	\N
2456	2023-08-03 06:32:38.513165	2023-08-03 06:32:38.513165	Tuesday	600	1430	349	\N	\N	\N	\N
2457	2023-08-03 06:32:38.514651	2023-08-03 06:32:38.514651	Wednesday	715	1915	349	\N	\N	\N	\N
2458	2023-08-03 06:32:38.516093	2023-08-03 06:32:38.516093	Thursday	600	2145	349	\N	\N	\N	\N
2459	2023-08-03 06:32:38.517497	2023-08-03 06:32:38.517497	Friday	645	1815	349	\N	\N	\N	\N
2460	2023-08-03 06:32:38.51899	2023-08-03 06:32:38.51899	Saturday	615	2015	349	\N	\N	\N	\N
2461	2023-08-03 06:32:38.520479	2023-08-03 06:32:38.520479	Sunday	615	1915	349	\N	\N	\N	\N
2462	2023-08-03 06:32:38.531808	2023-08-03 06:32:38.531808	Monday	1100	1215	350	\N	\N	\N	\N
2463	2023-08-03 06:32:38.533375	2023-08-03 06:32:38.533375	Monday	1430	700	350	\N	\N	\N	\N
2464	2023-08-03 06:32:38.534811	2023-08-03 06:32:38.534811	Thursday	700	2200	350	\N	\N	\N	\N
2465	2023-08-03 06:32:38.536235	2023-08-03 06:32:38.536235	Friday	745	1800	350	\N	\N	\N	\N
2466	2023-08-03 06:32:38.537718	2023-08-03 06:32:38.537718	Saturday	1800	300	350	\N	\N	\N	\N
2467	2023-08-03 06:32:38.560787	2023-08-03 06:32:38.560787	Tuesday	900	2100	351	\N	\N	\N	\N
2468	2023-08-03 06:32:38.562224	2023-08-03 06:32:38.562224	Wednesday	45	545	351	\N	\N	\N	\N
2469	2023-08-03 06:32:38.563625	2023-08-03 06:32:38.563625	Wednesday	1745	1915	351	\N	\N	\N	\N
2470	2023-08-03 06:32:38.565038	2023-08-03 06:32:38.565038	Thursday	415	1315	351	\N	\N	\N	\N
2471	2023-08-03 06:32:38.56646	2023-08-03 06:32:38.56646	Thursday	1715	2300	351	\N	\N	\N	\N
2472	2023-08-03 06:32:38.568087	2023-08-03 06:32:38.568087	Saturday	700	1700	351	\N	\N	\N	\N
2473	2023-08-03 06:32:38.578006	2023-08-03 06:32:38.578006	Monday	600	615	352	\N	\N	\N	\N
2474	2023-08-03 06:32:38.579444	2023-08-03 06:32:38.579444	Monday	715	2315	352	\N	\N	\N	\N
2475	2023-08-03 06:32:38.581275	2023-08-03 06:32:38.581275	Tuesday	1100	1230	352	\N	\N	\N	\N
2476	2023-08-03 06:32:38.582687	2023-08-03 06:32:38.582687	Tuesday	1415	245	352	\N	\N	\N	\N
2477	2023-08-03 06:32:38.584122	2023-08-03 06:32:38.584122	Friday	945	1815	352	\N	\N	\N	\N
2478	2023-08-03 06:32:38.585558	2023-08-03 06:32:38.585558	Saturday	845	1415	352	\N	\N	\N	\N
2479	2023-08-03 06:32:38.587063	2023-08-03 06:32:38.587063	Sunday	1145	1315	352	\N	\N	\N	\N
2480	2023-08-03 06:32:38.588559	2023-08-03 06:32:38.588559	Sunday	1330	2300	352	\N	\N	\N	\N
2481	2023-08-03 06:32:38.612451	2023-08-03 06:32:38.612451	Monday	815	1630	353	\N	\N	\N	\N
2482	2023-08-03 06:32:38.613949	2023-08-03 06:32:38.613949	Tuesday	615	2245	353	\N	\N	\N	\N
2483	2023-08-03 06:32:38.61539	2023-08-03 06:32:38.61539	Thursday	2100	315	353	\N	\N	\N	\N
2484	2023-08-03 06:32:38.616848	2023-08-03 06:32:38.616848	Friday	1400	200	353	\N	\N	\N	\N
2485	2023-08-03 06:32:38.618228	2023-08-03 06:32:38.618228	Saturday	2230	245	353	\N	\N	\N	\N
2486	2023-08-03 06:32:38.619879	2023-08-03 06:32:38.619879	Sunday	1715	315	353	\N	\N	\N	\N
2487	2023-08-03 06:32:38.629703	2023-08-03 06:32:38.629703	Monday	300	930	354	\N	\N	\N	\N
2488	2023-08-03 06:32:38.631116	2023-08-03 06:32:38.631116	Monday	1415	1545	354	\N	\N	\N	\N
2489	2023-08-03 06:32:38.632601	2023-08-03 06:32:38.632601	Tuesday	630	1215	354	\N	\N	\N	\N
2490	2023-08-03 06:32:38.634109	2023-08-03 06:32:38.634109	Tuesday	1545	2145	354	\N	\N	\N	\N
2491	2023-08-03 06:32:38.635542	2023-08-03 06:32:38.635542	Wednesday	2130	230	354	\N	\N	\N	\N
2492	2023-08-03 06:32:38.636969	2023-08-03 06:32:38.636969	Thursday	130	1800	354	\N	\N	\N	\N
2493	2023-08-03 06:32:38.638379	2023-08-03 06:32:38.638379	Thursday	2015	2200	354	\N	\N	\N	\N
2494	2023-08-03 06:32:38.639773	2023-08-03 06:32:38.639773	Saturday	915	1830	354	\N	\N	\N	\N
2495	2023-08-03 06:32:38.641208	2023-08-03 06:32:38.641208	Sunday	915	1045	354	\N	\N	\N	\N
2496	2023-08-03 06:32:38.642605	2023-08-03 06:32:38.642605	Sunday	1130	2100	354	\N	\N	\N	\N
2497	2023-08-03 06:32:38.663771	2023-08-03 06:32:38.663771	Tuesday	1000	2115	355	\N	\N	\N	\N
2498	2023-08-03 06:32:38.665231	2023-08-03 06:32:38.665231	Wednesday	930	1930	355	\N	\N	\N	\N
2499	2023-08-03 06:32:38.666692	2023-08-03 06:32:38.666692	Thursday	845	1445	355	\N	\N	\N	\N
2500	2023-08-03 06:32:38.668211	2023-08-03 06:32:38.668211	Friday	715	1115	355	\N	\N	\N	\N
2501	2023-08-03 06:32:38.669612	2023-08-03 06:32:38.669612	Friday	2000	345	355	\N	\N	\N	\N
2502	2023-08-03 06:32:38.671528	2023-08-03 06:32:38.671528	Saturday	630	2215	355	\N	\N	\N	\N
2503	2023-08-03 06:32:38.681671	2023-08-03 06:32:38.681671	Monday	915	1930	356	\N	\N	\N	\N
2504	2023-08-03 06:32:38.683108	2023-08-03 06:32:38.683108	Tuesday	715	1500	356	\N	\N	\N	\N
2505	2023-08-03 06:32:38.684765	2023-08-03 06:32:38.684765	Wednesday	845	1445	356	\N	\N	\N	\N
2506	2023-08-03 06:32:38.686282	2023-08-03 06:32:38.686282	Thursday	730	1845	356	\N	\N	\N	\N
2507	2023-08-03 06:32:38.687706	2023-08-03 06:32:38.687706	Thursday	2300	2330	356	\N	\N	\N	\N
2508	2023-08-03 06:32:38.689127	2023-08-03 06:32:38.689127	Friday	615	1630	356	\N	\N	\N	\N
2509	2023-08-03 06:32:38.690554	2023-08-03 06:32:38.690554	Saturday	815	1945	356	\N	\N	\N	\N
2510	2023-08-03 06:32:38.692033	2023-08-03 06:32:38.692033	Sunday	745	1715	356	\N	\N	\N	\N
2511	2023-08-03 06:32:38.7087	2023-08-03 06:32:38.7087	Monday	815	2030	357	\N	\N	\N	\N
2512	2023-08-03 06:32:38.710179	2023-08-03 06:32:38.710179	Tuesday	1400	345	357	\N	\N	\N	\N
2513	2023-08-03 06:32:38.711754	2023-08-03 06:32:38.711754	Wednesday	915	1600	357	\N	\N	\N	\N
2514	2023-08-03 06:32:38.713275	2023-08-03 06:32:38.713275	Friday	30	500	357	\N	\N	\N	\N
2515	2023-08-03 06:32:38.714632	2023-08-03 06:32:38.714632	Friday	2100	2230	357	\N	\N	\N	\N
2516	2023-08-03 06:32:38.716036	2023-08-03 06:32:38.716036	Sunday	245	415	357	\N	\N	\N	\N
2517	2023-08-03 06:32:38.717389	2023-08-03 06:32:38.717389	Sunday	1200	1530	357	\N	\N	\N	\N
2518	2023-08-03 06:32:38.738194	2023-08-03 06:32:38.738194	Tuesday	830	1500	358	\N	\N	\N	\N
2519	2023-08-03 06:32:38.739617	2023-08-03 06:32:38.739617	Wednesday	630	2345	358	\N	\N	\N	\N
2520	2023-08-03 06:32:38.741004	2023-08-03 06:32:38.741004	Friday	845	1800	358	\N	\N	\N	\N
2521	2023-08-03 06:32:38.74251	2023-08-03 06:32:38.74251	Saturday	1845	330	358	\N	\N	\N	\N
2522	2023-08-03 06:32:38.743917	2023-08-03 06:32:38.743917	Sunday	715	2215	358	\N	\N	\N	\N
2523	2023-08-03 06:32:38.753936	2023-08-03 06:32:38.753936	Monday	800	2015	359	\N	\N	\N	\N
2524	2023-08-03 06:32:38.755329	2023-08-03 06:32:38.755329	Tuesday	615	2200	359	\N	\N	\N	\N
2525	2023-08-03 06:32:38.756716	2023-08-03 06:32:38.756716	Wednesday	2130	115	359	\N	\N	\N	\N
2526	2023-08-03 06:32:38.758243	2023-08-03 06:32:38.758243	Thursday	545	600	359	\N	\N	\N	\N
2527	2023-08-03 06:32:38.759591	2023-08-03 06:32:38.759591	Thursday	1645	1700	359	\N	\N	\N	\N
2528	2023-08-03 06:32:38.760922	2023-08-03 06:32:38.760922	Friday	715	1445	359	\N	\N	\N	\N
2529	2023-08-03 06:32:38.777446	2023-08-03 06:32:38.777446	Tuesday	0	1000	360	\N	\N	\N	\N
2530	2023-08-03 06:32:38.778804	2023-08-03 06:32:38.778804	Tuesday	1915	2030	360	\N	\N	\N	\N
2531	2023-08-03 06:32:38.780248	2023-08-03 06:32:38.780248	Wednesday	2215	115	360	\N	\N	\N	\N
2532	2023-08-03 06:32:38.781603	2023-08-03 06:32:38.781603	Friday	915	1500	360	\N	\N	\N	\N
2533	2023-08-03 06:32:38.782979	2023-08-03 06:32:38.782979	Saturday	500	1445	360	\N	\N	\N	\N
2534	2023-08-03 06:32:38.784347	2023-08-03 06:32:38.784347	Saturday	1930	2100	360	\N	\N	\N	\N
2535	2023-08-03 06:32:38.785675	2023-08-03 06:32:38.785675	Sunday	800	1900	360	\N	\N	\N	\N
2536	2023-08-03 06:32:38.806689	2023-08-03 06:32:38.806689	Monday	1015	1115	361	\N	\N	\N	\N
2537	2023-08-03 06:32:38.808039	2023-08-03 06:32:38.808039	Monday	1400	1745	361	\N	\N	\N	\N
2538	2023-08-03 06:32:38.809417	2023-08-03 06:32:38.809417	Tuesday	945	2200	361	\N	\N	\N	\N
2539	2023-08-03 06:32:38.810833	2023-08-03 06:32:38.810833	Wednesday	1030	1345	361	\N	\N	\N	\N
2540	2023-08-03 06:32:38.812184	2023-08-03 06:32:38.812184	Wednesday	2030	2145	361	\N	\N	\N	\N
2541	2023-08-03 06:32:38.813804	2023-08-03 06:32:38.813804	Thursday	900	1545	361	\N	\N	\N	\N
2542	2023-08-03 06:32:38.815159	2023-08-03 06:32:38.815159	Sunday	2245	230	361	\N	\N	\N	\N
2543	2023-08-03 06:32:38.825041	2023-08-03 06:32:38.825041	Monday	900	1645	362	\N	\N	\N	\N
2544	2023-08-03 06:32:38.826692	2023-08-03 06:32:38.826692	Tuesday	2100	130	362	\N	\N	\N	\N
2545	2023-08-03 06:32:38.828026	2023-08-03 06:32:38.828026	Wednesday	715	1430	362	\N	\N	\N	\N
2546	2023-08-03 06:32:38.82948	2023-08-03 06:32:38.82948	Thursday	330	1030	362	\N	\N	\N	\N
2547	2023-08-03 06:32:38.830917	2023-08-03 06:32:38.830917	Thursday	1315	2300	362	\N	\N	\N	\N
2548	2023-08-03 06:32:38.832408	2023-08-03 06:32:38.832408	Friday	945	1400	362	\N	\N	\N	\N
2549	2023-08-03 06:32:38.833858	2023-08-03 06:32:38.833858	Saturday	800	2045	362	\N	\N	\N	\N
2550	2023-08-03 06:32:38.858122	2023-08-03 06:32:38.858122	Monday	2245	345	363	\N	\N	\N	\N
2551	2023-08-03 06:32:38.859721	2023-08-03 06:32:38.859721	Tuesday	915	2200	363	\N	\N	\N	\N
2552	2023-08-03 06:32:38.861077	2023-08-03 06:32:38.861077	Wednesday	730	1430	363	\N	\N	\N	\N
2553	2023-08-03 06:32:38.862482	2023-08-03 06:32:38.862482	Friday	630	2100	363	\N	\N	\N	\N
2554	2023-08-03 06:32:38.864075	2023-08-03 06:32:38.864075	Saturday	1000	2400	363	\N	\N	\N	\N
2555	2023-08-03 06:32:38.865442	2023-08-03 06:32:38.865442	Sunday	745	1815	363	\N	\N	\N	\N
2556	2023-08-03 06:32:38.875203	2023-08-03 06:32:38.875203	Monday	700	2315	364	\N	\N	\N	\N
2557	2023-08-03 06:32:38.876783	2023-08-03 06:32:38.876783	Tuesday	1000	2215	364	\N	\N	\N	\N
2558	2023-08-03 06:32:38.878181	2023-08-03 06:32:38.878181	Wednesday	815	1830	364	\N	\N	\N	\N
2559	2023-08-03 06:32:38.879678	2023-08-03 06:32:38.879678	Thursday	900	2045	364	\N	\N	\N	\N
2560	2023-08-03 06:32:38.881062	2023-08-03 06:32:38.881062	Thursday	2315	2400	364	\N	\N	\N	\N
2561	2023-08-03 06:32:38.882527	2023-08-03 06:32:38.882527	Friday	800	2000	364	\N	\N	\N	\N
2562	2023-08-03 06:32:38.883889	2023-08-03 06:32:38.883889	Saturday	745	1730	364	\N	\N	\N	\N
2563	2023-08-03 06:32:38.885273	2023-08-03 06:32:38.885273	Sunday	930	1530	364	\N	\N	\N	\N
2564	2023-08-03 06:32:39.498508	2023-08-03 06:32:39.498508	Tuesday	315	1045	365	\N	\N	\N	\N
2565	2023-08-03 06:32:39.499885	2023-08-03 06:32:39.499885	Tuesday	1815	2345	365	\N	\N	\N	\N
2566	2023-08-03 06:32:39.501413	2023-08-03 06:32:39.501413	Wednesday	815	1945	365	\N	\N	\N	\N
2567	2023-08-03 06:32:39.50278	2023-08-03 06:32:39.50278	Friday	2145	115	365	\N	\N	\N	\N
2568	2023-08-03 06:32:39.504163	2023-08-03 06:32:39.504163	Saturday	2245	345	365	\N	\N	\N	\N
2569	2023-08-03 06:32:39.505597	2023-08-03 06:32:39.505597	Sunday	230	1500	365	\N	\N	\N	\N
2570	2023-08-03 06:32:39.506986	2023-08-03 06:32:39.506986	Sunday	1530	2015	365	\N	\N	\N	\N
2571	2023-08-03 06:32:39.51667	2023-08-03 06:32:39.51667	Monday	2130	330	366	\N	\N	\N	\N
2572	2023-08-03 06:32:39.518088	2023-08-03 06:32:39.518088	Tuesday	1915	2000	366	\N	\N	\N	\N
2573	2023-08-03 06:32:39.519442	2023-08-03 06:32:39.519442	Tuesday	2245	1030	366	\N	\N	\N	\N
2574	2023-08-03 06:32:39.520879	2023-08-03 06:32:39.520879	Friday	815	1615	366	\N	\N	\N	\N
2575	2023-08-03 06:32:39.522272	2023-08-03 06:32:39.522272	Saturday	530	545	366	\N	\N	\N	\N
2576	2023-08-03 06:32:39.523601	2023-08-03 06:32:39.523601	Saturday	1045	1230	366	\N	\N	\N	\N
2577	2023-08-03 06:32:39.525156	2023-08-03 06:32:39.525156	Sunday	745	1830	366	\N	\N	\N	\N
2578	2023-08-03 06:32:39.538264	2023-08-03 06:32:39.538264	Wednesday	915	1615	367	\N	\N	\N	\N
2579	2023-08-03 06:32:39.539659	2023-08-03 06:32:39.539659	Saturday	915	1545	367	\N	\N	\N	\N
2580	2023-08-03 06:32:39.541068	2023-08-03 06:32:39.541068	Sunday	800	1500	367	\N	\N	\N	\N
2581	2023-08-03 06:32:39.551119	2023-08-03 06:32:39.551119	Monday	600	2400	368	\N	\N	\N	\N
2582	2023-08-03 06:32:39.552506	2023-08-03 06:32:39.552506	Tuesday	130	445	368	\N	\N	\N	\N
2583	2023-08-03 06:32:39.553785	2023-08-03 06:32:39.553785	Tuesday	1815	2230	368	\N	\N	\N	\N
2584	2023-08-03 06:32:39.555177	2023-08-03 06:32:39.555177	Friday	215	630	368	\N	\N	\N	\N
2585	2023-08-03 06:32:39.556476	2023-08-03 06:32:39.556476	Friday	700	2300	368	\N	\N	\N	\N
2586	2023-08-03 06:32:39.55782	2023-08-03 06:32:39.55782	Saturday	1845	330	368	\N	\N	\N	\N
2587	2023-08-03 06:32:39.559161	2023-08-03 06:32:39.559161	Sunday	1045	1430	368	\N	\N	\N	\N
2588	2023-08-03 06:32:39.560443	2023-08-03 06:32:39.560443	Sunday	1700	2130	368	\N	\N	\N	\N
2589	2023-08-03 06:32:39.573144	2023-08-03 06:32:39.573144	Monday	730	1700	369	\N	\N	\N	\N
2590	2023-08-03 06:32:39.57473	2023-08-03 06:32:39.57473	Tuesday	200	345	369	\N	\N	\N	\N
2591	2023-08-03 06:32:39.575973	2023-08-03 06:32:39.575973	Tuesday	930	1445	369	\N	\N	\N	\N
2592	2023-08-03 06:32:39.577249	2023-08-03 06:32:39.577249	Wednesday	845	2045	369	\N	\N	\N	\N
2593	2023-08-03 06:32:39.578482	2023-08-03 06:32:39.578482	Thursday	845	2030	369	\N	\N	\N	\N
2594	2023-08-03 06:32:39.579735	2023-08-03 06:32:39.579735	Saturday	945	1530	369	\N	\N	\N	\N
2595	2023-08-03 06:32:39.581036	2023-08-03 06:32:39.581036	Sunday	145	1030	369	\N	\N	\N	\N
2596	2023-08-03 06:32:39.582348	2023-08-03 06:32:39.582348	Sunday	1400	2115	369	\N	\N	\N	\N
2597	2023-08-03 06:32:39.591604	2023-08-03 06:32:39.591604	Tuesday	600	1515	370	\N	\N	\N	\N
2598	2023-08-03 06:32:39.592865	2023-08-03 06:32:39.592865	Wednesday	615	1400	370	\N	\N	\N	\N
2599	2023-08-03 06:32:39.594141	2023-08-03 06:32:39.594141	Friday	945	2030	370	\N	\N	\N	\N
2600	2023-08-03 06:32:39.595425	2023-08-03 06:32:39.595425	Saturday	800	1830	370	\N	\N	\N	\N
2601	2023-08-03 06:32:39.597021	2023-08-03 06:32:39.597021	Sunday	615	2145	370	\N	\N	\N	\N
2602	2023-08-03 06:32:39.609536	2023-08-03 06:32:39.609536	Monday	615	1845	371	\N	\N	\N	\N
2603	2023-08-03 06:32:39.610827	2023-08-03 06:32:39.610827	Tuesday	945	1900	371	\N	\N	\N	\N
2604	2023-08-03 06:32:39.612314	2023-08-03 06:32:39.612314	Wednesday	715	1430	371	\N	\N	\N	\N
2605	2023-08-03 06:32:39.613691	2023-08-03 06:32:39.613691	Thursday	630	2030	371	\N	\N	\N	\N
2606	2023-08-03 06:32:39.61515	2023-08-03 06:32:39.61515	Friday	800	2345	371	\N	\N	\N	\N
2607	2023-08-03 06:32:39.616473	2023-08-03 06:32:39.616473	Saturday	1000	1600	371	\N	\N	\N	\N
2608	2023-08-03 06:32:39.617789	2023-08-03 06:32:39.617789	Sunday	700	2345	371	\N	\N	\N	\N
2609	2023-08-03 06:32:39.62726	2023-08-03 06:32:39.62726	Wednesday	1000	1745	372	\N	\N	\N	\N
2610	2023-08-03 06:32:39.62853	2023-08-03 06:32:39.62853	Thursday	930	2000	372	\N	\N	\N	\N
2611	2023-08-03 06:32:39.62978	2023-08-03 06:32:39.62978	Friday	700	1730	372	\N	\N	\N	\N
2612	2023-08-03 06:32:39.631163	2023-08-03 06:32:39.631163	Sunday	1530	230	372	\N	\N	\N	\N
2613	2023-08-03 06:32:39.646265	2023-08-03 06:32:39.646265	Monday	30	1045	373	\N	\N	\N	\N
2614	2023-08-03 06:32:39.647591	2023-08-03 06:32:39.647591	Monday	1430	2130	373	\N	\N	\N	\N
2615	2023-08-03 06:32:39.649282	2023-08-03 06:32:39.649282	Tuesday	745	2230	373	\N	\N	\N	\N
2616	2023-08-03 06:32:39.650761	2023-08-03 06:32:39.650761	Wednesday	1315	1330	373	\N	\N	\N	\N
2617	2023-08-03 06:32:39.652047	2023-08-03 06:32:39.652047	Wednesday	1600	2015	373	\N	\N	\N	\N
2618	2023-08-03 06:32:39.653342	2023-08-03 06:32:39.653342	Thursday	1930	100	373	\N	\N	\N	\N
2619	2023-08-03 06:32:39.654727	2023-08-03 06:32:39.654727	Friday	30	715	373	\N	\N	\N	\N
2620	2023-08-03 06:32:39.656051	2023-08-03 06:32:39.656051	Friday	1215	2000	373	\N	\N	\N	\N
2621	2023-08-03 06:32:39.657814	2023-08-03 06:32:39.657814	Saturday	715	1945	373	\N	\N	\N	\N
2622	2023-08-03 06:32:39.659116	2023-08-03 06:32:39.659116	Sunday	615	1515	373	\N	\N	\N	\N
2623	2023-08-03 06:32:39.672636	2023-08-03 06:32:39.672636	Monday	1000	1915	374	\N	\N	\N	\N
2624	2023-08-03 06:32:39.674264	2023-08-03 06:32:39.674264	Friday	930	1415	374	\N	\N	\N	\N
2625	2023-08-03 06:32:39.675564	2023-08-03 06:32:39.675564	Saturday	1745	100	374	\N	\N	\N	\N
2626	2023-08-03 06:32:39.676894	2023-08-03 06:32:39.676894	Sunday	315	400	374	\N	\N	\N	\N
2627	2023-08-03 06:32:39.67813	2023-08-03 06:32:39.67813	Sunday	915	1515	374	\N	\N	\N	\N
2628	2023-08-03 06:32:39.715182	2023-08-03 06:32:39.715182	Monday	530	630	375	\N	\N	\N	\N
2629	2023-08-03 06:32:39.716634	2023-08-03 06:32:39.716634	Monday	1230	1715	375	\N	\N	\N	\N
2630	2023-08-03 06:32:39.717947	2023-08-03 06:32:39.717947	Tuesday	945	1815	375	\N	\N	\N	\N
2631	2023-08-03 06:32:39.719281	2023-08-03 06:32:39.719281	Wednesday	1915	130	375	\N	\N	\N	\N
2632	2023-08-03 06:32:39.720868	2023-08-03 06:32:39.720868	Thursday	730	1630	375	\N	\N	\N	\N
2633	2023-08-03 06:32:39.722238	2023-08-03 06:32:39.722238	Friday	830	2315	375	\N	\N	\N	\N
2634	2023-08-03 06:32:39.723586	2023-08-03 06:32:39.723586	Saturday	600	1800	375	\N	\N	\N	\N
2635	2023-08-03 06:32:39.725041	2023-08-03 06:32:39.725041	Sunday	1800	1945	375	\N	\N	\N	\N
2636	2023-08-03 06:32:39.726356	2023-08-03 06:32:39.726356	Sunday	2030	1015	375	\N	\N	\N	\N
2637	2023-08-03 06:32:39.735941	2023-08-03 06:32:39.735941	Monday	2030	215	376	\N	\N	\N	\N
2638	2023-08-03 06:32:39.737293	2023-08-03 06:32:39.737293	Tuesday	800	2015	376	\N	\N	\N	\N
2639	2023-08-03 06:32:39.738646	2023-08-03 06:32:39.738646	Wednesday	545	845	376	\N	\N	\N	\N
2640	2023-08-03 06:32:39.73992	2023-08-03 06:32:39.73992	Wednesday	1345	1945	376	\N	\N	\N	\N
2641	2023-08-03 06:32:39.74122	2023-08-03 06:32:39.74122	Friday	800	2130	376	\N	\N	\N	\N
2642	2023-08-03 06:32:39.742482	2023-08-03 06:32:39.742482	Sunday	830	1815	376	\N	\N	\N	\N
2643	2023-08-03 06:32:39.757475	2023-08-03 06:32:39.757475	Monday	1000	2115	377	\N	\N	\N	\N
2644	2023-08-03 06:32:39.75876	2023-08-03 06:32:39.75876	Wednesday	800	2400	377	\N	\N	\N	\N
2645	2023-08-03 06:32:39.760027	2023-08-03 06:32:39.760027	Thursday	900	1730	377	\N	\N	\N	\N
2646	2023-08-03 06:32:39.761317	2023-08-03 06:32:39.761317	Friday	900	1945	377	\N	\N	\N	\N
2647	2023-08-03 06:32:39.762717	2023-08-03 06:32:39.762717	Sunday	0	130	377	\N	\N	\N	\N
2648	2023-08-03 06:32:39.764079	2023-08-03 06:32:39.764079	Sunday	400	1315	377	\N	\N	\N	\N
2649	2023-08-03 06:32:39.773511	2023-08-03 06:32:39.773511	Monday	600	2215	378	\N	\N	\N	\N
2650	2023-08-03 06:32:39.774873	2023-08-03 06:32:39.774873	Tuesday	430	815	378	\N	\N	\N	\N
2651	2023-08-03 06:32:39.776151	2023-08-03 06:32:39.776151	Tuesday	830	2345	378	\N	\N	\N	\N
2652	2023-08-03 06:32:39.777407	2023-08-03 06:32:39.777407	Wednesday	915	1630	378	\N	\N	\N	\N
2653	2023-08-03 06:32:39.778671	2023-08-03 06:32:39.778671	Thursday	2145	400	378	\N	\N	\N	\N
2654	2023-08-03 06:32:39.780164	2023-08-03 06:32:39.780164	Friday	515	800	378	\N	\N	\N	\N
2655	2023-08-03 06:32:39.78142	2023-08-03 06:32:39.78142	Friday	1145	2345	378	\N	\N	\N	\N
2656	2023-08-03 06:32:39.782673	2023-08-03 06:32:39.782673	Saturday	745	1600	378	\N	\N	\N	\N
2657	2023-08-03 06:32:39.783927	2023-08-03 06:32:39.783927	Sunday	615	2000	378	\N	\N	\N	\N
2658	2023-08-03 06:32:39.798729	2023-08-03 06:32:39.798729	Monday	0	30	379	\N	\N	\N	\N
2659	2023-08-03 06:32:39.800034	2023-08-03 06:32:39.800034	Monday	530	2000	379	\N	\N	\N	\N
2660	2023-08-03 06:32:39.801321	2023-08-03 06:32:39.801321	Tuesday	630	1600	379	\N	\N	\N	\N
2661	2023-08-03 06:32:39.802568	2023-08-03 06:32:39.802568	Thursday	1815	330	379	\N	\N	\N	\N
2662	2023-08-03 06:32:39.803897	2023-08-03 06:32:39.803897	Friday	600	1630	379	\N	\N	\N	\N
2663	2023-08-03 06:32:39.805311	2023-08-03 06:32:39.805311	Sunday	600	1815	379	\N	\N	\N	\N
2664	2023-08-03 06:32:39.814572	2023-08-03 06:32:39.814572	Monday	700	1745	380	\N	\N	\N	\N
2665	2023-08-03 06:32:39.815897	2023-08-03 06:32:39.815897	Wednesday	615	1815	380	\N	\N	\N	\N
2666	2023-08-03 06:32:39.817666	2023-08-03 06:32:39.817666	Thursday	830	2130	380	\N	\N	\N	\N
2667	2023-08-03 06:32:39.832777	2023-08-03 06:32:39.832777	Monday	715	2030	381	\N	\N	\N	\N
2668	2023-08-03 06:32:39.834158	2023-08-03 06:32:39.834158	Tuesday	1700	330	381	\N	\N	\N	\N
2669	2023-08-03 06:32:39.835642	2023-08-03 06:32:39.835642	Wednesday	345	930	381	\N	\N	\N	\N
2670	2023-08-03 06:32:39.837007	2023-08-03 06:32:39.837007	Wednesday	1830	330	381	\N	\N	\N	\N
2671	2023-08-03 06:32:39.838332	2023-08-03 06:32:39.838332	Thursday	1245	1800	381	\N	\N	\N	\N
2672	2023-08-03 06:32:39.839621	2023-08-03 06:32:39.839621	Thursday	2045	2100	381	\N	\N	\N	\N
2673	2023-08-03 06:32:39.841062	2023-08-03 06:32:39.841062	Friday	330	1030	381	\N	\N	\N	\N
2674	2023-08-03 06:32:39.842559	2023-08-03 06:32:39.842559	Friday	2315	300	381	\N	\N	\N	\N
2675	2023-08-03 06:32:39.843907	2023-08-03 06:32:39.843907	Saturday	800	1330	381	\N	\N	\N	\N
2676	2023-08-03 06:32:39.845187	2023-08-03 06:32:39.845187	Saturday	1745	2200	381	\N	\N	\N	\N
2677	2023-08-03 06:32:39.846497	2023-08-03 06:32:39.846497	Sunday	700	2000	381	\N	\N	\N	\N
2678	2023-08-03 06:32:39.856201	2023-08-03 06:32:39.856201	Monday	45	300	382	\N	\N	\N	\N
2679	2023-08-03 06:32:39.857531	2023-08-03 06:32:39.857531	Monday	645	1615	382	\N	\N	\N	\N
2680	2023-08-03 06:32:39.858886	2023-08-03 06:32:39.858886	Tuesday	2015	230	382	\N	\N	\N	\N
2681	2023-08-03 06:32:39.860204	2023-08-03 06:32:39.860204	Wednesday	900	1815	382	\N	\N	\N	\N
2682	2023-08-03 06:32:39.861502	2023-08-03 06:32:39.861502	Thursday	930	2400	382	\N	\N	\N	\N
2683	2023-08-03 06:32:39.862786	2023-08-03 06:32:39.862786	Friday	715	2230	382	\N	\N	\N	\N
2684	2023-08-03 06:32:39.86407	2023-08-03 06:32:39.86407	Saturday	730	2230	382	\N	\N	\N	\N
2685	2023-08-03 06:32:39.878712	2023-08-03 06:32:39.878712	Tuesday	630	1945	383	\N	\N	\N	\N
2686	2023-08-03 06:32:39.880026	2023-08-03 06:32:39.880026	Wednesday	615	2200	383	\N	\N	\N	\N
2687	2023-08-03 06:32:39.881354	2023-08-03 06:32:39.881354	Thursday	1000	1415	383	\N	\N	\N	\N
2688	2023-08-03 06:32:39.88272	2023-08-03 06:32:39.88272	Saturday	915	1845	383	\N	\N	\N	\N
2689	2023-08-03 06:32:39.892016	2023-08-03 06:32:39.892016	Monday	745	1500	384	\N	\N	\N	\N
2690	2023-08-03 06:32:39.893301	2023-08-03 06:32:39.893301	Tuesday	1630	400	384	\N	\N	\N	\N
2691	2023-08-03 06:32:39.894589	2023-08-03 06:32:39.894589	Thursday	2015	100	384	\N	\N	\N	\N
2692	2023-08-03 06:32:39.895911	2023-08-03 06:32:39.895911	Friday	915	2315	384	\N	\N	\N	\N
2693	2023-08-03 06:32:39.89716	2023-08-03 06:32:39.89716	Sunday	800	1430	384	\N	\N	\N	\N
2694	2023-08-03 06:32:39.912932	2023-08-03 06:32:39.912932	Monday	1500	115	385	\N	\N	\N	\N
2695	2023-08-03 06:32:39.914222	2023-08-03 06:32:39.914222	Tuesday	800	1645	385	\N	\N	\N	\N
2696	2023-08-03 06:32:39.915591	2023-08-03 06:32:39.915591	Wednesday	430	900	385	\N	\N	\N	\N
2697	2023-08-03 06:32:39.916824	2023-08-03 06:32:39.916824	Wednesday	1400	1500	385	\N	\N	\N	\N
2698	2023-08-03 06:32:39.918042	2023-08-03 06:32:39.918042	Friday	700	2400	385	\N	\N	\N	\N
2699	2023-08-03 06:32:39.919292	2023-08-03 06:32:39.919292	Sunday	715	1530	385	\N	\N	\N	\N
2700	2023-08-03 06:32:39.928566	2023-08-03 06:32:39.928566	Monday	845	1015	386	\N	\N	\N	\N
2701	2023-08-03 06:32:39.929966	2023-08-03 06:32:39.929966	Monday	1300	1815	386	\N	\N	\N	\N
2702	2023-08-03 06:32:39.931402	2023-08-03 06:32:39.931402	Wednesday	400	1600	386	\N	\N	\N	\N
2703	2023-08-03 06:32:39.932685	2023-08-03 06:32:39.932685	Wednesday	1800	45	386	\N	\N	\N	\N
2704	2023-08-03 06:32:39.934033	2023-08-03 06:32:39.934033	Friday	845	1630	386	\N	\N	\N	\N
2705	2023-08-03 06:32:39.935324	2023-08-03 06:32:39.935324	Saturday	645	2245	386	\N	\N	\N	\N
2706	2023-08-03 06:32:39.936838	2023-08-03 06:32:39.936838	Sunday	630	1800	386	\N	\N	\N	\N
2707	2023-08-03 06:32:39.95186	2023-08-03 06:32:39.95186	Monday	745	1730	387	\N	\N	\N	\N
2708	2023-08-03 06:32:39.953207	2023-08-03 06:32:39.953207	Tuesday	15	830	387	\N	\N	\N	\N
2709	2023-08-03 06:32:39.954459	2023-08-03 06:32:39.954459	Tuesday	1045	2200	387	\N	\N	\N	\N
2710	2023-08-03 06:32:39.955794	2023-08-03 06:32:39.955794	Wednesday	230	615	387	\N	\N	\N	\N
2711	2023-08-03 06:32:39.957097	2023-08-03 06:32:39.957097	Wednesday	730	1000	387	\N	\N	\N	\N
2712	2023-08-03 06:32:39.958424	2023-08-03 06:32:39.958424	Thursday	1000	1500	387	\N	\N	\N	\N
2713	2023-08-03 06:32:39.959953	2023-08-03 06:32:39.959953	Saturday	215	315	387	\N	\N	\N	\N
2714	2023-08-03 06:32:39.96141	2023-08-03 06:32:39.96141	Saturday	345	1445	387	\N	\N	\N	\N
2715	2023-08-03 06:32:39.962758	2023-08-03 06:32:39.962758	Sunday	2115	200	387	\N	\N	\N	\N
2716	2023-08-03 06:32:39.9719	2023-08-03 06:32:39.9719	Monday	900	1400	388	\N	\N	\N	\N
2717	2023-08-03 06:32:39.973404	2023-08-03 06:32:39.973404	Tuesday	715	1415	388	\N	\N	\N	\N
2718	2023-08-03 06:32:39.97473	2023-08-03 06:32:39.97473	Wednesday	845	1745	388	\N	\N	\N	\N
2719	2023-08-03 06:32:39.976151	2023-08-03 06:32:39.976151	Thursday	900	2330	388	\N	\N	\N	\N
2720	2023-08-03 06:32:39.977461	2023-08-03 06:32:39.977461	Saturday	1815	2115	388	\N	\N	\N	\N
2721	2023-08-03 06:32:39.978714	2023-08-03 06:32:39.978714	Saturday	2300	115	388	\N	\N	\N	\N
2722	2023-08-03 06:32:39.979993	2023-08-03 06:32:39.979993	Sunday	730	1830	388	\N	\N	\N	\N
2723	2023-08-03 06:32:39.995933	2023-08-03 06:32:39.995933	Monday	845	1445	389	\N	\N	\N	\N
2724	2023-08-03 06:32:39.997232	2023-08-03 06:32:39.997232	Wednesday	1830	330	389	\N	\N	\N	\N
2725	2023-08-03 06:32:39.998712	2023-08-03 06:32:39.998712	Thursday	945	1715	389	\N	\N	\N	\N
2726	2023-08-03 06:32:40.000034	2023-08-03 06:32:40.000034	Friday	915	1615	389	\N	\N	\N	\N
2727	2023-08-03 06:32:40.00909	2023-08-03 06:32:40.00909	Monday	615	1415	390	\N	\N	\N	\N
2728	2023-08-03 06:32:40.010392	2023-08-03 06:32:40.010392	Tuesday	1930	400	390	\N	\N	\N	\N
2729	2023-08-03 06:32:40.011899	2023-08-03 06:32:40.011899	Thursday	645	1200	390	\N	\N	\N	\N
2730	2023-08-03 06:32:40.013196	2023-08-03 06:32:40.013196	Thursday	1745	130	390	\N	\N	\N	\N
2731	2023-08-03 06:32:40.014503	2023-08-03 06:32:40.014503	Sunday	730	2330	390	\N	\N	\N	\N
2732	2023-08-03 06:32:40.028912	2023-08-03 06:32:40.028912	Monday	800	2100	391	\N	\N	\N	\N
2733	2023-08-03 06:32:40.030191	2023-08-03 06:32:40.030191	Tuesday	400	845	391	\N	\N	\N	\N
2734	2023-08-03 06:32:40.031409	2023-08-03 06:32:40.031409	Tuesday	1100	1145	391	\N	\N	\N	\N
2735	2023-08-03 06:32:40.032746	2023-08-03 06:32:40.032746	Wednesday	630	1400	391	\N	\N	\N	\N
2736	2023-08-03 06:32:40.034093	2023-08-03 06:32:40.034093	Wednesday	2015	430	391	\N	\N	\N	\N
2737	2023-08-03 06:32:40.035604	2023-08-03 06:32:40.035604	Thursday	1430	200	391	\N	\N	\N	\N
2738	2023-08-03 06:32:40.037096	2023-08-03 06:32:40.037096	Sunday	600	930	391	\N	\N	\N	\N
2739	2023-08-03 06:32:40.038426	2023-08-03 06:32:40.038426	Sunday	2130	2230	391	\N	\N	\N	\N
2740	2023-08-03 06:32:40.048228	2023-08-03 06:32:40.048228	Monday	545	1230	392	\N	\N	\N	\N
2741	2023-08-03 06:32:40.049531	2023-08-03 06:32:40.049531	Monday	1830	1930	392	\N	\N	\N	\N
2742	2023-08-03 06:32:40.050836	2023-08-03 06:32:40.050836	Tuesday	900	2330	392	\N	\N	\N	\N
2743	2023-08-03 06:32:40.052195	2023-08-03 06:32:40.052195	Wednesday	200	1145	392	\N	\N	\N	\N
2744	2023-08-03 06:32:40.05344	2023-08-03 06:32:40.05344	Wednesday	1745	2015	392	\N	\N	\N	\N
2745	2023-08-03 06:32:40.0547	2023-08-03 06:32:40.0547	Thursday	945	2145	392	\N	\N	\N	\N
2746	2023-08-03 06:32:40.055976	2023-08-03 06:32:40.055976	Friday	1845	130	392	\N	\N	\N	\N
2747	2023-08-03 06:32:40.057226	2023-08-03 06:32:40.057226	Saturday	615	1430	392	\N	\N	\N	\N
2748	2023-08-03 06:32:40.058613	2023-08-03 06:32:40.058613	Sunday	630	1600	392	\N	\N	\N	\N
2749	2023-08-03 06:32:40.076401	2023-08-03 06:32:40.076401	Monday	1000	2145	393	\N	\N	\N	\N
2750	2023-08-03 06:32:40.078043	2023-08-03 06:32:40.078043	Tuesday	600	1630	393	\N	\N	\N	\N
2751	2023-08-03 06:32:40.079441	2023-08-03 06:32:40.079441	Wednesday	830	2315	393	\N	\N	\N	\N
2752	2023-08-03 06:32:40.080832	2023-08-03 06:32:40.080832	Thursday	845	1600	393	\N	\N	\N	\N
2753	2023-08-03 06:32:40.082248	2023-08-03 06:32:40.082248	Friday	215	800	393	\N	\N	\N	\N
2754	2023-08-03 06:32:40.083546	2023-08-03 06:32:40.083546	Friday	1500	100	393	\N	\N	\N	\N
2755	2023-08-03 06:32:40.08496	2023-08-03 06:32:40.08496	Saturday	730	830	393	\N	\N	\N	\N
2756	2023-08-03 06:32:40.08648	2023-08-03 06:32:40.08648	Saturday	1345	1730	393	\N	\N	\N	\N
2757	2023-08-03 06:32:40.087817	2023-08-03 06:32:40.087817	Sunday	0	145	393	\N	\N	\N	\N
2758	2023-08-03 06:32:40.089087	2023-08-03 06:32:40.089087	Sunday	745	2300	393	\N	\N	\N	\N
2759	2023-08-03 06:32:40.098756	2023-08-03 06:32:40.098756	Monday	830	2230	394	\N	\N	\N	\N
2760	2023-08-03 06:32:40.100212	2023-08-03 06:32:40.100212	Tuesday	115	315	394	\N	\N	\N	\N
2761	2023-08-03 06:32:40.101483	2023-08-03 06:32:40.101483	Tuesday	1315	2100	394	\N	\N	\N	\N
2762	2023-08-03 06:32:40.102742	2023-08-03 06:32:40.102742	Wednesday	645	1415	394	\N	\N	\N	\N
2763	2023-08-03 06:32:40.104127	2023-08-03 06:32:40.104127	Thursday	0	1715	394	\N	\N	\N	\N
2764	2023-08-03 06:32:40.10538	2023-08-03 06:32:40.10538	Thursday	2230	2315	394	\N	\N	\N	\N
2765	2023-08-03 06:32:40.106743	2023-08-03 06:32:40.106743	Friday	100	1200	394	\N	\N	\N	\N
2766	2023-08-03 06:32:40.10799	2023-08-03 06:32:40.10799	Friday	1215	1930	394	\N	\N	\N	\N
2767	2023-08-03 06:32:40.109515	2023-08-03 06:32:40.109515	Saturday	245	400	394	\N	\N	\N	\N
2768	2023-08-03 06:32:40.110776	2023-08-03 06:32:40.110776	Saturday	500	1115	394	\N	\N	\N	\N
2769	2023-08-03 06:32:40.112109	2023-08-03 06:32:40.112109	Sunday	1145	1300	394	\N	\N	\N	\N
2770	2023-08-03 06:32:40.113367	2023-08-03 06:32:40.113367	Sunday	2115	2330	394	\N	\N	\N	\N
2771	2023-08-03 06:32:40.127994	2023-08-03 06:32:40.127994	Monday	700	1515	395	\N	\N	\N	\N
2772	2023-08-03 06:32:40.129326	2023-08-03 06:32:40.129326	Tuesday	700	1400	395	\N	\N	\N	\N
2773	2023-08-03 06:32:40.13065	2023-08-03 06:32:40.13065	Wednesday	1415	1845	395	\N	\N	\N	\N
2774	2023-08-03 06:32:40.131855	2023-08-03 06:32:40.131855	Wednesday	2215	2300	395	\N	\N	\N	\N
2775	2023-08-03 06:32:40.133355	2023-08-03 06:32:40.133355	Thursday	215	830	395	\N	\N	\N	\N
2776	2023-08-03 06:32:40.134617	2023-08-03 06:32:40.134617	Thursday	2245	2400	395	\N	\N	\N	\N
2777	2023-08-03 06:32:40.136011	2023-08-03 06:32:40.136011	Friday	645	2200	395	\N	\N	\N	\N
2778	2023-08-03 06:32:40.137256	2023-08-03 06:32:40.137256	Saturday	830	2400	395	\N	\N	\N	\N
2779	2023-08-03 06:32:40.13857	2023-08-03 06:32:40.13857	Sunday	815	1945	395	\N	\N	\N	\N
2780	2023-08-03 06:32:40.147832	2023-08-03 06:32:40.147832	Monday	345	515	396	\N	\N	\N	\N
2781	2023-08-03 06:32:40.149085	2023-08-03 06:32:40.149085	Monday	645	2145	396	\N	\N	\N	\N
2782	2023-08-03 06:32:40.150318	2023-08-03 06:32:40.150318	Tuesday	745	2345	396	\N	\N	\N	\N
2783	2023-08-03 06:32:40.151572	2023-08-03 06:32:40.151572	Thursday	30	845	396	\N	\N	\N	\N
2784	2023-08-03 06:32:40.152832	2023-08-03 06:32:40.152832	Thursday	2130	2300	396	\N	\N	\N	\N
2785	2023-08-03 06:32:40.154068	2023-08-03 06:32:40.154068	Friday	930	2115	396	\N	\N	\N	\N
2786	2023-08-03 06:32:40.155543	2023-08-03 06:32:40.155543	Saturday	730	1815	396	\N	\N	\N	\N
2787	2023-08-03 06:32:40.156797	2023-08-03 06:32:40.156797	Sunday	700	1615	396	\N	\N	\N	\N
2788	2023-08-03 06:32:40.171248	2023-08-03 06:32:40.171248	Tuesday	715	2200	397	\N	\N	\N	\N
2789	2023-08-03 06:32:40.172647	2023-08-03 06:32:40.172647	Wednesday	415	445	397	\N	\N	\N	\N
2790	2023-08-03 06:32:40.173893	2023-08-03 06:32:40.173893	Wednesday	1745	2230	397	\N	\N	\N	\N
2791	2023-08-03 06:32:40.175201	2023-08-03 06:32:40.175201	Thursday	2145	245	397	\N	\N	\N	\N
2792	2023-08-03 06:32:40.17648	2023-08-03 06:32:40.17648	Friday	700	2000	397	\N	\N	\N	\N
2793	2023-08-03 06:32:40.17773	2023-08-03 06:32:40.17773	Saturday	900	1545	397	\N	\N	\N	\N
2794	2023-08-03 06:32:40.179227	2023-08-03 06:32:40.179227	Sunday	115	1800	397	\N	\N	\N	\N
2795	2023-08-03 06:32:40.180436	2023-08-03 06:32:40.180436	Sunday	2000	2100	397	\N	\N	\N	\N
2796	2023-08-03 06:32:40.189823	2023-08-03 06:32:40.189823	Monday	815	1700	398	\N	\N	\N	\N
2797	2023-08-03 06:32:40.191357	2023-08-03 06:32:40.191357	Tuesday	2130	245	398	\N	\N	\N	\N
2798	2023-08-03 06:32:40.19265	2023-08-03 06:32:40.19265	Wednesday	930	1630	398	\N	\N	\N	\N
2799	2023-08-03 06:32:40.193899	2023-08-03 06:32:40.193899	Thursday	700	1600	398	\N	\N	\N	\N
2800	2023-08-03 06:32:40.195138	2023-08-03 06:32:40.195138	Friday	700	2200	398	\N	\N	\N	\N
2801	2023-08-03 06:32:40.19644	2023-08-03 06:32:40.19644	Saturday	630	2045	398	\N	\N	\N	\N
2802	2023-08-03 06:32:40.197722	2023-08-03 06:32:40.197722	Sunday	1000	2015	398	\N	\N	\N	\N
2803	2023-08-03 06:32:40.212362	2023-08-03 06:32:40.212362	Tuesday	1000	1445	399	\N	\N	\N	\N
2804	2023-08-03 06:32:40.213754	2023-08-03 06:32:40.213754	Wednesday	715	2215	399	\N	\N	\N	\N
2805	2023-08-03 06:32:40.215285	2023-08-03 06:32:40.215285	Thursday	900	2000	399	\N	\N	\N	\N
2806	2023-08-03 06:32:40.216605	2023-08-03 06:32:40.216605	Friday	2245	115	399	\N	\N	\N	\N
2807	2023-08-03 06:32:40.217884	2023-08-03 06:32:40.217884	Saturday	730	2345	399	\N	\N	\N	\N
2808	2023-08-03 06:32:40.219116	2023-08-03 06:32:40.219116	Sunday	915	2115	399	\N	\N	\N	\N
2809	2023-08-03 06:32:40.23185	2023-08-03 06:32:40.23185	Monday	1415	300	400	\N	\N	\N	\N
2810	2023-08-03 06:32:40.233215	2023-08-03 06:32:40.233215	Tuesday	745	2015	400	\N	\N	\N	\N
2811	2023-08-03 06:32:40.234512	2023-08-03 06:32:40.234512	Wednesday	800	2230	400	\N	\N	\N	\N
2812	2023-08-03 06:32:40.235847	2023-08-03 06:32:40.235847	Friday	1145	1815	400	\N	\N	\N	\N
2813	2023-08-03 06:32:40.237163	2023-08-03 06:32:40.237163	Friday	2200	315	400	\N	\N	\N	\N
2814	2023-08-03 06:32:40.238412	2023-08-03 06:32:40.238412	Saturday	1900	300	400	\N	\N	\N	\N
2815	2023-08-03 06:32:40.23982	2023-08-03 06:32:40.23982	Sunday	1445	345	400	\N	\N	\N	\N
2816	2023-08-03 06:32:40.255795	2023-08-03 06:32:40.255795	Monday	900	1545	401	\N	\N	\N	\N
2817	2023-08-03 06:32:40.257114	2023-08-03 06:32:40.257114	Thursday	30	415	401	\N	\N	\N	\N
2818	2023-08-03 06:32:40.258372	2023-08-03 06:32:40.258372	Thursday	1100	1930	401	\N	\N	\N	\N
2819	2023-08-03 06:32:40.259635	2023-08-03 06:32:40.259635	Friday	645	2015	401	\N	\N	\N	\N
2820	2023-08-03 06:32:40.26095	2023-08-03 06:32:40.26095	Saturday	1230	1815	401	\N	\N	\N	\N
2821	2023-08-03 06:32:40.2622	2023-08-03 06:32:40.2622	Saturday	1830	1845	401	\N	\N	\N	\N
2822	2023-08-03 06:32:40.263645	2023-08-03 06:32:40.263645	Sunday	2115	245	401	\N	\N	\N	\N
2823	2023-08-03 06:32:40.273062	2023-08-03 06:32:40.273062	Monday	845	2215	402	\N	\N	\N	\N
2824	2023-08-03 06:32:40.274357	2023-08-03 06:32:40.274357	Tuesday	745	1745	402	\N	\N	\N	\N
2825	2023-08-03 06:32:40.275619	2023-08-03 06:32:40.275619	Thursday	930	1800	402	\N	\N	\N	\N
2826	2023-08-03 06:32:40.276897	2023-08-03 06:32:40.276897	Friday	615	1945	402	\N	\N	\N	\N
2827	2023-08-03 06:32:40.278163	2023-08-03 06:32:40.278163	Saturday	845	2400	402	\N	\N	\N	\N
2828	2023-08-03 06:32:40.292825	2023-08-03 06:32:40.292825	Monday	615	1845	403	\N	\N	\N	\N
2829	2023-08-03 06:32:40.294103	2023-08-03 06:32:40.294103	Monday	1900	2300	403	\N	\N	\N	\N
2830	2023-08-03 06:32:40.295438	2023-08-03 06:32:40.295438	Wednesday	930	1000	403	\N	\N	\N	\N
2831	2023-08-03 06:32:40.296754	2023-08-03 06:32:40.296754	Wednesday	1045	2230	403	\N	\N	\N	\N
2832	2023-08-03 06:32:40.298267	2023-08-03 06:32:40.298267	Thursday	715	2330	403	\N	\N	\N	\N
2833	2023-08-03 06:32:40.299526	2023-08-03 06:32:40.299526	Friday	1900	230	403	\N	\N	\N	\N
2834	2023-08-03 06:32:40.300973	2023-08-03 06:32:40.300973	Saturday	830	1930	403	\N	\N	\N	\N
2835	2023-08-03 06:32:40.302266	2023-08-03 06:32:40.302266	Sunday	1745	215	403	\N	\N	\N	\N
2836	2023-08-03 06:32:40.311586	2023-08-03 06:32:40.311586	Monday	1830	230	404	\N	\N	\N	\N
2837	2023-08-03 06:32:40.312906	2023-08-03 06:32:40.312906	Tuesday	1400	230	404	\N	\N	\N	\N
2838	2023-08-03 06:32:40.314585	2023-08-03 06:32:40.314585	Thursday	915	1115	404	\N	\N	\N	\N
2839	2023-08-03 06:32:40.315912	2023-08-03 06:32:40.315912	Thursday	1315	1745	404	\N	\N	\N	\N
2840	2023-08-03 06:32:40.3172	2023-08-03 06:32:40.3172	Friday	845	2145	404	\N	\N	\N	\N
2841	2023-08-03 06:32:40.318598	2023-08-03 06:32:40.318598	Saturday	715	2145	404	\N	\N	\N	\N
2842	2023-08-03 06:32:40.319874	2023-08-03 06:32:40.319874	Sunday	715	2015	404	\N	\N	\N	\N
2843	2023-08-03 06:32:40.33451	2023-08-03 06:32:40.33451	Monday	700	1630	405	\N	\N	\N	\N
2844	2023-08-03 06:32:40.335854	2023-08-03 06:32:40.335854	Tuesday	845	2030	405	\N	\N	\N	\N
2845	2023-08-03 06:32:40.33733	2023-08-03 06:32:40.33733	Wednesday	615	1715	405	\N	\N	\N	\N
2846	2023-08-03 06:32:40.338622	2023-08-03 06:32:40.338622	Thursday	745	1845	405	\N	\N	\N	\N
2847	2023-08-03 06:32:40.340162	2023-08-03 06:32:40.340162	Saturday	900	2045	405	\N	\N	\N	\N
2848	2023-08-03 06:32:40.349754	2023-08-03 06:32:40.349754	Monday	645	845	406	\N	\N	\N	\N
2849	2023-08-03 06:32:40.351021	2023-08-03 06:32:40.351021	Monday	900	1045	406	\N	\N	\N	\N
2850	2023-08-03 06:32:40.352452	2023-08-03 06:32:40.352452	Tuesday	915	1230	406	\N	\N	\N	\N
2851	2023-08-03 06:32:40.353676	2023-08-03 06:32:40.353676	Tuesday	1600	2145	406	\N	\N	\N	\N
2852	2023-08-03 06:32:40.354959	2023-08-03 06:32:40.354959	Wednesday	815	1430	406	\N	\N	\N	\N
2853	2023-08-03 06:32:40.356211	2023-08-03 06:32:40.356211	Thursday	615	2045	406	\N	\N	\N	\N
2854	2023-08-03 06:32:40.357443	2023-08-03 06:32:40.357443	Sunday	615	2400	406	\N	\N	\N	\N
2855	2023-08-03 06:32:40.371452	2023-08-03 06:32:40.371452	Monday	745	1315	407	\N	\N	\N	\N
2856	2023-08-03 06:32:40.372988	2023-08-03 06:32:40.372988	Monday	1630	230	407	\N	\N	\N	\N
2857	2023-08-03 06:32:40.37433	2023-08-03 06:32:40.37433	Thursday	930	1800	407	\N	\N	\N	\N
2858	2023-08-03 06:32:40.375709	2023-08-03 06:32:40.375709	Friday	1000	2115	407	\N	\N	\N	\N
2859	2023-08-03 06:32:40.377033	2023-08-03 06:32:40.377033	Saturday	1130	1900	407	\N	\N	\N	\N
2860	2023-08-03 06:32:40.378332	2023-08-03 06:32:40.378332	Saturday	1945	815	407	\N	\N	\N	\N
2861	2023-08-03 06:32:40.37969	2023-08-03 06:32:40.37969	Sunday	100	1115	407	\N	\N	\N	\N
2862	2023-08-03 06:32:40.380927	2023-08-03 06:32:40.380927	Sunday	1300	1515	407	\N	\N	\N	\N
2863	2023-08-03 06:32:40.390165	2023-08-03 06:32:40.390165	Tuesday	1530	245	408	\N	\N	\N	\N
2864	2023-08-03 06:32:40.391444	2023-08-03 06:32:40.391444	Saturday	815	1700	408	\N	\N	\N	\N
2865	2023-08-03 06:32:40.392726	2023-08-03 06:32:40.392726	Sunday	245	1015	408	\N	\N	\N	\N
2866	2023-08-03 06:32:40.394031	2023-08-03 06:32:40.394031	Sunday	1100	215	408	\N	\N	\N	\N
2867	2023-08-03 06:32:40.408845	2023-08-03 06:32:40.408845	Monday	930	2315	409	\N	\N	\N	\N
2868	2023-08-03 06:32:40.410264	2023-08-03 06:32:40.410264	Tuesday	945	1645	409	\N	\N	\N	\N
2869	2023-08-03 06:32:40.41156	2023-08-03 06:32:40.41156	Wednesday	2245	215	409	\N	\N	\N	\N
2870	2023-08-03 06:32:40.412776	2023-08-03 06:32:40.412776	Thursday	745	1845	409	\N	\N	\N	\N
2871	2023-08-03 06:32:40.414045	2023-08-03 06:32:40.414045	Friday	1800	115	409	\N	\N	\N	\N
2872	2023-08-03 06:32:40.415309	2023-08-03 06:32:40.415309	Saturday	900	2230	409	\N	\N	\N	\N
2873	2023-08-03 06:32:40.416708	2023-08-03 06:32:40.416708	Sunday	30	230	409	\N	\N	\N	\N
2874	2023-08-03 06:32:40.417921	2023-08-03 06:32:40.417921	Sunday	500	2315	409	\N	\N	\N	\N
2875	2023-08-03 06:32:40.427059	2023-08-03 06:32:40.427059	Monday	315	745	410	\N	\N	\N	\N
2876	2023-08-03 06:32:40.428302	2023-08-03 06:32:40.428302	Monday	2000	2200	410	\N	\N	\N	\N
2877	2023-08-03 06:32:40.429595	2023-08-03 06:32:40.429595	Tuesday	1630	315	410	\N	\N	\N	\N
2878	2023-08-03 06:32:40.431047	2023-08-03 06:32:40.431047	Wednesday	1600	1700	410	\N	\N	\N	\N
2879	2023-08-03 06:32:40.432508	2023-08-03 06:32:40.432508	Wednesday	1830	1930	410	\N	\N	\N	\N
2880	2023-08-03 06:32:40.433853	2023-08-03 06:32:40.433853	Thursday	700	1415	410	\N	\N	\N	\N
2881	2023-08-03 06:32:40.435132	2023-08-03 06:32:40.435132	Friday	830	1545	410	\N	\N	\N	\N
2882	2023-08-03 06:32:40.436452	2023-08-03 06:32:40.436452	Saturday	1900	200	410	\N	\N	\N	\N
2883	2023-08-03 06:32:40.437802	2023-08-03 06:32:40.437802	Sunday	600	1645	410	\N	\N	\N	\N
2884	2023-08-03 06:32:40.453768	2023-08-03 06:32:40.453768	Monday	615	2315	411	\N	\N	\N	\N
2885	2023-08-03 06:32:40.455433	2023-08-03 06:32:40.455433	Tuesday	1900	145	411	\N	\N	\N	\N
2886	2023-08-03 06:32:40.456788	2023-08-03 06:32:40.456788	Wednesday	800	1630	411	\N	\N	\N	\N
2887	2023-08-03 06:32:40.458313	2023-08-03 06:32:40.458313	Thursday	715	2400	411	\N	\N	\N	\N
2888	2023-08-03 06:32:40.459679	2023-08-03 06:32:40.459679	Saturday	730	1900	411	\N	\N	\N	\N
2889	2023-08-03 06:32:40.468991	2023-08-03 06:32:40.468991	Monday	845	1615	412	\N	\N	\N	\N
2890	2023-08-03 06:32:40.470341	2023-08-03 06:32:40.470341	Tuesday	530	1445	412	\N	\N	\N	\N
2891	2023-08-03 06:32:40.47164	2023-08-03 06:32:40.47164	Tuesday	1545	0	412	\N	\N	\N	\N
2892	2023-08-03 06:32:40.473017	2023-08-03 06:32:40.473017	Thursday	215	230	412	\N	\N	\N	\N
2893	2023-08-03 06:32:40.474314	2023-08-03 06:32:40.474314	Thursday	1415	1445	412	\N	\N	\N	\N
2894	2023-08-03 06:32:40.475643	2023-08-03 06:32:40.475643	Friday	945	2130	412	\N	\N	\N	\N
2895	2023-08-03 06:32:40.476942	2023-08-03 06:32:40.476942	Saturday	830	1945	412	\N	\N	\N	\N
2896	2023-08-03 06:32:40.478304	2023-08-03 06:32:40.478304	Sunday	45	330	412	\N	\N	\N	\N
2897	2023-08-03 06:32:40.479771	2023-08-03 06:32:40.479771	Sunday	1430	1700	412	\N	\N	\N	\N
2898	2023-08-03 06:32:40.494571	2023-08-03 06:32:40.494571	Monday	715	2030	413	\N	\N	\N	\N
2899	2023-08-03 06:32:40.496026	2023-08-03 06:32:40.496026	Tuesday	445	830	413	\N	\N	\N	\N
2900	2023-08-03 06:32:40.497337	2023-08-03 06:32:40.497337	Tuesday	1500	1700	413	\N	\N	\N	\N
2901	2023-08-03 06:32:40.498662	2023-08-03 06:32:40.498662	Wednesday	215	745	413	\N	\N	\N	\N
2902	2023-08-03 06:32:40.499913	2023-08-03 06:32:40.499913	Wednesday	900	1845	413	\N	\N	\N	\N
2903	2023-08-03 06:32:40.501211	2023-08-03 06:32:40.501211	Thursday	1315	1515	413	\N	\N	\N	\N
2904	2023-08-03 06:32:40.502435	2023-08-03 06:32:40.502435	Thursday	1900	2000	413	\N	\N	\N	\N
2905	2023-08-03 06:32:40.503892	2023-08-03 06:32:40.503892	Friday	700	2045	413	\N	\N	\N	\N
2906	2023-08-03 06:32:40.50514	2023-08-03 06:32:40.50514	Sunday	945	2400	413	\N	\N	\N	\N
2907	2023-08-03 06:32:40.514267	2023-08-03 06:32:40.514267	Tuesday	315	415	414	\N	\N	\N	\N
2908	2023-08-03 06:32:40.515797	2023-08-03 06:32:40.515797	Tuesday	815	2245	414	\N	\N	\N	\N
2909	2023-08-03 06:32:40.517064	2023-08-03 06:32:40.517064	Wednesday	845	2300	414	\N	\N	\N	\N
2910	2023-08-03 06:32:40.51833	2023-08-03 06:32:40.51833	Saturday	700	2145	414	\N	\N	\N	\N
2911	2023-08-03 06:32:40.519673	2023-08-03 06:32:40.519673	Sunday	745	2315	414	\N	\N	\N	\N
2912	2023-08-03 06:32:40.533923	2023-08-03 06:32:40.533923	Monday	815	1400	415	\N	\N	\N	\N
2913	2023-08-03 06:32:40.535233	2023-08-03 06:32:40.535233	Tuesday	415	830	415	\N	\N	\N	\N
2914	2023-08-03 06:32:40.536452	2023-08-03 06:32:40.536452	Tuesday	1630	1815	415	\N	\N	\N	\N
2915	2023-08-03 06:32:40.537737	2023-08-03 06:32:40.537737	Wednesday	745	1945	415	\N	\N	\N	\N
2916	2023-08-03 06:32:40.539244	2023-08-03 06:32:40.539244	Thursday	630	1915	415	\N	\N	\N	\N
2917	2023-08-03 06:32:40.540497	2023-08-03 06:32:40.540497	Friday	915	2000	415	\N	\N	\N	\N
2918	2023-08-03 06:32:40.541756	2023-08-03 06:32:40.541756	Saturday	1745	100	415	\N	\N	\N	\N
2919	2023-08-03 06:32:40.543015	2023-08-03 06:32:40.543015	Sunday	1900	200	415	\N	\N	\N	\N
2920	2023-08-03 06:32:40.552407	2023-08-03 06:32:40.552407	Monday	815	2315	416	\N	\N	\N	\N
2921	2023-08-03 06:32:40.553785	2023-08-03 06:32:40.553785	Thursday	400	500	416	\N	\N	\N	\N
2922	2023-08-03 06:32:40.555092	2023-08-03 06:32:40.555092	Thursday	530	1915	416	\N	\N	\N	\N
2923	2023-08-03 06:32:40.556426	2023-08-03 06:32:40.556426	Friday	830	1545	416	\N	\N	\N	\N
2924	2023-08-03 06:32:40.557804	2023-08-03 06:32:40.557804	Saturday	30	730	416	\N	\N	\N	\N
2925	2023-08-03 06:32:40.559293	2023-08-03 06:32:40.559293	Saturday	1130	2045	416	\N	\N	\N	\N
2926	2023-08-03 06:32:40.561126	2023-08-03 06:32:40.561126	Sunday	1800	2145	416	\N	\N	\N	\N
2927	2023-08-03 06:32:40.563248	2023-08-03 06:32:40.563248	Sunday	2330	545	416	\N	\N	\N	\N
2928	2023-08-03 06:32:40.582407	2023-08-03 06:32:40.582407	Monday	945	2345	417	\N	\N	\N	\N
2929	2023-08-03 06:32:40.584281	2023-08-03 06:32:40.584281	Tuesday	15	800	417	\N	\N	\N	\N
2930	2023-08-03 06:32:40.5861	2023-08-03 06:32:40.5861	Tuesday	1500	2345	417	\N	\N	\N	\N
2931	2023-08-03 06:32:40.588107	2023-08-03 06:32:40.588107	Wednesday	2115	345	417	\N	\N	\N	\N
2932	2023-08-03 06:32:40.589829	2023-08-03 06:32:40.589829	Thursday	400	430	417	\N	\N	\N	\N
2933	2023-08-03 06:32:40.591625	2023-08-03 06:32:40.591625	Thursday	1330	2115	417	\N	\N	\N	\N
2934	2023-08-03 06:32:40.593247	2023-08-03 06:32:40.593247	Friday	1815	400	417	\N	\N	\N	\N
2935	2023-08-03 06:32:40.594857	2023-08-03 06:32:40.594857	Saturday	945	2100	417	\N	\N	\N	\N
2936	2023-08-03 06:32:40.596409	2023-08-03 06:32:40.596409	Saturday	2330	2345	417	\N	\N	\N	\N
2937	2023-08-03 06:32:40.598077	2023-08-03 06:32:40.598077	Sunday	700	930	417	\N	\N	\N	\N
2938	2023-08-03 06:32:40.599661	2023-08-03 06:32:40.599661	Sunday	1230	1815	417	\N	\N	\N	\N
2939	2023-08-03 06:32:40.61155	2023-08-03 06:32:40.61155	Monday	600	1700	418	\N	\N	\N	\N
2940	2023-08-03 06:32:40.614461	2023-08-03 06:32:40.614461	Tuesday	745	2130	418	\N	\N	\N	\N
2941	2023-08-03 06:32:40.618249	2023-08-03 06:32:40.618249	Wednesday	415	1145	418	\N	\N	\N	\N
2942	2023-08-03 06:32:40.620374	2023-08-03 06:32:40.620374	Wednesday	1330	1430	418	\N	\N	\N	\N
2943	2023-08-03 06:32:40.622223	2023-08-03 06:32:40.622223	Thursday	145	200	418	\N	\N	\N	\N
2944	2023-08-03 06:32:40.623838	2023-08-03 06:32:40.623838	Thursday	1145	2000	418	\N	\N	\N	\N
2945	2023-08-03 06:32:40.625477	2023-08-03 06:32:40.625477	Friday	830	1715	418	\N	\N	\N	\N
2946	2023-08-03 06:32:40.627067	2023-08-03 06:32:40.627067	Saturday	900	1515	418	\N	\N	\N	\N
2947	2023-08-03 06:32:40.629054	2023-08-03 06:32:40.629054	Sunday	600	1930	418	\N	\N	\N	\N
2948	2023-08-03 06:32:40.647226	2023-08-03 06:32:40.647226	Tuesday	645	1830	419	\N	\N	\N	\N
2949	2023-08-03 06:32:40.648571	2023-08-03 06:32:40.648571	Wednesday	645	1800	419	\N	\N	\N	\N
2950	2023-08-03 06:32:40.650093	2023-08-03 06:32:40.650093	Thursday	715	1900	419	\N	\N	\N	\N
2951	2023-08-03 06:32:40.651402	2023-08-03 06:32:40.651402	Friday	1715	245	419	\N	\N	\N	\N
2952	2023-08-03 06:32:40.652695	2023-08-03 06:32:40.652695	Saturday	945	1530	419	\N	\N	\N	\N
2953	2023-08-03 06:32:40.653973	2023-08-03 06:32:40.653973	Sunday	900	1615	419	\N	\N	\N	\N
2954	2023-08-03 06:32:40.663259	2023-08-03 06:32:40.663259	Monday	930	1400	420	\N	\N	\N	\N
2955	2023-08-03 06:32:40.664599	2023-08-03 06:32:40.664599	Tuesday	700	2345	420	\N	\N	\N	\N
2956	2023-08-03 06:32:40.665902	2023-08-03 06:32:40.665902	Wednesday	900	2215	420	\N	\N	\N	\N
2957	2023-08-03 06:32:40.667154	2023-08-03 06:32:40.667154	Thursday	630	1945	420	\N	\N	\N	\N
2958	2023-08-03 06:32:40.668671	2023-08-03 06:32:40.668671	Friday	945	1730	420	\N	\N	\N	\N
2959	2023-08-03 06:32:40.67005	2023-08-03 06:32:40.67005	Saturday	800	1030	420	\N	\N	\N	\N
2960	2023-08-03 06:32:40.671286	2023-08-03 06:32:40.671286	Saturday	1230	2030	420	\N	\N	\N	\N
2961	2023-08-03 06:32:40.672581	2023-08-03 06:32:40.672581	Sunday	545	1400	420	\N	\N	\N	\N
2962	2023-08-03 06:32:40.673788	2023-08-03 06:32:40.673788	Sunday	1500	1630	420	\N	\N	\N	\N
2963	2023-08-03 06:32:40.688459	2023-08-03 06:32:40.688459	Tuesday	930	2145	421	\N	\N	\N	\N
2964	2023-08-03 06:32:40.689836	2023-08-03 06:32:40.689836	Wednesday	0	945	421	\N	\N	\N	\N
2965	2023-08-03 06:32:40.691159	2023-08-03 06:32:40.691159	Wednesday	1100	1930	421	\N	\N	\N	\N
2966	2023-08-03 06:32:40.692681	2023-08-03 06:32:40.692681	Thursday	615	1630	421	\N	\N	\N	\N
2967	2023-08-03 06:32:40.693979	2023-08-03 06:32:40.693979	Saturday	945	1100	421	\N	\N	\N	\N
2968	2023-08-03 06:32:40.695248	2023-08-03 06:32:40.695248	Saturday	1615	2245	421	\N	\N	\N	\N
2969	2023-08-03 06:32:40.696562	2023-08-03 06:32:40.696562	Sunday	2145	145	421	\N	\N	\N	\N
2970	2023-08-03 06:32:40.706163	2023-08-03 06:32:40.706163	Monday	1815	245	422	\N	\N	\N	\N
2971	2023-08-03 06:32:40.707606	2023-08-03 06:32:40.707606	Wednesday	230	630	422	\N	\N	\N	\N
2972	2023-08-03 06:32:40.708905	2023-08-03 06:32:40.708905	Wednesday	1930	2245	422	\N	\N	\N	\N
2973	2023-08-03 06:32:40.710241	2023-08-03 06:32:40.710241	Thursday	215	245	422	\N	\N	\N	\N
2974	2023-08-03 06:32:40.711552	2023-08-03 06:32:40.711552	Thursday	1800	1815	422	\N	\N	\N	\N
2975	2023-08-03 06:32:40.71294	2023-08-03 06:32:40.71294	Friday	600	1530	422	\N	\N	\N	\N
2976	2023-08-03 06:32:40.714328	2023-08-03 06:32:40.714328	Sunday	500	1945	422	\N	\N	\N	\N
2977	2023-08-03 06:32:40.715615	2023-08-03 06:32:40.715615	Sunday	2300	2330	422	\N	\N	\N	\N
2978	2023-08-03 06:32:40.73029	2023-08-03 06:32:40.73029	Monday	830	1530	423	\N	\N	\N	\N
2979	2023-08-03 06:32:40.731595	2023-08-03 06:32:40.731595	Monday	2130	2145	423	\N	\N	\N	\N
2980	2023-08-03 06:32:40.732954	2023-08-03 06:32:40.732954	Tuesday	1745	1815	423	\N	\N	\N	\N
2981	2023-08-03 06:32:40.734252	2023-08-03 06:32:40.734252	Tuesday	1900	2100	423	\N	\N	\N	\N
2982	2023-08-03 06:32:40.735516	2023-08-03 06:32:40.735516	Wednesday	1830	145	423	\N	\N	\N	\N
2983	2023-08-03 06:32:40.736859	2023-08-03 06:32:40.736859	Thursday	600	1600	423	\N	\N	\N	\N
2984	2023-08-03 06:32:40.738194	2023-08-03 06:32:40.738194	Saturday	700	1400	423	\N	\N	\N	\N
2985	2023-08-03 06:32:40.739612	2023-08-03 06:32:40.739612	Sunday	715	1815	423	\N	\N	\N	\N
2986	2023-08-03 06:32:40.741172	2023-08-03 06:32:40.741172	Sunday	2145	615	423	\N	\N	\N	\N
2987	2023-08-03 06:32:40.750375	2023-08-03 06:32:40.750375	Monday	0	1230	424	\N	\N	\N	\N
2988	2023-08-03 06:32:40.751664	2023-08-03 06:32:40.751664	Monday	2115	2300	424	\N	\N	\N	\N
2989	2023-08-03 06:32:40.753141	2023-08-03 06:32:40.753141	Wednesday	845	1415	424	\N	\N	\N	\N
2990	2023-08-03 06:32:40.754509	2023-08-03 06:32:40.754509	Thursday	845	1430	424	\N	\N	\N	\N
2991	2023-08-03 06:32:40.755769	2023-08-03 06:32:40.755769	Friday	915	1945	424	\N	\N	\N	\N
2992	2023-08-03 06:32:40.771784	2023-08-03 06:32:40.771784	Monday	945	1515	425	\N	\N	\N	\N
2993	2023-08-03 06:32:40.773104	2023-08-03 06:32:40.773104	Tuesday	1000	1445	425	\N	\N	\N	\N
2994	2023-08-03 06:32:40.77442	2023-08-03 06:32:40.77442	Wednesday	900	1515	425	\N	\N	\N	\N
2995	2023-08-03 06:32:40.775735	2023-08-03 06:32:40.775735	Thursday	700	1515	425	\N	\N	\N	\N
2996	2023-08-03 06:32:40.777004	2023-08-03 06:32:40.777004	Friday	815	2400	425	\N	\N	\N	\N
2997	2023-08-03 06:32:40.77844	2023-08-03 06:32:40.77844	Saturday	745	2000	425	\N	\N	\N	\N
2998	2023-08-03 06:32:40.779705	2023-08-03 06:32:40.779705	Sunday	845	1400	425	\N	\N	\N	\N
2999	2023-08-03 06:32:40.788734	2023-08-03 06:32:40.788734	Monday	745	2045	426	\N	\N	\N	\N
3000	2023-08-03 06:32:40.790276	2023-08-03 06:32:40.790276	Tuesday	1100	1500	426	\N	\N	\N	\N
3001	2023-08-03 06:32:40.791574	2023-08-03 06:32:40.791574	Tuesday	1900	2215	426	\N	\N	\N	\N
3002	2023-08-03 06:32:40.792931	2023-08-03 06:32:40.792931	Wednesday	800	1400	426	\N	\N	\N	\N
3003	2023-08-03 06:32:40.794246	2023-08-03 06:32:40.794246	Friday	915	2400	426	\N	\N	\N	\N
3004	2023-08-03 06:32:40.795485	2023-08-03 06:32:40.795485	Sunday	2015	130	426	\N	\N	\N	\N
3005	2023-08-03 06:32:40.809988	2023-08-03 06:32:40.809988	Monday	715	845	427	\N	\N	\N	\N
3006	2023-08-03 06:32:40.811323	2023-08-03 06:32:40.811323	Monday	1500	2300	427	\N	\N	\N	\N
3007	2023-08-03 06:32:40.812613	2023-08-03 06:32:40.812613	Tuesday	630	1445	427	\N	\N	\N	\N
3008	2023-08-03 06:32:40.814026	2023-08-03 06:32:40.814026	Thursday	715	1730	427	\N	\N	\N	\N
3009	2023-08-03 06:32:40.815356	2023-08-03 06:32:40.815356	Friday	1915	215	427	\N	\N	\N	\N
3010	2023-08-03 06:32:40.816622	2023-08-03 06:32:40.816622	Saturday	2045	130	427	\N	\N	\N	\N
3011	2023-08-03 06:32:40.817872	2023-08-03 06:32:40.817872	Sunday	930	2215	427	\N	\N	\N	\N
3012	2023-08-03 06:32:40.827297	2023-08-03 06:32:40.827297	Monday	1000	1015	428	\N	\N	\N	\N
3013	2023-08-03 06:32:40.828586	2023-08-03 06:32:40.828586	Monday	1215	2215	428	\N	\N	\N	\N
3014	2023-08-03 06:32:40.82986	2023-08-03 06:32:40.82986	Tuesday	930	2230	428	\N	\N	\N	\N
3015	2023-08-03 06:32:40.831095	2023-08-03 06:32:40.831095	Wednesday	300	1645	428	\N	\N	\N	\N
3016	2023-08-03 06:32:40.832303	2023-08-03 06:32:40.832303	Wednesday	1715	2100	428	\N	\N	\N	\N
3017	2023-08-03 06:32:40.83362	2023-08-03 06:32:40.83362	Thursday	830	1915	428	\N	\N	\N	\N
3018	2023-08-03 06:32:40.834951	2023-08-03 06:32:40.834951	Friday	245	1200	428	\N	\N	\N	\N
3019	2023-08-03 06:32:40.836186	2023-08-03 06:32:40.836186	Friday	1845	1900	428	\N	\N	\N	\N
3020	2023-08-03 06:32:40.837686	2023-08-03 06:32:40.837686	Saturday	2015	315	428	\N	\N	\N	\N
3021	2023-08-03 06:32:40.838905	2023-08-03 06:32:40.838905	Sunday	900	2400	428	\N	\N	\N	\N
3022	2023-08-03 06:32:40.853694	2023-08-03 06:32:40.853694	Monday	1615	300	429	\N	\N	\N	\N
3023	2023-08-03 06:32:40.855042	2023-08-03 06:32:40.855042	Tuesday	700	2345	429	\N	\N	\N	\N
3024	2023-08-03 06:32:40.85638	2023-08-03 06:32:40.85638	Friday	15	215	429	\N	\N	\N	\N
3025	2023-08-03 06:32:40.857691	2023-08-03 06:32:40.857691	Friday	745	900	429	\N	\N	\N	\N
3026	2023-08-03 06:32:40.859092	2023-08-03 06:32:40.859092	Saturday	730	1400	429	\N	\N	\N	\N
3027	2023-08-03 06:32:40.868852	2023-08-03 06:32:40.868852	Tuesday	915	1445	430	\N	\N	\N	\N
3028	2023-08-03 06:32:40.870308	2023-08-03 06:32:40.870308	Wednesday	830	2045	430	\N	\N	\N	\N
3029	2023-08-03 06:32:40.871742	2023-08-03 06:32:40.871742	Thursday	415	1630	430	\N	\N	\N	\N
3030	2023-08-03 06:32:40.873037	2023-08-03 06:32:40.873037	Thursday	1730	130	430	\N	\N	\N	\N
3031	2023-08-03 06:32:40.874811	2023-08-03 06:32:40.874811	Friday	100	800	430	\N	\N	\N	\N
3032	2023-08-03 06:32:40.876124	2023-08-03 06:32:40.876124	Friday	1100	1830	430	\N	\N	\N	\N
3033	2023-08-03 06:32:40.877484	2023-08-03 06:32:40.877484	Sunday	645	2400	430	\N	\N	\N	\N
3034	2023-08-03 06:32:40.891767	2023-08-03 06:32:40.891767	Monday	645	1115	431	\N	\N	\N	\N
3035	2023-08-03 06:32:40.893054	2023-08-03 06:32:40.893054	Monday	1730	2000	431	\N	\N	\N	\N
3036	2023-08-03 06:32:40.894297	2023-08-03 06:32:40.894297	Tuesday	700	1800	431	\N	\N	\N	\N
3037	2023-08-03 06:32:40.89562	2023-08-03 06:32:40.89562	Wednesday	2145	100	431	\N	\N	\N	\N
3038	2023-08-03 06:32:40.896918	2023-08-03 06:32:40.896918	Thursday	800	1645	431	\N	\N	\N	\N
3039	2023-08-03 06:32:40.898471	2023-08-03 06:32:40.898471	Friday	645	2400	431	\N	\N	\N	\N
3040	2023-08-03 06:32:40.89986	2023-08-03 06:32:40.89986	Sunday	800	1445	431	\N	\N	\N	\N
3041	2023-08-03 06:32:40.908934	2023-08-03 06:32:40.908934	Monday	1845	245	432	\N	\N	\N	\N
3042	2023-08-03 06:32:40.910504	2023-08-03 06:32:40.910504	Tuesday	1945	215	432	\N	\N	\N	\N
3043	2023-08-03 06:32:40.911771	2023-08-03 06:32:40.911771	Wednesday	1000	1745	432	\N	\N	\N	\N
3044	2023-08-03 06:32:40.913098	2023-08-03 06:32:40.913098	Thursday	800	1530	432	\N	\N	\N	\N
3045	2023-08-03 06:32:40.914338	2023-08-03 06:32:40.914338	Thursday	1915	715	432	\N	\N	\N	\N
3046	2023-08-03 06:32:40.915571	2023-08-03 06:32:40.915571	Friday	900	1430	432	\N	\N	\N	\N
3047	2023-08-03 06:32:40.916836	2023-08-03 06:32:40.916836	Sunday	2030	200	432	\N	\N	\N	\N
3048	2023-08-03 06:32:40.932417	2023-08-03 06:32:40.932417	Monday	845	2215	433	\N	\N	\N	\N
3049	2023-08-03 06:32:40.933762	2023-08-03 06:32:40.933762	Tuesday	1000	2100	433	\N	\N	\N	\N
3050	2023-08-03 06:32:40.93528	2023-08-03 06:32:40.93528	Thursday	345	1030	433	\N	\N	\N	\N
3051	2023-08-03 06:32:40.936549	2023-08-03 06:32:40.936549	Thursday	1530	2000	433	\N	\N	\N	\N
3052	2023-08-03 06:32:40.937818	2023-08-03 06:32:40.937818	Saturday	815	2245	433	\N	\N	\N	\N
3053	2023-08-03 06:32:40.946976	2023-08-03 06:32:40.946976	Monday	845	1645	434	\N	\N	\N	\N
3054	2023-08-03 06:32:40.948395	2023-08-03 06:32:40.948395	Tuesday	230	445	434	\N	\N	\N	\N
3055	2023-08-03 06:32:40.949744	2023-08-03 06:32:40.949744	Tuesday	2230	100	434	\N	\N	\N	\N
3056	2023-08-03 06:32:40.951135	2023-08-03 06:32:40.951135	Wednesday	30	630	434	\N	\N	\N	\N
3057	2023-08-03 06:32:40.952382	2023-08-03 06:32:40.952382	Wednesday	1015	2330	434	\N	\N	\N	\N
3058	2023-08-03 06:32:40.953684	2023-08-03 06:32:40.953684	Friday	1000	1730	434	\N	\N	\N	\N
3059	2023-08-03 06:32:40.954934	2023-08-03 06:32:40.954934	Saturday	1000	1930	434	\N	\N	\N	\N
3060	2023-08-03 06:32:40.956189	2023-08-03 06:32:40.956189	Sunday	600	2400	434	\N	\N	\N	\N
3061	2023-08-03 06:32:40.972075	2023-08-03 06:32:40.972075	Monday	730	1500	435	\N	\N	\N	\N
3062	2023-08-03 06:32:40.97335	2023-08-03 06:32:40.97335	Tuesday	630	2330	435	\N	\N	\N	\N
3063	2023-08-03 06:32:40.974662	2023-08-03 06:32:40.974662	Thursday	745	2345	435	\N	\N	\N	\N
3064	2023-08-03 06:32:40.975975	2023-08-03 06:32:40.975975	Friday	930	2130	435	\N	\N	\N	\N
3065	2023-08-03 06:32:40.977305	2023-08-03 06:32:40.977305	Saturday	915	1230	435	\N	\N	\N	\N
3066	2023-08-03 06:32:40.978559	2023-08-03 06:32:40.978559	Saturday	2015	2330	435	\N	\N	\N	\N
3067	2023-08-03 06:32:40.979864	2023-08-03 06:32:40.979864	Sunday	630	1600	435	\N	\N	\N	\N
3068	2023-08-03 06:32:40.989267	2023-08-03 06:32:40.989267	Monday	1730	115	436	\N	\N	\N	\N
3069	2023-08-03 06:32:40.990586	2023-08-03 06:32:40.990586	Tuesday	1630	100	436	\N	\N	\N	\N
3070	2023-08-03 06:32:40.991871	2023-08-03 06:32:40.991871	Wednesday	600	2215	436	\N	\N	\N	\N
3071	2023-08-03 06:32:40.995413	2023-08-03 06:32:40.995413	Thursday	2245	130	436	\N	\N	\N	\N
3072	2023-08-03 06:32:40.997023	2023-08-03 06:32:40.997023	Friday	730	2045	436	\N	\N	\N	\N
3073	2023-08-03 06:32:41.012011	2023-08-03 06:32:41.012011	Monday	1845	400	437	\N	\N	\N	\N
3074	2023-08-03 06:32:41.013366	2023-08-03 06:32:41.013366	Tuesday	15	600	437	\N	\N	\N	\N
3075	2023-08-03 06:32:41.014682	2023-08-03 06:32:41.014682	Tuesday	1345	1815	437	\N	\N	\N	\N
3076	2023-08-03 06:32:41.015986	2023-08-03 06:32:41.015986	Wednesday	1000	2245	437	\N	\N	\N	\N
3077	2023-08-03 06:32:41.017266	2023-08-03 06:32:41.017266	Friday	915	2400	437	\N	\N	\N	\N
3078	2023-08-03 06:32:41.026629	2023-08-03 06:32:41.026629	Monday	845	2345	438	\N	\N	\N	\N
3079	2023-08-03 06:32:41.027937	2023-08-03 06:32:41.027937	Tuesday	645	2130	438	\N	\N	\N	\N
3080	2023-08-03 06:32:41.029372	2023-08-03 06:32:41.029372	Wednesday	345	1230	438	\N	\N	\N	\N
3081	2023-08-03 06:32:41.030702	2023-08-03 06:32:41.030702	Wednesday	1415	2045	438	\N	\N	\N	\N
3082	2023-08-03 06:32:41.032044	2023-08-03 06:32:41.032044	Friday	615	1145	438	\N	\N	\N	\N
3083	2023-08-03 06:32:41.033295	2023-08-03 06:32:41.033295	Friday	1600	2330	438	\N	\N	\N	\N
3084	2023-08-03 06:32:41.034754	2023-08-03 06:32:41.034754	Sunday	1000	2030	438	\N	\N	\N	\N
3085	2023-08-03 06:32:41.049543	2023-08-03 06:32:41.049543	Monday	845	2345	439	\N	\N	\N	\N
3086	2023-08-03 06:32:41.05088	2023-08-03 06:32:41.05088	Tuesday	630	2215	439	\N	\N	\N	\N
3087	2023-08-03 06:32:41.052163	2023-08-03 06:32:41.052163	Wednesday	830	1815	439	\N	\N	\N	\N
3088	2023-08-03 06:32:41.053515	2023-08-03 06:32:41.053515	Friday	745	1615	439	\N	\N	\N	\N
3089	2023-08-03 06:32:41.054845	2023-08-03 06:32:41.054845	Saturday	800	1800	439	\N	\N	\N	\N
3090	2023-08-03 06:32:41.056136	2023-08-03 06:32:41.056136	Sunday	630	1515	439	\N	\N	\N	\N
3091	2023-08-03 06:32:41.065707	2023-08-03 06:32:41.065707	Tuesday	745	2045	440	\N	\N	\N	\N
3092	2023-08-03 06:32:41.06705	2023-08-03 06:32:41.06705	Wednesday	745	1815	440	\N	\N	\N	\N
3093	2023-08-03 06:32:41.068327	2023-08-03 06:32:41.068327	Thursday	930	2245	440	\N	\N	\N	\N
3094	2023-08-03 06:32:41.069682	2023-08-03 06:32:41.069682	Friday	400	1600	440	\N	\N	\N	\N
3095	2023-08-03 06:32:41.071189	2023-08-03 06:32:41.071189	Friday	1645	2300	440	\N	\N	\N	\N
3096	2023-08-03 06:32:41.072392	2023-08-03 06:32:41.072392	Saturday	845	2100	440	\N	\N	\N	\N
3097	2023-08-03 06:32:41.074617	2023-08-03 06:32:41.074617	Sunday	930	2300	440	\N	\N	\N	\N
\.


--
-- Data for Name: schedules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedules (id, created_at, updated_at, resource_id, service_id, hours_known) FROM stdin;
1	2023-08-03 06:32:29.412463	2023-08-03 06:32:29.412463	1	\N	t
2	2023-08-03 06:32:29.505666	2023-08-03 06:32:29.505666	\N	1	t
3	2023-08-03 06:32:29.572258	2023-08-03 06:32:29.572258	\N	2	t
4	2023-08-03 06:32:29.606642	2023-08-03 06:32:29.606642	2	\N	t
5	2023-08-03 06:32:29.623228	2023-08-03 06:32:29.623228	\N	3	t
6	2023-08-03 06:32:29.654745	2023-08-03 06:32:29.654745	\N	4	t
7	2023-08-03 06:32:29.682018	2023-08-03 06:32:29.682018	3	\N	t
8	2023-08-03 06:32:29.701128	2023-08-03 06:32:29.701128	\N	5	t
9	2023-08-03 06:32:29.724192	2023-08-03 06:32:29.724192	\N	6	t
10	2023-08-03 06:32:29.75354	2023-08-03 06:32:29.75354	4	\N	t
11	2023-08-03 06:32:29.771722	2023-08-03 06:32:29.771722	\N	7	t
12	2023-08-03 06:32:29.808124	2023-08-03 06:32:29.808124	5	\N	t
13	2023-08-03 06:32:29.831293	2023-08-03 06:32:29.831293	\N	8	t
14	2023-08-03 06:32:29.857225	2023-08-03 06:32:29.857225	\N	9	t
15	2023-08-03 06:32:29.885961	2023-08-03 06:32:29.885961	6	\N	t
16	2023-08-03 06:32:29.905912	2023-08-03 06:32:29.905912	\N	10	t
17	2023-08-03 06:32:29.930019	2023-08-03 06:32:29.930019	\N	11	t
18	2023-08-03 06:32:29.961968	2023-08-03 06:32:29.961968	7	\N	t
19	2023-08-03 06:32:29.984464	2023-08-03 06:32:29.984464	\N	12	t
20	2023-08-03 06:32:30.014677	2023-08-03 06:32:30.014677	\N	13	t
21	2023-08-03 06:32:30.038652	2023-08-03 06:32:30.038652	8	\N	t
22	2023-08-03 06:32:30.052335	2023-08-03 06:32:30.052335	\N	14	t
23	2023-08-03 06:32:30.077271	2023-08-03 06:32:30.077271	\N	15	t
24	2023-08-03 06:32:30.106892	2023-08-03 06:32:30.106892	9	\N	t
25	2023-08-03 06:32:30.121364	2023-08-03 06:32:30.121364	\N	16	t
26	2023-08-03 06:32:30.146838	2023-08-03 06:32:30.146838	10	\N	t
27	2023-08-03 06:32:30.167138	2023-08-03 06:32:30.167138	\N	17	t
28	2023-08-03 06:32:30.19752	2023-08-03 06:32:30.19752	11	\N	t
29	2023-08-03 06:32:30.221363	2023-08-03 06:32:30.221363	\N	18	t
30	2023-08-03 06:32:30.246757	2023-08-03 06:32:30.246757	\N	19	t
31	2023-08-03 06:32:30.273084	2023-08-03 06:32:30.273084	12	\N	t
32	2023-08-03 06:32:30.285577	2023-08-03 06:32:30.285577	\N	20	t
33	2023-08-03 06:32:30.309737	2023-08-03 06:32:30.309737	\N	21	t
34	2023-08-03 06:32:30.334934	2023-08-03 06:32:30.334934	13	\N	t
35	2023-08-03 06:32:30.351677	2023-08-03 06:32:30.351677	\N	22	t
36	2023-08-03 06:32:30.377805	2023-08-03 06:32:30.377805	\N	23	t
37	2023-08-03 06:32:30.405727	2023-08-03 06:32:30.405727	14	\N	t
38	2023-08-03 06:32:30.425723	2023-08-03 06:32:30.425723	\N	24	t
39	2023-08-03 06:32:30.45241	2023-08-03 06:32:30.45241	15	\N	t
40	2023-08-03 06:32:30.467486	2023-08-03 06:32:30.467486	\N	25	t
41	2023-08-03 06:32:30.496516	2023-08-03 06:32:30.496516	16	\N	t
42	2023-08-03 06:32:30.514048	2023-08-03 06:32:30.514048	\N	26	t
43	2023-08-03 06:32:30.537892	2023-08-03 06:32:30.537892	17	\N	t
44	2023-08-03 06:32:30.55585	2023-08-03 06:32:30.55585	\N	27	t
45	2023-08-03 06:32:30.577054	2023-08-03 06:32:30.577054	\N	28	t
46	2023-08-03 06:32:30.610335	2023-08-03 06:32:30.610335	18	\N	t
47	2023-08-03 06:32:30.637556	2023-08-03 06:32:30.637556	\N	29	t
48	2023-08-03 06:32:30.665545	2023-08-03 06:32:30.665545	\N	30	t
49	2023-08-03 06:32:30.691174	2023-08-03 06:32:30.691174	19	\N	t
50	2023-08-03 06:32:30.7099	2023-08-03 06:32:30.7099	\N	31	t
51	2023-08-03 06:32:30.735964	2023-08-03 06:32:30.735964	20	\N	t
52	2023-08-03 06:32:30.751301	2023-08-03 06:32:30.751301	\N	32	t
53	2023-08-03 06:32:30.779424	2023-08-03 06:32:30.779424	\N	33	t
54	2023-08-03 06:32:30.803974	2023-08-03 06:32:30.803974	21	\N	t
55	2023-08-03 06:32:30.817501	2023-08-03 06:32:30.817501	\N	34	t
56	2023-08-03 06:32:30.844967	2023-08-03 06:32:30.844967	22	\N	t
57	2023-08-03 06:32:30.864683	2023-08-03 06:32:30.864683	\N	35	t
58	2023-08-03 06:32:30.88686	2023-08-03 06:32:30.88686	\N	36	t
59	2023-08-03 06:32:30.912957	2023-08-03 06:32:30.912957	23	\N	t
60	2023-08-03 06:32:30.927696	2023-08-03 06:32:30.927696	\N	37	t
61	2023-08-03 06:32:30.953521	2023-08-03 06:32:30.953521	\N	38	t
62	2023-08-03 06:32:30.985803	2023-08-03 06:32:30.985803	24	\N	t
63	2023-08-03 06:32:31.005044	2023-08-03 06:32:31.005044	\N	39	t
64	2023-08-03 06:32:31.026969	2023-08-03 06:32:31.026969	\N	40	t
65	2023-08-03 06:32:31.059208	2023-08-03 06:32:31.059208	25	\N	t
66	2023-08-03 06:32:31.076471	2023-08-03 06:32:31.076471	\N	41	t
67	2023-08-03 06:32:31.111466	2023-08-03 06:32:31.111466	26	\N	t
68	2023-08-03 06:32:31.132287	2023-08-03 06:32:31.132287	\N	42	t
69	2023-08-03 06:32:31.1624	2023-08-03 06:32:31.1624	27	\N	t
70	2023-08-03 06:32:31.183338	2023-08-03 06:32:31.183338	\N	43	t
71	2023-08-03 06:32:31.215285	2023-08-03 06:32:31.215285	28	\N	t
72	2023-08-03 06:32:31.2348	2023-08-03 06:32:31.2348	\N	44	t
73	2023-08-03 06:32:31.262318	2023-08-03 06:32:31.262318	29	\N	t
74	2023-08-03 06:32:31.282714	2023-08-03 06:32:31.282714	\N	45	t
75	2023-08-03 06:32:31.309002	2023-08-03 06:32:31.309002	30	\N	t
76	2023-08-03 06:32:31.322349	2023-08-03 06:32:31.322349	\N	46	t
77	2023-08-03 06:32:31.353467	2023-08-03 06:32:31.353467	31	\N	t
78	2023-08-03 06:32:31.371199	2023-08-03 06:32:31.371199	\N	47	t
79	2023-08-03 06:32:31.394737	2023-08-03 06:32:31.394737	\N	48	t
80	2023-08-03 06:32:31.425569	2023-08-03 06:32:31.425569	32	\N	t
81	2023-08-03 06:32:31.445646	2023-08-03 06:32:31.445646	\N	49	t
82	2023-08-03 06:32:31.471859	2023-08-03 06:32:31.471859	33	\N	t
83	2023-08-03 06:32:31.491541	2023-08-03 06:32:31.491541	\N	50	t
84	2023-08-03 06:32:31.518642	2023-08-03 06:32:31.518642	34	\N	t
85	2023-08-03 06:32:31.539877	2023-08-03 06:32:31.539877	\N	51	t
86	2023-08-03 06:32:31.562073	2023-08-03 06:32:31.562073	\N	52	t
87	2023-08-03 06:32:31.588434	2023-08-03 06:32:31.588434	35	\N	t
88	2023-08-03 06:32:31.61001	2023-08-03 06:32:31.61001	\N	53	t
89	2023-08-03 06:32:31.639213	2023-08-03 06:32:31.639213	36	\N	t
90	2023-08-03 06:32:31.660187	2023-08-03 06:32:31.660187	\N	54	t
91	2023-08-03 06:32:31.690431	2023-08-03 06:32:31.690431	37	\N	t
92	2023-08-03 06:32:31.706364	2023-08-03 06:32:31.706364	\N	55	t
93	2023-08-03 06:32:31.73469	2023-08-03 06:32:31.73469	38	\N	t
94	2023-08-03 06:32:31.756311	2023-08-03 06:32:31.756311	\N	56	t
95	2023-08-03 06:32:31.786287	2023-08-03 06:32:31.786287	39	\N	t
96	2023-08-03 06:32:31.808039	2023-08-03 06:32:31.808039	\N	57	t
97	2023-08-03 06:32:31.836331	2023-08-03 06:32:31.836331	40	\N	t
98	2023-08-03 06:32:31.858592	2023-08-03 06:32:31.858592	\N	58	t
99	2023-08-03 06:32:31.887711	2023-08-03 06:32:31.887711	41	\N	t
100	2023-08-03 06:32:31.90228	2023-08-03 06:32:31.90228	\N	59	t
101	2023-08-03 06:32:31.935755	2023-08-03 06:32:31.935755	42	\N	t
102	2023-08-03 06:32:31.953594	2023-08-03 06:32:31.953594	\N	60	t
103	2023-08-03 06:32:31.979329	2023-08-03 06:32:31.979329	\N	61	t
104	2023-08-03 06:32:32.009165	2023-08-03 06:32:32.009165	43	\N	t
105	2023-08-03 06:32:32.022738	2023-08-03 06:32:32.022738	\N	62	t
106	2023-08-03 06:32:32.051169	2023-08-03 06:32:32.051169	44	\N	t
107	2023-08-03 06:32:32.071674	2023-08-03 06:32:32.071674	\N	63	t
108	2023-08-03 06:32:32.101745	2023-08-03 06:32:32.101745	45	\N	t
109	2023-08-03 06:32:32.118338	2023-08-03 06:32:32.118338	\N	64	t
110	2023-08-03 06:32:32.145275	2023-08-03 06:32:32.145275	\N	65	t
111	2023-08-03 06:32:32.168083	2023-08-03 06:32:32.168083	46	\N	t
112	2023-08-03 06:32:32.186634	2023-08-03 06:32:32.186634	\N	66	t
113	2023-08-03 06:32:32.214776	2023-08-03 06:32:32.214776	47	\N	t
114	2023-08-03 06:32:32.233786	2023-08-03 06:32:32.233786	\N	67	t
115	2023-08-03 06:32:32.256282	2023-08-03 06:32:32.256282	\N	68	t
116	2023-08-03 06:32:32.287519	2023-08-03 06:32:32.287519	48	\N	t
117	2023-08-03 06:32:32.3057	2023-08-03 06:32:32.3057	\N	69	t
118	2023-08-03 06:32:32.332873	2023-08-03 06:32:32.332873	49	\N	t
119	2023-08-03 06:32:32.352986	2023-08-03 06:32:32.352986	\N	70	t
120	2023-08-03 06:32:32.382008	2023-08-03 06:32:32.382008	50	\N	t
121	2023-08-03 06:32:32.405606	2023-08-03 06:32:32.405606	\N	71	t
122	2023-08-03 06:32:32.432916	2023-08-03 06:32:32.432916	51	\N	t
123	2023-08-03 06:32:32.455549	2023-08-03 06:32:32.455549	\N	72	t
124	2023-08-03 06:32:32.483271	2023-08-03 06:32:32.483271	\N	73	t
125	2023-08-03 06:32:32.510381	2023-08-03 06:32:32.510381	52	\N	t
126	2023-08-03 06:32:32.529272	2023-08-03 06:32:32.529272	\N	74	t
127	2023-08-03 06:32:32.553343	2023-08-03 06:32:32.553343	\N	75	t
128	2023-08-03 06:32:32.582671	2023-08-03 06:32:32.582671	53	\N	t
129	2023-08-03 06:32:32.600228	2023-08-03 06:32:32.600228	\N	76	t
130	2023-08-03 06:32:32.62421	2023-08-03 06:32:32.62421	\N	77	t
131	2023-08-03 06:32:32.652446	2023-08-03 06:32:32.652446	54	\N	t
132	2023-08-03 06:32:32.672426	2023-08-03 06:32:32.672426	\N	78	t
133	2023-08-03 06:32:32.698413	2023-08-03 06:32:32.698413	55	\N	t
134	2023-08-03 06:32:32.719618	2023-08-03 06:32:32.719618	\N	79	t
135	2023-08-03 06:32:32.74572	2023-08-03 06:32:32.74572	\N	80	t
136	2023-08-03 06:32:32.774738	2023-08-03 06:32:32.774738	56	\N	t
137	2023-08-03 06:32:32.797863	2023-08-03 06:32:32.797863	\N	81	t
138	2023-08-03 06:32:32.823654	2023-08-03 06:32:32.823654	\N	82	t
139	2023-08-03 06:32:32.853429	2023-08-03 06:32:32.853429	57	\N	t
140	2023-08-03 06:32:32.87764	2023-08-03 06:32:32.87764	\N	83	t
141	2023-08-03 06:32:32.904658	2023-08-03 06:32:32.904658	58	\N	t
142	2023-08-03 06:32:32.922936	2023-08-03 06:32:32.922936	\N	84	t
143	2023-08-03 06:32:32.946439	2023-08-03 06:32:32.946439	\N	85	t
144	2023-08-03 06:32:32.975325	2023-08-03 06:32:32.975325	59	\N	t
145	2023-08-03 06:32:32.988273	2023-08-03 06:32:32.988273	\N	86	t
146	2023-08-03 06:32:33.012887	2023-08-03 06:32:33.012887	\N	87	t
147	2023-08-03 06:32:33.039445	2023-08-03 06:32:33.039445	60	\N	t
148	2023-08-03 06:32:33.055808	2023-08-03 06:32:33.055808	\N	88	t
149	2023-08-03 06:32:33.077124	2023-08-03 06:32:33.077124	\N	89	t
150	2023-08-03 06:32:33.107909	2023-08-03 06:32:33.107909	61	\N	t
151	2023-08-03 06:32:33.130674	2023-08-03 06:32:33.130674	\N	90	t
152	2023-08-03 06:32:33.159178	2023-08-03 06:32:33.159178	\N	91	t
153	2023-08-03 06:32:33.193646	2023-08-03 06:32:33.193646	62	\N	t
154	2023-08-03 06:32:33.217206	2023-08-03 06:32:33.217206	\N	92	t
155	2023-08-03 06:32:33.241038	2023-08-03 06:32:33.241038	\N	93	t
156	2023-08-03 06:32:33.275383	2023-08-03 06:32:33.275383	63	\N	t
157	2023-08-03 06:32:33.291503	2023-08-03 06:32:33.291503	\N	94	t
158	2023-08-03 06:32:33.321186	2023-08-03 06:32:33.321186	64	\N	t
159	2023-08-03 06:32:33.33993	2023-08-03 06:32:33.33993	\N	95	t
160	2023-08-03 06:32:33.36796	2023-08-03 06:32:33.36796	\N	96	t
161	2023-08-03 06:32:33.391612	2023-08-03 06:32:33.391612	65	\N	t
162	2023-08-03 06:32:33.413846	2023-08-03 06:32:33.413846	\N	97	t
163	2023-08-03 06:32:33.436265	2023-08-03 06:32:33.436265	\N	98	t
164	2023-08-03 06:32:33.467593	2023-08-03 06:32:33.467593	66	\N	t
165	2023-08-03 06:32:33.49267	2023-08-03 06:32:33.49267	\N	99	t
166	2023-08-03 06:32:33.523957	2023-08-03 06:32:33.523957	67	\N	t
167	2023-08-03 06:32:33.547452	2023-08-03 06:32:33.547452	\N	100	t
168	2023-08-03 06:32:33.57574	2023-08-03 06:32:33.57574	68	\N	t
169	2023-08-03 06:32:33.598065	2023-08-03 06:32:33.598065	\N	101	t
170	2023-08-03 06:32:33.622286	2023-08-03 06:32:33.622286	\N	102	t
171	2023-08-03 06:32:33.652833	2023-08-03 06:32:33.652833	69	\N	t
172	2023-08-03 06:32:33.671597	2023-08-03 06:32:33.671597	\N	103	t
173	2023-08-03 06:32:33.706611	2023-08-03 06:32:33.706611	70	\N	t
174	2023-08-03 06:32:33.730728	2023-08-03 06:32:33.730728	\N	104	t
175	2023-08-03 06:32:33.759003	2023-08-03 06:32:33.759003	\N	105	t
176	2023-08-03 06:32:33.783085	2023-08-03 06:32:33.783085	71	\N	t
177	2023-08-03 06:32:33.807639	2023-08-03 06:32:33.807639	\N	106	t
178	2023-08-03 06:32:33.832618	2023-08-03 06:32:33.832618	\N	107	t
179	2023-08-03 06:32:33.859769	2023-08-03 06:32:33.859769	72	\N	t
180	2023-08-03 06:32:33.881928	2023-08-03 06:32:33.881928	\N	108	t
181	2023-08-03 06:32:33.910086	2023-08-03 06:32:33.910086	73	\N	t
182	2023-08-03 06:32:33.929831	2023-08-03 06:32:33.929831	\N	109	t
183	2023-08-03 06:32:33.954936	2023-08-03 06:32:33.954936	\N	110	t
184	2023-08-03 06:32:33.990374	2023-08-03 06:32:33.990374	74	\N	t
185	2023-08-03 06:32:34.011566	2023-08-03 06:32:34.011566	\N	111	t
186	2023-08-03 06:32:34.036602	2023-08-03 06:32:34.036602	\N	112	t
187	2023-08-03 06:32:34.067894	2023-08-03 06:32:34.067894	75	\N	t
188	2023-08-03 06:32:34.086716	2023-08-03 06:32:34.086716	\N	113	t
189	2023-08-03 06:32:34.112635	2023-08-03 06:32:34.112635	\N	114	t
190	2023-08-03 06:32:34.143956	2023-08-03 06:32:34.143956	76	\N	t
191	2023-08-03 06:32:34.167259	2023-08-03 06:32:34.167259	\N	115	t
192	2023-08-03 06:32:34.19674	2023-08-03 06:32:34.19674	77	\N	t
193	2023-08-03 06:32:34.219115	2023-08-03 06:32:34.219115	\N	116	t
194	2023-08-03 06:32:34.25068	2023-08-03 06:32:34.25068	78	\N	t
195	2023-08-03 06:32:34.271944	2023-08-03 06:32:34.271944	\N	117	t
196	2023-08-03 06:32:34.301885	2023-08-03 06:32:34.301885	\N	118	t
197	2023-08-03 06:32:34.32863	2023-08-03 06:32:34.32863	79	\N	t
198	2023-08-03 06:32:34.350448	2023-08-03 06:32:34.350448	\N	119	t
199	2023-08-03 06:32:34.376503	2023-08-03 06:32:34.376503	\N	120	t
200	2023-08-03 06:32:34.407007	2023-08-03 06:32:34.407007	80	\N	t
201	2023-08-03 06:32:34.426728	2023-08-03 06:32:34.426728	\N	121	t
202	2023-08-03 06:32:34.449821	2023-08-03 06:32:34.449821	\N	122	t
203	2023-08-03 06:32:34.478077	2023-08-03 06:32:34.478077	81	\N	t
204	2023-08-03 06:32:34.497466	2023-08-03 06:32:34.497466	\N	123	t
205	2023-08-03 06:32:34.529572	2023-08-03 06:32:34.529572	82	\N	t
206	2023-08-03 06:32:34.547918	2023-08-03 06:32:34.547918	\N	124	t
207	2023-08-03 06:32:34.577018	2023-08-03 06:32:34.577018	\N	125	t
208	2023-08-03 06:32:34.607978	2023-08-03 06:32:34.607978	83	\N	t
209	2023-08-03 06:32:34.625877	2023-08-03 06:32:34.625877	\N	126	t
210	2023-08-03 06:32:34.659757	2023-08-03 06:32:34.659757	84	\N	t
211	2023-08-03 06:32:34.682178	2023-08-03 06:32:34.682178	\N	127	t
212	2023-08-03 06:32:34.715109	2023-08-03 06:32:34.715109	85	\N	t
213	2023-08-03 06:32:34.738722	2023-08-03 06:32:34.738722	\N	128	t
214	2023-08-03 06:32:34.774052	2023-08-03 06:32:34.774052	86	\N	t
215	2023-08-03 06:32:34.791668	2023-08-03 06:32:34.791668	\N	129	t
216	2023-08-03 06:32:34.820521	2023-08-03 06:32:34.820521	\N	130	t
217	2023-08-03 06:32:34.848661	2023-08-03 06:32:34.848661	87	\N	t
218	2023-08-03 06:32:34.874716	2023-08-03 06:32:34.874716	\N	131	t
219	2023-08-03 06:32:34.920846	2023-08-03 06:32:34.920846	88	\N	t
220	2023-08-03 06:32:34.980732	2023-08-03 06:32:34.980732	\N	132	t
221	2023-08-03 06:32:35.021716	2023-08-03 06:32:35.021716	\N	133	t
222	2023-08-03 06:32:35.05724	2023-08-03 06:32:35.05724	89	\N	t
223	2023-08-03 06:32:35.079569	2023-08-03 06:32:35.079569	\N	134	t
224	2023-08-03 06:32:35.107221	2023-08-03 06:32:35.107221	90	\N	t
225	2023-08-03 06:32:35.126748	2023-08-03 06:32:35.126748	\N	135	t
226	2023-08-03 06:32:35.148584	2023-08-03 06:32:35.148584	\N	136	t
227	2023-08-03 06:32:35.18227	2023-08-03 06:32:35.18227	91	\N	t
228	2023-08-03 06:32:35.219223	2023-08-03 06:32:35.219223	\N	137	t
229	2023-08-03 06:32:35.249882	2023-08-03 06:32:35.249882	\N	138	t
230	2023-08-03 06:32:35.27845	2023-08-03 06:32:35.27845	92	\N	t
231	2023-08-03 06:32:35.302302	2023-08-03 06:32:35.302302	\N	139	t
232	2023-08-03 06:32:35.350141	2023-08-03 06:32:35.350141	93	\N	t
233	2023-08-03 06:32:35.39051	2023-08-03 06:32:35.39051	\N	140	t
234	2023-08-03 06:32:35.428823	2023-08-03 06:32:35.428823	94	\N	t
235	2023-08-03 06:32:35.461002	2023-08-03 06:32:35.461002	\N	141	t
236	2023-08-03 06:32:35.493663	2023-08-03 06:32:35.493663	\N	142	t
237	2023-08-03 06:32:35.530212	2023-08-03 06:32:35.530212	95	\N	t
238	2023-08-03 06:32:35.550502	2023-08-03 06:32:35.550502	\N	143	t
239	2023-08-03 06:32:35.582136	2023-08-03 06:32:35.582136	96	\N	t
240	2023-08-03 06:32:35.600351	2023-08-03 06:32:35.600351	\N	144	t
241	2023-08-03 06:32:35.633714	2023-08-03 06:32:35.633714	97	\N	t
242	2023-08-03 06:32:35.657236	2023-08-03 06:32:35.657236	\N	145	t
243	2023-08-03 06:32:35.686158	2023-08-03 06:32:35.686158	\N	146	t
244	2023-08-03 06:32:35.718532	2023-08-03 06:32:35.718532	98	\N	t
245	2023-08-03 06:32:35.736806	2023-08-03 06:32:35.736806	\N	147	t
246	2023-08-03 06:32:35.767145	2023-08-03 06:32:35.767145	99	\N	t
247	2023-08-03 06:32:35.785539	2023-08-03 06:32:35.785539	\N	148	t
248	2023-08-03 06:32:35.80678	2023-08-03 06:32:35.80678	\N	149	t
249	2023-08-03 06:32:35.837899	2023-08-03 06:32:35.837899	100	\N	t
250	2023-08-03 06:32:35.864377	2023-08-03 06:32:35.864377	\N	150	t
251	2023-08-03 06:32:35.891809	2023-08-03 06:32:35.891809	101	\N	t
252	2023-08-03 06:32:35.910977	2023-08-03 06:32:35.910977	\N	151	t
253	2023-08-03 06:32:35.934941	2023-08-03 06:32:35.934941	102	\N	t
254	2023-08-03 06:32:35.955538	2023-08-03 06:32:35.955538	\N	152	t
255	2023-08-03 06:32:35.980376	2023-08-03 06:32:35.980376	\N	153	t
256	2023-08-03 06:32:36.007126	2023-08-03 06:32:36.007126	103	\N	t
257	2023-08-03 06:32:36.026939	2023-08-03 06:32:36.026939	\N	154	t
258	2023-08-03 06:32:36.057769	2023-08-03 06:32:36.057769	104	\N	t
259	2023-08-03 06:32:36.075593	2023-08-03 06:32:36.075593	\N	155	t
260	2023-08-03 06:32:36.105312	2023-08-03 06:32:36.105312	105	\N	t
261	2023-08-03 06:32:36.141251	2023-08-03 06:32:36.141251	\N	156	t
262	2023-08-03 06:32:36.178338	2023-08-03 06:32:36.178338	106	\N	t
263	2023-08-03 06:32:36.199526	2023-08-03 06:32:36.199526	\N	157	t
264	2023-08-03 06:32:36.221482	2023-08-03 06:32:36.221482	107	\N	t
265	2023-08-03 06:32:36.242405	2023-08-03 06:32:36.242405	\N	158	t
266	2023-08-03 06:32:36.272559	2023-08-03 06:32:36.272559	108	\N	t
267	2023-08-03 06:32:36.290633	2023-08-03 06:32:36.290633	\N	159	t
268	2023-08-03 06:32:36.320062	2023-08-03 06:32:36.320062	109	\N	t
269	2023-08-03 06:32:36.342654	2023-08-03 06:32:36.342654	\N	160	t
270	2023-08-03 06:32:36.368483	2023-08-03 06:32:36.368483	110	\N	t
271	2023-08-03 06:32:36.388114	2023-08-03 06:32:36.388114	\N	161	t
272	2023-08-03 06:32:36.408244	2023-08-03 06:32:36.408244	\N	162	t
273	2023-08-03 06:32:36.435197	2023-08-03 06:32:36.435197	111	\N	t
274	2023-08-03 06:32:36.456995	2023-08-03 06:32:36.456995	\N	163	t
275	2023-08-03 06:32:36.483027	2023-08-03 06:32:36.483027	112	\N	t
276	2023-08-03 06:32:36.506071	2023-08-03 06:32:36.506071	\N	164	t
277	2023-08-03 06:32:36.565112	2023-08-03 06:32:36.565112	\N	165	t
278	2023-08-03 06:32:36.600132	2023-08-03 06:32:36.600132	113	\N	t
279	2023-08-03 06:32:36.626426	2023-08-03 06:32:36.626426	\N	166	t
280	2023-08-03 06:32:36.657724	2023-08-03 06:32:36.657724	114	\N	t
281	2023-08-03 06:32:36.677926	2023-08-03 06:32:36.677926	\N	167	t
282	2023-08-03 06:32:36.707934	2023-08-03 06:32:36.707934	115	\N	t
283	2023-08-03 06:32:36.723265	2023-08-03 06:32:36.723265	\N	168	t
284	2023-08-03 06:32:36.771595	2023-08-03 06:32:36.771595	116	\N	t
285	2023-08-03 06:32:36.792967	2023-08-03 06:32:36.792967	\N	169	t
286	2023-08-03 06:32:36.829942	2023-08-03 06:32:36.829942	117	\N	t
287	2023-08-03 06:32:36.846042	2023-08-03 06:32:36.846042	\N	170	t
288	2023-08-03 06:32:36.883139	2023-08-03 06:32:36.883139	118	\N	t
289	2023-08-03 06:32:36.904602	2023-08-03 06:32:36.904602	\N	171	t
290	2023-08-03 06:32:36.939667	2023-08-03 06:32:36.939667	119	\N	t
291	2023-08-03 06:32:36.960457	2023-08-03 06:32:36.960457	\N	172	t
292	2023-08-03 06:32:36.997641	2023-08-03 06:32:36.997641	120	\N	t
293	2023-08-03 06:32:37.021534	2023-08-03 06:32:37.021534	\N	173	t
294	2023-08-03 06:32:37.055845	2023-08-03 06:32:37.055845	121	\N	t
295	2023-08-03 06:32:37.078975	2023-08-03 06:32:37.078975	\N	174	t
296	2023-08-03 06:32:37.11814	2023-08-03 06:32:37.11814	\N	175	t
297	2023-08-03 06:32:37.150758	2023-08-03 06:32:37.150758	122	\N	t
298	2023-08-03 06:32:37.174356	2023-08-03 06:32:37.174356	\N	176	t
299	2023-08-03 06:32:37.205686	2023-08-03 06:32:37.205686	\N	177	t
300	2023-08-03 06:32:37.245943	2023-08-03 06:32:37.245943	123	\N	t
301	2023-08-03 06:32:37.264195	2023-08-03 06:32:37.264195	\N	178	t
302	2023-08-03 06:32:37.29383	2023-08-03 06:32:37.29383	\N	179	t
303	2023-08-03 06:32:37.324431	2023-08-03 06:32:37.324431	124	\N	t
304	2023-08-03 06:32:37.343012	2023-08-03 06:32:37.343012	\N	180	t
305	2023-08-03 06:32:37.370566	2023-08-03 06:32:37.370566	\N	181	t
306	2023-08-03 06:32:37.398387	2023-08-03 06:32:37.398387	125	\N	t
307	2023-08-03 06:32:37.417997	2023-08-03 06:32:37.417997	\N	182	t
308	2023-08-03 06:32:37.446932	2023-08-03 06:32:37.446932	126	\N	t
309	2023-08-03 06:32:37.469656	2023-08-03 06:32:37.469656	\N	183	t
310	2023-08-03 06:32:37.498337	2023-08-03 06:32:37.498337	127	\N	t
311	2023-08-03 06:32:37.518766	2023-08-03 06:32:37.518766	\N	184	t
312	2023-08-03 06:32:37.54564	2023-08-03 06:32:37.54564	128	\N	t
313	2023-08-03 06:32:37.564046	2023-08-03 06:32:37.564046	\N	185	t
314	2023-08-03 06:32:37.595962	2023-08-03 06:32:37.595962	129	\N	t
315	2023-08-03 06:32:37.61988	2023-08-03 06:32:37.61988	\N	186	t
316	2023-08-03 06:32:37.642396	2023-08-03 06:32:37.642396	\N	187	t
317	2023-08-03 06:32:37.675224	2023-08-03 06:32:37.675224	130	\N	t
318	2023-08-03 06:32:37.695715	2023-08-03 06:32:37.695715	\N	188	t
319	2023-08-03 06:32:37.722288	2023-08-03 06:32:37.722288	131	\N	t
320	2023-08-03 06:32:37.73976	2023-08-03 06:32:37.73976	\N	189	t
321	2023-08-03 06:32:37.766368	2023-08-03 06:32:37.766368	132	\N	t
322	2023-08-03 06:32:37.785985	2023-08-03 06:32:37.785985	\N	190	t
323	2023-08-03 06:32:37.817812	2023-08-03 06:32:37.817812	133	\N	t
324	2023-08-03 06:32:37.835034	2023-08-03 06:32:37.835034	\N	191	t
325	2023-08-03 06:32:37.858365	2023-08-03 06:32:37.858365	\N	192	t
326	2023-08-03 06:32:37.885296	2023-08-03 06:32:37.885296	134	\N	t
327	2023-08-03 06:32:37.902436	2023-08-03 06:32:37.902436	\N	193	t
328	2023-08-03 06:32:37.922953	2023-08-03 06:32:37.922953	\N	194	t
329	2023-08-03 06:32:37.952593	2023-08-03 06:32:37.952593	135	\N	t
330	2023-08-03 06:32:37.973226	2023-08-03 06:32:37.973226	\N	195	t
331	2023-08-03 06:32:38.003194	2023-08-03 06:32:38.003194	136	\N	t
332	2023-08-03 06:32:38.022181	2023-08-03 06:32:38.022181	\N	196	t
333	2023-08-03 06:32:38.05948	2023-08-03 06:32:38.05948	137	\N	t
334	2023-08-03 06:32:38.086555	2023-08-03 06:32:38.086555	\N	197	t
335	2023-08-03 06:32:38.137762	2023-08-03 06:32:38.137762	\N	198	t
336	2023-08-03 06:32:38.172675	2023-08-03 06:32:38.172675	138	\N	t
337	2023-08-03 06:32:38.192584	2023-08-03 06:32:38.192584	\N	199	t
338	2023-08-03 06:32:38.218518	2023-08-03 06:32:38.218518	\N	200	t
339	2023-08-03 06:32:38.249925	2023-08-03 06:32:38.249925	139	\N	t
340	2023-08-03 06:32:38.269406	2023-08-03 06:32:38.269406	\N	201	t
341	2023-08-03 06:32:38.299313	2023-08-03 06:32:38.299313	\N	202	t
342	2023-08-03 06:32:38.332204	2023-08-03 06:32:38.332204	140	\N	t
343	2023-08-03 06:32:38.354113	2023-08-03 06:32:38.354113	\N	203	t
344	2023-08-03 06:32:38.383298	2023-08-03 06:32:38.383298	141	\N	t
345	2023-08-03 06:32:38.402396	2023-08-03 06:32:38.402396	\N	204	t
346	2023-08-03 06:32:38.430718	2023-08-03 06:32:38.430718	142	\N	t
347	2023-08-03 06:32:38.454791	2023-08-03 06:32:38.454791	\N	205	t
348	2023-08-03 06:32:38.477615	2023-08-03 06:32:38.477615	\N	206	t
349	2023-08-03 06:32:38.509162	2023-08-03 06:32:38.509162	143	\N	t
350	2023-08-03 06:32:38.530136	2023-08-03 06:32:38.530136	\N	207	t
351	2023-08-03 06:32:38.558805	2023-08-03 06:32:38.558805	144	\N	t
352	2023-08-03 06:32:38.576457	2023-08-03 06:32:38.576457	\N	208	t
353	2023-08-03 06:32:38.61037	2023-08-03 06:32:38.61037	145	\N	t
354	2023-08-03 06:32:38.62823	2023-08-03 06:32:38.62823	\N	209	t
355	2023-08-03 06:32:38.661728	2023-08-03 06:32:38.661728	146	\N	t
356	2023-08-03 06:32:38.680107	2023-08-03 06:32:38.680107	\N	210	t
357	2023-08-03 06:32:38.707259	2023-08-03 06:32:38.707259	\N	211	t
358	2023-08-03 06:32:38.736013	2023-08-03 06:32:38.736013	147	\N	t
359	2023-08-03 06:32:38.752549	2023-08-03 06:32:38.752549	\N	212	t
360	2023-08-03 06:32:38.775943	2023-08-03 06:32:38.775943	\N	213	t
361	2023-08-03 06:32:38.80462	2023-08-03 06:32:38.80462	148	\N	t
362	2023-08-03 06:32:38.823523	2023-08-03 06:32:38.823523	\N	214	t
363	2023-08-03 06:32:38.856128	2023-08-03 06:32:38.856128	149	\N	t
364	2023-08-03 06:32:38.873764	2023-08-03 06:32:38.873764	\N	215	t
365	2023-08-03 06:32:39.496613	2023-08-03 06:32:39.496613	150	\N	t
366	2023-08-03 06:32:39.515251	2023-08-03 06:32:39.515251	\N	216	t
367	2023-08-03 06:32:39.536098	2023-08-03 06:32:39.536098	151	\N	t
368	2023-08-03 06:32:39.549663	2023-08-03 06:32:39.549663	\N	217	t
369	2023-08-03 06:32:39.571293	2023-08-03 06:32:39.571293	152	\N	t
370	2023-08-03 06:32:39.590276	2023-08-03 06:32:39.590276	\N	218	t
371	2023-08-03 06:32:39.607484	2023-08-03 06:32:39.607484	153	\N	t
372	2023-08-03 06:32:39.625917	2023-08-03 06:32:39.625917	\N	219	t
373	2023-08-03 06:32:39.644119	2023-08-03 06:32:39.644119	154	\N	t
374	2023-08-03 06:32:39.671083	2023-08-03 06:32:39.671083	\N	220	t
375	2023-08-03 06:32:39.713242	2023-08-03 06:32:39.713242	155	\N	t
376	2023-08-03 06:32:39.734439	2023-08-03 06:32:39.734439	\N	221	t
377	2023-08-03 06:32:39.755474	2023-08-03 06:32:39.755474	156	\N	t
378	2023-08-03 06:32:39.77214	2023-08-03 06:32:39.77214	\N	222	t
379	2023-08-03 06:32:39.796874	2023-08-03 06:32:39.796874	157	\N	t
380	2023-08-03 06:32:39.813126	2023-08-03 06:32:39.813126	\N	223	t
381	2023-08-03 06:32:39.830947	2023-08-03 06:32:39.830947	158	\N	t
382	2023-08-03 06:32:39.854744	2023-08-03 06:32:39.854744	\N	224	t
383	2023-08-03 06:32:39.876739	2023-08-03 06:32:39.876739	159	\N	t
384	2023-08-03 06:32:39.890693	2023-08-03 06:32:39.890693	\N	225	t
385	2023-08-03 06:32:39.910867	2023-08-03 06:32:39.910867	160	\N	t
386	2023-08-03 06:32:39.927124	2023-08-03 06:32:39.927124	\N	226	t
387	2023-08-03 06:32:39.949973	2023-08-03 06:32:39.949973	161	\N	t
388	2023-08-03 06:32:39.970595	2023-08-03 06:32:39.970595	\N	227	t
389	2023-08-03 06:32:39.994139	2023-08-03 06:32:39.994139	162	\N	t
390	2023-08-03 06:32:40.007726	2023-08-03 06:32:40.007726	\N	228	t
391	2023-08-03 06:32:40.027095	2023-08-03 06:32:40.027095	163	\N	t
392	2023-08-03 06:32:40.046592	2023-08-03 06:32:40.046592	\N	229	t
393	2023-08-03 06:32:40.073467	2023-08-03 06:32:40.073467	164	\N	t
394	2023-08-03 06:32:40.097102	2023-08-03 06:32:40.097102	\N	230	t
395	2023-08-03 06:32:40.126071	2023-08-03 06:32:40.126071	165	\N	t
396	2023-08-03 06:32:40.146484	2023-08-03 06:32:40.146484	\N	231	t
397	2023-08-03 06:32:40.169421	2023-08-03 06:32:40.169421	166	\N	t
398	2023-08-03 06:32:40.188456	2023-08-03 06:32:40.188456	\N	232	t
399	2023-08-03 06:32:40.210511	2023-08-03 06:32:40.210511	167	\N	t
400	2023-08-03 06:32:40.227035	2023-08-03 06:32:40.227035	\N	233	t
401	2023-08-03 06:32:40.253748	2023-08-03 06:32:40.253748	168	\N	t
402	2023-08-03 06:32:40.271702	2023-08-03 06:32:40.271702	\N	234	t
403	2023-08-03 06:32:40.290916	2023-08-03 06:32:40.290916	169	\N	t
404	2023-08-03 06:32:40.310191	2023-08-03 06:32:40.310191	\N	235	t
405	2023-08-03 06:32:40.332655	2023-08-03 06:32:40.332655	170	\N	t
406	2023-08-03 06:32:40.348117	2023-08-03 06:32:40.348117	\N	236	t
407	2023-08-03 06:32:40.369625	2023-08-03 06:32:40.369625	171	\N	t
408	2023-08-03 06:32:40.388781	2023-08-03 06:32:40.388781	\N	237	t
409	2023-08-03 06:32:40.406746	2023-08-03 06:32:40.406746	172	\N	t
410	2023-08-03 06:32:40.425734	2023-08-03 06:32:40.425734	\N	238	t
411	2023-08-03 06:32:40.451889	2023-08-03 06:32:40.451889	173	\N	t
412	2023-08-03 06:32:40.467629	2023-08-03 06:32:40.467629	\N	239	t
413	2023-08-03 06:32:40.492705	2023-08-03 06:32:40.492705	174	\N	t
414	2023-08-03 06:32:40.512909	2023-08-03 06:32:40.512909	\N	240	t
415	2023-08-03 06:32:40.53219	2023-08-03 06:32:40.53219	175	\N	t
416	2023-08-03 06:32:40.55096	2023-08-03 06:32:40.55096	\N	241	t
417	2023-08-03 06:32:40.579939	2023-08-03 06:32:40.579939	176	\N	t
418	2023-08-03 06:32:40.609572	2023-08-03 06:32:40.609572	\N	242	t
419	2023-08-03 06:32:40.645345	2023-08-03 06:32:40.645345	177	\N	t
420	2023-08-03 06:32:40.661871	2023-08-03 06:32:40.661871	\N	243	t
421	2023-08-03 06:32:40.686504	2023-08-03 06:32:40.686504	178	\N	t
422	2023-08-03 06:32:40.704595	2023-08-03 06:32:40.704595	\N	244	t
423	2023-08-03 06:32:40.728115	2023-08-03 06:32:40.728115	179	\N	t
424	2023-08-03 06:32:40.748911	2023-08-03 06:32:40.748911	\N	245	t
425	2023-08-03 06:32:40.769967	2023-08-03 06:32:40.769967	180	\N	t
426	2023-08-03 06:32:40.787387	2023-08-03 06:32:40.787387	\N	246	t
427	2023-08-03 06:32:40.808143	2023-08-03 06:32:40.808143	181	\N	t
428	2023-08-03 06:32:40.825862	2023-08-03 06:32:40.825862	\N	247	t
429	2023-08-03 06:32:40.851812	2023-08-03 06:32:40.851812	182	\N	t
430	2023-08-03 06:32:40.867124	2023-08-03 06:32:40.867124	\N	248	t
431	2023-08-03 06:32:40.889893	2023-08-03 06:32:40.889893	183	\N	t
432	2023-08-03 06:32:40.907563	2023-08-03 06:32:40.907563	\N	249	t
433	2023-08-03 06:32:40.930408	2023-08-03 06:32:40.930408	184	\N	t
434	2023-08-03 06:32:40.945338	2023-08-03 06:32:40.945338	\N	250	t
435	2023-08-03 06:32:40.969924	2023-08-03 06:32:40.969924	185	\N	t
436	2023-08-03 06:32:40.9879	2023-08-03 06:32:40.9879	\N	251	t
437	2023-08-03 06:32:41.009971	2023-08-03 06:32:41.009971	186	\N	t
438	2023-08-03 06:32:41.025278	2023-08-03 06:32:41.025278	\N	252	t
439	2023-08-03 06:32:41.047646	2023-08-03 06:32:41.047646	187	\N	t
440	2023-08-03 06:32:41.064326	2023-08-03 06:32:41.064326	\N	253	t
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version) FROM stdin;
20230609201040
20160320194732
20160320195323
20160320200142
20160321021009
20160401042735
20160401043112
20160401043139
20160401043947
20160405025104
20160425220934
20160427075710
20160427211824
20160427223914
20160522230506
20160523003118
20160607025257
20160626211504
20160626215946
20160626235137
20160626235235
20160626235249
20160719055628
20160721060831
20160721065026
20161204204007
20161204211752
20161206004753
20161208022001
20170112020108
20170116075815
20170121235411
20170216022106
20170216022813
20170216032041
20170223031402
20170324170333
20170703234822
20170909221914
20171029205653
20171029212944
20171218201727
20171218201826
20180201020034
20180201020437
20180201021006
20180201021417
20180201023804
20180201030127
20180201030204
20180201030240
20180201040240
20180201050818
20180204222729
20180204222821
20180204224356
20180204224831
20180204225031
20180204225337
20180204225503
20180204225609
20180204225622
20180204230826
20180204230859
20180218214354
20180218214738
20180218214758
20180218214934
20180218215711
20180218215933
20180218220556
20180218220624
20180218221548
20180218221712
20180218221825
20180218222002
20180627135323
20180630205912
20180805190627
20181127163326
20181231212751
20190106233415
20190204014940
20190331214423
20190505235706
20190505235754
20190602224010
20190602224219
20190613040858
20190613041725
20190613054936
20190811225329
20191004234040
20191119150033
20191119150125
20200904021230
20200907000752
20200907010754
20200928034548
20201010051554
20201010052534
20201025061056
20201211012159
20201211012256
20210214012211
20210527020930
20220601051134
20220602025217
20220824191631
20220825045308
20220902002957
20220902003134
20220909212858
20230404181143
20230404230604
20230530212320
20230530212331
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.services (id, created_at, updated_at, name, long_description, eligibility, required_documents, fee, application_process, resource_id, verified_at, email, status, certified, program_id, interpretation_services, url, wait_time, contact_id, funding_id, alternate_name, certified_at, featured, source_attribution, internal_note) FROM stdin;
1	2023-08-03 06:32:29.490801	2023-08-03 06:32:29.490801	Legros-Lynch	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	\N	\N	\N	\N	1	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
2	2023-08-03 06:32:29.567336	2023-08-03 06:32:29.567336	Hartmann Inc	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	1	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
3	2023-08-03 06:32:29.61912	2023-08-03 06:32:29.61912	Smith Inc	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	\N	\N	\N	\N	2	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
4	2023-08-03 06:32:29.65039	2023-08-03 06:32:29.65039	Donnelly LLC	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	2	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
5	2023-08-03 06:32:29.696282	2023-08-03 06:32:29.696282	Beer-Windler	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	\N	\N	\N	\N	3	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
6	2023-08-03 06:32:29.719734	2023-08-03 06:32:29.719734	McCullough-Sporer	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	\N	\N	\N	\N	3	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
7	2023-08-03 06:32:29.766452	2023-08-03 06:32:29.766452	Crooks and Sons	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	\N	\N	\N	\N	4	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
8	2023-08-03 06:32:29.82545	2023-08-03 06:32:29.82545	O'Kon-Nader	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	\N	\N	\N	\N	5	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
9	2023-08-03 06:32:29.853008	2023-08-03 06:32:29.853008	Heaney-Flatley	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	\N	\N	\N	\N	5	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
10	2023-08-03 06:32:29.90171	2023-08-03 06:32:29.90171	Koepp, Nitzsche and Greenfelder	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	\N	\N	\N	\N	6	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
11	2023-08-03 06:32:29.925947	2023-08-03 06:32:29.925947	Balistreri-Leuschke	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	6	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
12	2023-08-03 06:32:29.978578	2023-08-03 06:32:29.978578	Hyatt and Sons	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	\N	\N	\N	\N	7	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
13	2023-08-03 06:32:30.009905	2023-08-03 06:32:30.009905	Daugherty, Bayer and Leffler	Serves lunch Monday and Wednesday. Dinner available all days.\n	\N	\N	\N	\N	7	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
14	2023-08-03 06:32:30.048831	2023-08-03 06:32:30.048831	Lakin Group	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	\N	\N	\N	\N	8	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
15	2023-08-03 06:32:30.073631	2023-08-03 06:32:30.073631	Halvorson-Gulgowski	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	\N	\N	\N	\N	8	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
16	2023-08-03 06:32:30.117258	2023-08-03 06:32:30.117258	Hills LLC	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	\N	\N	\N	\N	9	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
17	2023-08-03 06:32:30.163098	2023-08-03 06:32:30.163098	Pacocha, Thiel and Thiel	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	10	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
18	2023-08-03 06:32:30.216708	2023-08-03 06:32:30.216708	Walker LLC	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	11	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
19	2023-08-03 06:32:30.24244	2023-08-03 06:32:30.24244	VonRueden LLC	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	\N	\N	\N	\N	11	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
20	2023-08-03 06:32:30.281696	2023-08-03 06:32:30.281696	Gerlach, Parker and Pollich	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	\N	\N	\N	\N	12	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
21	2023-08-03 06:32:30.30581	2023-08-03 06:32:30.30581	Lynch-Balistreri	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	\N	\N	\N	\N	12	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
22	2023-08-03 06:32:30.347414	2023-08-03 06:32:30.347414	Crona LLC	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	13	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
23	2023-08-03 06:32:30.37341	2023-08-03 06:32:30.37341	Abernathy LLC	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	\N	\N	\N	\N	13	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
24	2023-08-03 06:32:30.421911	2023-08-03 06:32:30.421911	Barton and Sons	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	\N	\N	\N	\N	14	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
25	2023-08-03 06:32:30.463291	2023-08-03 06:32:30.463291	Crist Inc	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	15	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
26	2023-08-03 06:32:30.510091	2023-08-03 06:32:30.510091	Kovacek LLC	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	\N	\N	\N	\N	16	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
27	2023-08-03 06:32:30.551557	2023-08-03 06:32:30.551557	Schroeder and Sons	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	17	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
28	2023-08-03 06:32:30.572524	2023-08-03 06:32:30.572524	Hagenes, Cole and Hyatt	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	\N	\N	\N	\N	17	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
29	2023-08-03 06:32:30.63325	2023-08-03 06:32:30.63325	Roberts, Balistreri and Ryan	A place to shower on Tuesday through Saturday.\n	\N	\N	\N	\N	18	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
30	2023-08-03 06:32:30.661613	2023-08-03 06:32:30.661613	Wiegand-Yost	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	18	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
31	2023-08-03 06:32:30.706113	2023-08-03 06:32:30.706113	Mosciski Group	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	\N	\N	\N	\N	19	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
32	2023-08-03 06:32:30.746918	2023-08-03 06:32:30.746918	Marks-Walter	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	\N	\N	\N	\N	20	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
33	2023-08-03 06:32:30.774644	2023-08-03 06:32:30.774644	Bergstrom-Kuvalis	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	\N	\N	\N	\N	20	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
34	2023-08-03 06:32:30.813276	2023-08-03 06:32:30.813276	Rau and Sons	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	\N	\N	\N	\N	21	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
35	2023-08-03 06:32:30.861116	2023-08-03 06:32:30.861116	Paucek Inc	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	22	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
36	2023-08-03 06:32:30.883362	2023-08-03 06:32:30.883362	Konopelski-Runolfsdottir	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	\N	\N	\N	\N	22	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
37	2023-08-03 06:32:30.923944	2023-08-03 06:32:30.923944	Hoppe-Roberts	Serves lunch Monday and Wednesday. Dinner available all days.\n	\N	\N	\N	\N	23	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
38	2023-08-03 06:32:30.949625	2023-08-03 06:32:30.949625	Bogan Inc	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	\N	\N	\N	\N	23	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
39	2023-08-03 06:32:31.000428	2023-08-03 06:32:31.000428	Anderson-Wiegand	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	\N	\N	\N	\N	24	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
40	2023-08-03 06:32:31.022494	2023-08-03 06:32:31.022494	Lubowitz, Nikolaus and Satterfield	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	24	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
41	2023-08-03 06:32:31.072327	2023-08-03 06:32:31.072327	Hessel and Sons	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	\N	\N	\N	\N	25	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
42	2023-08-03 06:32:31.127838	2023-08-03 06:32:31.127838	Kovacek, Hackett and Johnson	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	\N	\N	\N	\N	26	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
43	2023-08-03 06:32:31.179449	2023-08-03 06:32:31.179449	Bayer-D'Amore	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	27	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
44	2023-08-03 06:32:31.230216	2023-08-03 06:32:31.230216	Spinka-Cronin	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	\N	\N	\N	\N	28	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
45	2023-08-03 06:32:31.278311	2023-08-03 06:32:31.278311	Wehner and Sons	Serves lunch Monday and Wednesday. Dinner available all days.\n	\N	\N	\N	\N	29	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
46	2023-08-03 06:32:31.318143	2023-08-03 06:32:31.318143	Shanahan-Dare	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	\N	\N	\N	\N	30	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
47	2023-08-03 06:32:31.367226	2023-08-03 06:32:31.367226	Block Group	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	\N	\N	\N	\N	31	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
48	2023-08-03 06:32:31.390333	2023-08-03 06:32:31.390333	Hermiston-Nader	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	\N	\N	\N	\N	31	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
49	2023-08-03 06:32:31.441808	2023-08-03 06:32:31.441808	Purdy-Witting	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	\N	\N	\N	\N	32	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
50	2023-08-03 06:32:31.48789	2023-08-03 06:32:31.48789	Abernathy-Wolff	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	33	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
51	2023-08-03 06:32:31.53622	2023-08-03 06:32:31.53622	Thompson, Kuhic and Predovic	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	\N	\N	\N	\N	34	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
52	2023-08-03 06:32:31.558626	2023-08-03 06:32:31.558626	Sipes Group	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	\N	\N	\N	\N	34	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
53	2023-08-03 06:32:31.60598	2023-08-03 06:32:31.60598	DuBuque-Borer	A place to shower on Tuesday through Saturday.\n	\N	\N	\N	\N	35	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
54	2023-08-03 06:32:31.6559	2023-08-03 06:32:31.6559	Cartwright and Sons	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	\N	\N	\N	\N	36	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
55	2023-08-03 06:32:31.702161	2023-08-03 06:32:31.702161	Herman-Jacobson	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	37	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
56	2023-08-03 06:32:31.751667	2023-08-03 06:32:31.751667	Ryan, Skiles and Daugherty	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	\N	\N	\N	\N	38	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
57	2023-08-03 06:32:31.804071	2023-08-03 06:32:31.804071	Ullrich, Carter and Stark	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	\N	\N	\N	\N	39	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
58	2023-08-03 06:32:31.85411	2023-08-03 06:32:31.85411	Torp, Douglas and Rippin	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	\N	\N	\N	\N	40	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
59	2023-08-03 06:32:31.8981	2023-08-03 06:32:31.8981	Jones-Weimann	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	\N	\N	\N	\N	41	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
60	2023-08-03 06:32:31.948818	2023-08-03 06:32:31.948818	Carter Group	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	\N	\N	\N	\N	42	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
61	2023-08-03 06:32:31.974482	2023-08-03 06:32:31.974482	Kunze, Rath and Feest	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	\N	\N	\N	\N	42	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
62	2023-08-03 06:32:32.019261	2023-08-03 06:32:32.019261	Mayert LLC	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	\N	\N	\N	\N	43	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
63	2023-08-03 06:32:32.06821	2023-08-03 06:32:32.06821	Mohr Inc	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	\N	\N	\N	\N	44	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
64	2023-08-03 06:32:32.113601	2023-08-03 06:32:32.113601	Hamill, Reynolds and Emmerich	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	\N	\N	\N	\N	45	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
65	2023-08-03 06:32:32.140745	2023-08-03 06:32:32.140745	Johns-Jast	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	\N	\N	\N	\N	45	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
66	2023-08-03 06:32:32.182637	2023-08-03 06:32:32.182637	Hintz-Miller	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	46	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
67	2023-08-03 06:32:32.229642	2023-08-03 06:32:32.229642	D'Amore, Padberg and Dooley	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	\N	\N	\N	\N	47	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
68	2023-08-03 06:32:32.252175	2023-08-03 06:32:32.252175	Prohaska and Sons	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	\N	\N	\N	\N	47	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
69	2023-08-03 06:32:32.301186	2023-08-03 06:32:32.301186	Trantow Inc	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	\N	\N	\N	\N	48	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
70	2023-08-03 06:32:32.348572	2023-08-03 06:32:32.348572	Wehner-Murphy	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	49	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
71	2023-08-03 06:32:32.400834	2023-08-03 06:32:32.400834	Rowe-Bergnaum	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	\N	\N	\N	\N	50	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
72	2023-08-03 06:32:32.450795	2023-08-03 06:32:32.450795	Corkery-Satterfield	A place to shower on Tuesday through Saturday.\n	\N	\N	\N	\N	51	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
73	2023-08-03 06:32:32.478715	2023-08-03 06:32:32.478715	Funk-Lowe	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	51	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
74	2023-08-03 06:32:32.524885	2023-08-03 06:32:32.524885	Balistreri-Rosenbaum	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	52	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
75	2023-08-03 06:32:32.549234	2023-08-03 06:32:32.549234	Yost Group	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	52	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
76	2023-08-03 06:32:32.596457	2023-08-03 06:32:32.596457	Feeney, Nikolaus and Rodriguez	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	\N	\N	\N	\N	53	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
77	2023-08-03 06:32:32.620457	2023-08-03 06:32:32.620457	Hirthe-Grimes	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	\N	\N	\N	\N	53	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
78	2023-08-03 06:32:32.668352	2023-08-03 06:32:32.668352	Roob Inc	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	54	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
79	2023-08-03 06:32:32.714667	2023-08-03 06:32:32.714667	Roob, Dooley and Kunze	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	\N	\N	\N	\N	55	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
80	2023-08-03 06:32:32.740717	2023-08-03 06:32:32.740717	Wiza-Leannon	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	\N	\N	\N	\N	55	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
81	2023-08-03 06:32:32.792906	2023-08-03 06:32:32.792906	Leuschke-Adams	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	\N	\N	\N	\N	56	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
82	2023-08-03 06:32:32.818535	2023-08-03 06:32:32.818535	Durgan-Conroy	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	\N	\N	\N	\N	56	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
83	2023-08-03 06:32:32.873152	2023-08-03 06:32:32.873152	Larkin Inc	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	57	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
84	2023-08-03 06:32:32.918924	2023-08-03 06:32:32.918924	Moore, Macejkovic and Smith	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	\N	\N	\N	\N	58	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
85	2023-08-03 06:32:32.94192	2023-08-03 06:32:32.94192	Hamill-Marquardt	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	\N	\N	\N	\N	58	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
86	2023-08-03 06:32:32.983933	2023-08-03 06:32:32.983933	Klocko and Sons	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	\N	\N	\N	\N	59	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
87	2023-08-03 06:32:33.008568	2023-08-03 06:32:33.008568	Thiel, Kuhic and Lynch	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	\N	\N	\N	\N	59	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
88	2023-08-03 06:32:33.051599	2023-08-03 06:32:33.051599	Ziemann Inc	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	\N	\N	\N	\N	60	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
89	2023-08-03 06:32:33.072694	2023-08-03 06:32:33.072694	Funk, Gutkowski and Conroy	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	\N	\N	\N	\N	60	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
90	2023-08-03 06:32:33.125883	2023-08-03 06:32:33.125883	Hansen Inc	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	\N	\N	\N	\N	61	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
91	2023-08-03 06:32:33.154654	2023-08-03 06:32:33.154654	Williamson-Wyman	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	\N	\N	\N	\N	61	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
92	2023-08-03 06:32:33.212881	2023-08-03 06:32:33.212881	Leannon, Rempel and Renner	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	\N	\N	\N	\N	62	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
93	2023-08-03 06:32:33.236248	2023-08-03 06:32:33.236248	Lang-Cronin	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	\N	\N	\N	\N	62	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
94	2023-08-03 06:32:33.287591	2023-08-03 06:32:33.287591	Maggio Inc	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	\N	\N	\N	\N	63	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
95	2023-08-03 06:32:33.335154	2023-08-03 06:32:33.335154	Larkin-West	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	\N	\N	\N	\N	64	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
96	2023-08-03 06:32:33.363235	2023-08-03 06:32:33.363235	Dickens Group	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	\N	\N	\N	\N	64	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
97	2023-08-03 06:32:33.408461	2023-08-03 06:32:33.408461	McCullough, Kozey and Rippin	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	\N	\N	\N	\N	65	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
98	2023-08-03 06:32:33.431867	2023-08-03 06:32:33.431867	Murray-White	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	\N	\N	\N	\N	65	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
99	2023-08-03 06:32:33.48796	2023-08-03 06:32:33.48796	Kunze, Cremin and Kemmer	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	\N	\N	\N	\N	66	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
100	2023-08-03 06:32:33.542449	2023-08-03 06:32:33.542449	Cruickshank and Sons	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	\N	\N	\N	\N	67	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
101	2023-08-03 06:32:33.593595	2023-08-03 06:32:33.593595	Kemmer Inc	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	\N	\N	\N	\N	68	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
102	2023-08-03 06:32:33.617605	2023-08-03 06:32:33.617605	Kerluke-Barton	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	\N	\N	\N	\N	68	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
103	2023-08-03 06:32:33.66743	2023-08-03 06:32:33.66743	Leuschke-Kuhlman	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	\N	\N	\N	\N	69	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
104	2023-08-03 06:32:33.725896	2023-08-03 06:32:33.725896	Cruickshank-Schroeder	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	\N	\N	\N	\N	70	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
105	2023-08-03 06:32:33.754144	2023-08-03 06:32:33.754144	Schroeder Group	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	\N	\N	\N	\N	70	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
106	2023-08-03 06:32:33.803591	2023-08-03 06:32:33.803591	Spencer-Stracke	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	\N	\N	\N	\N	71	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
107	2023-08-03 06:32:33.828737	2023-08-03 06:32:33.828737	Huels-Bednar	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	\N	\N	\N	\N	71	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
108	2023-08-03 06:32:33.87737	2023-08-03 06:32:33.87737	Heller-Lueilwitz	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	72	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
109	2023-08-03 06:32:33.926321	2023-08-03 06:32:33.926321	Kuphal, Jakubowski and Rolfson	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	\N	\N	\N	\N	73	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
110	2023-08-03 06:32:33.951061	2023-08-03 06:32:33.951061	Homenick LLC	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	\N	\N	\N	\N	73	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
111	2023-08-03 06:32:34.007381	2023-08-03 06:32:34.007381	Macejkovic, Wintheiser and McGlynn	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	74	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
112	2023-08-03 06:32:34.032277	2023-08-03 06:32:34.032277	Blanda, Streich and Ullrich	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	\N	\N	\N	\N	74	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
113	2023-08-03 06:32:34.082337	2023-08-03 06:32:34.082337	Mohr-Larson	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	75	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
114	2023-08-03 06:32:34.108054	2023-08-03 06:32:34.108054	Block, Borer and Grant	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	\N	\N	\N	\N	75	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
115	2023-08-03 06:32:34.162744	2023-08-03 06:32:34.162744	Hettinger, Mitchell and Torphy	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	\N	\N	\N	\N	76	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
116	2023-08-03 06:32:34.214947	2023-08-03 06:32:34.214947	Hauck, Wehner and Marquardt	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	\N	\N	\N	\N	77	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
117	2023-08-03 06:32:34.266994	2023-08-03 06:32:34.266994	Wolf-Kub	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	\N	\N	\N	\N	78	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
118	2023-08-03 06:32:34.297075	2023-08-03 06:32:34.297075	Predovic Group	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	\N	\N	\N	\N	78	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
119	2023-08-03 06:32:34.345606	2023-08-03 06:32:34.345606	Ratke and Sons	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	\N	\N	\N	\N	79	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
120	2023-08-03 06:32:34.3713	2023-08-03 06:32:34.3713	O'Connell, Wunsch and Bednar	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	\N	\N	\N	\N	79	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
121	2023-08-03 06:32:34.422538	2023-08-03 06:32:34.422538	Gusikowski, Batz and Kshlerin	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	80	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
122	2023-08-03 06:32:34.44526	2023-08-03 06:32:34.44526	Pagac, Ortiz and Padberg	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	\N	\N	\N	\N	80	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
123	2023-08-03 06:32:34.493898	2023-08-03 06:32:34.493898	Ruecker, Grimes and Cummings	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	\N	\N	\N	\N	81	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
124	2023-08-03 06:32:34.542975	2023-08-03 06:32:34.542975	Schultz Group	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	\N	\N	\N	\N	82	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
125	2023-08-03 06:32:34.572259	2023-08-03 06:32:34.572259	Reinger-Breitenberg	Serves lunch Monday and Wednesday. Dinner available all days.\n	\N	\N	\N	\N	82	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
126	2023-08-03 06:32:34.621807	2023-08-03 06:32:34.621807	Hickle Inc	Serves lunch Monday and Wednesday. Dinner available all days.\n	\N	\N	\N	\N	83	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
127	2023-08-03 06:32:34.67622	2023-08-03 06:32:34.67622	Spinka-Lubowitz	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	\N	\N	\N	\N	84	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
128	2023-08-03 06:32:34.734398	2023-08-03 06:32:34.734398	Hyatt Inc	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	\N	\N	\N	\N	85	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
129	2023-08-03 06:32:34.787963	2023-08-03 06:32:34.787963	Kuhn-Deckow	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	\N	\N	\N	\N	86	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
130	2023-08-03 06:32:34.816646	2023-08-03 06:32:34.816646	Braun Inc	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	\N	\N	\N	\N	86	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
131	2023-08-03 06:32:34.868352	2023-08-03 06:32:34.868352	Lehner-Denesik	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	\N	\N	\N	\N	87	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
132	2023-08-03 06:32:34.974704	2023-08-03 06:32:34.974704	Ryan, Schroeder and Carroll	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	88	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
133	2023-08-03 06:32:35.015422	2023-08-03 06:32:35.015422	Leffler, Ferry and Collins	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	88	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
134	2023-08-03 06:32:35.074783	2023-08-03 06:32:35.074783	McCullough Inc	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	89	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
135	2023-08-03 06:32:35.123098	2023-08-03 06:32:35.123098	Boehm Group	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	\N	\N	\N	\N	90	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
136	2023-08-03 06:32:35.144473	2023-08-03 06:32:35.144473	Durgan and Sons	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	\N	\N	\N	\N	90	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
137	2023-08-03 06:32:35.212037	2023-08-03 06:32:35.212037	Gibson Group	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	\N	\N	\N	\N	91	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
138	2023-08-03 06:32:35.245582	2023-08-03 06:32:35.245582	Heathcote, Von and Schumm	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	91	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
139	2023-08-03 06:32:35.296234	2023-08-03 06:32:35.296234	Cartwright Inc	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	\N	\N	\N	\N	92	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
140	2023-08-03 06:32:35.368048	2023-08-03 06:32:35.368048	Murray-Emard	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	93	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
141	2023-08-03 06:32:35.453805	2023-08-03 06:32:35.453805	Cole LLC	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	\N	\N	\N	\N	94	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
142	2023-08-03 06:32:35.487806	2023-08-03 06:32:35.487806	Rohan-Olson	A place to shower on Tuesday through Saturday.\n	\N	\N	\N	\N	94	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
143	2023-08-03 06:32:35.545442	2023-08-03 06:32:35.545442	Kutch-Bergnaum	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	95	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
144	2023-08-03 06:32:35.596084	2023-08-03 06:32:35.596084	Labadie, Leffler and Luettgen	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	96	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
145	2023-08-03 06:32:35.65211	2023-08-03 06:32:35.65211	Feeney-Bogan	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	\N	\N	\N	\N	97	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
146	2023-08-03 06:32:35.68077	2023-08-03 06:32:35.68077	Murphy LLC	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	\N	\N	\N	\N	97	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
147	2023-08-03 06:32:35.732442	2023-08-03 06:32:35.732442	Little Inc	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	\N	\N	\N	\N	98	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
148	2023-08-03 06:32:35.780905	2023-08-03 06:32:35.780905	Steuber Group	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	99	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
149	2023-08-03 06:32:35.802325	2023-08-03 06:32:35.802325	O'Keefe, Howe and Homenick	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	\N	\N	\N	\N	99	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
150	2023-08-03 06:32:35.860083	2023-08-03 06:32:35.860083	Klein, Fritsch and Lind	Serves lunch Monday and Wednesday. Dinner available all days.\n	\N	\N	\N	\N	100	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
151	2023-08-03 06:32:35.906777	2023-08-03 06:32:35.906777	Hamill-Rogahn	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	\N	\N	\N	\N	101	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
152	2023-08-03 06:32:35.951122	2023-08-03 06:32:35.951122	Schroeder, Wiza and Reynolds	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	102	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
153	2023-08-03 06:32:35.976028	2023-08-03 06:32:35.976028	Conn-Turcotte	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	\N	\N	\N	\N	102	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
154	2023-08-03 06:32:36.02321	2023-08-03 06:32:36.02321	Funk-Schamberger	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	103	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
155	2023-08-03 06:32:36.07115	2023-08-03 06:32:36.07115	Jacobi, Effertz and O'Kon	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	104	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
156	2023-08-03 06:32:36.13658	2023-08-03 06:32:36.13658	Sanford-Towne	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	105	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
157	2023-08-03 06:32:36.194807	2023-08-03 06:32:36.194807	Thiel and Sons	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	\N	\N	\N	\N	106	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
158	2023-08-03 06:32:36.237753	2023-08-03 06:32:36.237753	Fadel-Prosacco	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	\N	\N	\N	\N	107	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
159	2023-08-03 06:32:36.287074	2023-08-03 06:32:36.287074	Jacobson, Konopelski and VonRueden	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	\N	\N	\N	\N	108	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
160	2023-08-03 06:32:36.338549	2023-08-03 06:32:36.338549	Robel-Mayert	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	109	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
161	2023-08-03 06:32:36.383883	2023-08-03 06:32:36.383883	Feest LLC	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	\N	\N	\N	\N	110	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
162	2023-08-03 06:32:36.403232	2023-08-03 06:32:36.403232	Farrell Inc	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	110	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
163	2023-08-03 06:32:36.452577	2023-08-03 06:32:36.452577	Sanford, DuBuque and Wehner	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	\N	\N	\N	\N	111	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
164	2023-08-03 06:32:36.500183	2023-08-03 06:32:36.500183	Hammes LLC	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	\N	\N	\N	\N	112	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
165	2023-08-03 06:32:36.554549	2023-08-03 06:32:36.554549	Kirlin LLC	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	112	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
166	2023-08-03 06:32:36.621726	2023-08-03 06:32:36.621726	Swaniawski-Mayer	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	113	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
167	2023-08-03 06:32:36.673627	2023-08-03 06:32:36.673627	Kohler Group	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	114	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
168	2023-08-03 06:32:36.718557	2023-08-03 06:32:36.718557	Douglas and Sons	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	115	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
169	2023-08-03 06:32:36.788518	2023-08-03 06:32:36.788518	Glover LLC	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	\N	\N	\N	\N	116	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
170	2023-08-03 06:32:36.840886	2023-08-03 06:32:36.840886	Moen-VonRueden	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	\N	\N	\N	\N	117	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
171	2023-08-03 06:32:36.900692	2023-08-03 06:32:36.900692	Grimes-Sipes	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	\N	\N	\N	\N	118	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
172	2023-08-03 06:32:36.955967	2023-08-03 06:32:36.955967	Graham, Mraz and Murazik	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	\N	\N	\N	\N	119	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
173	2023-08-03 06:32:37.0171	2023-08-03 06:32:37.0171	Dietrich, Koch and Nikolaus	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	120	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
174	2023-08-03 06:32:37.074047	2023-08-03 06:32:37.074047	Ruecker-O'Kon	Serves lunch Monday and Wednesday. Dinner available all days.\n	\N	\N	\N	\N	121	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
175	2023-08-03 06:32:37.113071	2023-08-03 06:32:37.113071	Stamm Group	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	121	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
176	2023-08-03 06:32:37.169508	2023-08-03 06:32:37.169508	Konopelski, Schinner and Thompson	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	\N	\N	\N	\N	122	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
177	2023-08-03 06:32:37.200524	2023-08-03 06:32:37.200524	Turner, Schultz and Ward	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	\N	\N	\N	\N	122	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
178	2023-08-03 06:32:37.259	2023-08-03 06:32:37.259	Yundt-Effertz	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	\N	\N	\N	\N	123	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
179	2023-08-03 06:32:37.288928	2023-08-03 06:32:37.288928	Lueilwitz Group	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	123	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
180	2023-08-03 06:32:37.339153	2023-08-03 06:32:37.339153	Marvin LLC	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	124	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
181	2023-08-03 06:32:37.366406	2023-08-03 06:32:37.366406	Zieme Inc	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	\N	\N	\N	\N	124	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
213	2023-08-03 06:32:38.771647	2023-08-03 06:32:38.771647	Moen LLC	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	147	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
182	2023-08-03 06:32:37.413541	2023-08-03 06:32:37.413541	Lang-Streich	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	\N	\N	\N	\N	125	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
183	2023-08-03 06:32:37.464704	2023-08-03 06:32:37.464704	Waters-Schmitt	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	126	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
184	2023-08-03 06:32:37.514596	2023-08-03 06:32:37.514596	Borer, Mante and Wintheiser	Serves lunch Monday and Wednesday. Dinner available all days.\n	\N	\N	\N	\N	127	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
185	2023-08-03 06:32:37.559704	2023-08-03 06:32:37.559704	Oberbrunner-Wilkinson	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	\N	\N	\N	\N	128	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
186	2023-08-03 06:32:37.61543	2023-08-03 06:32:37.61543	Kihn and Sons	Serves lunch Monday and Wednesday. Dinner available all days.\n	\N	\N	\N	\N	129	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
187	2023-08-03 06:32:37.638224	2023-08-03 06:32:37.638224	Gutmann-Abshire	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	\N	\N	\N	\N	129	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
188	2023-08-03 06:32:37.691537	2023-08-03 06:32:37.691537	Nolan LLC	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	\N	\N	\N	\N	130	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
189	2023-08-03 06:32:37.735279	2023-08-03 06:32:37.735279	Quigley, Bogisich and Carter	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	\N	\N	\N	\N	131	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
190	2023-08-03 06:32:37.781802	2023-08-03 06:32:37.781802	Lind and Sons	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	\N	\N	\N	\N	132	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
191	2023-08-03 06:32:37.83092	2023-08-03 06:32:37.83092	Klein, Hartmann and Wiegand	A place to shower on Tuesday through Saturday.\n	\N	\N	\N	\N	133	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
192	2023-08-03 06:32:37.854219	2023-08-03 06:32:37.854219	Wilkinson-West	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	133	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
193	2023-08-03 06:32:37.898349	2023-08-03 06:32:37.898349	Wyman, Senger and Nolan	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	\N	\N	\N	\N	134	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
194	2023-08-03 06:32:37.918864	2023-08-03 06:32:37.918864	Kerluke-Rohan	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	\N	\N	\N	\N	134	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
195	2023-08-03 06:32:37.969122	2023-08-03 06:32:37.969122	Tremblay, Erdman and Lehner	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	\N	\N	\N	\N	135	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
196	2023-08-03 06:32:38.017189	2023-08-03 06:32:38.017189	Block, Wilderman and Jones	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	136	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
197	2023-08-03 06:32:38.081299	2023-08-03 06:32:38.081299	Keebler-Feil	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	137	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
198	2023-08-03 06:32:38.123524	2023-08-03 06:32:38.123524	Lakin, Leffler and Dach	A place to shower on Tuesday through Saturday.\n	\N	\N	\N	\N	137	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
199	2023-08-03 06:32:38.188328	2023-08-03 06:32:38.188328	Waters Group	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	\N	\N	\N	\N	138	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
200	2023-08-03 06:32:38.213924	2023-08-03 06:32:38.213924	Kertzmann, Labadie and Baumbach	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	138	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
201	2023-08-03 06:32:38.265095	2023-08-03 06:32:38.265095	Konopelski, Murazik and O'Kon	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	139	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
202	2023-08-03 06:32:38.294711	2023-08-03 06:32:38.294711	Bayer, Torp and Oberbrunner	Serves lunch Monday and Wednesday. Dinner available all days.\n	\N	\N	\N	\N	139	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
203	2023-08-03 06:32:38.349722	2023-08-03 06:32:38.349722	Swaniawski, Dach and Medhurst	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	\N	\N	\N	\N	140	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
204	2023-08-03 06:32:38.398157	2023-08-03 06:32:38.398157	Mosciski-Paucek	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	141	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
205	2023-08-03 06:32:38.450613	2023-08-03 06:32:38.450613	Nitzsche-Lockman	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	142	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
206	2023-08-03 06:32:38.473252	2023-08-03 06:32:38.473252	Feest, Rempel and O'Connell	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	142	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
207	2023-08-03 06:32:38.525252	2023-08-03 06:32:38.525252	Connelly-Mayert	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	143	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
208	2023-08-03 06:32:38.572184	2023-08-03 06:32:38.572184	Robel and Sons	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	\N	\N	\N	\N	144	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
209	2023-08-03 06:32:38.623948	2023-08-03 06:32:38.623948	Harber Group	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	145	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
210	2023-08-03 06:32:38.675685	2023-08-03 06:32:38.675685	Schmeler-Weissnat	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	146	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
211	2023-08-03 06:32:38.702922	2023-08-03 06:32:38.702922	Kerluke-Weissnat	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	146	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
212	2023-08-03 06:32:38.748135	2023-08-03 06:32:38.748135	Leffler, Carroll and Mohr	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	\N	\N	\N	\N	147	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
214	2023-08-03 06:32:38.81931	2023-08-03 06:32:38.81931	Jacobson, Paucek and Gorczany	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	\N	\N	\N	\N	148	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
215	2023-08-03 06:32:38.869512	2023-08-03 06:32:38.869512	A Test Service	I am a long description of a service.	\N	\N	\N	\N	149	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
216	2023-08-03 06:32:39.510921	2023-08-03 06:32:39.510921	Dooley-Cronin	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	\N	\N	\N	\N	150	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
217	2023-08-03 06:32:39.545118	2023-08-03 06:32:39.545118	Little, Johnson and White	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	\N	\N	\N	\N	151	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
218	2023-08-03 06:32:39.586459	2023-08-03 06:32:39.586459	Prohaska, Ankunding and Feil	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	\N	\N	\N	\N	152	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
219	2023-08-03 06:32:39.622034	2023-08-03 06:32:39.622034	Reynolds, Davis and Feest	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	\N	\N	\N	\N	153	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
220	2023-08-03 06:32:39.662925	2023-08-03 06:32:39.662925	Murray-Turner	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	\N	\N	\N	\N	154	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
221	2023-08-03 06:32:39.730273	2023-08-03 06:32:39.730273	Christiansen, Gutkowski and Bernier	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	\N	\N	\N	\N	155	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
222	2023-08-03 06:32:39.768033	2023-08-03 06:32:39.768033	Gusikowski, Waelchi and Parisian	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	156	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
223	2023-08-03 06:32:39.809097	2023-08-03 06:32:39.809097	Zemlak, Hoppe and Koelpin	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	\N	\N	\N	\N	157	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
224	2023-08-03 06:32:39.850518	2023-08-03 06:32:39.850518	Bruen, Runolfsdottir and Macejkovic	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	158	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
225	2023-08-03 06:32:39.886592	2023-08-03 06:32:39.886592	Farrell, Bechtelar and Russel	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	\N	\N	\N	\N	159	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
226	2023-08-03 06:32:39.923058	2023-08-03 06:32:39.923058	Conn and Sons	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	160	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
227	2023-08-03 06:32:39.96671	2023-08-03 06:32:39.96671	Metz, Ritchie and Pacocha	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	\N	\N	\N	\N	161	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
228	2023-08-03 06:32:40.003865	2023-08-03 06:32:40.003865	Marvin Group	A place to shower on Tuesday through Saturday.\n	\N	\N	\N	\N	162	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
229	2023-08-03 06:32:40.04239	2023-08-03 06:32:40.04239	Becker, Bailey and Orn	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	163	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
230	2023-08-03 06:32:40.093129	2023-08-03 06:32:40.093129	Kub, Jast and Deckow	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	\N	\N	\N	\N	164	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
231	2023-08-03 06:32:40.142418	2023-08-03 06:32:40.142418	Zemlak LLC	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	\N	\N	\N	\N	165	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
232	2023-08-03 06:32:40.184391	2023-08-03 06:32:40.184391	Stracke-Streich	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	\N	\N	\N	\N	166	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
233	2023-08-03 06:32:40.222964	2023-08-03 06:32:40.222964	Sporer, Schaefer and Bailey	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	\N	\N	\N	\N	167	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
234	2023-08-03 06:32:40.26787	2023-08-03 06:32:40.26787	Rogahn LLC	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	\N	\N	\N	\N	168	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
235	2023-08-03 06:32:40.306129	2023-08-03 06:32:40.306129	Upton-Dooley	Serves lunch Monday and Wednesday. Dinner available all days.\n	\N	\N	\N	\N	169	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
236	2023-08-03 06:32:40.344262	2023-08-03 06:32:40.344262	Ward, Luettgen and Parker	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	\N	\N	\N	\N	170	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
237	2023-08-03 06:32:40.384874	2023-08-03 06:32:40.384874	Weber, Ernser and Price	Serves lunch Monday and Wednesday. Dinner available all days.\n	\N	\N	\N	\N	171	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
238	2023-08-03 06:32:40.421894	2023-08-03 06:32:40.421894	Mohr-Cremin	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	\N	\N	\N	\N	172	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
239	2023-08-03 06:32:40.463554	2023-08-03 06:32:40.463554	Feeney-Jacobs	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	173	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
240	2023-08-03 06:32:40.508933	2023-08-03 06:32:40.508933	Von-Pacocha	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	174	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
241	2023-08-03 06:32:40.546892	2023-08-03 06:32:40.546892	Stracke, Cremin and Stanton	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	\N	\N	\N	\N	175	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
242	2023-08-03 06:32:40.604454	2023-08-03 06:32:40.604454	Mraz, Lesch and Wolf	A place to shower on Tuesday through Saturday.\n	\N	\N	\N	\N	176	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
243	2023-08-03 06:32:40.657998	2023-08-03 06:32:40.657998	Borer LLC	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	177	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
244	2023-08-03 06:32:40.700401	2023-08-03 06:32:40.700401	Bosco-Ziemann	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	178	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
245	2023-08-03 06:32:40.745036	2023-08-03 06:32:40.745036	Swaniawski Group	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	\N	\N	\N	\N	179	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
246	2023-08-03 06:32:40.783614	2023-08-03 06:32:40.783614	Baumbach, Hilpert and Kub	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	\N	\N	\N	\N	180	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
247	2023-08-03 06:32:40.821884	2023-08-03 06:32:40.821884	O'Kon, Maggio and Schmitt	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	\N	\N	\N	\N	181	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
248	2023-08-03 06:32:40.863116	2023-08-03 06:32:40.863116	Bergstrom Inc	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	\N	\N	\N	\N	182	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
249	2023-08-03 06:32:40.903676	2023-08-03 06:32:40.903676	Cummings, Deckow and Torphy	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	\N	\N	\N	\N	183	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
250	2023-08-03 06:32:40.941552	2023-08-03 06:32:40.941552	Jacobs Group	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	\N	\N	\N	\N	184	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
251	2023-08-03 06:32:40.983916	2023-08-03 06:32:40.983916	Marks, Schinner and Ondricka	A place to shower on Tuesday through Saturday.\n	\N	\N	\N	\N	185	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
252	2023-08-03 06:32:41.021059	2023-08-03 06:32:41.021059	Conroy Inc	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	\N	\N	\N	\N	186	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
253	2023-08-03 06:32:41.060256	2023-08-03 06:32:41.060256	Wiegand and Sons	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	\N	\N	\N	\N	187	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
\.


--
-- Data for Name: sites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sites (id, site_code) FROM stdin;
1	sfsg
2	sffamilies
\.


--
-- Data for Name: synonym_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.synonym_groups (id, group_type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: synonyms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.synonyms (id, word, synonym_group_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: texting_recipients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.texting_recipients (id, recipient_name, phone_number, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: textings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.textings (id, texting_recipient_id, service_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name) FROM stdin;
\.


--
-- Data for Name: volunteers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.volunteers (id, description, url, created_at, updated_at, resource_id) FROM stdin;
\.


--
-- Name: accessibilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accessibilities_id_seq', 1, false);


--
-- Name: addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.addresses_id_seq', 187, true);


--
-- Name: admins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admins_id_seq', 1, false);


--
-- Name: bookmarks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bookmarks_id_seq', 1, false);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 231, true);


--
-- Name: change_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.change_requests_id_seq', 215, true);


--
-- Name: contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contacts_id_seq', 1, false);


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.delayed_jobs_id_seq', 1, false);


--
-- Name: documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.documents_id_seq', 214, true);


--
-- Name: eligibilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eligibilities_id_seq', 13, true);


--
-- Name: feedbacks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.feedbacks_id_seq', 1, false);


--
-- Name: field_changes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.field_changes_id_seq', 430, true);


--
-- Name: fundings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fundings_id_seq', 1, false);


--
-- Name: instructions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instructions_id_seq', 214, true);


--
-- Name: keywords_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.keywords_id_seq', 1, false);


--
-- Name: languages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.languages_id_seq', 1, false);


--
-- Name: news_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.news_articles_id_seq', 1, false);


--
-- Name: notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notes_id_seq', 440, true);


--
-- Name: phones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.phones_id_seq', 187, true);


--
-- Name: programs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.programs_id_seq', 1, false);


--
-- Name: resources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.resources_id_seq', 187, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_id_seq', 1, false);


--
-- Name: schedule_days_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schedule_days_id_seq', 3097, true);


--
-- Name: schedules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schedules_id_seq', 440, true);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.services_id_seq', 253, true);


--
-- Name: sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sites_id_seq', 2, true);


--
-- Name: synonym_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.synonym_groups_id_seq', 1, false);


--
-- Name: synonyms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.synonyms_id_seq', 1, false);


--
-- Name: texting_recipients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.texting_recipients_id_seq', 1, false);


--
-- Name: textings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.textings_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: volunteers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.volunteers_id_seq', 1, false);


--
-- Name: accessibilities accessibilities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accessibilities
    ADD CONSTRAINT accessibilities_pkey PRIMARY KEY (id);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: bookmarks bookmarks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookmarks
    ADD CONSTRAINT bookmarks_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: change_requests change_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.change_requests
    ADD CONSTRAINT change_requests_pkey PRIMARY KEY (id);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs delayed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delayed_jobs
    ADD CONSTRAINT delayed_jobs_pkey PRIMARY KEY (id);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: eligibilities eligibilities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eligibilities
    ADD CONSTRAINT eligibilities_pkey PRIMARY KEY (id);


--
-- Name: feedbacks feedbacks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedbacks_pkey PRIMARY KEY (id);


--
-- Name: field_changes field_changes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.field_changes
    ADD CONSTRAINT field_changes_pkey PRIMARY KEY (id);


--
-- Name: fundings fundings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fundings
    ADD CONSTRAINT fundings_pkey PRIMARY KEY (id);


--
-- Name: instructions instructions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructions
    ADD CONSTRAINT instructions_pkey PRIMARY KEY (id);


--
-- Name: keywords keywords_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keywords
    ADD CONSTRAINT keywords_pkey PRIMARY KEY (id);


--
-- Name: languages languages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (id);


--
-- Name: news_articles news_articles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_articles
    ADD CONSTRAINT news_articles_pkey PRIMARY KEY (id);


--
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: phones phones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phones
    ADD CONSTRAINT phones_pkey PRIMARY KEY (id);


--
-- Name: programs programs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.programs
    ADD CONSTRAINT programs_pkey PRIMARY KEY (id);


--
-- Name: resources resources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT resources_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: schedule_days schedule_days_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_days
    ADD CONSTRAINT schedule_days_pkey PRIMARY KEY (id);


--
-- Name: schedules schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: sites sites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_pkey PRIMARY KEY (id);


--
-- Name: synonym_groups synonym_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.synonym_groups
    ADD CONSTRAINT synonym_groups_pkey PRIMARY KEY (id);


--
-- Name: synonyms synonyms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.synonyms
    ADD CONSTRAINT synonyms_pkey PRIMARY KEY (id);


--
-- Name: texting_recipients texting_recipients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.texting_recipients
    ADD CONSTRAINT texting_recipients_pkey PRIMARY KEY (id);


--
-- Name: textings textings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.textings
    ADD CONSTRAINT textings_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: volunteers volunteers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volunteers
    ADD CONSTRAINT volunteers_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_priority; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX delayed_jobs_priority ON public.delayed_jobs USING btree (priority, run_at);


--
-- Name: index_addresses_on_resource_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_addresses_on_resource_id ON public.addresses USING btree (resource_id);


--
-- Name: index_addresses_services_on_address_id_and_service_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_addresses_services_on_address_id_and_service_id ON public.addresses_services USING btree (address_id, service_id);


--
-- Name: index_addresses_services_on_service_id_and_address_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_addresses_services_on_service_id_and_address_id ON public.addresses_services USING btree (service_id, address_id);


--
-- Name: index_admins_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_admins_on_email ON public.admins USING btree (email);


--
-- Name: index_admins_on_uid_and_provider; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_admins_on_uid_and_provider ON public.admins USING btree (uid, provider);


--
-- Name: index_bookmarks_on_identifier; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_bookmarks_on_identifier ON public.bookmarks USING btree (identifier);


--
-- Name: index_categories_on_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_categories_on_name ON public.categories USING btree (name);


--
-- Name: index_categories_resources_on_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_categories_resources_on_category_id ON public.categories_resources USING btree (category_id);


--
-- Name: index_categories_resources_on_resource_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_categories_resources_on_resource_id ON public.categories_resources USING btree (resource_id);


--
-- Name: index_categories_services_on_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_categories_services_on_category_id ON public.categories_services USING btree (category_id);


--
-- Name: index_categories_services_on_service_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_categories_services_on_service_id ON public.categories_services USING btree (service_id);


--
-- Name: index_categories_sites_on_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_categories_sites_on_category_id ON public.categories_sites USING btree (category_id);


--
-- Name: index_categories_sites_on_site_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_categories_sites_on_site_id ON public.categories_sites USING btree (site_id);


--
-- Name: index_category_relationships_on_child_id_and_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_category_relationships_on_child_id_and_parent_id ON public.category_relationships USING btree (child_id, parent_id);


--
-- Name: index_change_requests_on_resource_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_change_requests_on_resource_id ON public.change_requests USING btree (resource_id);


--
-- Name: index_contacts_on_resource_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_contacts_on_resource_id ON public.contacts USING btree (resource_id);


--
-- Name: index_contacts_on_service_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_contacts_on_service_id ON public.contacts USING btree (service_id);


--
-- Name: index_eligibilities_on_feature_rank; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_eligibilities_on_feature_rank ON public.eligibilities USING btree (feature_rank);


--
-- Name: index_eligibilities_on_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_eligibilities_on_name ON public.eligibilities USING btree (name);


--
-- Name: index_eligibilities_services_on_eligibility_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_eligibilities_services_on_eligibility_id ON public.eligibilities_services USING btree (eligibility_id);


--
-- Name: index_eligibilities_services_on_service_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_eligibilities_services_on_service_id ON public.eligibilities_services USING btree (service_id);


--
-- Name: index_feedbacks_on_resource_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_feedbacks_on_resource_id ON public.feedbacks USING btree (resource_id);


--
-- Name: index_feedbacks_on_service_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_feedbacks_on_service_id ON public.feedbacks USING btree (service_id);


--
-- Name: index_field_changes_on_change_request_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_field_changes_on_change_request_id ON public.field_changes USING btree (change_request_id);


--
-- Name: index_instructions_on_service_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_instructions_on_service_id ON public.instructions USING btree (service_id);


--
-- Name: index_notes_on_resource_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_notes_on_resource_id ON public.notes USING btree (resource_id);


--
-- Name: index_notes_on_service_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_notes_on_service_id ON public.notes USING btree (service_id);


--
-- Name: index_phones_on_contact_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_phones_on_contact_id ON public.phones USING btree (contact_id);


--
-- Name: index_phones_on_language_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_phones_on_language_id ON public.phones USING btree (language_id);


--
-- Name: index_phones_on_resource_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_phones_on_resource_id ON public.phones USING btree (resource_id);


--
-- Name: index_phones_on_service_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_phones_on_service_id ON public.phones USING btree (service_id);


--
-- Name: index_programs_on_resource_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_programs_on_resource_id ON public.programs USING btree (resource_id);


--
-- Name: index_resources_on_contact_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_resources_on_contact_id ON public.resources USING btree (contact_id);


--
-- Name: index_resources_on_funding_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_resources_on_funding_id ON public.resources USING btree (funding_id);


--
-- Name: index_resources_on_updated_at_and_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_resources_on_updated_at_and_id ON public.resources USING btree (updated_at, id);


--
-- Name: index_resources_sites_on_resource_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_resources_sites_on_resource_id ON public.resources_sites USING btree (resource_id);


--
-- Name: index_resources_sites_on_site_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_resources_sites_on_site_id ON public.resources_sites USING btree (site_id);


--
-- Name: index_reviews_on_feedback_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_reviews_on_feedback_id ON public.reviews USING btree (feedback_id);


--
-- Name: index_schedule_days_on_schedule_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_schedule_days_on_schedule_id ON public.schedule_days USING btree (schedule_id);


--
-- Name: index_schedules_on_resource_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_schedules_on_resource_id ON public.schedules USING btree (resource_id);


--
-- Name: index_schedules_on_service_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_schedules_on_service_id ON public.schedules USING btree (service_id);


--
-- Name: index_services_on_contact_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_services_on_contact_id ON public.services USING btree (contact_id);


--
-- Name: index_services_on_funding_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_services_on_funding_id ON public.services USING btree (funding_id);


--
-- Name: index_services_on_program_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_services_on_program_id ON public.services USING btree (program_id);


--
-- Name: index_services_on_resource_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_services_on_resource_id ON public.services USING btree (resource_id);


--
-- Name: index_synonym_groups_on_group_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_synonym_groups_on_group_type ON public.synonym_groups USING btree (group_type);


--
-- Name: index_synonyms_on_synonym_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_synonyms_on_synonym_group_id ON public.synonyms USING btree (synonym_group_id);


--
-- Name: index_synonyms_on_word; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_synonyms_on_word ON public.synonyms USING btree (word);


--
-- Name: index_textings_on_service_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_textings_on_service_id ON public.textings USING btree (service_id);


--
-- Name: index_textings_on_texting_recipient_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_textings_on_texting_recipient_id ON public.textings USING btree (texting_recipient_id);


--
-- Name: index_volunteers_on_resource_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_volunteers_on_resource_id ON public.volunteers USING btree (resource_id);


--
-- Name: phones fk_rails_0c8c68a120; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phones
    ADD CONSTRAINT fk_rails_0c8c68a120 FOREIGN KEY (contact_id) REFERENCES public.contacts(id);


--
-- Name: resources_sites fk_rails_101ffc8ff0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources_sites
    ADD CONSTRAINT fk_rails_101ffc8ff0 FOREIGN KEY (resource_id) REFERENCES public.resources(id);


--
-- Name: services fk_rails_2633b2a805; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT fk_rails_2633b2a805 FOREIGN KEY (program_id) REFERENCES public.programs(id);


--
-- Name: schedule_days fk_rails_29f8ca6b88; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_days
    ADD CONSTRAINT fk_rails_29f8ca6b88 FOREIGN KEY (schedule_id) REFERENCES public.schedules(id);


--
-- Name: programs fk_rails_2de31db625; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.programs
    ADD CONSTRAINT fk_rails_2de31db625 FOREIGN KEY (resource_id) REFERENCES public.resources(id);


--
-- Name: instructions fk_rails_36cfbe63f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructions
    ADD CONSTRAINT fk_rails_36cfbe63f1 FOREIGN KEY (service_id) REFERENCES public.services(id);


--
-- Name: addresses fk_rails_55362d1ad2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT fk_rails_55362d1ad2 FOREIGN KEY (resource_id) REFERENCES public.resources(id);


--
-- Name: phones fk_rails_57049cfb09; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phones
    ADD CONSTRAINT fk_rails_57049cfb09 FOREIGN KEY (language_id) REFERENCES public.languages(id);


--
-- Name: notes fk_rails_64d648111b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT fk_rails_64d648111b FOREIGN KEY (service_id) REFERENCES public.services(id);


--
-- Name: services fk_rails_73c21d485f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT fk_rails_73c21d485f FOREIGN KEY (contact_id) REFERENCES public.contacts(id);


--
-- Name: schedules fk_rails_766e5034a8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT fk_rails_766e5034a8 FOREIGN KEY (service_id) REFERENCES public.services(id);


--
-- Name: categories_sites fk_rails_77373afc24; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories_sites
    ADD CONSTRAINT fk_rails_77373afc24 FOREIGN KEY (site_id) REFERENCES public.sites(id);


--
-- Name: phones fk_rails_8af4287405; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phones
    ADD CONSTRAINT fk_rails_8af4287405 FOREIGN KEY (service_id) REFERENCES public.services(id);


--
-- Name: textings fk_rails_8c41a435e9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.textings
    ADD CONSTRAINT fk_rails_8c41a435e9 FOREIGN KEY (service_id) REFERENCES public.services(id);


--
-- Name: categories_sites fk_rails_915b8c61e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories_sites
    ADD CONSTRAINT fk_rails_915b8c61e8 FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: phones fk_rails_924e6c87a8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phones
    ADD CONSTRAINT fk_rails_924e6c87a8 FOREIGN KEY (resource_id) REFERENCES public.resources(id);


--
-- Name: textings fk_rails_976379f94a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.textings
    ADD CONSTRAINT fk_rails_976379f94a FOREIGN KEY (texting_recipient_id) REFERENCES public.texting_recipients(id);


--
-- Name: volunteers fk_rails_97f9ec98e4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volunteers
    ADD CONSTRAINT fk_rails_97f9ec98e4 FOREIGN KEY (resource_id) REFERENCES public.resources(id);


--
-- Name: notes fk_rails_9dd4d623bc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT fk_rails_9dd4d623bc FOREIGN KEY (resource_id) REFERENCES public.resources(id);


--
-- Name: resources_sites fk_rails_b2ab196031; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources_sites
    ADD CONSTRAINT fk_rails_b2ab196031 FOREIGN KEY (site_id) REFERENCES public.sites(id);


--
-- Name: feedbacks fk_rails_ba1e97eb0b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT fk_rails_ba1e97eb0b FOREIGN KEY (service_id) REFERENCES public.services(id);


--
-- Name: reviews fk_rails_ba3bc4eba4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_rails_ba3bc4eba4 FOREIGN KEY (feedback_id) REFERENCES public.feedbacks(id);


--
-- Name: resources fk_rails_c3c5410abb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT fk_rails_c3c5410abb FOREIGN KEY (contact_id) REFERENCES public.contacts(id);


--
-- Name: schedules fk_rails_c5d9a6dd50; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT fk_rails_c5d9a6dd50 FOREIGN KEY (resource_id) REFERENCES public.resources(id);


--
-- Name: change_requests fk_rails_ddab69079b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.change_requests
    ADD CONSTRAINT fk_rails_ddab69079b FOREIGN KEY (resource_id) REFERENCES public.resources(id);


--
-- Name: resources fk_rails_e042c299b0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT fk_rails_e042c299b0 FOREIGN KEY (funding_id) REFERENCES public.fundings(id);


--
-- Name: services fk_rails_e4aecbda0b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT fk_rails_e4aecbda0b FOREIGN KEY (funding_id) REFERENCES public.fundings(id);


--
-- Name: feedbacks fk_rails_e5a70b6b87; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT fk_rails_e5a70b6b87 FOREIGN KEY (resource_id) REFERENCES public.resources(id);


--
-- Name: contacts fk_rails_e5fbe64e2e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT fk_rails_e5fbe64e2e FOREIGN KEY (service_id) REFERENCES public.services(id);


--
-- Name: synonyms fk_rails_ec216edb57; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.synonyms
    ADD CONSTRAINT fk_rails_ec216edb57 FOREIGN KEY (synonym_group_id) REFERENCES public.synonym_groups(id);


--
-- Name: field_changes fk_rails_ed91fd9e31; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.field_changes
    ADD CONSTRAINT fk_rails_ed91fd9e31 FOREIGN KEY (change_request_id) REFERENCES public.change_requests(id);


--
-- Name: services fk_rails_f45d7dd368; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT fk_rails_f45d7dd368 FOREIGN KEY (resource_id) REFERENCES public.resources(id);


--
-- Name: contacts fk_rails_fb619aa824; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT fk_rails_fb619aa824 FOREIGN KEY (resource_id) REFERENCES public.resources(id);


--
-- PostgreSQL database dump complete
--

