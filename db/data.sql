--
-- PostgreSQL database dump
--
CREATE DATABASE askdarcel_development;
GRANT ALL PRIVILEGES ON DATABASE askdarcel_development TO postgres;
\c askdarcel_development
-- Dumped from database version 13.11 (Debian 13.11-1.pgdg120+1)
-- Dumped by pg_dump version 15.13 (Homebrew)

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
    id integer NOT NULL,
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
    AS integer
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
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    attention character varying,
    address_1 character varying NOT NULL,
    address_2 character varying,
    address_3 character varying,
    address_4 character varying,
    city character varying NOT NULL,
    state_province character varying NOT NULL,
    postal_code character varying NOT NULL,
    resource_id bigint,
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
    id integer NOT NULL,
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
    AS integer
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
    "order" integer,
    folder_id bigint,
    service_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    resource_id bigint,
    user_id bigint,
    name character varying
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
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
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
    category_id bigint NOT NULL,
    keyword_id bigint NOT NULL
);


ALTER TABLE public.categories_keywords OWNER TO postgres;

--
-- Name: categories_resources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories_resources (
    category_id bigint NOT NULL,
    resource_id bigint NOT NULL
);


ALTER TABLE public.categories_resources OWNER TO postgres;

--
-- Name: categories_services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories_services (
    service_id bigint NOT NULL,
    category_id bigint NOT NULL,
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
    id integer NOT NULL,
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
    AS integer
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
    id integer NOT NULL,
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
    AS integer
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
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    feature_rank integer,
    is_parent boolean DEFAULT false,
    parent_id integer
);


ALTER TABLE public.eligibilities OWNER TO postgres;

--
-- Name: eligibilities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eligibilities_id_seq
    AS integer
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
    id integer NOT NULL,
    field_name character varying,
    field_value character varying,
    change_request_id integer NOT NULL
);


ALTER TABLE public.field_changes OWNER TO postgres;

--
-- Name: field_changes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.field_changes_id_seq
    AS integer
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
-- Name: folders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.folders (
    id bigint NOT NULL,
    name character varying,
    "order" integer,
    user_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.folders OWNER TO postgres;

--
-- Name: folders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.folders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.folders_id_seq OWNER TO postgres;

--
-- Name: folders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.folders_id_seq OWNED BY public.folders.id;


--
-- Name: fundings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fundings (
    id integer NOT NULL,
    source character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.fundings OWNER TO postgres;

--
-- Name: fundings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fundings_id_seq
    AS integer
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
-- Name: group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_permissions (
    group_id bigint NOT NULL,
    permission_id bigint NOT NULL
);


ALTER TABLE public.group_permissions OWNER TO postgres;

--
-- Name: groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groups (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.groups OWNER TO postgres;

--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groups_id_seq OWNER TO postgres;

--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


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
    resource_id bigint NOT NULL,
    keyword_id bigint NOT NULL
);


ALTER TABLE public.keywords_resources OWNER TO postgres;

--
-- Name: keywords_services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keywords_services (
    service_id bigint NOT NULL,
    keyword_id bigint NOT NULL
);


ALTER TABLE public.keywords_services OWNER TO postgres;

--
-- Name: languages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.languages (
    id integer NOT NULL,
    language character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.languages OWNER TO postgres;

--
-- Name: languages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.languages_id_seq
    AS integer
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
    resource_id bigint,
    service_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
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
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permissions (
    id bigint NOT NULL,
    action integer,
    resource_id bigint,
    service_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    CONSTRAINT resource_xor_service CHECK ((((resource_id IS NOT NULL) AND (service_id IS NULL)) OR ((resource_id IS NULL) AND (service_id IS NOT NULL))))
);


ALTER TABLE public.permissions OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permissions_id_seq OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: phones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.phones (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    number character varying NOT NULL,
    service_type character varying NOT NULL,
    resource_id bigint NOT NULL,
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
    id integer NOT NULL,
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
    AS integer
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
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
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
-- Name: saved_searches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.saved_searches (
    id bigint NOT NULL,
    user_id bigint,
    name character varying,
    search jsonb DEFAULT '"{}"'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.saved_searches OWNER TO postgres;

--
-- Name: saved_searches_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.saved_searches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.saved_searches_id_seq OWNER TO postgres;

--
-- Name: saved_searches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.saved_searches_id_seq OWNED BY public.saved_searches.id;


--
-- Name: schedule_days; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedule_days (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    day character varying NOT NULL,
    opens_at integer,
    closes_at integer,
    schedule_id bigint NOT NULL,
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
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    resource_id bigint,
    service_id bigint,
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
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    name character varying,
    long_description text,
    eligibility character varying,
    required_documents character varying,
    fee character varying,
    application_process text,
    resource_id bigint,
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
    short_description character varying,
    boosted_category_id bigint
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
    service_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    resource_id bigint,
    CONSTRAINT resource_xor_service CHECK ((((resource_id IS NOT NULL) AND (service_id IS NULL)) OR ((resource_id IS NULL) AND (service_id IS NOT NULL))))
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
-- Name: user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_groups (
    user_id bigint NOT NULL,
    group_id bigint NOT NULL
);


ALTER TABLE public.user_groups OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying,
    organization character varying,
    user_external_id character varying,
    email character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
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
    id integer NOT NULL,
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
    AS integer
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
-- Name: folders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folders ALTER COLUMN id SET DEFAULT nextval('public.folders_id_seq'::regclass);


--
-- Name: fundings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fundings ALTER COLUMN id SET DEFAULT nextval('public.fundings_id_seq'::regclass);


--
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


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
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


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
-- Name: saved_searches id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_searches ALTER COLUMN id SET DEFAULT nextval('public.saved_searches_id_seq'::regclass);


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
1	2025-12-04 04:23:58.688441	2025-12-04 04:23:58.688441	Lenore Nader	954 Miller Mission	Apt. 531	\N	\N	Emeryberg	South Dakota	03557	1	37.7912752558665	-122.399128302493	\N	\N	\N	\N	\N
2	2025-12-04 04:23:58.773672	2025-12-04 04:23:58.773672	Julio Smitham	550 Stark Run	Suite 658	\N	\N	Port Aubrey	Kansas	19484	2	37.7826239678829	-122.406545774824	\N	\N	\N	\N	\N
3	2025-12-04 04:23:58.822271	2025-12-04 04:23:58.822271	Ciera Huels	7629 Kessler Loaf	Apt. 338	\N	\N	Okunevaton	Illinois	11878	3	37.7819366280267	-122.402661016023	\N	\N	\N	\N	\N
4	2025-12-04 04:23:58.857039	2025-12-04 04:23:58.857039	Kristine Morissette	8258 Welch Wall	Apt. 950	\N	\N	East Chuck	Virginia	52618-2992	4	37.7828057680121	-122.397743823752	\N	\N	\N	\N	\N
5	2025-12-04 04:23:58.881821	2025-12-04 04:23:58.881821	Nina Zboncak	325 Kemmer Passage	Apt. 343	\N	\N	South Shirabury	Montana	89949	5	37.7872134832786	-122.398578903273	\N	\N	\N	\N	\N
6	2025-12-04 04:23:58.905928	2025-12-04 04:23:58.905928	The Hon. Scotty Kautzer	3521 McKenzie Summit	Apt. 217	\N	\N	Gleichnerland	Hawaii	67692	6	37.7905021292371	-122.400804500922	\N	\N	\N	\N	\N
7	2025-12-04 04:23:58.934036	2025-12-04 04:23:58.934036	Shelby Corkery	48453 Merrill Avenue	Apt. 275	\N	\N	New Aurore	Indiana	94014	7	37.7930723350187	-122.398449217818	\N	\N	\N	\N	\N
8	2025-12-04 04:23:58.961517	2025-12-04 04:23:58.961517	Louella Gleichner	1184 Turner Lodge	Suite 546	\N	\N	Leonardoton	Massachusetts	72156	8	37.7804859874546	-122.406835171809	\N	\N	\N	\N	\N
9	2025-12-04 04:23:58.986644	2025-12-04 04:23:58.986644	Maegan Halvorson IV	79174 Miranda Dale	Apt. 501	\N	\N	Padbergland	Pennsylvania	28895-7351	9	37.7973523852984	-122.403299628448	\N	\N	\N	\N	\N
10	2025-12-04 04:23:59.011077	2025-12-04 04:23:59.011077	Nelda Greenholt CPA	7392 Hane Circles	Suite 311	\N	\N	Geniaville	Arizona	11638-8122	10	37.7836227075017	-122.406409481855	\N	\N	\N	\N	\N
11	2025-12-04 04:23:59.039524	2025-12-04 04:23:59.039524	Josh Bartell	1452 Alayna Summit	Apt. 885	\N	\N	Boscofort	Georgia	94712	11	37.784045512634	-122.394750033066	\N	\N	\N	\N	\N
12	2025-12-04 04:23:59.074227	2025-12-04 04:23:59.074227	Kyra Schmitt	4748 Wisozk Burgs	Suite 802	\N	\N	South Denae	Delaware	54342-9073	12	37.7841240446803	-122.397788301271	\N	\N	\N	\N	\N
13	2025-12-04 04:23:59.096546	2025-12-04 04:23:59.096546	Billie Marquardt	762 Mark Loaf	Suite 585	\N	\N	West Palmer	Mississippi	18142	13	37.7820802732529	-122.395060956365	\N	\N	\N	\N	\N
14	2025-12-04 04:23:59.13351	2025-12-04 04:23:59.13351	Karla Pfeffer	35137 Schaden Light	Suite 940	\N	\N	South Zachariahside	Ohio	66074	14	37.7936238312515	-122.40990409216	\N	\N	\N	\N	\N
15	2025-12-04 04:23:59.157658	2025-12-04 04:23:59.157658	Maximina Nader DVM	23306 Eric Pines	Suite 815	\N	\N	North Apryl	Alabama	93593	15	37.7868656582714	-122.394092328049	\N	\N	\N	\N	\N
16	2025-12-04 04:23:59.181475	2025-12-04 04:23:59.181475	Diedre Barton	2340 Kuhic Ferry	Suite 175	\N	\N	Tyramouth	Arizona	29582	16	37.7979231610105	-122.398779795309	\N	\N	\N	\N	\N
17	2025-12-04 04:23:59.207169	2025-12-04 04:23:59.207169	Henry Ferry	81931 Stark Station	Suite 719	\N	\N	Ziemebury	Nevada	13869-7990	17	37.7853960942775	-122.39746288675	\N	\N	\N	\N	\N
18	2025-12-04 04:23:59.234175	2025-12-04 04:23:59.234175	Willy Kuhlman	2215 Dietrich Lock	Suite 457	\N	\N	South Dorethea	Connecticut	52786	18	37.7859903990972	-122.393326038591	\N	\N	\N	\N	\N
19	2025-12-04 04:23:59.277668	2025-12-04 04:23:59.277668	Msgr. Luanne Kozey	461 Zulauf Trace	Suite 842	\N	\N	Lake Ted	Rhode Island	62637	19	37.7899757963769	-122.390534383302	\N	\N	\N	\N	\N
20	2025-12-04 04:23:59.316333	2025-12-04 04:23:59.316333	Cody Beer	708 Blick Dam	Apt. 551	\N	\N	East Sari	Nebraska	25060	20	37.7805793390916	-122.398035447293	\N	\N	\N	\N	\N
21	2025-12-04 04:23:59.361918	2025-12-04 04:23:59.361918	Rebeca Mueller	581 Kulas Lights	Apt. 365	\N	\N	Feeneytown	Wisconsin	79261	21	37.7920522300457	-122.406747855028	\N	\N	\N	\N	\N
22	2025-12-04 04:23:59.40237	2025-12-04 04:23:59.40237	Caryl Grant	132 Tremblay Mission	Suite 639	\N	\N	Port Annamaeborough	Missouri	37979-9532	22	37.797815586438	-122.392509476433	\N	\N	\N	\N	\N
23	2025-12-04 04:23:59.430218	2025-12-04 04:23:59.430218	Msgr. Andreas Bogan	4643 Champlin Via	Apt. 423	\N	\N	Lake Hedyburgh	New Jersey	22263-8571	23	37.7951513032477	-122.403378151599	\N	\N	\N	\N	\N
24	2025-12-04 04:23:59.458011	2025-12-04 04:23:59.458011	Kelli Beahan	950 Lind Land	Suite 822	\N	\N	Lueilwitzmouth	Arkansas	91522	24	37.7927785331085	-122.40064007155	\N	\N	\N	\N	\N
25	2025-12-04 04:23:59.488854	2025-12-04 04:23:59.488854	Mr. Teena Ryan	88188 Smitham Skyway	Suite 890	\N	\N	Omerborough	Maine	88192-3473	25	37.7806144930579	-122.397077215489	\N	\N	\N	\N	\N
26	2025-12-04 04:23:59.519142	2025-12-04 04:23:59.519142	Beatris Koepp	574 Conchita Stravenue	Suite 194	\N	\N	Vonside	Rhode Island	96322-5771	26	37.7877483226198	-122.3946378049	\N	\N	\N	\N	\N
27	2025-12-04 04:23:59.547328	2025-12-04 04:23:59.547328	Doreatha Koch	8105 Connelly Radial	Apt. 244	\N	\N	North India	Ohio	95650	27	37.7866294679871	-122.409626129288	\N	\N	\N	\N	\N
28	2025-12-04 04:23:59.574969	2025-12-04 04:23:59.574969	Rodrick Boyle	23741 Lynch Trail	Suite 155	\N	\N	Lake Florence	Idaho	48299-5013	28	37.7876033301873	-122.401741760715	\N	\N	\N	\N	\N
29	2025-12-04 04:23:59.61226	2025-12-04 04:23:59.61226	Rolland Romaguera	285 Amado Point	Suite 636	\N	\N	North Terresaville	Indiana	80244-5998	29	37.7807130667004	-122.394093482455	\N	\N	\N	\N	\N
30	2025-12-04 04:23:59.653144	2025-12-04 04:23:59.653144	Antonietta Grant	1345 Amberly Route	Apt. 217	\N	\N	New Claudialand	Montana	88518	30	37.7938759730003	-122.403825823148	\N	\N	\N	\N	\N
31	2025-12-04 04:23:59.680735	2025-12-04 04:23:59.680735	Hugo Medhurst	98723 Damion Islands	Apt. 188	\N	\N	South Rigoberto	Michigan	31838-0061	31	37.7879169270869	-122.401353832807	\N	\N	\N	\N	\N
32	2025-12-04 04:23:59.720502	2025-12-04 04:23:59.720502	Jackqueline Stroman	1429 Marquerite Harbors	Apt. 603	\N	\N	Breitenbergshire	South Carolina	26839-1291	32	37.7943348333128	-122.403349250043	\N	\N	\N	\N	\N
33	2025-12-04 04:23:59.756454	2025-12-04 04:23:59.756454	Nestor Walker	619 Carmon Bridge	Suite 460	\N	\N	Colbyborough	Maryland	66745	33	37.7919288166038	-122.409087525789	\N	\N	\N	\N	\N
34	2025-12-04 04:23:59.79635	2025-12-04 04:23:59.79635	Rev. Leatha Schaden	6490 Mose Lodge	Apt. 585	\N	\N	East Rosannland	Colorado	59354	34	37.7874698611292	-122.398484616765	\N	\N	\N	\N	\N
35	2025-12-04 04:23:59.822224	2025-12-04 04:23:59.822224	Rory Schroeder	1058 Geralyn Fields	Apt. 546	\N	\N	North Anibal	Tennessee	82784	35	37.7975976627641	-122.404758396796	\N	\N	\N	\N	\N
36	2025-12-04 04:23:59.851132	2025-12-04 04:23:59.851132	Kirk Kuvalis	64479 Satterfield Plains	Apt. 317	\N	\N	North Quiana	Idaho	67588	36	37.7861094713894	-122.409440589141	\N	\N	\N	\N	\N
37	2025-12-04 04:23:59.880037	2025-12-04 04:23:59.880037	Porsha Harris	50700 Hoeger Ville	Suite 318	\N	\N	Todfort	California	82762	37	37.7807506292813	-122.390487329844	\N	\N	\N	\N	\N
38	2025-12-04 04:23:59.910224	2025-12-04 04:23:59.910224	Evelyne Haag	767 Maggio Port	Suite 988	\N	\N	Toyfurt	Michigan	55262-6467	38	37.7968232084958	-122.393060808519	\N	\N	\N	\N	\N
39	2025-12-04 04:23:59.936803	2025-12-04 04:23:59.936803	Lynetta Harvey PhD	18056 O'Kon Mills	Apt. 458	\N	\N	Pansyfort	New York	68322-5395	39	37.7917134265105	-122.408310577048	\N	\N	\N	\N	\N
40	2025-12-04 04:23:59.988045	2025-12-04 04:23:59.988045	Renita Hudson	213 Howell Squares	Suite 726	\N	\N	Mayertview	Alaska	44528-5889	40	37.7944438984302	-122.404231083414	\N	\N	\N	\N	\N
41	2025-12-04 04:24:00.015868	2025-12-04 04:24:00.015868	Robbie Willms LLD	14877 Cecily Gardens	Apt. 128	\N	\N	New Columbus	Pennsylvania	04227-6049	41	37.7835331560654	-122.400947466846	\N	\N	\N	\N	\N
42	2025-12-04 04:24:00.044404	2025-12-04 04:24:00.044404	Ettie Bayer	91659 Griselda Valleys	Suite 280	\N	\N	Langworthtown	Rhode Island	32501	42	37.79617285242	-122.40989871589	\N	\N	\N	\N	\N
43	2025-12-04 04:24:00.069614	2025-12-04 04:24:00.069614	Sheree Hirthe	693 Keila Viaduct	Apt. 568	\N	\N	Port Fleta	New Jersey	92368-9925	43	37.7991762028883	-122.390202909894	\N	\N	\N	\N	\N
44	2025-12-04 04:24:00.111864	2025-12-04 04:24:00.111864	Alfredo Gerlach	5550 Mercedes Lodge	Suite 760	\N	\N	Vicentaland	Texas	37004-4109	44	37.7889237013078	-122.398433997423	\N	\N	\N	\N	\N
45	2025-12-04 04:24:00.139804	2025-12-04 04:24:00.139804	Neil Labadie	410 Celeste Knoll	Suite 524	\N	\N	Port Andres	Colorado	44735-6726	45	37.7825124523196	-122.401309796389	\N	\N	\N	\N	\N
46	2025-12-04 04:24:00.178213	2025-12-04 04:24:00.178213	Eun Cartwright DDS	6547 Oswaldo Villages	Suite 906	\N	\N	Port Adina	New Hampshire	18937-4451	46	37.799866810722	-122.405519576477	\N	\N	\N	\N	\N
47	2025-12-04 04:24:00.207461	2025-12-04 04:24:00.207461	Dr. Ronald Thompson	3261 Rochelle Alley	Apt. 628	\N	\N	Port Colleneton	Vermont	26117	47	37.7907260823898	-122.390663541807	\N	\N	\N	\N	\N
48	2025-12-04 04:24:00.234838	2025-12-04 04:24:00.234838	Laquita Lueilwitz	704 Gale Motorway	Suite 743	\N	\N	South Ranaeborough	Minnesota	42935	48	37.7878710663347	-122.405912075225	\N	\N	\N	\N	\N
49	2025-12-04 04:24:00.263611	2025-12-04 04:24:00.263611	Launa Bartell	1810 Luisa Burgs	Apt. 835	\N	\N	Lake Jungfort	Connecticut	51967	49	37.7854975795971	-122.394531085482	\N	\N	\N	\N	\N
50	2025-12-04 04:24:00.30386	2025-12-04 04:24:00.30386	Marlin Schmeler	32610 Lehner Stream	Apt. 151	\N	\N	Gorczanyfort	Georgia	35309-8368	50	37.786132216541	-122.398303425711	\N	\N	\N	\N	\N
51	2025-12-04 04:24:00.328005	2025-12-04 04:24:00.328005	Clorinda Kunde Esq.	626 Estella Mills	Suite 987	\N	\N	Robeltown	Colorado	40693	51	37.7821390646263	-122.395224244979	\N	\N	\N	\N	\N
52	2025-12-04 04:24:00.370125	2025-12-04 04:24:00.370125	Reginald Hilll	581 Shoshana Pines	Suite 458	\N	\N	Port Irinamouth	Delaware	59589-6934	52	37.7812146050141	-122.409694312583	\N	\N	\N	\N	\N
53	2025-12-04 04:24:00.409394	2025-12-04 04:24:00.409394	Donette Cummings	7732 Ralph Landing	Suite 584	\N	\N	Shanahanland	Wisconsin	07833	53	37.7820409062096	-122.40170322116	\N	\N	\N	\N	\N
54	2025-12-04 04:24:00.447542	2025-12-04 04:24:00.447542	Waylon Veum	72032 Sauer Corner	Apt. 724	\N	\N	North Michal	Nebraska	49118	54	37.7868488930967	-122.391474844884	\N	\N	\N	\N	\N
55	2025-12-04 04:24:00.475549	2025-12-04 04:24:00.475549	Lionel Hoeger	25820 Zulauf Trace	Suite 462	\N	\N	West Traci	Alabama	62044-4370	55	37.7800411771947	-122.398531959716	\N	\N	\N	\N	\N
56	2025-12-04 04:24:00.504984	2025-12-04 04:24:00.504984	Meggan Collins	8097 Jerrold Viaduct	Apt. 693	\N	\N	Lake Ruthie	Delaware	74183	56	37.7960853017177	-122.397618392225	\N	\N	\N	\N	\N
57	2025-12-04 04:24:00.532128	2025-12-04 04:24:00.532128	Johnnie Lemke	63503 Jenkins Village	Suite 473	\N	\N	West Clarencefurt	Wisconsin	50452	57	37.7826685689987	-122.397529864663	\N	\N	\N	\N	\N
58	2025-12-04 04:24:00.573852	2025-12-04 04:24:00.573852	Jacinto Rosenbaum	76810 Trinidad Street	Suite 654	\N	\N	South Guyland	Connecticut	51440	58	37.7869359626531	-122.399688076324	\N	\N	\N	\N	\N
59	2025-12-04 04:24:00.602848	2025-12-04 04:24:00.602848	Kathryn Trantow	255 Kam Light	Suite 316	\N	\N	Effertzborough	Mississippi	84690	59	37.7946063398046	-122.403763052495	\N	\N	\N	\N	\N
60	2025-12-04 04:24:00.63265	2025-12-04 04:24:00.63265	Booker Greenfelder	733 Scottie Branch	Suite 533	\N	\N	South Lauraleeborough	Maine	51284-2988	60	37.7813919314442	-122.405845615751	\N	\N	\N	\N	\N
61	2025-12-04 04:24:00.660983	2025-12-04 04:24:00.660983	Chanell Kutch	32848 Kohler Well	Apt. 690	\N	\N	Champlinfort	Vermont	52141-2063	61	37.7943052711654	-122.39565646414	\N	\N	\N	\N	\N
62	2025-12-04 04:24:00.70403	2025-12-04 04:24:00.70403	Genaro Goldner	2684 Gerlach Light	Apt. 379	\N	\N	South Arronland	Missouri	15039	62	37.7972848676549	-122.400982929972	\N	\N	\N	\N	\N
63	2025-12-04 04:24:00.731665	2025-12-04 04:24:00.731665	Oliva Strosin III	41898 Kuhn Lodge	Suite 394	\N	\N	Lake Rebbecca	North Carolina	82708	63	37.7929643151209	-122.400685209505	\N	\N	\N	\N	\N
64	2025-12-04 04:24:00.759113	2025-12-04 04:24:00.759113	Shaunta Price JD	1896 Adena Curve	Apt. 710	\N	\N	Fernandoville	Alaska	81607-2892	64	37.7862495474555	-122.403134481235	\N	\N	\N	\N	\N
65	2025-12-04 04:24:00.787815	2025-12-04 04:24:00.787815	Leisha Mosciski III	323 Stoltenberg Causeway	Suite 211	\N	\N	Brandonshire	Colorado	82135	65	37.796740852392	-122.397405644962	\N	\N	\N	\N	\N
66	2025-12-04 04:24:00.831871	2025-12-04 04:24:00.831871	Eufemia Hammes	65462 Berge Port	Apt. 783	\N	\N	Port Basil	Louisiana	65905-9151	66	37.7911055895151	-122.398856710404	\N	\N	\N	\N	\N
67	2025-12-04 04:24:00.861896	2025-12-04 04:24:00.861896	Caroyln McClure	204 Rau Junctions	Apt. 600	\N	\N	North Harriet	New Hampshire	46633	67	37.7906847636076	-122.409839853504	\N	\N	\N	\N	\N
68	2025-12-04 04:24:00.904725	2025-12-04 04:24:00.904725	Breanna Klocko	176 Neville Unions	Apt. 171	\N	\N	North Zelma	Ohio	75826-7012	68	37.7981112473324	-122.393691001296	\N	\N	\N	\N	\N
69	2025-12-04 04:24:00.929757	2025-12-04 04:24:00.929757	Gregg Nienow	42077 Nitzsche Circles	Apt. 553	\N	\N	North Nolanmouth	Vermont	26420	69	37.7802858900985	-122.394236195805	\N	\N	\N	\N	\N
70	2025-12-04 04:24:00.957432	2025-12-04 04:24:00.957432	Grady Hermiston	31457 Gavin Avenue	Suite 747	\N	\N	South Basil	New Hampshire	93628-9455	70	37.7885677897472	-122.395453552708	\N	\N	\N	\N	\N
71	2025-12-04 04:24:00.981479	2025-12-04 04:24:00.981479	Elvis Bernhard	1784 Erick Common	Suite 410	\N	\N	Rayfordside	Nebraska	84079-4128	71	37.7863193136556	-122.39090678814	\N	\N	\N	\N	\N
72	2025-12-04 04:24:01.024271	2025-12-04 04:24:01.024271	Fe Becker	3529 Krajcik Center	Apt. 282	\N	\N	Jonasshire	South Carolina	37814	72	37.7930732533248	-122.405344111973	\N	\N	\N	\N	\N
73	2025-12-04 04:24:01.050243	2025-12-04 04:24:01.050243	Lilia Hilpert	784 Blanch Forge	Apt. 566	\N	\N	Jamarshire	Washington	79013	73	37.7990321620107	-122.40328151814	\N	\N	\N	\N	\N
74	2025-12-04 04:24:01.088966	2025-12-04 04:24:01.088966	Charisse Von	52830 Bauch Turnpike	Suite 983	\N	\N	Davisfort	Kentucky	59238	74	37.7807666599197	-122.403265656383	\N	\N	\N	\N	\N
75	2025-12-04 04:24:01.126663	2025-12-04 04:24:01.126663	Randy Veum	3839 Jame Glens	Suite 849	\N	\N	Lonborough	Tennessee	63284	75	37.7874991951988	-122.3919144908	\N	\N	\N	\N	\N
76	2025-12-04 04:24:01.156072	2025-12-04 04:24:01.156072	Regena Yost VM	1902 Carmine Grove	Apt. 606	\N	\N	South Rosariobury	Rhode Island	55889-4743	76	37.7999941841212	-122.401637903148	\N	\N	\N	\N	\N
77	2025-12-04 04:24:01.196103	2025-12-04 04:24:01.196103	Isaias Wiegand	591 Conn Station	Suite 880	\N	\N	Port Lashaun	Arizona	60352	77	37.7815058987595	-122.403355457492	\N	\N	\N	\N	\N
78	2025-12-04 04:24:01.224157	2025-12-04 04:24:01.224157	Fr. Margery Walsh	97992 Shanti Glens	Apt. 371	\N	\N	Murrayton	New York	61758	78	37.7969674378357	-122.395082429269	\N	\N	\N	\N	\N
79	2025-12-04 04:24:01.265599	2025-12-04 04:24:01.265599	Rigoberto Stamm	850 Hyman Spur	Suite 641	\N	\N	Marquardtview	Alaska	74991-6071	79	37.793539540833	-122.394757294211	\N	\N	\N	\N	\N
80	2025-12-04 04:24:01.306015	2025-12-04 04:24:01.306015	Edmundo Schuster	146 Emanuel Circle	Suite 294	\N	\N	Lake Salinaland	Washington	04489-2129	80	37.7905397697142	-122.400740322189	\N	\N	\N	\N	\N
81	2025-12-04 04:24:01.349149	2025-12-04 04:24:01.349149	Mrs. Latrisha Rutherford	7217 Emmett Knolls	Apt. 700	\N	\N	North Augustineside	Maine	08934-8231	81	37.7928930462186	-122.399283366753	\N	\N	\N	\N	\N
82	2025-12-04 04:24:01.373404	2025-12-04 04:24:01.373404	Lorrie Grimes	83799 Mavis Port	Suite 918	\N	\N	East Kayceeside	Alaska	35482	82	37.7995594128164	-122.393593149326	\N	\N	\N	\N	\N
83	2025-12-04 04:24:01.419572	2025-12-04 04:24:01.419572	Korey O'Reilly	828 Bernardo Run	Apt. 729	\N	\N	Isatown	Idaho	00946	83	37.7958786764887	-122.406023471661	\N	\N	\N	\N	\N
84	2025-12-04 04:24:01.461776	2025-12-04 04:24:01.461776	Rose Waelchi LLD	496 Ronna Bridge	Suite 995	\N	\N	Schmitthaven	Washington	86568	84	37.7939270449434	-122.393541982947	\N	\N	\N	\N	\N
85	2025-12-04 04:24:01.490411	2025-12-04 04:24:01.490411	Sen. Kenneth Watsica	59983 Daugherty Mill	Suite 301	\N	\N	East Jeseniaton	Wisconsin	41638	85	37.7885869526658	-122.395879416821	\N	\N	\N	\N	\N
86	2025-12-04 04:24:01.518122	2025-12-04 04:24:01.518122	Rev. Palmer Kshlerin	656 Wiegand Causeway	Apt. 221	\N	\N	Douglasside	Mississippi	78262-7510	86	37.7843252467386	-122.403650247393	\N	\N	\N	\N	\N
87	2025-12-04 04:24:01.568433	2025-12-04 04:24:01.568433	Fatima Donnelly DDS	79262 Hugh Causeway	Suite 695	\N	\N	West Wendie	Oklahoma	37569-1896	87	37.7896271813052	-122.404378802213	\N	\N	\N	\N	\N
88	2025-12-04 04:24:01.610455	2025-12-04 04:24:01.610455	Ferdinand Kiehn	2866 Nestor Fort	Apt. 768	\N	\N	Grantmouth	Pennsylvania	63948	88	37.7957633854163	-122.404517577877	\N	\N	\N	\N	\N
89	2025-12-04 04:24:01.653536	2025-12-04 04:24:01.653536	Hilton Larson	560 Drew Burgs	Apt. 455	\N	\N	Zboncakbury	Ohio	19929	89	37.7876407985214	-122.394076577128	\N	\N	\N	\N	\N
90	2025-12-04 04:24:01.681152	2025-12-04 04:24:01.681152	Shad Champlin	661 Bergnaum Motorway	Apt. 580	\N	\N	West Zoraidaview	Louisiana	47778-3212	90	37.7971687623341	-122.398841255969	\N	\N	\N	\N	\N
91	2025-12-04 04:24:01.707348	2025-12-04 04:24:01.707348	Rev. Suzi Tromp	3271 Duane Forks	Suite 887	\N	\N	Simonischester	North Carolina	01878-2690	91	37.7870775743259	-122.392515531502	\N	\N	\N	\N	\N
92	2025-12-04 04:24:01.734838	2025-12-04 04:24:01.734838	Eliana Schamberger	96594 Mira Mission	Apt. 892	\N	\N	Armandburgh	Arizona	02073-9133	92	37.7883101917785	-122.397270966877	\N	\N	\N	\N	\N
93	2025-12-04 04:24:01.777701	2025-12-04 04:24:01.777701	Merlin Deckow	736 Abshire Burgs	Suite 827	\N	\N	Lindseyville	Pennsylvania	94648-1993	93	37.7992699996052	-122.409605656471	\N	\N	\N	\N	\N
94	2025-12-04 04:24:01.807595	2025-12-04 04:24:01.807595	Boris Roob	598 Murazik Freeway	Suite 431	\N	\N	North Ramon	New York	13673	94	37.7897086231878	-122.397092486257	\N	\N	\N	\N	\N
95	2025-12-04 04:24:01.833955	2025-12-04 04:24:01.833955	Sadie Rutherford Jr.	950 Ricarda Mills	Suite 767	\N	\N	New Nadene	Michigan	50820	95	37.7841465647871	-122.409640347977	\N	\N	\N	\N	\N
96	2025-12-04 04:24:01.857656	2025-12-04 04:24:01.857656	Jeannie Hoppe	83536 Berna Knoll	Suite 386	\N	\N	New Hue	New Mexico	40876-5518	96	37.7959030166452	-122.40973940934	\N	\N	\N	\N	\N
97	2025-12-04 04:24:01.887743	2025-12-04 04:24:01.887743	Jimmy Abernathy	983 Bashirian Estates	Apt. 533	\N	\N	Lake Brittenymouth	North Dakota	94726-4468	97	37.7987446343812	-122.409460808874	\N	\N	\N	\N	\N
98	2025-12-04 04:24:01.928792	2025-12-04 04:24:01.928792	Carlo Cummerata DC	620 Reinger Knoll	Apt. 283	\N	\N	Adinaborough	Louisiana	58801	98	37.7865661088243	-122.398653032076	\N	\N	\N	\N	\N
99	2025-12-04 04:24:01.97138	2025-12-04 04:24:01.97138	Roberto Ledner II	13681 Spencer Locks	Suite 925	\N	\N	Connellyshire	Maryland	48137	99	37.7945315280375	-122.391683684201	\N	\N	\N	\N	\N
100	2025-12-04 04:24:02.016468	2025-12-04 04:24:02.016468	Msgr. Catherine Adams	25632 Schmeler Station	Apt. 356	\N	\N	South Eraborough	Florida	65148	100	37.7934501637237	-122.406553264608	\N	\N	\N	\N	\N
101	2025-12-04 04:24:02.040921	2025-12-04 04:24:02.040921	Tana Hyatt	742 Numbers Squares	Suite 906	\N	\N	New Sanjuanatown	Georgia	50425	101	37.7853585625488	-122.3962429518	\N	\N	\N	\N	\N
102	2025-12-04 04:24:02.082755	2025-12-04 04:24:02.082755	Ruben Grady	9138 Sherril Park	Apt. 143	\N	\N	Vincenzoville	South Dakota	28112	102	37.7998970224533	-122.407053247652	\N	\N	\N	\N	\N
103	2025-12-04 04:24:02.109213	2025-12-04 04:24:02.109213	Aurora Dooley	528 Hamill Lodge	Apt. 817	\N	\N	Loydbury	Connecticut	36790-6687	103	37.7921929206908	-122.40647755347	\N	\N	\N	\N	\N
104	2025-12-04 04:24:02.135098	2025-12-04 04:24:02.135098	Pres. Will Wisozk	860 Simonis Roads	Apt. 708	\N	\N	Garyborough	Texas	82903-5177	104	37.7870978323011	-122.406286658432	\N	\N	\N	\N	\N
105	2025-12-04 04:24:02.160749	2025-12-04 04:24:02.160749	Debora Jones	2248 Stehr Pine	Suite 943	\N	\N	West Staciemouth	Pennsylvania	88541-1580	105	37.7817202935422	-122.391852646622	\N	\N	\N	\N	\N
106	2025-12-04 04:24:02.203802	2025-12-04 04:24:02.203802	Seema Hane	50182 McLaughlin Square	Apt. 503	\N	\N	North Haroldville	North Carolina	31899-6501	106	37.7979383406373	-122.39558989768	\N	\N	\N	\N	\N
107	2025-12-04 04:24:02.229234	2025-12-04 04:24:02.229234	Julius Mohr	6863 Ben Inlet	Suite 765	\N	\N	New Kenton	Oregon	28730-7195	107	37.7870089708051	-122.408649130793	\N	\N	\N	\N	\N
108	2025-12-04 04:24:02.272436	2025-12-04 04:24:02.272436	Wayne Schulist	789 Myrtis Causeway	Apt. 955	\N	\N	West Jonna	New Jersey	27463-0089	108	37.7852777049189	-122.406835861426	\N	\N	\N	\N	\N
109	2025-12-04 04:24:02.310618	2025-12-04 04:24:02.310618	Suzan Simonis	923 Konopelski Viaduct	Apt. 100	\N	\N	Mooreland	Maryland	58805-6194	109	37.7846882674393	-122.393528395491	\N	\N	\N	\N	\N
110	2025-12-04 04:24:02.337609	2025-12-04 04:24:02.337609	Kasey Luettgen	9795 Monroe Lane	Suite 328	\N	\N	Framiberg	Florida	04766-3444	110	37.7886377866982	-122.408915487959	\N	\N	\N	\N	\N
111	2025-12-04 04:24:02.373652	2025-12-04 04:24:02.373652	Amb. Alex Yost	7128 Jones Tunnel	Suite 915	\N	\N	East Jeremyville	Massachusetts	00479-0896	111	37.7951461470568	-122.408546270558	\N	\N	\N	\N	\N
112	2025-12-04 04:24:02.418143	2025-12-04 04:24:02.418143	Neoma Hayes	76101 Ferry Parkways	Suite 924	\N	\N	Swaniawskiberg	Texas	53387-7750	112	37.7952266471061	-122.406422557078	\N	\N	\N	\N	\N
113	2025-12-04 04:24:02.458602	2025-12-04 04:24:02.458602	Sylvester Blanda	1088 Shakira Canyon	Suite 131	\N	\N	Parisianhaven	Washington	44770-9509	113	37.7920428281014	-122.400592696299	\N	\N	\N	\N	\N
114	2025-12-04 04:24:02.498006	2025-12-04 04:24:02.498006	Roland Leffler Sr.	3813 Roseline Mountain	Suite 151	\N	\N	Greenholtville	Michigan	67840-0346	114	37.7825908799088	-122.409416782893	\N	\N	\N	\N	\N
115	2025-12-04 04:24:02.541772	2025-12-04 04:24:02.541772	Rubin Huel	485 Romaguera Flats	Suite 764	\N	\N	Port Tynishafort	Montana	04940-7723	115	37.799443773959	-122.405037380018	\N	\N	\N	\N	\N
116	2025-12-04 04:24:02.569932	2025-12-04 04:24:02.569932	Hobert Powlowski	8316 Rodrick Keys	Suite 728	\N	\N	Scottfurt	Arizona	89156	116	37.793889385241	-122.400125598408	\N	\N	\N	\N	\N
117	2025-12-04 04:24:02.608262	2025-12-04 04:24:02.608262	Neida Ferry	283 Towanda Drive	Suite 729	\N	\N	South Perry	Georgia	61683	117	37.7883346385266	-122.40319477421	\N	\N	\N	\N	\N
118	2025-12-04 04:24:02.632361	2025-12-04 04:24:02.632361	Ping Reichert	72405 Cassin Brooks	Suite 692	\N	\N	West Derick	South Carolina	87202	118	37.7858290925826	-122.399411215273	\N	\N	\N	\N	\N
119	2025-12-04 04:24:02.661931	2025-12-04 04:24:02.661931	Jeana Wyman	494 Cherelle Walk	Apt. 579	\N	\N	North Grazyna	Kentucky	67490	119	37.7912721208007	-122.395168648084	\N	\N	\N	\N	\N
120	2025-12-04 04:24:02.709216	2025-12-04 04:24:02.709216	Elidia Schowalter	2429 Tran Throughway	Apt. 800	\N	\N	Port Benport	Washington	84551-9590	120	37.7978143912373	-122.404418168521	\N	\N	\N	\N	\N
121	2025-12-04 04:24:02.73909	2025-12-04 04:24:02.73909	Luis Johnson	170 Ismael Loaf	Suite 936	\N	\N	Yingstad	North Carolina	19877	121	37.7943802148428	-122.408020980441	\N	\N	\N	\N	\N
122	2025-12-04 04:24:02.763002	2025-12-04 04:24:02.763002	Luetta Hirthe	9504 Theola Orchard	Suite 983	\N	\N	West Jed	Nevada	06837-8403	122	37.7980170512065	-122.4089951414	\N	\N	\N	\N	\N
123	2025-12-04 04:24:02.792222	2025-12-04 04:24:02.792222	Miss Bo Harvey	872 Jacqualine Walks	Suite 763	\N	\N	Huelton	North Dakota	63288	123	37.7880433190748	-122.403064038059	\N	\N	\N	\N	\N
124	2025-12-04 04:24:02.822573	2025-12-04 04:24:02.822573	Lucille Streich	799 Ofelia Overpass	Suite 669	\N	\N	North Britney	Vermont	51516-6071	124	37.7858884979781	-122.391076585449	\N	\N	\N	\N	\N
125	2025-12-04 04:24:02.862975	2025-12-04 04:24:02.862975	Shani Haag III	6470 Wiegand Camp	Apt. 603	\N	\N	North Jackberg	Missouri	59899-8606	125	37.7803986189121	-122.404625199781	\N	\N	\N	\N	\N
126	2025-12-04 04:24:02.892001	2025-12-04 04:24:02.892001	Ahmad Runolfsson	9602 Morissette Rapids	Suite 843	\N	\N	South Donnetteburgh	Oklahoma	38765-5220	126	37.7891643206328	-122.407522134806	\N	\N	\N	\N	\N
127	2025-12-04 04:24:02.93436	2025-12-04 04:24:02.93436	Brooks Will	99743 Arlene Viaduct	Apt. 732	\N	\N	West Javierchester	Kentucky	01955-2682	127	37.7984054713026	-122.405535134284	\N	\N	\N	\N	\N
128	2025-12-04 04:24:02.964729	2025-12-04 04:24:02.964729	Benny Mills	205 Xavier Estates	Suite 281	\N	\N	New Stephaniview	Florida	69215-4925	128	37.7897476834714	-122.408148147713	\N	\N	\N	\N	\N
129	2025-12-04 04:24:03.002327	2025-12-04 04:24:03.002327	Cherly Reilly	28415 Hilll Rest	Apt. 717	\N	\N	Kozeybury	South Carolina	33466-8466	129	37.7922449493382	-122.405958710859	\N	\N	\N	\N	\N
130	2025-12-04 04:24:03.044959	2025-12-04 04:24:03.044959	Dong Powlowski	876 Nikia Throughway	Suite 750	\N	\N	Lubowitzstad	Maryland	85377	130	37.7929391185613	-122.403159480401	\N	\N	\N	\N	\N
131	2025-12-04 04:24:03.070017	2025-12-04 04:24:03.070017	Amb. Sean Franecki	9285 Braun Track	Suite 169	\N	\N	Sanfordhaven	West Virginia	25371	131	37.7912764976661	-122.397725381441	\N	\N	\N	\N	\N
132	2025-12-04 04:24:03.097433	2025-12-04 04:24:03.097433	Ashlie Jacobson Sr.	7960 Robel Square	Suite 497	\N	\N	North Charlie	Arizona	13100-0360	132	37.7868464151545	-122.402082503732	\N	\N	\N	\N	\N
133	2025-12-04 04:24:03.124951	2025-12-04 04:24:03.124951	Ms. Jeffery Towne	9247 Keneth Village	Suite 122	\N	\N	South Earlean	Arkansas	55045-2210	133	37.7872924324546	-122.402722704195	\N	\N	\N	\N	\N
134	2025-12-04 04:24:03.148896	2025-12-04 04:24:03.148896	Steven Hilll MD	4053 Upton Expressway	Suite 802	\N	\N	East Ludie	Iowa	47139-7603	134	37.7880940186794	-122.393551059889	\N	\N	\N	\N	\N
135	2025-12-04 04:24:03.174003	2025-12-04 04:24:03.174003	Mike Carter	2349 Tillman Forge	Suite 272	\N	\N	South Maurice	Kansas	31828-2308	135	37.7891059078522	-122.405274136216	\N	\N	\N	\N	\N
136	2025-12-04 04:24:03.197958	2025-12-04 04:24:03.197958	Lorene Bartell Ret.	98765 Kaycee Shoal	Apt. 984	\N	\N	Corneliusfort	Alabama	13997	136	37.7810607828307	-122.406913234328	\N	\N	\N	\N	\N
137	2025-12-04 04:24:03.230041	2025-12-04 04:24:03.230041	Kimbery Morar	80567 Augustus Street	Apt. 620	\N	\N	Wildermanstad	Oregon	94018	137	37.798081178346	-122.406259296942	\N	\N	\N	\N	\N
138	2025-12-04 04:24:03.274044	2025-12-04 04:24:03.274044	Scarlet Stamm	10920 Ferry Drive	Suite 784	\N	\N	Derrickmouth	Pennsylvania	24457	138	37.7946909839126	-122.390956721004	\N	\N	\N	\N	\N
139	2025-12-04 04:24:03.314538	2025-12-04 04:24:03.314538	Shannon Kreiger	82309 Watsica Mountains	Suite 117	\N	\N	West Sylvester	Colorado	64885	139	37.7886681442349	-122.40684997139	\N	\N	\N	\N	\N
140	2025-12-04 04:24:03.35805	2025-12-04 04:24:03.35805	Luz MacGyver	1878 Shields Camp	Apt. 387	\N	\N	West Genaro	Colorado	25158-1238	140	37.7808333596686	-122.403105887563	\N	\N	\N	\N	\N
141	2025-12-04 04:24:03.384394	2025-12-04 04:24:03.384394	Romaine Mills	378 Trista Mountains	Apt. 210	\N	\N	Port Nakiamouth	Rhode Island	80893	141	37.7985102403373	-122.402322132446	\N	\N	\N	\N	\N
142	2025-12-04 04:24:03.426421	2025-12-04 04:24:03.426421	Jamal Dickens	18076 Nader Courts	Apt. 629	\N	\N	Lake Fredfurt	Idaho	13564	142	37.7933491706451	-122.392905735416	\N	\N	\N	\N	\N
143	2025-12-04 04:24:03.454938	2025-12-04 04:24:03.454938	Leonila Pacocha	7553 Littel Corner	Suite 230	\N	\N	Aidefurt	South Dakota	37709	143	37.7927558155111	-122.399941332868	\N	\N	\N	\N	\N
144	2025-12-04 04:24:03.494793	2025-12-04 04:24:03.494793	Emogene Dach	5640 Guy Light	Suite 589	\N	\N	Champlinview	Hawaii	57413	144	37.7972114852	-122.393026585141	\N	\N	\N	\N	\N
145	2025-12-04 04:24:03.522418	2025-12-04 04:24:03.522418	Brian Mueller	9063 Mante Turnpike	Suite 439	\N	\N	South Jesenia	Washington	13542-9111	145	37.7879057721017	-122.395995900218	\N	\N	\N	\N	\N
146	2025-12-04 04:24:03.565588	2025-12-04 04:24:03.565588	Amb. Michaela Kub	7292 Helena Cape	Suite 973	\N	\N	Satterfieldfurt	New Jersey	62744	146	37.7856407382658	-122.401178971906	\N	\N	\N	\N	\N
147	2025-12-04 04:24:03.59407	2025-12-04 04:24:03.59407	Mrs. Robt Kulas	7218 Klocko Ferry	Suite 433	\N	\N	Aufderharchester	Louisiana	35760	147	37.7851387560962	-122.392318411613	\N	\N	\N	\N	\N
148	2025-12-04 04:24:03.633735	2025-12-04 04:24:03.633735	Clifford Oberbrunner	24108 Cummerata Walks	Suite 348	\N	\N	Corwinburgh	Connecticut	22616	148	37.7803270539511	-122.407002354233	\N	\N	\N	\N	\N
149	2025-12-04 04:24:03.660833	2025-12-04 04:24:03.660833	Ms. Robert Herman	9425 Jude Lights	Suite 984	\N	\N	South Jana	Idaho	02731-4166	149	37.7959467954528	-122.394698815767	\N	\N	\N	\N	\N
150	2025-12-04 04:24:04.017499	2025-12-04 04:24:04.017499	Fred Wintheiser	999 Billy Coves	Suite 406	\N	\N	West Claudeland	Maryland	99140-1894	150	37.7892530097776	-122.405749246637	\N	\N	\N	\N	\N
151	2025-12-04 04:24:04.038303	2025-12-04 04:24:04.038303	Jay Harvey	3805 Cherish Hills	Suite 551	\N	\N	Sylviemouth	Illinois	19849	151	37.7825928345582	-122.407199665834	\N	\N	\N	\N	\N
152	2025-12-04 04:24:04.058901	2025-12-04 04:24:04.058901	Josef Medhurst	314 Rochelle Estate	Suite 911	\N	\N	Goyetteport	Kentucky	55868	152	37.7981998443254	-122.393985188924	\N	\N	\N	\N	\N
153	2025-12-04 04:24:04.094239	2025-12-04 04:24:04.094239	Hildegarde Dickinson	6253 Haywood Ways	Suite 780	\N	\N	Lake Mikiview	Montana	96218	153	37.7996494788417	-122.398132300026	\N	\N	\N	\N	\N
154	2025-12-04 04:24:04.125978	2025-12-04 04:24:04.125978	Dr. Rudolph Cartwright	1043 Shanta Vista	Suite 682	\N	\N	Port Chi	Delaware	23225	154	37.7827088434238	-122.393182738256	\N	\N	\N	\N	\N
155	2025-12-04 04:24:04.160732	2025-12-04 04:24:04.160732	Versie Botsford II	843 Kunde Glen	Apt. 530	\N	\N	Elfredatown	Massachusetts	66645	155	37.799797515477	-122.396904955777	\N	\N	\N	\N	\N
156	2025-12-04 04:24:04.184313	2025-12-04 04:24:04.184313	Normand Barton	93593 Rick Way	Suite 524	\N	\N	Lake Mitziemouth	Virginia	62947	156	37.790093763754	-122.408137682352	\N	\N	\N	\N	\N
157	2025-12-04 04:24:04.210128	2025-12-04 04:24:04.210128	Mozelle Kemmer	8475 Jacobson Vista	Suite 745	\N	\N	Dainahaven	Louisiana	94254	157	37.7909520711427	-122.403730453817	\N	\N	\N	\N	\N
158	2025-12-04 04:24:04.234886	2025-12-04 04:24:04.234886	Angelita Gibson	844 Ryan Pike	Apt. 454	\N	\N	Monahanport	Kansas	50579-9264	158	37.7853663131711	-122.394834324586	\N	\N	\N	\N	\N
159	2025-12-04 04:24:04.259191	2025-12-04 04:24:04.259191	Tamera Runolfsdottir	566 Josue Forge	Suite 139	\N	\N	Lake Ellenatown	Maryland	86756	159	37.793451146127	-122.40865980799	\N	\N	\N	\N	\N
160	2025-12-04 04:24:04.281253	2025-12-04 04:24:04.281253	Shelby Waelchi	75474 Spencer Ridges	Apt. 501	\N	\N	Careymouth	Illinois	29043	160	37.7986272121847	-122.399672703437	\N	\N	\N	\N	\N
161	2025-12-04 04:24:04.306919	2025-12-04 04:24:04.306919	Augustine Hodkiewicz	42077 Levi Corner	Suite 707	\N	\N	Sipesview	North Carolina	94891-9861	161	37.7864191723798	-122.392843503901	\N	\N	\N	\N	\N
162	2025-12-04 04:24:04.332715	2025-12-04 04:24:04.332715	Coy Kutch V	726 Bradley Stravenue	Suite 667	\N	\N	Wallacemouth	Idaho	15817	162	37.794958896026	-122.401605879736	\N	\N	\N	\N	\N
163	2025-12-04 04:24:04.35958	2025-12-04 04:24:04.35958	Derick Keeling	3884 DuBuque Park	Suite 648	\N	\N	Wuckertmouth	New Mexico	62982-2016	163	37.7855013699004	-122.394526091164	\N	\N	\N	\N	\N
164	2025-12-04 04:24:04.385669	2025-12-04 04:24:04.385669	Gov. Mauro Gleichner	5816 Nick Lodge	Suite 646	\N	\N	Emmerichport	Illinois	58601-5394	164	37.7948172972095	-122.402142221117	\N	\N	\N	\N	\N
165	2025-12-04 04:24:04.410248	2025-12-04 04:24:04.410248	Cyril Fisher	9918 Ollie Stravenue	Apt. 604	\N	\N	Indiraton	Colorado	22281-8059	165	37.793506800233	-122.406700017866	\N	\N	\N	\N	\N
166	2025-12-04 04:24:04.436504	2025-12-04 04:24:04.436504	Rep. Douglass Zieme	88170 Daniel Route	Apt. 995	\N	\N	Port Geraldo	Kentucky	06758-6050	166	37.7876798835285	-122.400700779083	\N	\N	\N	\N	\N
167	2025-12-04 04:24:04.461353	2025-12-04 04:24:04.461353	Isaac Kuphal	417 Launa Unions	Suite 985	\N	\N	Braunfort	New Hampshire	73596	167	37.7969736235347	-122.39696394799	\N	\N	\N	\N	\N
168	2025-12-04 04:24:04.485778	2025-12-04 04:24:04.485778	Mac Bartell	81806 Wilber Wells	Suite 186	\N	\N	Chiton	Delaware	79315-3273	168	37.7961668735029	-122.405890997311	\N	\N	\N	\N	\N
169	2025-12-04 04:24:04.511913	2025-12-04 04:24:04.511913	Miss Cassandra Stroman	53678 Cole Port	Apt. 387	\N	\N	Powlowskishire	Illinois	10633	169	37.7979663005579	-122.406838500422	\N	\N	\N	\N	\N
170	2025-12-04 04:24:04.538241	2025-12-04 04:24:04.538241	Milton Ferry	415 Newton Road	Suite 652	\N	\N	Marvinfurt	New Jersey	91969-0743	170	37.7813262393195	-122.398189556819	\N	\N	\N	\N	\N
171	2025-12-04 04:24:04.56074	2025-12-04 04:24:04.56074	Delpha Farrell	9335 Monahan Glens	Apt. 169	\N	\N	Hellerport	Connecticut	92181-0432	171	37.7834864099927	-122.392854658838	\N	\N	\N	\N	\N
172	2025-12-04 04:24:04.586051	2025-12-04 04:24:04.586051	Msgr. Aileen Mante	5088 Charlesetta Glens	Suite 761	\N	\N	East Jay	Idaho	26443	172	37.7983318140271	-122.395065855017	\N	\N	\N	\N	\N
173	2025-12-04 04:24:04.611715	2025-12-04 04:24:04.611715	Loraine Anderson DC	172 Weber Track	Suite 103	\N	\N	Lake Vincenzofurt	Florida	75904	173	37.7843851387898	-122.403118410183	\N	\N	\N	\N	\N
174	2025-12-04 04:24:04.636068	2025-12-04 04:24:04.636068	Rev. Jamel Erdman	71444 Goldner Lodge	Apt. 576	\N	\N	East Kimmouth	Idaho	98563	174	37.7993404752504	-122.391137988878	\N	\N	\N	\N	\N
175	2025-12-04 04:24:04.662014	2025-12-04 04:24:04.662014	Sen. Valene Rau	73542 Bogisich Spur	Suite 625	\N	\N	Porterfurt	Ohio	66673	175	37.784423219513	-122.39863058339	\N	\N	\N	\N	\N
176	2025-12-04 04:24:04.682324	2025-12-04 04:24:04.682324	The Hon. Henry Huels	1236 Sporer Run	Apt. 684	\N	\N	Shaniquaberg	North Carolina	52644-2833	176	37.7941535792746	-122.4075239387	\N	\N	\N	\N	\N
177	2025-12-04 04:24:04.708834	2025-12-04 04:24:04.708834	Sherice Graham	49429 Casper Spring	Suite 671	\N	\N	Demetricetown	Wyoming	89057	177	37.7985921126881	-122.402197306846	\N	\N	\N	\N	\N
178	2025-12-04 04:24:04.734045	2025-12-04 04:24:04.734045	Kymberly Berge V	2907 Rau Radial	Apt. 150	\N	\N	Lake Rashad	Connecticut	47124	178	37.7897494246947	-122.39758056455	\N	\N	\N	\N	\N
179	2025-12-04 04:24:04.755962	2025-12-04 04:24:04.755962	Michaela Roberts	20704 Sabine Parkway	Suite 202	\N	\N	Blakeberg	Oklahoma	54341	179	37.7818410772003	-122.39036969231	\N	\N	\N	\N	\N
180	2025-12-04 04:24:04.779686	2025-12-04 04:24:04.779686	Arianne Abernathy	750 Beer Burgs	Apt. 603	\N	\N	East Diegomouth	Pennsylvania	38427-8625	180	37.7981011033531	-122.397807489018	\N	\N	\N	\N	\N
181	2025-12-04 04:24:04.802539	2025-12-04 04:24:04.802539	Felisha Runolfsdottir	65004 German Burgs	Suite 833	\N	\N	North Bufordbury	Alaska	95556	181	37.7979416373089	-122.392439313399	\N	\N	\N	\N	\N
182	2025-12-04 04:24:04.827085	2025-12-04 04:24:04.827085	Cindie Doyle	5610 Nestor Greens	Suite 751	\N	\N	Botsfordfort	New Hampshire	68025	182	37.7857761617907	-122.397875958722	\N	\N	\N	\N	\N
183	2025-12-04 04:24:04.851031	2025-12-04 04:24:04.851031	Steve Muller	171 Charline Streets	Apt. 874	\N	\N	Schaeferstad	Delaware	08632	183	37.787107517432	-122.397861056658	\N	\N	\N	\N	\N
184	2025-12-04 04:24:04.876932	2025-12-04 04:24:04.876932	Msgr. Wilburn Lindgren	1995 Stokes Cliff	Apt. 881	\N	\N	Gislasonland	North Dakota	53692	184	37.7961303283668	-122.409170913016	\N	\N	\N	\N	\N
185	2025-12-04 04:24:04.902038	2025-12-04 04:24:04.902038	Norberto Denesik	9938 Eleonor Stream	Apt. 231	\N	\N	Kautzerside	Louisiana	21855	185	37.798455391102	-122.396101737106	\N	\N	\N	\N	\N
186	2025-12-04 04:24:04.926354	2025-12-04 04:24:04.926354	Maryrose Wehner	886 Kohler Skyway	Apt. 199	\N	\N	North Austin	Oregon	28812	186	37.7974592988213	-122.404346278521	\N	\N	\N	\N	\N
187	2025-12-04 04:24:04.952274	2025-12-04 04:24:04.952274	Leonardo Dickens	413 Hirthe Port	Apt. 453	\N	\N	East Cortez	South Dakota	96249	187	37.7971339484337	-122.401818775748	\N	\N	\N	\N	\N
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
environment	development	2025-12-04 04:23:57.840095	2025-12-04 04:23:57.840095
schema_sha1	201bc84a83779683ca113e81f5dfefab0046f254	2025-12-04 04:23:57.841898	2025-12-04 04:23:57.841898
\.


--
-- Data for Name: bookmarks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bookmarks (id, "order", folder_id, service_id, created_at, updated_at, resource_id, user_id, name) FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, created_at, updated_at, name, top_level, vocabulary, featured) FROM stdin;
2	2025-12-04 04:23:57.989403	2025-12-04 04:23:57.989403	Immediate Safety	f	\N	f
3	2025-12-04 04:23:57.990094	2025-12-04 04:23:57.990094	Help Escape Violence	f	\N	f
4	2025-12-04 04:23:57.990734	2025-12-04 04:23:57.990734	Psychiatric Emergency Services	f	\N	f
6	2025-12-04 04:23:57.992	2025-12-04 04:23:57.992	Food Delivery	f	\N	f
7	2025-12-04 04:23:57.992657	2025-12-04 04:23:57.992657	Food Pantry	f	\N	f
8	2025-12-04 04:23:57.993315	2025-12-04 04:23:57.993315	Free Meals	f	\N	f
9	2025-12-04 04:23:57.993941	2025-12-04 04:23:57.993941	Food Benefits	f	\N	f
10	2025-12-04 04:23:57.994563	2025-12-04 04:23:57.994563	Help Pay for Food	f	\N	f
13	2025-12-04 04:23:57.996423	2025-12-04 04:23:57.996423	Help Pay For Housing	f	\N	f
14	2025-12-04 04:23:57.997103	2025-12-04 04:23:57.997103	Help Pay for Housing	f	\N	f
15	2025-12-04 04:23:57.997738	2025-12-04 04:23:57.997738	Help Pay for Utilities	f	\N	f
16	2025-12-04 04:23:57.998644	2025-12-04 04:23:57.998644	Help Pay for Internet or Phone	f	\N	f
17	2025-12-04 04:23:57.999302	2025-12-04 04:23:57.999302	Home & Renters Insurance	f	\N	f
18	2025-12-04 04:23:57.999951	2025-12-04 04:23:57.999951	Housing Vouchers	f	\N	f
19	2025-12-04 04:23:58.000594	2025-12-04 04:23:58.000594	Long-Term Housing	f	\N	f
20	2025-12-04 04:23:58.001265	2025-12-04 04:23:58.001265	Assisted Living	f	\N	f
21	2025-12-04 04:23:58.002011	2025-12-04 04:23:58.002011	Independent Living	f	\N	f
22	2025-12-04 04:23:58.002619	2025-12-04 04:23:58.002619	Nursing Home	f	\N	f
23	2025-12-04 04:23:58.003251	2025-12-04 04:23:58.003251	Public Housing	f	\N	f
24	2025-12-04 04:23:58.003846	2025-12-04 04:23:58.003846	Safe Housing	f	\N	f
25	2025-12-04 04:23:58.004428	2025-12-04 04:23:58.004428	Short-Term Housing	f	\N	f
26	2025-12-04 04:23:58.005148	2025-12-04 04:23:58.005148	Sober Living	f	\N	f
28	2025-12-04 04:23:58.006377	2025-12-04 04:23:58.006377	Clothes for School	f	\N	f
29	2025-12-04 04:23:58.007005	2025-12-04 04:23:58.007005	Clothes for Work	f	\N	f
30	2025-12-04 04:23:58.007624	2025-12-04 04:23:58.007624	Clothing Vouchers	f	\N	f
31	2025-12-04 04:23:58.008261	2025-12-04 04:23:58.008261	Home Goods	f	\N	f
32	2025-12-04 04:23:58.008839	2025-12-04 04:23:58.008839	Medical Supplies	f	\N	f
33	2025-12-04 04:23:58.009561	2025-12-04 04:23:58.009561	Personal Safety	f	\N	f
35	2025-12-04 04:23:58.010839	2025-12-04 04:23:58.010839	Bus Passes	f	\N	f
36	2025-12-04 04:23:58.011504	2025-12-04 04:23:58.011504	Help Pay for Transit	f	\N	f
38	2025-12-04 04:23:58.0128	2025-12-04 04:23:58.0128	Addiction & Recovery	f	\N	f
39	2025-12-04 04:23:58.013433	2025-12-04 04:23:58.013433	Dental Care	f	\N	f
40	2025-12-04 04:23:58.01408	2025-12-04 04:23:58.01408	Health Education	f	\N	f
41	2025-12-04 04:23:58.014721	2025-12-04 04:23:58.014721	Daily Life Skills	f	\N	f
42	2025-12-04 04:23:58.015342	2025-12-04 04:23:58.015342	Disease Management	f	\N	f
43	2025-12-04 04:23:58.015965	2025-12-04 04:23:58.015965	Family Planning	f	\N	f
44	2025-12-04 04:23:58.016582	2025-12-04 04:23:58.016582	Nutrition Education	f	\N	f
45	2025-12-04 04:23:58.017232	2025-12-04 04:23:58.017232	Parenting Education	f	\N	f
46	2025-12-04 04:23:58.017857	2025-12-04 04:23:58.017857	Sex Education	f	\N	f
47	2025-12-04 04:23:58.018478	2025-12-04 04:23:58.018478	Understand Disability	f	\N	f
48	2025-12-04 04:23:58.019106	2025-12-04 04:23:58.019106	Understand Mental Health	f	\N	f
49	2025-12-04 04:23:58.019717	2025-12-04 04:23:58.019717	Help Pay for Healthcare	f	\N	f
50	2025-12-04 04:23:58.020317	2025-12-04 04:23:58.020317	Disability Benefits	f	\N	f
51	2025-12-04 04:23:58.020937	2025-12-04 04:23:58.020937	Discounted Healthcare	f	\N	f
52	2025-12-04 04:23:58.021573	2025-12-04 04:23:58.021573	Health Insurance	f	\N	f
53	2025-12-04 04:23:58.022202	2025-12-04 04:23:58.022202	Prescription Assistance	f	\N	f
54	2025-12-04 04:23:58.022834	2025-12-04 04:23:58.022834	Transportation for Healthcare	f	\N	f
55	2025-12-04 04:23:58.023447	2025-12-04 04:23:58.023447	Medical Care	f	\N	f
56	2025-12-04 04:23:58.024068	2025-12-04 04:23:58.024068	Primary Care	f	\N	f
57	2025-12-04 04:23:58.024722	2025-12-04 04:23:58.024722	Birth Control	f	\N	f
58	2025-12-04 04:23:58.025332	2025-12-04 04:23:58.025332	Checkup & Test	f	\N	f
59	2025-12-04 04:23:58.025974	2025-12-04 04:23:58.025974	Disability Screening	f	\N	f
60	2025-12-04 04:23:58.026609	2025-12-04 04:23:58.026609	Disease Screening	f	\N	f
61	2025-12-04 04:23:58.027221	2025-12-04 04:23:58.027221	Hearing Tests	f	\N	f
62	2025-12-04 04:23:58.027832	2025-12-04 04:23:58.027832	Mental Health Evaluation	f	\N	f
63	2025-12-04 04:23:58.028453	2025-12-04 04:23:58.028453	Pregnancy Tests	f	\N	f
64	2025-12-04 04:23:58.029056	2025-12-04 04:23:58.029056	Fertility	f	\N	f
65	2025-12-04 04:23:58.029648	2025-12-04 04:23:58.029648	Maternity Care	f	\N	f
66	2025-12-04 04:23:58.030261	2025-12-04 04:23:58.030261	Personal Hygiene	f	\N	f
67	2025-12-04 04:23:58.030843	2025-12-04 04:23:58.030843	Postnatal Care	f	\N	f
68	2025-12-04 04:23:58.031423	2025-12-04 04:23:58.031423	Prevent & Treat	f	\N	f
69	2025-12-04 04:23:58.032026	2025-12-04 04:23:58.032026	Counseling	f	\N	f
70	2025-12-04 04:23:58.032645	2025-12-04 04:23:58.032645	HIV Treatment	f	\N	f
71	2025-12-04 04:23:58.033278	2025-12-04 04:23:58.033278	Pain Management	f	\N	f
72	2025-12-04 04:23:58.03391	2025-12-04 04:23:58.03391	Physical Therapy	f	\N	f
73	2025-12-04 04:23:58.034597	2025-12-04 04:23:58.034597	Specialized Therapy	f	\N	f
74	2025-12-04 04:23:58.035395	2025-12-04 04:23:58.035395	Vaccinations	f	\N	f
75	2025-12-04 04:23:58.036088	2025-12-04 04:23:58.036088	Mental Health Care	f	\N	f
76	2025-12-04 04:23:58.036787	2025-12-04 04:23:58.036787	Anger Management	f	\N	f
77	2025-12-04 04:23:58.037404	2025-12-04 04:23:58.037404	Bereavement	f	\N	f
78	2025-12-04 04:23:58.038077	2025-12-04 04:23:58.038077	Group Therapy	f	\N	f
79	2025-12-04 04:23:58.038758	2025-12-04 04:23:58.038758	Substance Abuse Counseling	f	\N	f
80	2025-12-04 04:23:58.039419	2025-12-04 04:23:58.039419	Family Counseling	f	\N	f
81	2025-12-04 04:23:58.040056	2025-12-04 04:23:58.040056	Individual Counseling	f	\N	f
82	2025-12-04 04:23:58.040711	2025-12-04 04:23:58.040711	Medicatons for Mental Health	f	\N	f
83	2025-12-04 04:23:58.041346	2025-12-04 04:23:58.041346	Drug Testing	f	\N	f
84	2025-12-04 04:23:58.041991	2025-12-04 04:23:58.041991	Hospice	f	\N	f
85	2025-12-04 04:23:58.042745	2025-12-04 04:23:58.042745	Vision Care	f	\N	f
87	2025-12-04 04:23:58.044229	2025-12-04 04:23:58.044229	Government Benefits	f	\N	f
88	2025-12-04 04:23:58.04487	2025-12-04 04:23:58.04487	Retirement Benefits	f	\N	f
89	2025-12-04 04:23:58.045585	2025-12-04 04:23:58.045585	Understand Government Programs	f	\N	f
90	2025-12-04 04:23:58.046253	2025-12-04 04:23:58.046253	Unemployment Benefits	f	\N	f
91	2025-12-04 04:23:58.046924	2025-12-04 04:23:58.046924	Financial Education	f	\N	f
92	2025-12-04 04:23:58.047579	2025-12-04 04:23:58.047579	Insurance	f	\N	f
93	2025-12-04 04:23:58.048259	2025-12-04 04:23:58.048259	Tax Preparation	f	\N	f
95	2025-12-04 04:23:58.049619	2025-12-04 04:23:58.049619	Daytime Care	f	\N	f
96	2025-12-04 04:23:58.050276	2025-12-04 04:23:58.050276	Adult Daycare	f	\N	f
97	2025-12-04 04:23:58.050941	2025-12-04 04:23:58.050941	After School Care	f	\N	f
98	2025-12-04 04:23:58.051585	2025-12-04 04:23:58.051585	Before School Care	f	\N	f
99	2025-12-04 04:23:58.052318	2025-12-04 04:23:58.052318	Childcare	f	\N	f
100	2025-12-04 04:23:58.052972	2025-12-04 04:23:58.052972	Help Find Childcare	f	\N	f
101	2025-12-04 04:23:58.053647	2025-12-04 04:23:58.053647	Help Pay for Childcare	f	\N	f
102	2025-12-04 04:23:58.054315	2025-12-04 04:23:58.054315	Day Camp	f	\N	f
103	2025-12-04 04:23:58.054977	2025-12-04 04:23:58.054977	Preschool	f	\N	f
104	2025-12-04 04:23:58.055662	2025-12-04 04:23:58.055662	Recreation	f	\N	f
105	2025-12-04 04:23:58.056365	2025-12-04 04:23:58.056365	Relief for Caregivers	f	\N	f
106	2025-12-04 04:23:58.057072	2025-12-04 04:23:58.057072	End-of-Life Care	f	\N	f
107	2025-12-04 04:23:58.057716	2025-12-04 04:23:58.057716	Navigating the System	f	\N	f
108	2025-12-04 04:23:58.058333	2025-12-04 04:23:58.058333	Help Fill out Forms	f	\N	f
109	2025-12-04 04:23:58.058989	2025-12-04 04:23:58.058989	Help Find Housing	f	\N	f
110	2025-12-04 04:23:58.059627	2025-12-04 04:23:58.059627	Help Find School	f	\N	f
5	2025-12-04 04:23:57.991361	2025-12-04 04:23:58.118601	Food	t	\N	f
27	2025-12-04 04:23:58.005773	2025-12-04 04:23:58.120115	Goods	t	\N	f
34	2025-12-04 04:23:58.010188	2025-12-04 04:23:58.120879	Transit	t	\N	f
37	2025-12-04 04:23:58.012138	2025-12-04 04:23:58.121791	Health	t	\N	f
86	2025-12-04 04:23:58.043485	2025-12-04 04:23:58.122541	Money	t	\N	f
94	2025-12-04 04:23:58.04893	2025-12-04 04:23:58.123453	Care	t	\N	f
11	2025-12-04 04:23:57.995233	2025-12-04 04:23:58.134287	Housing	t	\N	t
111	2025-12-04 04:23:58.060274	2025-12-04 04:23:58.060274	Help Find Work	f	\N	f
112	2025-12-04 04:23:58.061023	2025-12-04 04:23:58.061023	Support Network	f	\N	f
113	2025-12-04 04:23:58.061668	2025-12-04 04:23:58.061668	Help Hotlines	f	\N	f
114	2025-12-04 04:23:58.062352	2025-12-04 04:23:58.062352	Home Visiting	f	\N	f
115	2025-12-04 04:23:58.063025	2025-12-04 04:23:58.063025	In-Home Support	f	\N	f
116	2025-12-04 04:23:58.066482	2025-12-04 04:23:58.066482	Mentoring	f	\N	f
117	2025-12-04 04:23:58.067196	2025-12-04 04:23:58.067196	One-on-One Support	f	\N	f
118	2025-12-04 04:23:58.067831	2025-12-04 04:23:58.067831	Peer Support	f	\N	f
119	2025-12-04 04:23:58.068465	2025-12-04 04:23:58.068465	Spiritual Support	f	\N	f
120	2025-12-04 04:23:58.069105	2025-12-04 04:23:58.069105	Support Groups	f	\N	f
121	2025-12-04 04:23:58.069713	2025-12-04 04:23:58.069713	12-Step	f	\N	f
122	2025-12-04 04:23:58.070325	2025-12-04 04:23:58.070325	Virtual Support	f	\N	f
124	2025-12-04 04:23:58.071619	2025-12-04 04:23:58.071619	Help Pay for School	f	\N	f
125	2025-12-04 04:23:58.072233	2025-12-04 04:23:58.072233	Books	f	\N	f
126	2025-12-04 04:23:58.072875	2025-12-04 04:23:58.072875	Financial Aid & Loans	f	\N	f
127	2025-12-04 04:23:58.073504	2025-12-04 04:23:58.073504	Transportation for School	f	\N	f
128	2025-12-04 04:23:58.074127	2025-12-04 04:23:58.074127	Supplies for School	f	\N	f
129	2025-12-04 04:23:58.074769	2025-12-04 04:23:58.074769	More Education	f	\N	f
130	2025-12-04 04:23:58.075377	2025-12-04 04:23:58.075377	Alternative Education	f	\N	f
131	2025-12-04 04:23:58.07616	2025-12-04 04:23:58.07616	English as a Second Language (ESL)	f	\N	f
132	2025-12-04 04:23:58.076766	2025-12-04 04:23:58.076766	Foreign Languages	f	\N	f
133	2025-12-04 04:23:58.077351	2025-12-04 04:23:58.077351	GED/High-School Equivalency	f	\N	f
134	2025-12-04 04:23:58.077961	2025-12-04 04:23:58.077961	Supported Employment	f	\N	f
135	2025-12-04 04:23:58.078544	2025-12-04 04:23:58.078544	Special Education	f	\N	f
136	2025-12-04 04:23:58.079177	2025-12-04 04:23:58.079177	Tutoring	f	\N	f
137	2025-12-04 04:23:58.079772	2025-12-04 04:23:58.079772	Screening & Exams	f	\N	f
138	2025-12-04 04:23:58.080409	2025-12-04 04:23:58.080409	Citizenship & Immigration	f	\N	f
139	2025-12-04 04:23:58.080997	2025-12-04 04:23:58.080997	Skills & Training	f	\N	f
140	2025-12-04 04:23:58.081585	2025-12-04 04:23:58.081585	Basic Literacy	f	\N	f
141	2025-12-04 04:23:58.082201	2025-12-04 04:23:58.082201	Computer Class	f	\N	f
142	2025-12-04 04:23:58.082802	2025-12-04 04:23:58.082802	Interview Training	f	\N	f
143	2025-12-04 04:23:58.083431	2025-12-04 04:23:58.083431	Resume Development	f	\N	f
144	2025-12-04 04:23:58.08405	2025-12-04 04:23:58.08405	Skills Assessment	f	\N	f
145	2025-12-04 04:23:58.084709	2025-12-04 04:23:58.084709	Specialized Training	f	\N	f
147	2025-12-04 04:23:58.086012	2025-12-04 04:23:58.086012	Job Placement	f	\N	f
148	2025-12-04 04:23:58.086654	2025-12-04 04:23:58.086654	Help Pay for Work Expenses	f	\N	f
149	2025-12-04 04:23:58.087268	2025-12-04 04:23:58.087268	Workplace Rights	f	\N	f
151	2025-12-04 04:23:58.088448	2025-12-04 04:23:58.088448	Advocacy & Legal Aid	f	\N	f
152	2025-12-04 04:23:58.089054	2025-12-04 04:23:58.089054	Discrimination & Civil Rights	f	\N	f
153	2025-12-04 04:23:58.089626	2025-12-04 04:23:58.089626	Guardianship	f	\N	f
154	2025-12-04 04:23:58.090213	2025-12-04 04:23:58.090213	Identification Recovery	f	\N	f
155	2025-12-04 04:23:58.090801	2025-12-04 04:23:58.090801	Mediation	f	\N	f
156	2025-12-04 04:23:58.091407	2025-12-04 04:23:58.091407	Notary	f	\N	f
157	2025-12-04 04:23:58.092003	2025-12-04 04:23:58.092003	Representation	f	\N	f
158	2025-12-04 04:23:58.092622	2025-12-04 04:23:58.092622	Translation & Interpretation	f	\N	f
160	2025-12-04 04:23:58.093879	2025-12-04 04:23:58.093879	Hygiene	f	\N	f
161	2025-12-04 04:23:58.094474	2025-12-04 04:23:58.094474	Toilet	f	\N	f
162	2025-12-04 04:23:58.095095	2025-12-04 04:23:58.095095	Shower	f	\N	f
163	2025-12-04 04:23:58.095693	2025-12-04 04:23:58.095693	Hygiene Supplies	f	\N	f
164	2025-12-04 04:23:58.09628	2025-12-04 04:23:58.09628	Waste Disposal	f	\N	f
165	2025-12-04 04:23:58.096884	2025-12-04 04:23:58.096884	Water	f	\N	f
166	2025-12-04 04:23:58.097479	2025-12-04 04:23:58.097479	Storage	f	\N	f
167	2025-12-04 04:23:58.098081	2025-12-04 04:23:58.098081	Drug Related Services	f	\N	f
168	2025-12-04 04:23:58.098661	2025-12-04 04:23:58.098661	Government Homelessness Services	f	\N	f
169	2025-12-04 04:23:58.09924	2025-12-04 04:23:58.09924	Technology	f	\N	f
170	2025-12-04 04:23:58.099833	2025-12-04 04:23:58.099833	Wifi Access	f	\N	f
171	2025-12-04 04:23:58.10042	2025-12-04 04:23:58.10042	Computer Access	f	\N	f
172	2025-12-04 04:23:58.100988	2025-12-04 04:23:58.100988	Smartphones	f	\N	f
173	2025-12-04 04:23:58.101587	2025-12-04 04:23:58.101587	Family Shelters	f	\N	f
174	2025-12-04 04:23:58.10219	2025-12-04 04:23:58.10219	Domestic Violence Shelters	f	\N	f
176	2025-12-04 04:23:58.103394	2025-12-04 04:23:58.103394	Housing/Tenants Rights	f	\N	f
179	2025-12-04 04:23:58.105221	2025-12-04 04:23:58.105221	End of Life Care	f	\N	f
180	2025-12-04 04:23:58.105871	2025-12-04 04:23:58.105871	Home Delivered Meals	f	\N	f
181	2025-12-04 04:23:58.106495	2025-12-04 04:23:58.106495	Senior Centers	f	\N	f
182	2025-12-04 04:23:58.107093	2025-12-04 04:23:58.107093	Congregate Meals	f	\N	f
183	2025-12-04 04:23:58.107695	2025-12-04 04:23:58.107695	Housing Rights	f	\N	f
185	2025-12-04 04:23:58.108934	2025-12-04 04:23:58.108934	Legal Representation	f	\N	f
187	2025-12-04 04:23:58.110253	2025-12-04 04:23:58.110253	Legal Services	f	\N	f
188	2025-12-04 04:23:58.11083	2025-12-04 04:23:58.11083	Domestic Violence Hotlines	f	\N	f
189	2025-12-04 04:23:58.11158	2025-12-04 04:23:58.11158	Re-entry Services	f	\N	f
190	2025-12-04 04:23:58.112174	2025-12-04 04:23:58.112174	Clean Slate	f	\N	f
191	2025-12-04 04:23:58.112778	2025-12-04 04:23:58.112778	Probation and Parole	f	\N	f
1	2025-12-04 04:23:57.988431	2025-12-04 04:23:58.117648	Emergency	t	\N	f
123	2025-12-04 04:23:58.070952	2025-12-04 04:23:58.124233	Education	t	\N	f
146	2025-12-04 04:23:58.085378	2025-12-04 04:23:58.124977	Work	t	\N	f
159	2025-12-04 04:23:58.093252	2025-12-04 04:23:58.126399	Homelessness Essentials	t	\N	f
177	2025-12-04 04:23:58.104033	2025-12-04 04:23:58.127098	Youth	t	\N	f
178	2025-12-04 04:23:58.104617	2025-12-04 04:23:58.127788	Seniors	t	\N	f
184	2025-12-04 04:23:58.108304	2025-12-04 04:23:58.128471	Domestic Violence	t	\N	f
186	2025-12-04 04:23:58.109614	2025-12-04 04:23:58.129225	Prison/Jail Related Services	t	\N	f
192	2025-12-04 04:23:58.113368	2025-12-04 04:23:58.129975	MOHCD Funded Services	t	\N	f
175	2025-12-04 04:23:58.102789	2025-12-04 04:23:58.130696	Eviction Defense	t	\N	f
12	2025-12-04 04:23:57.995842	2025-12-04 04:23:58.131441	Temporary Shelter	t	\N	f
196	2025-12-04 04:23:58.115772	2025-12-04 04:23:58.132182	sffamilies	t	\N	f
197	2025-12-04 04:23:58.116375	2025-12-04 04:23:58.132894	Covid Shelter	t	\N	f
193	2025-12-04 04:23:58.113967	2025-12-04 04:23:58.133583	Basic Needs & Shelter	f	\N	t
194	2025-12-04 04:23:58.114566	2025-12-04 04:23:58.134972	Health & Medical	f	\N	t
195	2025-12-04 04:23:58.115176	2025-12-04 04:23:58.13565	Employment	f	\N	t
150	2025-12-04 04:23:58.087856	2025-12-04 04:23:58.13645	Legal	t	\N	t
234	2025-12-04 04:24:03.657831	2025-12-04 04:24:03.657831	Test_Category_Top_Level	t	\N	f
1000001	2025-12-04 04:24:04.013124	2025-12-04 04:24:04.013124	Covid-food	f	\N	f
1000002	2025-12-04 04:24:04.121561	2025-12-04 04:24:04.121561	Covid-hygiene	f	\N	f
198	2025-12-04 04:24:04.122361	2025-12-04 04:24:04.122361	Portable Toilets and Hand-Washing Stations	f	\N	f
199	2025-12-04 04:24:04.157036	2025-12-04 04:24:04.157036	Hygiene kits	f	\N	f
200	2025-12-04 04:24:04.181056	2025-12-04 04:24:04.181056	Showers	f	\N	f
201	2025-12-04 04:24:04.206389	2025-12-04 04:24:04.206389	Laundry	f	\N	f
202	2025-12-04 04:24:04.231746	2025-12-04 04:24:04.231746	Clothing	f	\N	f
203	2025-12-04 04:24:04.255971	2025-12-04 04:24:04.255971	Diaper Bank	f	\N	f
1000003	2025-12-04 04:24:04.277395	2025-12-04 04:24:04.277395	Covid-finance	f	\N	f
204	2025-12-04 04:24:04.278054	2025-12-04 04:24:04.278054	Emergency Financial Assistance	f	\N	f
205	2025-12-04 04:24:04.303389	2025-12-04 04:24:04.303389	Financial Assistance for Living Expenses	f	\N	f
206	2025-12-04 04:24:04.32945	2025-12-04 04:24:04.32945	Unemployment Insurance-based Benefit Payments	f	\N	f
207	2025-12-04 04:24:04.356261	2025-12-04 04:24:04.356261	Job Assistance	f	\N	f
1000004	2025-12-04 04:24:04.381726	2025-12-04 04:24:04.381726	Covid-housing	f	\N	f
208	2025-12-04 04:24:04.382475	2025-12-04 04:24:04.382475	My landlord gave me an eviction notice and I need legal help	f	\N	f
209	2025-12-04 04:24:04.406876	2025-12-04 04:24:04.406876	My landlord told me I would get evicted and I need advice	f	\N	f
210	2025-12-04 04:24:04.433068	2025-12-04 04:24:04.433068	I have not been able to pay my rent and I do not know what to do	f	\N	f
211	2025-12-04 04:24:04.458255	2025-12-04 04:24:04.458255	I am not getting along with my neighbor(s) and /or my landlord and I need advice	f	\N	f
1000005	2025-12-04 04:24:04.481717	2025-12-04 04:24:04.481717	Covid-health	f	\N	f
212	2025-12-04 04:24:04.482461	2025-12-04 04:24:04.482461	Coronavirus (COVID-19) Testing	f	\N	f
213	2025-12-04 04:24:04.508553	2025-12-04 04:24:04.508553	Coronavirus-Related Urgent Care	f	\N	f
214	2025-12-04 04:24:04.53493	2025-12-04 04:24:04.53493	Other Medical Services	f	\N	f
215	2025-12-04 04:24:04.557511	2025-12-04 04:24:04.557511	Mental Health Urgent Care	f	\N	f
216	2025-12-04 04:24:04.582708	2025-12-04 04:24:04.582708	Other Mental Health Services	f	\N	f
1000006	2025-12-04 04:24:04.607614	2025-12-04 04:24:04.607614	Covid-domesticviolence	f	\N	f
217	2025-12-04 04:24:04.608318	2025-12-04 04:24:04.608318	Temporary Shelter for Women	f	\N	f
218	2025-12-04 04:24:04.632797	2025-12-04 04:24:04.632797	Transitional Housing for Women	f	\N	f
219	2025-12-04 04:24:04.658824	2025-12-04 04:24:04.658824	Legal Assistance	f	\N	f
220	2025-12-04 04:24:04.679031	2025-12-04 04:24:04.679031	Domestic Violence Counseling	f	\N	f
1000007	2025-12-04 04:24:04.702534	2025-12-04 04:24:04.702534	Covid-internet	f	\N	f
221	2025-12-04 04:24:04.703209	2025-12-04 04:24:04.703209	Computer and Internet Access	f	\N	f
222	2025-12-04 04:24:04.730851	2025-12-04 04:24:04.730851	Computer Classes	f	\N	f
223	2025-12-04 04:24:04.752759	2025-12-04 04:24:04.752759	Cell phone Services	f	\N	f
1000008	2025-12-04 04:24:04.775661	2025-12-04 04:24:04.775661	Covid-lgbtqa	f	\N	f
224	2025-12-04 04:24:04.776352	2025-12-04 04:24:04.776352	Housing Assistance	f	\N	f
225	2025-12-04 04:24:04.799053	2025-12-04 04:24:04.799053	Legal Assistance 	f	\N	f
226	2025-12-04 04:24:04.822945	2025-12-04 04:24:04.822945	Youth Services	f	\N	f
227	2025-12-04 04:24:04.847664	2025-12-04 04:24:04.847664	Counseling Assistance	f	\N	f
228	2025-12-04 04:24:04.873805	2025-12-04 04:24:04.873805	General Help	f	\N	f
1000010	2025-12-04 04:24:04.89772	2025-12-04 04:24:04.89772	Covid-shelter	f	\N	f
229	2025-12-04 04:24:04.898512	2025-12-04 04:24:04.898512	We are a family and we need shelter	f	\N	f
230	2025-12-04 04:24:04.923134	2025-12-04 04:24:04.923134	I am someone between 18-24 years old in need of shelter	f	\N	f
231	2025-12-04 04:24:04.949105	2025-12-04 04:24:04.949105	I am a single adult and I need shelter	f	\N	f
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
89	2
107	3
32	4
57	5
159	7
27	8
5	9
54	10
178	13
16	13
6	14
174	16
86	17
141	17
62	19
27	20
173	20
49	21
94	23
120	25
123	26
24	27
94	29
102	30
186	31
41	31
42	32
184	33
150	34
34	35
171	36
5	37
178	38
12	40
128	40
178	41
1	44
37	47
104	48
27	49
1	50
79	51
27	52
56	52
178	53
131	53
92	54
86	55
181	55
86	56
32	56
135	58
12	59
136	59
178	60
86	61
109	61
186	62
1	64
136	67
150	68
144	68
37	71
177	72
1	74
178	76
47	77
197	78
44	78
94	79
11	80
140	80
27	81
16	82
14	84
184	85
166	85
192	86
116	86
94	87
15	88
123	91
29	91
27	92
74	92
196	93
28	93
146	94
142	94
12	97
188	97
173	99
86	100
28	100
1	101
6	102
114	104
178	105
186	107
84	107
27	108
110	112
146	114
1	115
126	115
185	117
164	119
178	120
65	120
184	122
46	122
101	123
192	124
37	125
183	125
197	126
159	126
110	127
5	128
1	128
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
2	89	\N
3	89	\N
4	107	\N
5	107	\N
6	32	\N
7	57	\N
9	159	\N
10	27	\N
11	5	\N
12	54	\N
16	178	\N
16	16	\N
17	178	\N
17	16	\N
18	6	\N
20	174	\N
21	86	\N
21	141	\N
24	62	\N
25	62	\N
26	27	\N
26	173	\N
27	27	\N
27	173	\N
28	49	\N
29	49	\N
31	94	\N
33	120	\N
34	123	\N
35	24	\N
38	94	\N
39	94	\N
40	102	\N
41	186	\N
41	41	\N
42	186	\N
42	41	\N
43	42	\N
44	42	\N
45	184	\N
46	184	\N
48	34	\N
49	171	\N
50	5	\N
51	178	\N
54	12	\N
54	128	\N
55	178	\N
59	1	\N
63	37	\N
64	104	\N
65	27	\N
66	27	\N
67	1	\N
68	79	\N
69	79	\N
70	27	\N
70	56	\N
71	27	\N
71	56	\N
72	178	\N
72	131	\N
73	178	\N
73	131	\N
74	92	\N
75	86	\N
75	181	\N
76	86	\N
76	32	\N
79	135	\N
80	12	\N
80	136	\N
81	178	\N
82	86	\N
82	109	\N
83	86	\N
83	109	\N
84	186	\N
86	1	\N
90	136	\N
91	136	\N
92	144	\N
95	37	\N
96	37	\N
97	177	\N
100	1	\N
101	1	\N
103	178	\N
104	178	\N
105	47	\N
106	197	\N
106	44	\N
107	197	\N
107	44	\N
108	94	\N
109	94	\N
110	140	\N
111	140	\N
112	27	\N
113	16	\N
114	16	\N
117	14	\N
118	184	\N
118	166	\N
119	192	\N
119	116	\N
120	192	\N
120	116	\N
121	94	\N
122	94	\N
123	15	\N
124	15	\N
127	123	\N
127	29	\N
128	27	\N
128	74	\N
129	27	\N
129	74	\N
130	196	\N
130	28	\N
131	146	\N
131	142	\N
134	12	\N
134	188	\N
135	12	\N
135	188	\N
138	173	\N
139	173	\N
140	86	\N
140	28	\N
141	1	\N
142	1	\N
143	6	\N
145	114	\N
146	178	\N
147	178	\N
149	186	\N
149	84	\N
150	186	\N
150	84	\N
151	27	\N
152	27	\N
158	110	\N
159	110	\N
162	146	\N
163	146	\N
164	1	\N
164	126	\N
167	185	\N
169	164	\N
170	164	\N
171	178	\N
171	65	\N
173	184	\N
173	46	\N
174	101	\N
175	192	\N
176	192	\N
177	37	\N
177	183	\N
178	197	\N
178	159	\N
179	197	\N
179	159	\N
180	110	\N
181	5	\N
181	1	\N
182	11	\N
183	11	\N
184	11	\N
185	11	\N
186	11	\N
110	11	1
111	11	2
189	193	\N
190	193	\N
187	193	1
188	193	2
193	194	\N
191	194	1
192	194	2
92	150	2
194	194	\N
195	194	\N
196	194	\N
197	194	\N
200	195	\N
201	195	\N
202	195	\N
203	195	\N
198	195	1
199	195	2
204	150	\N
205	150	\N
206	150	\N
207	150	\N
208	150	\N
209	150	\N
47	150	1
210	234	\N
211	1000001	\N
212	1000001	\N
213	1000001	\N
214	1000001	\N
215	198	\N
215	1000002	\N
216	199	\N
216	1000002	\N
217	200	\N
217	1000002	\N
218	201	\N
218	1000002	\N
219	202	\N
219	1000002	\N
220	203	\N
220	1000002	\N
221	204	\N
221	1000003	\N
222	205	\N
222	1000003	\N
223	206	\N
223	1000003	\N
224	207	\N
224	1000003	\N
225	208	\N
225	1000004	\N
226	209	\N
226	1000004	\N
227	210	\N
227	1000004	\N
228	211	\N
228	1000004	\N
229	212	\N
229	1000005	\N
230	213	\N
230	1000005	\N
231	214	\N
231	1000005	\N
232	215	\N
232	1000005	\N
233	216	\N
233	1000005	\N
234	217	\N
234	1000006	\N
235	218	\N
235	1000006	\N
236	219	\N
236	1000006	\N
237	220	\N
237	1000006	\N
238	221	\N
238	1000007	\N
239	222	\N
239	1000007	\N
240	223	\N
240	1000007	\N
241	224	\N
241	1000008	\N
242	225	\N
242	1000008	\N
243	226	\N
243	1000008	\N
244	227	\N
244	1000008	\N
245	228	\N
245	1000008	\N
246	229	\N
246	1000010	\N
247	230	\N
247	1000010	\N
248	231	\N
248	1000010	\N
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
1	2025-12-04 04:23:58.762565	2025-12-04 04:23:58.762565	ResourceChangeRequest	1	0	1	\N
2	2025-12-04 04:23:58.801307	2025-12-04 04:23:58.801307	ResourceChangeRequest	2	0	1	\N
3	2025-12-04 04:23:58.817405	2025-12-04 04:23:58.817405	ResourceChangeRequest	2	0	1	\N
4	2025-12-04 04:23:58.841208	2025-12-04 04:23:58.841208	ResourceChangeRequest	3	0	1	\N
5	2025-12-04 04:23:58.852546	2025-12-04 04:23:58.852546	ResourceChangeRequest	3	0	1	\N
6	2025-12-04 04:23:58.877065	2025-12-04 04:23:58.877065	ResourceChangeRequest	4	0	1	\N
7	2025-12-04 04:23:58.902241	2025-12-04 04:23:58.902241	ResourceChangeRequest	5	0	1	\N
8	2025-12-04 04:23:58.929557	2025-12-04 04:23:58.929557	ResourceChangeRequest	6	0	1	\N
9	2025-12-04 04:23:58.956845	2025-12-04 04:23:58.956845	ResourceChangeRequest	7	0	1	\N
10	2025-12-04 04:23:58.982017	2025-12-04 04:23:58.982017	ResourceChangeRequest	8	0	1	\N
11	2025-12-04 04:23:59.006777	2025-12-04 04:23:59.006777	ResourceChangeRequest	9	0	1	\N
12	2025-12-04 04:23:59.035722	2025-12-04 04:23:59.035722	ResourceChangeRequest	10	0	1	\N
13	2025-12-04 04:23:59.058175	2025-12-04 04:23:59.058175	ResourceChangeRequest	11	0	1	\N
14	2025-12-04 04:23:59.070465	2025-12-04 04:23:59.070465	ResourceChangeRequest	11	0	1	\N
15	2025-12-04 04:23:59.092006	2025-12-04 04:23:59.092006	ResourceChangeRequest	12	0	1	\N
16	2025-12-04 04:23:59.117234	2025-12-04 04:23:59.117234	ResourceChangeRequest	13	0	1	\N
17	2025-12-04 04:23:59.129265	2025-12-04 04:23:59.129265	ResourceChangeRequest	13	0	1	\N
18	2025-12-04 04:23:59.153974	2025-12-04 04:23:59.153974	ResourceChangeRequest	14	0	1	\N
19	2025-12-04 04:23:59.177137	2025-12-04 04:23:59.177137	ResourceChangeRequest	15	0	1	\N
20	2025-12-04 04:23:59.202411	2025-12-04 04:23:59.202411	ResourceChangeRequest	16	0	1	\N
21	2025-12-04 04:23:59.229713	2025-12-04 04:23:59.229713	ResourceChangeRequest	17	0	1	\N
22	2025-12-04 04:23:59.2603	2025-12-04 04:23:59.2603	ResourceChangeRequest	18	0	1	\N
23	2025-12-04 04:23:59.272764	2025-12-04 04:23:59.272764	ResourceChangeRequest	18	0	1	\N
24	2025-12-04 04:23:59.29843	2025-12-04 04:23:59.29843	ResourceChangeRequest	19	0	1	\N
25	2025-12-04 04:23:59.310923	2025-12-04 04:23:59.310923	ResourceChangeRequest	19	0	1	\N
26	2025-12-04 04:23:59.341905	2025-12-04 04:23:59.341905	ResourceChangeRequest	20	0	1	\N
27	2025-12-04 04:23:59.356872	2025-12-04 04:23:59.356872	ResourceChangeRequest	20	0	1	\N
28	2025-12-04 04:23:59.384601	2025-12-04 04:23:59.384601	ResourceChangeRequest	21	0	1	\N
29	2025-12-04 04:23:59.397906	2025-12-04 04:23:59.397906	ResourceChangeRequest	21	0	1	\N
30	2025-12-04 04:23:59.425067	2025-12-04 04:23:59.425067	ResourceChangeRequest	22	0	1	\N
31	2025-12-04 04:23:59.453863	2025-12-04 04:23:59.453863	ResourceChangeRequest	23	0	1	\N
32	2025-12-04 04:23:59.483585	2025-12-04 04:23:59.483585	ResourceChangeRequest	24	0	1	\N
33	2025-12-04 04:23:59.51442	2025-12-04 04:23:59.51442	ResourceChangeRequest	25	0	1	\N
34	2025-12-04 04:23:59.54265	2025-12-04 04:23:59.54265	ResourceChangeRequest	26	0	1	\N
35	2025-12-04 04:23:59.570579	2025-12-04 04:23:59.570579	ResourceChangeRequest	27	0	1	\N
36	2025-12-04 04:23:59.593587	2025-12-04 04:23:59.593587	ResourceChangeRequest	28	0	1	\N
37	2025-12-04 04:23:59.60718	2025-12-04 04:23:59.60718	ResourceChangeRequest	28	0	1	\N
38	2025-12-04 04:23:59.636323	2025-12-04 04:23:59.636323	ResourceChangeRequest	29	0	1	\N
39	2025-12-04 04:23:59.648353	2025-12-04 04:23:59.648353	ResourceChangeRequest	29	0	1	\N
40	2025-12-04 04:23:59.675371	2025-12-04 04:23:59.675371	ResourceChangeRequest	30	0	1	\N
41	2025-12-04 04:23:59.703444	2025-12-04 04:23:59.703444	ResourceChangeRequest	31	0	1	\N
42	2025-12-04 04:23:59.715493	2025-12-04 04:23:59.715493	ResourceChangeRequest	31	0	1	\N
43	2025-12-04 04:23:59.74092	2025-12-04 04:23:59.74092	ResourceChangeRequest	32	0	1	\N
44	2025-12-04 04:23:59.75152	2025-12-04 04:23:59.75152	ResourceChangeRequest	32	0	1	\N
45	2025-12-04 04:23:59.780016	2025-12-04 04:23:59.780016	ResourceChangeRequest	33	0	1	\N
46	2025-12-04 04:23:59.791275	2025-12-04 04:23:59.791275	ResourceChangeRequest	33	0	1	\N
47	2025-12-04 04:23:59.817577	2025-12-04 04:23:59.817577	ResourceChangeRequest	34	0	1	\N
48	2025-12-04 04:23:59.84648	2025-12-04 04:23:59.84648	ResourceChangeRequest	35	0	1	\N
49	2025-12-04 04:23:59.875351	2025-12-04 04:23:59.875351	ResourceChangeRequest	36	0	1	\N
50	2025-12-04 04:23:59.905328	2025-12-04 04:23:59.905328	ResourceChangeRequest	37	0	1	\N
51	2025-12-04 04:23:59.930489	2025-12-04 04:23:59.930489	ResourceChangeRequest	38	0	1	\N
52	2025-12-04 04:23:59.960097	2025-12-04 04:23:59.960097	ResourceChangeRequest	39	0	1	\N
53	2025-12-04 04:23:59.975195	2025-12-04 04:23:59.975195	ResourceChangeRequest	39	0	1	\N
54	2025-12-04 04:24:00.010833	2025-12-04 04:24:00.010833	ResourceChangeRequest	40	0	1	\N
55	2025-12-04 04:24:00.039947	2025-12-04 04:24:00.039947	ResourceChangeRequest	41	0	1	\N
56	2025-12-04 04:24:00.065221	2025-12-04 04:24:00.065221	ResourceChangeRequest	42	0	1	\N
57	2025-12-04 04:24:00.093612	2025-12-04 04:24:00.093612	ResourceChangeRequest	43	0	1	\N
58	2025-12-04 04:24:00.106755	2025-12-04 04:24:00.106755	ResourceChangeRequest	43	0	1	\N
59	2025-12-04 04:24:00.135518	2025-12-04 04:24:00.135518	ResourceChangeRequest	44	0	1	\N
60	2025-12-04 04:24:00.159834	2025-12-04 04:24:00.159834	ResourceChangeRequest	45	0	1	\N
61	2025-12-04 04:24:00.17367	2025-12-04 04:24:00.17367	ResourceChangeRequest	45	0	1	\N
62	2025-12-04 04:24:00.202301	2025-12-04 04:24:00.202301	ResourceChangeRequest	46	0	1	\N
63	2025-12-04 04:24:00.229888	2025-12-04 04:24:00.229888	ResourceChangeRequest	47	0	1	\N
64	2025-12-04 04:24:00.258726	2025-12-04 04:24:00.258726	ResourceChangeRequest	48	0	1	\N
65	2025-12-04 04:24:00.284948	2025-12-04 04:24:00.284948	ResourceChangeRequest	49	0	1	\N
66	2025-12-04 04:24:00.298898	2025-12-04 04:24:00.298898	ResourceChangeRequest	49	0	1	\N
67	2025-12-04 04:24:00.322665	2025-12-04 04:24:00.322665	ResourceChangeRequest	50	0	1	\N
68	2025-12-04 04:24:00.350633	2025-12-04 04:24:00.350633	ResourceChangeRequest	51	0	1	\N
69	2025-12-04 04:24:00.364616	2025-12-04 04:24:00.364616	ResourceChangeRequest	51	0	1	\N
70	2025-12-04 04:24:00.390805	2025-12-04 04:24:00.390805	ResourceChangeRequest	52	0	1	\N
71	2025-12-04 04:24:00.404305	2025-12-04 04:24:00.404305	ResourceChangeRequest	52	0	1	\N
72	2025-12-04 04:24:00.429883	2025-12-04 04:24:00.429883	ResourceChangeRequest	53	0	1	\N
73	2025-12-04 04:24:00.442573	2025-12-04 04:24:00.442573	ResourceChangeRequest	53	0	1	\N
74	2025-12-04 04:24:00.469749	2025-12-04 04:24:00.469749	ResourceChangeRequest	54	0	1	\N
75	2025-12-04 04:24:00.499651	2025-12-04 04:24:00.499651	ResourceChangeRequest	55	0	1	\N
76	2025-12-04 04:24:00.52748	2025-12-04 04:24:00.52748	ResourceChangeRequest	56	0	1	\N
77	2025-12-04 04:24:00.555882	2025-12-04 04:24:00.555882	ResourceChangeRequest	57	0	1	\N
78	2025-12-04 04:24:00.568594	2025-12-04 04:24:00.568594	ResourceChangeRequest	57	0	1	\N
79	2025-12-04 04:24:00.597523	2025-12-04 04:24:00.597523	ResourceChangeRequest	58	0	1	\N
80	2025-12-04 04:24:00.627472	2025-12-04 04:24:00.627472	ResourceChangeRequest	59	0	1	\N
81	2025-12-04 04:24:00.655817	2025-12-04 04:24:00.655817	ResourceChangeRequest	60	0	1	\N
82	2025-12-04 04:24:00.684992	2025-12-04 04:24:00.684992	ResourceChangeRequest	61	0	1	\N
83	2025-12-04 04:24:00.699183	2025-12-04 04:24:00.699183	ResourceChangeRequest	61	0	1	\N
84	2025-12-04 04:24:00.727183	2025-12-04 04:24:00.727183	ResourceChangeRequest	62	0	1	\N
85	2025-12-04 04:24:00.753957	2025-12-04 04:24:00.753957	ResourceChangeRequest	63	0	1	\N
86	2025-12-04 04:24:00.783521	2025-12-04 04:24:00.783521	ResourceChangeRequest	64	0	1	\N
87	2025-12-04 04:24:00.814295	2025-12-04 04:24:00.814295	ResourceChangeRequest	65	0	1	\N
88	2025-12-04 04:24:00.827651	2025-12-04 04:24:00.827651	ResourceChangeRequest	65	0	1	\N
89	2025-12-04 04:24:00.856824	2025-12-04 04:24:00.856824	ResourceChangeRequest	66	0	1	\N
90	2025-12-04 04:24:00.88651	2025-12-04 04:24:00.88651	ResourceChangeRequest	67	0	1	\N
91	2025-12-04 04:24:00.899554	2025-12-04 04:24:00.899554	ResourceChangeRequest	67	0	1	\N
92	2025-12-04 04:24:00.925618	2025-12-04 04:24:00.925618	ResourceChangeRequest	68	0	1	\N
93	2025-12-04 04:24:00.952952	2025-12-04 04:24:00.952952	ResourceChangeRequest	69	0	1	\N
94	2025-12-04 04:24:00.976391	2025-12-04 04:24:00.976391	ResourceChangeRequest	70	0	1	\N
95	2025-12-04 04:24:01.003152	2025-12-04 04:24:01.003152	ResourceChangeRequest	71	0	1	\N
96	2025-12-04 04:24:01.019361	2025-12-04 04:24:01.019361	ResourceChangeRequest	71	0	1	\N
97	2025-12-04 04:24:01.045411	2025-12-04 04:24:01.045411	ResourceChangeRequest	72	0	1	\N
98	2025-12-04 04:24:01.069981	2025-12-04 04:24:01.069981	ResourceChangeRequest	73	0	1	\N
99	2025-12-04 04:24:01.084268	2025-12-04 04:24:01.084268	ResourceChangeRequest	73	0	1	\N
100	2025-12-04 04:24:01.109403	2025-12-04 04:24:01.109403	ResourceChangeRequest	74	0	1	\N
101	2025-12-04 04:24:01.122184	2025-12-04 04:24:01.122184	ResourceChangeRequest	74	0	1	\N
102	2025-12-04 04:24:01.148676	2025-12-04 04:24:01.148676	ResourceChangeRequest	75	0	1	\N
103	2025-12-04 04:24:01.176487	2025-12-04 04:24:01.176487	ResourceChangeRequest	76	0	1	\N
104	2025-12-04 04:24:01.191214	2025-12-04 04:24:01.191214	ResourceChangeRequest	76	0	1	\N
105	2025-12-04 04:24:01.218638	2025-12-04 04:24:01.218638	ResourceChangeRequest	77	0	1	\N
106	2025-12-04 04:24:01.243798	2025-12-04 04:24:01.243798	ResourceChangeRequest	78	0	1	\N
107	2025-12-04 04:24:01.260587	2025-12-04 04:24:01.260587	ResourceChangeRequest	78	0	1	\N
108	2025-12-04 04:24:01.286345	2025-12-04 04:24:01.286345	ResourceChangeRequest	79	0	1	\N
109	2025-12-04 04:24:01.300517	2025-12-04 04:24:01.300517	ResourceChangeRequest	79	0	1	\N
110	2025-12-04 04:24:01.330221	2025-12-04 04:24:01.330221	ResourceChangeRequest	80	0	1	\N
111	2025-12-04 04:24:01.344282	2025-12-04 04:24:01.344282	ResourceChangeRequest	80	0	1	\N
112	2025-12-04 04:24:01.36835	2025-12-04 04:24:01.36835	ResourceChangeRequest	81	0	1	\N
113	2025-12-04 04:24:01.39859	2025-12-04 04:24:01.39859	ResourceChangeRequest	82	0	1	\N
114	2025-12-04 04:24:01.415401	2025-12-04 04:24:01.415401	ResourceChangeRequest	82	0	1	\N
115	2025-12-04 04:24:01.439469	2025-12-04 04:24:01.439469	ResourceChangeRequest	83	0	1	\N
116	2025-12-04 04:24:01.457026	2025-12-04 04:24:01.457026	ResourceChangeRequest	83	0	1	\N
117	2025-12-04 04:24:01.485335	2025-12-04 04:24:01.485335	ResourceChangeRequest	84	0	1	\N
118	2025-12-04 04:24:01.512788	2025-12-04 04:24:01.512788	ResourceChangeRequest	85	0	1	\N
119	2025-12-04 04:24:01.542605	2025-12-04 04:24:01.542605	ResourceChangeRequest	86	0	1	\N
120	2025-12-04 04:24:01.558387	2025-12-04 04:24:01.558387	ResourceChangeRequest	86	0	1	\N
121	2025-12-04 04:24:01.591095	2025-12-04 04:24:01.591095	ResourceChangeRequest	87	0	1	\N
122	2025-12-04 04:24:01.605124	2025-12-04 04:24:01.605124	ResourceChangeRequest	87	0	1	\N
123	2025-12-04 04:24:01.634549	2025-12-04 04:24:01.634549	ResourceChangeRequest	88	0	1	\N
124	2025-12-04 04:24:01.649369	2025-12-04 04:24:01.649369	ResourceChangeRequest	88	0	1	\N
125	2025-12-04 04:24:01.67654	2025-12-04 04:24:01.67654	ResourceChangeRequest	89	0	1	\N
126	2025-12-04 04:24:01.702223	2025-12-04 04:24:01.702223	ResourceChangeRequest	90	0	1	\N
127	2025-12-04 04:24:01.729541	2025-12-04 04:24:01.729541	ResourceChangeRequest	91	0	1	\N
128	2025-12-04 04:24:01.758703	2025-12-04 04:24:01.758703	ResourceChangeRequest	92	0	1	\N
129	2025-12-04 04:24:01.772333	2025-12-04 04:24:01.772333	ResourceChangeRequest	92	0	1	\N
130	2025-12-04 04:24:01.802354	2025-12-04 04:24:01.802354	ResourceChangeRequest	93	0	1	\N
131	2025-12-04 04:24:01.829801	2025-12-04 04:24:01.829801	ResourceChangeRequest	94	0	1	\N
132	2025-12-04 04:24:01.853147	2025-12-04 04:24:01.853147	ResourceChangeRequest	95	0	1	\N
133	2025-12-04 04:24:01.882379	2025-12-04 04:24:01.882379	ResourceChangeRequest	96	0	1	\N
134	2025-12-04 04:24:01.909364	2025-12-04 04:24:01.909364	ResourceChangeRequest	97	0	1	\N
135	2025-12-04 04:24:01.924387	2025-12-04 04:24:01.924387	ResourceChangeRequest	97	0	1	\N
136	2025-12-04 04:24:01.951801	2025-12-04 04:24:01.951801	ResourceChangeRequest	98	0	1	\N
137	2025-12-04 04:24:01.966155	2025-12-04 04:24:01.966155	ResourceChangeRequest	98	0	1	\N
138	2025-12-04 04:24:01.997204	2025-12-04 04:24:01.997204	ResourceChangeRequest	99	0	1	\N
139	2025-12-04 04:24:02.010943	2025-12-04 04:24:02.010943	ResourceChangeRequest	99	0	1	\N
140	2025-12-04 04:24:02.035818	2025-12-04 04:24:02.035818	ResourceChangeRequest	100	0	1	\N
141	2025-12-04 04:24:02.063157	2025-12-04 04:24:02.063157	ResourceChangeRequest	101	0	1	\N
142	2025-12-04 04:24:02.077561	2025-12-04 04:24:02.077561	ResourceChangeRequest	101	0	1	\N
143	2025-12-04 04:24:02.105	2025-12-04 04:24:02.105	ResourceChangeRequest	102	0	1	\N
144	2025-12-04 04:24:02.130417	2025-12-04 04:24:02.130417	ResourceChangeRequest	103	0	1	\N
145	2025-12-04 04:24:02.155482	2025-12-04 04:24:02.155482	ResourceChangeRequest	104	0	1	\N
146	2025-12-04 04:24:02.184204	2025-12-04 04:24:02.184204	ResourceChangeRequest	105	0	1	\N
147	2025-12-04 04:24:02.199318	2025-12-04 04:24:02.199318	ResourceChangeRequest	105	0	1	\N
148	2025-12-04 04:24:02.223848	2025-12-04 04:24:02.223848	ResourceChangeRequest	106	0	1	\N
149	2025-12-04 04:24:02.25414	2025-12-04 04:24:02.25414	ResourceChangeRequest	107	0	1	\N
150	2025-12-04 04:24:02.267364	2025-12-04 04:24:02.267364	ResourceChangeRequest	107	0	1	\N
151	2025-12-04 04:24:02.293395	2025-12-04 04:24:02.293395	ResourceChangeRequest	108	0	1	\N
152	2025-12-04 04:24:02.306227	2025-12-04 04:24:02.306227	ResourceChangeRequest	108	0	1	\N
153	2025-12-04 04:24:02.33347	2025-12-04 04:24:02.33347	ResourceChangeRequest	109	0	1	\N
154	2025-12-04 04:24:02.357781	2025-12-04 04:24:02.357781	ResourceChangeRequest	110	0	1	\N
155	2025-12-04 04:24:02.369195	2025-12-04 04:24:02.369195	ResourceChangeRequest	110	0	1	\N
156	2025-12-04 04:24:02.397779	2025-12-04 04:24:02.397779	ResourceChangeRequest	111	0	1	\N
157	2025-12-04 04:24:02.413071	2025-12-04 04:24:02.413071	ResourceChangeRequest	111	0	1	\N
158	2025-12-04 04:24:02.439736	2025-12-04 04:24:02.439736	ResourceChangeRequest	112	0	1	\N
159	2025-12-04 04:24:02.454179	2025-12-04 04:24:02.454179	ResourceChangeRequest	112	0	1	\N
160	2025-12-04 04:24:02.480281	2025-12-04 04:24:02.480281	ResourceChangeRequest	113	0	1	\N
161	2025-12-04 04:24:02.492911	2025-12-04 04:24:02.492911	ResourceChangeRequest	113	0	1	\N
162	2025-12-04 04:24:02.522772	2025-12-04 04:24:02.522772	ResourceChangeRequest	114	0	1	\N
163	2025-12-04 04:24:02.536443	2025-12-04 04:24:02.536443	ResourceChangeRequest	114	0	1	\N
164	2025-12-04 04:24:02.565231	2025-12-04 04:24:02.565231	ResourceChangeRequest	115	0	1	\N
165	2025-12-04 04:24:02.589337	2025-12-04 04:24:02.589337	ResourceChangeRequest	116	0	1	\N
166	2025-12-04 04:24:02.60334	2025-12-04 04:24:02.60334	ResourceChangeRequest	116	0	1	\N
167	2025-12-04 04:24:02.628345	2025-12-04 04:24:02.628345	ResourceChangeRequest	117	0	1	\N
168	2025-12-04 04:24:02.657117	2025-12-04 04:24:02.657117	ResourceChangeRequest	118	0	1	\N
169	2025-12-04 04:24:02.686934	2025-12-04 04:24:02.686934	ResourceChangeRequest	119	0	1	\N
170	2025-12-04 04:24:02.703723	2025-12-04 04:24:02.703723	ResourceChangeRequest	119	0	1	\N
171	2025-12-04 04:24:02.734502	2025-12-04 04:24:02.734502	ResourceChangeRequest	120	0	1	\N
172	2025-12-04 04:24:02.757548	2025-12-04 04:24:02.757548	ResourceChangeRequest	121	0	1	\N
173	2025-12-04 04:24:02.787389	2025-12-04 04:24:02.787389	ResourceChangeRequest	122	0	1	\N
174	2025-12-04 04:24:02.817804	2025-12-04 04:24:02.817804	ResourceChangeRequest	123	0	1	\N
175	2025-12-04 04:24:02.844061	2025-12-04 04:24:02.844061	ResourceChangeRequest	124	0	1	\N
176	2025-12-04 04:24:02.857703	2025-12-04 04:24:02.857703	ResourceChangeRequest	124	0	1	\N
177	2025-12-04 04:24:02.886781	2025-12-04 04:24:02.886781	ResourceChangeRequest	125	0	1	\N
178	2025-12-04 04:24:02.915796	2025-12-04 04:24:02.915796	ResourceChangeRequest	126	0	1	\N
179	2025-12-04 04:24:02.929439	2025-12-04 04:24:02.929439	ResourceChangeRequest	126	0	1	\N
180	2025-12-04 04:24:02.959579	2025-12-04 04:24:02.959579	ResourceChangeRequest	127	0	1	\N
181	2025-12-04 04:24:02.996957	2025-12-04 04:24:02.996957	ResourceChangeRequest	128	0	1	\N
182	2025-12-04 04:24:03.02502	2025-12-04 04:24:03.02502	ResourceChangeRequest	129	0	1	\N
183	2025-12-04 04:24:03.040071	2025-12-04 04:24:03.040071	ResourceChangeRequest	129	0	1	\N
184	2025-12-04 04:24:03.06505	2025-12-04 04:24:03.06505	ResourceChangeRequest	130	0	1	\N
185	2025-12-04 04:24:03.09207	2025-12-04 04:24:03.09207	ResourceChangeRequest	131	0	1	\N
186	2025-12-04 04:24:03.117724	2025-12-04 04:24:03.117724	ResourceChangeRequest	132	0	1	\N
187	2025-12-04 04:24:03.144137	2025-12-04 04:24:03.144137	ResourceChangeRequest	133	0	1	\N
188	2025-12-04 04:24:03.168994	2025-12-04 04:24:03.168994	ResourceChangeRequest	134	0	1	\N
189	2025-12-04 04:24:03.192752	2025-12-04 04:24:03.192752	ResourceChangeRequest	135	0	1	\N
190	2025-12-04 04:24:03.2241	2025-12-04 04:24:03.2241	ResourceChangeRequest	136	0	1	\N
191	2025-12-04 04:24:03.255751	2025-12-04 04:24:03.255751	ResourceChangeRequest	137	0	1	\N
192	2025-12-04 04:24:03.268757	2025-12-04 04:24:03.268757	ResourceChangeRequest	137	0	1	\N
193	2025-12-04 04:24:03.295151	2025-12-04 04:24:03.295151	ResourceChangeRequest	138	0	1	\N
194	2025-12-04 04:24:03.309584	2025-12-04 04:24:03.309584	ResourceChangeRequest	138	0	1	\N
195	2025-12-04 04:24:03.338502	2025-12-04 04:24:03.338502	ResourceChangeRequest	139	0	1	\N
196	2025-12-04 04:24:03.352899	2025-12-04 04:24:03.352899	ResourceChangeRequest	139	0	1	\N
197	2025-12-04 04:24:03.378471	2025-12-04 04:24:03.378471	ResourceChangeRequest	140	0	1	\N
198	2025-12-04 04:24:03.408794	2025-12-04 04:24:03.408794	ResourceChangeRequest	141	0	1	\N
199	2025-12-04 04:24:03.421751	2025-12-04 04:24:03.421751	ResourceChangeRequest	141	0	1	\N
200	2025-12-04 04:24:03.450002	2025-12-04 04:24:03.450002	ResourceChangeRequest	142	0	1	\N
201	2025-12-04 04:24:03.476164	2025-12-04 04:24:03.476164	ResourceChangeRequest	143	0	1	\N
202	2025-12-04 04:24:03.489766	2025-12-04 04:24:03.489766	ResourceChangeRequest	143	0	1	\N
203	2025-12-04 04:24:03.516743	2025-12-04 04:24:03.516743	ResourceChangeRequest	144	0	1	\N
204	2025-12-04 04:24:03.546847	2025-12-04 04:24:03.546847	ResourceChangeRequest	145	0	1	\N
205	2025-12-04 04:24:03.560531	2025-12-04 04:24:03.560531	ResourceChangeRequest	145	0	1	\N
206	2025-12-04 04:24:03.589424	2025-12-04 04:24:03.589424	ResourceChangeRequest	146	0	1	\N
207	2025-12-04 04:24:03.61545	2025-12-04 04:24:03.61545	ResourceChangeRequest	147	0	1	\N
208	2025-12-04 04:24:03.629092	2025-12-04 04:24:03.629092	ResourceChangeRequest	147	0	1	\N
209	2025-12-04 04:24:03.65437	2025-12-04 04:24:03.65437	ResourceChangeRequest	148	0	1	\N
210	2025-12-04 04:24:03.677779	2025-12-04 04:24:03.677779	ResourceChangeRequest	149	0	1	\N
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contacts (id, name, title, email, created_at, updated_at, resource_id, service_id) FROM stdin;
\.


--
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documents (id, name, url, description, created_at, updated_at) FROM stdin;
1	1	document_url	Some document	2025-12-04 04:23:58.749486	2025-12-04 04:23:58.749486
2	2	document_url	Some document	2025-12-04 04:23:58.798194	2025-12-04 04:23:58.798194
3	3	document_url	Some document	2025-12-04 04:23:58.815234	2025-12-04 04:23:58.815234
4	4	document_url	Some document	2025-12-04 04:23:58.838949	2025-12-04 04:23:58.838949
5	5	document_url	Some document	2025-12-04 04:23:58.850391	2025-12-04 04:23:58.850391
6	6	document_url	Some document	2025-12-04 04:23:58.874611	2025-12-04 04:23:58.874611
7	7	document_url	Some document	2025-12-04 04:23:58.900116	2025-12-04 04:23:58.900116
8	8	document_url	Some document	2025-12-04 04:23:58.927375	2025-12-04 04:23:58.927375
9	9	document_url	Some document	2025-12-04 04:23:58.954397	2025-12-04 04:23:58.954397
10	10	document_url	Some document	2025-12-04 04:23:58.979518	2025-12-04 04:23:58.979518
11	11	document_url	Some document	2025-12-04 04:23:59.004695	2025-12-04 04:23:59.004695
12	12	document_url	Some document	2025-12-04 04:23:59.033472	2025-12-04 04:23:59.033472
13	13	document_url	Some document	2025-12-04 04:23:59.056032	2025-12-04 04:23:59.056032
14	14	document_url	Some document	2025-12-04 04:23:59.06833	2025-12-04 04:23:59.06833
15	15	document_url	Some document	2025-12-04 04:23:59.089861	2025-12-04 04:23:59.089861
16	16	document_url	Some document	2025-12-04 04:23:59.11502	2025-12-04 04:23:59.11502
17	17	document_url	Some document	2025-12-04 04:23:59.127017	2025-12-04 04:23:59.127017
18	18	document_url	Some document	2025-12-04 04:23:59.151837	2025-12-04 04:23:59.151837
19	19	document_url	Some document	2025-12-04 04:23:59.174817	2025-12-04 04:23:59.174817
20	20	document_url	Some document	2025-12-04 04:23:59.200284	2025-12-04 04:23:59.200284
21	21	document_url	Some document	2025-12-04 04:23:59.227004	2025-12-04 04:23:59.227004
22	22	document_url	Some document	2025-12-04 04:23:59.257806	2025-12-04 04:23:59.257806
23	23	document_url	Some document	2025-12-04 04:23:59.270337	2025-12-04 04:23:59.270337
24	24	document_url	Some document	2025-12-04 04:23:59.295839	2025-12-04 04:23:59.295839
25	25	document_url	Some document	2025-12-04 04:23:59.308527	2025-12-04 04:23:59.308527
26	26	document_url	Some document	2025-12-04 04:23:59.339451	2025-12-04 04:23:59.339451
27	27	document_url	Some document	2025-12-04 04:23:59.354554	2025-12-04 04:23:59.354554
28	28	document_url	Some document	2025-12-04 04:23:59.382279	2025-12-04 04:23:59.382279
29	29	document_url	Some document	2025-12-04 04:23:59.395561	2025-12-04 04:23:59.395561
30	30	document_url	Some document	2025-12-04 04:23:59.422456	2025-12-04 04:23:59.422456
31	31	document_url	Some document	2025-12-04 04:23:59.451435	2025-12-04 04:23:59.451435
32	32	document_url	Some document	2025-12-04 04:23:59.480959	2025-12-04 04:23:59.480959
33	33	document_url	Some document	2025-12-04 04:23:59.512025	2025-12-04 04:23:59.512025
34	34	document_url	Some document	2025-12-04 04:23:59.540112	2025-12-04 04:23:59.540112
35	35	document_url	Some document	2025-12-04 04:23:59.568268	2025-12-04 04:23:59.568268
36	36	document_url	Some document	2025-12-04 04:23:59.591217	2025-12-04 04:23:59.591217
37	37	document_url	Some document	2025-12-04 04:23:59.604819	2025-12-04 04:23:59.604819
38	38	document_url	Some document	2025-12-04 04:23:59.633923	2025-12-04 04:23:59.633923
39	39	document_url	Some document	2025-12-04 04:23:59.646025	2025-12-04 04:23:59.646025
40	40	document_url	Some document	2025-12-04 04:23:59.672965	2025-12-04 04:23:59.672965
41	41	document_url	Some document	2025-12-04 04:23:59.701042	2025-12-04 04:23:59.701042
42	42	document_url	Some document	2025-12-04 04:23:59.713089	2025-12-04 04:23:59.713089
43	43	document_url	Some document	2025-12-04 04:23:59.738505	2025-12-04 04:23:59.738505
44	44	document_url	Some document	2025-12-04 04:23:59.749184	2025-12-04 04:23:59.749184
45	45	document_url	Some document	2025-12-04 04:23:59.77758	2025-12-04 04:23:59.77758
46	46	document_url	Some document	2025-12-04 04:23:59.788892	2025-12-04 04:23:59.788892
47	47	document_url	Some document	2025-12-04 04:23:59.815239	2025-12-04 04:23:59.815239
48	48	document_url	Some document	2025-12-04 04:23:59.844103	2025-12-04 04:23:59.844103
49	49	document_url	Some document	2025-12-04 04:23:59.872938	2025-12-04 04:23:59.872938
50	50	document_url	Some document	2025-12-04 04:23:59.902841	2025-12-04 04:23:59.902841
51	51	document_url	Some document	2025-12-04 04:23:59.928113	2025-12-04 04:23:59.928113
52	52	document_url	Some document	2025-12-04 04:23:59.957738	2025-12-04 04:23:59.957738
53	53	document_url	Some document	2025-12-04 04:23:59.972568	2025-12-04 04:23:59.972568
54	54	document_url	Some document	2025-12-04 04:24:00.008359	2025-12-04 04:24:00.008359
55	55	document_url	Some document	2025-12-04 04:24:00.037536	2025-12-04 04:24:00.037536
56	56	document_url	Some document	2025-12-04 04:24:00.062831	2025-12-04 04:24:00.062831
57	57	document_url	Some document	2025-12-04 04:24:00.091286	2025-12-04 04:24:00.091286
58	58	document_url	Some document	2025-12-04 04:24:00.104396	2025-12-04 04:24:00.104396
59	59	document_url	Some document	2025-12-04 04:24:00.133181	2025-12-04 04:24:00.133181
60	60	document_url	Some document	2025-12-04 04:24:00.157415	2025-12-04 04:24:00.157415
61	61	document_url	Some document	2025-12-04 04:24:00.171354	2025-12-04 04:24:00.171354
62	62	document_url	Some document	2025-12-04 04:24:00.199853	2025-12-04 04:24:00.199853
63	63	document_url	Some document	2025-12-04 04:24:00.227548	2025-12-04 04:24:00.227548
64	64	document_url	Some document	2025-12-04 04:24:00.256359	2025-12-04 04:24:00.256359
65	65	document_url	Some document	2025-12-04 04:24:00.282566	2025-12-04 04:24:00.282566
66	66	document_url	Some document	2025-12-04 04:24:00.296575	2025-12-04 04:24:00.296575
67	67	document_url	Some document	2025-12-04 04:24:00.320339	2025-12-04 04:24:00.320339
68	68	document_url	Some document	2025-12-04 04:24:00.348263	2025-12-04 04:24:00.348263
69	69	document_url	Some document	2025-12-04 04:24:00.3623	2025-12-04 04:24:00.3623
70	70	document_url	Some document	2025-12-04 04:24:00.388405	2025-12-04 04:24:00.388405
71	71	document_url	Some document	2025-12-04 04:24:00.401965	2025-12-04 04:24:00.401965
72	72	document_url	Some document	2025-12-04 04:24:00.427356	2025-12-04 04:24:00.427356
73	73	document_url	Some document	2025-12-04 04:24:00.440089	2025-12-04 04:24:00.440089
74	74	document_url	Some document	2025-12-04 04:24:00.467245	2025-12-04 04:24:00.467245
75	75	document_url	Some document	2025-12-04 04:24:00.49715	2025-12-04 04:24:00.49715
76	76	document_url	Some document	2025-12-04 04:24:00.525029	2025-12-04 04:24:00.525029
77	77	document_url	Some document	2025-12-04 04:24:00.553387	2025-12-04 04:24:00.553387
78	78	document_url	Some document	2025-12-04 04:24:00.56629	2025-12-04 04:24:00.56629
79	79	document_url	Some document	2025-12-04 04:24:00.595087	2025-12-04 04:24:00.595087
80	80	document_url	Some document	2025-12-04 04:24:00.62509	2025-12-04 04:24:00.62509
81	81	document_url	Some document	2025-12-04 04:24:00.653423	2025-12-04 04:24:00.653423
82	82	document_url	Some document	2025-12-04 04:24:00.682605	2025-12-04 04:24:00.682605
83	83	document_url	Some document	2025-12-04 04:24:00.696764	2025-12-04 04:24:00.696764
84	84	document_url	Some document	2025-12-04 04:24:00.724496	2025-12-04 04:24:00.724496
85	85	document_url	Some document	2025-12-04 04:24:00.751596	2025-12-04 04:24:00.751596
86	86	document_url	Some document	2025-12-04 04:24:00.781183	2025-12-04 04:24:00.781183
87	87	document_url	Some document	2025-12-04 04:24:00.811572	2025-12-04 04:24:00.811572
88	88	document_url	Some document	2025-12-04 04:24:00.825274	2025-12-04 04:24:00.825274
89	89	document_url	Some document	2025-12-04 04:24:00.854247	2025-12-04 04:24:00.854247
90	90	document_url	Some document	2025-12-04 04:24:00.884141	2025-12-04 04:24:00.884141
91	91	document_url	Some document	2025-12-04 04:24:00.897162	2025-12-04 04:24:00.897162
92	92	document_url	Some document	2025-12-04 04:24:00.923232	2025-12-04 04:24:00.923232
93	93	document_url	Some document	2025-12-04 04:24:00.95056	2025-12-04 04:24:00.95056
94	94	document_url	Some document	2025-12-04 04:24:00.973998	2025-12-04 04:24:00.973998
95	95	document_url	Some document	2025-12-04 04:24:01.000757	2025-12-04 04:24:01.000757
96	96	document_url	Some document	2025-12-04 04:24:01.016962	2025-12-04 04:24:01.016962
97	97	document_url	Some document	2025-12-04 04:24:01.042882	2025-12-04 04:24:01.042882
98	98	document_url	Some document	2025-12-04 04:24:01.067515	2025-12-04 04:24:01.067515
99	99	document_url	Some document	2025-12-04 04:24:01.081866	2025-12-04 04:24:01.081866
100	100	document_url	Some document	2025-12-04 04:24:01.1069	2025-12-04 04:24:01.1069
101	101	document_url	Some document	2025-12-04 04:24:01.119806	2025-12-04 04:24:01.119806
102	102	document_url	Some document	2025-12-04 04:24:01.146144	2025-12-04 04:24:01.146144
103	103	document_url	Some document	2025-12-04 04:24:01.174131	2025-12-04 04:24:01.174131
104	104	document_url	Some document	2025-12-04 04:24:01.188829	2025-12-04 04:24:01.188829
105	105	document_url	Some document	2025-12-04 04:24:01.216221	2025-12-04 04:24:01.216221
106	106	document_url	Some document	2025-12-04 04:24:01.241312	2025-12-04 04:24:01.241312
107	107	document_url	Some document	2025-12-04 04:24:01.25818	2025-12-04 04:24:01.25818
108	108	document_url	Some document	2025-12-04 04:24:01.28392	2025-12-04 04:24:01.28392
109	109	document_url	Some document	2025-12-04 04:24:01.297953	2025-12-04 04:24:01.297953
110	110	document_url	Some document	2025-12-04 04:24:01.327755	2025-12-04 04:24:01.327755
111	111	document_url	Some document	2025-12-04 04:24:01.341946	2025-12-04 04:24:01.341946
112	112	document_url	Some document	2025-12-04 04:24:01.365939	2025-12-04 04:24:01.365939
113	113	document_url	Some document	2025-12-04 04:24:01.396188	2025-12-04 04:24:01.396188
114	114	document_url	Some document	2025-12-04 04:24:01.412993	2025-12-04 04:24:01.412993
115	115	document_url	Some document	2025-12-04 04:24:01.43706	2025-12-04 04:24:01.43706
116	116	document_url	Some document	2025-12-04 04:24:01.454579	2025-12-04 04:24:01.454579
117	117	document_url	Some document	2025-12-04 04:24:01.482973	2025-12-04 04:24:01.482973
118	118	document_url	Some document	2025-12-04 04:24:01.510426	2025-12-04 04:24:01.510426
119	119	document_url	Some document	2025-12-04 04:24:01.540292	2025-12-04 04:24:01.540292
120	120	document_url	Some document	2025-12-04 04:24:01.554872	2025-12-04 04:24:01.554872
121	121	document_url	Some document	2025-12-04 04:24:01.588508	2025-12-04 04:24:01.588508
122	122	document_url	Some document	2025-12-04 04:24:01.602676	2025-12-04 04:24:01.602676
123	123	document_url	Some document	2025-12-04 04:24:01.632127	2025-12-04 04:24:01.632127
124	124	document_url	Some document	2025-12-04 04:24:01.646967	2025-12-04 04:24:01.646967
125	125	document_url	Some document	2025-12-04 04:24:01.673997	2025-12-04 04:24:01.673997
126	126	document_url	Some document	2025-12-04 04:24:01.699865	2025-12-04 04:24:01.699865
127	127	document_url	Some document	2025-12-04 04:24:01.727205	2025-12-04 04:24:01.727205
128	128	document_url	Some document	2025-12-04 04:24:01.753925	2025-12-04 04:24:01.753925
129	129	document_url	Some document	2025-12-04 04:24:01.770013	2025-12-04 04:24:01.770013
130	130	document_url	Some document	2025-12-04 04:24:01.79993	2025-12-04 04:24:01.79993
131	131	document_url	Some document	2025-12-04 04:24:01.827457	2025-12-04 04:24:01.827457
132	132	document_url	Some document	2025-12-04 04:24:01.850685	2025-12-04 04:24:01.850685
133	133	document_url	Some document	2025-12-04 04:24:01.879874	2025-12-04 04:24:01.879874
134	134	document_url	Some document	2025-12-04 04:24:01.907026	2025-12-04 04:24:01.907026
135	135	document_url	Some document	2025-12-04 04:24:01.922019	2025-12-04 04:24:01.922019
136	136	document_url	Some document	2025-12-04 04:24:01.949454	2025-12-04 04:24:01.949454
137	137	document_url	Some document	2025-12-04 04:24:01.963852	2025-12-04 04:24:01.963852
138	138	document_url	Some document	2025-12-04 04:24:01.994818	2025-12-04 04:24:01.994818
139	139	document_url	Some document	2025-12-04 04:24:02.008566	2025-12-04 04:24:02.008566
140	140	document_url	Some document	2025-12-04 04:24:02.033432	2025-12-04 04:24:02.033432
141	141	document_url	Some document	2025-12-04 04:24:02.060682	2025-12-04 04:24:02.060682
142	142	document_url	Some document	2025-12-04 04:24:02.075258	2025-12-04 04:24:02.075258
143	143	document_url	Some document	2025-12-04 04:24:02.102579	2025-12-04 04:24:02.102579
144	144	document_url	Some document	2025-12-04 04:24:02.128008	2025-12-04 04:24:02.128008
145	145	document_url	Some document	2025-12-04 04:24:02.153016	2025-12-04 04:24:02.153016
146	146	document_url	Some document	2025-12-04 04:24:02.181782	2025-12-04 04:24:02.181782
147	147	document_url	Some document	2025-12-04 04:24:02.196987	2025-12-04 04:24:02.196987
148	148	document_url	Some document	2025-12-04 04:24:02.221469	2025-12-04 04:24:02.221469
149	149	document_url	Some document	2025-12-04 04:24:02.251817	2025-12-04 04:24:02.251817
150	150	document_url	Some document	2025-12-04 04:24:02.265029	2025-12-04 04:24:02.265029
151	151	document_url	Some document	2025-12-04 04:24:02.290811	2025-12-04 04:24:02.290811
152	152	document_url	Some document	2025-12-04 04:24:02.303905	2025-12-04 04:24:02.303905
153	153	document_url	Some document	2025-12-04 04:24:02.33098	2025-12-04 04:24:02.33098
154	154	document_url	Some document	2025-12-04 04:24:02.35538	2025-12-04 04:24:02.35538
155	155	document_url	Some document	2025-12-04 04:24:02.36692	2025-12-04 04:24:02.36692
156	156	document_url	Some document	2025-12-04 04:24:02.395466	2025-12-04 04:24:02.395466
157	157	document_url	Some document	2025-12-04 04:24:02.410726	2025-12-04 04:24:02.410726
158	158	document_url	Some document	2025-12-04 04:24:02.437412	2025-12-04 04:24:02.437412
159	159	document_url	Some document	2025-12-04 04:24:02.451769	2025-12-04 04:24:02.451769
160	160	document_url	Some document	2025-12-04 04:24:02.477498	2025-12-04 04:24:02.477498
161	161	document_url	Some document	2025-12-04 04:24:02.490401	2025-12-04 04:24:02.490401
162	162	document_url	Some document	2025-12-04 04:24:02.520433	2025-12-04 04:24:02.520433
163	163	document_url	Some document	2025-12-04 04:24:02.534104	2025-12-04 04:24:02.534104
164	164	document_url	Some document	2025-12-04 04:24:02.562841	2025-12-04 04:24:02.562841
165	165	document_url	Some document	2025-12-04 04:24:02.586897	2025-12-04 04:24:02.586897
166	166	document_url	Some document	2025-12-04 04:24:02.60101	2025-12-04 04:24:02.60101
167	167	document_url	Some document	2025-12-04 04:24:02.626023	2025-12-04 04:24:02.626023
168	168	document_url	Some document	2025-12-04 04:24:02.654765	2025-12-04 04:24:02.654765
169	169	document_url	Some document	2025-12-04 04:24:02.684565	2025-12-04 04:24:02.684565
170	170	document_url	Some document	2025-12-04 04:24:02.700917	2025-12-04 04:24:02.700917
171	171	document_url	Some document	2025-12-04 04:24:02.732092	2025-12-04 04:24:02.732092
172	172	document_url	Some document	2025-12-04 04:24:02.755158	2025-12-04 04:24:02.755158
173	173	document_url	Some document	2025-12-04 04:24:02.784872	2025-12-04 04:24:02.784872
174	174	document_url	Some document	2025-12-04 04:24:02.815426	2025-12-04 04:24:02.815426
175	175	document_url	Some document	2025-12-04 04:24:02.841619	2025-12-04 04:24:02.841619
176	176	document_url	Some document	2025-12-04 04:24:02.855323	2025-12-04 04:24:02.855323
177	177	document_url	Some document	2025-12-04 04:24:02.884459	2025-12-04 04:24:02.884459
178	178	document_url	Some document	2025-12-04 04:24:02.913383	2025-12-04 04:24:02.913383
179	179	document_url	Some document	2025-12-04 04:24:02.927071	2025-12-04 04:24:02.927071
180	180	document_url	Some document	2025-12-04 04:24:02.957178	2025-12-04 04:24:02.957178
181	181	document_url	Some document	2025-12-04 04:24:02.994325	2025-12-04 04:24:02.994325
182	182	document_url	Some document	2025-12-04 04:24:03.022501	2025-12-04 04:24:03.022501
183	183	document_url	Some document	2025-12-04 04:24:03.037562	2025-12-04 04:24:03.037562
184	184	document_url	Some document	2025-12-04 04:24:03.062523	2025-12-04 04:24:03.062523
185	185	document_url	Some document	2025-12-04 04:24:03.08956	2025-12-04 04:24:03.08956
186	186	document_url	Some document	2025-12-04 04:24:03.115272	2025-12-04 04:24:03.115272
187	187	document_url	Some document	2025-12-04 04:24:03.141703	2025-12-04 04:24:03.141703
188	188	document_url	Some document	2025-12-04 04:24:03.166596	2025-12-04 04:24:03.166596
189	189	document_url	Some document	2025-12-04 04:24:03.190409	2025-12-04 04:24:03.190409
190	190	document_url	Some document	2025-12-04 04:24:03.221654	2025-12-04 04:24:03.221654
191	191	document_url	Some document	2025-12-04 04:24:03.253364	2025-12-04 04:24:03.253364
192	192	document_url	Some document	2025-12-04 04:24:03.266324	2025-12-04 04:24:03.266324
193	193	document_url	Some document	2025-12-04 04:24:03.292751	2025-12-04 04:24:03.292751
194	194	document_url	Some document	2025-12-04 04:24:03.307247	2025-12-04 04:24:03.307247
195	195	document_url	Some document	2025-12-04 04:24:03.33587	2025-12-04 04:24:03.33587
196	196	document_url	Some document	2025-12-04 04:24:03.350525	2025-12-04 04:24:03.350525
197	197	document_url	Some document	2025-12-04 04:24:03.376125	2025-12-04 04:24:03.376125
198	198	document_url	Some document	2025-12-04 04:24:03.406447	2025-12-04 04:24:03.406447
199	199	document_url	Some document	2025-12-04 04:24:03.419394	2025-12-04 04:24:03.419394
200	200	document_url	Some document	2025-12-04 04:24:03.447591	2025-12-04 04:24:03.447591
201	201	document_url	Some document	2025-12-04 04:24:03.473454	2025-12-04 04:24:03.473454
202	202	document_url	Some document	2025-12-04 04:24:03.487404	2025-12-04 04:24:03.487404
203	203	document_url	Some document	2025-12-04 04:24:03.514306	2025-12-04 04:24:03.514306
204	204	document_url	Some document	2025-12-04 04:24:03.544412	2025-12-04 04:24:03.544412
205	205	document_url	Some document	2025-12-04 04:24:03.558158	2025-12-04 04:24:03.558158
206	206	document_url	Some document	2025-12-04 04:24:03.587049	2025-12-04 04:24:03.587049
207	207	document_url	Some document	2025-12-04 04:24:03.613115	2025-12-04 04:24:03.613115
208	208	document_url	Some document	2025-12-04 04:24:03.626749	2025-12-04 04:24:03.626749
209	209	document_url	Some document	2025-12-04 04:24:03.652014	2025-12-04 04:24:03.652014
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
\.


--
-- Data for Name: eligibilities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eligibilities (id, name, created_at, updated_at, feature_rank, is_parent, parent_id) FROM stdin;
1	Seniors (55+ years old)	2025-12-04 04:24:03.683052	2025-12-04 04:24:03.683052	1	f	\N
2	Veterans	2025-12-04 04:24:03.712779	2025-12-04 04:24:03.712779	2	f	\N
3	Families	2025-12-04 04:24:03.73146	2025-12-04 04:24:03.73146	3	f	\N
4	Transition Aged Youth	2025-12-04 04:24:03.740999	2025-12-04 04:24:03.740999	4	f	\N
5	Re-Entry	2025-12-04 04:24:03.766734	2025-12-04 04:24:03.766734	5	f	\N
6	Immigrants	2025-12-04 04:24:03.785243	2025-12-04 04:24:03.785243	6	f	\N
8	Near Homeless	2025-12-04 04:24:03.801171	2025-12-04 04:24:03.801171	\N	f	\N
9	LGBTQ	2025-12-04 04:24:03.807626	2025-12-04 04:24:03.807626	\N	f	\N
10	Alzheimers	2025-12-04 04:24:03.814276	2025-12-04 04:24:03.814276	\N	f	\N
13	Low-Income	2025-12-04 04:24:03.83402	2025-12-04 04:24:03.83402	\N	f	\N
7	Foster Youth	2025-12-04 04:24:03.794708	2025-12-04 04:24:03.844497	\N	t	\N
11	Homeless	2025-12-04 04:24:03.821046	2025-12-04 04:24:03.848364	\N	t	\N
12	Disabled	2025-12-04 04:24:03.827533	2025-12-04 04:24:03.850137	\N	t	\N
\.


--
-- Data for Name: eligibilities_services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eligibilities_services (service_id, eligibility_id) FROM stdin;
48	1
66	1
118	1
137	1
29	1
139	1
200	1
71	1
72	1
83	1
63	1
130	1
148	1
99	1
10	1
35	1
92	1
174	1
126	1
107	1
178	1
40	1
177	1
146	1
132	2
84	2
181	2
87	2
56	2
155	2
139	2
200	2
208	2
40	2
67	2
130	2
12	2
3	2
141	2
187	2
173	2
77	3
204	3
35	3
144	3
133	3
164	3
154	3
43	3
33	4
130	4
51	4
140	4
55	4
118	4
67	4
126	4
39	4
147	4
31	4
17	4
48	4
127	4
200	4
98	4
92	4
117	4
109	4
121	4
32	4
56	4
64	4
115	4
17	5
168	5
207	5
21	5
206	5
13	5
143	5
84	5
97	5
22	5
35	5
148	5
158	5
1	5
185	5
8	5
51	5
8	6
22	6
191	6
160	6
126	6
102	6
194	6
29	6
7	7
192	7
78	7
190	7
114	7
20	8
89	8
137	8
185	8
129	8
126	9
103	9
102	9
145	9
61	9
54	10
30	10
38	10
22	10
160	10
188	11
203	11
208	11
206	11
34	11
71	12
156	12
114	12
148	12
110	12
55	13
209	13
64	13
185	13
149	13
211	12
212	1
213	3
214	11
\.


--
-- Data for Name: eligibility_relationships; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eligibility_relationships (parent_id, child_id) FROM stdin;
7	5
11	10
12	5
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
1	name	Bins LLC	1
2	long_description	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	1
3	name	Huel-Cole	2
4	long_description	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	2
5	name	Larkin-Mante	3
6	long_description	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	3
7	name	Kemmer, Hahn and O'Hara	4
8	long_description	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	4
9	name	Romaguera and Sons	5
10	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	5
11	name	Douglas-Kessler	6
12	long_description	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	6
13	name	Wilderman, Mueller and Oberbrunner	7
14	long_description	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	7
15	name	Jacobs, Terry and Ruecker	8
16	long_description	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	8
17	name	Nader, Sauer and Donnelly	9
18	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	9
19	name	McKenzie-Stroman	10
20	long_description	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	10
21	name	Aufderhar-Ortiz	11
22	long_description	A place to shower on Tuesday through Saturday.\n	11
23	name	Gutkowski LLC	12
24	long_description	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	12
25	name	Upton Group	13
26	long_description	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	13
27	name	Farrell-Hagenes	14
28	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	14
29	name	Oberbrunner, Smith and Vandervort	15
30	long_description	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	15
31	name	Lockman-Ryan	16
32	long_description	Serves lunch Monday and Wednesday. Dinner available all days.\n	16
33	name	Cronin Group	17
34	long_description	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	17
35	name	Glover-Kozey	18
36	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	18
37	name	Corwin LLC	19
38	long_description	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	19
39	name	Graham Group	20
40	long_description	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	20
41	name	Cole, Stanton and Quitzon	21
42	long_description	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	21
43	name	Rempel-Ankunding	22
44	long_description	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	22
45	name	D'Amore, Bayer and Kemmer	23
46	long_description	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	23
47	name	Nader-Terry	24
48	long_description	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	24
49	name	Hills Inc	25
50	long_description	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	25
51	name	Lueilwitz, Kuhn and Rolfson	26
52	long_description	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	26
53	name	Strosin, Paucek and Macejkovic	27
54	long_description	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	27
55	name	Kreiger-Yundt	28
56	long_description	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	28
57	name	Krajcik-Hilpert	29
58	long_description	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	29
59	name	Von and Sons	30
60	long_description	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	30
61	name	VonRueden, Hane and Ratke	31
62	long_description	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	31
63	name	Cronin Inc	32
64	long_description	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	32
65	name	Jacobs-White	33
66	long_description	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	33
67	name	Stracke and Sons	34
68	long_description	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	34
69	name	Barrows, Nolan and Kihn	35
70	long_description	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	35
71	name	Reichel and Sons	36
72	long_description	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	36
73	name	Brown Group	37
74	long_description	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	37
75	name	Boehm-Senger	38
76	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	38
77	name	Bergstrom-Dibbert	39
78	long_description	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	39
79	name	Roob-Jast	40
80	long_description	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	40
81	name	Sawayn Group	41
82	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	41
83	name	Wuckert-Hane	42
84	long_description	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	42
85	name	Willms-Walsh	43
86	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	43
87	name	Spencer, Sawayn and Deckow	44
88	long_description	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	44
89	name	Thiel and Sons	45
90	long_description	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	45
91	name	Huel, Hoeger and Upton	46
92	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	46
93	name	Larkin, Bailey and Bartell	47
94	long_description	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	47
95	name	Gulgowski Group	48
96	long_description	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	48
97	name	Monahan, Pfeffer and Osinski	49
98	long_description	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	49
99	name	Kshlerin LLC	50
100	long_description	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	50
101	name	Batz-Friesen	51
102	long_description	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	51
103	name	Langworth, Fahey and Hartmann	52
104	long_description	Serves lunch Monday and Wednesday. Dinner available all days.\n	52
105	name	Quigley, Herzog and Emard	53
106	long_description	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	53
107	name	Romaguera, Stehr and Mertz	54
108	long_description	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	54
109	name	Schiller-Feil	55
110	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	55
111	name	Kulas-Kihn	56
112	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	56
113	name	Harris-Waelchi	57
114	long_description	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	57
115	name	Price, Hammes and Little	58
116	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	58
117	name	Cronin, Kuvalis and Brown	59
118	long_description	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	59
119	name	Wisozk-Hudson	60
120	long_description	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	60
121	name	Orn-Bechtelar	61
122	long_description	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	61
123	name	Ondricka Group	62
124	long_description	A place to shower on Tuesday through Saturday.\n	62
125	name	Abbott-Goldner	63
126	long_description	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	63
127	name	Cartwright-Schuster	64
128	long_description	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	64
129	name	Dibbert-Watsica	65
130	long_description	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	65
131	name	Cummings, Wiegand and Hoeger	66
132	long_description	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	66
133	name	Boyle, Medhurst and Buckridge	67
134	long_description	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	67
135	name	Hahn Group	68
136	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	68
137	name	Mills-Prosacco	69
138	long_description	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	69
139	name	Rowe-Goodwin	70
140	long_description	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	70
141	name	Balistreri, Will and Hegmann	71
142	long_description	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	71
143	name	Flatley-Berge	72
144	long_description	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	72
145	name	Weissnat, Kozey and Lynch	73
146	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	73
147	name	Hamill Inc	74
148	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	74
149	name	Effertz LLC	75
150	long_description	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	75
151	name	Fahey, Kihn and Haag	76
152	long_description	Serves lunch Monday and Wednesday. Dinner available all days.\n	76
153	name	Rosenbaum-Hansen	77
154	long_description	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	77
155	name	Farrell Group	78
156	long_description	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	78
157	name	Bogan, Reilly and Schmitt	79
158	long_description	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	79
159	name	Abshire-Durgan	80
160	long_description	A place to shower on Tuesday through Saturday.\n	80
161	name	Reilly, Rowe and Frami	81
162	long_description	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	81
163	name	Sporer, Rice and Weissnat	82
164	long_description	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	82
165	name	Kilback-Leannon	83
166	long_description	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	83
167	name	Lubowitz-Langworth	84
168	long_description	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	84
169	name	Runolfsdottir LLC	85
170	long_description	Serves lunch Monday and Wednesday. Dinner available all days.\n	85
171	name	Davis, Fay and Gutkowski	86
172	long_description	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	86
173	name	Gerlach-Heidenreich	87
174	long_description	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	87
175	name	O'Kon-Jast	88
176	long_description	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	88
177	name	Kutch Group	89
178	long_description	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	89
179	name	Johns-Schoen	90
180	long_description	A place to shower on Tuesday through Saturday.\n	90
181	name	Keebler, Zboncak and Johnston	91
182	long_description	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	91
183	name	Bahringer, Abbott and Koepp	92
184	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	92
185	name	Weber-Lind	93
186	long_description	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	93
187	name	Ondricka, Dach and Littel	94
188	long_description	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	94
189	name	Harber-Crooks	95
190	long_description	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	95
191	name	Simonis, Will and Windler	96
192	long_description	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	96
193	name	Zieme and Sons	97
194	long_description	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	97
195	name	McGlynn, Braun and Collier	98
196	long_description	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	98
197	name	Raynor LLC	99
198	long_description	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	99
199	name	Renner, Stamm and Gusikowski	100
200	long_description	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	100
201	name	Von, Kihn and Strosin	101
202	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	101
203	name	Feeney-Bins	102
204	long_description	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	102
205	name	Emard LLC	103
206	long_description	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	103
207	name	O'Keefe LLC	104
208	long_description	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	104
209	name	Veum, Jaskolski and Rutherford	105
210	long_description	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	105
211	name	Kessler Inc	106
212	long_description	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	106
213	name	Weimann, O'Connell and Rempel	107
214	long_description	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	107
215	name	Batz, Collier and Gutmann	108
216	long_description	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	108
217	name	Bergnaum, Kub and Block	109
218	long_description	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	109
219	name	MacGyver Inc	110
220	long_description	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	110
221	name	Stokes-Von	111
222	long_description	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	111
223	name	Wilkinson-Medhurst	112
224	long_description	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	112
225	name	McKenzie, Wolf and Kshlerin	113
226	long_description	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	113
227	name	Okuneva Inc	114
228	long_description	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	114
229	name	Howe, Kautzer and Breitenberg	115
230	long_description	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	115
231	name	Hirthe, Howell and Bartell	116
232	long_description	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	116
233	name	Carroll, Leannon and Rosenbaum	117
234	long_description	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	117
235	name	Bartell-Wolff	118
236	long_description	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	118
237	name	Wilderman-Kiehn	119
238	long_description	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	119
239	name	Reichert-Bartell	120
240	long_description	Serves lunch Monday and Wednesday. Dinner available all days.\n	120
241	name	Shields, Pollich and Upton	121
242	long_description	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	121
243	name	Boyer-Roob	122
244	long_description	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	122
245	name	Halvorson-Kling	123
246	long_description	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	123
247	name	Hudson-Von	124
248	long_description	Serves lunch Monday and Wednesday. Dinner available all days.\n	124
249	name	Johns Inc	125
250	long_description	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	125
251	name	Shields-Gislason	126
252	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	126
253	name	Rowe Inc	127
254	long_description	Serves lunch Monday and Wednesday. Dinner available all days.\n	127
255	name	Crist-Conn	128
256	long_description	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	128
257	name	Abbott, Marks and Will	129
258	long_description	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	129
259	name	Donnelly, Feil and Feeney	130
260	long_description	Serves lunch Monday and Wednesday. Dinner available all days.\n	130
261	name	Kozey-Larson	131
262	long_description	Weekly food pantry (Thursday).\n	131
263	name	Ernser Inc	132
264	long_description	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	132
265	name	Bogisich, Konopelski and Rice	133
266	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	133
267	name	Rutherford and Sons	134
268	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	134
269	name	Monahan, Murray and Adams	135
270	long_description	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	135
271	name	Murphy-Rolfson	136
272	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	136
273	name	Pagac, Jerde and Hegmann	137
274	long_description	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	137
275	name	Olson, Krajcik and Stamm	138
276	long_description	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	138
277	name	Bahringer-Bailey	139
278	long_description	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	139
279	name	Klocko, Crooks and Reichel	140
280	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	140
281	name	Waelchi-Lubowitz	141
282	long_description	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	141
283	name	Weimann-Robel	142
284	long_description	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	142
285	name	Kub, Hoeger and Kirlin	143
286	long_description	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	143
287	name	Jacobson-Ullrich	144
288	long_description	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	144
289	name	Schuppe-Ratke	145
290	long_description	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	145
291	name	Schinner, Schroeder and Nikolaus	146
292	long_description	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	146
293	name	Cremin, Reilly and Ullrich	147
294	long_description	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	147
295	name	Casper, Stamm and Johnson	148
296	long_description	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	148
297	name	Schuster Inc	149
298	long_description	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	149
299	name	Jast LLC	150
300	long_description	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	150
301	name	Huels, Renner and Hane	151
302	long_description	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	151
303	name	Oberbrunner-Lakin	152
304	long_description	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	152
305	name	Ullrich and Sons	153
306	long_description	Serves lunch Monday and Wednesday. Dinner available all days.\n	153
307	name	Wehner Group	154
308	long_description	A place to shower on Tuesday through Saturday.\n	154
309	name	Gislason, Kling and White	155
310	long_description	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	155
311	name	Pfeffer-Schuster	156
312	long_description	Weekly food pantry (Thursday).\n	156
313	name	Stroman-Haag	157
314	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	157
315	name	Walsh, VonRueden and Larson	158
316	long_description	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	158
317	name	Ebert, Vandervort and Bayer	159
318	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	159
319	name	Upton, Lueilwitz and Gerlach	160
320	long_description	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	160
321	name	Ward Group	161
322	long_description	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	161
323	name	Lynch LLC	162
324	long_description	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	162
325	name	Macejkovic-Heaney	163
326	long_description	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	163
327	name	Bailey-Grimes	164
328	long_description	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	164
329	name	Prosacco, Bailey and Daniel	165
330	long_description	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	165
331	name	Beer, Heller and Pouros	166
332	long_description	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	166
333	name	Zemlak, Ryan and Veum	167
334	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	167
335	name	Aufderhar, Miller and Kovacek	168
336	long_description	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	168
337	name	Brekke, Boehm and Parker	169
338	long_description	Weekly food pantry (Thursday).\n	169
339	name	Greenholt-Ryan	170
340	long_description	Weekly food pantry (Thursday).\n	170
341	name	Schaefer Inc	171
342	long_description	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	171
343	name	Buckridge LLC	172
344	long_description	A place to shower on Tuesday through Saturday.\n	172
345	name	O'Keefe, Nitzsche and Ruecker	173
346	long_description	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	173
347	name	Herzog, Kutch and Quitzon	174
348	long_description	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	174
349	name	Vandervort-Ebert	175
350	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	175
351	name	Tromp, Adams and Christiansen	176
352	long_description	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	176
353	name	Quigley, Barton and Langworth	177
354	long_description	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	177
355	name	Grimes-Gislason	178
356	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	178
357	name	Boyer, Gerhold and Abernathy	179
358	long_description	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	179
359	name	Stoltenberg, Fritsch and Bauch	180
360	long_description	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	180
361	name	Aufderhar Inc	181
362	long_description	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	181
363	name	Kirlin, Krajcik and Dooley	182
364	long_description	Serves lunch Monday and Wednesday. Dinner available all days.\n	182
365	name	Spencer, Wolf and Gerhold	183
366	long_description	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	183
367	name	Hackett Inc	184
368	long_description	Serves lunch Monday and Wednesday. Dinner available all days.\n	184
369	name	Pouros LLC	185
370	long_description	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	185
371	name	Moore, Ledner and Rosenbaum	186
372	long_description	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	186
373	name	Jenkins-Block	187
374	long_description	Weekly food pantry (Thursday).\n	187
375	name	Torp-Haley	188
376	long_description	Weekly food pantry (Thursday).\n	188
377	name	Witting, Quitzon and Purdy	189
378	long_description	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	189
379	name	Beier, Daugherty and Bergnaum	190
380	long_description	Weekly food pantry (Thursday).\n	190
381	name	Jacobi-Rath	191
382	long_description	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	191
383	name	Brekke, Abshire and Kutch	192
384	long_description	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	192
385	name	Nolan, Koch and Bogisich	193
386	long_description	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	193
387	name	Crist and Sons	194
388	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	194
389	name	Hickle-Bailey	195
390	long_description	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	195
391	name	Altenwerth-Hyatt	196
392	long_description	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	196
393	name	Schumm-Jast	197
394	long_description	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	197
395	name	Hammes, Hintz and Corkery	198
396	long_description	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	198
397	name	Green and Sons	199
398	long_description	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	199
399	name	Hahn LLC	200
400	long_description	Weekly food pantry (Thursday).\n	200
401	name	Trantow, Haley and Heller	201
402	long_description	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	201
403	name	Koch LLC	202
404	long_description	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	202
405	name	Olson and Sons	203
406	long_description	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	203
407	name	Witting Group	204
408	long_description	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	204
409	name	Lind-Pollich	205
410	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	205
411	name	Doyle-Cruickshank	206
412	long_description	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	206
413	name	Witting, Crona and Douglas	207
414	long_description	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	207
415	name	Bruen-Lebsack	208
416	long_description	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	208
417	name	McLaughlin, Weissnat and Marvin	209
418	long_description	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	209
419	name	Runolfsson-Purdy	210
420	long_description	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	210
\.


--
-- Data for Name: folders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.folders (id, name, "order", user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: fundings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fundings (id, source, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_permissions (group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groups (id, name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: instructions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instructions (id, instruction, created_at, updated_at, service_id) FROM stdin;
1	Instruction text goes here	2025-12-04 04:23:58.758755	2025-12-04 04:23:58.758755	1
2	Instruction text goes here	2025-12-04 04:23:58.800306	2025-12-04 04:23:58.800306	2
3	Instruction text goes here	2025-12-04 04:23:58.816733	2025-12-04 04:23:58.816733	3
4	Instruction text goes here	2025-12-04 04:23:58.840538	2025-12-04 04:23:58.840538	4
5	Instruction text goes here	2025-12-04 04:23:58.851873	2025-12-04 04:23:58.851873	5
6	Instruction text goes here	2025-12-04 04:23:58.87637	2025-12-04 04:23:58.87637	6
7	Instruction text goes here	2025-12-04 04:23:58.901592	2025-12-04 04:23:58.901592	7
8	Instruction text goes here	2025-12-04 04:23:58.928902	2025-12-04 04:23:58.928902	8
9	Instruction text goes here	2025-12-04 04:23:58.9561	2025-12-04 04:23:58.9561	9
10	Instruction text goes here	2025-12-04 04:23:58.981271	2025-12-04 04:23:58.981271	10
11	Instruction text goes here	2025-12-04 04:23:59.006131	2025-12-04 04:23:59.006131	11
12	Instruction text goes here	2025-12-04 04:23:59.03506	2025-12-04 04:23:59.03506	12
13	Instruction text goes here	2025-12-04 04:23:59.057532	2025-12-04 04:23:59.057532	13
14	Instruction text goes here	2025-12-04 04:23:59.069831	2025-12-04 04:23:59.069831	14
15	Instruction text goes here	2025-12-04 04:23:59.091356	2025-12-04 04:23:59.091356	15
16	Instruction text goes here	2025-12-04 04:23:59.116541	2025-12-04 04:23:59.116541	16
17	Instruction text goes here	2025-12-04 04:23:59.12861	2025-12-04 04:23:59.12861	17
18	Instruction text goes here	2025-12-04 04:23:59.153324	2025-12-04 04:23:59.153324	18
19	Instruction text goes here	2025-12-04 04:23:59.176321	2025-12-04 04:23:59.176321	19
20	Instruction text goes here	2025-12-04 04:23:59.201798	2025-12-04 04:23:59.201798	20
21	Instruction text goes here	2025-12-04 04:23:59.228934	2025-12-04 04:23:59.228934	21
22	Instruction text goes here	2025-12-04 04:23:59.259543	2025-12-04 04:23:59.259543	22
23	Instruction text goes here	2025-12-04 04:23:59.272016	2025-12-04 04:23:59.272016	23
24	Instruction text goes here	2025-12-04 04:23:59.297603	2025-12-04 04:23:59.297603	24
25	Instruction text goes here	2025-12-04 04:23:59.310151	2025-12-04 04:23:59.310151	25
26	Instruction text goes here	2025-12-04 04:23:59.341178	2025-12-04 04:23:59.341178	26
27	Instruction text goes here	2025-12-04 04:23:59.356146	2025-12-04 04:23:59.356146	27
28	Instruction text goes here	2025-12-04 04:23:59.383888	2025-12-04 04:23:59.383888	28
29	Instruction text goes here	2025-12-04 04:23:59.397151	2025-12-04 04:23:59.397151	29
30	Instruction text goes here	2025-12-04 04:23:59.424319	2025-12-04 04:23:59.424319	30
31	Instruction text goes here	2025-12-04 04:23:59.453129	2025-12-04 04:23:59.453129	31
32	Instruction text goes here	2025-12-04 04:23:59.482786	2025-12-04 04:23:59.482786	32
33	Instruction text goes here	2025-12-04 04:23:59.513642	2025-12-04 04:23:59.513642	33
34	Instruction text goes here	2025-12-04 04:23:59.541923	2025-12-04 04:23:59.541923	34
35	Instruction text goes here	2025-12-04 04:23:59.569866	2025-12-04 04:23:59.569866	35
36	Instruction text goes here	2025-12-04 04:23:59.592855	2025-12-04 04:23:59.592855	36
37	Instruction text goes here	2025-12-04 04:23:59.606468	2025-12-04 04:23:59.606468	37
38	Instruction text goes here	2025-12-04 04:23:59.635592	2025-12-04 04:23:59.635592	38
39	Instruction text goes here	2025-12-04 04:23:59.647623	2025-12-04 04:23:59.647623	39
40	Instruction text goes here	2025-12-04 04:23:59.674638	2025-12-04 04:23:59.674638	40
41	Instruction text goes here	2025-12-04 04:23:59.702693	2025-12-04 04:23:59.702693	41
42	Instruction text goes here	2025-12-04 04:23:59.714771	2025-12-04 04:23:59.714771	42
43	Instruction text goes here	2025-12-04 04:23:59.740153	2025-12-04 04:23:59.740153	43
44	Instruction text goes here	2025-12-04 04:23:59.750804	2025-12-04 04:23:59.750804	44
45	Instruction text goes here	2025-12-04 04:23:59.77924	2025-12-04 04:23:59.77924	45
46	Instruction text goes here	2025-12-04 04:23:59.790561	2025-12-04 04:23:59.790561	46
47	Instruction text goes here	2025-12-04 04:23:59.816836	2025-12-04 04:23:59.816836	47
48	Instruction text goes here	2025-12-04 04:23:59.845746	2025-12-04 04:23:59.845746	48
49	Instruction text goes here	2025-12-04 04:23:59.874613	2025-12-04 04:23:59.874613	49
50	Instruction text goes here	2025-12-04 04:23:59.904556	2025-12-04 04:23:59.904556	50
51	Instruction text goes here	2025-12-04 04:23:59.929796	2025-12-04 04:23:59.929796	51
52	Instruction text goes here	2025-12-04 04:23:59.959353	2025-12-04 04:23:59.959353	52
53	Instruction text goes here	2025-12-04 04:23:59.974362	2025-12-04 04:23:59.974362	53
54	Instruction text goes here	2025-12-04 04:24:00.010093	2025-12-04 04:24:00.010093	54
55	Instruction text goes here	2025-12-04 04:24:00.039196	2025-12-04 04:24:00.039196	55
56	Instruction text goes here	2025-12-04 04:24:00.064476	2025-12-04 04:24:00.064476	56
57	Instruction text goes here	2025-12-04 04:24:00.092915	2025-12-04 04:24:00.092915	57
58	Instruction text goes here	2025-12-04 04:24:00.10602	2025-12-04 04:24:00.10602	58
59	Instruction text goes here	2025-12-04 04:24:00.134819	2025-12-04 04:24:00.134819	59
60	Instruction text goes here	2025-12-04 04:24:00.15909	2025-12-04 04:24:00.15909	60
61	Instruction text goes here	2025-12-04 04:24:00.17296	2025-12-04 04:24:00.17296	61
62	Instruction text goes here	2025-12-04 04:24:00.201548	2025-12-04 04:24:00.201548	62
63	Instruction text goes here	2025-12-04 04:24:00.229165	2025-12-04 04:24:00.229165	63
64	Instruction text goes here	2025-12-04 04:24:00.257983	2025-12-04 04:24:00.257983	64
65	Instruction text goes here	2025-12-04 04:24:00.284176	2025-12-04 04:24:00.284176	65
66	Instruction text goes here	2025-12-04 04:24:00.298195	2025-12-04 04:24:00.298195	66
67	Instruction text goes here	2025-12-04 04:24:00.321937	2025-12-04 04:24:00.321937	67
68	Instruction text goes here	2025-12-04 04:24:00.349891	2025-12-04 04:24:00.349891	68
69	Instruction text goes here	2025-12-04 04:24:00.363932	2025-12-04 04:24:00.363932	69
70	Instruction text goes here	2025-12-04 04:24:00.390079	2025-12-04 04:24:00.390079	70
71	Instruction text goes here	2025-12-04 04:24:00.403565	2025-12-04 04:24:00.403565	71
72	Instruction text goes here	2025-12-04 04:24:00.428974	2025-12-04 04:24:00.428974	72
73	Instruction text goes here	2025-12-04 04:24:00.441813	2025-12-04 04:24:00.441813	73
74	Instruction text goes here	2025-12-04 04:24:00.468998	2025-12-04 04:24:00.468998	74
75	Instruction text goes here	2025-12-04 04:24:00.49886	2025-12-04 04:24:00.49886	75
76	Instruction text goes here	2025-12-04 04:24:00.526746	2025-12-04 04:24:00.526746	76
77	Instruction text goes here	2025-12-04 04:24:00.55508	2025-12-04 04:24:00.55508	77
78	Instruction text goes here	2025-12-04 04:24:00.567874	2025-12-04 04:24:00.567874	78
79	Instruction text goes here	2025-12-04 04:24:00.596779	2025-12-04 04:24:00.596779	79
80	Instruction text goes here	2025-12-04 04:24:00.626735	2025-12-04 04:24:00.626735	80
81	Instruction text goes here	2025-12-04 04:24:00.655074	2025-12-04 04:24:00.655074	81
82	Instruction text goes here	2025-12-04 04:24:00.68426	2025-12-04 04:24:00.68426	82
83	Instruction text goes here	2025-12-04 04:24:00.698441	2025-12-04 04:24:00.698441	83
84	Instruction text goes here	2025-12-04 04:24:00.726293	2025-12-04 04:24:00.726293	84
85	Instruction text goes here	2025-12-04 04:24:00.753257	2025-12-04 04:24:00.753257	85
86	Instruction text goes here	2025-12-04 04:24:00.782803	2025-12-04 04:24:00.782803	86
87	Instruction text goes here	2025-12-04 04:24:00.813564	2025-12-04 04:24:00.813564	87
88	Instruction text goes here	2025-12-04 04:24:00.826894	2025-12-04 04:24:00.826894	88
89	Instruction text goes here	2025-12-04 04:24:00.85598	2025-12-04 04:24:00.85598	89
90	Instruction text goes here	2025-12-04 04:24:00.885782	2025-12-04 04:24:00.885782	90
91	Instruction text goes here	2025-12-04 04:24:00.898825	2025-12-04 04:24:00.898825	91
92	Instruction text goes here	2025-12-04 04:24:00.924894	2025-12-04 04:24:00.924894	92
93	Instruction text goes here	2025-12-04 04:24:00.952197	2025-12-04 04:24:00.952197	93
94	Instruction text goes here	2025-12-04 04:24:00.975621	2025-12-04 04:24:00.975621	94
95	Instruction text goes here	2025-12-04 04:24:01.002448	2025-12-04 04:24:01.002448	95
96	Instruction text goes here	2025-12-04 04:24:01.018628	2025-12-04 04:24:01.018628	96
97	Instruction text goes here	2025-12-04 04:24:01.044554	2025-12-04 04:24:01.044554	97
98	Instruction text goes here	2025-12-04 04:24:01.069255	2025-12-04 04:24:01.069255	98
99	Instruction text goes here	2025-12-04 04:24:01.083511	2025-12-04 04:24:01.083511	99
100	Instruction text goes here	2025-12-04 04:24:01.108488	2025-12-04 04:24:01.108488	100
101	Instruction text goes here	2025-12-04 04:24:01.12144	2025-12-04 04:24:01.12144	101
102	Instruction text goes here	2025-12-04 04:24:01.147934	2025-12-04 04:24:01.147934	102
103	Instruction text goes here	2025-12-04 04:24:01.175785	2025-12-04 04:24:01.175785	103
104	Instruction text goes here	2025-12-04 04:24:01.190456	2025-12-04 04:24:01.190456	104
105	Instruction text goes here	2025-12-04 04:24:01.217911	2025-12-04 04:24:01.217911	105
106	Instruction text goes here	2025-12-04 04:24:01.243054	2025-12-04 04:24:01.243054	106
107	Instruction text goes here	2025-12-04 04:24:01.259828	2025-12-04 04:24:01.259828	107
108	Instruction text goes here	2025-12-04 04:24:01.285576	2025-12-04 04:24:01.285576	108
109	Instruction text goes here	2025-12-04 04:24:01.299762	2025-12-04 04:24:01.299762	109
110	Instruction text goes here	2025-12-04 04:24:01.329464	2025-12-04 04:24:01.329464	110
111	Instruction text goes here	2025-12-04 04:24:01.343558	2025-12-04 04:24:01.343558	111
112	Instruction text goes here	2025-12-04 04:24:01.367585	2025-12-04 04:24:01.367585	112
113	Instruction text goes here	2025-12-04 04:24:01.397848	2025-12-04 04:24:01.397848	113
114	Instruction text goes here	2025-12-04 04:24:01.414701	2025-12-04 04:24:01.414701	114
115	Instruction text goes here	2025-12-04 04:24:01.438746	2025-12-04 04:24:01.438746	115
116	Instruction text goes here	2025-12-04 04:24:01.456274	2025-12-04 04:24:01.456274	116
117	Instruction text goes here	2025-12-04 04:24:01.484587	2025-12-04 04:24:01.484587	117
118	Instruction text goes here	2025-12-04 04:24:01.512017	2025-12-04 04:24:01.512017	118
119	Instruction text goes here	2025-12-04 04:24:01.541871	2025-12-04 04:24:01.541871	119
120	Instruction text goes here	2025-12-04 04:24:01.557281	2025-12-04 04:24:01.557281	120
121	Instruction text goes here	2025-12-04 04:24:01.590308	2025-12-04 04:24:01.590308	121
122	Instruction text goes here	2025-12-04 04:24:01.604361	2025-12-04 04:24:01.604361	122
123	Instruction text goes here	2025-12-04 04:24:01.633802	2025-12-04 04:24:01.633802	123
124	Instruction text goes here	2025-12-04 04:24:01.648643	2025-12-04 04:24:01.648643	124
125	Instruction text goes here	2025-12-04 04:24:01.675768	2025-12-04 04:24:01.675768	125
126	Instruction text goes here	2025-12-04 04:24:01.701499	2025-12-04 04:24:01.701499	126
127	Instruction text goes here	2025-12-04 04:24:01.728833	2025-12-04 04:24:01.728833	127
128	Instruction text goes here	2025-12-04 04:24:01.755589	2025-12-04 04:24:01.755589	128
129	Instruction text goes here	2025-12-04 04:24:01.771614	2025-12-04 04:24:01.771614	129
130	Instruction text goes here	2025-12-04 04:24:01.801639	2025-12-04 04:24:01.801639	130
131	Instruction text goes here	2025-12-04 04:24:01.829084	2025-12-04 04:24:01.829084	131
132	Instruction text goes here	2025-12-04 04:24:01.852376	2025-12-04 04:24:01.852376	132
133	Instruction text goes here	2025-12-04 04:24:01.881638	2025-12-04 04:24:01.881638	133
134	Instruction text goes here	2025-12-04 04:24:01.908623	2025-12-04 04:24:01.908623	134
135	Instruction text goes here	2025-12-04 04:24:01.923682	2025-12-04 04:24:01.923682	135
136	Instruction text goes here	2025-12-04 04:24:01.95105	2025-12-04 04:24:01.95105	136
137	Instruction text goes here	2025-12-04 04:24:01.965434	2025-12-04 04:24:01.965434	137
138	Instruction text goes here	2025-12-04 04:24:01.996462	2025-12-04 04:24:01.996462	138
139	Instruction text goes here	2025-12-04 04:24:02.010226	2025-12-04 04:24:02.010226	139
140	Instruction text goes here	2025-12-04 04:24:02.035105	2025-12-04 04:24:02.035105	140
141	Instruction text goes here	2025-12-04 04:24:02.06243	2025-12-04 04:24:02.06243	141
142	Instruction text goes here	2025-12-04 04:24:02.076849	2025-12-04 04:24:02.076849	142
143	Instruction text goes here	2025-12-04 04:24:02.104271	2025-12-04 04:24:02.104271	143
144	Instruction text goes here	2025-12-04 04:24:02.129655	2025-12-04 04:24:02.129655	144
145	Instruction text goes here	2025-12-04 04:24:02.154741	2025-12-04 04:24:02.154741	145
146	Instruction text goes here	2025-12-04 04:24:02.183446	2025-12-04 04:24:02.183446	146
147	Instruction text goes here	2025-12-04 04:24:02.198592	2025-12-04 04:24:02.198592	147
148	Instruction text goes here	2025-12-04 04:24:02.223132	2025-12-04 04:24:02.223132	148
149	Instruction text goes here	2025-12-04 04:24:02.253435	2025-12-04 04:24:02.253435	149
150	Instruction text goes here	2025-12-04 04:24:02.266606	2025-12-04 04:24:02.266606	150
151	Instruction text goes here	2025-12-04 04:24:02.292474	2025-12-04 04:24:02.292474	151
152	Instruction text goes here	2025-12-04 04:24:02.305495	2025-12-04 04:24:02.305495	152
153	Instruction text goes here	2025-12-04 04:24:02.332753	2025-12-04 04:24:02.332753	153
154	Instruction text goes here	2025-12-04 04:24:02.35705	2025-12-04 04:24:02.35705	154
155	Instruction text goes here	2025-12-04 04:24:02.368483	2025-12-04 04:24:02.368483	155
156	Instruction text goes here	2025-12-04 04:24:02.397031	2025-12-04 04:24:02.397031	156
157	Instruction text goes here	2025-12-04 04:24:02.412388	2025-12-04 04:24:02.412388	157
158	Instruction text goes here	2025-12-04 04:24:02.439005	2025-12-04 04:24:02.439005	158
159	Instruction text goes here	2025-12-04 04:24:02.453446	2025-12-04 04:24:02.453446	159
160	Instruction text goes here	2025-12-04 04:24:02.479478	2025-12-04 04:24:02.479478	160
161	Instruction text goes here	2025-12-04 04:24:02.492156	2025-12-04 04:24:02.492156	161
162	Instruction text goes here	2025-12-04 04:24:02.522029	2025-12-04 04:24:02.522029	162
163	Instruction text goes here	2025-12-04 04:24:02.535722	2025-12-04 04:24:02.535722	163
164	Instruction text goes here	2025-12-04 04:24:02.564512	2025-12-04 04:24:02.564512	164
165	Instruction text goes here	2025-12-04 04:24:02.588539	2025-12-04 04:24:02.588539	165
166	Instruction text goes here	2025-12-04 04:24:02.602612	2025-12-04 04:24:02.602612	166
167	Instruction text goes here	2025-12-04 04:24:02.627653	2025-12-04 04:24:02.627653	167
168	Instruction text goes here	2025-12-04 04:24:02.656414	2025-12-04 04:24:02.656414	168
169	Instruction text goes here	2025-12-04 04:24:02.686246	2025-12-04 04:24:02.686246	169
170	Instruction text goes here	2025-12-04 04:24:02.702956	2025-12-04 04:24:02.702956	170
171	Instruction text goes here	2025-12-04 04:24:02.733757	2025-12-04 04:24:02.733757	171
172	Instruction text goes here	2025-12-04 04:24:02.756817	2025-12-04 04:24:02.756817	172
173	Instruction text goes here	2025-12-04 04:24:02.78667	2025-12-04 04:24:02.78667	173
174	Instruction text goes here	2025-12-04 04:24:02.817074	2025-12-04 04:24:02.817074	174
175	Instruction text goes here	2025-12-04 04:24:02.843345	2025-12-04 04:24:02.843345	175
176	Instruction text goes here	2025-12-04 04:24:02.856976	2025-12-04 04:24:02.856976	176
177	Instruction text goes here	2025-12-04 04:24:02.886058	2025-12-04 04:24:02.886058	177
178	Instruction text goes here	2025-12-04 04:24:02.915086	2025-12-04 04:24:02.915086	178
179	Instruction text goes here	2025-12-04 04:24:02.92872	2025-12-04 04:24:02.92872	179
180	Instruction text goes here	2025-12-04 04:24:02.958889	2025-12-04 04:24:02.958889	180
181	Instruction text goes here	2025-12-04 04:24:02.996175	2025-12-04 04:24:02.996175	181
182	Instruction text goes here	2025-12-04 04:24:03.024224	2025-12-04 04:24:03.024224	182
183	Instruction text goes here	2025-12-04 04:24:03.039298	2025-12-04 04:24:03.039298	183
184	Instruction text goes here	2025-12-04 04:24:03.06429	2025-12-04 04:24:03.06429	184
185	Instruction text goes here	2025-12-04 04:24:03.09117	2025-12-04 04:24:03.09117	185
186	Instruction text goes here	2025-12-04 04:24:03.116932	2025-12-04 04:24:03.116932	186
187	Instruction text goes here	2025-12-04 04:24:03.143345	2025-12-04 04:24:03.143345	187
188	Instruction text goes here	2025-12-04 04:24:03.16825	2025-12-04 04:24:03.16825	188
189	Instruction text goes here	2025-12-04 04:24:03.19203	2025-12-04 04:24:03.19203	189
190	Instruction text goes here	2025-12-04 04:24:03.22334	2025-12-04 04:24:03.22334	190
191	Instruction text goes here	2025-12-04 04:24:03.255019	2025-12-04 04:24:03.255019	191
192	Instruction text goes here	2025-12-04 04:24:03.268018	2025-12-04 04:24:03.268018	192
193	Instruction text goes here	2025-12-04 04:24:03.294418	2025-12-04 04:24:03.294418	193
194	Instruction text goes here	2025-12-04 04:24:03.308896	2025-12-04 04:24:03.308896	194
195	Instruction text goes here	2025-12-04 04:24:03.337552	2025-12-04 04:24:03.337552	195
196	Instruction text goes here	2025-12-04 04:24:03.352155	2025-12-04 04:24:03.352155	196
197	Instruction text goes here	2025-12-04 04:24:03.377742	2025-12-04 04:24:03.377742	197
198	Instruction text goes here	2025-12-04 04:24:03.40808	2025-12-04 04:24:03.40808	198
199	Instruction text goes here	2025-12-04 04:24:03.421019	2025-12-04 04:24:03.421019	199
200	Instruction text goes here	2025-12-04 04:24:03.449256	2025-12-04 04:24:03.449256	200
201	Instruction text goes here	2025-12-04 04:24:03.475323	2025-12-04 04:24:03.475323	201
202	Instruction text goes here	2025-12-04 04:24:03.489047	2025-12-04 04:24:03.489047	202
203	Instruction text goes here	2025-12-04 04:24:03.515993	2025-12-04 04:24:03.515993	203
204	Instruction text goes here	2025-12-04 04:24:03.546114	2025-12-04 04:24:03.546114	204
205	Instruction text goes here	2025-12-04 04:24:03.559804	2025-12-04 04:24:03.559804	205
206	Instruction text goes here	2025-12-04 04:24:03.588652	2025-12-04 04:24:03.588652	206
207	Instruction text goes here	2025-12-04 04:24:03.614756	2025-12-04 04:24:03.614756	207
208	Instruction text goes here	2025-12-04 04:24:03.628363	2025-12-04 04:24:03.628363	208
209	Instruction text goes here	2025-12-04 04:24:03.653663	2025-12-04 04:24:03.653663	209
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
1	Consequatur iusto vel. In quasi delectus. Rerum impedit et.	1	\N	2025-12-04 04:23:58.720587	2025-12-04 04:23:58.720587
2	Suscipit quos et. Labore aut iure. Ut maiores expedita.	\N	1	2025-12-04 04:23:58.740529	2025-12-04 04:23:58.740529
3	Ea sit rerum. Ut sint quisquam. Rerum enim nesciunt.	2	\N	2025-12-04 04:23:58.782858	2025-12-04 04:23:58.782858
4	Autem quibusdam numquam. Aut qui voluptatem. Ex labore assumenda.	\N	2	2025-12-04 04:23:58.78904	2025-12-04 04:23:58.78904
5	Omnis delectus veritatis. Est dignissimos nihil. Beatae iure dolores.	\N	3	2025-12-04 04:23:58.805998	2025-12-04 04:23:58.805998
6	Consequuntur voluptate enim. Et cumque quis. Velit commodi nulla.	3	\N	2025-12-04 04:23:58.829098	2025-12-04 04:23:58.829098
7	Exercitationem nam optio. Eligendi nemo dolore. Voluptate officia animi.	\N	4	2025-12-04 04:23:58.832456	2025-12-04 04:23:58.832456
8	Laudantium sit in. Eius vero voluptatem. Totam illo molestias.	\N	5	2025-12-04 04:23:58.845368	2025-12-04 04:23:58.845368
9	Enim aliquid praesentium. Ea magni aut. Consectetur non deleniti.	4	\N	2025-12-04 04:23:58.865225	2025-12-04 04:23:58.865225
10	Iure asperiores quae. Voluptatem est eum. Est quas vero.	\N	6	2025-12-04 04:23:58.868393	2025-12-04 04:23:58.868393
11	Accusamus sit eaque. Omnis quos vero. Iusto suscipit voluptatem.	5	\N	2025-12-04 04:23:58.891075	2025-12-04 04:23:58.891075
12	Illo sunt doloremque. Placeat minus neque. Odit dolor earum.	\N	7	2025-12-04 04:23:58.894265	2025-12-04 04:23:58.894265
13	Id earum doloribus. Nihil harum porro. Et qui quae.	6	\N	2025-12-04 04:23:58.915745	2025-12-04 04:23:58.915745
14	Libero omnis quod. Magni maiores iste. Eveniet eligendi in.	\N	8	2025-12-04 04:23:58.91806	2025-12-04 04:23:58.91806
15	Explicabo est accusamus. Quo similique nostrum. Et perferendis repellendus.	7	\N	2025-12-04 04:23:58.943802	2025-12-04 04:23:58.943802
16	Id veritatis accusamus. Dolor voluptates molestiae. Enim voluptatem praesentium.	\N	9	2025-12-04 04:23:58.946908	2025-12-04 04:23:58.946908
17	Deleniti voluptatem voluptatem. Quia culpa minima. Aut perspiciatis dolor.	8	\N	2025-12-04 04:23:58.969847	2025-12-04 04:23:58.969847
18	Natus magnam id. Perspiciatis voluptatem ut. Nobis sed eos.	\N	10	2025-12-04 04:23:58.973549	2025-12-04 04:23:58.973549
19	Aut sit quia. Quibusdam est doloribus. Enim officia odio.	9	\N	2025-12-04 04:23:58.996682	2025-12-04 04:23:58.996682
20	Soluta sit cupiditate. Sunt libero reiciendis. Laudantium doloremque a.	\N	11	2025-12-04 04:23:58.999648	2025-12-04 04:23:58.999648
21	Ut est cum. Consequatur sint ad. Sed omnis assumenda.	10	\N	2025-12-04 04:23:59.019969	2025-12-04 04:23:59.019969
22	Exercitationem aut quo. Iusto at aut. Repudiandae laudantium aperiam.	\N	12	2025-12-04 04:23:59.023207	2025-12-04 04:23:59.023207
23	Asperiores aut laudantium. Omnis possimus quia. Molestias et rerum.	11	\N	2025-12-04 04:23:59.047088	2025-12-04 04:23:59.047088
24	Molestiae natus doloremque. Nisi modi laborum. Quia totam debitis.	\N	13	2025-12-04 04:23:59.049455	2025-12-04 04:23:59.049455
25	Velit voluptatem aperiam. Nihil eum est. Et ut fugit.	\N	14	2025-12-04 04:23:59.061416	2025-12-04 04:23:59.061416
26	Tempora dolores illo. Velit ut rerum. Voluptatem impedit aut.	12	\N	2025-12-04 04:23:59.082461	2025-12-04 04:23:59.082461
27	Quibusdam velit assumenda. Quia accusamus omnis. Ex aut sint.	\N	15	2025-12-04 04:23:59.085022	2025-12-04 04:23:59.085022
28	Accusantium temporibus expedita. Nihil quia est. Sit porro et.	13	\N	2025-12-04 04:23:59.104734	2025-12-04 04:23:59.104734
29	Dolorem ut sit. Blanditiis exercitationem quia. Earum consequatur quae.	\N	16	2025-12-04 04:23:59.107993	2025-12-04 04:23:59.107993
30	Officiis repellat et. Ut doloribus perspiciatis. Aut molestias est.	\N	17	2025-12-04 04:23:59.121437	2025-12-04 04:23:59.121437
31	Eum voluptas expedita. Culpa sunt consectetur. Vel explicabo nam.	14	\N	2025-12-04 04:23:59.140514	2025-12-04 04:23:59.140514
32	Molestiae architecto non. Labore ut ea. Omnis quod quasi.	\N	18	2025-12-04 04:23:59.143444	2025-12-04 04:23:59.143444
33	Quaerat laudantium molestias. Dolore laudantium ducimus. Iusto minus et.	15	\N	2025-12-04 04:23:59.167346	2025-12-04 04:23:59.167346
34	Dolor rerum laborum. Dolor ea sed. Possimus repudiandae rerum.	\N	19	2025-12-04 04:23:59.169961	2025-12-04 04:23:59.169961
35	Quam et ut. Architecto nihil cumque. Laborum sunt vel.	16	\N	2025-12-04 04:23:59.190998	2025-12-04 04:23:59.190998
36	Eaque nemo reiciendis. Sed aut iure. Ut et velit.	\N	20	2025-12-04 04:23:59.194166	2025-12-04 04:23:59.194166
37	Cumque ducimus harum. Amet voluptatem tempora. Totam voluptatum quasi.	17	\N	2025-12-04 04:23:59.2166	2025-12-04 04:23:59.2166
38	Incidunt nam qui. Aut nobis rem. Quibusdam dolorum ut.	\N	21	2025-12-04 04:23:59.220743	2025-12-04 04:23:59.220743
39	In repellat dolorum. Veniam facere harum. Et sapiente et.	18	\N	2025-12-04 04:23:59.246259	2025-12-04 04:23:59.246259
40	Aliquid sint id. Dolores rerum quos. Consequuntur velit excepturi.	\N	22	2025-12-04 04:23:59.249015	2025-12-04 04:23:59.249015
41	Mollitia voluptas numquam. Quia eos eveniet. Maiores esse vel.	\N	23	2025-12-04 04:23:59.26408	2025-12-04 04:23:59.26408
42	Ipsum magni ut. Cum rerum ipsam. Et necessitatibus corrupti.	19	\N	2025-12-04 04:23:59.285676	2025-12-04 04:23:59.285676
43	Sit qui provident. Quo adipisci est. Dolorem ex ut.	\N	24	2025-12-04 04:23:59.289134	2025-12-04 04:23:59.289134
44	Est et aliquid. Saepe doloribus consequatur. Qui fuga voluptatum.	\N	25	2025-12-04 04:23:59.302931	2025-12-04 04:23:59.302931
45	Atque quod qui. Facilis ipsum rem. Similique fuga blanditiis.	20	\N	2025-12-04 04:23:59.329281	2025-12-04 04:23:59.329281
46	Labore quos earum. Voluptatem porro quod. Occaecati totam omnis.	\N	26	2025-12-04 04:23:59.333117	2025-12-04 04:23:59.333117
47	Alias est iusto. Officia nulla labore. Nihil ex ullam.	\N	27	2025-12-04 04:23:59.346599	2025-12-04 04:23:59.346599
48	Velit sit quis. Quia quos aut. Quae dolorem explicabo.	21	\N	2025-12-04 04:23:59.372019	2025-12-04 04:23:59.372019
49	Ipsum itaque fugiat. Sequi mollitia voluptas. Voluptas facilis consequatur.	\N	28	2025-12-04 04:23:59.37524	2025-12-04 04:23:59.37524
50	In laborum accusamus. Ut fugit qui. Veniam et ad.	\N	29	2025-12-04 04:23:59.389331	2025-12-04 04:23:59.389331
51	Quis architecto nihil. Eos fugit est. Illo quos soluta.	22	\N	2025-12-04 04:23:59.41189	2025-12-04 04:23:59.41189
52	Ut eligendi ullam. Rem laudantium aut. Nemo aut necessitatibus.	\N	30	2025-12-04 04:23:59.41463	2025-12-04 04:23:59.41463
53	Aliquid maiores et. Quibusdam et autem. Et laboriosam quaerat.	23	\N	2025-12-04 04:23:59.441939	2025-12-04 04:23:59.441939
54	Accusantium voluptas corporis. Laboriosam eaque voluptatibus. Animi autem sapiente.	\N	31	2025-12-04 04:23:59.445214	2025-12-04 04:23:59.445214
55	Rerum debitis ut. Vel aspernatur qui. Dolor optio nam.	24	\N	2025-12-04 04:23:59.468886	2025-12-04 04:23:59.468886
56	Modi ipsam harum. Veritatis magnam suscipit. Ipsa quas tempora.	\N	32	2025-12-04 04:23:59.471767	2025-12-04 04:23:59.471767
57	Veritatis quia quasi. Consectetur voluptatem fugiat. Minima hic natus.	25	\N	2025-12-04 04:23:59.500173	2025-12-04 04:23:59.500173
58	Quaerat quia sequi. Voluptatibus aut doloribus. Libero est vel.	\N	33	2025-12-04 04:23:59.503553	2025-12-04 04:23:59.503553
59	Quia et explicabo. Dignissimos eveniet id. Temporibus voluptatem ab.	26	\N	2025-12-04 04:23:59.528649	2025-12-04 04:23:59.528649
60	Veritatis distinctio eaque. Assumenda suscipit mollitia. Aut maiores molestiae.	\N	34	2025-12-04 04:23:59.532025	2025-12-04 04:23:59.532025
61	Consequatur fugiat in. Nam qui consequatur. Quaerat placeat quisquam.	27	\N	2025-12-04 04:23:59.55494	2025-12-04 04:23:59.55494
62	Voluptas aut eligendi. Vel perferendis quo. Accusamus aut placeat.	\N	35	2025-12-04 04:23:59.558099	2025-12-04 04:23:59.558099
63	Id rem voluptas. Dolores temporibus incidunt. Sit commodi quaerat.	28	\N	2025-12-04 04:23:59.581682	2025-12-04 04:23:59.581682
64	Voluptates modi ut. Minus voluptates sed. Consequatur minima a.	\N	36	2025-12-04 04:23:59.584309	2025-12-04 04:23:59.584309
65	Alias non sed. Dolores cumque eum. Quod ut sed.	\N	37	2025-12-04 04:23:59.597587	2025-12-04 04:23:59.597587
66	Et ducimus blanditiis. Id molestias tenetur. Culpa ipsam quisquam.	29	\N	2025-12-04 04:23:59.620931	2025-12-04 04:23:59.620931
67	Est eum fugit. Exercitationem nulla perferendis. Autem qui nihil.	\N	38	2025-12-04 04:23:59.624276	2025-12-04 04:23:59.624276
68	Aliquid aspernatur voluptas. Reprehenderit similique voluptatum. Est nihil iste.	\N	39	2025-12-04 04:23:59.640606	2025-12-04 04:23:59.640606
69	Porro ipsa hic. Eos voluptatem aut. Iusto error qui.	30	\N	2025-12-04 04:23:59.662355	2025-12-04 04:23:59.662355
70	Dolor tenetur rerum. Facilis dolor natus. Enim est et.	\N	40	2025-12-04 04:23:59.666012	2025-12-04 04:23:59.666012
71	Quia totam quia. Rem velit exercitationem. Quia aut sequi.	31	\N	2025-12-04 04:23:59.689235	2025-12-04 04:23:59.689235
72	Fugiat placeat dolores. Cupiditate placeat recusandae. Aut quia culpa.	\N	41	2025-12-04 04:23:59.692828	2025-12-04 04:23:59.692828
73	Possimus corporis quae. Labore consectetur molestiae. Debitis molestias rem.	\N	42	2025-12-04 04:23:59.708396	2025-12-04 04:23:59.708396
74	Sit hic quibusdam. At provident odio. Quae velit rerum.	32	\N	2025-12-04 04:23:59.728899	2025-12-04 04:23:59.728899
75	Officiis est consequuntur. Illo quia ea. Enim velit rerum.	\N	43	2025-12-04 04:23:59.732215	2025-12-04 04:23:59.732215
76	Dolores et eum. Harum necessitatibus corrupti. Deleniti rerum ullam.	\N	44	2025-12-04 04:23:59.745267	2025-12-04 04:23:59.745267
77	Iusto necessitatibus blanditiis. Aspernatur deserunt iure. Ullam explicabo sunt.	33	\N	2025-12-04 04:23:59.766352	2025-12-04 04:23:59.766352
78	Rerum modi perspiciatis. Eaque nostrum corporis. Est ducimus harum.	\N	45	2025-12-04 04:23:59.769782	2025-12-04 04:23:59.769782
79	Dolorem ut labore. Sit deleniti voluptatem. Sequi veritatis qui.	\N	46	2025-12-04 04:23:59.784286	2025-12-04 04:23:59.784286
80	Animi et ut. Sunt cum aut. Fuga quos laudantium.	34	\N	2025-12-04 04:23:59.804985	2025-12-04 04:23:59.804985
81	Excepturi qui consequatur. Non et tempore. Ipsum quaerat nisi.	\N	47	2025-12-04 04:23:59.808228	2025-12-04 04:23:59.808228
82	Est nemo nulla. Fugit inventore delectus. Molestias quia asperiores.	35	\N	2025-12-04 04:23:59.832933	2025-12-04 04:23:59.832933
83	Id consequuntur deserunt. Qui vel consequatur. Eligendi ipsam explicabo.	\N	48	2025-12-04 04:23:59.8363	2025-12-04 04:23:59.8363
84	Deserunt a eligendi. Repellat ad sit. Deleniti sint vel.	36	\N	2025-12-04 04:23:59.86112	2025-12-04 04:23:59.86112
85	Explicabo placeat aut. Enim nam cupiditate. Molestiae aut dolorem.	\N	49	2025-12-04 04:23:59.864313	2025-12-04 04:23:59.864313
86	Veritatis quam nam. Necessitatibus nostrum minima. Aut numquam magnam.	37	\N	2025-12-04 04:23:59.889106	2025-12-04 04:23:59.889106
87	Quia sit perferendis. Soluta commodi ut. Omnis omnis mollitia.	\N	50	2025-12-04 04:23:59.892317	2025-12-04 04:23:59.892317
88	Commodi quibusdam incidunt. Iusto vel maxime. Sit impedit velit.	38	\N	2025-12-04 04:23:59.917828	2025-12-04 04:23:59.917828
89	Veritatis aliquam et. Soluta itaque nesciunt. Minus nobis natus.	\N	51	2025-12-04 04:23:59.921232	2025-12-04 04:23:59.921232
90	Consectetur quas et. Ex quia consectetur. Unde sit eos.	39	\N	2025-12-04 04:23:59.948196	2025-12-04 04:23:59.948196
91	Deleniti amet ut. Fugiat aliquam enim. Cupiditate et possimus.	\N	52	2025-12-04 04:23:59.950732	2025-12-04 04:23:59.950732
92	Quos ut et. Reprehenderit ducimus a. Minus dolore rerum.	\N	53	2025-12-04 04:23:59.963728	2025-12-04 04:23:59.963728
93	Omnis et dignissimos. Iste autem sed. Perspiciatis voluptates aut.	40	\N	2025-12-04 04:23:59.998019	2025-12-04 04:23:59.998019
94	Dolores veritatis debitis. Cumque non illo. Aut aut culpa.	\N	54	2025-12-04 04:24:00.001885	2025-12-04 04:24:00.001885
95	Placeat voluptatum dolor. Laborum inventore consequatur. Quasi distinctio in.	41	\N	2025-12-04 04:24:00.025471	2025-12-04 04:24:00.025471
96	Nihil itaque deserunt. Consequatur natus reiciendis. Aliquam sunt dolores.	\N	55	2025-12-04 04:24:00.028751	2025-12-04 04:24:00.028751
97	Aut iusto ipsum. Maiores vero aut. Autem ipsam neque.	42	\N	2025-12-04 04:24:00.052465	2025-12-04 04:24:00.052465
98	Voluptates harum sint. Et voluptates eius. Dolor deleniti sint.	\N	56	2025-12-04 04:24:00.055065	2025-12-04 04:24:00.055065
99	Placeat et minus. Autem et porro. Provident asperiores ad.	43	\N	2025-12-04 04:24:00.081256	2025-12-04 04:24:00.081256
100	Perspiciatis laboriosam sed. Reprehenderit consequatur accusamus. Fuga optio itaque.	\N	57	2025-12-04 04:24:00.083956	2025-12-04 04:24:00.083956
101	Impedit consequuntur delectus. Ad veniam quo. Reprehenderit est nihil.	\N	58	2025-12-04 04:24:00.097366	2025-12-04 04:24:00.097366
102	Facere veritatis fugit. Aut et quia. Fugiat fuga ut.	44	\N	2025-12-04 04:24:00.12125	2025-12-04 04:24:00.12125
103	Cumque nihil consequatur. In corporis id. Amet vel tempora.	\N	59	2025-12-04 04:24:00.124582	2025-12-04 04:24:00.124582
104	Voluptatem facilis similique. Non ea praesentium. Aliquid a qui.	45	\N	2025-12-04 04:24:00.149832	2025-12-04 04:24:00.149832
105	Et repellendus omnis. Similique est est. Deleniti id iure.	\N	60	2025-12-04 04:24:00.152636	2025-12-04 04:24:00.152636
106	Numquam magni praesentium. Voluptatem recusandae iste. In sunt tenetur.	\N	61	2025-12-04 04:24:00.163493	2025-12-04 04:24:00.163493
107	Ipsum deserunt et. Sit nemo quidem. Praesentium at ut.	46	\N	2025-12-04 04:24:00.187597	2025-12-04 04:24:00.187597
108	Suscipit ullam quibusdam. Facilis qui dignissimos. Vel aliquam incidunt.	\N	62	2025-12-04 04:24:00.190334	2025-12-04 04:24:00.190334
109	Aperiam a aliquid. Necessitatibus magni mollitia. Nam sequi voluptas.	47	\N	2025-12-04 04:24:00.217874	2025-12-04 04:24:00.217874
110	Vel minus consequatur. Et et qui. Laboriosam soluta sint.	\N	63	2025-12-04 04:24:00.22121	2025-12-04 04:24:00.22121
111	Nesciunt excepturi autem. Dolore quis sit. Dolorum ea voluptatem.	48	\N	2025-12-04 04:24:00.246418	2025-12-04 04:24:00.246418
112	Tempora id aperiam. Vel voluptas laudantium. Praesentium repudiandae beatae.	\N	64	2025-12-04 04:24:00.249868	2025-12-04 04:24:00.249868
113	Ut quis quos. Nisi vitae aut. Id occaecati voluptatem.	49	\N	2025-12-04 04:24:00.270638	2025-12-04 04:24:00.270638
114	Reiciendis facilis ut. Totam qui nam. Error atque cupiditate.	\N	65	2025-12-04 04:24:00.273933	2025-12-04 04:24:00.273933
115	Voluptas inventore porro. Ipsum sit velit. Tenetur iste asperiores.	\N	66	2025-12-04 04:24:00.289524	2025-12-04 04:24:00.289524
116	Error quam labore. Enim dolore perferendis. Iusto aut nobis.	50	\N	2025-12-04 04:24:00.311637	2025-12-04 04:24:00.311637
117	Consequatur voluptas architecto. Dolor quia molestiae. Excepturi quis enim.	\N	67	2025-12-04 04:24:00.31488	2025-12-04 04:24:00.31488
118	Enim deserunt quisquam. Quia debitis repudiandae. Ut ut optio.	51	\N	2025-12-04 04:24:00.337943	2025-12-04 04:24:00.337943
119	Ab sapiente voluptate. Libero labore commodi. Est quos corrupti.	\N	68	2025-12-04 04:24:00.341218	2025-12-04 04:24:00.341218
120	Qui atque est. Nisi ipsum veniam. Atque est a.	\N	69	2025-12-04 04:24:00.354961	2025-12-04 04:24:00.354961
121	Rerum reprehenderit minima. Dolore aut officiis. Sit porro et.	52	\N	2025-12-04 04:24:00.377874	2025-12-04 04:24:00.377874
122	Aperiam neque doloremque. Enim dolores et. Consequatur provident eius.	\N	70	2025-12-04 04:24:00.381488	2025-12-04 04:24:00.381488
123	Atque itaque quaerat. A maiores consectetur. Sint et est.	\N	71	2025-12-04 04:24:00.395846	2025-12-04 04:24:00.395846
124	Distinctio molestiae amet. Repudiandae labore corporis. A aliquid aut.	53	\N	2025-12-04 04:24:00.417966	2025-12-04 04:24:00.417966
125	Perferendis molestiae minima. Nam dolor iure. Totam ipsum quis.	\N	72	2025-12-04 04:24:00.421609	2025-12-04 04:24:00.421609
126	Perferendis cum voluptas. Sapiente quam ratione. Voluptatem alias fugiat.	\N	73	2025-12-04 04:24:00.434564	2025-12-04 04:24:00.434564
127	Voluptas qui odio. Veniam error quas. Sunt adipisci iste.	54	\N	2025-12-04 04:24:00.456675	2025-12-04 04:24:00.456675
128	Perferendis fuga excepturi. Sit ut qui. Itaque pariatur nam.	\N	74	2025-12-04 04:24:00.460119	2025-12-04 04:24:00.460119
129	Adipisci quis consequatur. Quia nulla recusandae. Impedit mollitia ipsa.	55	\N	2025-12-04 04:24:00.486715	2025-12-04 04:24:00.486715
130	Voluptas dolorem et. In incidunt minus. Quo rerum rerum.	\N	75	2025-12-04 04:24:00.490583	2025-12-04 04:24:00.490583
131	Et enim soluta. Quia eveniet est. Vel architecto facere.	56	\N	2025-12-04 04:24:00.515054	2025-12-04 04:24:00.515054
132	Sint adipisci delectus. Rem et magni. Voluptas cupiditate sed.	\N	76	2025-12-04 04:24:00.518781	2025-12-04 04:24:00.518781
133	Sunt explicabo consequatur. Aut perferendis eius. Molestiae id facilis.	57	\N	2025-12-04 04:24:00.542329	2025-12-04 04:24:00.542329
134	Voluptatem dolor vel. Voluptatibus quia ut. Libero est perspiciatis.	\N	77	2025-12-04 04:24:00.544995	2025-12-04 04:24:00.544995
135	Libero quisquam nihil. Et dolorem porro. Neque rem dolorum.	\N	78	2025-12-04 04:24:00.559779	2025-12-04 04:24:00.559779
136	Et inventore est. Quia ipsa aut. Illum vel commodi.	58	\N	2025-12-04 04:24:00.582238	2025-12-04 04:24:00.582238
137	Sequi mollitia nihil. Necessitatibus quibusdam odio. Ipsum expedita veritatis.	\N	79	2025-12-04 04:24:00.58553	2025-12-04 04:24:00.58553
138	Error enim vero. Nemo impedit corrupti. Nemo repudiandae ut.	59	\N	2025-12-04 04:24:00.613567	2025-12-04 04:24:00.613567
139	Ullam provident quia. Sed voluptas ad. Dolorem incidunt laboriosam.	\N	80	2025-12-04 04:24:00.617284	2025-12-04 04:24:00.617284
140	Id rerum quasi. Quo illo nobis. Suscipit repellendus excepturi.	60	\N	2025-12-04 04:24:00.643014	2025-12-04 04:24:00.643014
141	Velit non quos. Earum amet exercitationem. Laborum nisi doloribus.	\N	81	2025-12-04 04:24:00.646324	2025-12-04 04:24:00.646324
142	Rerum ratione laudantium. Voluptate soluta qui. Cumque repellendus est.	61	\N	2025-12-04 04:24:00.670406	2025-12-04 04:24:00.670406
143	Nulla autem est. Vel dolores quo. Ipsam quibusdam iusto.	\N	82	2025-12-04 04:24:00.674071	2025-12-04 04:24:00.674071
144	Fuga quia doloremque. Repellat non exercitationem. Optio libero asperiores.	\N	83	2025-12-04 04:24:00.689862	2025-12-04 04:24:00.689862
145	Eaque accusantium voluptatem. Necessitatibus dolores veniam. Quo et animi.	62	\N	2025-12-04 04:24:00.712755	2025-12-04 04:24:00.712755
146	Soluta eius eligendi. Reiciendis velit est. Voluptatem debitis nobis.	\N	84	2025-12-04 04:24:00.716038	2025-12-04 04:24:00.716038
147	Exercitationem qui quo. Ea voluptatem nulla. Harum eveniet mollitia.	63	\N	2025-12-04 04:24:00.740406	2025-12-04 04:24:00.740406
148	Quasi ut repellendus. Consequatur natus quas. Molestiae a vero.	\N	85	2025-12-04 04:24:00.743062	2025-12-04 04:24:00.743062
149	Repudiandae architecto officia. Qui qui laboriosam. In aut aut.	64	\N	2025-12-04 04:24:00.767524	2025-12-04 04:24:00.767524
150	Accusamus mollitia deserunt. Sunt et at. Alias a repudiandae.	\N	86	2025-12-04 04:24:00.770801	2025-12-04 04:24:00.770801
151	Nostrum quos inventore. Est eveniet deserunt. Repellat eius et.	65	\N	2025-12-04 04:24:00.798141	2025-12-04 04:24:00.798141
152	Consectetur aliquam ut. Architecto accusantium enim. Sed nulla sequi.	\N	87	2025-12-04 04:24:00.800845	2025-12-04 04:24:00.800845
153	Perspiciatis ipsam delectus. Exercitationem itaque quas. Quisquam tenetur atque.	\N	88	2025-12-04 04:24:00.818063	2025-12-04 04:24:00.818063
154	Quo quia corrupti. Voluptatem earum laboriosam. Quibusdam velit porro.	66	\N	2025-12-04 04:24:00.839764	2025-12-04 04:24:00.839764
155	Itaque quo voluptas. Voluptatibus excepturi delectus. Sed non veniam.	\N	89	2025-12-04 04:24:00.842609	2025-12-04 04:24:00.842609
156	Et eum praesentium. Sed quia quae. Nostrum aspernatur ipsam.	67	\N	2025-12-04 04:24:00.871944	2025-12-04 04:24:00.871944
157	Doloribus eos quia. Vel magni porro. Asperiores mollitia deserunt.	\N	90	2025-12-04 04:24:00.875256	2025-12-04 04:24:00.875256
158	Ullam illum mollitia. Hic sed reiciendis. Molestiae qui molestiae.	\N	91	2025-12-04 04:24:00.890853	2025-12-04 04:24:00.890853
159	Sit blanditiis velit. Non vel non. Eius eum doloribus.	68	\N	2025-12-04 04:24:00.912414	2025-12-04 04:24:00.912414
160	Ipsum molestiae praesentium. Nobis iure et. Commodi sed sapiente.	\N	92	2025-12-04 04:24:00.916203	2025-12-04 04:24:00.916203
161	Quis est voluptas. Rem sapiente nemo. Consequatur ullam delectus.	69	\N	2025-12-04 04:24:00.940609	2025-12-04 04:24:00.940609
162	Ipsa aut perferendis. At autem omnis. Beatae laboriosam maxime.	\N	93	2025-12-04 04:24:00.943318	2025-12-04 04:24:00.943318
163	Qui unde deleniti. Quis eum rerum. Ipsam nostrum pariatur.	70	\N	2025-12-04 04:24:00.964992	2025-12-04 04:24:00.964992
164	Sapiente rem delectus. Cupiditate in ut. Eos ex tempore.	\N	94	2025-12-04 04:24:00.967544	2025-12-04 04:24:00.967544
165	Ut modi enim. Magnam voluptatem fugit. Numquam nam quaerat.	71	\N	2025-12-04 04:24:00.989874	2025-12-04 04:24:00.989874
166	Aut animi consequatur. Ipsum eos qui. Nulla mollitia et.	\N	95	2025-12-04 04:24:00.993082	2025-12-04 04:24:00.993082
167	Ab sit modi. Quo repudiandae est. Reiciendis sint quos.	\N	96	2025-12-04 04:24:01.007541	2025-12-04 04:24:01.007541
168	Atque incidunt praesentium. Inventore facilis assumenda. Ipsum consectetur sint.	72	\N	2025-12-04 04:24:01.033509	2025-12-04 04:24:01.033509
169	Minima minus dolores. Et qui reiciendis. Dolorum earum consequatur.	\N	97	2025-12-04 04:24:01.036756	2025-12-04 04:24:01.036756
170	Iste maiores aspernatur. Aut cupiditate et. Voluptates non a.	73	\N	2025-12-04 04:24:01.058618	2025-12-04 04:24:01.058618
171	Non modi aut. Debitis distinctio vitae. Atque est eos.	\N	98	2025-12-04 04:24:01.061302	2025-12-04 04:24:01.061302
172	Eum voluptas repellat. Quisquam porro enim. Dignissimos sed mollitia.	\N	99	2025-12-04 04:24:01.073748	2025-12-04 04:24:01.073748
173	Cupiditate tempore nobis. Error laborum molestiae. Hic eum dolorem.	74	\N	2025-12-04 04:24:01.097365	2025-12-04 04:24:01.097365
174	Aut eum maxime. Dolor cum ut. Eaque repudiandae possimus.	\N	100	2025-12-04 04:24:01.100601	2025-12-04 04:24:01.100601
175	Molestiae et odit. Fugit qui officiis. Asperiores velit dignissimos.	\N	101	2025-12-04 04:24:01.114062	2025-12-04 04:24:01.114062
176	Ut in et. Totam id voluptatibus. Et deleniti aperiam.	75	\N	2025-12-04 04:24:01.13584	2025-12-04 04:24:01.13584
177	Quia occaecati nihil. Perspiciatis qui accusamus. Laboriosam illum sit.	\N	102	2025-12-04 04:24:01.138399	2025-12-04 04:24:01.138399
178	Et quo hic. Asperiores neque dolorem. Sint sapiente eos.	76	\N	2025-12-04 04:24:01.164543	2025-12-04 04:24:01.164543
179	Omnis delectus aut. Enim temporibus distinctio. Fugiat dolorem modi.	\N	103	2025-12-04 04:24:01.167769	2025-12-04 04:24:01.167769
180	Odit et ipsam. Voluptatem quis rerum. Ut ducimus neque.	\N	104	2025-12-04 04:24:01.180775	2025-12-04 04:24:01.180775
181	Voluptatibus quo non. Ab omnis ducimus. Labore et voluptatem.	77	\N	2025-12-04 04:24:01.206814	2025-12-04 04:24:01.206814
182	Ratione voluptates vitae. Cupiditate inventore accusamus. Laudantium officia sint.	\N	105	2025-12-04 04:24:01.210055	2025-12-04 04:24:01.210055
183	Qui iste quaerat. Qui ullam voluptates. Quia libero et.	78	\N	2025-12-04 04:24:01.231247	2025-12-04 04:24:01.231247
184	Aliquid a sequi. Omnis accusantium corrupti. Tempora et hic.	\N	106	2025-12-04 04:24:01.235018	2025-12-04 04:24:01.235018
185	Quos ea velit. Voluptas unde eos. Non occaecati excepturi.	\N	107	2025-12-04 04:24:01.248486	2025-12-04 04:24:01.248486
186	Ea vel enim. Quas ullam aut. Est cum temporibus.	79	\N	2025-12-04 04:24:01.274821	2025-12-04 04:24:01.274821
187	Nesciunt est modi. Repellendus perspiciatis ullam. In quibusdam praesentium.	\N	108	2025-12-04 04:24:01.27833	2025-12-04 04:24:01.27833
188	Sed enim occaecati. Nam sed a. Incidunt ut at.	\N	109	2025-12-04 04:24:01.290993	2025-12-04 04:24:01.290993
189	Magni doloribus ducimus. Est voluptatibus assumenda. Perferendis ea voluptatum.	80	\N	2025-12-04 04:24:01.315177	2025-12-04 04:24:01.315177
190	Fuga nulla tenetur. Corporis fuga et. At velit ab.	\N	110	2025-12-04 04:24:01.318813	2025-12-04 04:24:01.318813
191	Doloremque aut veniam. Illo ut quibusdam. In ad non.	\N	111	2025-12-04 04:24:01.334954	2025-12-04 04:24:01.334954
192	Nemo atque voluptatum. Non asperiores temporibus. Ullam magnam ipsum.	81	\N	2025-12-04 04:24:01.357703	2025-12-04 04:24:01.357703
193	Sunt accusamus ut. Illum praesentium fugiat. Nostrum cupiditate et.	\N	112	2025-12-04 04:24:01.361276	2025-12-04 04:24:01.361276
194	Id omnis sed. Vero non illum. Fuga eum aut.	82	\N	2025-12-04 04:24:01.384128	2025-12-04 04:24:01.384128
195	Earum expedita eum. Numquam tempore animi. Quo provident nihil.	\N	113	2025-12-04 04:24:01.38739	2025-12-04 04:24:01.38739
196	Perferendis nemo voluptas. Et dicta iste. Quia neque pariatur.	\N	114	2025-12-04 04:24:01.402886	2025-12-04 04:24:01.402886
197	Non tempore magnam. Aperiam quos expedita. Blanditiis placeat molestias.	83	\N	2025-12-04 04:24:01.428929	2025-12-04 04:24:01.428929
198	Voluptates est dolor. Explicabo itaque sed. Minima ad deleniti.	\N	115	2025-12-04 04:24:01.43158	2025-12-04 04:24:01.43158
199	Ratione architecto pariatur. Dicta commodi sequi. Cupiditate odit sit.	\N	116	2025-12-04 04:24:01.443157	2025-12-04 04:24:01.443157
200	Odit aperiam voluptatem. Alias maxime ullam. Et quia odio.	84	\N	2025-12-04 04:24:01.471892	2025-12-04 04:24:01.471892
201	Delectus iure fuga. Beatae atque possimus. Est sapiente quos.	\N	117	2025-12-04 04:24:01.475166	2025-12-04 04:24:01.475166
202	Deserunt vel nisi. Eos molestiae quasi. Porro nam accusamus.	85	\N	2025-12-04 04:24:01.499803	2025-12-04 04:24:01.499803
203	Velit quod maxime. Pariatur culpa doloribus. Distinctio ratione et.	\N	118	2025-12-04 04:24:01.503458	2025-12-04 04:24:01.503458
204	Placeat ut laborum. Delectus reprehenderit ipsum. Nemo laborum consequatur.	86	\N	2025-12-04 04:24:01.528029	2025-12-04 04:24:01.528029
205	Eum facilis perferendis. Non dolores perspiciatis. Error voluptas enim.	\N	119	2025-12-04 04:24:01.531878	2025-12-04 04:24:01.531878
206	Quisquam ducimus inventore. Quod sed sint. Id quos omnis.	\N	120	2025-12-04 04:24:01.547263	2025-12-04 04:24:01.547263
207	Provident modi eveniet. Voluptas sed consequatur. Earum et quo.	87	\N	2025-12-04 04:24:01.579056	2025-12-04 04:24:01.579056
208	Doloribus incidunt qui. Ipsam animi dolorem. Nulla distinctio qui.	\N	121	2025-12-04 04:24:01.582643	2025-12-04 04:24:01.582643
209	Pariatur sint ut. Commodi nostrum dolore. Et delectus error.	\N	122	2025-12-04 04:24:01.595569	2025-12-04 04:24:01.595569
210	Ipsum totam aut. Nisi ratione ex. Temporibus dolores quae.	88	\N	2025-12-04 04:24:01.622348	2025-12-04 04:24:01.622348
211	Est aut est. Voluptatem qui maxime. Recusandae sequi provident.	\N	123	2025-12-04 04:24:01.625825	2025-12-04 04:24:01.625825
212	Blanditiis dolor laborum. Expedita et sed. Et labore neque.	\N	124	2025-12-04 04:24:01.638901	2025-12-04 04:24:01.638901
213	Inventore reprehenderit quia. Eos officiis quia. Suscipit officiis voluptatibus.	89	\N	2025-12-04 04:24:01.662624	2025-12-04 04:24:01.662624
214	Pariatur id dignissimos. Culpa ut porro. Repellat impedit id.	\N	125	2025-12-04 04:24:01.66534	2025-12-04 04:24:01.66534
215	Qui beatae ipsa. Culpa impedit vitae. Consectetur nostrum ut.	90	\N	2025-12-04 04:24:01.689689	2025-12-04 04:24:01.689689
216	Eum est provident. Assumenda fuga ab. Nihil sit sapiente.	\N	126	2025-12-04 04:24:01.692211	2025-12-04 04:24:01.692211
217	Repudiandae ab non. Facere illo incidunt. Officia amet iusto.	91	\N	2025-12-04 04:24:01.716696	2025-12-04 04:24:01.716696
218	Quia enim nostrum. Ipsum consectetur alias. Commodi sint totam.	\N	127	2025-12-04 04:24:01.72037	2025-12-04 04:24:01.72037
219	Vero sed fugit. Sint quia ut. Atque ex quis.	92	\N	2025-12-04 04:24:01.745716	2025-12-04 04:24:01.745716
220	Consequuntur corrupti magni. Fugiat soluta quo. Nesciunt consequuntur possimus.	\N	128	2025-12-04 04:24:01.74937	2025-12-04 04:24:01.74937
221	Facilis praesentium quia. Mollitia distinctio facere. Fugit eos repellendus.	\N	129	2025-12-04 04:24:01.763445	2025-12-04 04:24:01.763445
222	Neque quod quas. Quisquam mollitia illum. Veritatis ratione libero.	93	\N	2025-12-04 04:24:01.788395	2025-12-04 04:24:01.788395
223	Fuga consectetur sit. Provident id doloremque. Sunt hic fugit.	\N	130	2025-12-04 04:24:01.792218	2025-12-04 04:24:01.792218
224	Dolores ut molestiae. Consequatur qui veritatis. Soluta consequatur asperiores.	94	\N	2025-12-04 04:24:01.816724	2025-12-04 04:24:01.816724
225	Iure eveniet voluptatibus. Culpa sit sunt. Numquam cupiditate ipsam.	\N	131	2025-12-04 04:24:01.820486	2025-12-04 04:24:01.820486
226	Atque autem accusamus. Atque sequi libero. Excepturi rerum praesentium.	95	\N	2025-12-04 04:24:01.8424	2025-12-04 04:24:01.8424
227	Consectetur enim praesentium. Dicta dolore sed. Ut temporibus rerum.	\N	132	2025-12-04 04:24:01.844937	2025-12-04 04:24:01.844937
228	Dolores nisi nobis. Consequuntur consequatur eum. Sunt accusantium esse.	96	\N	2025-12-04 04:24:01.867701	2025-12-04 04:24:01.867701
229	Ea voluptatem beatae. Placeat aut ut. Nobis esse voluptatibus.	\N	133	2025-12-04 04:24:01.870373	2025-12-04 04:24:01.870373
230	Voluptatem sint maxime. Et eos saepe. Et enim dolor.	97	\N	2025-12-04 04:24:01.896196	2025-12-04 04:24:01.896196
231	Temporibus ut et. Quas ut sed. Voluptatum laudantium fuga.	\N	134	2025-12-04 04:24:01.89998	2025-12-04 04:24:01.89998
232	Saepe adipisci odio. Debitis quasi voluptatum. Ducimus omnis in.	\N	135	2025-12-04 04:24:01.914056	2025-12-04 04:24:01.914056
233	Qui nemo eos. Totam est deleniti. Rerum rerum consequuntur.	98	\N	2025-12-04 04:24:01.938728	2025-12-04 04:24:01.938728
234	Ut eaque exercitationem. Aut quam ad. Inventore repellendus consequuntur.	\N	136	2025-12-04 04:24:01.941403	2025-12-04 04:24:01.941403
235	Eius et reprehenderit. Cumque dolorem et. Sit qui aut.	\N	137	2025-12-04 04:24:01.955477	2025-12-04 04:24:01.955477
236	Itaque et ea. Qui beatae voluptatum. A quia nemo.	99	\N	2025-12-04 04:24:01.982971	2025-12-04 04:24:01.982971
237	Ipsum a in. Deleniti praesentium quia. Et omnis ea.	\N	138	2025-12-04 04:24:01.986804	2025-12-04 04:24:01.986804
238	Qui est quo. Corporis temporibus est. Unde voluptas ex.	\N	139	2025-12-04 04:24:02.001518	2025-12-04 04:24:02.001518
239	Modi consequatur reiciendis. Itaque doloremque necessitatibus. Labore ut minima.	100	\N	2025-12-04 04:24:02.023496	2025-12-04 04:24:02.023496
240	Officiis minima et. Accusamus debitis excepturi. Architecto omnis rerum.	\N	140	2025-12-04 04:24:02.027217	2025-12-04 04:24:02.027217
241	Facere mollitia et. Aliquid quae molestiae. Voluptas ullam expedita.	101	\N	2025-12-04 04:24:02.04844	2025-12-04 04:24:02.04844
242	Facilis ipsam velit. Quis suscipit tempora. Quasi ut dolores.	\N	141	2025-12-04 04:24:02.051802	2025-12-04 04:24:02.051802
243	Sunt beatae aliquam. Odio qui quis. Aut pariatur quis.	\N	142	2025-12-04 04:24:02.067477	2025-12-04 04:24:02.067477
244	Mollitia enim delectus. Optio sint sit. Id a exercitationem.	102	\N	2025-12-04 04:24:02.092909	2025-12-04 04:24:02.092909
245	Dicta non dolor. Consequatur suscipit omnis. Ut aut possimus.	\N	143	2025-12-04 04:24:02.096164	2025-12-04 04:24:02.096164
246	Consequatur qui architecto. Fugiat rem eum. Illo sint ea.	103	\N	2025-12-04 04:24:02.117502	2025-12-04 04:24:02.117502
247	Est ullam optio. Qui earum odio. Est et suscipit.	\N	144	2025-12-04 04:24:02.120145	2025-12-04 04:24:02.120145
248	Itaque dolorem rerum. Vel consequatur natus. Rem qui et.	104	\N	2025-12-04 04:24:02.141167	2025-12-04 04:24:02.141167
249	Quae veritatis iusto. Voluptas dolor sunt. Ea nihil beatae.	\N	145	2025-12-04 04:24:02.144532	2025-12-04 04:24:02.144532
250	Doloremque repellendus id. Error est eius. Fuga ut aut.	105	\N	2025-12-04 04:24:02.170624	2025-12-04 04:24:02.170624
251	Hic atque culpa. Repellat commodi eaque. Magnam optio earum.	\N	146	2025-12-04 04:24:02.173932	2025-12-04 04:24:02.173932
252	Sint animi in. Provident et asperiores. Et nostrum qui.	\N	147	2025-12-04 04:24:02.188758	2025-12-04 04:24:02.188758
253	Ipsam et occaecati. Repellat maiores iure. Culpa soluta beatae.	106	\N	2025-12-04 04:24:02.212818	2025-12-04 04:24:02.212818
254	Minima maxime sint. Accusantium et et. Asperiores iusto aut.	\N	148	2025-12-04 04:24:02.215438	2025-12-04 04:24:02.215438
255	Est quaerat minima. Molestias aut ea. Magnam fuga iusto.	107	\N	2025-12-04 04:24:02.239128	2025-12-04 04:24:02.239128
256	Natus rerum eos. Delectus velit laudantium. Nesciunt ipsam saepe.	\N	149	2025-12-04 04:24:02.242778	2025-12-04 04:24:02.242778
257	Quidem a qui. Ratione omnis numquam. Fugiat dolore et.	\N	150	2025-12-04 04:24:02.258765	2025-12-04 04:24:02.258765
258	Asperiores eligendi blanditiis. Nostrum voluptas rerum. Vitae nostrum consectetur.	108	\N	2025-12-04 04:24:02.282082	2025-12-04 04:24:02.282082
259	Suscipit ex saepe. Alias earum vel. Vitae omnis nam.	\N	151	2025-12-04 04:24:02.285402	2025-12-04 04:24:02.285402
260	Omnis odit exercitationem. Dolor voluptatibus distinctio. Quia nostrum ut.	\N	152	2025-12-04 04:24:02.297684	2025-12-04 04:24:02.297684
261	Aliquid consectetur animi. Culpa libero eaque. Quis itaque enim.	109	\N	2025-12-04 04:24:02.320325	2025-12-04 04:24:02.320325
262	Facilis qui aut. Rerum non est. Voluptatum recusandae quo.	\N	153	2025-12-04 04:24:02.322946	2025-12-04 04:24:02.322946
263	Velit qui quo. Quisquam voluptatem laudantium. Sit est est.	110	\N	2025-12-04 04:24:02.343582	2025-12-04 04:24:02.343582
264	Quo in inventore. Voluptatem magni rem. Tenetur velit quam.	\N	154	2025-12-04 04:24:02.34624	2025-12-04 04:24:02.34624
265	Quisquam quidem cupiditate. Quasi cumque adipisci. Rerum sed id.	\N	155	2025-12-04 04:24:02.36157	2025-12-04 04:24:02.36157
266	Eum voluptas odio. Voluptatem vitae qui. Quae error dolor.	111	\N	2025-12-04 04:24:02.382773	2025-12-04 04:24:02.382773
267	Iusto molestiae consequuntur. Distinctio et eum. Aut hic sequi.	\N	156	2025-12-04 04:24:02.385318	2025-12-04 04:24:02.385318
268	Et suscipit repellendus. Voluptas quo quisquam. Magnam nostrum cum.	\N	157	2025-12-04 04:24:02.401436	2025-12-04 04:24:02.401436
269	Et natus ex. Qui soluta et. Omnis cum non.	112	\N	2025-12-04 04:24:02.426467	2025-12-04 04:24:02.426467
270	Nihil molestiae at. Consequatur sunt magni. Ut deleniti sapiente.	\N	158	2025-12-04 04:24:02.429872	2025-12-04 04:24:02.429872
271	Veritatis similique rerum. Et quae at. Dolores praesentium sit.	\N	159	2025-12-04 04:24:02.444026	2025-12-04 04:24:02.444026
272	Debitis alias accusamus. Aut nemo totam. Saepe similique reprehenderit.	113	\N	2025-12-04 04:24:02.465473	2025-12-04 04:24:02.465473
273	Officia molestiae numquam. Quod sint et. Vel quaerat ex.	\N	160	2025-12-04 04:24:02.468087	2025-12-04 04:24:02.468087
274	Vitae enim doloribus. Sed blanditiis qui. Quod atque et.	\N	161	2025-12-04 04:24:02.484106	2025-12-04 04:24:02.484106
275	Ut debitis accusamus. Voluptatibus ea eos. Facilis velit nihil.	114	\N	2025-12-04 04:24:02.508909	2025-12-04 04:24:02.508909
276	Architecto perspiciatis cumque. Modi et enim. Molestiae a in.	\N	162	2025-12-04 04:24:02.512091	2025-12-04 04:24:02.512091
277	Autem omnis facere. Provident ratione animi. Esse rem voluptate.	\N	163	2025-12-04 04:24:02.527014	2025-12-04 04:24:02.527014
278	Dolorum ut officiis. Rerum molestias aut. Iusto vero dolorem.	115	\N	2025-12-04 04:24:02.551665	2025-12-04 04:24:02.551665
279	Ducimus assumenda sint. Qui ad corrupti. Et soluta nemo.	\N	164	2025-12-04 04:24:02.555311	2025-12-04 04:24:02.555311
280	Sed est placeat. Cum doloremque quaerat. Quas enim iste.	116	\N	2025-12-04 04:24:02.57905	2025-12-04 04:24:02.57905
281	Quos ipsam at. Itaque voluptatem consequuntur. Hic vitae ea.	\N	165	2025-12-04 04:24:02.58158	2025-12-04 04:24:02.58158
282	Ullam iure rerum. Amet numquam nihil. Sed commodi nesciunt.	\N	166	2025-12-04 04:24:02.593012	2025-12-04 04:24:02.593012
283	A doloremque ut. Officia at odit. Sequi est reiciendis.	117	\N	2025-12-04 04:24:02.615965	2025-12-04 04:24:02.615965
284	Eum aut porro. Nesciunt ipsum dignissimos. Vel dolorum et.	\N	167	2025-12-04 04:24:02.619148	2025-12-04 04:24:02.619148
285	Quas consequatur in. Alias reprehenderit voluptatem. Sint sequi maxime.	118	\N	2025-12-04 04:24:02.642391	2025-12-04 04:24:02.642391
286	Facere officiis nam. Pariatur consequatur et. Error eaque ut.	\N	168	2025-12-04 04:24:02.647161	2025-12-04 04:24:02.647161
287	Delectus voluptatem minus. Repudiandae inventore perferendis. Saepe et optio.	119	\N	2025-12-04 04:24:02.672872	2025-12-04 04:24:02.672872
288	Labore amet et. Dolores aut dignissimos. Ipsam distinctio ut.	\N	169	2025-12-04 04:24:02.67614	2025-12-04 04:24:02.67614
289	Totam quam non. Possimus est molestiae. Ut aut impedit.	\N	170	2025-12-04 04:24:02.691453	2025-12-04 04:24:02.691453
290	Impedit saepe iusto. Eius sint expedita. Quos earum eos.	120	\N	2025-12-04 04:24:02.719972	2025-12-04 04:24:02.719972
291	Iure ut esse. Ipsum distinctio et. Id id temporibus.	\N	171	2025-12-04 04:24:02.723563	2025-12-04 04:24:02.723563
292	Quam odit quas. Quisquam eos possimus. Voluptatem optio nulla.	121	\N	2025-12-04 04:24:02.745384	2025-12-04 04:24:02.745384
293	Quia molestiae ad. Ea quia quisquam. Consequuntur quisquam maxime.	\N	172	2025-12-04 04:24:02.747986	2025-12-04 04:24:02.747986
294	Aut eos vitae. Autem repudiandae dolorem. Fugit est odio.	122	\N	2025-12-04 04:24:02.772437	2025-12-04 04:24:02.772437
295	Dignissimos voluptatum eaque. Aperiam sit reiciendis. Ut tenetur porro.	\N	173	2025-12-04 04:24:02.776088	2025-12-04 04:24:02.776088
296	Similique omnis dolores. Molestiae eligendi placeat. Magnam voluptates qui.	123	\N	2025-12-04 04:24:02.803206	2025-12-04 04:24:02.803206
297	Non libero fuga. Quia voluptatem ut. Dolorem et dolor.	\N	174	2025-12-04 04:24:02.806837	2025-12-04 04:24:02.806837
298	Placeat tempora et. In laboriosam esse. Eius ex consequuntur.	124	\N	2025-12-04 04:24:02.831778	2025-12-04 04:24:02.831778
299	Sit repellat voluptatem. Quod omnis perspiciatis. Repellat sapiente inventore.	\N	175	2025-12-04 04:24:02.835013	2025-12-04 04:24:02.835013
300	Id voluptatem facilis. Praesentium commodi autem. Sint quam eos.	\N	176	2025-12-04 04:24:02.84836	2025-12-04 04:24:02.84836
301	Commodi id cupiditate. Nihil exercitationem itaque. Eum officiis similique.	125	\N	2025-12-04 04:24:02.872767	2025-12-04 04:24:02.872767
302	Quibusdam aut totam. Iure qui molestiae. Numquam iste unde.	\N	177	2025-12-04 04:24:02.876715	2025-12-04 04:24:02.876715
303	In in quia. Consequuntur molestias labore. Architecto sit impedit.	126	\N	2025-12-04 04:24:02.901094	2025-12-04 04:24:02.901094
304	Excepturi et quia. Asperiores culpa consequatur. Sunt quos quas.	\N	178	2025-12-04 04:24:02.904704	2025-12-04 04:24:02.904704
305	Non praesentium in. Qui numquam est. Officiis modi quis.	\N	179	2025-12-04 04:24:02.920738	2025-12-04 04:24:02.920738
306	Repudiandae occaecati ut. Qui iusto aut. Libero et voluptatibus.	127	\N	2025-12-04 04:24:02.944235	2025-12-04 04:24:02.944235
307	Molestiae voluptatem distinctio. Cum sunt et. Consectetur architecto molestiae.	\N	180	2025-12-04 04:24:02.947877	2025-12-04 04:24:02.947877
308	Id ex repudiandae. Molestiae totam tempore. Perspiciatis aut ut.	128	\N	2025-12-04 04:24:02.976109	2025-12-04 04:24:02.976109
309	A accusantium voluptatem. Vitae earum molestiae. Animi et nesciunt.	\N	181	2025-12-04 04:24:02.986768	2025-12-04 04:24:02.986768
310	Tempora sequi nemo. Maiores sunt neque. Et explicabo ea.	129	\N	2025-12-04 04:24:03.010934	2025-12-04 04:24:03.010934
311	Beatae est culpa. Autem dignissimos vel. Vero et quo.	\N	182	2025-12-04 04:24:03.014362	2025-12-04 04:24:03.014362
312	Ullam facere est. Reiciendis distinctio quod. Excepturi ut consequatur.	\N	183	2025-12-04 04:24:03.02951	2025-12-04 04:24:03.02951
313	Officiis sed alias. Aut optio ratione. Aut veritatis vel.	130	\N	2025-12-04 04:24:03.052857	2025-12-04 04:24:03.052857
314	Consequuntur ut quia. Cupiditate facere laudantium. Omnis natus debitis.	\N	184	2025-12-04 04:24:03.056317	2025-12-04 04:24:03.056317
315	Occaecati omnis et. Optio id qui. Est saepe qui.	131	\N	2025-12-04 04:24:03.080063	2025-12-04 04:24:03.080063
316	Molestias illo sit. Et provident velit. A error facilis.	\N	185	2025-12-04 04:24:03.083315	2025-12-04 04:24:03.083315
317	Quod praesentium nemo. Id similique suscipit. Nihil voluptas officiis.	132	\N	2025-12-04 04:24:03.103548	2025-12-04 04:24:03.103548
318	Minima rerum ab. Et qui esse. Ad cumque qui.	\N	186	2025-12-04 04:24:03.106817	2025-12-04 04:24:03.106817
319	Nisi doloremque veritatis. Mollitia autem neque. Magni odio voluptatem.	133	\N	2025-12-04 04:24:03.134555	2025-12-04 04:24:03.134555
320	Ipsam optio omnis. Qui adipisci pariatur. Unde excepturi facilis.	\N	187	2025-12-04 04:24:03.137888	2025-12-04 04:24:03.137888
321	Corrupti et praesentium. Illum dolorum quod. Voluptas delectus nihil.	134	\N	2025-12-04 04:24:03.15605	2025-12-04 04:24:03.15605
322	Et error quas. Blanditiis quo iure. Amet voluptas fugiat.	\N	188	2025-12-04 04:24:03.159425	2025-12-04 04:24:03.159425
323	Unde consequuntur saepe. Est dolorem ducimus. Sequi quasi laboriosam.	135	\N	2025-12-04 04:24:03.183179	2025-12-04 04:24:03.183179
324	Est nihil dolores. Et qui sed. Amet rem veniam.	\N	189	2025-12-04 04:24:03.186471	2025-12-04 04:24:03.186471
325	Et quam assumenda. Non est ratione. Delectus dolorem et.	136	\N	2025-12-04 04:24:03.210225	2025-12-04 04:24:03.210225
326	Mollitia ex perspiciatis. Ea doloremque suscipit. Itaque et accusantium.	\N	190	2025-12-04 04:24:03.213782	2025-12-04 04:24:03.213782
327	Magni id unde. Magnam adipisci dolorem. Dicta dolorum ad.	137	\N	2025-12-04 04:24:03.2404	2025-12-04 04:24:03.2404
328	Quo voluptas a. Distinctio id praesentium. Quidem quae voluptas.	\N	191	2025-12-04 04:24:03.243786	2025-12-04 04:24:03.243786
329	Assumenda magni deserunt. Unde eius et. Asperiores ut delectus.	\N	192	2025-12-04 04:24:03.260032	2025-12-04 04:24:03.260032
330	Id adipisci in. Sunt quasi aut. Iure aut quasi.	138	\N	2025-12-04 04:24:03.282561	2025-12-04 04:24:03.282561
331	Maxime eaque id. Perferendis impedit quasi. Magnam vitae et.	\N	193	2025-12-04 04:24:03.285827	2025-12-04 04:24:03.285827
332	Rem assumenda molestiae. Totam laboriosam exercitationem. Officiis tenetur corrupti.	\N	194	2025-12-04 04:24:03.299466	2025-12-04 04:24:03.299466
333	Ipsa quo mollitia. Et nemo rerum. Autem possimus natus.	139	\N	2025-12-04 04:24:03.324471	2025-12-04 04:24:03.324471
334	Molestiae non est. Dolores quaerat dicta. Nisi doloribus quod.	\N	195	2025-12-04 04:24:03.327806	2025-12-04 04:24:03.327806
335	Eum alias voluptate. Ipsam sunt non. Possimus sed rerum.	\N	196	2025-12-04 04:24:03.342812	2025-12-04 04:24:03.342812
336	Dolor dolores voluptatem. Eius est numquam. A architecto perspiciatis.	140	\N	2025-12-04 04:24:03.367335	2025-12-04 04:24:03.367335
337	Consequuntur magnam nulla. Magni quia sint. Voluptatibus laborum sit.	\N	197	2025-12-04 04:24:03.370551	2025-12-04 04:24:03.370551
338	Modi enim officia. Velit in minus. Repellat id qui.	141	\N	2025-12-04 04:24:03.395311	2025-12-04 04:24:03.395311
339	Quae voluptatem pariatur. Suscipit corporis quo. Qui velit numquam.	\N	198	2025-12-04 04:24:03.398583	2025-12-04 04:24:03.398583
340	Voluptatem magnam voluptatem. Odio est aliquid. Possimus doloremque vel.	\N	199	2025-12-04 04:24:03.413131	2025-12-04 04:24:03.413131
341	Aut natus minima. Voluptatem praesentium ab. Autem non deleniti.	142	\N	2025-12-04 04:24:03.437263	2025-12-04 04:24:03.437263
342	Quia natus expedita. Autem voluptas eos. Maxime rerum corporis.	\N	200	2025-12-04 04:24:03.440682	2025-12-04 04:24:03.440682
343	Qui explicabo iusto. Provident dolor nihil. Aut excepturi placeat.	143	\N	2025-12-04 04:24:03.463446	2025-12-04 04:24:03.463446
344	Asperiores rerum eligendi. Nam officiis rerum. Animi in dignissimos.	\N	201	2025-12-04 04:24:03.46671	2025-12-04 04:24:03.46671
345	Rem assumenda molestias. Illum nihil facere. Incidunt rerum dolore.	\N	202	2025-12-04 04:24:03.481095	2025-12-04 04:24:03.481095
346	Odio aut et. Inventore doloribus est. Occaecati quia ea.	144	\N	2025-12-04 04:24:03.503935	2025-12-04 04:24:03.503935
347	Fuga sapiente sint. Omnis dolore voluptatem. Mollitia necessitatibus ad.	\N	203	2025-12-04 04:24:03.50742	2025-12-04 04:24:03.50742
348	Molestiae excepturi necessitatibus. Blanditiis consequatur sit. Et pariatur earum.	145	\N	2025-12-04 04:24:03.533165	2025-12-04 04:24:03.533165
349	Incidunt laborum voluptatem. Et perferendis aspernatur. Voluptatem ad numquam.	\N	204	2025-12-04 04:24:03.536506	2025-12-04 04:24:03.536506
350	Ullam expedita ab. Quasi expedita sunt. Laudantium et repudiandae.	\N	205	2025-12-04 04:24:03.551197	2025-12-04 04:24:03.551197
351	Adipisci impedit quam. Tempora ex dolor. Rerum dicta quaerat.	146	\N	2025-12-04 04:24:03.576699	2025-12-04 04:24:03.576699
352	Eaque nam praesentium. Quia quae nostrum. Quam incidunt voluptatem.	\N	206	2025-12-04 04:24:03.580022	2025-12-04 04:24:03.580022
353	Non amet perferendis. Nostrum ullam molestiae. Vel culpa qui.	147	\N	2025-12-04 04:24:03.603338	2025-12-04 04:24:03.603338
354	Ad qui perspiciatis. Eligendi necessitatibus ab. Consectetur culpa aut.	\N	207	2025-12-04 04:24:03.606581	2025-12-04 04:24:03.606581
355	Amet sapiente dolorem. Sunt voluptatem delectus. Aut sunt maiores.	\N	208	2025-12-04 04:24:03.619769	2025-12-04 04:24:03.619769
356	Qui quia occaecati. Aut aut id. Aut et eligendi.	148	\N	2025-12-04 04:24:03.642218	2025-12-04 04:24:03.642218
357	Deserunt quae dolore. Atque odit molestiae. Et fuga autem.	\N	209	2025-12-04 04:24:03.645878	2025-12-04 04:24:03.645878
358	Placeat dolorem reiciendis. Perspiciatis quis et. Magnam vero quasi.	149	\N	2025-12-04 04:24:03.66761	2025-12-04 04:24:03.66761
359	Qui rerum fugit. Veritatis neque omnis. Qui aperiam laboriosam.	\N	210	2025-12-04 04:24:03.670831	2025-12-04 04:24:03.670831
360	Consequatur excepturi ipsam. Sit vel dolor. Dolorum ipsum quia.	150	\N	2025-12-04 04:24:04.023986	2025-12-04 04:24:04.023986
361	Quaerat sit qui. Laudantium qui consequatur. Ex tempore possimus.	\N	211	2025-12-04 04:24:04.027346	2025-12-04 04:24:04.027346
362	Minima molestiae consectetur. Dolorem quia voluptatibus. Laborum quasi et.	151	\N	2025-12-04 04:24:04.046286	2025-12-04 04:24:04.046286
363	Porro omnis maxime. Sunt dolor mollitia. Ex qui minima.	\N	212	2025-12-04 04:24:04.049567	2025-12-04 04:24:04.049567
364	Vero nobis deserunt. Eum quia explicabo. Officiis ullam aperiam.	152	\N	2025-12-04 04:24:04.068957	2025-12-04 04:24:04.068957
365	Pariatur autem voluptatem. Maiores optio sint. Ut consequuntur inventore.	\N	213	2025-12-04 04:24:04.072209	2025-12-04 04:24:04.072209
366	Aspernatur voluptatem nihil. Dolorem quo voluptatem. Et est vel.	153	\N	2025-12-04 04:24:04.106587	2025-12-04 04:24:04.106587
367	Dicta incidunt neque. Numquam cumque quidem. Reiciendis maxime ut.	\N	214	2025-12-04 04:24:04.111566	2025-12-04 04:24:04.111566
368	Neque voluptatibus quidem. Vero qui id. Laborum molestiae quaerat.	154	\N	2025-12-04 04:24:04.138371	2025-12-04 04:24:04.138371
369	Sed consequatur qui. Alias ut eligendi. Ut sed libero.	\N	215	2025-12-04 04:24:04.1418	2025-12-04 04:24:04.1418
370	Animi et rerum. Ab est quia. Sunt officia ipsum.	155	\N	2025-12-04 04:24:04.170709	2025-12-04 04:24:04.170709
371	Praesentium quae sequi. Vitae voluptatum optio. Quaerat quam atque.	\N	216	2025-12-04 04:24:04.17407	2025-12-04 04:24:04.17407
372	Deserunt consectetur velit. Beatae ab tempora. Necessitatibus sunt velit.	156	\N	2025-12-04 04:24:04.195099	2025-12-04 04:24:04.195099
373	Debitis inventore non. Ipsa nostrum ut. Numquam et laudantium.	\N	217	2025-12-04 04:24:04.198414	2025-12-04 04:24:04.198414
374	Consequatur dolorem voluptas. Repellendus omnis illum. Quia quo nihil.	157	\N	2025-12-04 04:24:04.219153	2025-12-04 04:24:04.219153
375	Sit distinctio autem. Aliquam excepturi provident. Labore quibusdam et.	\N	218	2025-12-04 04:24:04.222506	2025-12-04 04:24:04.222506
376	Dolorem est velit. Aut aspernatur pariatur. Nulla sed rem.	158	\N	2025-12-04 04:24:04.244287	2025-12-04 04:24:04.244287
377	Voluptates aut amet. Et dignissimos similique. Rerum hic et.	\N	219	2025-12-04 04:24:04.247465	2025-12-04 04:24:04.247465
378	Alias maiores illum. Commodi saepe quasi. Voluptatem est qui.	159	\N	2025-12-04 04:24:04.268362	2025-12-04 04:24:04.268362
379	Voluptatem qui debitis. In ab praesentium. Esse qui provident.	\N	220	2025-12-04 04:24:04.27188	2025-12-04 04:24:04.27188
380	At et in. Nam commodi ut. Quasi qui molestiae.	160	\N	2025-12-04 04:24:04.291392	2025-12-04 04:24:04.291392
381	Ipsam et beatae. Fuga praesentium quia. Maxime accusantium laborum.	\N	221	2025-12-04 04:24:04.294689	2025-12-04 04:24:04.294689
382	Voluptatem quam deserunt. Omnis et vel. Perspiciatis iste neque.	161	\N	2025-12-04 04:24:04.318492	2025-12-04 04:24:04.318492
383	Optio vel ex. Doloribus vel qui. Cum qui quidem.	\N	222	2025-12-04 04:24:04.321822	2025-12-04 04:24:04.321822
384	Minima excepturi qui. Quibusdam possimus eos. Quidem cumque repellat.	162	\N	2025-12-04 04:24:04.342861	2025-12-04 04:24:04.342861
385	Distinctio sit consequatur. Corrupti consectetur voluptates. Dignissimos doloremque repellendus.	\N	223	2025-12-04 04:24:04.34611	2025-12-04 04:24:04.34611
386	Dignissimos aliquam error. Sit molestiae ut. Eum quo vel.	163	\N	2025-12-04 04:24:04.367969	2025-12-04 04:24:04.367969
387	Et minima enim. Dolor dignissimos aspernatur. Provident explicabo aperiam.	\N	224	2025-12-04 04:24:04.371723	2025-12-04 04:24:04.371723
388	Dolor similique et. Corrupti eos harum. Earum ea sunt.	164	\N	2025-12-04 04:24:04.39631	2025-12-04 04:24:04.39631
389	Qui velit tenetur. Mollitia vel omnis. Ut provident perspiciatis.	\N	225	2025-12-04 04:24:04.399542	2025-12-04 04:24:04.399542
390	Quam et est. Totam commodi perspiciatis. Molestias nesciunt rerum.	165	\N	2025-12-04 04:24:04.418749	2025-12-04 04:24:04.418749
391	Amet ex quis. Quas sit assumenda. Totam sit possimus.	\N	226	2025-12-04 04:24:04.421975	2025-12-04 04:24:04.421975
392	Deserunt neque et. Quo ea eos. Sit quod et.	166	\N	2025-12-04 04:24:04.445935	2025-12-04 04:24:04.445935
393	Facilis enim esse. Voluptas deleniti est. Dolorem dolores eaque.	\N	227	2025-12-04 04:24:04.449182	2025-12-04 04:24:04.449182
394	Sunt nemo accusamus. Deserunt consequatur nesciunt. Consectetur rerum et.	167	\N	2025-12-04 04:24:04.468107	2025-12-04 04:24:04.468107
395	Veritatis perferendis blanditiis. Sed quia beatae. Iste ut accusamus.	\N	228	2025-12-04 04:24:04.47143	2025-12-04 04:24:04.47143
396	Eos in similique. Ut cum laboriosam. Quo eos et.	168	\N	2025-12-04 04:24:04.495077	2025-12-04 04:24:04.495077
397	Assumenda id aspernatur. Natus voluptatum error. Corrupti consequuntur et.	\N	229	2025-12-04 04:24:04.498348	2025-12-04 04:24:04.498348
398	Nam accusamus aspernatur. Voluptate nostrum est. Voluptatem tempore repudiandae.	169	\N	2025-12-04 04:24:04.524042	2025-12-04 04:24:04.524042
399	Autem et eum. Minus qui voluptatem. Labore soluta eaque.	\N	230	2025-12-04 04:24:04.527357	2025-12-04 04:24:04.527357
400	Numquam aspernatur maxime. Ea id beatae. Nisi sit ducimus.	170	\N	2025-12-04 04:24:04.546685	2025-12-04 04:24:04.546685
401	Adipisci ut numquam. Et fuga voluptas. Ipsa eum est.	\N	231	2025-12-04 04:24:04.54992	2025-12-04 04:24:04.54992
402	Quia perferendis quaerat. Nam voluptas voluptates. Magni aut laborum.	171	\N	2025-12-04 04:24:04.569934	2025-12-04 04:24:04.569934
403	Et placeat rerum. Error suscipit qui. Ullam nam expedita.	\N	232	2025-12-04 04:24:04.573219	2025-12-04 04:24:04.573219
404	Eum magnam autem. Aliquid aut sed. Aut ea corrupti.	172	\N	2025-12-04 04:24:04.595206	2025-12-04 04:24:04.595206
405	Qui et in. Est officiis aut. Quisquam ipsam eum.	\N	233	2025-12-04 04:24:04.598483	2025-12-04 04:24:04.598483
406	Mollitia deleniti illo. Exercitationem omnis hic. Perspiciatis distinctio et.	173	\N	2025-12-04 04:24:04.620063	2025-12-04 04:24:04.620063
407	Debitis minus temporibus. Sapiente et vel. Deleniti repellendus commodi.	\N	234	2025-12-04 04:24:04.623312	2025-12-04 04:24:04.623312
408	Sunt sunt aut. Repellat quo nihil. Sint tempore placeat.	174	\N	2025-12-04 04:24:04.646189	2025-12-04 04:24:04.646189
409	Fugit qui quis. Maxime ut et. Autem sunt veritatis.	\N	235	2025-12-04 04:24:04.64955	2025-12-04 04:24:04.64955
410	Reiciendis molestias non. Enim veniam aut. Occaecati facilis eum.	175	\N	2025-12-04 04:24:04.667939	2025-12-04 04:24:04.667939
411	Magnam qui expedita. Voluptatem facilis repellat. Maxime voluptas corporis.	\N	236	2025-12-04 04:24:04.671157	2025-12-04 04:24:04.671157
412	Qui fuga recusandae. Illo velit aut. Sunt enim alias.	176	\N	2025-12-04 04:24:04.691593	2025-12-04 04:24:04.691593
413	Iste deleniti doloremque. Consectetur quos laudantium. Similique dolores tempore.	\N	237	2025-12-04 04:24:04.694856	2025-12-04 04:24:04.694856
414	Ut nam est. Fuga ut officiis. Cupiditate qui aut.	177	\N	2025-12-04 04:24:04.717433	2025-12-04 04:24:04.717433
415	Quaerat explicabo velit. Repudiandae debitis et. Et sed nulla.	\N	238	2025-12-04 04:24:04.720636	2025-12-04 04:24:04.720636
416	Quia aliquid ad. Sequi sit earum. Fugit magnam veniam.	178	\N	2025-12-04 04:24:04.741806	2025-12-04 04:24:04.741806
417	Magni in laborum. Rerum assumenda reiciendis. Consequatur eius aut.	\N	239	2025-12-04 04:24:04.745214	2025-12-04 04:24:04.745214
418	Non quia quisquam. Consequatur officiis qui. Aut eius culpa.	179	\N	2025-12-04 04:24:04.764942	2025-12-04 04:24:04.764942
419	Est et velit. Eos rerum itaque. Fugiat et qui.	\N	240	2025-12-04 04:24:04.768172	2025-12-04 04:24:04.768172
420	Rem consectetur explicabo. Nihil neque pariatur. Molestias distinctio ipsum.	180	\N	2025-12-04 04:24:04.787973	2025-12-04 04:24:04.787973
421	Ea laboriosam occaecati. Dolor earum illum. Incidunt recusandae ducimus.	\N	241	2025-12-04 04:24:04.791182	2025-12-04 04:24:04.791182
422	Qui ipsam sint. Sed enim error. Tenetur vero harum.	181	\N	2025-12-04 04:24:04.811603	2025-12-04 04:24:04.811603
423	Consequatur recusandae impedit. Quod officia ut. Nihil dolor vel.	\N	242	2025-12-04 04:24:04.814781	2025-12-04 04:24:04.814781
424	Id qui accusantium. Ducimus porro vitae. Quas maxime ratione.	182	\N	2025-12-04 04:24:04.836405	2025-12-04 04:24:04.836405
425	Accusamus sed rem. Consequuntur accusamus facilis. Quasi dolor minus.	\N	243	2025-12-04 04:24:04.839955	2025-12-04 04:24:04.839955
426	Corrupti non dolores. Explicabo voluptas eaque. Et et quis.	183	\N	2025-12-04 04:24:04.861557	2025-12-04 04:24:04.861557
427	Ut maiores exercitationem. Ab officia voluptate. Velit qui aut.	\N	244	2025-12-04 04:24:04.864802	2025-12-04 04:24:04.864802
428	Eveniet ut atque. Perspiciatis vero aspernatur. Nostrum et vel.	184	\N	2025-12-04 04:24:04.887572	2025-12-04 04:24:04.887572
429	Assumenda ut quam. Exercitationem porro ipsa. Libero pariatur sit.	\N	245	2025-12-04 04:24:04.890953	2025-12-04 04:24:04.890953
430	Magnam laborum ut. Ad aut tempore. Voluptas sint voluptatem.	185	\N	2025-12-04 04:24:04.910584	2025-12-04 04:24:04.910584
431	Consequuntur veritatis molestiae. Id aut sit. Inventore at iure.	\N	246	2025-12-04 04:24:04.913779	2025-12-04 04:24:04.913779
432	Nostrum a minus. Rerum magnam nihil. Aut culpa quas.	186	\N	2025-12-04 04:24:04.935342	2025-12-04 04:24:04.935342
433	Veritatis et autem. Porro quia architecto. Fuga debitis quod.	\N	247	2025-12-04 04:24:04.938752	2025-12-04 04:24:04.938752
434	Ut quo ut. Atque commodi ut. Deleniti dolores magni.	187	\N	2025-12-04 04:24:04.961276	2025-12-04 04:24:04.961276
435	Ut eius neque. Quam qui voluptatibus. At eaque doloribus.	\N	248	2025-12-04 04:24:04.96449	2025-12-04 04:24:04.96449
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (id, action, resource_id, service_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: phones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.phones (id, created_at, updated_at, number, service_type, resource_id, description, service_id, contact_id, language_id) FROM stdin;
1	2025-12-04 04:23:58.701702	2025-12-04 04:23:58.701702	+13602512834;ext=4239	Business	1	\N	\N	\N	\N
2	2025-12-04 04:23:58.775238	2025-12-04 04:23:58.775238	+18653478674;ext=3596	Business	2	\N	\N	\N	\N
3	2025-12-04 04:23:58.823635	2025-12-04 04:23:58.823635	+14259146019;ext=3779	Business	3	\N	\N	\N	\N
4	2025-12-04 04:23:58.858488	2025-12-04 04:23:58.858488	+17814052370;ext=6656	Business	4	\N	\N	\N	\N
5	2025-12-04 04:23:58.883149	2025-12-04 04:23:58.883149	+14135734255	Business	5	\N	\N	\N	\N
6	2025-12-04 04:23:58.907173	2025-12-04 04:23:58.907173	+18049125961;ext=0967	Business	6	\N	\N	\N	\N
7	2025-12-04 04:23:58.935304	2025-12-04 04:23:58.935304	+18635701814;ext=1262	Business	7	\N	\N	\N	\N
8	2025-12-04 04:23:58.962785	2025-12-04 04:23:58.962785	+14044353496	Business	8	\N	\N	\N	\N
9	2025-12-04 04:23:58.987949	2025-12-04 04:23:58.987949	+12092039868	Business	9	\N	\N	\N	\N
10	2025-12-04 04:23:59.012269	2025-12-04 04:23:59.012269	+15102172951;ext=2036	Business	10	\N	\N	\N	\N
11	2025-12-04 04:23:59.040848	2025-12-04 04:23:59.040848	+16016199302;ext=4408	Business	11	\N	\N	\N	\N
12	2025-12-04 04:23:59.075472	2025-12-04 04:23:59.075472	+17315132581	Business	12	\N	\N	\N	\N
13	2025-12-04 04:23:59.097825	2025-12-04 04:23:59.097825	+17755614269	Business	13	\N	\N	\N	\N
14	2025-12-04 04:23:59.134764	2025-12-04 04:23:59.134764	+19018147216;ext=6215	Business	14	\N	\N	\N	\N
15	2025-12-04 04:23:59.158969	2025-12-04 04:23:59.158969	+18062064969;ext=8383	Business	15	\N	\N	\N	\N
16	2025-12-04 04:23:59.182655	2025-12-04 04:23:59.182655	+18315021179	Business	16	\N	\N	\N	\N
17	2025-12-04 04:23:59.208917	2025-12-04 04:23:59.208917	+19479031667	Business	17	\N	\N	\N	\N
18	2025-12-04 04:23:59.235719	2025-12-04 04:23:59.235719	+18472187200	Business	18	\N	\N	\N	\N
19	2025-12-04 04:23:59.279084	2025-12-04 04:23:59.279084	+16619107025;ext=2241	Business	19	\N	\N	\N	\N
20	2025-12-04 04:23:59.317765	2025-12-04 04:23:59.317765	+16055104552	Business	20	\N	\N	\N	\N
21	2025-12-04 04:23:59.363343	2025-12-04 04:23:59.363343	+14198054251	Business	21	\N	\N	\N	\N
22	2025-12-04 04:23:59.403708	2025-12-04 04:23:59.403708	+19019368312	Business	22	\N	\N	\N	\N
23	2025-12-04 04:23:59.431625	2025-12-04 04:23:59.431625	+14349075774	Business	23	\N	\N	\N	\N
24	2025-12-04 04:23:59.459527	2025-12-04 04:23:59.459527	+19169048157	Business	24	\N	\N	\N	\N
25	2025-12-04 04:23:59.490338	2025-12-04 04:23:59.490338	+19083078913;ext=0788	Business	25	\N	\N	\N	\N
26	2025-12-04 04:23:59.520526	2025-12-04 04:23:59.520526	+16153345241;ext=2635	Business	26	\N	\N	\N	\N
27	2025-12-04 04:23:59.548663	2025-12-04 04:23:59.548663	+19209010986	Business	27	\N	\N	\N	\N
28	2025-12-04 04:23:59.576275	2025-12-04 04:23:59.576275	+13078040498	Business	28	\N	\N	\N	\N
29	2025-12-04 04:23:59.613631	2025-12-04 04:23:59.613631	+14345632799;ext=5042	Business	29	\N	\N	\N	\N
30	2025-12-04 04:23:59.654534	2025-12-04 04:23:59.654534	+15745099679;ext=6008	Business	30	\N	\N	\N	\N
31	2025-12-04 04:23:59.682082	2025-12-04 04:23:59.682082	+17318086850	Business	31	\N	\N	\N	\N
32	2025-12-04 04:23:59.721906	2025-12-04 04:23:59.721906	+12075707959	Business	32	\N	\N	\N	\N
33	2025-12-04 04:23:59.757841	2025-12-04 04:23:59.757841	+15038176071;ext=2207	Business	33	\N	\N	\N	\N
34	2025-12-04 04:23:59.797677	2025-12-04 04:23:59.797677	+19893088902;ext=9404	Business	34	\N	\N	\N	\N
35	2025-12-04 04:23:59.823567	2025-12-04 04:23:59.823567	+19545124757;ext=4463	Business	35	\N	\N	\N	\N
36	2025-12-04 04:23:59.852495	2025-12-04 04:23:59.852495	+15719595408;ext=9746	Business	36	\N	\N	\N	\N
37	2025-12-04 04:23:59.881361	2025-12-04 04:23:59.881361	+18138323012	Business	37	\N	\N	\N	\N
38	2025-12-04 04:23:59.911566	2025-12-04 04:23:59.911566	+12484022268	Business	38	\N	\N	\N	\N
39	2025-12-04 04:23:59.938132	2025-12-04 04:23:59.938132	+18283613947;ext=7659	Business	39	\N	\N	\N	\N
40	2025-12-04 04:23:59.989928	2025-12-04 04:23:59.989928	+15742244435;ext=3952	Business	40	\N	\N	\N	\N
41	2025-12-04 04:24:00.017344	2025-12-04 04:24:00.017344	+12148057608	Business	41	\N	\N	\N	\N
42	2025-12-04 04:24:00.045835	2025-12-04 04:24:00.045835	+14064174185;ext=7636	Business	42	\N	\N	\N	\N
43	2025-12-04 04:24:00.070991	2025-12-04 04:24:00.070991	+14176678544	Business	43	\N	\N	\N	\N
44	2025-12-04 04:24:00.113249	2025-12-04 04:24:00.113249	+15188122474	Business	44	\N	\N	\N	\N
45	2025-12-04 04:24:00.141224	2025-12-04 04:24:00.141224	+18038189990;ext=8297	Business	45	\N	\N	\N	\N
46	2025-12-04 04:24:00.179553	2025-12-04 04:24:00.179553	+17164230010	Business	46	\N	\N	\N	\N
47	2025-12-04 04:24:00.20882	2025-12-04 04:24:00.20882	+18599209718	Business	47	\N	\N	\N	\N
48	2025-12-04 04:24:00.236204	2025-12-04 04:24:00.236204	+17722408244	Business	48	\N	\N	\N	\N
49	2025-12-04 04:24:00.265108	2025-12-04 04:24:00.265108	+13048088032;ext=1546	Business	49	\N	\N	\N	\N
50	2025-12-04 04:24:00.305238	2025-12-04 04:24:00.305238	+15097376556;ext=6336	Business	50	\N	\N	\N	\N
51	2025-12-04 04:24:00.329352	2025-12-04 04:24:00.329352	+12066266837;ext=7967	Business	51	\N	\N	\N	\N
52	2025-12-04 04:24:00.371494	2025-12-04 04:24:00.371494	+19122121150	Business	52	\N	\N	\N	\N
53	2025-12-04 04:24:00.410777	2025-12-04 04:24:00.410777	+12606410156;ext=1830	Business	53	\N	\N	\N	\N
54	2025-12-04 04:24:00.448931	2025-12-04 04:24:00.448931	+16019141393;ext=9009	Business	54	\N	\N	\N	\N
55	2025-12-04 04:24:00.477075	2025-12-04 04:24:00.477075	+16053095134	Business	55	\N	\N	\N	\N
56	2025-12-04 04:24:00.50637	2025-12-04 04:24:00.50637	+12625055798	Business	56	\N	\N	\N	\N
57	2025-12-04 04:24:00.533507	2025-12-04 04:24:00.533507	+15702073313	Business	57	\N	\N	\N	\N
58	2025-12-04 04:24:00.575196	2025-12-04 04:24:00.575196	+19174020375;ext=8626	Business	58	\N	\N	\N	\N
59	2025-12-04 04:24:00.604193	2025-12-04 04:24:00.604193	+13056503311;ext=1500	Business	59	\N	\N	\N	\N
60	2025-12-04 04:24:00.634047	2025-12-04 04:24:00.634047	+19175048680;ext=4369	Business	60	\N	\N	\N	\N
61	2025-12-04 04:24:00.662317	2025-12-04 04:24:00.662317	+12166312253	Business	61	\N	\N	\N	\N
62	2025-12-04 04:24:00.705568	2025-12-04 04:24:00.705568	+19105594217;ext=3083	Business	62	\N	\N	\N	\N
63	2025-12-04 04:24:00.733063	2025-12-04 04:24:00.733063	+12156786784;ext=4042	Business	63	\N	\N	\N	\N
64	2025-12-04 04:24:00.760453	2025-12-04 04:24:00.760453	+16127748414	Business	64	\N	\N	\N	\N
65	2025-12-04 04:24:00.789186	2025-12-04 04:24:00.789186	+17032165398;ext=9802	Business	65	\N	\N	\N	\N
66	2025-12-04 04:24:00.83325	2025-12-04 04:24:00.83325	+13205591592;ext=7804	Business	66	\N	\N	\N	\N
67	2025-12-04 04:24:00.863327	2025-12-04 04:24:00.863327	+17183012364	Business	67	\N	\N	\N	\N
68	2025-12-04 04:24:00.906095	2025-12-04 04:24:00.906095	+13122628254;ext=2434	Business	68	\N	\N	\N	\N
69	2025-12-04 04:24:00.931094	2025-12-04 04:24:00.931094	+19044148306	Business	69	\N	\N	\N	\N
70	2025-12-04 04:24:00.958791	2025-12-04 04:24:00.958791	+13526128490	Business	70	\N	\N	\N	\N
71	2025-12-04 04:24:00.982834	2025-12-04 04:24:00.982834	+14135716158	Business	71	\N	\N	\N	\N
72	2025-12-04 04:24:01.025652	2025-12-04 04:24:01.025652	+16155594373;ext=9139	Business	72	\N	\N	\N	\N
73	2025-12-04 04:24:01.051626	2025-12-04 04:24:01.051626	+12316263723	Business	73	\N	\N	\N	\N
74	2025-12-04 04:24:01.09038	2025-12-04 04:24:01.09038	+19563095415;ext=1765	Business	74	\N	\N	\N	\N
75	2025-12-04 04:24:01.128056	2025-12-04 04:24:01.128056	+13515517802;ext=3924	Business	75	\N	\N	\N	\N
76	2025-12-04 04:24:01.157506	2025-12-04 04:24:01.157506	+17155304185	Business	76	\N	\N	\N	\N
77	2025-12-04 04:24:01.197487	2025-12-04 04:24:01.197487	+14193159115	Business	77	\N	\N	\N	\N
78	2025-12-04 04:24:01.225499	2025-12-04 04:24:01.225499	+19406234669	Business	78	\N	\N	\N	\N
79	2025-12-04 04:24:01.266988	2025-12-04 04:24:01.266988	+16239842824;ext=6092	Business	79	\N	\N	\N	\N
80	2025-12-04 04:24:01.30737	2025-12-04 04:24:01.30737	+16075031925;ext=8689	Business	80	\N	\N	\N	\N
81	2025-12-04 04:24:01.350512	2025-12-04 04:24:01.350512	+19208134521;ext=2200	Business	81	\N	\N	\N	\N
82	2025-12-04 04:24:01.37474	2025-12-04 04:24:01.37474	+17545860887	Business	82	\N	\N	\N	\N
83	2025-12-04 04:24:01.420946	2025-12-04 04:24:01.420946	+12195177125;ext=5249	Business	83	\N	\N	\N	\N
84	2025-12-04 04:24:01.463337	2025-12-04 04:24:01.463337	+18327866853	Business	84	\N	\N	\N	\N
85	2025-12-04 04:24:01.491754	2025-12-04 04:24:01.491754	+12259405433	Business	85	\N	\N	\N	\N
86	2025-12-04 04:24:01.51942	2025-12-04 04:24:01.51942	+12149795144	Business	86	\N	\N	\N	\N
87	2025-12-04 04:24:01.570294	2025-12-04 04:24:01.570294	+15405130085;ext=3243	Business	87	\N	\N	\N	\N
88	2025-12-04 04:24:01.611859	2025-12-04 04:24:01.611859	+18329416372;ext=3292	Business	88	\N	\N	\N	\N
89	2025-12-04 04:24:01.654934	2025-12-04 04:24:01.654934	+16098085918;ext=3257	Business	89	\N	\N	\N	\N
90	2025-12-04 04:24:01.682511	2025-12-04 04:24:01.682511	+16098106724	Business	90	\N	\N	\N	\N
91	2025-12-04 04:24:01.708754	2025-12-04 04:24:01.708754	+15015092457;ext=7795	Business	91	\N	\N	\N	\N
92	2025-12-04 04:24:01.736233	2025-12-04 04:24:01.736233	+18325417121;ext=7293	Business	92	\N	\N	\N	\N
93	2025-12-04 04:24:01.779045	2025-12-04 04:24:01.779045	+18013202242;ext=2193	Business	93	\N	\N	\N	\N
94	2025-12-04 04:24:01.808941	2025-12-04 04:24:01.808941	+19289030128	Business	94	\N	\N	\N	\N
95	2025-12-04 04:24:01.835496	2025-12-04 04:24:01.835496	+18783088971	Business	95	\N	\N	\N	\N
96	2025-12-04 04:24:01.859058	2025-12-04 04:24:01.859058	+13212012965;ext=5057	Business	96	\N	\N	\N	\N
97	2025-12-04 04:24:01.889099	2025-12-04 04:24:01.889099	+17733215929	Business	97	\N	\N	\N	\N
98	2025-12-04 04:24:01.930144	2025-12-04 04:24:01.930144	+19499104784;ext=7074	Business	98	\N	\N	\N	\N
99	2025-12-04 04:24:01.972922	2025-12-04 04:24:01.972922	+12256057276;ext=8474	Business	99	\N	\N	\N	\N
100	2025-12-04 04:24:02.017888	2025-12-04 04:24:02.017888	+18328157505	Business	100	\N	\N	\N	\N
101	2025-12-04 04:24:02.042274	2025-12-04 04:24:02.042274	+12546820274	Business	101	\N	\N	\N	\N
102	2025-12-04 04:24:02.084152	2025-12-04 04:24:02.084152	+17123135232	Business	102	\N	\N	\N	\N
103	2025-12-04 04:24:02.110539	2025-12-04 04:24:02.110539	+16165514936	Business	103	\N	\N	\N	\N
104	2025-12-04 04:24:02.136399	2025-12-04 04:24:02.136399	+19472058799	Business	104	\N	\N	\N	\N
105	2025-12-04 04:24:02.162105	2025-12-04 04:24:02.162105	+13342404509;ext=8125	Business	105	\N	\N	\N	\N
106	2025-12-04 04:24:02.205183	2025-12-04 04:24:02.205183	+12345867846	Business	106	\N	\N	\N	\N
107	2025-12-04 04:24:02.230565	2025-12-04 04:24:02.230565	+18624127663;ext=3316	Business	107	\N	\N	\N	\N
108	2025-12-04 04:24:02.273831	2025-12-04 04:24:02.273831	+15084806159	Business	108	\N	\N	\N	\N
109	2025-12-04 04:24:02.311989	2025-12-04 04:24:02.311989	+16785151735	Business	109	\N	\N	\N	\N
110	2025-12-04 04:24:02.338933	2025-12-04 04:24:02.338933	+17708506102	Business	110	\N	\N	\N	\N
111	2025-12-04 04:24:02.375097	2025-12-04 04:24:02.375097	+18053208062	Business	111	\N	\N	\N	\N
112	2025-12-04 04:24:02.419482	2025-12-04 04:24:02.419482	+16824044035	Business	112	\N	\N	\N	\N
113	2025-12-04 04:24:02.459942	2025-12-04 04:24:02.459942	+13472541212	Business	113	\N	\N	\N	\N
114	2025-12-04 04:24:02.499542	2025-12-04 04:24:02.499542	+15176108114	Business	114	\N	\N	\N	\N
115	2025-12-04 04:24:02.543234	2025-12-04 04:24:02.543234	+16149283359;ext=9687	Business	115	\N	\N	\N	\N
116	2025-12-04 04:24:02.571999	2025-12-04 04:24:02.571999	+18137734715	Business	116	\N	\N	\N	\N
117	2025-12-04 04:24:02.609706	2025-12-04 04:24:02.609706	+12677162840	Business	117	\N	\N	\N	\N
118	2025-12-04 04:24:02.633919	2025-12-04 04:24:02.633919	+18645641973;ext=5706	Business	118	\N	\N	\N	\N
119	2025-12-04 04:24:02.663313	2025-12-04 04:24:02.663313	+16189068183;ext=1989	Business	119	\N	\N	\N	\N
120	2025-12-04 04:24:02.710639	2025-12-04 04:24:02.710639	+14342108851;ext=2051	Business	120	\N	\N	\N	\N
121	2025-12-04 04:24:02.740498	2025-12-04 04:24:02.740498	+14084750344;ext=8525	Business	121	\N	\N	\N	\N
122	2025-12-04 04:24:02.764401	2025-12-04 04:24:02.764401	+12055012891	Business	122	\N	\N	\N	\N
123	2025-12-04 04:24:02.793595	2025-12-04 04:24:02.793595	+17129179802	Business	123	\N	\N	\N	\N
124	2025-12-04 04:24:02.823958	2025-12-04 04:24:02.823958	+15706318402;ext=0843	Business	124	\N	\N	\N	\N
125	2025-12-04 04:24:02.864301	2025-12-04 04:24:02.864301	+19134780146	Business	125	\N	\N	\N	\N
126	2025-12-04 04:24:02.893361	2025-12-04 04:24:02.893361	+15177700558;ext=5463	Business	126	\N	\N	\N	\N
127	2025-12-04 04:24:02.935748	2025-12-04 04:24:02.935748	+17739158558	Business	127	\N	\N	\N	\N
128	2025-12-04 04:24:02.966072	2025-12-04 04:24:02.966072	+14048629590	Business	128	\N	\N	\N	\N
129	2025-12-04 04:24:03.003746	2025-12-04 04:24:03.003746	+15852534745;ext=8801	Business	129	\N	\N	\N	\N
130	2025-12-04 04:24:03.046387	2025-12-04 04:24:03.046387	+12628108638;ext=3703	Business	130	\N	\N	\N	\N
131	2025-12-04 04:24:03.071416	2025-12-04 04:24:03.071416	+14044259375;ext=7067	Business	131	\N	\N	\N	\N
132	2025-12-04 04:24:03.098852	2025-12-04 04:24:03.098852	+15188167242;ext=2494	Business	132	\N	\N	\N	\N
133	2025-12-04 04:24:03.126406	2025-12-04 04:24:03.126406	+19155040582;ext=8184	Business	133	\N	\N	\N	\N
134	2025-12-04 04:24:03.150236	2025-12-04 04:24:03.150236	+18165305202	Business	134	\N	\N	\N	\N
135	2025-12-04 04:24:03.175394	2025-12-04 04:24:03.175394	+17409544830;ext=5809	Business	135	\N	\N	\N	\N
136	2025-12-04 04:24:03.199327	2025-12-04 04:24:03.199327	+14174340272;ext=6841	Business	136	\N	\N	\N	\N
137	2025-12-04 04:24:03.231484	2025-12-04 04:24:03.231484	+12344244774;ext=8988	Business	137	\N	\N	\N	\N
138	2025-12-04 04:24:03.275434	2025-12-04 04:24:03.275434	+14064047474;ext=2123	Business	138	\N	\N	\N	\N
139	2025-12-04 04:24:03.31592	2025-12-04 04:24:03.31592	+17704060614	Business	139	\N	\N	\N	\N
140	2025-12-04 04:24:03.359478	2025-12-04 04:24:03.359478	+17734088842;ext=2712	Business	140	\N	\N	\N	\N
141	2025-12-04 04:24:03.385799	2025-12-04 04:24:03.385799	+12489739456;ext=9217	Business	141	\N	\N	\N	\N
142	2025-12-04 04:24:03.427836	2025-12-04 04:24:03.427836	+14233047469;ext=0569	Business	142	\N	\N	\N	\N
143	2025-12-04 04:24:03.456336	2025-12-04 04:24:03.456336	+18609315207	Business	143	\N	\N	\N	\N
144	2025-12-04 04:24:03.496108	2025-12-04 04:24:03.496108	+17048359979;ext=5377	Business	144	\N	\N	\N	\N
145	2025-12-04 04:24:03.523803	2025-12-04 04:24:03.523803	+19285642717;ext=0971	Business	145	\N	\N	\N	\N
146	2025-12-04 04:24:03.566949	2025-12-04 04:24:03.566949	+15858508070;ext=5178	Business	146	\N	\N	\N	\N
147	2025-12-04 04:24:03.595454	2025-12-04 04:24:03.595454	+17137633990	Business	147	\N	\N	\N	\N
148	2025-12-04 04:24:03.635087	2025-12-04 04:24:03.635087	+14797275005	Business	148	\N	\N	\N	\N
149	2025-12-04 04:24:03.662183	2025-12-04 04:24:03.662183	+16517140353;ext=3489	Business	149	\N	\N	\N	\N
150	2025-12-04 04:24:04.019019	2025-12-04 04:24:04.019019	+12083103588	Business	150	\N	\N	\N	\N
151	2025-12-04 04:24:04.039679	2025-12-04 04:24:04.039679	+17577035264	Business	151	\N	\N	\N	\N
152	2025-12-04 04:24:04.060297	2025-12-04 04:24:04.060297	+12624353330;ext=6962	Business	152	\N	\N	\N	\N
153	2025-12-04 04:24:04.096462	2025-12-04 04:24:04.096462	+13234643911	Business	153	\N	\N	\N	\N
154	2025-12-04 04:24:04.12751	2025-12-04 04:24:04.12751	+18018060905;ext=5196	Business	154	\N	\N	\N	\N
155	2025-12-04 04:24:04.162254	2025-12-04 04:24:04.162254	+16039545840;ext=3829	Business	155	\N	\N	\N	\N
156	2025-12-04 04:24:04.185654	2025-12-04 04:24:04.185654	+17127632347	Business	156	\N	\N	\N	\N
157	2025-12-04 04:24:04.211698	2025-12-04 04:24:04.211698	+15864643752;ext=0340	Business	157	\N	\N	\N	\N
158	2025-12-04 04:24:04.236205	2025-12-04 04:24:04.236205	+19176676771	Business	158	\N	\N	\N	\N
159	2025-12-04 04:24:04.260541	2025-12-04 04:24:04.260541	+13512099962	Business	159	\N	\N	\N	\N
160	2025-12-04 04:24:04.282566	2025-12-04 04:24:04.282566	+19085705416	Business	160	\N	\N	\N	\N
161	2025-12-04 04:24:04.308327	2025-12-04 04:24:04.308327	+13163045419	Business	161	\N	\N	\N	\N
162	2025-12-04 04:24:04.334043	2025-12-04 04:24:04.334043	+13395078174	Business	162	\N	\N	\N	\N
163	2025-12-04 04:24:04.360947	2025-12-04 04:24:04.360947	+18308130663;ext=9991	Business	163	\N	\N	\N	\N
164	2025-12-04 04:24:04.386997	2025-12-04 04:24:04.386997	+18508659231	Business	164	\N	\N	\N	\N
165	2025-12-04 04:24:04.411663	2025-12-04 04:24:04.411663	+15409782129;ext=0933	Business	165	\N	\N	\N	\N
166	2025-12-04 04:24:04.437925	2025-12-04 04:24:04.437925	+18302258886;ext=6353	Business	166	\N	\N	\N	\N
167	2025-12-04 04:24:04.46264	2025-12-04 04:24:04.46264	+17633314765	Business	167	\N	\N	\N	\N
168	2025-12-04 04:24:04.487206	2025-12-04 04:24:04.487206	+18436169601	Business	168	\N	\N	\N	\N
169	2025-12-04 04:24:04.513268	2025-12-04 04:24:04.513268	+16018068174;ext=7317	Business	169	\N	\N	\N	\N
170	2025-12-04 04:24:04.539566	2025-12-04 04:24:04.539566	+14806108745;ext=6226	Business	170	\N	\N	\N	\N
171	2025-12-04 04:24:04.562077	2025-12-04 04:24:04.562077	+18603348858;ext=2802	Business	171	\N	\N	\N	\N
172	2025-12-04 04:24:04.587413	2025-12-04 04:24:04.587413	+18085200684	Business	172	\N	\N	\N	\N
173	2025-12-04 04:24:04.613056	2025-12-04 04:24:04.613056	+15712761497	Business	173	\N	\N	\N	\N
174	2025-12-04 04:24:04.637392	2025-12-04 04:24:04.637392	+12402174617	Business	174	\N	\N	\N	\N
175	2025-12-04 04:24:04.663332	2025-12-04 04:24:04.663332	+18144236163;ext=8398	Business	175	\N	\N	\N	\N
176	2025-12-04 04:24:04.6837	2025-12-04 04:24:04.6837	+18139478736;ext=5691	Business	176	\N	\N	\N	\N
177	2025-12-04 04:24:04.710216	2025-12-04 04:24:04.710216	+18458720059;ext=3696	Business	177	\N	\N	\N	\N
178	2025-12-04 04:24:04.735398	2025-12-04 04:24:04.735398	+15178131550	Business	178	\N	\N	\N	\N
179	2025-12-04 04:24:04.757288	2025-12-04 04:24:04.757288	+15165864802;ext=1424	Business	179	\N	\N	\N	\N
180	2025-12-04 04:24:04.781007	2025-12-04 04:24:04.781007	+19407810400;ext=8663	Business	180	\N	\N	\N	\N
181	2025-12-04 04:24:04.80391	2025-12-04 04:24:04.80391	+13606157663	Business	181	\N	\N	\N	\N
182	2025-12-04 04:24:04.828695	2025-12-04 04:24:04.828695	+14798150312;ext=6523	Business	182	\N	\N	\N	\N
183	2025-12-04 04:24:04.852379	2025-12-04 04:24:04.852379	+14232158820	Business	183	\N	\N	\N	\N
184	2025-12-04 04:24:04.878418	2025-12-04 04:24:04.878418	+12673127881	Business	184	\N	\N	\N	\N
185	2025-12-04 04:24:04.903366	2025-12-04 04:24:04.903366	+12815207343;ext=7084	Business	185	\N	\N	\N	\N
186	2025-12-04 04:24:04.92768	2025-12-04 04:24:04.92768	+18142186324;ext=9359	Business	186	\N	\N	\N	\N
187	2025-12-04 04:24:04.953582	2025-12-04 04:24:04.953582	+19075742005	Business	187	\N	\N	\N	\N
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
1	2025-12-04 04:23:58.679577	2025-12-04 04:23:58.7395	Sanford-Williamson		Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	http://dubuque-schroeder.name/gail_langosh	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
2	2025-12-04 04:23:58.771765	2025-12-04 04:23:58.80474	Balistreri and Sons		Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
3	2025-12-04 04:23:58.820625	2025-12-04 04:23:58.844256	Will, Borer and Halvorson	Autem officia dolores et.	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	http://morar-brakus.net/hana_lemke	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
4	2025-12-04 04:23:58.855407	2025-12-04 04:23:58.867345	Blanda, Rutherford and Johnston	Dolor ut aperiam exercitationem.	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
5	2025-12-04 04:23:58.880126	2025-12-04 04:23:58.893173	Nolan, McClure and Mohr		Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	http://sawayn.net/griselda	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
6	2025-12-04 04:23:58.904621	2025-12-04 04:23:58.917339	Sipes LLC	Dolore dolorem esse molestias.	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
7	2025-12-04 04:23:58.932402	2025-12-04 04:23:58.945781	Turcotte and Sons		Weekly food pantry (Thursday).\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
8	2025-12-04 04:23:58.959935	2025-12-04 04:23:58.972149	Runolfsson-Ebert	Minus at rerum ea.	Serves lunch Monday and Wednesday. Dinner available all days.\n	http://durgan.info/joe	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
9	2025-12-04 04:23:58.984964	2025-12-04 04:23:58.998641	O'Reilly LLC		Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	http://bayer.name/marissa	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
10	2025-12-04 04:23:59.00942	2025-12-04 04:23:59.022136	Hartmann-Gislason	Atque in rerum et.	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
11	2025-12-04 04:23:59.038147	2025-12-04 04:23:59.060648	Hayes and Sons	Aliquid sequi voluptas et.	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
12	2025-12-04 04:23:59.072853	2025-12-04 04:23:59.084098	Raynor LLC	In totam qui ut.	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
13	2025-12-04 04:23:59.094758	2025-12-04 04:23:59.120196	Quigley, Hirthe and Connelly		Weekly food pantry (Thursday).\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
14	2025-12-04 04:23:59.13193	2025-12-04 04:23:59.142434	Rosenbaum Group		Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
15	2025-12-04 04:23:59.156291	2025-12-04 04:23:59.169142	Roob, Kautzer and Torphy		Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
16	2025-12-04 04:23:59.179839	2025-12-04 04:23:59.193101	O'Kon-Nitzsche		Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
17	2025-12-04 04:23:59.205374	2025-12-04 04:23:59.218851	Effertz LLC		The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	http://ohara-mohr.org/krysten_kub	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
18	2025-12-04 04:23:59.232624	2025-12-04 04:23:59.263212	Barrows LLC		Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
19	2025-12-04 04:23:59.275858	2025-12-04 04:23:59.301754	Wunsch-Murphy	Soluta nihil laudantium enim.	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
20	2025-12-04 04:23:59.314061	2025-12-04 04:23:59.345162	Schiller-Greenfelder	Praesentium maxime a expedita.	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
21	2025-12-04 04:23:59.36025	2025-12-04 04:23:59.387903	Mraz-Koepp	Molestiae quo accusantium illo.	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	http://jones.info/levi	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
22	2025-12-04 04:23:59.400895	2025-12-04 04:23:59.413779	Kuhn Inc	Ipsum iusto molestiae quisquam.	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	http://nikolaus.org/tangela	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
23	2025-12-04 04:23:59.428337	2025-12-04 04:23:59.444086	Rau-Quitzon		Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	http://considine-marvin.info/carter_kris	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
24	2025-12-04 04:23:59.456577	2025-12-04 04:23:59.470738	Ankunding Group	Enim nostrum perferendis quia.	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
25	2025-12-04 04:23:59.486934	2025-12-04 04:23:59.502419	Franecki LLC		Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	http://schaden.biz/homer	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
26	2025-12-04 04:23:59.517345	2025-12-04 04:23:59.530879	Kuhic Inc		1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
27	2025-12-04 04:23:59.545611	2025-12-04 04:23:59.556991	Thompson, Harris and Lubowitz		Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
28	2025-12-04 04:23:59.573522	2025-12-04 04:23:59.596734	Terry Group	Voluptate rerum expedita accusamus.	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	http://wiza-johnson.com/hye	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
29	2025-12-04 04:23:59.610404	2025-12-04 04:23:59.639447	Hirthe Inc		Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	http://kris.info/nia.gleichner	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
30	2025-12-04 04:23:59.651346	2025-12-04 04:23:59.664652	Schmitt LLC	Iure facilis aliquid sed.	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
31	2025-12-04 04:23:59.678662	2025-12-04 04:23:59.706941	Schulist-Shanahan	Ratione repudiandae laboriosam similique.	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	http://hilpert.co/florida	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
32	2025-12-04 04:23:59.718777	2025-12-04 04:23:59.744125	Dickens-Kuphal	Quia fugit quia illo.	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	http://boyle.net/trent	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
33	2025-12-04 04:23:59.754753	2025-12-04 04:23:59.783141	Swaniawski, Heathcote and Streich		Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	http://steuber-anderson.io/brittaney_stamm	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
34	2025-12-04 04:23:59.794471	2025-12-04 04:23:59.80709	Haag-Wiegand		Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	http://hodkiewicz.info/brendan_medhurst	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
35	2025-12-04 04:23:59.820463	2025-12-04 04:23:59.8352	Skiles-Wunsch		Weekly food pantry (Thursday).\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
36	2025-12-04 04:23:59.849432	2025-12-04 04:23:59.863197	Harber, Hudson and Roberts		Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
37	2025-12-04 04:23:59.87829	2025-12-04 04:23:59.891223	Kuhic LLC	Voluptate quia quod qui.	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
38	2025-12-04 04:23:59.90851	2025-12-04 04:23:59.920033	Kessler, Metz and Reinger		Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	http://carroll.biz/floria.klein	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
39	2025-12-04 04:23:59.935352	2025-12-04 04:23:59.96289	Hettinger LLC	Sed necessitatibus aliquam illo.	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
40	2025-12-04 04:23:59.984932	2025-12-04 04:24:00.000414	Pouros-Torp		Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
41	2025-12-04 04:24:00.013909	2025-12-04 04:24:00.027597	Moore LLC		Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
42	2025-12-04 04:24:00.042945	2025-12-04 04:24:00.054274	Schaden-Gislason	Voluptatem laudantium libero sed.	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	http://boyer.net/bret	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
43	2025-12-04 04:24:00.068127	2025-12-04 04:24:00.096467	Gulgowski Group		A place to shower on Tuesday through Saturday.\n	http://nikolaus-luettgen.io/arie_deckow	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
44	2025-12-04 04:24:00.110006	2025-12-04 04:24:00.123433	Stiedemann, Schumm and Upton		Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	http://strosin.biz/ben_ziemann	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
45	2025-12-04 04:24:00.138229	2025-12-04 04:24:00.162627	Kuphal, Pouros and McGlynn		Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
46	2025-12-04 04:24:00.176646	2025-12-04 04:24:00.189436	Gusikowski, Kertzmann and Jerde	Quisquam et voluptates dolorum.	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	http://rowe.com/terrance.runolfsson	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
47	2025-12-04 04:24:00.205595	2025-12-04 04:24:00.220079	Ryan, Rohan and Mann	Fuga esse nihil illo.	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
48	2025-12-04 04:24:00.233031	2025-12-04 04:24:00.248717	Huel-Sipes		Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	http://smitham.info/walter.cremin	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
49	2025-12-04 04:24:00.261894	2025-12-04 04:24:00.288102	Davis-Dickens		1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	http://funk.info/louie	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
50	2025-12-04 04:24:00.302164	2025-12-04 04:24:00.313732	Rodriguez LLC	Ut sunt rem sit.	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	http://marks.com/oliver_rohan	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
51	2025-12-04 04:24:00.326299	2025-12-04 04:24:00.353833	Streich-Carter		5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	http://gislason.io/abe	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
52	2025-12-04 04:24:00.36803	2025-12-04 04:24:00.394421	Howe, Heller and Robel		Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	http://heathcote.name/randee_pfannerstill	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
53	2025-12-04 04:24:00.407416	2025-12-04 04:24:00.433189	Mayer, Prosacco and Graham		Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
54	2025-12-04 04:24:00.445791	2025-12-04 04:24:00.458804	Towne and Sons	Iure aut vel non.	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	http://lang-jerde.info/lisette	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
55	2025-12-04 04:24:00.473371	2025-12-04 04:24:00.489173	Jast, Turcotte and Mosciski	Consequatur commodi voluptatem velit.	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	http://hermiston-grant.org/wilber	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
56	2025-12-04 04:24:00.502929	2025-12-04 04:24:00.517364	Shanahan, Hegmann and Bauch		Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
57	2025-12-04 04:24:00.530431	2025-12-04 04:24:00.558882	Lemke-Johnson	Et dolorum dolorem aut.	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	http://barton-carter.biz/heriberto	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
58	2025-12-04 04:24:00.572022	2025-12-04 04:24:00.584395	Barton LLC	Vel autem earum ab.	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	http://weimann.org/tony.turcotte	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
59	2025-12-04 04:24:00.600639	2025-12-04 04:24:00.615879	Casper, Bogan and Pfannerstill		Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
60	2025-12-04 04:24:00.63081	2025-12-04 04:24:00.645178	Powlowski Group	Voluptatem pariatur beatae quae.	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	http://wiegand.org/tammera_sawayn	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
61	2025-12-04 04:24:00.658948	2025-12-04 04:24:00.688365	Sipes, Casper and Kertzmann		Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
62	2025-12-04 04:24:00.702277	2025-12-04 04:24:00.714869	Schiller, Harris and Daniel	Cum voluptatibus ad rerum.	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
183	2025-12-04 04:24:04.849283	2025-12-04 04:24:04.86369	Conroy-Bergnaum	Ipsam sit est ut.	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	http://gusikowski.co/renato	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
184	2025-12-04 04:24:04.875248	2025-12-04 04:24:04.889802	Murray-Gutmann	Quod voluptas optio et.	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	http://johns-halvorson.name/stewart	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
185	2025-12-04 04:24:04.900282	2025-12-04 04:24:04.912656	Grady, Yundt and Lueilwitz	At nam repellat voluptatum.	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	http://waelchi.org/kalyn_hessel	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
63	2025-12-04 04:24:00.730185	2025-12-04 04:24:00.742208	Rempel-Durgan	Sunt dolorem perferendis rerum.	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	http://mertz-halvorson.io/stuart	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
64	2025-12-04 04:24:00.757271	2025-12-04 04:24:00.769648	Kilback-Bogan	Id consequatur iure eligendi.	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	http://bashirian.co/kelly	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
65	2025-12-04 04:24:00.786416	2025-12-04 04:24:00.817225	Padberg, Hettinger and Haag	Quod explicabo rem perferendis.	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	http://swaniawski.io/brendan	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
66	2025-12-04 04:24:00.830376	2025-12-04 04:24:00.84181	Wyman, Padberg and Fisher		Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
67	2025-12-04 04:24:00.860133	2025-12-04 04:24:00.889673	Nader-Fahey	Non enim eos et.	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	http://blanda-keebler.name/aisha_kreiger	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
68	2025-12-04 04:24:00.902657	2025-12-04 04:24:00.914799	Green, Yundt and Ratke		Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
69	2025-12-04 04:24:00.92831	2025-12-04 04:24:00.942478	Weber LLC	Reiciendis nihil voluptatum eum.	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
70	2025-12-04 04:24:00.955888	2025-12-04 04:24:00.96677	Kuhn Inc	Porro sed similique eius.	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	http://fadel-flatley.info/tawana	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
71	2025-12-04 04:24:00.979385	2025-12-04 04:24:01.006375	Reichel, Funk and Hilll	Iusto labore voluptate alias.	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
72	2025-12-04 04:24:01.022304	2025-12-04 04:24:01.035591	Wilkinson-Hand	Est ipsa omnis numquam.	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
73	2025-12-04 04:24:01.048749	2025-12-04 04:24:01.072835	Kovacek LLC		Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	http://morissette.info/johnathon	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
74	2025-12-04 04:24:01.087266	2025-12-04 04:24:01.112867	Lowe-Zieme		Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
75	2025-12-04 04:24:01.125163	2025-12-04 04:24:01.137548	Schinner Group	Tempora pariatur maxime et.	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	http://ondricka-medhurst.co/yee.hermiston	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
76	2025-12-04 04:24:01.154159	2025-12-04 04:24:01.179604	Little, Bradtke and Mayert	Suscipit rerum error repudiandae.	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
77	2025-12-04 04:24:01.194392	2025-12-04 04:24:01.208899	Lemke-Metz		First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	http://kerluke-grimes.io/mikaela.kunze	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
78	2025-12-04 04:24:01.221939	2025-12-04 04:24:01.247053	Reichert-Bechtelar		Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	http://dibbert-schulist.io/clark.lueilwitz	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
79	2025-12-04 04:24:01.263823	2025-12-04 04:24:01.289622	Muller and Sons	Qui distinctio eius provident.	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	http://oberbrunner-prohaska.co/clair_mcdermott	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
80	2025-12-04 04:24:01.303928	2025-12-04 04:24:01.333533	Wilkinson LLC	Sunt sed et illum.	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	http://johns.co/liza	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
81	2025-12-04 04:24:01.347287	2025-12-04 04:24:01.360131	Mills and Sons	Consequatur vitae unde omnis.	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
186	2025-12-04 04:24:04.924701	2025-12-04 04:24:04.937441	Walker Inc	Laudantium corrupti deleniti vero.	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	http://kulas.io/sunshine_dare	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
82	2025-12-04 04:24:01.371544	2025-12-04 04:24:01.401769	Cassin Inc		Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	http://bednar.info/grace	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
83	2025-12-04 04:24:01.418105	2025-12-04 04:24:01.442299	Hermann-Cummings	Iusto explicabo tempora sit.	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
84	2025-12-04 04:24:01.460026	2025-12-04 04:24:01.474033	Hermiston, Bernier and Sanford		Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
85	2025-12-04 04:24:01.48837	2025-12-04 04:24:01.502056	Rodriguez-Hyatt		Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
86	2025-12-04 04:24:01.516162	2025-12-04 04:24:01.545832	Thompson-Dach	Est perferendis vero dolor.	Serves lunch Monday and Wednesday. Dinner available all days.\n	http://murray-wolff.com/aleshia_kautzer	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
87	2025-12-04 04:24:01.563059	2025-12-04 04:24:01.594382	Weber LLC		A place to shower on Tuesday through Saturday.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
88	2025-12-04 04:24:01.608332	2025-12-04 04:24:01.63775	Roberts Inc	Est iure at delectus.	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
89	2025-12-04 04:24:01.652162	2025-12-04 04:24:01.664504	Murphy-Bashirian	Sint distinctio voluptas nesciunt.	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
90	2025-12-04 04:24:01.679694	2025-12-04 04:24:01.691447	Berge, Cole and Barrows		Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	http://orn.net/maybelle.cummings	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
91	2025-12-04 04:24:01.705305	2025-12-04 04:24:01.718995	Bauch, Rau and Volkman		Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
92	2025-12-04 04:24:01.732692	2025-12-04 04:24:01.762005	Kessler-Towne	Quia eaque laboriosam qui.	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
93	2025-12-04 04:24:01.775657	2025-12-04 04:24:01.790688	Daugherty-Dietrich	Blanditiis excepturi eveniet nihil.	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	http://predovic.com/marvin.sporer	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
94	2025-12-04 04:24:01.805708	2025-12-04 04:24:01.819053	Yundt, Fisher and Smith		Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	http://bogisich-keebler.net/cathrine	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
95	2025-12-04 04:24:01.832465	2025-12-04 04:24:01.844146	Zemlak-Cormier	Placeat ea sed voluptas.	Weekly food pantry (Thursday).\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
96	2025-12-04 04:24:01.856136	2025-12-04 04:24:01.869538	Koss LLC		Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	http://bednar.name/filiberto	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
97	2025-12-04 04:24:01.885723	2025-12-04 04:24:01.912615	McLaughlin, Kling and Kessler		Serves lunch Monday and Wednesday. Dinner available all days.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
98	2025-12-04 04:24:01.927364	2025-12-04 04:24:01.954583	Erdman and Sons	Quam dolor incidunt ut.	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	http://mueller.com/marva	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
99	2025-12-04 04:24:01.969473	2025-12-04 04:24:02.000345	Effertz, Mohr and Bernier		Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	http://grant-leuschke.info/porsche	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
100	2025-12-04 04:24:02.014358	2025-12-04 04:24:02.025844	Rowe, Herzog and Ferry	Et et illo nobis.	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	http://schinner.io/manual	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
101	2025-12-04 04:24:02.039123	2025-12-04 04:24:02.066289	Predovic Group		Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	http://mante.net/edgardo	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
187	2025-12-04 04:24:04.950545	2025-12-04 04:24:04.963359	Nikolaus Inc	Esse nobis rem enim.	Serves lunch Monday and Wednesday. Dinner available all days.\n	http://heaney.com/glynis	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
102	2025-12-04 04:24:02.080957	2025-12-04 04:24:02.094993	Corkery, Schultz and Kuphal	Expedita autem itaque et.	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	http://carroll.info/dee.okuneva	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
103	2025-12-04 04:24:02.107794	2025-12-04 04:24:02.119345	Gorczany, Ferry and Douglas		First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
104	2025-12-04 04:24:02.133336	2025-12-04 04:24:02.14337	Bartoletti and Sons		1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
105	2025-12-04 04:24:02.158927	2025-12-04 04:24:02.187519	Stark-Mraz		Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	http://mclaughlin.name/jeffery	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
106	2025-12-04 04:24:02.20228	2025-12-04 04:24:02.214601	Dicki LLC		Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	http://considine.info/catherine_feeney	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
107	2025-12-04 04:24:02.227174	2025-12-04 04:24:02.25733	Flatley, Gislason and Lesch		Weekly food pantry (Thursday).\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
108	2025-12-04 04:24:02.270617	2025-12-04 04:24:02.296527	Kassulke Inc	Quo dolorem quia ex.	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	http://glover-vandervort.org/russel	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
109	2025-12-04 04:24:02.309237	2025-12-04 04:24:02.322136	Armstrong-Altenwerth		Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	http://gutmann.co/cole.nitzsche	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
110	2025-12-04 04:24:02.336153	2025-12-04 04:24:02.360732	Heidenreich Group	Natus perspiciatis et nemo.	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
111	2025-12-04 04:24:02.372089	2025-12-04 04:24:02.400596	Ziemann-Koss		Weekly food pantry (Thursday).\n	http://huels.org/suanne	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
112	2025-12-04 04:24:02.416408	2025-12-04 04:24:02.442873	Abernathy-Ledner	Nihil reprehenderit ut repellendus.	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	http://romaguera-robel.info/sean	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
113	2025-12-04 04:24:02.457143	2025-12-04 04:24:02.483197	Bauch Inc	Suscipit atque nam enim.	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	http://gleason.com/quincy.bins	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
114	2025-12-04 04:24:02.496164	2025-12-04 04:24:02.525875	Lebsack LLC	Eos in sunt ut.	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	http://mertz-gerhold.org/dong.gislason	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
115	2025-12-04 04:24:02.539785	2025-12-04 04:24:02.553814	Ferry LLC	Impedit quae quibusdam sapiente.	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	http://berge.co/leola	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
116	2025-12-04 04:24:02.568323	2025-12-04 04:24:02.592159	Tillman, Okuneva and Prohaska	Eum animi voluptatibus libero.	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	http://hegmann-romaguera.net/luciano_dietrich	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
117	2025-12-04 04:24:02.60645	2025-12-04 04:24:02.618052	Bayer Group		Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
118	2025-12-04 04:24:02.631002	2025-12-04 04:24:02.64622	Rempel, Blick and McClure	Est numquam voluptas maxime.	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
119	2025-12-04 04:24:02.660136	2025-12-04 04:24:02.690226	Medhurst-Hessel		1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
120	2025-12-04 04:24:02.707132	2025-12-04 04:24:02.722199	Adams LLC		Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	http://koss.biz/ashlea	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
121	2025-12-04 04:24:02.737493	2025-12-04 04:24:02.747159	Prohaska Inc	Cum aperiam commodi repellendus.	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	http://carroll.io/darby.swaniawski	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
122	2025-12-04 04:24:02.760915	2025-12-04 04:24:02.774707	Balistreri-Bernhard		Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	http://walter-barrows.net/darci_kris	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
123	2025-12-04 04:24:02.790381	2025-12-04 04:24:02.805486	Wisoky, Brekke and Bosco		Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
124	2025-12-04 04:24:02.820814	2025-12-04 04:24:02.847192	Konopelski and Sons		Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
125	2025-12-04 04:24:02.861002	2025-12-04 04:24:02.875296	Fahey and Sons		A place to shower on Tuesday through Saturday.\n	http://schultz-moen.biz/gale	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
126	2025-12-04 04:24:02.889983	2025-12-04 04:24:02.919254	Osinski-Bergstrom		Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
127	2025-12-04 04:24:02.932508	2025-12-04 04:24:02.946702	Kub-Klein	Quae a et voluptatem.	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
128	2025-12-04 04:24:02.962712	2025-12-04 04:24:02.984658	Torphy-Green		Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
129	2025-12-04 04:24:03.000538	2025-12-04 04:24:03.028361	Murray, Botsford and Koch		Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
130	2025-12-04 04:24:03.043249	2025-12-04 04:24:03.054993	Steuber-Bashirian	Quae in provident odio.	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
131	2025-12-04 04:24:03.068286	2025-12-04 04:24:03.082162	Beer, Hackett and McGlynn		Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	http://funk.name/dominick	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
132	2025-12-04 04:24:03.095638	2025-12-04 04:24:03.105678	Carter, Toy and Parker		Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	http://pouros.org/nidia.boyle	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
133	2025-12-04 04:24:03.123035	2025-12-04 04:24:03.136745	Donnelly Group		Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
134	2025-12-04 04:24:03.147098	2025-12-04 04:24:03.158242	Cremin LLC		Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
135	2025-12-04 04:24:03.172286	2025-12-04 04:24:03.185293	Schamberger-Rosenbaum	Animi esse est assumenda.	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	http://powlowski.co/jae_anderson	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
136	2025-12-04 04:24:03.19595	2025-12-04 04:24:03.212519	Mayert-Orn	At temporibus corporis ipsa.	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	http://anderson.biz/lavonna	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
137	2025-12-04 04:24:03.228281	2025-12-04 04:24:03.258872	Boyer-Franecki	Et et quia iste.	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
138	2025-12-04 04:24:03.272254	2025-12-04 04:24:03.298237	Stiedemann Group	Ipsam consequuntur non sed.	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	http://okuneva.io/federico.witting	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
139	2025-12-04 04:24:03.312802	2025-12-04 04:24:03.341648	Stracke and Sons		Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	http://bruen.io/vincenzo	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
140	2025-12-04 04:24:03.356221	2025-12-04 04:24:03.369467	Schmeler-Lebsack		Weekly food pantry (Thursday).\n	http://hessel-hamill.org/marcel.runolfsdottir	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
141	2025-12-04 04:24:03.382643	2025-12-04 04:24:03.411972	O'Conner, Runte and Champlin	Enim consectetur ipsum similique.	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	http://baumbach-kub.co/keely_shanahan	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
142	2025-12-04 04:24:03.424764	2025-12-04 04:24:03.439537	Marks-Muller	Quasi voluptatibus architecto error.	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
143	2025-12-04 04:24:03.453206	2025-12-04 04:24:03.479809	Stokes Group		Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	http://hamill-brakus.co/morgan_vonrueden	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
144	2025-12-04 04:24:03.493027	2025-12-04 04:24:03.506314	Gottlieb, Hilll and Keebler		Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	http://roberts.info/marcene_bernier	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
145	2025-12-04 04:24:03.520656	2025-12-04 04:24:03.550032	Schimmel, Spencer and Daniel		Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
146	2025-12-04 04:24:03.563867	2025-12-04 04:24:03.578882	Hintz, Stracke and Hodkiewicz	Aliquid ut veritatis assumenda.	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	http://mcclure.io/angella_luettgen	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
147	2025-12-04 04:24:03.592384	2025-12-04 04:24:03.618593	Miller, Haley and Lockman		5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
148	2025-12-04 04:24:03.632054	2025-12-04 04:24:03.644742	Dickens Group		Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n		\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
149	2025-12-04 04:24:03.658983	2025-12-04 04:24:03.669612	A Test Resource	I am a short description of a resource.	I am a long description of a resource.	www.fakewebsite.org	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
150	2025-12-04 04:24:04.015567	2025-12-04 04:24:04.026188	Hilpert, Emmerich and Runte	Cupiditate praesentium temporibus assumenda.	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	http://morissette-kub.org/joan	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
151	2025-12-04 04:24:04.036437	2025-12-04 04:24:04.048477	Purdy Group	Quibusdam minus laboriosam sunt.	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	http://stanton.io/val_fritsch	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
152	2025-12-04 04:24:04.05712	2025-12-04 04:24:04.071046	Balistreri, Parker and Tremblay	Autem libero magnam consectetur.	Serves lunch Monday and Wednesday. Dinner available all days.\n	http://hirthe.name/hans	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
153	2025-12-04 04:24:04.086155	2025-12-04 04:24:04.109864	O'Hara, Green and Beer	Quos doloremque velit sed.	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	http://davis.io/arletha	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
154	2025-12-04 04:24:04.124073	2025-12-04 04:24:04.140599	Schumm Group	Excepturi placeat est ratione.	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	http://renner.org/brooks.hettinger	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
155	2025-12-04 04:24:04.158902	2025-12-04 04:24:04.172929	Boyer Group	Eaque nihil ipsam consequatur.	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	http://hilpert.net/hans.schinner	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
156	2025-12-04 04:24:04.182527	2025-12-04 04:24:04.197253	Hilpert Group	Impedit iure harum vero.	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	http://rolfson.io/serina	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
157	2025-12-04 04:24:04.208211	2025-12-04 04:24:04.221334	Mosciski, Yundt and Ondricka	Aspernatur voluptas officia ipsa.	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	http://hessel-prohaska.net/wallace_west	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
158	2025-12-04 04:24:04.233223	2025-12-04 04:24:04.246366	Wyman and Sons	Tempora ab dicta ut.	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	http://hudson-olson.org/estefana	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
159	2025-12-04 04:24:04.257486	2025-12-04 04:24:04.270528	Jacobi, Lynch and Deckow	Quos molestias id praesentium.	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	http://schinner-weimann.info/venetta	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
160	2025-12-04 04:24:04.279529	2025-12-04 04:24:04.293542	Kutch Group	Rerum rem quo culpa.	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	http://raynor-gutkowski.io/charles_waters	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
161	2025-12-04 04:24:04.304937	2025-12-04 04:24:04.320617	Hauck, Quigley and Mayert	Quos reiciendis aliquam ipsa.	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	http://kessler.io/noe_bergstrom	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
162	2025-12-04 04:24:04.330959	2025-12-04 04:24:04.344975	Bauch, Block and Nienow	Impedit tempora quis omnis.	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	http://mraz-volkman.net/edmundo	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
163	2025-12-04 04:24:04.357854	2025-12-04 04:24:04.370236	Wyman and Sons	Enim blanditiis harum quia.	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	http://adams.com/rayna_parker	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
164	2025-12-04 04:24:04.383936	2025-12-04 04:24:04.398462	Schneider and Sons	Iusto harum aut sunt.	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	http://abshire-jaskolski.net/margret	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
165	2025-12-04 04:24:04.408388	2025-12-04 04:24:04.420837	Kris-Wolf	Eius dignissimos consequatur eos.	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	http://veum.io/cleveland	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
166	2025-12-04 04:24:04.434703	2025-12-04 04:24:04.448028	Weber-Emmerich	Omnis accusamus labore nam.	Weekly food pantry (Thursday).\n	http://yost.info/karima	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
167	2025-12-04 04:24:04.459734	2025-12-04 04:24:04.470197	Kuhn-Tillman	Tempore id in ratione.	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	http://williamson-beier.info/art	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
168	2025-12-04 04:24:04.483991	2025-12-04 04:24:04.497245	Wehner, Bechtelar and Runte	Dolore nulla sed aliquam.	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	http://jerde.org/dannielle_howell	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
169	2025-12-04 04:24:04.510038	2025-12-04 04:24:04.526166	Swaniawski Group	Odio labore veniam dolorum.	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	http://durgan.co/bobby_jaskolski	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
170	2025-12-04 04:24:04.536436	2025-12-04 04:24:04.548783	Herzog, McKenzie and Schulist	Est non vel voluptate.	Serves lunch Monday and Wednesday. Dinner available all days.\n	http://schoen.net/hilario_ledner	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
171	2025-12-04 04:24:04.55903	2025-12-04 04:24:04.572069	Hane-Kertzmann	Praesentium temporibus aut recusandae.	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	http://quigley.io/harlan.ziemann	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
172	2025-12-04 04:24:04.584219	2025-12-04 04:24:04.597298	Botsford-Nader	Similique non perspiciatis eius.	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	http://thiel.info/angelyn	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
173	2025-12-04 04:24:04.609795	2025-12-04 04:24:04.622163	Schowalter Inc	Aut qui modi neque.	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	http://rutherford-altenwerth.name/herlinda	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
174	2025-12-04 04:24:04.634286	2025-12-04 04:24:04.648417	Reilly LLC	Qui numquam officiis non.	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	http://schmeler.io/darrin.greenholt	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
175	2025-12-04 04:24:04.660337	2025-12-04 04:24:04.670045	Ortiz, Gleichner and Kreiger	Et sed recusandae vitae.	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	http://ullrich.co/kimberli	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
176	2025-12-04 04:24:04.680566	2025-12-04 04:24:04.693716	Lindgren-McKenzie	Accusamus quia delectus enim.	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	http://jerde-corkery.com/margherita_green	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
177	2025-12-04 04:24:04.706983	2025-12-04 04:24:04.719513	Blick Group	Iure consectetur quos suscipit.	A place to shower on Tuesday through Saturday.\n	http://stanton.name/nikole.hilll	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
178	2025-12-04 04:24:04.732332	2025-12-04 04:24:04.743839	Kreiger-Abernathy	Officiis sed qui modi.	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	http://ullrich.io/shera_ullrich	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
179	2025-12-04 04:24:04.754228	2025-12-04 04:24:04.767067	O'Hara-Crona	Illo quam ad omnis.	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	http://larson.info/tiara_prosacco	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
180	2025-12-04 04:24:04.777999	2025-12-04 04:24:04.790049	Cruickshank LLC	Mollitia ut sunt optio.	Serves lunch Monday and Wednesday. Dinner available all days.\n	http://schulist-reynolds.org/abbie.lind	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
181	2025-12-04 04:24:04.800773	2025-12-04 04:24:04.813663	Zieme-Tremblay	Non itaque aut a.	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	http://kunze.io/hobert	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
182	2025-12-04 04:24:04.824698	2025-12-04 04:24:04.838753	Rice-O'Reilly	Aut sint quibusdam impedit.	Weekly food pantry (Thursday).\n	http://leuschke.io/yetta_keeling	\N	\N	1	f	\N	\N	\N	\N	\N	\N	0	\N
\.


--
-- Data for Name: resources_sites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resources_sites (resource_id, site_id) FROM stdin;
1	1
2	1
3	1
4	1
4	2
5	1
6	2
7	1
7	2
8	1
9	2
10	1
11	1
11	2
12	2
13	2
14	2
15	2
16	1
16	2
17	1
17	2
18	1
18	2
19	1
19	2
20	1
20	2
21	1
21	2
22	2
23	2
24	1
24	2
25	1
25	2
26	1
26	2
27	1
27	2
28	2
29	1
29	2
30	1
31	2
32	1
32	2
33	1
34	1
35	1
35	2
36	1
37	1
38	1
39	1
39	2
40	1
40	2
41	1
41	2
42	1
43	2
44	1
44	2
45	1
46	1
46	2
47	1
48	1
48	2
49	1
49	2
50	2
51	2
52	1
52	2
53	1
53	2
54	2
55	1
55	2
56	2
57	1
58	1
58	2
59	1
59	2
60	1
60	2
61	1
62	1
63	2
64	1
64	2
65	2
66	2
67	2
68	1
69	2
70	1
71	2
72	1
73	2
74	1
75	1
75	2
76	1
77	1
77	2
78	1
78	2
79	1
80	2
81	1
82	1
82	2
83	1
83	2
84	2
85	1
85	2
86	1
86	2
87	1
87	2
88	1
88	2
89	2
90	1
90	2
91	1
91	2
92	2
93	2
94	1
95	1
95	2
96	1
96	2
97	1
98	2
99	2
100	1
100	2
101	1
102	1
103	1
104	1
104	2
105	2
106	1
106	2
107	1
108	1
109	2
110	2
111	2
112	1
112	2
113	1
113	2
114	1
114	2
115	1
116	1
117	1
117	2
118	1
119	2
120	2
121	1
121	2
122	1
122	2
123	1
123	2
124	2
125	2
126	2
127	1
128	1
129	1
130	1
130	2
131	1
132	1
133	1
133	2
134	1
134	2
135	2
136	2
137	2
138	2
139	1
139	2
140	1
141	1
141	2
142	1
143	1
144	2
145	1
146	2
147	1
147	2
148	2
149	1
149	2
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (id, review, tags, feedback_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: saved_searches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.saved_searches (id, user_id, name, search, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schedule_days; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedule_days (id, created_at, updated_at, day, opens_at, closes_at, schedule_id, open_time, open_day, close_time, close_day) FROM stdin;
1	2025-12-04 04:23:58.712506	2025-12-04 04:23:58.712506	Monday	1445	130	1	\N	\N	\N	\N
2	2025-12-04 04:23:58.713469	2025-12-04 04:23:58.713469	Tuesday	615	1530	1	\N	\N	\N	\N
3	2025-12-04 04:23:58.714208	2025-12-04 04:23:58.714208	Wednesday	830	2130	1	\N	\N	\N	\N
4	2025-12-04 04:23:58.714923	2025-12-04 04:23:58.714923	Thursday	2200	230	1	\N	\N	\N	\N
5	2025-12-04 04:23:58.715596	2025-12-04 04:23:58.715596	Friday	845	2215	1	\N	\N	\N	\N
6	2025-12-04 04:23:58.716402	2025-12-04 04:23:58.716402	Saturday	1000	1530	1	\N	\N	\N	\N
7	2025-12-04 04:23:58.743353	2025-12-04 04:23:58.743353	Monday	2015	130	2	\N	\N	\N	\N
8	2025-12-04 04:23:58.744165	2025-12-04 04:23:58.744165	Tuesday	745	2130	2	\N	\N	\N	\N
9	2025-12-04 04:23:58.744869	2025-12-04 04:23:58.744869	Wednesday	930	1645	2	\N	\N	\N	\N
10	2025-12-04 04:23:58.745559	2025-12-04 04:23:58.745559	Thursday	730	2045	2	\N	\N	\N	\N
11	2025-12-04 04:23:58.746283	2025-12-04 04:23:58.746283	Saturday	930	1400	2	\N	\N	\N	\N
12	2025-12-04 04:23:58.777471	2025-12-04 04:23:58.777471	Monday	700	1830	3	\N	\N	\N	\N
13	2025-12-04 04:23:58.778292	2025-12-04 04:23:58.778292	Wednesday	1030	1215	3	\N	\N	\N	\N
14	2025-12-04 04:23:58.779046	2025-12-04 04:23:58.779046	Wednesday	1715	2400	3	\N	\N	\N	\N
15	2025-12-04 04:23:58.779791	2025-12-04 04:23:58.779791	Thursday	645	2245	3	\N	\N	\N	\N
16	2025-12-04 04:23:58.780505	2025-12-04 04:23:58.780505	Friday	915	1445	3	\N	\N	\N	\N
17	2025-12-04 04:23:58.781221	2025-12-04 04:23:58.781221	Saturday	630	2300	3	\N	\N	\N	\N
18	2025-12-04 04:23:58.781924	2025-12-04 04:23:58.781924	Sunday	1400	230	3	\N	\N	\N	\N
19	2025-12-04 04:23:58.790919	2025-12-04 04:23:58.790919	Monday	800	845	4	\N	\N	\N	\N
20	2025-12-04 04:23:58.791729	2025-12-04 04:23:58.791729	Monday	1200	130	4	\N	\N	\N	\N
21	2025-12-04 04:23:58.792455	2025-12-04 04:23:58.792455	Wednesday	915	2200	4	\N	\N	\N	\N
22	2025-12-04 04:23:58.793255	2025-12-04 04:23:58.793255	Thursday	15	545	4	\N	\N	\N	\N
23	2025-12-04 04:23:58.793945	2025-12-04 04:23:58.793945	Thursday	915	1500	4	\N	\N	\N	\N
24	2025-12-04 04:23:58.794705	2025-12-04 04:23:58.794705	Friday	815	2215	4	\N	\N	\N	\N
25	2025-12-04 04:23:58.795448	2025-12-04 04:23:58.795448	Saturday	415	545	4	\N	\N	\N	\N
26	2025-12-04 04:23:58.796124	2025-12-04 04:23:58.796124	Saturday	1930	2300	4	\N	\N	\N	\N
27	2025-12-04 04:23:58.796872	2025-12-04 04:23:58.796872	Sunday	1830	315	4	\N	\N	\N	\N
28	2025-12-04 04:23:58.807786	2025-12-04 04:23:58.807786	Monday	1500	1730	5	\N	\N	\N	\N
29	2025-12-04 04:23:58.808556	2025-12-04 04:23:58.808556	Monday	1930	200	5	\N	\N	\N	\N
30	2025-12-04 04:23:58.809393	2025-12-04 04:23:58.809393	Tuesday	500	730	5	\N	\N	\N	\N
31	2025-12-04 04:23:58.810104	2025-12-04 04:23:58.810104	Tuesday	1915	2100	5	\N	\N	\N	\N
32	2025-12-04 04:23:58.810803	2025-12-04 04:23:58.810803	Wednesday	715	1730	5	\N	\N	\N	\N
33	2025-12-04 04:23:58.81155	2025-12-04 04:23:58.81155	Thursday	715	2045	5	\N	\N	\N	\N
34	2025-12-04 04:23:58.812278	2025-12-04 04:23:58.812278	Friday	745	2015	5	\N	\N	\N	\N
35	2025-12-04 04:23:58.812974	2025-12-04 04:23:58.812974	Saturday	730	1800	5	\N	\N	\N	\N
36	2025-12-04 04:23:58.813812	2025-12-04 04:23:58.813812	Sunday	1315	1430	5	\N	\N	\N	\N
37	2025-12-04 04:23:58.81453	2025-12-04 04:23:58.81453	Sunday	2245	45	5	\N	\N	\N	\N
38	2025-12-04 04:23:58.825801	2025-12-04 04:23:58.825801	Monday	615	1445	6	\N	\N	\N	\N
39	2025-12-04 04:23:58.826791	2025-12-04 04:23:58.826791	Tuesday	330	2200	6	\N	\N	\N	\N
40	2025-12-04 04:23:58.82751	2025-12-04 04:23:58.82751	Tuesday	2315	130	6	\N	\N	\N	\N
41	2025-12-04 04:23:58.828219	2025-12-04 04:23:58.828219	Wednesday	1515	100	6	\N	\N	\N	\N
42	2025-12-04 04:23:58.83402	2025-12-04 04:23:58.83402	Monday	200	700	7	\N	\N	\N	\N
43	2025-12-04 04:23:58.834745	2025-12-04 04:23:58.834745	Monday	1015	2345	7	\N	\N	\N	\N
44	2025-12-04 04:23:58.835399	2025-12-04 04:23:58.835399	Tuesday	900	2300	7	\N	\N	\N	\N
45	2025-12-04 04:23:58.836071	2025-12-04 04:23:58.836071	Wednesday	630	2215	7	\N	\N	\N	\N
46	2025-12-04 04:23:58.836813	2025-12-04 04:23:58.836813	Friday	745	1830	7	\N	\N	\N	\N
47	2025-12-04 04:23:58.837484	2025-12-04 04:23:58.837484	Saturday	800	1430	7	\N	\N	\N	\N
48	2025-12-04 04:23:58.83824	2025-12-04 04:23:58.83824	Sunday	1845	300	7	\N	\N	\N	\N
49	2025-12-04 04:23:58.846849	2025-12-04 04:23:58.846849	Monday	830	1600	8	\N	\N	\N	\N
50	2025-12-04 04:23:58.847622	2025-12-04 04:23:58.847622	Thursday	715	2130	8	\N	\N	\N	\N
51	2025-12-04 04:23:58.848328	2025-12-04 04:23:58.848328	Friday	700	1745	8	\N	\N	\N	\N
52	2025-12-04 04:23:58.849041	2025-12-04 04:23:58.849041	Saturday	600	2130	8	\N	\N	\N	\N
53	2025-12-04 04:23:58.849719	2025-12-04 04:23:58.849719	Sunday	715	1715	8	\N	\N	\N	\N
54	2025-12-04 04:23:58.860769	2025-12-04 04:23:58.860769	Tuesday	800	1430	9	\N	\N	\N	\N
55	2025-12-04 04:23:58.861496	2025-12-04 04:23:58.861496	Wednesday	930	2000	9	\N	\N	\N	\N
56	2025-12-04 04:23:58.862203	2025-12-04 04:23:58.862203	Thursday	1745	100	9	\N	\N	\N	\N
57	2025-12-04 04:23:58.862935	2025-12-04 04:23:58.862935	Friday	745	1430	9	\N	\N	\N	\N
58	2025-12-04 04:23:58.863664	2025-12-04 04:23:58.863664	Saturday	930	1400	9	\N	\N	\N	\N
59	2025-12-04 04:23:58.864373	2025-12-04 04:23:58.864373	Sunday	700	1500	9	\N	\N	\N	\N
60	2025-12-04 04:23:58.869884	2025-12-04 04:23:58.869884	Tuesday	1000	1400	10	\N	\N	\N	\N
61	2025-12-04 04:23:58.870767	2025-12-04 04:23:58.870767	Thursday	2130	200	10	\N	\N	\N	\N
62	2025-12-04 04:23:58.871527	2025-12-04 04:23:58.871527	Friday	645	2330	10	\N	\N	\N	\N
63	2025-12-04 04:23:58.872279	2025-12-04 04:23:58.872279	Saturday	15	530	10	\N	\N	\N	\N
64	2025-12-04 04:23:58.872984	2025-12-04 04:23:58.872984	Saturday	1845	2345	10	\N	\N	\N	\N
65	2025-12-04 04:23:58.873799	2025-12-04 04:23:58.873799	Sunday	730	1800	10	\N	\N	\N	\N
66	2025-12-04 04:23:58.885207	2025-12-04 04:23:58.885207	Monday	745	2100	11	\N	\N	\N	\N
67	2025-12-04 04:23:58.885937	2025-12-04 04:23:58.885937	Tuesday	400	430	11	\N	\N	\N	\N
68	2025-12-04 04:23:58.886638	2025-12-04 04:23:58.886638	Tuesday	445	2145	11	\N	\N	\N	\N
69	2025-12-04 04:23:58.887323	2025-12-04 04:23:58.887323	Wednesday	1000	2145	11	\N	\N	\N	\N
70	2025-12-04 04:23:58.888016	2025-12-04 04:23:58.888016	Thursday	615	1845	11	\N	\N	\N	\N
71	2025-12-04 04:23:58.888764	2025-12-04 04:23:58.888764	Friday	900	2100	11	\N	\N	\N	\N
72	2025-12-04 04:23:58.889577	2025-12-04 04:23:58.889577	Sunday	815	1530	11	\N	\N	\N	\N
73	2025-12-04 04:23:58.890249	2025-12-04 04:23:58.890249	Sunday	2130	2145	11	\N	\N	\N	\N
74	2025-12-04 04:23:58.895691	2025-12-04 04:23:58.895691	Monday	830	1830	12	\N	\N	\N	\N
75	2025-12-04 04:23:58.896394	2025-12-04 04:23:58.896394	Tuesday	645	2315	12	\N	\N	\N	\N
76	2025-12-04 04:23:58.897176	2025-12-04 04:23:58.897176	Wednesday	730	1445	12	\N	\N	\N	\N
77	2025-12-04 04:23:58.897856	2025-12-04 04:23:58.897856	Thursday	845	2245	12	\N	\N	\N	\N
78	2025-12-04 04:23:58.898573	2025-12-04 04:23:58.898573	Saturday	845	1515	12	\N	\N	\N	\N
79	2025-12-04 04:23:58.899362	2025-12-04 04:23:58.899362	Sunday	815	2300	12	\N	\N	\N	\N
80	2025-12-04 04:23:58.909178	2025-12-04 04:23:58.909178	Monday	1945	400	13	\N	\N	\N	\N
81	2025-12-04 04:23:58.909874	2025-12-04 04:23:58.909874	Tuesday	1530	345	13	\N	\N	\N	\N
82	2025-12-04 04:23:58.910587	2025-12-04 04:23:58.910587	Wednesday	730	815	13	\N	\N	\N	\N
83	2025-12-04 04:23:58.911249	2025-12-04 04:23:58.911249	Wednesday	1100	2330	13	\N	\N	\N	\N
84	2025-12-04 04:23:58.911967	2025-12-04 04:23:58.911967	Thursday	30	245	13	\N	\N	\N	\N
85	2025-12-04 04:23:58.912648	2025-12-04 04:23:58.912648	Thursday	830	1915	13	\N	\N	\N	\N
86	2025-12-04 04:23:58.913341	2025-12-04 04:23:58.913341	Saturday	830	2315	13	\N	\N	\N	\N
87	2025-12-04 04:23:58.914254	2025-12-04 04:23:58.914254	Sunday	500	715	13	\N	\N	\N	\N
88	2025-12-04 04:23:58.914914	2025-12-04 04:23:58.914914	Sunday	845	1030	13	\N	\N	\N	\N
89	2025-12-04 04:23:58.919471	2025-12-04 04:23:58.919471	Monday	645	2045	14	\N	\N	\N	\N
90	2025-12-04 04:23:58.920198	2025-12-04 04:23:58.920198	Tuesday	545	1015	14	\N	\N	\N	\N
91	2025-12-04 04:23:58.920872	2025-12-04 04:23:58.920872	Tuesday	2230	2315	14	\N	\N	\N	\N
92	2025-12-04 04:23:58.921667	2025-12-04 04:23:58.921667	Wednesday	630	815	14	\N	\N	\N	\N
93	2025-12-04 04:23:58.922327	2025-12-04 04:23:58.922327	Wednesday	1245	1315	14	\N	\N	\N	\N
94	2025-12-04 04:23:58.923004	2025-12-04 04:23:58.923004	Thursday	800	2115	14	\N	\N	\N	\N
95	2025-12-04 04:23:58.92378	2025-12-04 04:23:58.92378	Friday	600	1645	14	\N	\N	\N	\N
96	2025-12-04 04:23:58.924446	2025-12-04 04:23:58.924446	Saturday	1100	1700	14	\N	\N	\N	\N
97	2025-12-04 04:23:58.925168	2025-12-04 04:23:58.925168	Saturday	2000	2145	14	\N	\N	\N	\N
98	2025-12-04 04:23:58.925992	2025-12-04 04:23:58.925992	Sunday	130	600	14	\N	\N	\N	\N
99	2025-12-04 04:23:58.9267	2025-12-04 04:23:58.9267	Sunday	1330	2045	14	\N	\N	\N	\N
100	2025-12-04 04:23:58.937335	2025-12-04 04:23:58.937335	Monday	1000	1745	15	\N	\N	\N	\N
101	2025-12-04 04:23:58.938058	2025-12-04 04:23:58.938058	Tuesday	945	1500	15	\N	\N	\N	\N
102	2025-12-04 04:23:58.938817	2025-12-04 04:23:58.938817	Wednesday	845	1800	15	\N	\N	\N	\N
103	2025-12-04 04:23:58.939473	2025-12-04 04:23:58.939473	Thursday	845	2245	15	\N	\N	\N	\N
104	2025-12-04 04:23:58.940218	2025-12-04 04:23:58.940218	Friday	715	1415	15	\N	\N	\N	\N
105	2025-12-04 04:23:58.940927	2025-12-04 04:23:58.940927	Saturday	100	645	15	\N	\N	\N	\N
106	2025-12-04 04:23:58.941583	2025-12-04 04:23:58.941583	Saturday	730	945	15	\N	\N	\N	\N
107	2025-12-04 04:23:58.942287	2025-12-04 04:23:58.942287	Sunday	500	800	15	\N	\N	\N	\N
108	2025-12-04 04:23:58.94291	2025-12-04 04:23:58.94291	Sunday	1530	1600	15	\N	\N	\N	\N
109	2025-12-04 04:23:58.948506	2025-12-04 04:23:58.948506	Monday	1515	300	16	\N	\N	\N	\N
110	2025-12-04 04:23:58.949314	2025-12-04 04:23:58.949314	Tuesday	700	1415	16	\N	\N	\N	\N
111	2025-12-04 04:23:58.949995	2025-12-04 04:23:58.949995	Wednesday	700	1430	16	\N	\N	\N	\N
112	2025-12-04 04:23:58.950724	2025-12-04 04:23:58.950724	Thursday	200	545	16	\N	\N	\N	\N
113	2025-12-04 04:23:58.951365	2025-12-04 04:23:58.951365	Thursday	600	1530	16	\N	\N	\N	\N
114	2025-12-04 04:23:58.952039	2025-12-04 04:23:58.952039	Friday	900	2215	16	\N	\N	\N	\N
115	2025-12-04 04:23:58.952856	2025-12-04 04:23:58.952856	Saturday	1545	345	16	\N	\N	\N	\N
116	2025-12-04 04:23:58.953737	2025-12-04 04:23:58.953737	Sunday	1530	115	16	\N	\N	\N	\N
117	2025-12-04 04:23:58.964753	2025-12-04 04:23:58.964753	Monday	615	1945	17	\N	\N	\N	\N
118	2025-12-04 04:23:58.965504	2025-12-04 04:23:58.965504	Tuesday	615	1945	17	\N	\N	\N	\N
119	2025-12-04 04:23:58.966213	2025-12-04 04:23:58.966213	Thursday	500	1130	17	\N	\N	\N	\N
120	2025-12-04 04:23:58.966883	2025-12-04 04:23:58.966883	Thursday	2030	2115	17	\N	\N	\N	\N
121	2025-12-04 04:23:58.967612	2025-12-04 04:23:58.967612	Friday	945	1145	17	\N	\N	\N	\N
122	2025-12-04 04:23:58.968256	2025-12-04 04:23:58.968256	Friday	1330	1915	17	\N	\N	\N	\N
123	2025-12-04 04:23:58.968998	2025-12-04 04:23:58.968998	Sunday	1600	200	17	\N	\N	\N	\N
124	2025-12-04 04:23:58.97519	2025-12-04 04:23:58.97519	Monday	600	1900	18	\N	\N	\N	\N
125	2025-12-04 04:23:58.975942	2025-12-04 04:23:58.975942	Tuesday	930	1700	18	\N	\N	\N	\N
126	2025-12-04 04:23:58.976662	2025-12-04 04:23:58.976662	Thursday	630	2300	18	\N	\N	\N	\N
127	2025-12-04 04:23:58.977368	2025-12-04 04:23:58.977368	Friday	800	1500	18	\N	\N	\N	\N
128	2025-12-04 04:23:58.978135	2025-12-04 04:23:58.978135	Sunday	0	1515	18	\N	\N	\N	\N
129	2025-12-04 04:23:58.978822	2025-12-04 04:23:58.978822	Sunday	1715	2130	18	\N	\N	\N	\N
130	2025-12-04 04:23:58.990359	2025-12-04 04:23:58.990359	Monday	745	1615	19	\N	\N	\N	\N
131	2025-12-04 04:23:58.991112	2025-12-04 04:23:58.991112	Tuesday	1415	2030	19	\N	\N	\N	\N
132	2025-12-04 04:23:58.991764	2025-12-04 04:23:58.991764	Tuesday	2315	930	19	\N	\N	\N	\N
133	2025-12-04 04:23:58.992446	2025-12-04 04:23:58.992446	Wednesday	745	1530	19	\N	\N	\N	\N
134	2025-12-04 04:23:58.993154	2025-12-04 04:23:58.993154	Thursday	1315	1800	19	\N	\N	\N	\N
135	2025-12-04 04:23:58.993799	2025-12-04 04:23:58.993799	Thursday	2230	1115	19	\N	\N	\N	\N
136	2025-12-04 04:23:58.994477	2025-12-04 04:23:58.994477	Friday	900	2345	19	\N	\N	\N	\N
137	2025-12-04 04:23:58.995191	2025-12-04 04:23:58.995191	Saturday	715	2330	19	\N	\N	\N	\N
138	2025-12-04 04:23:58.995867	2025-12-04 04:23:58.995867	Sunday	1000	1600	19	\N	\N	\N	\N
139	2025-12-04 04:23:59.001278	2025-12-04 04:23:59.001278	Monday	1430	100	20	\N	\N	\N	\N
140	2025-12-04 04:23:59.001978	2025-12-04 04:23:59.001978	Tuesday	645	1415	20	\N	\N	\N	\N
141	2025-12-04 04:23:59.002679	2025-12-04 04:23:59.002679	Friday	145	1645	20	\N	\N	\N	\N
142	2025-12-04 04:23:59.003313	2025-12-04 04:23:59.003313	Friday	1830	1945	20	\N	\N	\N	\N
143	2025-12-04 04:23:59.003997	2025-12-04 04:23:59.003997	Sunday	630	2000	20	\N	\N	\N	\N
144	2025-12-04 04:23:59.014261	2025-12-04 04:23:59.014261	Monday	915	1330	21	\N	\N	\N	\N
145	2025-12-04 04:23:59.014936	2025-12-04 04:23:59.014936	Monday	2045	0	21	\N	\N	\N	\N
146	2025-12-04 04:23:59.015599	2025-12-04 04:23:59.015599	Tuesday	800	1630	21	\N	\N	\N	\N
147	2025-12-04 04:23:59.016349	2025-12-04 04:23:59.016349	Thursday	145	530	21	\N	\N	\N	\N
148	2025-12-04 04:23:59.016989	2025-12-04 04:23:59.016989	Thursday	645	1030	21	\N	\N	\N	\N
149	2025-12-04 04:23:59.017703	2025-12-04 04:23:59.017703	Friday	1015	1215	21	\N	\N	\N	\N
150	2025-12-04 04:23:59.018331	2025-12-04 04:23:59.018331	Friday	1715	200	21	\N	\N	\N	\N
151	2025-12-04 04:23:59.018999	2025-12-04 04:23:59.018999	Sunday	845	1400	21	\N	\N	\N	\N
152	2025-12-04 04:23:59.024605	2025-12-04 04:23:59.024605	Monday	615	1445	22	\N	\N	\N	\N
153	2025-12-04 04:23:59.025352	2025-12-04 04:23:59.025352	Tuesday	600	2100	22	\N	\N	\N	\N
154	2025-12-04 04:23:59.026059	2025-12-04 04:23:59.026059	Wednesday	930	2015	22	\N	\N	\N	\N
155	2025-12-04 04:23:59.026857	2025-12-04 04:23:59.026857	Thursday	1845	1915	22	\N	\N	\N	\N
156	2025-12-04 04:23:59.0275	2025-12-04 04:23:59.0275	Thursday	2115	1800	22	\N	\N	\N	\N
157	2025-12-04 04:23:59.031988	2025-12-04 04:23:59.031988	Friday	745	2115	22	\N	\N	\N	\N
158	2025-12-04 04:23:59.032779	2025-12-04 04:23:59.032779	Sunday	1000	1445	22	\N	\N	\N	\N
159	2025-12-04 04:23:59.042816	2025-12-04 04:23:59.042816	Tuesday	1000	1415	23	\N	\N	\N	\N
160	2025-12-04 04:23:59.043505	2025-12-04 04:23:59.043505	Wednesday	800	1845	23	\N	\N	\N	\N
161	2025-12-04 04:23:59.044201	2025-12-04 04:23:59.044201	Thursday	645	1715	23	\N	\N	\N	\N
162	2025-12-04 04:23:59.044929	2025-12-04 04:23:59.044929	Saturday	615	730	23	\N	\N	\N	\N
163	2025-12-04 04:23:59.045571	2025-12-04 04:23:59.045571	Saturday	1615	2315	23	\N	\N	\N	\N
164	2025-12-04 04:23:59.04625	2025-12-04 04:23:59.04625	Sunday	1445	330	23	\N	\N	\N	\N
165	2025-12-04 04:23:59.050944	2025-12-04 04:23:59.050944	Monday	1000	2345	24	\N	\N	\N	\N
166	2025-12-04 04:23:59.051647	2025-12-04 04:23:59.051647	Wednesday	845	2200	24	\N	\N	\N	\N
167	2025-12-04 04:23:59.052327	2025-12-04 04:23:59.052327	Thursday	800	2130	24	\N	\N	\N	\N
168	2025-12-04 04:23:59.053178	2025-12-04 04:23:59.053178	Friday	730	1915	24	\N	\N	\N	\N
169	2025-12-04 04:23:59.053885	2025-12-04 04:23:59.053885	Saturday	45	1200	24	\N	\N	\N	\N
170	2025-12-04 04:23:59.054579	2025-12-04 04:23:59.054579	Saturday	1315	1845	24	\N	\N	\N	\N
171	2025-12-04 04:23:59.055357	2025-12-04 04:23:59.055357	Sunday	1845	100	24	\N	\N	\N	\N
172	2025-12-04 04:23:59.062863	2025-12-04 04:23:59.062863	Monday	130	300	25	\N	\N	\N	\N
173	2025-12-04 04:23:59.06359	2025-12-04 04:23:59.06359	Monday	845	900	25	\N	\N	\N	\N
174	2025-12-04 04:23:59.06429	2025-12-04 04:23:59.06429	Tuesday	915	1845	25	\N	\N	\N	\N
175	2025-12-04 04:23:59.064954	2025-12-04 04:23:59.064954	Wednesday	600	1930	25	\N	\N	\N	\N
176	2025-12-04 04:23:59.065698	2025-12-04 04:23:59.065698	Thursday	30	500	25	\N	\N	\N	\N
177	2025-12-04 04:23:59.066321	2025-12-04 04:23:59.066321	Thursday	600	2330	25	\N	\N	\N	\N
178	2025-12-04 04:23:59.067009	2025-12-04 04:23:59.067009	Saturday	745	1530	25	\N	\N	\N	\N
179	2025-12-04 04:23:59.067675	2025-12-04 04:23:59.067675	Sunday	745	2400	25	\N	\N	\N	\N
180	2025-12-04 04:23:59.077521	2025-12-04 04:23:59.077521	Monday	645	1845	26	\N	\N	\N	\N
181	2025-12-04 04:23:59.078265	2025-12-04 04:23:59.078265	Tuesday	1200	1830	26	\N	\N	\N	\N
182	2025-12-04 04:23:59.078905	2025-12-04 04:23:59.078905	Tuesday	1930	715	26	\N	\N	\N	\N
183	2025-12-04 04:23:59.079577	2025-12-04 04:23:59.079577	Wednesday	615	2115	26	\N	\N	\N	\N
184	2025-12-04 04:23:59.080283	2025-12-04 04:23:59.080283	Saturday	2030	200	26	\N	\N	\N	\N
185	2025-12-04 04:23:59.081005	2025-12-04 04:23:59.081005	Sunday	115	415	26	\N	\N	\N	\N
186	2025-12-04 04:23:59.081655	2025-12-04 04:23:59.081655	Sunday	930	1145	26	\N	\N	\N	\N
187	2025-12-04 04:23:59.086394	2025-12-04 04:23:59.086394	Monday	645	1915	27	\N	\N	\N	\N
188	2025-12-04 04:23:59.087101	2025-12-04 04:23:59.087101	Tuesday	900	2015	27	\N	\N	\N	\N
189	2025-12-04 04:23:59.087773	2025-12-04 04:23:59.087773	Wednesday	1545	315	27	\N	\N	\N	\N
190	2025-12-04 04:23:59.08853	2025-12-04 04:23:59.08853	Friday	200	330	27	\N	\N	\N	\N
191	2025-12-04 04:23:59.089183	2025-12-04 04:23:59.089183	Friday	1315	1700	27	\N	\N	\N	\N
192	2025-12-04 04:23:59.099771	2025-12-04 04:23:59.099771	Tuesday	645	1715	28	\N	\N	\N	\N
193	2025-12-04 04:23:59.100505	2025-12-04 04:23:59.100505	Wednesday	100	545	28	\N	\N	\N	\N
194	2025-12-04 04:23:59.101154	2025-12-04 04:23:59.101154	Wednesday	1445	1645	28	\N	\N	\N	\N
195	2025-12-04 04:23:59.101891	2025-12-04 04:23:59.101891	Thursday	715	1045	28	\N	\N	\N	\N
196	2025-12-04 04:23:59.10253	2025-12-04 04:23:59.10253	Thursday	1745	500	28	\N	\N	\N	\N
197	2025-12-04 04:23:59.103238	2025-12-04 04:23:59.103238	Saturday	2145	330	28	\N	\N	\N	\N
198	2025-12-04 04:23:59.103895	2025-12-04 04:23:59.103895	Sunday	730	1600	28	\N	\N	\N	\N
199	2025-12-04 04:23:59.10938	2025-12-04 04:23:59.10938	Monday	615	1500	29	\N	\N	\N	\N
200	2025-12-04 04:23:59.110109	2025-12-04 04:23:59.110109	Tuesday	100	545	29	\N	\N	\N	\N
201	2025-12-04 04:23:59.110762	2025-12-04 04:23:59.110762	Tuesday	1015	1130	29	\N	\N	\N	\N
202	2025-12-04 04:23:59.111449	2025-12-04 04:23:59.111449	Wednesday	2245	330	29	\N	\N	\N	\N
203	2025-12-04 04:23:59.112151	2025-12-04 04:23:59.112151	Thursday	330	645	29	\N	\N	\N	\N
204	2025-12-04 04:23:59.112794	2025-12-04 04:23:59.112794	Thursday	815	1730	29	\N	\N	\N	\N
205	2025-12-04 04:23:59.113434	2025-12-04 04:23:59.113434	Friday	615	2400	29	\N	\N	\N	\N
206	2025-12-04 04:23:59.114117	2025-12-04 04:23:59.114117	Sunday	645	1915	29	\N	\N	\N	\N
207	2025-12-04 04:23:59.122876	2025-12-04 04:23:59.122876	Monday	815	2000	30	\N	\N	\N	\N
208	2025-12-04 04:23:59.123599	2025-12-04 04:23:59.123599	Tuesday	1730	345	30	\N	\N	\N	\N
209	2025-12-04 04:23:59.124287	2025-12-04 04:23:59.124287	Thursday	2100	315	30	\N	\N	\N	\N
210	2025-12-04 04:23:59.124994	2025-12-04 04:23:59.124994	Friday	1530	1815	30	\N	\N	\N	\N
211	2025-12-04 04:23:59.125648	2025-12-04 04:23:59.125648	Friday	1930	130	30	\N	\N	\N	\N
212	2025-12-04 04:23:59.126329	2025-12-04 04:23:59.126329	Sunday	1630	245	30	\N	\N	\N	\N
213	2025-12-04 04:23:59.136943	2025-12-04 04:23:59.136943	Thursday	900	1815	31	\N	\N	\N	\N
214	2025-12-04 04:23:59.137622	2025-12-04 04:23:59.137622	Friday	830	2400	31	\N	\N	\N	\N
215	2025-12-04 04:23:59.138354	2025-12-04 04:23:59.138354	Saturday	515	830	31	\N	\N	\N	\N
216	2025-12-04 04:23:59.139023	2025-12-04 04:23:59.139023	Saturday	1245	2200	31	\N	\N	\N	\N
217	2025-12-04 04:23:59.139712	2025-12-04 04:23:59.139712	Sunday	645	1730	31	\N	\N	\N	\N
218	2025-12-04 04:23:59.14505	2025-12-04 04:23:59.14505	Monday	315	330	32	\N	\N	\N	\N
219	2025-12-04 04:23:59.145745	2025-12-04 04:23:59.145745	Monday	1545	1700	32	\N	\N	\N	\N
220	2025-12-04 04:23:59.146508	2025-12-04 04:23:59.146508	Tuesday	230	545	32	\N	\N	\N	\N
221	2025-12-04 04:23:59.147173	2025-12-04 04:23:59.147173	Tuesday	1300	2315	32	\N	\N	\N	\N
222	2025-12-04 04:23:59.147872	2025-12-04 04:23:59.147872	Wednesday	1945	200	32	\N	\N	\N	\N
223	2025-12-04 04:23:59.148526	2025-12-04 04:23:59.148526	Thursday	845	2400	32	\N	\N	\N	\N
224	2025-12-04 04:23:59.149198	2025-12-04 04:23:59.149198	Friday	2145	130	32	\N	\N	\N	\N
225	2025-12-04 04:23:59.149863	2025-12-04 04:23:59.149863	Saturday	2045	200	32	\N	\N	\N	\N
226	2025-12-04 04:23:59.150558	2025-12-04 04:23:59.150558	Sunday	1000	1315	32	\N	\N	\N	\N
227	2025-12-04 04:23:59.151192	2025-12-04 04:23:59.151192	Sunday	1900	2115	32	\N	\N	\N	\N
228	2025-12-04 04:23:59.160954	2025-12-04 04:23:59.160954	Monday	730	2215	33	\N	\N	\N	\N
229	2025-12-04 04:23:59.161696	2025-12-04 04:23:59.161696	Tuesday	1045	1530	33	\N	\N	\N	\N
230	2025-12-04 04:23:59.162335	2025-12-04 04:23:59.162335	Tuesday	1630	815	33	\N	\N	\N	\N
231	2025-12-04 04:23:59.163048	2025-12-04 04:23:59.163048	Wednesday	900	1430	33	\N	\N	\N	\N
232	2025-12-04 04:23:59.163706	2025-12-04 04:23:59.163706	Wednesday	1515	1630	33	\N	\N	\N	\N
233	2025-12-04 04:23:59.16438	2025-12-04 04:23:59.16438	Thursday	845	1900	33	\N	\N	\N	\N
234	2025-12-04 04:23:59.165146	2025-12-04 04:23:59.165146	Saturday	900	2345	33	\N	\N	\N	\N
235	2025-12-04 04:23:59.165854	2025-12-04 04:23:59.165854	Sunday	300	1215	33	\N	\N	\N	\N
236	2025-12-04 04:23:59.166526	2025-12-04 04:23:59.166526	Sunday	1300	2300	33	\N	\N	\N	\N
237	2025-12-04 04:23:59.171356	2025-12-04 04:23:59.171356	Monday	615	1845	34	\N	\N	\N	\N
238	2025-12-04 04:23:59.172062	2025-12-04 04:23:59.172062	Tuesday	1000	1945	34	\N	\N	\N	\N
239	2025-12-04 04:23:59.17276	2025-12-04 04:23:59.17276	Wednesday	1000	2130	34	\N	\N	\N	\N
240	2025-12-04 04:23:59.173466	2025-12-04 04:23:59.173466	Saturday	730	1845	34	\N	\N	\N	\N
241	2025-12-04 04:23:59.174148	2025-12-04 04:23:59.174148	Sunday	615	2030	34	\N	\N	\N	\N
242	2025-12-04 04:23:59.184677	2025-12-04 04:23:59.184677	Monday	45	645	35	\N	\N	\N	\N
243	2025-12-04 04:23:59.185373	2025-12-04 04:23:59.185373	Monday	1500	1730	35	\N	\N	\N	\N
244	2025-12-04 04:23:59.186069	2025-12-04 04:23:59.186069	Tuesday	1730	315	35	\N	\N	\N	\N
245	2025-12-04 04:23:59.186776	2025-12-04 04:23:59.186776	Wednesday	815	830	35	\N	\N	\N	\N
246	2025-12-04 04:23:59.187401	2025-12-04 04:23:59.187401	Wednesday	1400	1645	35	\N	\N	\N	\N
247	2025-12-04 04:23:59.188084	2025-12-04 04:23:59.188084	Thursday	915	2330	35	\N	\N	\N	\N
248	2025-12-04 04:23:59.188788	2025-12-04 04:23:59.188788	Friday	830	2315	35	\N	\N	\N	\N
249	2025-12-04 04:23:59.189477	2025-12-04 04:23:59.189477	Saturday	815	1645	35	\N	\N	\N	\N
250	2025-12-04 04:23:59.190172	2025-12-04 04:23:59.190172	Sunday	615	1930	35	\N	\N	\N	\N
251	2025-12-04 04:23:59.195567	2025-12-04 04:23:59.195567	Monday	1830	130	36	\N	\N	\N	\N
252	2025-12-04 04:23:59.196287	2025-12-04 04:23:59.196287	Wednesday	845	2245	36	\N	\N	\N	\N
253	2025-12-04 04:23:59.196985	2025-12-04 04:23:59.196985	Thursday	15	500	36	\N	\N	\N	\N
254	2025-12-04 04:23:59.197626	2025-12-04 04:23:59.197626	Thursday	1400	1415	36	\N	\N	\N	\N
255	2025-12-04 04:23:59.198316	2025-12-04 04:23:59.198316	Friday	45	545	36	\N	\N	\N	\N
256	2025-12-04 04:23:59.19894	2025-12-04 04:23:59.19894	Friday	815	1800	36	\N	\N	\N	\N
257	2025-12-04 04:23:59.199624	2025-12-04 04:23:59.199624	Saturday	615	2215	36	\N	\N	\N	\N
258	2025-12-04 04:23:59.211338	2025-12-04 04:23:59.211338	Monday	830	2300	37	\N	\N	\N	\N
259	2025-12-04 04:23:59.212108	2025-12-04 04:23:59.212108	Wednesday	1000	1615	37	\N	\N	\N	\N
260	2025-12-04 04:23:59.212855	2025-12-04 04:23:59.212855	Thursday	900	1830	37	\N	\N	\N	\N
261	2025-12-04 04:23:59.213535	2025-12-04 04:23:59.213535	Friday	730	2200	37	\N	\N	\N	\N
262	2025-12-04 04:23:59.21425	2025-12-04 04:23:59.21425	Saturday	45	530	37	\N	\N	\N	\N
263	2025-12-04 04:23:59.214881	2025-12-04 04:23:59.214881	Saturday	1230	1415	37	\N	\N	\N	\N
264	2025-12-04 04:23:59.215613	2025-12-04 04:23:59.215613	Sunday	830	1700	37	\N	\N	\N	\N
265	2025-12-04 04:23:59.222823	2025-12-04 04:23:59.222823	Monday	2300	400	38	\N	\N	\N	\N
266	2025-12-04 04:23:59.223726	2025-12-04 04:23:59.223726	Thursday	845	1400	38	\N	\N	\N	\N
267	2025-12-04 04:23:59.224559	2025-12-04 04:23:59.224559	Friday	600	1430	38	\N	\N	\N	\N
268	2025-12-04 04:23:59.225427	2025-12-04 04:23:59.225427	Saturday	15	430	38	\N	\N	\N	\N
269	2025-12-04 04:23:59.226226	2025-12-04 04:23:59.226226	Saturday	1245	1715	38	\N	\N	\N	\N
270	2025-12-04 04:23:59.238074	2025-12-04 04:23:59.238074	Monday	745	1845	39	\N	\N	\N	\N
271	2025-12-04 04:23:59.238946	2025-12-04 04:23:59.238946	Tuesday	530	1400	39	\N	\N	\N	\N
272	2025-12-04 04:23:59.239682	2025-12-04 04:23:59.239682	Tuesday	2300	515	39	\N	\N	\N	\N
273	2025-12-04 04:23:59.240476	2025-12-04 04:23:59.240476	Wednesday	0	1215	39	\N	\N	\N	\N
274	2025-12-04 04:23:59.241254	2025-12-04 04:23:59.241254	Wednesday	1445	2230	39	\N	\N	\N	\N
275	2025-12-04 04:23:59.242101	2025-12-04 04:23:59.242101	Thursday	530	715	39	\N	\N	\N	\N
276	2025-12-04 04:23:59.242852	2025-12-04 04:23:59.242852	Thursday	1315	1800	39	\N	\N	\N	\N
277	2025-12-04 04:23:59.243874	2025-12-04 04:23:59.243874	Friday	2130	100	39	\N	\N	\N	\N
278	2025-12-04 04:23:59.244647	2025-12-04 04:23:59.244647	Saturday	615	1700	39	\N	\N	\N	\N
279	2025-12-04 04:23:59.24537	2025-12-04 04:23:59.24537	Sunday	745	1630	39	\N	\N	\N	\N
280	2025-12-04 04:23:59.250703	2025-12-04 04:23:59.250703	Monday	100	1330	40	\N	\N	\N	\N
281	2025-12-04 04:23:59.251506	2025-12-04 04:23:59.251506	Monday	1500	2015	40	\N	\N	\N	\N
282	2025-12-04 04:23:59.25228	2025-12-04 04:23:59.25228	Tuesday	830	1400	40	\N	\N	\N	\N
283	2025-12-04 04:23:59.253071	2025-12-04 04:23:59.253071	Thursday	900	1830	40	\N	\N	\N	\N
284	2025-12-04 04:23:59.253852	2025-12-04 04:23:59.253852	Friday	900	1830	40	\N	\N	\N	\N
285	2025-12-04 04:23:59.254664	2025-12-04 04:23:59.254664	Saturday	1100	1245	40	\N	\N	\N	\N
286	2025-12-04 04:23:59.255474	2025-12-04 04:23:59.255474	Saturday	1945	2200	40	\N	\N	\N	\N
287	2025-12-04 04:23:59.256279	2025-12-04 04:23:59.256279	Sunday	630	900	40	\N	\N	\N	\N
288	2025-12-04 04:23:59.257039	2025-12-04 04:23:59.257039	Sunday	1615	1630	40	\N	\N	\N	\N
289	2025-12-04 04:23:59.265678	2025-12-04 04:23:59.265678	Monday	630	1445	41	\N	\N	\N	\N
290	2025-12-04 04:23:59.26649	2025-12-04 04:23:59.26649	Monday	1730	2145	41	\N	\N	\N	\N
291	2025-12-04 04:23:59.267264	2025-12-04 04:23:59.267264	Tuesday	930	1500	41	\N	\N	\N	\N
292	2025-12-04 04:23:59.26805	2025-12-04 04:23:59.26805	Wednesday	745	1745	41	\N	\N	\N	\N
293	2025-12-04 04:23:59.268826	2025-12-04 04:23:59.268826	Friday	800	1945	41	\N	\N	\N	\N
294	2025-12-04 04:23:59.269593	2025-12-04 04:23:59.269593	Saturday	815	1845	41	\N	\N	\N	\N
295	2025-12-04 04:23:59.281531	2025-12-04 04:23:59.281531	Monday	715	1630	42	\N	\N	\N	\N
296	2025-12-04 04:23:59.282338	2025-12-04 04:23:59.282338	Wednesday	1830	115	42	\N	\N	\N	\N
297	2025-12-04 04:23:59.283084	2025-12-04 04:23:59.283084	Thursday	815	1600	42	\N	\N	\N	\N
298	2025-12-04 04:23:59.283847	2025-12-04 04:23:59.283847	Friday	1000	1715	42	\N	\N	\N	\N
299	2025-12-04 04:23:59.284609	2025-12-04 04:23:59.284609	Sunday	845	1600	42	\N	\N	\N	\N
300	2025-12-04 04:23:59.290902	2025-12-04 04:23:59.290902	Monday	645	1500	43	\N	\N	\N	\N
301	2025-12-04 04:23:59.29185	2025-12-04 04:23:59.29185	Tuesday	900	2245	43	\N	\N	\N	\N
302	2025-12-04 04:23:59.292699	2025-12-04 04:23:59.292699	Wednesday	630	1830	43	\N	\N	\N	\N
303	2025-12-04 04:23:59.293486	2025-12-04 04:23:59.293486	Thursday	1845	330	43	\N	\N	\N	\N
304	2025-12-04 04:23:59.294262	2025-12-04 04:23:59.294262	Friday	645	1645	43	\N	\N	\N	\N
305	2025-12-04 04:23:59.295046	2025-12-04 04:23:59.295046	Sunday	645	1430	43	\N	\N	\N	\N
306	2025-12-04 04:23:59.304592	2025-12-04 04:23:59.304592	Monday	1445	330	44	\N	\N	\N	\N
307	2025-12-04 04:23:59.305398	2025-12-04 04:23:59.305398	Tuesday	945	1530	44	\N	\N	\N	\N
308	2025-12-04 04:23:59.306194	2025-12-04 04:23:59.306194	Wednesday	615	1730	44	\N	\N	\N	\N
309	2025-12-04 04:23:59.307013	2025-12-04 04:23:59.307013	Friday	700	1545	44	\N	\N	\N	\N
310	2025-12-04 04:23:59.307791	2025-12-04 04:23:59.307791	Saturday	915	2200	44	\N	\N	\N	\N
311	2025-12-04 04:23:59.323437	2025-12-04 04:23:59.323437	Monday	600	1715	45	\N	\N	\N	\N
312	2025-12-04 04:23:59.32433	2025-12-04 04:23:59.32433	Tuesday	1430	130	45	\N	\N	\N	\N
313	2025-12-04 04:23:59.325138	2025-12-04 04:23:59.325138	Wednesday	2245	345	45	\N	\N	\N	\N
314	2025-12-04 04:23:59.325969	2025-12-04 04:23:59.325969	Thursday	600	2330	45	\N	\N	\N	\N
315	2025-12-04 04:23:59.326828	2025-12-04 04:23:59.326828	Friday	1915	400	45	\N	\N	\N	\N
316	2025-12-04 04:23:59.327626	2025-12-04 04:23:59.327626	Saturday	2130	115	45	\N	\N	\N	\N
317	2025-12-04 04:23:59.328369	2025-12-04 04:23:59.328369	Sunday	845	2215	45	\N	\N	\N	\N
318	2025-12-04 04:23:59.334812	2025-12-04 04:23:59.334812	Monday	1000	1730	46	\N	\N	\N	\N
319	2025-12-04 04:23:59.335614	2025-12-04 04:23:59.335614	Tuesday	645	1800	46	\N	\N	\N	\N
320	2025-12-04 04:23:59.336413	2025-12-04 04:23:59.336413	Wednesday	745	1815	46	\N	\N	\N	\N
321	2025-12-04 04:23:59.337189	2025-12-04 04:23:59.337189	Thursday	2130	130	46	\N	\N	\N	\N
322	2025-12-04 04:23:59.337929	2025-12-04 04:23:59.337929	Saturday	630	2145	46	\N	\N	\N	\N
323	2025-12-04 04:23:59.338711	2025-12-04 04:23:59.338711	Sunday	1630	345	46	\N	\N	\N	\N
324	2025-12-04 04:23:59.348267	2025-12-04 04:23:59.348267	Tuesday	745	1245	47	\N	\N	\N	\N
325	2025-12-04 04:23:59.349034	2025-12-04 04:23:59.349034	Tuesday	1445	330	47	\N	\N	\N	\N
326	2025-12-04 04:23:59.3498	2025-12-04 04:23:59.3498	Wednesday	615	2130	47	\N	\N	\N	\N
327	2025-12-04 04:23:59.350603	2025-12-04 04:23:59.350603	Thursday	745	830	47	\N	\N	\N	\N
328	2025-12-04 04:23:59.35135	2025-12-04 04:23:59.35135	Thursday	2045	430	47	\N	\N	\N	\N
329	2025-12-04 04:23:59.352097	2025-12-04 04:23:59.352097	Friday	700	2245	47	\N	\N	\N	\N
330	2025-12-04 04:23:59.352894	2025-12-04 04:23:59.352894	Saturday	115	300	47	\N	\N	\N	\N
331	2025-12-04 04:23:59.353822	2025-12-04 04:23:59.353822	Saturday	700	900	47	\N	\N	\N	\N
332	2025-12-04 04:23:59.3656	2025-12-04 04:23:59.3656	Monday	1730	300	48	\N	\N	\N	\N
333	2025-12-04 04:23:59.366422	2025-12-04 04:23:59.366422	Tuesday	745	1745	48	\N	\N	\N	\N
334	2025-12-04 04:23:59.367224	2025-12-04 04:23:59.367224	Wednesday	415	445	48	\N	\N	\N	\N
335	2025-12-04 04:23:59.368017	2025-12-04 04:23:59.368017	Wednesday	1000	1500	48	\N	\N	\N	\N
336	2025-12-04 04:23:59.368814	2025-12-04 04:23:59.368814	Thursday	2130	345	48	\N	\N	\N	\N
337	2025-12-04 04:23:59.36959	2025-12-04 04:23:59.36959	Friday	900	1530	48	\N	\N	\N	\N
338	2025-12-04 04:23:59.370383	2025-12-04 04:23:59.370383	Sunday	615	700	48	\N	\N	\N	\N
339	2025-12-04 04:23:59.371141	2025-12-04 04:23:59.371141	Sunday	1000	2030	48	\N	\N	\N	\N
340	2025-12-04 04:23:59.376863	2025-12-04 04:23:59.376863	Monday	845	2030	49	\N	\N	\N	\N
341	2025-12-04 04:23:59.377654	2025-12-04 04:23:59.377654	Tuesday	700	2130	49	\N	\N	\N	\N
342	2025-12-04 04:23:59.378463	2025-12-04 04:23:59.378463	Thursday	445	1030	49	\N	\N	\N	\N
343	2025-12-04 04:23:59.379219	2025-12-04 04:23:59.379219	Thursday	1315	2145	49	\N	\N	\N	\N
344	2025-12-04 04:23:59.379942	2025-12-04 04:23:59.379942	Friday	615	1400	49	\N	\N	\N	\N
345	2025-12-04 04:23:59.380736	2025-12-04 04:23:59.380736	Saturday	845	1600	49	\N	\N	\N	\N
346	2025-12-04 04:23:59.381522	2025-12-04 04:23:59.381522	Sunday	700	1445	49	\N	\N	\N	\N
347	2025-12-04 04:23:59.39091	2025-12-04 04:23:59.39091	Tuesday	1000	1730	50	\N	\N	\N	\N
348	2025-12-04 04:23:59.391742	2025-12-04 04:23:59.391742	Wednesday	800	1400	50	\N	\N	\N	\N
349	2025-12-04 04:23:59.392488	2025-12-04 04:23:59.392488	Thursday	615	2000	50	\N	\N	\N	\N
350	2025-12-04 04:23:59.393284	2025-12-04 04:23:59.393284	Friday	745	1500	50	\N	\N	\N	\N
351	2025-12-04 04:23:59.394014	2025-12-04 04:23:59.394014	Saturday	900	1800	50	\N	\N	\N	\N
352	2025-12-04 04:23:59.394793	2025-12-04 04:23:59.394793	Sunday	645	2100	50	\N	\N	\N	\N
353	2025-12-04 04:23:59.405972	2025-12-04 04:23:59.405972	Monday	715	1530	51	\N	\N	\N	\N
354	2025-12-04 04:23:59.406797	2025-12-04 04:23:59.406797	Wednesday	1745	215	51	\N	\N	\N	\N
355	2025-12-04 04:23:59.407561	2025-12-04 04:23:59.407561	Thursday	1000	1845	51	\N	\N	\N	\N
356	2025-12-04 04:23:59.408301	2025-12-04 04:23:59.408301	Friday	815	2400	51	\N	\N	\N	\N
357	2025-12-04 04:23:59.409105	2025-12-04 04:23:59.409105	Saturday	430	715	51	\N	\N	\N	\N
358	2025-12-04 04:23:59.409871	2025-12-04 04:23:59.409871	Saturday	1300	1500	51	\N	\N	\N	\N
359	2025-12-04 04:23:59.410857	2025-12-04 04:23:59.410857	Sunday	630	2000	51	\N	\N	\N	\N
360	2025-12-04 04:23:59.41627	2025-12-04 04:23:59.41627	Monday	615	2000	52	\N	\N	\N	\N
361	2025-12-04 04:23:59.417042	2025-12-04 04:23:59.417042	Monday	2030	315	52	\N	\N	\N	\N
362	2025-12-04 04:23:59.417842	2025-12-04 04:23:59.417842	Tuesday	900	1400	52	\N	\N	\N	\N
363	2025-12-04 04:23:59.418612	2025-12-04 04:23:59.418612	Tuesday	1445	2245	52	\N	\N	\N	\N
364	2025-12-04 04:23:59.419387	2025-12-04 04:23:59.419387	Wednesday	915	1645	52	\N	\N	\N	\N
365	2025-12-04 04:23:59.420154	2025-12-04 04:23:59.420154	Friday	615	1945	52	\N	\N	\N	\N
366	2025-12-04 04:23:59.420935	2025-12-04 04:23:59.420935	Saturday	1000	1415	52	\N	\N	\N	\N
367	2025-12-04 04:23:59.421706	2025-12-04 04:23:59.421706	Sunday	730	1600	52	\N	\N	\N	\N
368	2025-12-04 04:23:59.433904	2025-12-04 04:23:59.433904	Tuesday	930	2345	53	\N	\N	\N	\N
369	2025-12-04 04:23:59.434767	2025-12-04 04:23:59.434767	Wednesday	1415	1645	53	\N	\N	\N	\N
370	2025-12-04 04:23:59.435537	2025-12-04 04:23:59.435537	Wednesday	1745	1815	53	\N	\N	\N	\N
371	2025-12-04 04:23:59.436342	2025-12-04 04:23:59.436342	Thursday	1715	115	53	\N	\N	\N	\N
372	2025-12-04 04:23:59.437123	2025-12-04 04:23:59.437123	Friday	1100	1715	53	\N	\N	\N	\N
373	2025-12-04 04:23:59.437845	2025-12-04 04:23:59.437845	Friday	1745	0	53	\N	\N	\N	\N
374	2025-12-04 04:23:59.438716	2025-12-04 04:23:59.438716	Saturday	215	330	53	\N	\N	\N	\N
375	2025-12-04 04:23:59.439456	2025-12-04 04:23:59.439456	Saturday	415	2230	53	\N	\N	\N	\N
376	2025-12-04 04:23:59.440246	2025-12-04 04:23:59.440246	Sunday	400	445	53	\N	\N	\N	\N
377	2025-12-04 04:23:59.441014	2025-12-04 04:23:59.441014	Sunday	1530	1800	53	\N	\N	\N	\N
378	2025-12-04 04:23:59.44681	2025-12-04 04:23:59.44681	Monday	845	1745	54	\N	\N	\N	\N
379	2025-12-04 04:23:59.447578	2025-12-04 04:23:59.447578	Tuesday	800	1530	54	\N	\N	\N	\N
380	2025-12-04 04:23:59.448366	2025-12-04 04:23:59.448366	Wednesday	700	1715	54	\N	\N	\N	\N
381	2025-12-04 04:23:59.449124	2025-12-04 04:23:59.449124	Thursday	2115	300	54	\N	\N	\N	\N
382	2025-12-04 04:23:59.449913	2025-12-04 04:23:59.449913	Friday	945	1800	54	\N	\N	\N	\N
383	2025-12-04 04:23:59.45068	2025-12-04 04:23:59.45068	Sunday	2300	230	54	\N	\N	\N	\N
384	2025-12-04 04:23:59.461817	2025-12-04 04:23:59.461817	Monday	2015	100	55	\N	\N	\N	\N
385	2025-12-04 04:23:59.462634	2025-12-04 04:23:59.462634	Tuesday	815	1130	55	\N	\N	\N	\N
386	2025-12-04 04:23:59.463363	2025-12-04 04:23:59.463363	Tuesday	2100	2130	55	\N	\N	\N	\N
387	2025-12-04 04:23:59.464188	2025-12-04 04:23:59.464188	Wednesday	300	1030	55	\N	\N	\N	\N
388	2025-12-04 04:23:59.464927	2025-12-04 04:23:59.464927	Wednesday	1930	2230	55	\N	\N	\N	\N
389	2025-12-04 04:23:59.465679	2025-12-04 04:23:59.465679	Thursday	2200	245	55	\N	\N	\N	\N
390	2025-12-04 04:23:59.466459	2025-12-04 04:23:59.466459	Friday	1930	100	55	\N	\N	\N	\N
391	2025-12-04 04:23:59.467248	2025-12-04 04:23:59.467248	Saturday	830	1730	55	\N	\N	\N	\N
392	2025-12-04 04:23:59.467994	2025-12-04 04:23:59.467994	Sunday	900	2245	55	\N	\N	\N	\N
393	2025-12-04 04:23:59.473625	2025-12-04 04:23:59.473625	Monday	2245	100	56	\N	\N	\N	\N
394	2025-12-04 04:23:59.474544	2025-12-04 04:23:59.474544	Tuesday	1000	2400	56	\N	\N	\N	\N
395	2025-12-04 04:23:59.475553	2025-12-04 04:23:59.475553	Wednesday	830	2130	56	\N	\N	\N	\N
396	2025-12-04 04:23:59.476416	2025-12-04 04:23:59.476416	Thursday	800	2345	56	\N	\N	\N	\N
397	2025-12-04 04:23:59.477371	2025-12-04 04:23:59.477371	Friday	130	930	56	\N	\N	\N	\N
398	2025-12-04 04:23:59.478234	2025-12-04 04:23:59.478234	Friday	1515	1600	56	\N	\N	\N	\N
399	2025-12-04 04:23:59.479151	2025-12-04 04:23:59.479151	Sunday	115	445	56	\N	\N	\N	\N
400	2025-12-04 04:23:59.480084	2025-12-04 04:23:59.480084	Sunday	800	1100	56	\N	\N	\N	\N
401	2025-12-04 04:23:59.492628	2025-12-04 04:23:59.492628	Monday	1000	2115	57	\N	\N	\N	\N
402	2025-12-04 04:23:59.493483	2025-12-04 04:23:59.493483	Tuesday	845	1715	57	\N	\N	\N	\N
403	2025-12-04 04:23:59.494488	2025-12-04 04:23:59.494488	Thursday	845	1445	57	\N	\N	\N	\N
404	2025-12-04 04:23:59.495279	2025-12-04 04:23:59.495279	Friday	1500	1830	57	\N	\N	\N	\N
405	2025-12-04 04:23:59.496048	2025-12-04 04:23:59.496048	Friday	2245	2330	57	\N	\N	\N	\N
406	2025-12-04 04:23:59.496831	2025-12-04 04:23:59.496831	Saturday	1445	1645	57	\N	\N	\N	\N
407	2025-12-04 04:23:59.497587	2025-12-04 04:23:59.497587	Saturday	1830	2245	57	\N	\N	\N	\N
408	2025-12-04 04:23:59.498393	2025-12-04 04:23:59.498393	Sunday	1845	1915	57	\N	\N	\N	\N
409	2025-12-04 04:23:59.499216	2025-12-04 04:23:59.499216	Sunday	1945	2015	57	\N	\N	\N	\N
410	2025-12-04 04:23:59.505224	2025-12-04 04:23:59.505224	Monday	1245	1345	58	\N	\N	\N	\N
411	2025-12-04 04:23:59.505994	2025-12-04 04:23:59.505994	Monday	1645	2300	58	\N	\N	\N	\N
412	2025-12-04 04:23:59.506737	2025-12-04 04:23:59.506737	Tuesday	800	1545	58	\N	\N	\N	\N
413	2025-12-04 04:23:59.507509	2025-12-04 04:23:59.507509	Wednesday	630	1800	58	\N	\N	\N	\N
414	2025-12-04 04:23:59.508248	2025-12-04 04:23:59.508248	Thursday	1615	130	58	\N	\N	\N	\N
415	2025-12-04 04:23:59.509019	2025-12-04 04:23:59.509019	Friday	745	1700	58	\N	\N	\N	\N
416	2025-12-04 04:23:59.509784	2025-12-04 04:23:59.509784	Saturday	2115	145	58	\N	\N	\N	\N
417	2025-12-04 04:23:59.510562	2025-12-04 04:23:59.510562	Sunday	45	515	58	\N	\N	\N	\N
418	2025-12-04 04:23:59.511289	2025-12-04 04:23:59.511289	Sunday	1115	1715	58	\N	\N	\N	\N
419	2025-12-04 04:23:59.522798	2025-12-04 04:23:59.522798	Monday	815	1845	59	\N	\N	\N	\N
420	2025-12-04 04:23:59.52359	2025-12-04 04:23:59.52359	Tuesday	630	2015	59	\N	\N	\N	\N
421	2025-12-04 04:23:59.524348	2025-12-04 04:23:59.524348	Thursday	600	1815	59	\N	\N	\N	\N
422	2025-12-04 04:23:59.525137	2025-12-04 04:23:59.525137	Friday	600	830	59	\N	\N	\N	\N
423	2025-12-04 04:23:59.525926	2025-12-04 04:23:59.525926	Friday	1115	1915	59	\N	\N	\N	\N
424	2025-12-04 04:23:59.526754	2025-12-04 04:23:59.526754	Sunday	1045	1330	59	\N	\N	\N	\N
425	2025-12-04 04:23:59.527509	2025-12-04 04:23:59.527509	Sunday	1830	2100	59	\N	\N	\N	\N
426	2025-12-04 04:23:59.533706	2025-12-04 04:23:59.533706	Monday	1900	145	60	\N	\N	\N	\N
427	2025-12-04 04:23:59.534485	2025-12-04 04:23:59.534485	Tuesday	645	1900	60	\N	\N	\N	\N
428	2025-12-04 04:23:59.535309	2025-12-04 04:23:59.535309	Wednesday	715	1930	60	\N	\N	\N	\N
429	2025-12-04 04:23:59.536141	2025-12-04 04:23:59.536141	Thursday	1030	1300	60	\N	\N	\N	\N
430	2025-12-04 04:23:59.536872	2025-12-04 04:23:59.536872	Thursday	1545	2015	60	\N	\N	\N	\N
431	2025-12-04 04:23:59.537642	2025-12-04 04:23:59.537642	Friday	900	2215	60	\N	\N	\N	\N
432	2025-12-04 04:23:59.538424	2025-12-04 04:23:59.538424	Saturday	945	1900	60	\N	\N	\N	\N
433	2025-12-04 04:23:59.539265	2025-12-04 04:23:59.539265	Sunday	830	2215	60	\N	\N	\N	\N
434	2025-12-04 04:23:59.550964	2025-12-04 04:23:59.550964	Monday	0	200	61	\N	\N	\N	\N
435	2025-12-04 04:23:59.551742	2025-12-04 04:23:59.551742	Monday	500	830	61	\N	\N	\N	\N
436	2025-12-04 04:23:59.552517	2025-12-04 04:23:59.552517	Thursday	815	1700	61	\N	\N	\N	\N
437	2025-12-04 04:23:59.553317	2025-12-04 04:23:59.553317	Sunday	100	415	61	\N	\N	\N	\N
438	2025-12-04 04:23:59.554037	2025-12-04 04:23:59.554037	Sunday	515	1545	61	\N	\N	\N	\N
439	2025-12-04 04:23:59.559921	2025-12-04 04:23:59.559921	Monday	615	1200	62	\N	\N	\N	\N
440	2025-12-04 04:23:59.560655	2025-12-04 04:23:59.560655	Monday	1415	2030	62	\N	\N	\N	\N
441	2025-12-04 04:23:59.561454	2025-12-04 04:23:59.561454	Tuesday	300	515	62	\N	\N	\N	\N
442	2025-12-04 04:23:59.562217	2025-12-04 04:23:59.562217	Tuesday	1045	1715	62	\N	\N	\N	\N
443	2025-12-04 04:23:59.562963	2025-12-04 04:23:59.562963	Wednesday	1715	400	62	\N	\N	\N	\N
444	2025-12-04 04:23:59.563762	2025-12-04 04:23:59.563762	Thursday	945	1615	62	\N	\N	\N	\N
445	2025-12-04 04:23:59.564528	2025-12-04 04:23:59.564528	Friday	115	245	62	\N	\N	\N	\N
446	2025-12-04 04:23:59.56524	2025-12-04 04:23:59.56524	Friday	445	900	62	\N	\N	\N	\N
447	2025-12-04 04:23:59.566042	2025-12-04 04:23:59.566042	Saturday	800	1030	62	\N	\N	\N	\N
448	2025-12-04 04:23:59.566806	2025-12-04 04:23:59.566806	Saturday	1300	1545	62	\N	\N	\N	\N
449	2025-12-04 04:23:59.567541	2025-12-04 04:23:59.567541	Sunday	600	2330	62	\N	\N	\N	\N
450	2025-12-04 04:23:59.578472	2025-12-04 04:23:59.578472	Wednesday	700	1945	63	\N	\N	\N	\N
451	2025-12-04 04:23:59.579252	2025-12-04 04:23:59.579252	Thursday	1000	2030	63	\N	\N	\N	\N
452	2025-12-04 04:23:59.580047	2025-12-04 04:23:59.580047	Friday	45	1030	63	\N	\N	\N	\N
453	2025-12-04 04:23:59.580791	2025-12-04 04:23:59.580791	Friday	2100	2400	63	\N	\N	\N	\N
454	2025-12-04 04:23:59.585874	2025-12-04 04:23:59.585874	Tuesday	630	1730	64	\N	\N	\N	\N
455	2025-12-04 04:23:59.586676	2025-12-04 04:23:59.586676	Wednesday	630	2130	64	\N	\N	\N	\N
456	2025-12-04 04:23:59.587486	2025-12-04 04:23:59.587486	Thursday	115	415	64	\N	\N	\N	\N
457	2025-12-04 04:23:59.588221	2025-12-04 04:23:59.588221	Thursday	1000	2000	64	\N	\N	\N	\N
458	2025-12-04 04:23:59.588965	2025-12-04 04:23:59.588965	Friday	930	2015	64	\N	\N	\N	\N
459	2025-12-04 04:23:59.589735	2025-12-04 04:23:59.589735	Saturday	845	1545	64	\N	\N	\N	\N
460	2025-12-04 04:23:59.590485	2025-12-04 04:23:59.590485	Sunday	730	1430	64	\N	\N	\N	\N
461	2025-12-04 04:23:59.599258	2025-12-04 04:23:59.599258	Tuesday	815	2045	65	\N	\N	\N	\N
462	2025-12-04 04:23:59.600044	2025-12-04 04:23:59.600044	Wednesday	645	2030	65	\N	\N	\N	\N
463	2025-12-04 04:23:59.600973	2025-12-04 04:23:59.600973	Thursday	645	800	65	\N	\N	\N	\N
464	2025-12-04 04:23:59.601719	2025-12-04 04:23:59.601719	Thursday	1115	1200	65	\N	\N	\N	\N
465	2025-12-04 04:23:59.602503	2025-12-04 04:23:59.602503	Saturday	415	800	65	\N	\N	\N	\N
466	2025-12-04 04:23:59.603262	2025-12-04 04:23:59.603262	Saturday	1845	1930	65	\N	\N	\N	\N
467	2025-12-04 04:23:59.604067	2025-12-04 04:23:59.604067	Sunday	900	1930	65	\N	\N	\N	\N
468	2025-12-04 04:23:59.615938	2025-12-04 04:23:59.615938	Monday	30	600	66	\N	\N	\N	\N
469	2025-12-04 04:23:59.616697	2025-12-04 04:23:59.616697	Monday	1900	2230	66	\N	\N	\N	\N
470	2025-12-04 04:23:59.61756	2025-12-04 04:23:59.61756	Tuesday	1315	1330	66	\N	\N	\N	\N
471	2025-12-04 04:23:59.618314	2025-12-04 04:23:59.618314	Tuesday	1715	915	66	\N	\N	\N	\N
472	2025-12-04 04:23:59.619106	2025-12-04 04:23:59.619106	Friday	745	1715	66	\N	\N	\N	\N
473	2025-12-04 04:23:59.619937	2025-12-04 04:23:59.619937	Saturday	730	2230	66	\N	\N	\N	\N
474	2025-12-04 04:23:59.62586	2025-12-04 04:23:59.62586	Monday	915	1515	67	\N	\N	\N	\N
475	2025-12-04 04:23:59.626648	2025-12-04 04:23:59.626648	Tuesday	1500	1815	67	\N	\N	\N	\N
476	2025-12-04 04:23:59.629914	2025-12-04 04:23:59.629914	Tuesday	2100	230	67	\N	\N	\N	\N
477	2025-12-04 04:23:59.63081	2025-12-04 04:23:59.63081	Wednesday	1845	215	67	\N	\N	\N	\N
478	2025-12-04 04:23:59.631593	2025-12-04 04:23:59.631593	Friday	745	1645	67	\N	\N	\N	\N
479	2025-12-04 04:23:59.632393	2025-12-04 04:23:59.632393	Saturday	900	2015	67	\N	\N	\N	\N
480	2025-12-04 04:23:59.633212	2025-12-04 04:23:59.633212	Sunday	915	2345	67	\N	\N	\N	\N
481	2025-12-04 04:23:59.642224	2025-12-04 04:23:59.642224	Tuesday	915	2000	68	\N	\N	\N	\N
482	2025-12-04 04:23:59.642987	2025-12-04 04:23:59.642987	Thursday	600	2345	68	\N	\N	\N	\N
483	2025-12-04 04:23:59.643765	2025-12-04 04:23:59.643765	Friday	815	1830	68	\N	\N	\N	\N
484	2025-12-04 04:23:59.644512	2025-12-04 04:23:59.644512	Saturday	615	1915	68	\N	\N	\N	\N
485	2025-12-04 04:23:59.645235	2025-12-04 04:23:59.645235	Sunday	615	2330	68	\N	\N	\N	\N
486	2025-12-04 04:23:59.656809	2025-12-04 04:23:59.656809	Monday	700	1815	69	\N	\N	\N	\N
487	2025-12-04 04:23:59.657576	2025-12-04 04:23:59.657576	Tuesday	830	2045	69	\N	\N	\N	\N
488	2025-12-04 04:23:59.65831	2025-12-04 04:23:59.65831	Wednesday	930	1545	69	\N	\N	\N	\N
489	2025-12-04 04:23:59.659087	2025-12-04 04:23:59.659087	Thursday	730	2345	69	\N	\N	\N	\N
490	2025-12-04 04:23:59.659854	2025-12-04 04:23:59.659854	Friday	845	2330	69	\N	\N	\N	\N
491	2025-12-04 04:23:59.660655	2025-12-04 04:23:59.660655	Saturday	945	2130	69	\N	\N	\N	\N
492	2025-12-04 04:23:59.661463	2025-12-04 04:23:59.661463	Sunday	715	2115	69	\N	\N	\N	\N
493	2025-12-04 04:23:59.66757	2025-12-04 04:23:59.66757	Monday	730	2200	70	\N	\N	\N	\N
494	2025-12-04 04:23:59.668448	2025-12-04 04:23:59.668448	Wednesday	715	1445	70	\N	\N	\N	\N
495	2025-12-04 04:23:59.669197	2025-12-04 04:23:59.669197	Thursday	930	2030	70	\N	\N	\N	\N
496	2025-12-04 04:23:59.66995	2025-12-04 04:23:59.66995	Friday	645	1930	70	\N	\N	\N	\N
497	2025-12-04 04:23:59.670715	2025-12-04 04:23:59.670715	Saturday	945	1715	70	\N	\N	\N	\N
498	2025-12-04 04:23:59.671478	2025-12-04 04:23:59.671478	Sunday	45	400	70	\N	\N	\N	\N
499	2025-12-04 04:23:59.672218	2025-12-04 04:23:59.672218	Sunday	1500	1630	70	\N	\N	\N	\N
500	2025-12-04 04:23:59.68441	2025-12-04 04:23:59.68441	Tuesday	615	1915	71	\N	\N	\N	\N
501	2025-12-04 04:23:59.685263	2025-12-04 04:23:59.685263	Wednesday	1000	1745	71	\N	\N	\N	\N
502	2025-12-04 04:23:59.686042	2025-12-04 04:23:59.686042	Thursday	830	1600	71	\N	\N	\N	\N
503	2025-12-04 04:23:59.686833	2025-12-04 04:23:59.686833	Friday	2115	400	71	\N	\N	\N	\N
504	2025-12-04 04:23:59.687584	2025-12-04 04:23:59.687584	Saturday	1000	2145	71	\N	\N	\N	\N
505	2025-12-04 04:23:59.688334	2025-12-04 04:23:59.688334	Sunday	2115	245	71	\N	\N	\N	\N
506	2025-12-04 04:23:59.694502	2025-12-04 04:23:59.694502	Monday	800	1815	72	\N	\N	\N	\N
507	2025-12-04 04:23:59.695364	2025-12-04 04:23:59.695364	Wednesday	930	1100	72	\N	\N	\N	\N
508	2025-12-04 04:23:59.696069	2025-12-04 04:23:59.696069	Wednesday	1930	2130	72	\N	\N	\N	\N
509	2025-12-04 04:23:59.696859	2025-12-04 04:23:59.696859	Thursday	1000	1645	72	\N	\N	\N	\N
510	2025-12-04 04:23:59.697646	2025-12-04 04:23:59.697646	Friday	1030	1215	72	\N	\N	\N	\N
511	2025-12-04 04:23:59.698591	2025-12-04 04:23:59.698591	Friday	2300	830	72	\N	\N	\N	\N
512	2025-12-04 04:23:59.69937	2025-12-04 04:23:59.69937	Saturday	830	1900	72	\N	\N	\N	\N
513	2025-12-04 04:23:59.700271	2025-12-04 04:23:59.700271	Sunday	830	1900	72	\N	\N	\N	\N
514	2025-12-04 04:23:59.710014	2025-12-04 04:23:59.710014	Monday	800	1800	73	\N	\N	\N	\N
515	2025-12-04 04:23:59.710816	2025-12-04 04:23:59.710816	Thursday	645	1715	73	\N	\N	\N	\N
516	2025-12-04 04:23:59.711571	2025-12-04 04:23:59.711571	Friday	1800	115	73	\N	\N	\N	\N
517	2025-12-04 04:23:59.712366	2025-12-04 04:23:59.712366	Sunday	715	1930	73	\N	\N	\N	\N
518	2025-12-04 04:23:59.724165	2025-12-04 04:23:59.724165	Monday	700	1945	74	\N	\N	\N	\N
519	2025-12-04 04:23:59.72494	2025-12-04 04:23:59.72494	Wednesday	700	1700	74	\N	\N	\N	\N
520	2025-12-04 04:23:59.725777	2025-12-04 04:23:59.725777	Thursday	1400	1815	74	\N	\N	\N	\N
521	2025-12-04 04:23:59.72648	2025-12-04 04:23:59.72648	Thursday	2115	2145	74	\N	\N	\N	\N
522	2025-12-04 04:23:59.727272	2025-12-04 04:23:59.727272	Saturday	815	2100	74	\N	\N	\N	\N
523	2025-12-04 04:23:59.728015	2025-12-04 04:23:59.728015	Sunday	715	1845	74	\N	\N	\N	\N
524	2025-12-04 04:23:59.733989	2025-12-04 04:23:59.733989	Monday	900	1600	75	\N	\N	\N	\N
525	2025-12-04 04:23:59.734785	2025-12-04 04:23:59.734785	Tuesday	645	1545	75	\N	\N	\N	\N
526	2025-12-04 04:23:59.735513	2025-12-04 04:23:59.735513	Wednesday	615	2330	75	\N	\N	\N	\N
527	2025-12-04 04:23:59.736261	2025-12-04 04:23:59.736261	Thursday	630	1515	75	\N	\N	\N	\N
528	2025-12-04 04:23:59.737019	2025-12-04 04:23:59.737019	Friday	645	2145	75	\N	\N	\N	\N
529	2025-12-04 04:23:59.737775	2025-12-04 04:23:59.737775	Sunday	1545	330	75	\N	\N	\N	\N
530	2025-12-04 04:23:59.746865	2025-12-04 04:23:59.746865	Tuesday	2130	145	76	\N	\N	\N	\N
531	2025-12-04 04:23:59.747652	2025-12-04 04:23:59.747652	Friday	1400	345	76	\N	\N	\N	\N
532	2025-12-04 04:23:59.748434	2025-12-04 04:23:59.748434	Saturday	830	1445	76	\N	\N	\N	\N
533	2025-12-04 04:23:59.760045	2025-12-04 04:23:59.760045	Monday	930	2100	77	\N	\N	\N	\N
534	2025-12-04 04:23:59.76088	2025-12-04 04:23:59.76088	Tuesday	945	2215	77	\N	\N	\N	\N
535	2025-12-04 04:23:59.761661	2025-12-04 04:23:59.761661	Wednesday	745	1145	77	\N	\N	\N	\N
536	2025-12-04 04:23:59.762408	2025-12-04 04:23:59.762408	Wednesday	1330	2230	77	\N	\N	\N	\N
537	2025-12-04 04:23:59.763148	2025-12-04 04:23:59.763148	Thursday	1000	1845	77	\N	\N	\N	\N
538	2025-12-04 04:23:59.763884	2025-12-04 04:23:59.763884	Friday	700	1800	77	\N	\N	\N	\N
539	2025-12-04 04:23:59.764677	2025-12-04 04:23:59.764677	Saturday	645	2215	77	\N	\N	\N	\N
540	2025-12-04 04:23:59.765438	2025-12-04 04:23:59.765438	Sunday	645	1800	77	\N	\N	\N	\N
541	2025-12-04 04:23:59.771372	2025-12-04 04:23:59.771372	Monday	1400	400	78	\N	\N	\N	\N
542	2025-12-04 04:23:59.772174	2025-12-04 04:23:59.772174	Wednesday	800	815	78	\N	\N	\N	\N
543	2025-12-04 04:23:59.772941	2025-12-04 04:23:59.772941	Wednesday	1545	2200	78	\N	\N	\N	\N
544	2025-12-04 04:23:59.773762	2025-12-04 04:23:59.773762	Thursday	130	430	78	\N	\N	\N	\N
545	2025-12-04 04:23:59.774507	2025-12-04 04:23:59.774507	Thursday	1200	1630	78	\N	\N	\N	\N
546	2025-12-04 04:23:59.775262	2025-12-04 04:23:59.775262	Saturday	600	2115	78	\N	\N	\N	\N
547	2025-12-04 04:23:59.776039	2025-12-04 04:23:59.776039	Sunday	445	1700	78	\N	\N	\N	\N
548	2025-12-04 04:23:59.776788	2025-12-04 04:23:59.776788	Sunday	2200	2215	78	\N	\N	\N	\N
549	2025-12-04 04:23:59.785849	2025-12-04 04:23:59.785849	Monday	1000	2015	79	\N	\N	\N	\N
550	2025-12-04 04:23:59.786622	2025-12-04 04:23:59.786622	Tuesday	800	1800	79	\N	\N	\N	\N
551	2025-12-04 04:23:59.787382	2025-12-04 04:23:59.787382	Wednesday	915	2400	79	\N	\N	\N	\N
552	2025-12-04 04:23:59.788134	2025-12-04 04:23:59.788134	Friday	700	1900	79	\N	\N	\N	\N
553	2025-12-04 04:23:59.800126	2025-12-04 04:23:59.800126	Monday	715	1700	80	\N	\N	\N	\N
554	2025-12-04 04:23:59.800915	2025-12-04 04:23:59.800915	Wednesday	730	1445	80	\N	\N	\N	\N
555	2025-12-04 04:23:59.801773	2025-12-04 04:23:59.801773	Friday	930	1715	80	\N	\N	\N	\N
556	2025-12-04 04:23:59.802516	2025-12-04 04:23:59.802516	Saturday	830	1800	80	\N	\N	\N	\N
557	2025-12-04 04:23:59.803338	2025-12-04 04:23:59.803338	Sunday	130	1245	80	\N	\N	\N	\N
558	2025-12-04 04:23:59.804057	2025-12-04 04:23:59.804057	Sunday	1700	1830	80	\N	\N	\N	\N
559	2025-12-04 04:23:59.809854	2025-12-04 04:23:59.809854	Monday	645	1430	81	\N	\N	\N	\N
560	2025-12-04 04:23:59.810691	2025-12-04 04:23:59.810691	Tuesday	730	2215	81	\N	\N	\N	\N
561	2025-12-04 04:23:59.811451	2025-12-04 04:23:59.811451	Thursday	630	2015	81	\N	\N	\N	\N
562	2025-12-04 04:23:59.812236	2025-12-04 04:23:59.812236	Friday	630	2315	81	\N	\N	\N	\N
563	2025-12-04 04:23:59.813021	2025-12-04 04:23:59.813021	Saturday	1015	1030	81	\N	\N	\N	\N
564	2025-12-04 04:23:59.813753	2025-12-04 04:23:59.813753	Saturday	1700	1730	81	\N	\N	\N	\N
565	2025-12-04 04:23:59.814511	2025-12-04 04:23:59.814511	Sunday	800	1645	81	\N	\N	\N	\N
566	2025-12-04 04:23:59.825944	2025-12-04 04:23:59.825944	Monday	15	1500	82	\N	\N	\N	\N
567	2025-12-04 04:23:59.826699	2025-12-04 04:23:59.826699	Monday	2315	2330	82	\N	\N	\N	\N
568	2025-12-04 04:23:59.827435	2025-12-04 04:23:59.827435	Tuesday	630	2130	82	\N	\N	\N	\N
569	2025-12-04 04:23:59.828222	2025-12-04 04:23:59.828222	Wednesday	100	115	82	\N	\N	\N	\N
570	2025-12-04 04:23:59.828938	2025-12-04 04:23:59.828938	Wednesday	145	2030	82	\N	\N	\N	\N
571	2025-12-04 04:23:59.829672	2025-12-04 04:23:59.829672	Thursday	800	2115	82	\N	\N	\N	\N
572	2025-12-04 04:23:59.830438	2025-12-04 04:23:59.830438	Friday	730	1830	82	\N	\N	\N	\N
573	2025-12-04 04:23:59.831216	2025-12-04 04:23:59.831216	Sunday	415	1300	82	\N	\N	\N	\N
574	2025-12-04 04:23:59.832014	2025-12-04 04:23:59.832014	Sunday	1600	1745	82	\N	\N	\N	\N
575	2025-12-04 04:23:59.838025	2025-12-04 04:23:59.838025	Monday	215	330	83	\N	\N	\N	\N
576	2025-12-04 04:23:59.83879	2025-12-04 04:23:59.83879	Monday	1530	1815	83	\N	\N	\N	\N
577	2025-12-04 04:23:59.839584	2025-12-04 04:23:59.839584	Wednesday	1845	400	83	\N	\N	\N	\N
578	2025-12-04 04:23:59.840395	2025-12-04 04:23:59.840395	Thursday	915	1515	83	\N	\N	\N	\N
579	2025-12-04 04:23:59.841174	2025-12-04 04:23:59.841174	Saturday	1015	1330	83	\N	\N	\N	\N
580	2025-12-04 04:23:59.841884	2025-12-04 04:23:59.841884	Saturday	1445	2215	83	\N	\N	\N	\N
581	2025-12-04 04:23:59.842666	2025-12-04 04:23:59.842666	Sunday	445	600	83	\N	\N	\N	\N
582	2025-12-04 04:23:59.843382	2025-12-04 04:23:59.843382	Sunday	730	1915	83	\N	\N	\N	\N
583	2025-12-04 04:23:59.854762	2025-12-04 04:23:59.854762	Monday	630	1915	84	\N	\N	\N	\N
584	2025-12-04 04:23:59.855518	2025-12-04 04:23:59.855518	Tuesday	630	2345	84	\N	\N	\N	\N
585	2025-12-04 04:23:59.856322	2025-12-04 04:23:59.856322	Wednesday	0	300	84	\N	\N	\N	\N
586	2025-12-04 04:23:59.857064	2025-12-04 04:23:59.857064	Wednesday	1430	1930	84	\N	\N	\N	\N
587	2025-12-04 04:23:59.857842	2025-12-04 04:23:59.857842	Thursday	315	745	84	\N	\N	\N	\N
588	2025-12-04 04:23:59.858554	2025-12-04 04:23:59.858554	Thursday	1630	2315	84	\N	\N	\N	\N
589	2025-12-04 04:23:59.859415	2025-12-04 04:23:59.859415	Saturday	800	1745	84	\N	\N	\N	\N
590	2025-12-04 04:23:59.860247	2025-12-04 04:23:59.860247	Sunday	1400	200	84	\N	\N	\N	\N
591	2025-12-04 04:23:59.865905	2025-12-04 04:23:59.865905	Tuesday	200	930	85	\N	\N	\N	\N
592	2025-12-04 04:23:59.866636	2025-12-04 04:23:59.866636	Tuesday	2000	2030	85	\N	\N	\N	\N
593	2025-12-04 04:23:59.867427	2025-12-04 04:23:59.867427	Wednesday	745	2345	85	\N	\N	\N	\N
594	2025-12-04 04:23:59.868384	2025-12-04 04:23:59.868384	Thursday	30	200	85	\N	\N	\N	\N
595	2025-12-04 04:23:59.869117	2025-12-04 04:23:59.869117	Thursday	300	2100	85	\N	\N	\N	\N
596	2025-12-04 04:23:59.869877	2025-12-04 04:23:59.869877	Friday	600	2230	85	\N	\N	\N	\N
597	2025-12-04 04:23:59.870624	2025-12-04 04:23:59.870624	Saturday	1715	230	85	\N	\N	\N	\N
598	2025-12-04 04:23:59.871491	2025-12-04 04:23:59.871491	Sunday	230	530	85	\N	\N	\N	\N
599	2025-12-04 04:23:59.872203	2025-12-04 04:23:59.872203	Sunday	1915	100	85	\N	\N	\N	\N
600	2025-12-04 04:23:59.88355	2025-12-04 04:23:59.88355	Tuesday	800	1630	86	\N	\N	\N	\N
601	2025-12-04 04:23:59.88436	2025-12-04 04:23:59.88436	Wednesday	745	1415	86	\N	\N	\N	\N
602	2025-12-04 04:23:59.885166	2025-12-04 04:23:59.885166	Thursday	245	1430	86	\N	\N	\N	\N
603	2025-12-04 04:23:59.885928	2025-12-04 04:23:59.885928	Thursday	1645	0	86	\N	\N	\N	\N
604	2025-12-04 04:23:59.886678	2025-12-04 04:23:59.886678	Friday	600	1415	86	\N	\N	\N	\N
605	2025-12-04 04:23:59.887471	2025-12-04 04:23:59.887471	Saturday	945	2000	86	\N	\N	\N	\N
606	2025-12-04 04:23:59.888227	2025-12-04 04:23:59.888227	Sunday	615	1945	86	\N	\N	\N	\N
607	2025-12-04 04:23:59.893917	2025-12-04 04:23:59.893917	Monday	600	1800	87	\N	\N	\N	\N
608	2025-12-04 04:23:59.894784	2025-12-04 04:23:59.894784	Tuesday	345	645	87	\N	\N	\N	\N
609	2025-12-04 04:23:59.895627	2025-12-04 04:23:59.895627	Tuesday	930	1030	87	\N	\N	\N	\N
610	2025-12-04 04:23:59.896416	2025-12-04 04:23:59.896416	Wednesday	730	2245	87	\N	\N	\N	\N
611	2025-12-04 04:23:59.897236	2025-12-04 04:23:59.897236	Thursday	1000	1545	87	\N	\N	\N	\N
612	2025-12-04 04:23:59.897976	2025-12-04 04:23:59.897976	Thursday	1630	2300	87	\N	\N	\N	\N
613	2025-12-04 04:23:59.898787	2025-12-04 04:23:59.898787	Friday	815	1430	87	\N	\N	\N	\N
614	2025-12-04 04:23:59.899574	2025-12-04 04:23:59.899574	Saturday	1800	1830	87	\N	\N	\N	\N
615	2025-12-04 04:23:59.900334	2025-12-04 04:23:59.900334	Saturday	2245	1245	87	\N	\N	\N	\N
616	2025-12-04 04:23:59.901136	2025-12-04 04:23:59.901136	Sunday	345	1130	87	\N	\N	\N	\N
617	2025-12-04 04:23:59.902116	2025-12-04 04:23:59.902116	Sunday	1330	1845	87	\N	\N	\N	\N
618	2025-12-04 04:23:59.913831	2025-12-04 04:23:59.913831	Monday	600	1515	88	\N	\N	\N	\N
619	2025-12-04 04:23:59.914605	2025-12-04 04:23:59.914605	Wednesday	845	1915	88	\N	\N	\N	\N
620	2025-12-04 04:23:59.915372	2025-12-04 04:23:59.915372	Thursday	900	2300	88	\N	\N	\N	\N
621	2025-12-04 04:23:59.916172	2025-12-04 04:23:59.916172	Friday	600	1700	88	\N	\N	\N	\N
622	2025-12-04 04:23:59.91694	2025-12-04 04:23:59.91694	Saturday	800	2045	88	\N	\N	\N	\N
623	2025-12-04 04:23:59.922758	2025-12-04 04:23:59.922758	Monday	900	1430	89	\N	\N	\N	\N
624	2025-12-04 04:23:59.923542	2025-12-04 04:23:59.923542	Tuesday	800	1430	89	\N	\N	\N	\N
625	2025-12-04 04:23:59.92435	2025-12-04 04:23:59.92435	Wednesday	15	1400	89	\N	\N	\N	\N
626	2025-12-04 04:23:59.925085	2025-12-04 04:23:59.925085	Wednesday	1745	2315	89	\N	\N	\N	\N
627	2025-12-04 04:23:59.925829	2025-12-04 04:23:59.925829	Thursday	600	1645	89	\N	\N	\N	\N
628	2025-12-04 04:23:59.926578	2025-12-04 04:23:59.926578	Friday	845	2330	89	\N	\N	\N	\N
629	2025-12-04 04:23:59.927382	2025-12-04 04:23:59.927382	Sunday	745	1515	89	\N	\N	\N	\N
630	2025-12-04 04:23:59.940576	2025-12-04 04:23:59.940576	Monday	1600	230	90	\N	\N	\N	\N
631	2025-12-04 04:23:59.941347	2025-12-04 04:23:59.941347	Tuesday	715	1915	90	\N	\N	\N	\N
632	2025-12-04 04:23:59.94211	2025-12-04 04:23:59.94211	Wednesday	215	345	90	\N	\N	\N	\N
633	2025-12-04 04:23:59.942817	2025-12-04 04:23:59.942817	Wednesday	715	1000	90	\N	\N	\N	\N
634	2025-12-04 04:23:59.943636	2025-12-04 04:23:59.943636	Thursday	445	600	90	\N	\N	\N	\N
635	2025-12-04 04:23:59.944385	2025-12-04 04:23:59.944385	Thursday	615	915	90	\N	\N	\N	\N
636	2025-12-04 04:23:59.945087	2025-12-04 04:23:59.945087	Friday	915	1930	90	\N	\N	\N	\N
637	2025-12-04 04:23:59.945857	2025-12-04 04:23:59.945857	Saturday	1300	1400	90	\N	\N	\N	\N
638	2025-12-04 04:23:59.946586	2025-12-04 04:23:59.946586	Saturday	1730	1945	90	\N	\N	\N	\N
639	2025-12-04 04:23:59.947317	2025-12-04 04:23:59.947317	Sunday	700	2400	90	\N	\N	\N	\N
640	2025-12-04 04:23:59.952274	2025-12-04 04:23:59.952274	Monday	915	2000	91	\N	\N	\N	\N
641	2025-12-04 04:23:59.953052	2025-12-04 04:23:59.953052	Tuesday	730	1200	91	\N	\N	\N	\N
642	2025-12-04 04:23:59.953924	2025-12-04 04:23:59.953924	Tuesday	1400	2100	91	\N	\N	\N	\N
643	2025-12-04 04:23:59.954779	2025-12-04 04:23:59.954779	Wednesday	200	1100	91	\N	\N	\N	\N
644	2025-12-04 04:23:59.955507	2025-12-04 04:23:59.955507	Wednesday	1145	1230	91	\N	\N	\N	\N
645	2025-12-04 04:23:59.956286	2025-12-04 04:23:59.956286	Sunday	315	1215	91	\N	\N	\N	\N
646	2025-12-04 04:23:59.956997	2025-12-04 04:23:59.956997	Sunday	1315	2230	91	\N	\N	\N	\N
647	2025-12-04 04:23:59.965309	2025-12-04 04:23:59.965309	Monday	900	2300	92	\N	\N	\N	\N
648	2025-12-04 04:23:59.966057	2025-12-04 04:23:59.966057	Tuesday	630	1915	92	\N	\N	\N	\N
649	2025-12-04 04:23:59.966827	2025-12-04 04:23:59.966827	Wednesday	2115	2215	92	\N	\N	\N	\N
650	2025-12-04 04:23:59.967562	2025-12-04 04:23:59.967562	Wednesday	2245	1015	92	\N	\N	\N	\N
651	2025-12-04 04:23:59.968278	2025-12-04 04:23:59.968278	Thursday	730	1945	92	\N	\N	\N	\N
652	2025-12-04 04:23:59.969067	2025-12-04 04:23:59.969067	Saturday	800	830	92	\N	\N	\N	\N
653	2025-12-04 04:23:59.969803	2025-12-04 04:23:59.969803	Saturday	1245	1730	92	\N	\N	\N	\N
654	2025-12-04 04:23:59.97059	2025-12-04 04:23:59.97059	Sunday	130	400	92	\N	\N	\N	\N
655	2025-12-04 04:23:59.971496	2025-12-04 04:23:59.971496	Sunday	515	1215	92	\N	\N	\N	\N
656	2025-12-04 04:23:59.992416	2025-12-04 04:23:59.992416	Monday	2215	315	93	\N	\N	\N	\N
657	2025-12-04 04:23:59.993207	2025-12-04 04:23:59.993207	Wednesday	715	2115	93	\N	\N	\N	\N
658	2025-12-04 04:23:59.994	2025-12-04 04:23:59.994	Thursday	830	1630	93	\N	\N	\N	\N
659	2025-12-04 04:23:59.994777	2025-12-04 04:23:59.994777	Friday	615	2000	93	\N	\N	\N	\N
660	2025-12-04 04:23:59.995531	2025-12-04 04:23:59.995531	Saturday	730	1830	93	\N	\N	\N	\N
661	2025-12-04 04:23:59.996332	2025-12-04 04:23:59.996332	Sunday	315	1615	93	\N	\N	\N	\N
662	2025-12-04 04:23:59.997089	2025-12-04 04:23:59.997089	Sunday	1930	2245	93	\N	\N	\N	\N
663	2025-12-04 04:24:00.003679	2025-12-04 04:24:00.003679	Monday	830	2245	94	\N	\N	\N	\N
664	2025-12-04 04:24:00.004672	2025-12-04 04:24:00.004672	Tuesday	945	1700	94	\N	\N	\N	\N
665	2025-12-04 04:24:00.005845	2025-12-04 04:24:00.005845	Wednesday	330	515	94	\N	\N	\N	\N
666	2025-12-04 04:24:00.006798	2025-12-04 04:24:00.006798	Wednesday	830	1145	94	\N	\N	\N	\N
667	2025-12-04 04:24:00.007591	2025-12-04 04:24:00.007591	Sunday	600	2130	94	\N	\N	\N	\N
668	2025-12-04 04:24:00.019881	2025-12-04 04:24:00.019881	Monday	2215	345	95	\N	\N	\N	\N
669	2025-12-04 04:24:00.020676	2025-12-04 04:24:00.020676	Wednesday	615	2100	95	\N	\N	\N	\N
670	2025-12-04 04:24:00.021504	2025-12-04 04:24:00.021504	Thursday	1515	400	95	\N	\N	\N	\N
671	2025-12-04 04:24:00.022287	2025-12-04 04:24:00.022287	Friday	700	1100	95	\N	\N	\N	\N
672	2025-12-04 04:24:00.02301	2025-12-04 04:24:00.02301	Friday	1330	2045	95	\N	\N	\N	\N
673	2025-12-04 04:24:00.023768	2025-12-04 04:24:00.023768	Saturday	2215	245	95	\N	\N	\N	\N
674	2025-12-04 04:24:00.024517	2025-12-04 04:24:00.024517	Sunday	1945	245	95	\N	\N	\N	\N
675	2025-12-04 04:24:00.030343	2025-12-04 04:24:00.030343	Monday	745	2345	96	\N	\N	\N	\N
676	2025-12-04 04:24:00.031114	2025-12-04 04:24:00.031114	Tuesday	915	1415	96	\N	\N	\N	\N
677	2025-12-04 04:24:00.031914	2025-12-04 04:24:00.031914	Wednesday	230	430	96	\N	\N	\N	\N
678	2025-12-04 04:24:00.032662	2025-12-04 04:24:00.032662	Wednesday	1830	2330	96	\N	\N	\N	\N
679	2025-12-04 04:24:00.033474	2025-12-04 04:24:00.033474	Thursday	800	1845	96	\N	\N	\N	\N
680	2025-12-04 04:24:00.034293	2025-12-04 04:24:00.034293	Friday	1830	100	96	\N	\N	\N	\N
681	2025-12-04 04:24:00.035078	2025-12-04 04:24:00.035078	Saturday	930	1600	96	\N	\N	\N	\N
682	2025-12-04 04:24:00.03591	2025-12-04 04:24:00.03591	Sunday	330	1600	96	\N	\N	\N	\N
683	2025-12-04 04:24:00.036692	2025-12-04 04:24:00.036692	Sunday	1930	2000	96	\N	\N	\N	\N
684	2025-12-04 04:24:00.048138	2025-12-04 04:24:00.048138	Monday	715	1900	97	\N	\N	\N	\N
685	2025-12-04 04:24:00.048927	2025-12-04 04:24:00.048927	Tuesday	600	1915	97	\N	\N	\N	\N
686	2025-12-04 04:24:00.049763	2025-12-04 04:24:00.049763	Thursday	900	1815	97	\N	\N	\N	\N
687	2025-12-04 04:24:00.050591	2025-12-04 04:24:00.050591	Saturday	715	2030	97	\N	\N	\N	\N
688	2025-12-04 04:24:00.05137	2025-12-04 04:24:00.05137	Sunday	1845	100	97	\N	\N	\N	\N
689	2025-12-04 04:24:00.056662	2025-12-04 04:24:00.056662	Monday	445	630	98	\N	\N	\N	\N
690	2025-12-04 04:24:00.057462	2025-12-04 04:24:00.057462	Monday	1115	1300	98	\N	\N	\N	\N
691	2025-12-04 04:24:00.058217	2025-12-04 04:24:00.058217	Tuesday	745	1615	98	\N	\N	\N	\N
692	2025-12-04 04:24:00.058967	2025-12-04 04:24:00.058967	Wednesday	1000	1815	98	\N	\N	\N	\N
693	2025-12-04 04:24:00.059707	2025-12-04 04:24:00.059707	Thursday	615	1400	98	\N	\N	\N	\N
694	2025-12-04 04:24:00.060451	2025-12-04 04:24:00.060451	Friday	945	2315	98	\N	\N	\N	\N
695	2025-12-04 04:24:00.061263	2025-12-04 04:24:00.061263	Sunday	30	530	98	\N	\N	\N	\N
696	2025-12-04 04:24:00.062031	2025-12-04 04:24:00.062031	Sunday	1630	1645	98	\N	\N	\N	\N
697	2025-12-04 04:24:00.073231	2025-12-04 04:24:00.073231	Monday	615	1600	99	\N	\N	\N	\N
698	2025-12-04 04:24:00.074067	2025-12-04 04:24:00.074067	Tuesday	945	1430	99	\N	\N	\N	\N
699	2025-12-04 04:24:00.074822	2025-12-04 04:24:00.074822	Wednesday	700	1645	99	\N	\N	\N	\N
700	2025-12-04 04:24:00.075647	2025-12-04 04:24:00.075647	Thursday	115	1945	99	\N	\N	\N	\N
701	2025-12-04 04:24:00.076413	2025-12-04 04:24:00.076413	Thursday	2215	2230	99	\N	\N	\N	\N
702	2025-12-04 04:24:00.077224	2025-12-04 04:24:00.077224	Friday	830	1030	99	\N	\N	\N	\N
703	2025-12-04 04:24:00.078032	2025-12-04 04:24:00.078032	Friday	1545	200	99	\N	\N	\N	\N
704	2025-12-04 04:24:00.078829	2025-12-04 04:24:00.078829	Saturday	945	1100	99	\N	\N	\N	\N
705	2025-12-04 04:24:00.079564	2025-12-04 04:24:00.079564	Saturday	1445	1945	99	\N	\N	\N	\N
706	2025-12-04 04:24:00.080308	2025-12-04 04:24:00.080308	Sunday	715	1845	99	\N	\N	\N	\N
707	2025-12-04 04:24:00.085851	2025-12-04 04:24:00.085851	Monday	1645	315	100	\N	\N	\N	\N
708	2025-12-04 04:24:00.086657	2025-12-04 04:24:00.086657	Wednesday	930	2400	100	\N	\N	\N	\N
709	2025-12-04 04:24:00.087439	2025-12-04 04:24:00.087439	Thursday	1445	200	100	\N	\N	\N	\N
710	2025-12-04 04:24:00.088281	2025-12-04 04:24:00.088281	Friday	315	1115	100	\N	\N	\N	\N
711	2025-12-04 04:24:00.089035	2025-12-04 04:24:00.089035	Friday	1500	1630	100	\N	\N	\N	\N
712	2025-12-04 04:24:00.089803	2025-12-04 04:24:00.089803	Saturday	630	1600	100	\N	\N	\N	\N
713	2025-12-04 04:24:00.090554	2025-12-04 04:24:00.090554	Sunday	930	1845	100	\N	\N	\N	\N
714	2025-12-04 04:24:00.098971	2025-12-04 04:24:00.098971	Monday	945	1530	101	\N	\N	\N	\N
715	2025-12-04 04:24:00.09975	2025-12-04 04:24:00.09975	Tuesday	600	2330	101	\N	\N	\N	\N
716	2025-12-04 04:24:00.100528	2025-12-04 04:24:00.100528	Wednesday	15	730	101	\N	\N	\N	\N
717	2025-12-04 04:24:00.101295	2025-12-04 04:24:00.101295	Wednesday	1130	2115	101	\N	\N	\N	\N
718	2025-12-04 04:24:00.102073	2025-12-04 04:24:00.102073	Thursday	945	1945	101	\N	\N	\N	\N
719	2025-12-04 04:24:00.102876	2025-12-04 04:24:00.102876	Friday	2245	345	101	\N	\N	\N	\N
720	2025-12-04 04:24:00.103649	2025-12-04 04:24:00.103649	Sunday	900	1615	101	\N	\N	\N	\N
721	2025-12-04 04:24:00.115509	2025-12-04 04:24:00.115509	Monday	615	1915	102	\N	\N	\N	\N
722	2025-12-04 04:24:00.116329	2025-12-04 04:24:00.116329	Tuesday	530	615	102	\N	\N	\N	\N
723	2025-12-04 04:24:00.117102	2025-12-04 04:24:00.117102	Tuesday	2030	245	102	\N	\N	\N	\N
724	2025-12-04 04:24:00.117855	2025-12-04 04:24:00.117855	Wednesday	730	1515	102	\N	\N	\N	\N
725	2025-12-04 04:24:00.118622	2025-12-04 04:24:00.118622	Friday	745	2245	102	\N	\N	\N	\N
726	2025-12-04 04:24:00.119583	2025-12-04 04:24:00.119583	Saturday	2200	300	102	\N	\N	\N	\N
727	2025-12-04 04:24:00.120348	2025-12-04 04:24:00.120348	Sunday	630	1745	102	\N	\N	\N	\N
728	2025-12-04 04:24:00.126304	2025-12-04 04:24:00.126304	Monday	415	1315	103	\N	\N	\N	\N
729	2025-12-04 04:24:00.127075	2025-12-04 04:24:00.127075	Monday	1600	2230	103	\N	\N	\N	\N
730	2025-12-04 04:24:00.127879	2025-12-04 04:24:00.127879	Wednesday	630	1815	103	\N	\N	\N	\N
731	2025-12-04 04:24:00.128629	2025-12-04 04:24:00.128629	Wednesday	2300	315	103	\N	\N	\N	\N
732	2025-12-04 04:24:00.129404	2025-12-04 04:24:00.129404	Thursday	1830	400	103	\N	\N	\N	\N
733	2025-12-04 04:24:00.130217	2025-12-04 04:24:00.130217	Friday	615	715	103	\N	\N	\N	\N
734	2025-12-04 04:24:00.130936	2025-12-04 04:24:00.130936	Friday	1030	1200	103	\N	\N	\N	\N
735	2025-12-04 04:24:00.131694	2025-12-04 04:24:00.131694	Saturday	1945	245	103	\N	\N	\N	\N
736	2025-12-04 04:24:00.132468	2025-12-04 04:24:00.132468	Sunday	815	1900	103	\N	\N	\N	\N
737	2025-12-04 04:24:00.143502	2025-12-04 04:24:00.143502	Monday	915	1845	104	\N	\N	\N	\N
738	2025-12-04 04:24:00.144308	2025-12-04 04:24:00.144308	Tuesday	745	1600	104	\N	\N	\N	\N
739	2025-12-04 04:24:00.145102	2025-12-04 04:24:00.145102	Wednesday	900	1545	104	\N	\N	\N	\N
740	2025-12-04 04:24:00.145894	2025-12-04 04:24:00.145894	Thursday	230	730	104	\N	\N	\N	\N
741	2025-12-04 04:24:00.146617	2025-12-04 04:24:00.146617	Thursday	1200	0	104	\N	\N	\N	\N
742	2025-12-04 04:24:00.147408	2025-12-04 04:24:00.147408	Friday	715	945	104	\N	\N	\N	\N
743	2025-12-04 04:24:00.14813	2025-12-04 04:24:00.14813	Friday	1615	1800	104	\N	\N	\N	\N
744	2025-12-04 04:24:00.148891	2025-12-04 04:24:00.148891	Saturday	1730	100	104	\N	\N	\N	\N
745	2025-12-04 04:24:00.154272	2025-12-04 04:24:00.154272	Monday	200	400	105	\N	\N	\N	\N
746	2025-12-04 04:24:00.155095	2025-12-04 04:24:00.155095	Monday	715	1530	105	\N	\N	\N	\N
747	2025-12-04 04:24:00.155839	2025-12-04 04:24:00.155839	Tuesday	815	1915	105	\N	\N	\N	\N
748	2025-12-04 04:24:00.156627	2025-12-04 04:24:00.156627	Sunday	830	1400	105	\N	\N	\N	\N
749	2025-12-04 04:24:00.165079	2025-12-04 04:24:00.165079	Monday	2100	145	106	\N	\N	\N	\N
750	2025-12-04 04:24:00.165858	2025-12-04 04:24:00.165858	Tuesday	730	1545	106	\N	\N	\N	\N
751	2025-12-04 04:24:00.166599	2025-12-04 04:24:00.166599	Wednesday	845	2000	106	\N	\N	\N	\N
752	2025-12-04 04:24:00.167397	2025-12-04 04:24:00.167397	Thursday	815	1515	106	\N	\N	\N	\N
753	2025-12-04 04:24:00.168217	2025-12-04 04:24:00.168217	Friday	1830	200	106	\N	\N	\N	\N
754	2025-12-04 04:24:00.169119	2025-12-04 04:24:00.169119	Saturday	1200	1545	106	\N	\N	\N	\N
755	2025-12-04 04:24:00.169859	2025-12-04 04:24:00.169859	Saturday	1700	2100	106	\N	\N	\N	\N
756	2025-12-04 04:24:00.170614	2025-12-04 04:24:00.170614	Sunday	2045	400	106	\N	\N	\N	\N
757	2025-12-04 04:24:00.181888	2025-12-04 04:24:00.181888	Monday	1545	215	107	\N	\N	\N	\N
758	2025-12-04 04:24:00.182708	2025-12-04 04:24:00.182708	Tuesday	600	2145	107	\N	\N	\N	\N
759	2025-12-04 04:24:00.183474	2025-12-04 04:24:00.183474	Wednesday	745	2200	107	\N	\N	\N	\N
760	2025-12-04 04:24:00.184257	2025-12-04 04:24:00.184257	Friday	115	900	107	\N	\N	\N	\N
761	2025-12-04 04:24:00.185033	2025-12-04 04:24:00.185033	Friday	1830	2400	107	\N	\N	\N	\N
762	2025-12-04 04:24:00.185954	2025-12-04 04:24:00.185954	Saturday	900	1845	107	\N	\N	\N	\N
763	2025-12-04 04:24:00.186712	2025-12-04 04:24:00.186712	Sunday	830	2015	107	\N	\N	\N	\N
764	2025-12-04 04:24:00.191964	2025-12-04 04:24:00.191964	Monday	630	1630	108	\N	\N	\N	\N
765	2025-12-04 04:24:00.192977	2025-12-04 04:24:00.192977	Tuesday	615	730	108	\N	\N	\N	\N
766	2025-12-04 04:24:00.19374	2025-12-04 04:24:00.19374	Tuesday	945	2300	108	\N	\N	\N	\N
767	2025-12-04 04:24:00.194492	2025-12-04 04:24:00.194492	Wednesday	600	1715	108	\N	\N	\N	\N
768	2025-12-04 04:24:00.195282	2025-12-04 04:24:00.195282	Thursday	800	1130	108	\N	\N	\N	\N
769	2025-12-04 04:24:00.196026	2025-12-04 04:24:00.196026	Thursday	1600	500	108	\N	\N	\N	\N
770	2025-12-04 04:24:00.196803	2025-12-04 04:24:00.196803	Friday	945	1930	108	\N	\N	\N	\N
771	2025-12-04 04:24:00.197602	2025-12-04 04:24:00.197602	Saturday	30	1330	108	\N	\N	\N	\N
772	2025-12-04 04:24:00.198349	2025-12-04 04:24:00.198349	Saturday	1500	2115	108	\N	\N	\N	\N
773	2025-12-04 04:24:00.199089	2025-12-04 04:24:00.199089	Sunday	945	2130	108	\N	\N	\N	\N
774	2025-12-04 04:24:00.211068	2025-12-04 04:24:00.211068	Monday	900	1900	109	\N	\N	\N	\N
775	2025-12-04 04:24:00.211922	2025-12-04 04:24:00.211922	Tuesday	630	2115	109	\N	\N	\N	\N
776	2025-12-04 04:24:00.212665	2025-12-04 04:24:00.212665	Wednesday	645	2100	109	\N	\N	\N	\N
777	2025-12-04 04:24:00.213456	2025-12-04 04:24:00.213456	Thursday	800	1545	109	\N	\N	\N	\N
778	2025-12-04 04:24:00.214192	2025-12-04 04:24:00.214192	Friday	745	1830	109	\N	\N	\N	\N
779	2025-12-04 04:24:00.215074	2025-12-04 04:24:00.215074	Saturday	615	1830	109	\N	\N	\N	\N
780	2025-12-04 04:24:00.21598	2025-12-04 04:24:00.21598	Sunday	600	945	109	\N	\N	\N	\N
781	2025-12-04 04:24:00.216746	2025-12-04 04:24:00.216746	Sunday	1130	1415	109	\N	\N	\N	\N
782	2025-12-04 04:24:00.222852	2025-12-04 04:24:00.222852	Monday	1445	1645	110	\N	\N	\N	\N
783	2025-12-04 04:24:00.22362	2025-12-04 04:24:00.22362	Monday	2130	200	110	\N	\N	\N	\N
784	2025-12-04 04:24:00.224409	2025-12-04 04:24:00.224409	Thursday	2245	115	110	\N	\N	\N	\N
785	2025-12-04 04:24:00.225152	2025-12-04 04:24:00.225152	Friday	730	2330	110	\N	\N	\N	\N
786	2025-12-04 04:24:00.22598	2025-12-04 04:24:00.22598	Saturday	845	1430	110	\N	\N	\N	\N
787	2025-12-04 04:24:00.226761	2025-12-04 04:24:00.226761	Sunday	600	2115	110	\N	\N	\N	\N
788	2025-12-04 04:24:00.238537	2025-12-04 04:24:00.238537	Tuesday	400	1030	111	\N	\N	\N	\N
789	2025-12-04 04:24:00.239386	2025-12-04 04:24:00.239386	Tuesday	1330	200	111	\N	\N	\N	\N
790	2025-12-04 04:24:00.240151	2025-12-04 04:24:00.240151	Wednesday	945	1730	111	\N	\N	\N	\N
791	2025-12-04 04:24:00.240936	2025-12-04 04:24:00.240936	Thursday	815	2115	111	\N	\N	\N	\N
792	2025-12-04 04:24:00.241771	2025-12-04 04:24:00.241771	Saturday	730	1300	111	\N	\N	\N	\N
793	2025-12-04 04:24:00.242504	2025-12-04 04:24:00.242504	Saturday	1545	2030	111	\N	\N	\N	\N
794	2025-12-04 04:24:00.243278	2025-12-04 04:24:00.243278	Sunday	1445	300	111	\N	\N	\N	\N
795	2025-12-04 04:24:00.251549	2025-12-04 04:24:00.251549	Monday	2245	330	112	\N	\N	\N	\N
796	2025-12-04 04:24:00.252311	2025-12-04 04:24:00.252311	Tuesday	900	2000	112	\N	\N	\N	\N
797	2025-12-04 04:24:00.253082	2025-12-04 04:24:00.253082	Wednesday	845	2015	112	\N	\N	\N	\N
798	2025-12-04 04:24:00.254043	2025-12-04 04:24:00.254043	Thursday	930	2015	112	\N	\N	\N	\N
799	2025-12-04 04:24:00.254816	2025-12-04 04:24:00.254816	Friday	600	1430	112	\N	\N	\N	\N
800	2025-12-04 04:24:00.255576	2025-12-04 04:24:00.255576	Saturday	730	2130	112	\N	\N	\N	\N
801	2025-12-04 04:24:00.267394	2025-12-04 04:24:00.267394	Wednesday	815	1515	113	\N	\N	\N	\N
802	2025-12-04 04:24:00.268191	2025-12-04 04:24:00.268191	Friday	630	1645	113	\N	\N	\N	\N
803	2025-12-04 04:24:00.268953	2025-12-04 04:24:00.268953	Saturday	1630	215	113	\N	\N	\N	\N
804	2025-12-04 04:24:00.269759	2025-12-04 04:24:00.269759	Sunday	1500	200	113	\N	\N	\N	\N
805	2025-12-04 04:24:00.275541	2025-12-04 04:24:00.275541	Monday	615	2200	114	\N	\N	\N	\N
806	2025-12-04 04:24:00.276348	2025-12-04 04:24:00.276348	Tuesday	730	1515	114	\N	\N	\N	\N
807	2025-12-04 04:24:00.277178	2025-12-04 04:24:00.277178	Wednesday	1100	1745	114	\N	\N	\N	\N
808	2025-12-04 04:24:00.277911	2025-12-04 04:24:00.277911	Wednesday	2300	2315	114	\N	\N	\N	\N
809	2025-12-04 04:24:00.278753	2025-12-04 04:24:00.278753	Thursday	700	715	114	\N	\N	\N	\N
810	2025-12-04 04:24:00.279543	2025-12-04 04:24:00.279543	Thursday	1115	1300	114	\N	\N	\N	\N
811	2025-12-04 04:24:00.280323	2025-12-04 04:24:00.280323	Friday	1400	230	114	\N	\N	\N	\N
812	2025-12-04 04:24:00.281088	2025-12-04 04:24:00.281088	Saturday	700	2030	114	\N	\N	\N	\N
813	2025-12-04 04:24:00.281851	2025-12-04 04:24:00.281851	Sunday	930	2245	114	\N	\N	\N	\N
814	2025-12-04 04:24:00.291173	2025-12-04 04:24:00.291173	Monday	415	815	115	\N	\N	\N	\N
815	2025-12-04 04:24:00.291942	2025-12-04 04:24:00.291942	Monday	1515	1915	115	\N	\N	\N	\N
816	2025-12-04 04:24:00.29272	2025-12-04 04:24:00.29272	Tuesday	900	2315	115	\N	\N	\N	\N
817	2025-12-04 04:24:00.293536	2025-12-04 04:24:00.293536	Wednesday	830	1545	115	\N	\N	\N	\N
818	2025-12-04 04:24:00.294296	2025-12-04 04:24:00.294296	Wednesday	1900	2200	115	\N	\N	\N	\N
819	2025-12-04 04:24:00.295088	2025-12-04 04:24:00.295088	Thursday	1000	1715	115	\N	\N	\N	\N
820	2025-12-04 04:24:00.295849	2025-12-04 04:24:00.295849	Saturday	615	1900	115	\N	\N	\N	\N
821	2025-12-04 04:24:00.307472	2025-12-04 04:24:00.307472	Monday	615	2315	116	\N	\N	\N	\N
822	2025-12-04 04:24:00.308271	2025-12-04 04:24:00.308271	Tuesday	745	1445	116	\N	\N	\N	\N
823	2025-12-04 04:24:00.309082	2025-12-04 04:24:00.309082	Wednesday	800	1815	116	\N	\N	\N	\N
824	2025-12-04 04:24:00.309848	2025-12-04 04:24:00.309848	Thursday	715	2130	116	\N	\N	\N	\N
825	2025-12-04 04:24:00.310628	2025-12-04 04:24:00.310628	Saturday	815	1600	116	\N	\N	\N	\N
826	2025-12-04 04:24:00.316463	2025-12-04 04:24:00.316463	Monday	900	1745	117	\N	\N	\N	\N
827	2025-12-04 04:24:00.317233	2025-12-04 04:24:00.317233	Tuesday	830	2130	117	\N	\N	\N	\N
828	2025-12-04 04:24:00.317976	2025-12-04 04:24:00.317976	Wednesday	645	2300	117	\N	\N	\N	\N
829	2025-12-04 04:24:00.31878	2025-12-04 04:24:00.31878	Saturday	800	845	117	\N	\N	\N	\N
830	2025-12-04 04:24:00.319595	2025-12-04 04:24:00.319595	Saturday	1600	100	117	\N	\N	\N	\N
831	2025-12-04 04:24:00.331561	2025-12-04 04:24:00.331561	Wednesday	45	930	118	\N	\N	\N	\N
832	2025-12-04 04:24:00.332347	2025-12-04 04:24:00.332347	Wednesday	1715	2345	118	\N	\N	\N	\N
833	2025-12-04 04:24:00.333093	2025-12-04 04:24:00.333093	Thursday	715	1530	118	\N	\N	\N	\N
834	2025-12-04 04:24:00.333873	2025-12-04 04:24:00.333873	Friday	730	1015	118	\N	\N	\N	\N
835	2025-12-04 04:24:00.334612	2025-12-04 04:24:00.334612	Friday	1915	2300	118	\N	\N	\N	\N
836	2025-12-04 04:24:00.335478	2025-12-04 04:24:00.335478	Saturday	400	1430	118	\N	\N	\N	\N
837	2025-12-04 04:24:00.336246	2025-12-04 04:24:00.336246	Saturday	1645	2315	118	\N	\N	\N	\N
838	2025-12-04 04:24:00.336992	2025-12-04 04:24:00.336992	Sunday	715	1700	118	\N	\N	\N	\N
839	2025-12-04 04:24:00.342763	2025-12-04 04:24:00.342763	Monday	900	1945	119	\N	\N	\N	\N
840	2025-12-04 04:24:00.343547	2025-12-04 04:24:00.343547	Wednesday	1915	300	119	\N	\N	\N	\N
841	2025-12-04 04:24:00.344338	2025-12-04 04:24:00.344338	Thursday	2130	315	119	\N	\N	\N	\N
842	2025-12-04 04:24:00.345142	2025-12-04 04:24:00.345142	Friday	845	1815	119	\N	\N	\N	\N
843	2025-12-04 04:24:00.345967	2025-12-04 04:24:00.345967	Saturday	545	1345	119	\N	\N	\N	\N
844	2025-12-04 04:24:00.346738	2025-12-04 04:24:00.346738	Saturday	2230	30	119	\N	\N	\N	\N
845	2025-12-04 04:24:00.347515	2025-12-04 04:24:00.347515	Sunday	800	1845	119	\N	\N	\N	\N
846	2025-12-04 04:24:00.35653	2025-12-04 04:24:00.35653	Tuesday	730	1645	120	\N	\N	\N	\N
847	2025-12-04 04:24:00.357316	2025-12-04 04:24:00.357316	Wednesday	730	1915	120	\N	\N	\N	\N
848	2025-12-04 04:24:00.358384	2025-12-04 04:24:00.358384	Thursday	745	1915	120	\N	\N	\N	\N
849	2025-12-04 04:24:00.359145	2025-12-04 04:24:00.359145	Friday	1930	100	120	\N	\N	\N	\N
850	2025-12-04 04:24:00.359988	2025-12-04 04:24:00.359988	Saturday	330	1830	120	\N	\N	\N	\N
851	2025-12-04 04:24:00.360729	2025-12-04 04:24:00.360729	Saturday	2000	2045	120	\N	\N	\N	\N
852	2025-12-04 04:24:00.361527	2025-12-04 04:24:00.361527	Sunday	730	2400	120	\N	\N	\N	\N
853	2025-12-04 04:24:00.373845	2025-12-04 04:24:00.373845	Monday	615	2130	121	\N	\N	\N	\N
854	2025-12-04 04:24:00.374633	2025-12-04 04:24:00.374633	Friday	630	1700	121	\N	\N	\N	\N
855	2025-12-04 04:24:00.375436	2025-12-04 04:24:00.375436	Saturday	1045	1945	121	\N	\N	\N	\N
856	2025-12-04 04:24:00.3762	2025-12-04 04:24:00.3762	Saturday	2000	400	121	\N	\N	\N	\N
857	2025-12-04 04:24:00.376976	2025-12-04 04:24:00.376976	Sunday	2145	315	121	\N	\N	\N	\N
858	2025-12-04 04:24:00.383151	2025-12-04 04:24:00.383151	Monday	300	1630	122	\N	\N	\N	\N
859	2025-12-04 04:24:00.38388	2025-12-04 04:24:00.38388	Monday	2045	2215	122	\N	\N	\N	\N
860	2025-12-04 04:24:00.384639	2025-12-04 04:24:00.384639	Tuesday	715	2345	122	\N	\N	\N	\N
861	2025-12-04 04:24:00.385383	2025-12-04 04:24:00.385383	Wednesday	1730	315	122	\N	\N	\N	\N
862	2025-12-04 04:24:00.386154	2025-12-04 04:24:00.386154	Friday	600	1600	122	\N	\N	\N	\N
863	2025-12-04 04:24:00.386884	2025-12-04 04:24:00.386884	Saturday	745	2015	122	\N	\N	\N	\N
864	2025-12-04 04:24:00.387636	2025-12-04 04:24:00.387636	Sunday	2145	315	122	\N	\N	\N	\N
865	2025-12-04 04:24:00.397455	2025-12-04 04:24:00.397455	Monday	745	1630	123	\N	\N	\N	\N
866	2025-12-04 04:24:00.398233	2025-12-04 04:24:00.398233	Wednesday	715	1700	123	\N	\N	\N	\N
867	2025-12-04 04:24:00.39895	2025-12-04 04:24:00.39895	Thursday	645	2230	123	\N	\N	\N	\N
868	2025-12-04 04:24:00.399715	2025-12-04 04:24:00.399715	Friday	830	1715	123	\N	\N	\N	\N
869	2025-12-04 04:24:00.400474	2025-12-04 04:24:00.400474	Sunday	830	1215	123	\N	\N	\N	\N
870	2025-12-04 04:24:00.401205	2025-12-04 04:24:00.401205	Sunday	2030	2315	123	\N	\N	\N	\N
871	2025-12-04 04:24:00.412984	2025-12-04 04:24:00.412984	Monday	945	1500	124	\N	\N	\N	\N
872	2025-12-04 04:24:00.41382	2025-12-04 04:24:00.41382	Tuesday	30	1415	124	\N	\N	\N	\N
873	2025-12-04 04:24:00.41457	2025-12-04 04:24:00.41457	Tuesday	1845	2200	124	\N	\N	\N	\N
874	2025-12-04 04:24:00.415347	2025-12-04 04:24:00.415347	Friday	815	2100	124	\N	\N	\N	\N
875	2025-12-04 04:24:00.416099	2025-12-04 04:24:00.416099	Saturday	915	1930	124	\N	\N	\N	\N
876	2025-12-04 04:24:00.416906	2025-12-04 04:24:00.416906	Sunday	915	2315	124	\N	\N	\N	\N
877	2025-12-04 04:24:00.423198	2025-12-04 04:24:00.423198	Monday	1915	215	125	\N	\N	\N	\N
878	2025-12-04 04:24:00.424366	2025-12-04 04:24:00.424366	Wednesday	730	1345	125	\N	\N	\N	\N
879	2025-12-04 04:24:00.425087	2025-12-04 04:24:00.425087	Wednesday	1945	715	125	\N	\N	\N	\N
880	2025-12-04 04:24:00.425882	2025-12-04 04:24:00.425882	Thursday	700	2130	125	\N	\N	\N	\N
881	2025-12-04 04:24:00.426622	2025-12-04 04:24:00.426622	Friday	700	2145	125	\N	\N	\N	\N
882	2025-12-04 04:24:00.4362	2025-12-04 04:24:00.4362	Wednesday	715	2100	126	\N	\N	\N	\N
883	2025-12-04 04:24:00.437041	2025-12-04 04:24:00.437041	Thursday	215	745	126	\N	\N	\N	\N
884	2025-12-04 04:24:00.437804	2025-12-04 04:24:00.437804	Thursday	1400	2230	126	\N	\N	\N	\N
885	2025-12-04 04:24:00.438548	2025-12-04 04:24:00.438548	Saturday	645	1800	126	\N	\N	\N	\N
886	2025-12-04 04:24:00.439364	2025-12-04 04:24:00.439364	Sunday	845	1530	126	\N	\N	\N	\N
887	2025-12-04 04:24:00.451178	2025-12-04 04:24:00.451178	Monday	230	1345	127	\N	\N	\N	\N
888	2025-12-04 04:24:00.451934	2025-12-04 04:24:00.451934	Monday	1400	1615	127	\N	\N	\N	\N
889	2025-12-04 04:24:00.452717	2025-12-04 04:24:00.452717	Tuesday	1400	300	127	\N	\N	\N	\N
890	2025-12-04 04:24:00.453512	2025-12-04 04:24:00.453512	Wednesday	630	2400	127	\N	\N	\N	\N
891	2025-12-04 04:24:00.454337	2025-12-04 04:24:00.454337	Friday	900	1715	127	\N	\N	\N	\N
892	2025-12-04 04:24:00.455084	2025-12-04 04:24:00.455084	Saturday	745	1515	127	\N	\N	\N	\N
893	2025-12-04 04:24:00.455826	2025-12-04 04:24:00.455826	Sunday	715	2000	127	\N	\N	\N	\N
894	2025-12-04 04:24:00.461756	2025-12-04 04:24:00.461756	Monday	2230	130	128	\N	\N	\N	\N
895	2025-12-04 04:24:00.462523	2025-12-04 04:24:00.462523	Tuesday	2215	215	128	\N	\N	\N	\N
896	2025-12-04 04:24:00.463271	2025-12-04 04:24:00.463271	Wednesday	615	2030	128	\N	\N	\N	\N
897	2025-12-04 04:24:00.464004	2025-12-04 04:24:00.464004	Thursday	815	1545	128	\N	\N	\N	\N
898	2025-12-04 04:24:00.464738	2025-12-04 04:24:00.464738	Friday	1000	1430	128	\N	\N	\N	\N
899	2025-12-04 04:24:00.465698	2025-12-04 04:24:00.465698	Saturday	700	1145	128	\N	\N	\N	\N
900	2025-12-04 04:24:00.466506	2025-12-04 04:24:00.466506	Saturday	2315	2345	128	\N	\N	\N	\N
901	2025-12-04 04:24:00.479667	2025-12-04 04:24:00.479667	Monday	900	1730	129	\N	\N	\N	\N
902	2025-12-04 04:24:00.480615	2025-12-04 04:24:00.480615	Tuesday	200	645	129	\N	\N	\N	\N
903	2025-12-04 04:24:00.481497	2025-12-04 04:24:00.481497	Tuesday	1215	1245	129	\N	\N	\N	\N
904	2025-12-04 04:24:00.482381	2025-12-04 04:24:00.482381	Wednesday	1800	345	129	\N	\N	\N	\N
905	2025-12-04 04:24:00.483233	2025-12-04 04:24:00.483233	Thursday	915	1545	129	\N	\N	\N	\N
906	2025-12-04 04:24:00.484091	2025-12-04 04:24:00.484091	Saturday	1000	1645	129	\N	\N	\N	\N
907	2025-12-04 04:24:00.484959	2025-12-04 04:24:00.484959	Sunday	100	915	129	\N	\N	\N	\N
908	2025-12-04 04:24:00.485752	2025-12-04 04:24:00.485752	Sunday	1945	2345	129	\N	\N	\N	\N
909	2025-12-04 04:24:00.492264	2025-12-04 04:24:00.492264	Monday	915	1500	130	\N	\N	\N	\N
910	2025-12-04 04:24:00.493048	2025-12-04 04:24:00.493048	Monday	2230	2345	130	\N	\N	\N	\N
911	2025-12-04 04:24:00.493847	2025-12-04 04:24:00.493847	Tuesday	830	1915	130	\N	\N	\N	\N
912	2025-12-04 04:24:00.494841	2025-12-04 04:24:00.494841	Wednesday	800	1400	130	\N	\N	\N	\N
913	2025-12-04 04:24:00.495634	2025-12-04 04:24:00.495634	Friday	945	2200	130	\N	\N	\N	\N
914	2025-12-04 04:24:00.49639	2025-12-04 04:24:00.49639	Sunday	930	1700	130	\N	\N	\N	\N
915	2025-12-04 04:24:00.508603	2025-12-04 04:24:00.508603	Monday	930	1430	131	\N	\N	\N	\N
916	2025-12-04 04:24:00.509429	2025-12-04 04:24:00.509429	Tuesday	730	2345	131	\N	\N	\N	\N
917	2025-12-04 04:24:00.510188	2025-12-04 04:24:00.510188	Wednesday	845	1445	131	\N	\N	\N	\N
918	2025-12-04 04:24:00.51095	2025-12-04 04:24:00.51095	Thursday	645	2400	131	\N	\N	\N	\N
919	2025-12-04 04:24:00.511748	2025-12-04 04:24:00.511748	Friday	930	1630	131	\N	\N	\N	\N
920	2025-12-04 04:24:00.512578	2025-12-04 04:24:00.512578	Saturday	445	630	131	\N	\N	\N	\N
921	2025-12-04 04:24:00.513369	2025-12-04 04:24:00.513369	Saturday	1615	1745	131	\N	\N	\N	\N
922	2025-12-04 04:24:00.514175	2025-12-04 04:24:00.514175	Sunday	2300	145	131	\N	\N	\N	\N
923	2025-12-04 04:24:00.520339	2025-12-04 04:24:00.520339	Monday	730	2045	132	\N	\N	\N	\N
924	2025-12-04 04:24:00.521109	2025-12-04 04:24:00.521109	Tuesday	815	2115	132	\N	\N	\N	\N
925	2025-12-04 04:24:00.52189	2025-12-04 04:24:00.52189	Wednesday	1045	1415	132	\N	\N	\N	\N
926	2025-12-04 04:24:00.522651	2025-12-04 04:24:00.522651	Wednesday	1500	30	132	\N	\N	\N	\N
927	2025-12-04 04:24:00.52346	2025-12-04 04:24:00.52346	Thursday	945	2330	132	\N	\N	\N	\N
928	2025-12-04 04:24:00.524266	2025-12-04 04:24:00.524266	Saturday	700	2400	132	\N	\N	\N	\N
929	2025-12-04 04:24:00.535863	2025-12-04 04:24:00.535863	Monday	830	2245	133	\N	\N	\N	\N
930	2025-12-04 04:24:00.536725	2025-12-04 04:24:00.536725	Tuesday	900	1615	133	\N	\N	\N	\N
931	2025-12-04 04:24:00.537499	2025-12-04 04:24:00.537499	Wednesday	1845	215	133	\N	\N	\N	\N
932	2025-12-04 04:24:00.53826	2025-12-04 04:24:00.53826	Thursday	745	2400	133	\N	\N	\N	\N
933	2025-12-04 04:24:00.539069	2025-12-04 04:24:00.539069	Friday	545	900	133	\N	\N	\N	\N
934	2025-12-04 04:24:00.539832	2025-12-04 04:24:00.539832	Friday	1815	2315	133	\N	\N	\N	\N
935	2025-12-04 04:24:00.540636	2025-12-04 04:24:00.540636	Saturday	645	2315	133	\N	\N	\N	\N
936	2025-12-04 04:24:00.541413	2025-12-04 04:24:00.541413	Sunday	600	2115	133	\N	\N	\N	\N
937	2025-12-04 04:24:00.546628	2025-12-04 04:24:00.546628	Tuesday	615	1815	134	\N	\N	\N	\N
938	2025-12-04 04:24:00.549512	2025-12-04 04:24:00.549512	Wednesday	945	1300	134	\N	\N	\N	\N
939	2025-12-04 04:24:00.550268	2025-12-04 04:24:00.550268	Wednesday	1900	1945	134	\N	\N	\N	\N
940	2025-12-04 04:24:00.551071	2025-12-04 04:24:00.551071	Thursday	1515	200	134	\N	\N	\N	\N
941	2025-12-04 04:24:00.551862	2025-12-04 04:24:00.551862	Saturday	1815	115	134	\N	\N	\N	\N
942	2025-12-04 04:24:00.552598	2025-12-04 04:24:00.552598	Sunday	830	2130	134	\N	\N	\N	\N
943	2025-12-04 04:24:00.561426	2025-12-04 04:24:00.561426	Monday	830	2130	135	\N	\N	\N	\N
944	2025-12-04 04:24:00.562298	2025-12-04 04:24:00.562298	Thursday	1000	1530	135	\N	\N	\N	\N
945	2025-12-04 04:24:00.563073	2025-12-04 04:24:00.563073	Thursday	1730	2045	135	\N	\N	\N	\N
946	2025-12-04 04:24:00.563832	2025-12-04 04:24:00.563832	Friday	730	2015	135	\N	\N	\N	\N
947	2025-12-04 04:24:00.56459	2025-12-04 04:24:00.56459	Saturday	800	1745	135	\N	\N	\N	\N
948	2025-12-04 04:24:00.565552	2025-12-04 04:24:00.565552	Sunday	715	2215	135	\N	\N	\N	\N
949	2025-12-04 04:24:00.577417	2025-12-04 04:24:00.577417	Tuesday	1000	1730	136	\N	\N	\N	\N
950	2025-12-04 04:24:00.578243	2025-12-04 04:24:00.578243	Wednesday	415	1600	136	\N	\N	\N	\N
951	2025-12-04 04:24:00.578994	2025-12-04 04:24:00.578994	Wednesday	1730	2230	136	\N	\N	\N	\N
952	2025-12-04 04:24:00.579797	2025-12-04 04:24:00.579797	Friday	200	530	136	\N	\N	\N	\N
953	2025-12-04 04:24:00.580565	2025-12-04 04:24:00.580565	Friday	1845	2145	136	\N	\N	\N	\N
954	2025-12-04 04:24:00.581339	2025-12-04 04:24:00.581339	Saturday	715	2245	136	\N	\N	\N	\N
955	2025-12-04 04:24:00.587142	2025-12-04 04:24:00.587142	Monday	915	1945	137	\N	\N	\N	\N
956	2025-12-04 04:24:00.588023	2025-12-04 04:24:00.588023	Tuesday	415	1130	137	\N	\N	\N	\N
957	2025-12-04 04:24:00.588789	2025-12-04 04:24:00.588789	Tuesday	1530	2345	137	\N	\N	\N	\N
958	2025-12-04 04:24:00.589554	2025-12-04 04:24:00.589554	Wednesday	600	2045	137	\N	\N	\N	\N
959	2025-12-04 04:24:00.590284	2025-12-04 04:24:00.590284	Thursday	945	1400	137	\N	\N	\N	\N
960	2025-12-04 04:24:00.591077	2025-12-04 04:24:00.591077	Friday	115	215	137	\N	\N	\N	\N
961	2025-12-04 04:24:00.591813	2025-12-04 04:24:00.591813	Friday	1515	1845	137	\N	\N	\N	\N
962	2025-12-04 04:24:00.592679	2025-12-04 04:24:00.592679	Saturday	745	1845	137	\N	\N	\N	\N
963	2025-12-04 04:24:00.59352	2025-12-04 04:24:00.59352	Sunday	515	1300	137	\N	\N	\N	\N
964	2025-12-04 04:24:00.594304	2025-12-04 04:24:00.594304	Sunday	1845	145	137	\N	\N	\N	\N
965	2025-12-04 04:24:00.606477	2025-12-04 04:24:00.606477	Monday	715	1900	138	\N	\N	\N	\N
966	2025-12-04 04:24:00.607273	2025-12-04 04:24:00.607273	Tuesday	700	2400	138	\N	\N	\N	\N
967	2025-12-04 04:24:00.608041	2025-12-04 04:24:00.608041	Wednesday	700	1945	138	\N	\N	\N	\N
968	2025-12-04 04:24:00.60884	2025-12-04 04:24:00.60884	Thursday	200	1000	138	\N	\N	\N	\N
969	2025-12-04 04:24:00.609591	2025-12-04 04:24:00.609591	Thursday	1030	1300	138	\N	\N	\N	\N
970	2025-12-04 04:24:00.610336	2025-12-04 04:24:00.610336	Friday	830	1915	138	\N	\N	\N	\N
971	2025-12-04 04:24:00.611169	2025-12-04 04:24:00.611169	Saturday	200	345	138	\N	\N	\N	\N
972	2025-12-04 04:24:00.611898	2025-12-04 04:24:00.611898	Saturday	600	2145	138	\N	\N	\N	\N
973	2025-12-04 04:24:00.612675	2025-12-04 04:24:00.612675	Sunday	2145	200	138	\N	\N	\N	\N
974	2025-12-04 04:24:00.618888	2025-12-04 04:24:00.618888	Tuesday	945	1815	139	\N	\N	\N	\N
975	2025-12-04 04:24:00.619672	2025-12-04 04:24:00.619672	Wednesday	1645	315	139	\N	\N	\N	\N
976	2025-12-04 04:24:00.620458	2025-12-04 04:24:00.620458	Thursday	1900	215	139	\N	\N	\N	\N
977	2025-12-04 04:24:00.621262	2025-12-04 04:24:00.621262	Friday	0	100	139	\N	\N	\N	\N
978	2025-12-04 04:24:00.622029	2025-12-04 04:24:00.622029	Friday	730	1800	139	\N	\N	\N	\N
979	2025-12-04 04:24:00.62279	2025-12-04 04:24:00.62279	Saturday	815	1700	139	\N	\N	\N	\N
980	2025-12-04 04:24:00.623568	2025-12-04 04:24:00.623568	Sunday	445	1800	139	\N	\N	\N	\N
981	2025-12-04 04:24:00.624347	2025-12-04 04:24:00.624347	Sunday	2115	2345	139	\N	\N	\N	\N
982	2025-12-04 04:24:00.636564	2025-12-04 04:24:00.636564	Monday	115	800	140	\N	\N	\N	\N
983	2025-12-04 04:24:00.63732	2025-12-04 04:24:00.63732	Monday	1045	2000	140	\N	\N	\N	\N
984	2025-12-04 04:24:00.638143	2025-12-04 04:24:00.638143	Tuesday	200	1730	140	\N	\N	\N	\N
985	2025-12-04 04:24:00.638914	2025-12-04 04:24:00.638914	Tuesday	1745	115	140	\N	\N	\N	\N
986	2025-12-04 04:24:00.639703	2025-12-04 04:24:00.639703	Thursday	930	2230	140	\N	\N	\N	\N
987	2025-12-04 04:24:00.640498	2025-12-04 04:24:00.640498	Friday	700	1730	140	\N	\N	\N	\N
988	2025-12-04 04:24:00.64133	2025-12-04 04:24:00.64133	Sunday	315	630	140	\N	\N	\N	\N
989	2025-12-04 04:24:00.642099	2025-12-04 04:24:00.642099	Sunday	1115	2230	140	\N	\N	\N	\N
990	2025-12-04 04:24:00.647934	2025-12-04 04:24:00.647934	Tuesday	730	1045	141	\N	\N	\N	\N
991	2025-12-04 04:24:00.648716	2025-12-04 04:24:00.648716	Tuesday	1445	1545	141	\N	\N	\N	\N
992	2025-12-04 04:24:00.649491	2025-12-04 04:24:00.649491	Wednesday	730	1630	141	\N	\N	\N	\N
993	2025-12-04 04:24:00.650289	2025-12-04 04:24:00.650289	Thursday	1500	230	141	\N	\N	\N	\N
994	2025-12-04 04:24:00.651101	2025-12-04 04:24:00.651101	Saturday	945	1015	141	\N	\N	\N	\N
995	2025-12-04 04:24:00.651859	2025-12-04 04:24:00.651859	Saturday	2030	2215	141	\N	\N	\N	\N
996	2025-12-04 04:24:00.652632	2025-12-04 04:24:00.652632	Sunday	1930	330	141	\N	\N	\N	\N
997	2025-12-04 04:24:00.664585	2025-12-04 04:24:00.664585	Monday	745	1930	142	\N	\N	\N	\N
998	2025-12-04 04:24:00.66541	2025-12-04 04:24:00.66541	Tuesday	630	1415	142	\N	\N	\N	\N
999	2025-12-04 04:24:00.666198	2025-12-04 04:24:00.666198	Wednesday	1545	245	142	\N	\N	\N	\N
1000	2025-12-04 04:24:00.666979	2025-12-04 04:24:00.666979	Thursday	700	1730	142	\N	\N	\N	\N
1001	2025-12-04 04:24:00.66776	2025-12-04 04:24:00.66776	Friday	145	1045	142	\N	\N	\N	\N
1002	2025-12-04 04:24:00.668481	2025-12-04 04:24:00.668481	Friday	1745	2330	142	\N	\N	\N	\N
1003	2025-12-04 04:24:00.669324	2025-12-04 04:24:00.669324	Sunday	730	1400	142	\N	\N	\N	\N
1004	2025-12-04 04:24:00.675655	2025-12-04 04:24:00.675655	Monday	515	815	143	\N	\N	\N	\N
1005	2025-12-04 04:24:00.676415	2025-12-04 04:24:00.676415	Monday	1115	2345	143	\N	\N	\N	\N
1006	2025-12-04 04:24:00.677208	2025-12-04 04:24:00.677208	Tuesday	915	1845	143	\N	\N	\N	\N
1007	2025-12-04 04:24:00.678083	2025-12-04 04:24:00.678083	Thursday	15	500	143	\N	\N	\N	\N
1008	2025-12-04 04:24:00.678837	2025-12-04 04:24:00.678837	Thursday	915	1415	143	\N	\N	\N	\N
1009	2025-12-04 04:24:00.679569	2025-12-04 04:24:00.679569	Friday	2015	215	143	\N	\N	\N	\N
1010	2025-12-04 04:24:00.680386	2025-12-04 04:24:00.680386	Saturday	1130	1630	143	\N	\N	\N	\N
1011	2025-12-04 04:24:00.681144	2025-12-04 04:24:00.681144	Saturday	1715	30	143	\N	\N	\N	\N
1012	2025-12-04 04:24:00.681875	2025-12-04 04:24:00.681875	Sunday	815	1600	143	\N	\N	\N	\N
1013	2025-12-04 04:24:00.691444	2025-12-04 04:24:00.691444	Monday	700	1600	144	\N	\N	\N	\N
1014	2025-12-04 04:24:00.692192	2025-12-04 04:24:00.692192	Tuesday	730	1415	144	\N	\N	\N	\N
1015	2025-12-04 04:24:00.692953	2025-12-04 04:24:00.692953	Wednesday	915	2200	144	\N	\N	\N	\N
1016	2025-12-04 04:24:00.693724	2025-12-04 04:24:00.693724	Friday	1415	115	144	\N	\N	\N	\N
1017	2025-12-04 04:24:00.694501	2025-12-04 04:24:00.694501	Saturday	700	1630	144	\N	\N	\N	\N
1018	2025-12-04 04:24:00.695291	2025-12-04 04:24:00.695291	Sunday	445	545	144	\N	\N	\N	\N
1019	2025-12-04 04:24:00.696013	2025-12-04 04:24:00.696013	Sunday	2000	2215	144	\N	\N	\N	\N
1020	2025-12-04 04:24:00.707839	2025-12-04 04:24:00.707839	Monday	2230	315	145	\N	\N	\N	\N
1021	2025-12-04 04:24:00.70864	2025-12-04 04:24:00.70864	Tuesday	1900	145	145	\N	\N	\N	\N
1022	2025-12-04 04:24:00.709438	2025-12-04 04:24:00.709438	Thursday	30	445	145	\N	\N	\N	\N
1023	2025-12-04 04:24:00.710216	2025-12-04 04:24:00.710216	Thursday	815	1245	145	\N	\N	\N	\N
1024	2025-12-04 04:24:00.710987	2025-12-04 04:24:00.710987	Friday	1745	145	145	\N	\N	\N	\N
1025	2025-12-04 04:24:00.711845	2025-12-04 04:24:00.711845	Saturday	845	1400	145	\N	\N	\N	\N
1026	2025-12-04 04:24:00.717609	2025-12-04 04:24:00.717609	Tuesday	400	1130	146	\N	\N	\N	\N
1027	2025-12-04 04:24:00.718371	2025-12-04 04:24:00.718371	Tuesday	2015	2300	146	\N	\N	\N	\N
1028	2025-12-04 04:24:00.719187	2025-12-04 04:24:00.719187	Wednesday	0	100	146	\N	\N	\N	\N
1029	2025-12-04 04:24:00.719911	2025-12-04 04:24:00.719911	Wednesday	500	2030	146	\N	\N	\N	\N
1030	2025-12-04 04:24:00.720666	2025-12-04 04:24:00.720666	Thursday	1515	330	146	\N	\N	\N	\N
1031	2025-12-04 04:24:00.721464	2025-12-04 04:24:00.721464	Friday	830	2400	146	\N	\N	\N	\N
1032	2025-12-04 04:24:00.722231	2025-12-04 04:24:00.722231	Saturday	2145	215	146	\N	\N	\N	\N
1033	2025-12-04 04:24:00.72304	2025-12-04 04:24:00.72304	Sunday	15	430	146	\N	\N	\N	\N
1034	2025-12-04 04:24:00.72375	2025-12-04 04:24:00.72375	Sunday	1900	2215	146	\N	\N	\N	\N
1035	2025-12-04 04:24:00.735337	2025-12-04 04:24:00.735337	Monday	945	1545	147	\N	\N	\N	\N
1036	2025-12-04 04:24:00.736115	2025-12-04 04:24:00.736115	Thursday	800	1845	147	\N	\N	\N	\N
1037	2025-12-04 04:24:00.73687	2025-12-04 04:24:00.73687	Friday	815	1445	147	\N	\N	\N	\N
1038	2025-12-04 04:24:00.7379	2025-12-04 04:24:00.7379	Saturday	1915	130	147	\N	\N	\N	\N
1039	2025-12-04 04:24:00.738708	2025-12-04 04:24:00.738708	Sunday	1200	1700	147	\N	\N	\N	\N
1040	2025-12-04 04:24:00.739477	2025-12-04 04:24:00.739477	Sunday	2145	545	147	\N	\N	\N	\N
1041	2025-12-04 04:24:00.744676	2025-12-04 04:24:00.744676	Monday	930	1715	148	\N	\N	\N	\N
1042	2025-12-04 04:24:00.745501	2025-12-04 04:24:00.745501	Tuesday	1815	315	148	\N	\N	\N	\N
1043	2025-12-04 04:24:00.746305	2025-12-04 04:24:00.746305	Wednesday	0	15	148	\N	\N	\N	\N
1044	2025-12-04 04:24:00.747012	2025-12-04 04:24:00.747012	Wednesday	515	630	148	\N	\N	\N	\N
1045	2025-12-04 04:24:00.747788	2025-12-04 04:24:00.747788	Thursday	615	2300	148	\N	\N	\N	\N
1046	2025-12-04 04:24:00.748545	2025-12-04 04:24:00.748545	Friday	2200	145	148	\N	\N	\N	\N
1047	2025-12-04 04:24:00.749306	2025-12-04 04:24:00.749306	Saturday	830	1500	148	\N	\N	\N	\N
1048	2025-12-04 04:24:00.75009	2025-12-04 04:24:00.75009	Sunday	745	1145	148	\N	\N	\N	\N
1049	2025-12-04 04:24:00.750841	2025-12-04 04:24:00.750841	Sunday	1600	2030	148	\N	\N	\N	\N
1050	2025-12-04 04:24:00.762701	2025-12-04 04:24:00.762701	Tuesday	430	530	149	\N	\N	\N	\N
1051	2025-12-04 04:24:00.763452	2025-12-04 04:24:00.763452	Tuesday	2045	2200	149	\N	\N	\N	\N
1052	2025-12-04 04:24:00.764265	2025-12-04 04:24:00.764265	Wednesday	215	330	149	\N	\N	\N	\N
1053	2025-12-04 04:24:00.765041	2025-12-04 04:24:00.765041	Wednesday	1530	1630	149	\N	\N	\N	\N
1054	2025-12-04 04:24:00.765826	2025-12-04 04:24:00.765826	Thursday	930	1915	149	\N	\N	\N	\N
1055	2025-12-04 04:24:00.766603	2025-12-04 04:24:00.766603	Friday	800	2200	149	\N	\N	\N	\N
1056	2025-12-04 04:24:00.772789	2025-12-04 04:24:00.772789	Monday	0	545	150	\N	\N	\N	\N
1057	2025-12-04 04:24:00.773533	2025-12-04 04:24:00.773533	Monday	1700	2215	150	\N	\N	\N	\N
1058	2025-12-04 04:24:00.774328	2025-12-04 04:24:00.774328	Tuesday	1530	400	150	\N	\N	\N	\N
1059	2025-12-04 04:24:00.775056	2025-12-04 04:24:00.775056	Wednesday	815	2045	150	\N	\N	\N	\N
1060	2025-12-04 04:24:00.775851	2025-12-04 04:24:00.775851	Thursday	430	1030	150	\N	\N	\N	\N
1061	2025-12-04 04:24:00.776608	2025-12-04 04:24:00.776608	Thursday	1230	1300	150	\N	\N	\N	\N
1062	2025-12-04 04:24:00.777409	2025-12-04 04:24:00.777409	Friday	0	545	150	\N	\N	\N	\N
1063	2025-12-04 04:24:00.778123	2025-12-04 04:24:00.778123	Friday	2045	2100	150	\N	\N	\N	\N
1064	2025-12-04 04:24:00.778878	2025-12-04 04:24:00.778878	Saturday	700	1700	150	\N	\N	\N	\N
1065	2025-12-04 04:24:00.779652	2025-12-04 04:24:00.779652	Sunday	45	115	150	\N	\N	\N	\N
1066	2025-12-04 04:24:00.780422	2025-12-04 04:24:00.780422	Sunday	900	1200	150	\N	\N	\N	\N
1067	2025-12-04 04:24:00.791446	2025-12-04 04:24:00.791446	Monday	715	2100	151	\N	\N	\N	\N
1068	2025-12-04 04:24:00.792251	2025-12-04 04:24:00.792251	Tuesday	645	2130	151	\N	\N	\N	\N
1069	2025-12-04 04:24:00.793014	2025-12-04 04:24:00.793014	Wednesday	900	2030	151	\N	\N	\N	\N
1070	2025-12-04 04:24:00.793762	2025-12-04 04:24:00.793762	Thursday	915	2115	151	\N	\N	\N	\N
1071	2025-12-04 04:24:00.794908	2025-12-04 04:24:00.794908	Friday	645	1600	151	\N	\N	\N	\N
1072	2025-12-04 04:24:00.796168	2025-12-04 04:24:00.796168	Saturday	815	1815	151	\N	\N	\N	\N
1073	2025-12-04 04:24:00.797112	2025-12-04 04:24:00.797112	Sunday	630	2145	151	\N	\N	\N	\N
1074	2025-12-04 04:24:00.80258	2025-12-04 04:24:00.80258	Monday	1645	2045	152	\N	\N	\N	\N
1075	2025-12-04 04:24:00.803402	2025-12-04 04:24:00.803402	Monday	2315	1230	152	\N	\N	\N	\N
1076	2025-12-04 04:24:00.804222	2025-12-04 04:24:00.804222	Tuesday	330	1345	152	\N	\N	\N	\N
1077	2025-12-04 04:24:00.805008	2025-12-04 04:24:00.805008	Tuesday	1445	2115	152	\N	\N	\N	\N
1078	2025-12-04 04:24:00.805997	2025-12-04 04:24:00.805997	Wednesday	730	2400	152	\N	\N	\N	\N
1079	2025-12-04 04:24:00.806817	2025-12-04 04:24:00.806817	Thursday	730	1615	152	\N	\N	\N	\N
1080	2025-12-04 04:24:00.807618	2025-12-04 04:24:00.807618	Thursday	1715	1815	152	\N	\N	\N	\N
1081	2025-12-04 04:24:00.808426	2025-12-04 04:24:00.808426	Friday	900	1515	152	\N	\N	\N	\N
1082	2025-12-04 04:24:00.809261	2025-12-04 04:24:00.809261	Saturday	400	830	152	\N	\N	\N	\N
1083	2025-12-04 04:24:00.81002	2025-12-04 04:24:00.81002	Saturday	1000	300	152	\N	\N	\N	\N
1084	2025-12-04 04:24:00.810811	2025-12-04 04:24:00.810811	Sunday	600	2230	152	\N	\N	\N	\N
1085	2025-12-04 04:24:00.819703	2025-12-04 04:24:00.819703	Tuesday	1430	300	153	\N	\N	\N	\N
1086	2025-12-04 04:24:00.820507	2025-12-04 04:24:00.820507	Wednesday	1000	2315	153	\N	\N	\N	\N
1087	2025-12-04 04:24:00.821266	2025-12-04 04:24:00.821266	Thursday	700	1900	153	\N	\N	\N	\N
1088	2025-12-04 04:24:00.822085	2025-12-04 04:24:00.822085	Friday	1600	2215	153	\N	\N	\N	\N
1089	2025-12-04 04:24:00.822892	2025-12-04 04:24:00.822892	Friday	2400	945	153	\N	\N	\N	\N
1090	2025-12-04 04:24:00.823728	2025-12-04 04:24:00.823728	Saturday	1645	230	153	\N	\N	\N	\N
1091	2025-12-04 04:24:00.824514	2025-12-04 04:24:00.824514	Sunday	900	2100	153	\N	\N	\N	\N
1092	2025-12-04 04:24:00.835548	2025-12-04 04:24:00.835548	Tuesday	1545	200	154	\N	\N	\N	\N
1093	2025-12-04 04:24:00.83634	2025-12-04 04:24:00.83634	Thursday	930	1615	154	\N	\N	\N	\N
1094	2025-12-04 04:24:00.837132	2025-12-04 04:24:00.837132	Friday	700	1830	154	\N	\N	\N	\N
1095	2025-12-04 04:24:00.837968	2025-12-04 04:24:00.837968	Saturday	1415	215	154	\N	\N	\N	\N
1096	2025-12-04 04:24:00.838826	2025-12-04 04:24:00.838826	Sunday	830	1615	154	\N	\N	\N	\N
1097	2025-12-04 04:24:00.844278	2025-12-04 04:24:00.844278	Monday	1400	1900	155	\N	\N	\N	\N
1098	2025-12-04 04:24:00.845081	2025-12-04 04:24:00.845081	Monday	2330	845	155	\N	\N	\N	\N
1099	2025-12-04 04:24:00.845845	2025-12-04 04:24:00.845845	Tuesday	945	2130	155	\N	\N	\N	\N
1100	2025-12-04 04:24:00.846614	2025-12-04 04:24:00.846614	Wednesday	600	2200	155	\N	\N	\N	\N
1101	2025-12-04 04:24:00.847391	2025-12-04 04:24:00.847391	Thursday	0	230	155	\N	\N	\N	\N
1102	2025-12-04 04:24:00.850211	2025-12-04 04:24:00.850211	Thursday	1330	1745	155	\N	\N	\N	\N
1103	2025-12-04 04:24:00.851128	2025-12-04 04:24:00.851128	Friday	1645	2115	155	\N	\N	\N	\N
1104	2025-12-04 04:24:00.851926	2025-12-04 04:24:00.851926	Friday	2300	1130	155	\N	\N	\N	\N
1105	2025-12-04 04:24:00.852727	2025-12-04 04:24:00.852727	Saturday	945	1930	155	\N	\N	\N	\N
1106	2025-12-04 04:24:00.853496	2025-12-04 04:24:00.853496	Sunday	630	1900	155	\N	\N	\N	\N
1107	2025-12-04 04:24:00.865621	2025-12-04 04:24:00.865621	Monday	845	1445	156	\N	\N	\N	\N
1108	2025-12-04 04:24:00.86646	2025-12-04 04:24:00.86646	Tuesday	100	715	156	\N	\N	\N	\N
1109	2025-12-04 04:24:00.86717	2025-12-04 04:24:00.86717	Tuesday	1300	1800	156	\N	\N	\N	\N
1110	2025-12-04 04:24:00.86793	2025-12-04 04:24:00.86793	Wednesday	730	2045	156	\N	\N	\N	\N
1111	2025-12-04 04:24:00.868716	2025-12-04 04:24:00.868716	Friday	1600	345	156	\N	\N	\N	\N
1112	2025-12-04 04:24:00.86947	2025-12-04 04:24:00.86947	Saturday	600	1945	156	\N	\N	\N	\N
1113	2025-12-04 04:24:00.870292	2025-12-04 04:24:00.870292	Sunday	230	700	156	\N	\N	\N	\N
1114	2025-12-04 04:24:00.871032	2025-12-04 04:24:00.871032	Sunday	1430	1800	156	\N	\N	\N	\N
1115	2025-12-04 04:24:00.87692	2025-12-04 04:24:00.87692	Monday	1930	2130	157	\N	\N	\N	\N
1116	2025-12-04 04:24:00.877877	2025-12-04 04:24:00.877877	Monday	2145	945	157	\N	\N	\N	\N
1117	2025-12-04 04:24:00.878625	2025-12-04 04:24:00.878625	Tuesday	1000	1845	157	\N	\N	\N	\N
1118	2025-12-04 04:24:00.879449	2025-12-04 04:24:00.879449	Wednesday	430	1000	157	\N	\N	\N	\N
1119	2025-12-04 04:24:00.880181	2025-12-04 04:24:00.880181	Wednesday	1745	1915	157	\N	\N	\N	\N
1120	2025-12-04 04:24:00.880947	2025-12-04 04:24:00.880947	Friday	2130	315	157	\N	\N	\N	\N
1121	2025-12-04 04:24:00.881712	2025-12-04 04:24:00.881712	Saturday	815	1630	157	\N	\N	\N	\N
1122	2025-12-04 04:24:00.882566	2025-12-04 04:24:00.882566	Sunday	1000	1200	157	\N	\N	\N	\N
1123	2025-12-04 04:24:00.883326	2025-12-04 04:24:00.883326	Sunday	1215	445	157	\N	\N	\N	\N
1124	2025-12-04 04:24:00.892462	2025-12-04 04:24:00.892462	Monday	700	1415	158	\N	\N	\N	\N
1125	2025-12-04 04:24:00.893273	2025-12-04 04:24:00.893273	Tuesday	600	2000	158	\N	\N	\N	\N
1126	2025-12-04 04:24:00.89405	2025-12-04 04:24:00.89405	Friday	900	2000	158	\N	\N	\N	\N
1127	2025-12-04 04:24:00.894832	2025-12-04 04:24:00.894832	Saturday	815	1100	158	\N	\N	\N	\N
1128	2025-12-04 04:24:00.895567	2025-12-04 04:24:00.895567	Saturday	2000	2230	158	\N	\N	\N	\N
1129	2025-12-04 04:24:00.896392	2025-12-04 04:24:00.896392	Sunday	2030	315	158	\N	\N	\N	\N
1130	2025-12-04 04:24:00.908365	2025-12-04 04:24:00.908365	Monday	645	2330	159	\N	\N	\N	\N
1131	2025-12-04 04:24:00.909216	2025-12-04 04:24:00.909216	Wednesday	715	2215	159	\N	\N	\N	\N
1132	2025-12-04 04:24:00.909981	2025-12-04 04:24:00.909981	Thursday	915	2315	159	\N	\N	\N	\N
1133	2025-12-04 04:24:00.910714	2025-12-04 04:24:00.910714	Saturday	830	2245	159	\N	\N	\N	\N
1134	2025-12-04 04:24:00.911468	2025-12-04 04:24:00.911468	Sunday	900	2315	159	\N	\N	\N	\N
1135	2025-12-04 04:24:00.917808	2025-12-04 04:24:00.917808	Monday	745	2045	160	\N	\N	\N	\N
1136	2025-12-04 04:24:00.918564	2025-12-04 04:24:00.918564	Tuesday	745	1615	160	\N	\N	\N	\N
1137	2025-12-04 04:24:00.919322	2025-12-04 04:24:00.919322	Wednesday	445	815	160	\N	\N	\N	\N
1138	2025-12-04 04:24:00.920103	2025-12-04 04:24:00.920103	Wednesday	1215	2045	160	\N	\N	\N	\N
1139	2025-12-04 04:24:00.920867	2025-12-04 04:24:00.920867	Thursday	745	2345	160	\N	\N	\N	\N
1140	2025-12-04 04:24:00.921653	2025-12-04 04:24:00.921653	Friday	1445	230	160	\N	\N	\N	\N
1141	2025-12-04 04:24:00.922494	2025-12-04 04:24:00.922494	Sunday	645	2030	160	\N	\N	\N	\N
1142	2025-12-04 04:24:00.933507	2025-12-04 04:24:00.933507	Tuesday	1215	1315	161	\N	\N	\N	\N
1143	2025-12-04 04:24:00.934289	2025-12-04 04:24:00.934289	Tuesday	1345	2245	161	\N	\N	\N	\N
1144	2025-12-04 04:24:00.935055	2025-12-04 04:24:00.935055	Wednesday	930	2130	161	\N	\N	\N	\N
1145	2025-12-04 04:24:00.935869	2025-12-04 04:24:00.935869	Thursday	345	645	161	\N	\N	\N	\N
1146	2025-12-04 04:24:00.936594	2025-12-04 04:24:00.936594	Thursday	2100	2215	161	\N	\N	\N	\N
1147	2025-12-04 04:24:00.937316	2025-12-04 04:24:00.937316	Friday	845	2045	161	\N	\N	\N	\N
1148	2025-12-04 04:24:00.938108	2025-12-04 04:24:00.938108	Saturday	145	200	161	\N	\N	\N	\N
1149	2025-12-04 04:24:00.938847	2025-12-04 04:24:00.938847	Saturday	215	1815	161	\N	\N	\N	\N
1150	2025-12-04 04:24:00.939593	2025-12-04 04:24:00.939593	Sunday	930	2000	161	\N	\N	\N	\N
1151	2025-12-04 04:24:00.945117	2025-12-04 04:24:00.945117	Tuesday	1000	1700	162	\N	\N	\N	\N
1152	2025-12-04 04:24:00.945912	2025-12-04 04:24:00.945912	Wednesday	930	1400	162	\N	\N	\N	\N
1153	2025-12-04 04:24:00.946707	2025-12-04 04:24:00.946707	Thursday	630	1930	162	\N	\N	\N	\N
1154	2025-12-04 04:24:00.947438	2025-12-04 04:24:00.947438	Friday	930	1445	162	\N	\N	\N	\N
1155	2025-12-04 04:24:00.948278	2025-12-04 04:24:00.948278	Saturday	45	145	162	\N	\N	\N	\N
1156	2025-12-04 04:24:00.949028	2025-12-04 04:24:00.949028	Saturday	200	1045	162	\N	\N	\N	\N
1157	2025-12-04 04:24:00.949847	2025-12-04 04:24:00.949847	Sunday	1800	100	162	\N	\N	\N	\N
1158	2025-12-04 04:24:00.960961	2025-12-04 04:24:00.960961	Tuesday	600	1615	163	\N	\N	\N	\N
1159	2025-12-04 04:24:00.96177	2025-12-04 04:24:00.96177	Wednesday	945	1945	163	\N	\N	\N	\N
1160	2025-12-04 04:24:00.962572	2025-12-04 04:24:00.962572	Friday	815	2145	163	\N	\N	\N	\N
1161	2025-12-04 04:24:00.963358	2025-12-04 04:24:00.963358	Saturday	945	2000	163	\N	\N	\N	\N
1162	2025-12-04 04:24:00.964099	2025-12-04 04:24:00.964099	Sunday	645	2215	163	\N	\N	\N	\N
1163	2025-12-04 04:24:00.969178	2025-12-04 04:24:00.969178	Monday	2245	200	164	\N	\N	\N	\N
1164	2025-12-04 04:24:00.970005	2025-12-04 04:24:00.970005	Tuesday	1145	1415	164	\N	\N	\N	\N
1165	2025-12-04 04:24:00.970782	2025-12-04 04:24:00.970782	Tuesday	1715	2330	164	\N	\N	\N	\N
1166	2025-12-04 04:24:00.971592	2025-12-04 04:24:00.971592	Wednesday	800	1430	164	\N	\N	\N	\N
1167	2025-12-04 04:24:00.972434	2025-12-04 04:24:00.972434	Friday	2245	330	164	\N	\N	\N	\N
1168	2025-12-04 04:24:00.97323	2025-12-04 04:24:00.97323	Saturday	600	1615	164	\N	\N	\N	\N
1169	2025-12-04 04:24:00.985122	2025-12-04 04:24:00.985122	Monday	730	2100	165	\N	\N	\N	\N
1170	2025-12-04 04:24:00.985887	2025-12-04 04:24:00.985887	Wednesday	630	2115	165	\N	\N	\N	\N
1171	2025-12-04 04:24:00.986667	2025-12-04 04:24:00.986667	Friday	1815	315	165	\N	\N	\N	\N
1172	2025-12-04 04:24:00.987476	2025-12-04 04:24:00.987476	Saturday	845	1245	165	\N	\N	\N	\N
1173	2025-12-04 04:24:00.988214	2025-12-04 04:24:00.988214	Saturday	1445	145	165	\N	\N	\N	\N
1174	2025-12-04 04:24:00.988979	2025-12-04 04:24:00.988979	Sunday	915	1500	165	\N	\N	\N	\N
1175	2025-12-04 04:24:00.994644	2025-12-04 04:24:00.994644	Monday	715	2000	166	\N	\N	\N	\N
1176	2025-12-04 04:24:00.995434	2025-12-04 04:24:00.995434	Tuesday	800	2330	166	\N	\N	\N	\N
1177	2025-12-04 04:24:00.996192	2025-12-04 04:24:00.996192	Wednesday	700	2000	166	\N	\N	\N	\N
1178	2025-12-04 04:24:00.996943	2025-12-04 04:24:00.996943	Thursday	1630	245	166	\N	\N	\N	\N
1179	2025-12-04 04:24:00.997784	2025-12-04 04:24:00.997784	Friday	115	930	166	\N	\N	\N	\N
1180	2025-12-04 04:24:00.998501	2025-12-04 04:24:00.998501	Friday	1600	1930	166	\N	\N	\N	\N
1181	2025-12-04 04:24:00.999276	2025-12-04 04:24:00.999276	Sunday	245	315	166	\N	\N	\N	\N
1182	2025-12-04 04:24:01.000002	2025-12-04 04:24:01.000002	Sunday	1745	2245	166	\N	\N	\N	\N
1183	2025-12-04 04:24:01.009233	2025-12-04 04:24:01.009233	Monday	1145	1830	167	\N	\N	\N	\N
1184	2025-12-04 04:24:01.009982	2025-12-04 04:24:01.009982	Monday	2315	600	167	\N	\N	\N	\N
1185	2025-12-04 04:24:01.010764	2025-12-04 04:24:01.010764	Tuesday	1000	2300	167	\N	\N	\N	\N
1186	2025-12-04 04:24:01.011524	2025-12-04 04:24:01.011524	Wednesday	815	2145	167	\N	\N	\N	\N
1187	2025-12-04 04:24:01.012279	2025-12-04 04:24:01.012279	Thursday	300	800	167	\N	\N	\N	\N
1188	2025-12-04 04:24:01.013195	2025-12-04 04:24:01.013195	Thursday	1030	1200	167	\N	\N	\N	\N
1189	2025-12-04 04:24:01.013941	2025-12-04 04:24:01.013941	Friday	630	1830	167	\N	\N	\N	\N
1190	2025-12-04 04:24:01.014698	2025-12-04 04:24:01.014698	Saturday	745	1715	167	\N	\N	\N	\N
1191	2025-12-04 04:24:01.015443	2025-12-04 04:24:01.015443	Sunday	845	915	167	\N	\N	\N	\N
1192	2025-12-04 04:24:01.016214	2025-12-04 04:24:01.016214	Sunday	2000	2345	167	\N	\N	\N	\N
1193	2025-12-04 04:24:01.027886	2025-12-04 04:24:01.027886	Tuesday	600	1745	168	\N	\N	\N	\N
1194	2025-12-04 04:24:01.028735	2025-12-04 04:24:01.028735	Wednesday	1100	1700	168	\N	\N	\N	\N
1195	2025-12-04 04:24:01.029465	2025-12-04 04:24:01.029465	Wednesday	2230	2345	168	\N	\N	\N	\N
1196	2025-12-04 04:24:01.030241	2025-12-04 04:24:01.030241	Thursday	1645	345	168	\N	\N	\N	\N
1197	2025-12-04 04:24:01.031027	2025-12-04 04:24:01.031027	Friday	745	1630	168	\N	\N	\N	\N
1198	2025-12-04 04:24:01.031817	2025-12-04 04:24:01.031817	Saturday	1415	230	168	\N	\N	\N	\N
1199	2025-12-04 04:24:01.032608	2025-12-04 04:24:01.032608	Sunday	630	1515	168	\N	\N	\N	\N
1200	2025-12-04 04:24:01.038279	2025-12-04 04:24:01.038279	Monday	800	2400	169	\N	\N	\N	\N
1201	2025-12-04 04:24:01.039077	2025-12-04 04:24:01.039077	Tuesday	800	2215	169	\N	\N	\N	\N
1202	2025-12-04 04:24:01.039866	2025-12-04 04:24:01.039866	Friday	715	1930	169	\N	\N	\N	\N
1203	2025-12-04 04:24:01.040643	2025-12-04 04:24:01.040643	Saturday	1300	1815	169	\N	\N	\N	\N
1204	2025-12-04 04:24:01.04138	2025-12-04 04:24:01.04138	Saturday	2030	2400	169	\N	\N	\N	\N
1205	2025-12-04 04:24:01.042127	2025-12-04 04:24:01.042127	Sunday	645	2000	169	\N	\N	\N	\N
1206	2025-12-04 04:24:01.053909	2025-12-04 04:24:01.053909	Monday	745	1545	170	\N	\N	\N	\N
1207	2025-12-04 04:24:01.054673	2025-12-04 04:24:01.054673	Monday	1615	2145	170	\N	\N	\N	\N
1208	2025-12-04 04:24:01.055428	2025-12-04 04:24:01.055428	Tuesday	1515	200	170	\N	\N	\N	\N
1209	2025-12-04 04:24:01.056229	2025-12-04 04:24:01.056229	Wednesday	845	2400	170	\N	\N	\N	\N
1210	2025-12-04 04:24:01.056957	2025-12-04 04:24:01.056957	Thursday	2145	145	170	\N	\N	\N	\N
1211	2025-12-04 04:24:01.057722	2025-12-04 04:24:01.057722	Sunday	1700	115	170	\N	\N	\N	\N
1212	2025-12-04 04:24:01.062915	2025-12-04 04:24:01.062915	Monday	615	2000	171	\N	\N	\N	\N
1213	2025-12-04 04:24:01.063753	2025-12-04 04:24:01.063753	Wednesday	315	815	171	\N	\N	\N	\N
1214	2025-12-04 04:24:01.064525	2025-12-04 04:24:01.064525	Wednesday	1530	2115	171	\N	\N	\N	\N
1215	2025-12-04 04:24:01.065291	2025-12-04 04:24:01.065291	Thursday	1730	330	171	\N	\N	\N	\N
1216	2025-12-04 04:24:01.066046	2025-12-04 04:24:01.066046	Saturday	900	2045	171	\N	\N	\N	\N
1217	2025-12-04 04:24:01.066779	2025-12-04 04:24:01.066779	Sunday	645	2200	171	\N	\N	\N	\N
1218	2025-12-04 04:24:01.075434	2025-12-04 04:24:01.075434	Monday	1130	2100	172	\N	\N	\N	\N
1219	2025-12-04 04:24:01.076174	2025-12-04 04:24:01.076174	Monday	2300	600	172	\N	\N	\N	\N
1220	2025-12-04 04:24:01.0769	2025-12-04 04:24:01.0769	Tuesday	830	1545	172	\N	\N	\N	\N
1221	2025-12-04 04:24:01.077659	2025-12-04 04:24:01.077659	Wednesday	1000	2400	172	\N	\N	\N	\N
1222	2025-12-04 04:24:01.078399	2025-12-04 04:24:01.078399	Thursday	1000	1900	172	\N	\N	\N	\N
1223	2025-12-04 04:24:01.079287	2025-12-04 04:24:01.079287	Friday	745	1430	172	\N	\N	\N	\N
1224	2025-12-04 04:24:01.080037	2025-12-04 04:24:01.080037	Friday	1615	2015	172	\N	\N	\N	\N
1225	2025-12-04 04:24:01.080828	2025-12-04 04:24:01.080828	Saturday	600	2200	172	\N	\N	\N	\N
1226	2025-12-04 04:24:01.092611	2025-12-04 04:24:01.092611	Monday	115	345	173	\N	\N	\N	\N
1227	2025-12-04 04:24:01.093428	2025-12-04 04:24:01.093428	Monday	545	1115	173	\N	\N	\N	\N
1228	2025-12-04 04:24:01.094215	2025-12-04 04:24:01.094215	Wednesday	700	1430	173	\N	\N	\N	\N
1229	2025-12-04 04:24:01.094966	2025-12-04 04:24:01.094966	Friday	2015	115	173	\N	\N	\N	\N
1230	2025-12-04 04:24:01.095712	2025-12-04 04:24:01.095712	Saturday	630	1730	173	\N	\N	\N	\N
1231	2025-12-04 04:24:01.096446	2025-12-04 04:24:01.096446	Sunday	915	1730	173	\N	\N	\N	\N
1232	2025-12-04 04:24:01.10223	2025-12-04 04:24:01.10223	Monday	845	1715	174	\N	\N	\N	\N
1233	2025-12-04 04:24:01.103004	2025-12-04 04:24:01.103004	Tuesday	715	1415	174	\N	\N	\N	\N
1234	2025-12-04 04:24:01.103819	2025-12-04 04:24:01.103819	Thursday	300	2145	174	\N	\N	\N	\N
1235	2025-12-04 04:24:01.104573	2025-12-04 04:24:01.104573	Thursday	2200	145	174	\N	\N	\N	\N
1236	2025-12-04 04:24:01.105401	2025-12-04 04:24:01.105401	Sunday	30	1130	174	\N	\N	\N	\N
1237	2025-12-04 04:24:01.106164	2025-12-04 04:24:01.106164	Sunday	1345	1800	174	\N	\N	\N	\N
1238	2025-12-04 04:24:01.115942	2025-12-04 04:24:01.115942	Tuesday	430	545	175	\N	\N	\N	\N
1239	2025-12-04 04:24:01.116726	2025-12-04 04:24:01.116726	Tuesday	1345	1930	175	\N	\N	\N	\N
1240	2025-12-04 04:24:01.117492	2025-12-04 04:24:01.117492	Friday	1000	2215	175	\N	\N	\N	\N
1241	2025-12-04 04:24:01.118279	2025-12-04 04:24:01.118279	Saturday	900	2145	175	\N	\N	\N	\N
1242	2025-12-04 04:24:01.11905	2025-12-04 04:24:01.11905	Sunday	830	1930	175	\N	\N	\N	\N
1243	2025-12-04 04:24:01.130247	2025-12-04 04:24:01.130247	Monday	745	1100	176	\N	\N	\N	\N
1244	2025-12-04 04:24:01.131012	2025-12-04 04:24:01.131012	Monday	1345	2115	176	\N	\N	\N	\N
1245	2025-12-04 04:24:01.131757	2025-12-04 04:24:01.131757	Tuesday	900	2045	176	\N	\N	\N	\N
1246	2025-12-04 04:24:01.132526	2025-12-04 04:24:01.132526	Wednesday	1630	300	176	\N	\N	\N	\N
1247	2025-12-04 04:24:01.133328	2025-12-04 04:24:01.133328	Thursday	945	2115	176	\N	\N	\N	\N
1248	2025-12-04 04:24:01.134089	2025-12-04 04:24:01.134089	Saturday	645	2245	176	\N	\N	\N	\N
1249	2025-12-04 04:24:01.134936	2025-12-04 04:24:01.134936	Sunday	2045	200	176	\N	\N	\N	\N
1250	2025-12-04 04:24:01.140002	2025-12-04 04:24:01.140002	Monday	2300	245	177	\N	\N	\N	\N
1251	2025-12-04 04:24:01.140804	2025-12-04 04:24:01.140804	Tuesday	915	1915	177	\N	\N	\N	\N
1252	2025-12-04 04:24:01.141568	2025-12-04 04:24:01.141568	Wednesday	600	1700	177	\N	\N	\N	\N
1253	2025-12-04 04:24:01.142335	2025-12-04 04:24:01.142335	Thursday	1545	100	177	\N	\N	\N	\N
1254	2025-12-04 04:24:01.14308	2025-12-04 04:24:01.14308	Friday	1000	2000	177	\N	\N	\N	\N
1255	2025-12-04 04:24:01.143895	2025-12-04 04:24:01.143895	Saturday	645	1200	177	\N	\N	\N	\N
1256	2025-12-04 04:24:01.144618	2025-12-04 04:24:01.144618	Saturday	2130	2230	177	\N	\N	\N	\N
1257	2025-12-04 04:24:01.145389	2025-12-04 04:24:01.145389	Sunday	1000	1415	177	\N	\N	\N	\N
1258	2025-12-04 04:24:01.159771	2025-12-04 04:24:01.159771	Monday	800	1600	178	\N	\N	\N	\N
1259	2025-12-04 04:24:01.160526	2025-12-04 04:24:01.160526	Tuesday	815	1745	178	\N	\N	\N	\N
1260	2025-12-04 04:24:01.161376	2025-12-04 04:24:01.161376	Wednesday	30	1130	178	\N	\N	\N	\N
1261	2025-12-04 04:24:01.162101	2025-12-04 04:24:01.162101	Wednesday	1215	1345	178	\N	\N	\N	\N
1262	2025-12-04 04:24:01.162868	2025-12-04 04:24:01.162868	Friday	945	2115	178	\N	\N	\N	\N
1263	2025-12-04 04:24:01.163632	2025-12-04 04:24:01.163632	Sunday	930	2330	178	\N	\N	\N	\N
1264	2025-12-04 04:24:01.169415	2025-12-04 04:24:01.169415	Monday	1730	345	179	\N	\N	\N	\N
1265	2025-12-04 04:24:01.170273	2025-12-04 04:24:01.170273	Tuesday	845	1700	179	\N	\N	\N	\N
1266	2025-12-04 04:24:01.171046	2025-12-04 04:24:01.171046	Thursday	730	2315	179	\N	\N	\N	\N
1267	2025-12-04 04:24:01.171839	2025-12-04 04:24:01.171839	Friday	615	1200	179	\N	\N	\N	\N
1268	2025-12-04 04:24:01.17256	2025-12-04 04:24:01.17256	Friday	1245	1530	179	\N	\N	\N	\N
1269	2025-12-04 04:24:01.173383	2025-12-04 04:24:01.173383	Sunday	1000	1400	179	\N	\N	\N	\N
1270	2025-12-04 04:24:01.182504	2025-12-04 04:24:01.182504	Monday	1115	1315	180	\N	\N	\N	\N
1271	2025-12-04 04:24:01.183251	2025-12-04 04:24:01.183251	Monday	1400	1430	180	\N	\N	\N	\N
1272	2025-12-04 04:24:01.184028	2025-12-04 04:24:01.184028	Wednesday	830	1445	180	\N	\N	\N	\N
1273	2025-12-04 04:24:01.184822	2025-12-04 04:24:01.184822	Thursday	1245	1630	180	\N	\N	\N	\N
1274	2025-12-04 04:24:01.185801	2025-12-04 04:24:01.185801	Thursday	1930	2015	180	\N	\N	\N	\N
1275	2025-12-04 04:24:01.186553	2025-12-04 04:24:01.186553	Friday	700	1745	180	\N	\N	\N	\N
1276	2025-12-04 04:24:01.187311	2025-12-04 04:24:01.187311	Saturday	700	1545	180	\N	\N	\N	\N
1277	2025-12-04 04:24:01.188031	2025-12-04 04:24:01.188031	Sunday	600	2345	180	\N	\N	\N	\N
1278	2025-12-04 04:24:01.199773	2025-12-04 04:24:01.199773	Monday	700	715	181	\N	\N	\N	\N
1279	2025-12-04 04:24:01.200496	2025-12-04 04:24:01.200496	Monday	1400	1630	181	\N	\N	\N	\N
1280	2025-12-04 04:24:01.201284	2025-12-04 04:24:01.201284	Tuesday	800	1730	181	\N	\N	\N	\N
1281	2025-12-04 04:24:01.202038	2025-12-04 04:24:01.202038	Wednesday	930	1700	181	\N	\N	\N	\N
1282	2025-12-04 04:24:01.202845	2025-12-04 04:24:01.202845	Friday	330	1145	181	\N	\N	\N	\N
1283	2025-12-04 04:24:01.203574	2025-12-04 04:24:01.203574	Friday	1415	2000	181	\N	\N	\N	\N
1284	2025-12-04 04:24:01.204339	2025-12-04 04:24:01.204339	Saturday	700	1530	181	\N	\N	\N	\N
1285	2025-12-04 04:24:01.205145	2025-12-04 04:24:01.205145	Sunday	745	1700	181	\N	\N	\N	\N
1286	2025-12-04 04:24:01.205901	2025-12-04 04:24:01.205901	Sunday	1900	2100	181	\N	\N	\N	\N
1287	2025-12-04 04:24:01.211659	2025-12-04 04:24:01.211659	Monday	715	1845	182	\N	\N	\N	\N
1288	2025-12-04 04:24:01.212414	2025-12-04 04:24:01.212414	Tuesday	630	1600	182	\N	\N	\N	\N
1289	2025-12-04 04:24:01.213188	2025-12-04 04:24:01.213188	Thursday	2100	245	182	\N	\N	\N	\N
1290	2025-12-04 04:24:01.213981	2025-12-04 04:24:01.213981	Friday	1000	1645	182	\N	\N	\N	\N
1291	2025-12-04 04:24:01.214774	2025-12-04 04:24:01.214774	Sunday	1315	1445	182	\N	\N	\N	\N
1292	2025-12-04 04:24:01.215505	2025-12-04 04:24:01.215505	Sunday	1800	230	182	\N	\N	\N	\N
1293	2025-12-04 04:24:01.227734	2025-12-04 04:24:01.227734	Tuesday	600	2345	183	\N	\N	\N	\N
1294	2025-12-04 04:24:01.228534	2025-12-04 04:24:01.228534	Thursday	800	2330	183	\N	\N	\N	\N
1295	2025-12-04 04:24:01.229458	2025-12-04 04:24:01.229458	Friday	700	1615	183	\N	\N	\N	\N
1296	2025-12-04 04:24:01.23035	2025-12-04 04:24:01.23035	Sunday	745	2245	183	\N	\N	\N	\N
1297	2025-12-04 04:24:01.236719	2025-12-04 04:24:01.236719	Monday	1000	1500	184	\N	\N	\N	\N
1298	2025-12-04 04:24:01.237529	2025-12-04 04:24:01.237529	Tuesday	2000	145	184	\N	\N	\N	\N
1299	2025-12-04 04:24:01.238253	2025-12-04 04:24:01.238253	Wednesday	900	1830	184	\N	\N	\N	\N
1300	2025-12-04 04:24:01.239023	2025-12-04 04:24:01.239023	Thursday	600	1830	184	\N	\N	\N	\N
1301	2025-12-04 04:24:01.239789	2025-12-04 04:24:01.239789	Friday	900	2130	184	\N	\N	\N	\N
1302	2025-12-04 04:24:01.240567	2025-12-04 04:24:01.240567	Saturday	1545	115	184	\N	\N	\N	\N
1303	2025-12-04 04:24:01.250098	2025-12-04 04:24:01.250098	Monday	245	700	185	\N	\N	\N	\N
1304	2025-12-04 04:24:01.250895	2025-12-04 04:24:01.250895	Monday	900	1200	185	\N	\N	\N	\N
1305	2025-12-04 04:24:01.251796	2025-12-04 04:24:01.251796	Tuesday	430	615	185	\N	\N	\N	\N
1306	2025-12-04 04:24:01.252553	2025-12-04 04:24:01.252553	Tuesday	1730	1815	185	\N	\N	\N	\N
1307	2025-12-04 04:24:01.253353	2025-12-04 04:24:01.253353	Wednesday	1600	100	185	\N	\N	\N	\N
1308	2025-12-04 04:24:01.25413	2025-12-04 04:24:01.25413	Thursday	945	1845	185	\N	\N	\N	\N
1309	2025-12-04 04:24:01.255111	2025-12-04 04:24:01.255111	Saturday	1000	1300	185	\N	\N	\N	\N
1310	2025-12-04 04:24:01.255858	2025-12-04 04:24:01.255858	Saturday	2200	700	185	\N	\N	\N	\N
1311	2025-12-04 04:24:01.256664	2025-12-04 04:24:01.256664	Sunday	430	730	185	\N	\N	\N	\N
1312	2025-12-04 04:24:01.257425	2025-12-04 04:24:01.257425	Sunday	1645	1745	185	\N	\N	\N	\N
1313	2025-12-04 04:24:01.269264	2025-12-04 04:24:01.269264	Monday	800	2330	186	\N	\N	\N	\N
1314	2025-12-04 04:24:01.270057	2025-12-04 04:24:01.270057	Tuesday	730	2030	186	\N	\N	\N	\N
1315	2025-12-04 04:24:01.270811	2025-12-04 04:24:01.270811	Wednesday	730	1430	186	\N	\N	\N	\N
1316	2025-12-04 04:24:01.271592	2025-12-04 04:24:01.271592	Thursday	945	2030	186	\N	\N	\N	\N
1317	2025-12-04 04:24:01.272411	2025-12-04 04:24:01.272411	Saturday	315	430	186	\N	\N	\N	\N
1318	2025-12-04 04:24:01.273181	2025-12-04 04:24:01.273181	Saturday	1630	1715	186	\N	\N	\N	\N
1319	2025-12-04 04:24:01.273899	2025-12-04 04:24:01.273899	Sunday	745	2000	186	\N	\N	\N	\N
1320	2025-12-04 04:24:01.280047	2025-12-04 04:24:01.280047	Monday	945	1145	187	\N	\N	\N	\N
1321	2025-12-04 04:24:01.280826	2025-12-04 04:24:01.280826	Monday	1530	600	187	\N	\N	\N	\N
1322	2025-12-04 04:24:01.281609	2025-12-04 04:24:01.281609	Wednesday	845	2130	187	\N	\N	\N	\N
1323	2025-12-04 04:24:01.282413	2025-12-04 04:24:01.282413	Thursday	630	1400	187	\N	\N	\N	\N
1324	2025-12-04 04:24:01.283158	2025-12-04 04:24:01.283158	Saturday	715	2100	187	\N	\N	\N	\N
1325	2025-12-04 04:24:01.292596	2025-12-04 04:24:01.292596	Monday	930	2030	188	\N	\N	\N	\N
1326	2025-12-04 04:24:01.293376	2025-12-04 04:24:01.293376	Tuesday	2145	200	188	\N	\N	\N	\N
1327	2025-12-04 04:24:01.294155	2025-12-04 04:24:01.294155	Wednesday	915	1500	188	\N	\N	\N	\N
1328	2025-12-04 04:24:01.294924	2025-12-04 04:24:01.294924	Thursday	2015	345	188	\N	\N	\N	\N
1329	2025-12-04 04:24:01.295659	2025-12-04 04:24:01.295659	Friday	945	1415	188	\N	\N	\N	\N
1330	2025-12-04 04:24:01.296475	2025-12-04 04:24:01.296475	Sunday	1030	1630	188	\N	\N	\N	\N
1331	2025-12-04 04:24:01.297217	2025-12-04 04:24:01.297217	Sunday	2330	45	188	\N	\N	\N	\N
1332	2025-12-04 04:24:01.30968	2025-12-04 04:24:01.30968	Monday	1415	115	189	\N	\N	\N	\N
1333	2025-12-04 04:24:01.310451	2025-12-04 04:24:01.310451	Tuesday	830	1800	189	\N	\N	\N	\N
1334	2025-12-04 04:24:01.311229	2025-12-04 04:24:01.311229	Wednesday	845	2015	189	\N	\N	\N	\N
1335	2025-12-04 04:24:01.31199	2025-12-04 04:24:01.31199	Thursday	930	2100	189	\N	\N	\N	\N
1336	2025-12-04 04:24:01.312778	2025-12-04 04:24:01.312778	Friday	130	1600	189	\N	\N	\N	\N
1337	2025-12-04 04:24:01.313526	2025-12-04 04:24:01.313526	Friday	1715	2315	189	\N	\N	\N	\N
1338	2025-12-04 04:24:01.31427	2025-12-04 04:24:01.31427	Sunday	945	1600	189	\N	\N	\N	\N
1339	2025-12-04 04:24:01.320397	2025-12-04 04:24:01.320397	Monday	2130	315	190	\N	\N	\N	\N
1340	2025-12-04 04:24:01.321229	2025-12-04 04:24:01.321229	Tuesday	200	600	190	\N	\N	\N	\N
1341	2025-12-04 04:24:01.322001	2025-12-04 04:24:01.322001	Tuesday	645	1700	190	\N	\N	\N	\N
1342	2025-12-04 04:24:01.322976	2025-12-04 04:24:01.322976	Wednesday	530	1730	190	\N	\N	\N	\N
1343	2025-12-04 04:24:01.323871	2025-12-04 04:24:01.323871	Wednesday	1830	2315	190	\N	\N	\N	\N
1344	2025-12-04 04:24:01.324697	2025-12-04 04:24:01.324697	Friday	1600	400	190	\N	\N	\N	\N
1345	2025-12-04 04:24:01.325458	2025-12-04 04:24:01.325458	Saturday	945	2300	190	\N	\N	\N	\N
1346	2025-12-04 04:24:01.326238	2025-12-04 04:24:01.326238	Sunday	1230	1615	190	\N	\N	\N	\N
1347	2025-12-04 04:24:01.326988	2025-12-04 04:24:01.326988	Sunday	1830	2045	190	\N	\N	\N	\N
1348	2025-12-04 04:24:01.33665	2025-12-04 04:24:01.33665	Monday	815	1600	191	\N	\N	\N	\N
1349	2025-12-04 04:24:01.337485	2025-12-04 04:24:01.337485	Thursday	115	415	191	\N	\N	\N	\N
1350	2025-12-04 04:24:01.338212	2025-12-04 04:24:01.338212	Thursday	1115	2315	191	\N	\N	\N	\N
1351	2025-12-04 04:24:01.338985	2025-12-04 04:24:01.338985	Friday	1445	400	191	\N	\N	\N	\N
1352	2025-12-04 04:24:01.339739	2025-12-04 04:24:01.339739	Saturday	945	1745	191	\N	\N	\N	\N
1353	2025-12-04 04:24:01.34051	2025-12-04 04:24:01.34051	Sunday	615	1315	191	\N	\N	\N	\N
1354	2025-12-04 04:24:01.341237	2025-12-04 04:24:01.341237	Sunday	1330	2045	191	\N	\N	\N	\N
1355	2025-12-04 04:24:01.352846	2025-12-04 04:24:01.352846	Wednesday	700	1245	192	\N	\N	\N	\N
1356	2025-12-04 04:24:01.353569	2025-12-04 04:24:01.353569	Wednesday	2015	130	192	\N	\N	\N	\N
1357	2025-12-04 04:24:01.354342	2025-12-04 04:24:01.354342	Thursday	2045	215	192	\N	\N	\N	\N
1358	2025-12-04 04:24:01.355098	2025-12-04 04:24:01.355098	Friday	945	2345	192	\N	\N	\N	\N
1359	2025-12-04 04:24:01.355848	2025-12-04 04:24:01.355848	Saturday	915	1715	192	\N	\N	\N	\N
1360	2025-12-04 04:24:01.356706	2025-12-04 04:24:01.356706	Sunday	745	2130	192	\N	\N	\N	\N
1361	2025-12-04 04:24:01.362879	2025-12-04 04:24:01.362879	Wednesday	915	2345	193	\N	\N	\N	\N
1362	2025-12-04 04:24:01.363642	2025-12-04 04:24:01.363642	Friday	815	2300	193	\N	\N	\N	\N
1363	2025-12-04 04:24:01.364412	2025-12-04 04:24:01.364412	Saturday	715	1515	193	\N	\N	\N	\N
1364	2025-12-04 04:24:01.365188	2025-12-04 04:24:01.365188	Sunday	930	2300	193	\N	\N	\N	\N
1365	2025-12-04 04:24:01.376976	2025-12-04 04:24:01.376976	Monday	2045	200	194	\N	\N	\N	\N
1366	2025-12-04 04:24:01.377793	2025-12-04 04:24:01.377793	Tuesday	1000	1845	194	\N	\N	\N	\N
1367	2025-12-04 04:24:01.378602	2025-12-04 04:24:01.378602	Wednesday	115	245	194	\N	\N	\N	\N
1368	2025-12-04 04:24:01.379383	2025-12-04 04:24:01.379383	Wednesday	715	830	194	\N	\N	\N	\N
1369	2025-12-04 04:24:01.380129	2025-12-04 04:24:01.380129	Thursday	2245	115	194	\N	\N	\N	\N
1370	2025-12-04 04:24:01.380893	2025-12-04 04:24:01.380893	Friday	900	1915	194	\N	\N	\N	\N
1371	2025-12-04 04:24:01.381669	2025-12-04 04:24:01.381669	Saturday	230	315	194	\N	\N	\N	\N
1372	2025-12-04 04:24:01.382431	2025-12-04 04:24:01.382431	Saturday	730	2230	194	\N	\N	\N	\N
1373	2025-12-04 04:24:01.383248	2025-12-04 04:24:01.383248	Sunday	715	1415	194	\N	\N	\N	\N
1374	2025-12-04 04:24:01.38896	2025-12-04 04:24:01.38896	Monday	515	1215	195	\N	\N	\N	\N
1375	2025-12-04 04:24:01.389741	2025-12-04 04:24:01.389741	Monday	1400	1615	195	\N	\N	\N	\N
1376	2025-12-04 04:24:01.390511	2025-12-04 04:24:01.390511	Tuesday	2245	215	195	\N	\N	\N	\N
1377	2025-12-04 04:24:01.39156	2025-12-04 04:24:01.39156	Wednesday	900	2000	195	\N	\N	\N	\N
1378	2025-12-04 04:24:01.392363	2025-12-04 04:24:01.392363	Friday	745	1430	195	\N	\N	\N	\N
1379	2025-12-04 04:24:01.393087	2025-12-04 04:24:01.393087	Friday	1945	2100	195	\N	\N	\N	\N
1380	2025-12-04 04:24:01.393873	2025-12-04 04:24:01.393873	Saturday	30	1730	195	\N	\N	\N	\N
1381	2025-12-04 04:24:01.394652	2025-12-04 04:24:01.394652	Saturday	1815	2130	195	\N	\N	\N	\N
1382	2025-12-04 04:24:01.395433	2025-12-04 04:24:01.395433	Sunday	615	2100	195	\N	\N	\N	\N
1383	2025-12-04 04:24:01.404469	2025-12-04 04:24:01.404469	Monday	730	1130	196	\N	\N	\N	\N
1384	2025-12-04 04:24:01.405233	2025-12-04 04:24:01.405233	Monday	2215	2230	196	\N	\N	\N	\N
1385	2025-12-04 04:24:01.406009	2025-12-04 04:24:01.406009	Tuesday	945	1430	196	\N	\N	\N	\N
1386	2025-12-04 04:24:01.406821	2025-12-04 04:24:01.406821	Wednesday	800	1115	196	\N	\N	\N	\N
1387	2025-12-04 04:24:01.407624	2025-12-04 04:24:01.407624	Wednesday	1145	1645	196	\N	\N	\N	\N
1388	2025-12-04 04:24:01.40841	2025-12-04 04:24:01.40841	Thursday	15	345	196	\N	\N	\N	\N
1389	2025-12-04 04:24:01.409147	2025-12-04 04:24:01.409147	Thursday	1000	1945	196	\N	\N	\N	\N
1390	2025-12-04 04:24:01.409967	2025-12-04 04:24:01.409967	Friday	900	1415	196	\N	\N	\N	\N
1391	2025-12-04 04:24:01.410733	2025-12-04 04:24:01.410733	Saturday	1730	245	196	\N	\N	\N	\N
1392	2025-12-04 04:24:01.411539	2025-12-04 04:24:01.411539	Sunday	445	1015	196	\N	\N	\N	\N
1393	2025-12-04 04:24:01.412276	2025-12-04 04:24:01.412276	Sunday	1630	1945	196	\N	\N	\N	\N
1394	2025-12-04 04:24:01.423199	2025-12-04 04:24:01.423199	Monday	600	1630	197	\N	\N	\N	\N
1395	2025-12-04 04:24:01.423996	2025-12-04 04:24:01.423996	Tuesday	400	545	197	\N	\N	\N	\N
1396	2025-12-04 04:24:01.424761	2025-12-04 04:24:01.424761	Tuesday	845	2315	197	\N	\N	\N	\N
1397	2025-12-04 04:24:01.425546	2025-12-04 04:24:01.425546	Thursday	445	645	197	\N	\N	\N	\N
1398	2025-12-04 04:24:01.426287	2025-12-04 04:24:01.426287	Thursday	1045	1700	197	\N	\N	\N	\N
1399	2025-12-04 04:24:01.427283	2025-12-04 04:24:01.427283	Saturday	45	130	197	\N	\N	\N	\N
1400	2025-12-04 04:24:01.428027	2025-12-04 04:24:01.428027	Saturday	715	1945	197	\N	\N	\N	\N
1401	2025-12-04 04:24:01.433184	2025-12-04 04:24:01.433184	Monday	1400	245	198	\N	\N	\N	\N
1402	2025-12-04 04:24:01.433958	2025-12-04 04:24:01.433958	Tuesday	615	1645	198	\N	\N	\N	\N
1403	2025-12-04 04:24:01.43476	2025-12-04 04:24:01.43476	Thursday	930	2345	198	\N	\N	\N	\N
1404	2025-12-04 04:24:01.435563	2025-12-04 04:24:01.435563	Friday	945	2015	198	\N	\N	\N	\N
1405	2025-12-04 04:24:01.436299	2025-12-04 04:24:01.436299	Saturday	915	1830	198	\N	\N	\N	\N
1406	2025-12-04 04:24:01.444717	2025-12-04 04:24:01.444717	Monday	1930	200	199	\N	\N	\N	\N
1407	2025-12-04 04:24:01.445539	2025-12-04 04:24:01.445539	Tuesday	1345	1500	199	\N	\N	\N	\N
1408	2025-12-04 04:24:01.446275	2025-12-04 04:24:01.446275	Tuesday	1545	800	199	\N	\N	\N	\N
1409	2025-12-04 04:24:01.447026	2025-12-04 04:24:01.447026	Wednesday	745	1545	199	\N	\N	\N	\N
1410	2025-12-04 04:24:01.447761	2025-12-04 04:24:01.447761	Thursday	930	1915	199	\N	\N	\N	\N
1411	2025-12-04 04:24:01.450564	2025-12-04 04:24:01.450564	Friday	945	1400	199	\N	\N	\N	\N
1412	2025-12-04 04:24:01.451429	2025-12-04 04:24:01.451429	Friday	1645	830	199	\N	\N	\N	\N
1413	2025-12-04 04:24:01.45223	2025-12-04 04:24:01.45223	Saturday	200	245	199	\N	\N	\N	\N
1414	2025-12-04 04:24:01.45298	2025-12-04 04:24:01.45298	Saturday	1700	1945	199	\N	\N	\N	\N
1415	2025-12-04 04:24:01.453785	2025-12-04 04:24:01.453785	Sunday	900	2330	199	\N	\N	\N	\N
1416	2025-12-04 04:24:01.465594	2025-12-04 04:24:01.465594	Monday	2045	330	200	\N	\N	\N	\N
1417	2025-12-04 04:24:01.466447	2025-12-04 04:24:01.466447	Tuesday	545	1330	200	\N	\N	\N	\N
1418	2025-12-04 04:24:01.467193	2025-12-04 04:24:01.467193	Tuesday	1345	1915	200	\N	\N	\N	\N
1419	2025-12-04 04:24:01.467941	2025-12-04 04:24:01.467941	Wednesday	915	2145	200	\N	\N	\N	\N
1420	2025-12-04 04:24:01.468657	2025-12-04 04:24:01.468657	Thursday	830	1415	200	\N	\N	\N	\N
1421	2025-12-04 04:24:01.469454	2025-12-04 04:24:01.469454	Friday	815	2115	200	\N	\N	\N	\N
1422	2025-12-04 04:24:01.470223	2025-12-04 04:24:01.470223	Saturday	1430	215	200	\N	\N	\N	\N
1423	2025-12-04 04:24:01.470972	2025-12-04 04:24:01.470972	Sunday	930	2315	200	\N	\N	\N	\N
1424	2025-12-04 04:24:01.476749	2025-12-04 04:24:01.476749	Monday	2245	330	201	\N	\N	\N	\N
1425	2025-12-04 04:24:01.477575	2025-12-04 04:24:01.477575	Wednesday	630	1830	201	\N	\N	\N	\N
1426	2025-12-04 04:24:01.478401	2025-12-04 04:24:01.478401	Thursday	845	2000	201	\N	\N	\N	\N
1427	2025-12-04 04:24:01.479212	2025-12-04 04:24:01.479212	Friday	600	1915	201	\N	\N	\N	\N
1428	2025-12-04 04:24:01.479938	2025-12-04 04:24:01.479938	Friday	2300	2330	201	\N	\N	\N	\N
1429	2025-12-04 04:24:01.480715	2025-12-04 04:24:01.480715	Saturday	600	1400	201	\N	\N	\N	\N
1430	2025-12-04 04:24:01.481478	2025-12-04 04:24:01.481478	Saturday	1445	1545	201	\N	\N	\N	\N
1431	2025-12-04 04:24:01.482238	2025-12-04 04:24:01.482238	Sunday	715	2400	201	\N	\N	\N	\N
1432	2025-12-04 04:24:01.494015	2025-12-04 04:24:01.494015	Wednesday	1000	1400	202	\N	\N	\N	\N
1433	2025-12-04 04:24:01.494847	2025-12-04 04:24:01.494847	Thursday	730	930	202	\N	\N	\N	\N
1434	2025-12-04 04:24:01.495607	2025-12-04 04:24:01.495607	Thursday	1800	2045	202	\N	\N	\N	\N
1435	2025-12-04 04:24:01.496557	2025-12-04 04:24:01.496557	Friday	915	1500	202	\N	\N	\N	\N
1436	2025-12-04 04:24:01.497332	2025-12-04 04:24:01.497332	Saturday	2245	400	202	\N	\N	\N	\N
1437	2025-12-04 04:24:01.498151	2025-12-04 04:24:01.498151	Sunday	415	1445	202	\N	\N	\N	\N
1438	2025-12-04 04:24:01.498877	2025-12-04 04:24:01.498877	Sunday	2115	2400	202	\N	\N	\N	\N
1439	2025-12-04 04:24:01.505077	2025-12-04 04:24:01.505077	Monday	745	1530	203	\N	\N	\N	\N
1440	2025-12-04 04:24:01.505885	2025-12-04 04:24:01.505885	Tuesday	1500	1915	203	\N	\N	\N	\N
1441	2025-12-04 04:24:01.506586	2025-12-04 04:24:01.506586	Tuesday	1945	1215	203	\N	\N	\N	\N
1442	2025-12-04 04:24:01.507363	2025-12-04 04:24:01.507363	Wednesday	600	2115	203	\N	\N	\N	\N
1443	2025-12-04 04:24:01.508161	2025-12-04 04:24:01.508161	Thursday	45	715	203	\N	\N	\N	\N
1444	2025-12-04 04:24:01.508892	2025-12-04 04:24:01.508892	Thursday	1445	1830	203	\N	\N	\N	\N
1445	2025-12-04 04:24:01.509653	2025-12-04 04:24:01.509653	Friday	645	2015	203	\N	\N	\N	\N
1446	2025-12-04 04:24:01.521804	2025-12-04 04:24:01.521804	Monday	645	2000	204	\N	\N	\N	\N
1447	2025-12-04 04:24:01.522553	2025-12-04 04:24:01.522553	Tuesday	745	1545	204	\N	\N	\N	\N
1448	2025-12-04 04:24:01.523319	2025-12-04 04:24:01.523319	Wednesday	900	1500	204	\N	\N	\N	\N
1449	2025-12-04 04:24:01.524114	2025-12-04 04:24:01.524114	Thursday	830	1915	204	\N	\N	\N	\N
1450	2025-12-04 04:24:01.524847	2025-12-04 04:24:01.524847	Friday	730	1715	204	\N	\N	\N	\N
1451	2025-12-04 04:24:01.525623	2025-12-04 04:24:01.525623	Saturday	200	900	204	\N	\N	\N	\N
1452	2025-12-04 04:24:01.526369	2025-12-04 04:24:01.526369	Saturday	1015	2045	204	\N	\N	\N	\N
1453	2025-12-04 04:24:01.52712	2025-12-04 04:24:01.52712	Sunday	800	1645	204	\N	\N	\N	\N
1454	2025-12-04 04:24:01.533465	2025-12-04 04:24:01.533465	Monday	2045	230	205	\N	\N	\N	\N
1455	2025-12-04 04:24:01.534267	2025-12-04 04:24:01.534267	Tuesday	245	600	205	\N	\N	\N	\N
1456	2025-12-04 04:24:01.534978	2025-12-04 04:24:01.534978	Tuesday	1645	2315	205	\N	\N	\N	\N
1457	2025-12-04 04:24:01.535767	2025-12-04 04:24:01.535767	Wednesday	600	1730	205	\N	\N	\N	\N
1458	2025-12-04 04:24:01.536531	2025-12-04 04:24:01.536531	Thursday	1945	130	205	\N	\N	\N	\N
1459	2025-12-04 04:24:01.537339	2025-12-04 04:24:01.537339	Friday	230	445	205	\N	\N	\N	\N
1460	2025-12-04 04:24:01.538035	2025-12-04 04:24:01.538035	Friday	700	1230	205	\N	\N	\N	\N
1461	2025-12-04 04:24:01.538786	2025-12-04 04:24:01.538786	Saturday	915	2130	205	\N	\N	\N	\N
1462	2025-12-04 04:24:01.539536	2025-12-04 04:24:01.539536	Sunday	730	2215	205	\N	\N	\N	\N
1463	2025-12-04 04:24:01.549026	2025-12-04 04:24:01.549026	Wednesday	915	2300	206	\N	\N	\N	\N
1464	2025-12-04 04:24:01.550202	2025-12-04 04:24:01.550202	Thursday	0	245	206	\N	\N	\N	\N
1465	2025-12-04 04:24:01.55104	2025-12-04 04:24:01.55104	Thursday	330	1745	206	\N	\N	\N	\N
1466	2025-12-04 04:24:01.551934	2025-12-04 04:24:01.551934	Friday	445	800	206	\N	\N	\N	\N
1467	2025-12-04 04:24:01.552753	2025-12-04 04:24:01.552753	Friday	1900	2345	206	\N	\N	\N	\N
1468	2025-12-04 04:24:01.553847	2025-12-04 04:24:01.553847	Saturday	1000	2145	206	\N	\N	\N	\N
1469	2025-12-04 04:24:01.573146	2025-12-04 04:24:01.573146	Monday	830	2330	207	\N	\N	\N	\N
1470	2025-12-04 04:24:01.574063	2025-12-04 04:24:01.574063	Tuesday	815	1400	207	\N	\N	\N	\N
1471	2025-12-04 04:24:01.574865	2025-12-04 04:24:01.574865	Wednesday	700	2230	207	\N	\N	\N	\N
1472	2025-12-04 04:24:01.575665	2025-12-04 04:24:01.575665	Thursday	645	2345	207	\N	\N	\N	\N
1473	2025-12-04 04:24:01.576473	2025-12-04 04:24:01.576473	Friday	900	1515	207	\N	\N	\N	\N
1474	2025-12-04 04:24:01.577243	2025-12-04 04:24:01.577243	Saturday	645	2100	207	\N	\N	\N	\N
1475	2025-12-04 04:24:01.578067	2025-12-04 04:24:01.578067	Sunday	845	1615	207	\N	\N	\N	\N
1476	2025-12-04 04:24:01.584349	2025-12-04 04:24:01.584349	Monday	930	1900	208	\N	\N	\N	\N
1477	2025-12-04 04:24:01.585194	2025-12-04 04:24:01.585194	Tuesday	745	2315	208	\N	\N	\N	\N
1478	2025-12-04 04:24:01.586049	2025-12-04 04:24:01.586049	Wednesday	1430	245	208	\N	\N	\N	\N
1479	2025-12-04 04:24:01.586863	2025-12-04 04:24:01.586863	Thursday	945	1715	208	\N	\N	\N	\N
1480	2025-12-04 04:24:01.587658	2025-12-04 04:24:01.587658	Saturday	800	1445	208	\N	\N	\N	\N
1481	2025-12-04 04:24:01.597225	2025-12-04 04:24:01.597225	Monday	615	1930	209	\N	\N	\N	\N
1482	2025-12-04 04:24:01.598046	2025-12-04 04:24:01.598046	Tuesday	630	2300	209	\N	\N	\N	\N
1483	2025-12-04 04:24:01.598848	2025-12-04 04:24:01.598848	Thursday	830	2130	209	\N	\N	\N	\N
1484	2025-12-04 04:24:01.599591	2025-12-04 04:24:01.599591	Friday	715	1715	209	\N	\N	\N	\N
1485	2025-12-04 04:24:01.600349	2025-12-04 04:24:01.600349	Saturday	1000	1500	209	\N	\N	\N	\N
1486	2025-12-04 04:24:01.60117	2025-12-04 04:24:01.60117	Sunday	1500	1900	209	\N	\N	\N	\N
1487	2025-12-04 04:24:01.601915	2025-12-04 04:24:01.601915	Sunday	2200	1130	209	\N	\N	\N	\N
1488	2025-12-04 04:24:01.614133	2025-12-04 04:24:01.614133	Monday	1815	400	210	\N	\N	\N	\N
1489	2025-12-04 04:24:01.614968	2025-12-04 04:24:01.614968	Tuesday	30	330	210	\N	\N	\N	\N
1490	2025-12-04 04:24:01.615737	2025-12-04 04:24:01.615737	Tuesday	1130	2400	210	\N	\N	\N	\N
1491	2025-12-04 04:24:01.616537	2025-12-04 04:24:01.616537	Wednesday	1930	2100	210	\N	\N	\N	\N
1492	2025-12-04 04:24:01.617352	2025-12-04 04:24:01.617352	Wednesday	2300	1530	210	\N	\N	\N	\N
1493	2025-12-04 04:24:01.618162	2025-12-04 04:24:01.618162	Thursday	800	2330	210	\N	\N	\N	\N
1494	2025-12-04 04:24:01.618912	2025-12-04 04:24:01.618912	Friday	730	2130	210	\N	\N	\N	\N
1495	2025-12-04 04:24:01.619668	2025-12-04 04:24:01.619668	Saturday	900	1415	210	\N	\N	\N	\N
1496	2025-12-04 04:24:01.620501	2025-12-04 04:24:01.620501	Sunday	745	1215	210	\N	\N	\N	\N
1497	2025-12-04 04:24:01.621288	2025-12-04 04:24:01.621288	Sunday	2130	445	210	\N	\N	\N	\N
1498	2025-12-04 04:24:01.627445	2025-12-04 04:24:01.627445	Monday	1545	245	211	\N	\N	\N	\N
1499	2025-12-04 04:24:01.62826	2025-12-04 04:24:01.62826	Tuesday	715	1545	211	\N	\N	\N	\N
1500	2025-12-04 04:24:01.629069	2025-12-04 04:24:01.629069	Wednesday	730	1645	211	\N	\N	\N	\N
1501	2025-12-04 04:24:01.629798	2025-12-04 04:24:01.629798	Thursday	730	2300	211	\N	\N	\N	\N
1502	2025-12-04 04:24:01.630583	2025-12-04 04:24:01.630583	Friday	845	2330	211	\N	\N	\N	\N
1503	2025-12-04 04:24:01.631386	2025-12-04 04:24:01.631386	Saturday	2000	115	211	\N	\N	\N	\N
1504	2025-12-04 04:24:01.640584	2025-12-04 04:24:01.640584	Monday	2130	230	212	\N	\N	\N	\N
1505	2025-12-04 04:24:01.641388	2025-12-04 04:24:01.641388	Tuesday	1000	2130	212	\N	\N	\N	\N
1506	2025-12-04 04:24:01.64218	2025-12-04 04:24:01.64218	Wednesday	0	1145	212	\N	\N	\N	\N
1507	2025-12-04 04:24:01.643173	2025-12-04 04:24:01.643173	Wednesday	1230	1715	212	\N	\N	\N	\N
1508	2025-12-04 04:24:01.643976	2025-12-04 04:24:01.643976	Friday	315	830	212	\N	\N	\N	\N
1509	2025-12-04 04:24:01.644704	2025-12-04 04:24:01.644704	Friday	2130	2245	212	\N	\N	\N	\N
1510	2025-12-04 04:24:01.645466	2025-12-04 04:24:01.645466	Saturday	730	2045	212	\N	\N	\N	\N
1511	2025-12-04 04:24:01.646203	2025-12-04 04:24:01.646203	Sunday	1000	1945	212	\N	\N	\N	\N
1512	2025-12-04 04:24:01.657146	2025-12-04 04:24:01.657146	Monday	2130	215	213	\N	\N	\N	\N
1513	2025-12-04 04:24:01.65793	2025-12-04 04:24:01.65793	Tuesday	715	1630	213	\N	\N	\N	\N
1514	2025-12-04 04:24:01.658701	2025-12-04 04:24:01.658701	Wednesday	730	1715	213	\N	\N	\N	\N
1515	2025-12-04 04:24:01.659421	2025-12-04 04:24:01.659421	Thursday	900	1600	213	\N	\N	\N	\N
1516	2025-12-04 04:24:01.66021	2025-12-04 04:24:01.66021	Friday	845	1430	213	\N	\N	\N	\N
1517	2025-12-04 04:24:01.660948	2025-12-04 04:24:01.660948	Saturday	700	2215	213	\N	\N	\N	\N
1518	2025-12-04 04:24:01.66173	2025-12-04 04:24:01.66173	Sunday	615	1900	213	\N	\N	\N	\N
1519	2025-12-04 04:24:01.666982	2025-12-04 04:24:01.666982	Monday	815	900	214	\N	\N	\N	\N
1520	2025-12-04 04:24:01.667786	2025-12-04 04:24:01.667786	Monday	945	1130	214	\N	\N	\N	\N
1521	2025-12-04 04:24:01.668563	2025-12-04 04:24:01.668563	Tuesday	830	1430	214	\N	\N	\N	\N
1522	2025-12-04 04:24:01.66943	2025-12-04 04:24:01.66943	Wednesday	645	1230	214	\N	\N	\N	\N
1523	2025-12-04 04:24:01.67017	2025-12-04 04:24:01.67017	Wednesday	2030	2345	214	\N	\N	\N	\N
1524	2025-12-04 04:24:01.67097	2025-12-04 04:24:01.67097	Thursday	800	2030	214	\N	\N	\N	\N
1525	2025-12-04 04:24:01.671741	2025-12-04 04:24:01.671741	Friday	1415	130	214	\N	\N	\N	\N
1526	2025-12-04 04:24:01.672501	2025-12-04 04:24:01.672501	Saturday	645	2000	214	\N	\N	\N	\N
1527	2025-12-04 04:24:01.673252	2025-12-04 04:24:01.673252	Sunday	700	2000	214	\N	\N	\N	\N
1528	2025-12-04 04:24:01.68478	2025-12-04 04:24:01.68478	Monday	745	1515	215	\N	\N	\N	\N
1529	2025-12-04 04:24:01.68559	2025-12-04 04:24:01.68559	Tuesday	1945	345	215	\N	\N	\N	\N
1530	2025-12-04 04:24:01.6864	2025-12-04 04:24:01.6864	Thursday	745	2100	215	\N	\N	\N	\N
1531	2025-12-04 04:24:01.687185	2025-12-04 04:24:01.687185	Friday	1530	400	215	\N	\N	\N	\N
1532	2025-12-04 04:24:01.687942	2025-12-04 04:24:01.687942	Saturday	730	1600	215	\N	\N	\N	\N
1533	2025-12-04 04:24:01.688743	2025-12-04 04:24:01.688743	Sunday	730	2315	215	\N	\N	\N	\N
1534	2025-12-04 04:24:01.693774	2025-12-04 04:24:01.693774	Monday	745	1530	216	\N	\N	\N	\N
1535	2025-12-04 04:24:01.694573	2025-12-04 04:24:01.694573	Tuesday	115	300	216	\N	\N	\N	\N
1536	2025-12-04 04:24:01.695294	2025-12-04 04:24:01.695294	Tuesday	545	1730	216	\N	\N	\N	\N
1537	2025-12-04 04:24:01.696064	2025-12-04 04:24:01.696064	Wednesday	345	445	216	\N	\N	\N	\N
1538	2025-12-04 04:24:01.696819	2025-12-04 04:24:01.696819	Wednesday	945	2200	216	\N	\N	\N	\N
1539	2025-12-04 04:24:01.697578	2025-12-04 04:24:01.697578	Thursday	830	1445	216	\N	\N	\N	\N
1540	2025-12-04 04:24:01.698431	2025-12-04 04:24:01.698431	Sunday	1045	1115	216	\N	\N	\N	\N
1541	2025-12-04 04:24:01.699149	2025-12-04 04:24:01.699149	Sunday	1615	1800	216	\N	\N	\N	\N
1542	2025-12-04 04:24:01.711145	2025-12-04 04:24:01.711145	Monday	1645	115	217	\N	\N	\N	\N
1543	2025-12-04 04:24:01.711929	2025-12-04 04:24:01.711929	Tuesday	1730	315	217	\N	\N	\N	\N
1544	2025-12-04 04:24:01.712793	2025-12-04 04:24:01.712793	Wednesday	830	2045	217	\N	\N	\N	\N
1545	2025-12-04 04:24:01.713533	2025-12-04 04:24:01.713533	Thursday	700	1415	217	\N	\N	\N	\N
1546	2025-12-04 04:24:01.714289	2025-12-04 04:24:01.714289	Friday	845	1600	217	\N	\N	\N	\N
1547	2025-12-04 04:24:01.715033	2025-12-04 04:24:01.715033	Saturday	845	2100	217	\N	\N	\N	\N
1548	2025-12-04 04:24:01.715786	2025-12-04 04:24:01.715786	Sunday	1745	400	217	\N	\N	\N	\N
1549	2025-12-04 04:24:01.721934	2025-12-04 04:24:01.721934	Monday	0	200	218	\N	\N	\N	\N
1550	2025-12-04 04:24:01.722688	2025-12-04 04:24:01.722688	Monday	1745	2245	218	\N	\N	\N	\N
1551	2025-12-04 04:24:01.72345	2025-12-04 04:24:01.72345	Wednesday	830	2330	218	\N	\N	\N	\N
1552	2025-12-04 04:24:01.724227	2025-12-04 04:24:01.724227	Thursday	915	2345	218	\N	\N	\N	\N
1553	2025-12-04 04:24:01.725012	2025-12-04 04:24:01.725012	Friday	1500	345	218	\N	\N	\N	\N
1554	2025-12-04 04:24:01.725777	2025-12-04 04:24:01.725777	Saturday	700	1915	218	\N	\N	\N	\N
1555	2025-12-04 04:24:01.726511	2025-12-04 04:24:01.726511	Sunday	715	2215	218	\N	\N	\N	\N
1556	2025-12-04 04:24:01.738445	2025-12-04 04:24:01.738445	Monday	800	1000	219	\N	\N	\N	\N
1557	2025-12-04 04:24:01.739233	2025-12-04 04:24:01.739233	Monday	1500	1530	219	\N	\N	\N	\N
1558	2025-12-04 04:24:01.740024	2025-12-04 04:24:01.740024	Tuesday	915	2200	219	\N	\N	\N	\N
1559	2025-12-04 04:24:01.740812	2025-12-04 04:24:01.740812	Wednesday	115	615	219	\N	\N	\N	\N
1560	2025-12-04 04:24:01.741557	2025-12-04 04:24:01.741557	Wednesday	730	2400	219	\N	\N	\N	\N
1561	2025-12-04 04:24:01.742349	2025-12-04 04:24:01.742349	Friday	215	530	219	\N	\N	\N	\N
1562	2025-12-04 04:24:01.743082	2025-12-04 04:24:01.743082	Friday	1600	1900	219	\N	\N	\N	\N
1563	2025-12-04 04:24:01.744013	2025-12-04 04:24:01.744013	Saturday	900	2200	219	\N	\N	\N	\N
1564	2025-12-04 04:24:01.744806	2025-12-04 04:24:01.744806	Sunday	700	1600	219	\N	\N	\N	\N
1565	2025-12-04 04:24:01.75092	2025-12-04 04:24:01.75092	Wednesday	945	1700	220	\N	\N	\N	\N
1566	2025-12-04 04:24:01.751682	2025-12-04 04:24:01.751682	Thursday	700	2000	220	\N	\N	\N	\N
1567	2025-12-04 04:24:01.75245	2025-12-04 04:24:01.75245	Friday	1830	145	220	\N	\N	\N	\N
1568	2025-12-04 04:24:01.753201	2025-12-04 04:24:01.753201	Sunday	1630	400	220	\N	\N	\N	\N
1569	2025-12-04 04:24:01.765214	2025-12-04 04:24:01.765214	Monday	730	1530	221	\N	\N	\N	\N
1570	2025-12-04 04:24:01.766086	2025-12-04 04:24:01.766086	Tuesday	915	2045	221	\N	\N	\N	\N
1571	2025-12-04 04:24:01.766914	2025-12-04 04:24:01.766914	Wednesday	630	1845	221	\N	\N	\N	\N
1572	2025-12-04 04:24:01.767666	2025-12-04 04:24:01.767666	Thursday	915	1515	221	\N	\N	\N	\N
1573	2025-12-04 04:24:01.768489	2025-12-04 04:24:01.768489	Saturday	1830	145	221	\N	\N	\N	\N
1574	2025-12-04 04:24:01.769306	2025-12-04 04:24:01.769306	Sunday	915	2130	221	\N	\N	\N	\N
1575	2025-12-04 04:24:01.781452	2025-12-04 04:24:01.781452	Monday	615	1645	222	\N	\N	\N	\N
1576	2025-12-04 04:24:01.782212	2025-12-04 04:24:01.782212	Tuesday	930	2000	222	\N	\N	\N	\N
1577	2025-12-04 04:24:01.782942	2025-12-04 04:24:01.782942	Wednesday	830	2130	222	\N	\N	\N	\N
1578	2025-12-04 04:24:01.783738	2025-12-04 04:24:01.783738	Thursday	315	1430	222	\N	\N	\N	\N
1579	2025-12-04 04:24:01.78449	2025-12-04 04:24:01.78449	Thursday	2315	2400	222	\N	\N	\N	\N
1580	2025-12-04 04:24:01.785252	2025-12-04 04:24:01.785252	Friday	1945	200	222	\N	\N	\N	\N
1581	2025-12-04 04:24:01.786019	2025-12-04 04:24:01.786019	Saturday	745	1030	222	\N	\N	\N	\N
1582	2025-12-04 04:24:01.786773	2025-12-04 04:24:01.786773	Saturday	1615	630	222	\N	\N	\N	\N
1583	2025-12-04 04:24:01.787503	2025-12-04 04:24:01.787503	Sunday	1530	100	222	\N	\N	\N	\N
1584	2025-12-04 04:24:01.793849	2025-12-04 04:24:01.793849	Monday	545	900	223	\N	\N	\N	\N
1585	2025-12-04 04:24:01.794609	2025-12-04 04:24:01.794609	Monday	2230	2400	223	\N	\N	\N	\N
1586	2025-12-04 04:24:01.7954	2025-12-04 04:24:01.7954	Tuesday	945	1945	223	\N	\N	\N	\N
1587	2025-12-04 04:24:01.796141	2025-12-04 04:24:01.796141	Thursday	915	2300	223	\N	\N	\N	\N
1588	2025-12-04 04:24:01.796924	2025-12-04 04:24:01.796924	Saturday	645	1745	223	\N	\N	\N	\N
1589	2025-12-04 04:24:01.797687	2025-12-04 04:24:01.797687	Saturday	1915	2045	223	\N	\N	\N	\N
1590	2025-12-04 04:24:01.798465	2025-12-04 04:24:01.798465	Sunday	45	830	223	\N	\N	\N	\N
1591	2025-12-04 04:24:01.7992	2025-12-04 04:24:01.7992	Sunday	1145	1830	223	\N	\N	\N	\N
1592	2025-12-04 04:24:01.811105	2025-12-04 04:24:01.811105	Monday	2015	200	224	\N	\N	\N	\N
1593	2025-12-04 04:24:01.811883	2025-12-04 04:24:01.811883	Wednesday	1000	1800	224	\N	\N	\N	\N
1594	2025-12-04 04:24:01.812656	2025-12-04 04:24:01.812656	Thursday	730	2245	224	\N	\N	\N	\N
1595	2025-12-04 04:24:01.813391	2025-12-04 04:24:01.813391	Friday	300	415	224	\N	\N	\N	\N
1596	2025-12-04 04:24:01.814381	2025-12-04 04:24:01.814381	Friday	430	2330	224	\N	\N	\N	\N
1597	2025-12-04 04:24:01.815093	2025-12-04 04:24:01.815093	Saturday	830	1630	224	\N	\N	\N	\N
1598	2025-12-04 04:24:01.815834	2025-12-04 04:24:01.815834	Sunday	645	1815	224	\N	\N	\N	\N
1599	2025-12-04 04:24:01.822044	2025-12-04 04:24:01.822044	Monday	700	1915	225	\N	\N	\N	\N
1600	2025-12-04 04:24:01.822805	2025-12-04 04:24:01.822805	Tuesday	1815	230	225	\N	\N	\N	\N
1601	2025-12-04 04:24:01.82355	2025-12-04 04:24:01.82355	Thursday	615	1845	225	\N	\N	\N	\N
1602	2025-12-04 04:24:01.824452	2025-12-04 04:24:01.824452	Friday	1300	2130	225	\N	\N	\N	\N
1603	2025-12-04 04:24:01.825207	2025-12-04 04:24:01.825207	Friday	2245	2300	225	\N	\N	\N	\N
1604	2025-12-04 04:24:01.825954	2025-12-04 04:24:01.825954	Saturday	815	2230	225	\N	\N	\N	\N
1605	2025-12-04 04:24:01.826759	2025-12-04 04:24:01.826759	Sunday	915	2345	225	\N	\N	\N	\N
1606	2025-12-04 04:24:01.837662	2025-12-04 04:24:01.837662	Monday	2100	130	226	\N	\N	\N	\N
1607	2025-12-04 04:24:01.838438	2025-12-04 04:24:01.838438	Tuesday	2030	115	226	\N	\N	\N	\N
1608	2025-12-04 04:24:01.839219	2025-12-04 04:24:01.839219	Wednesday	845	2230	226	\N	\N	\N	\N
1609	2025-12-04 04:24:01.839985	2025-12-04 04:24:01.839985	Thursday	830	1745	226	\N	\N	\N	\N
1610	2025-12-04 04:24:01.840791	2025-12-04 04:24:01.840791	Sunday	1630	1930	226	\N	\N	\N	\N
1611	2025-12-04 04:24:01.841507	2025-12-04 04:24:01.841507	Sunday	2130	2300	226	\N	\N	\N	\N
1612	2025-12-04 04:24:01.846655	2025-12-04 04:24:01.846655	Monday	645	1815	227	\N	\N	\N	\N
1613	2025-12-04 04:24:01.847454	2025-12-04 04:24:01.847454	Thursday	1000	1915	227	\N	\N	\N	\N
1614	2025-12-04 04:24:01.848413	2025-12-04 04:24:01.848413	Friday	745	1830	227	\N	\N	\N	\N
1615	2025-12-04 04:24:01.849176	2025-12-04 04:24:01.849176	Saturday	700	1930	227	\N	\N	\N	\N
1616	2025-12-04 04:24:01.849943	2025-12-04 04:24:01.849943	Sunday	1000	1830	227	\N	\N	\N	\N
1617	2025-12-04 04:24:01.861321	2025-12-04 04:24:01.861321	Monday	745	2045	228	\N	\N	\N	\N
1618	2025-12-04 04:24:01.862084	2025-12-04 04:24:01.862084	Tuesday	630	2315	228	\N	\N	\N	\N
1619	2025-12-04 04:24:01.862858	2025-12-04 04:24:01.862858	Wednesday	600	1630	228	\N	\N	\N	\N
1620	2025-12-04 04:24:01.86367	2025-12-04 04:24:01.86367	Thursday	130	800	228	\N	\N	\N	\N
1621	2025-12-04 04:24:01.864477	2025-12-04 04:24:01.864477	Thursday	2030	2315	228	\N	\N	\N	\N
1622	2025-12-04 04:24:01.865243	2025-12-04 04:24:01.865243	Friday	745	1545	228	\N	\N	\N	\N
1623	2025-12-04 04:24:01.866012	2025-12-04 04:24:01.866012	Saturday	1000	1930	228	\N	\N	\N	\N
1624	2025-12-04 04:24:01.866799	2025-12-04 04:24:01.866799	Sunday	2000	300	228	\N	\N	\N	\N
1625	2025-12-04 04:24:01.871951	2025-12-04 04:24:01.871951	Monday	200	1200	229	\N	\N	\N	\N
1626	2025-12-04 04:24:01.872737	2025-12-04 04:24:01.872737	Monday	1630	1730	229	\N	\N	\N	\N
1627	2025-12-04 04:24:01.873613	2025-12-04 04:24:01.873613	Tuesday	1800	400	229	\N	\N	\N	\N
1628	2025-12-04 04:24:01.87443	2025-12-04 04:24:01.87443	Wednesday	315	1015	229	\N	\N	\N	\N
1629	2025-12-04 04:24:01.875181	2025-12-04 04:24:01.875181	Wednesday	1415	2400	229	\N	\N	\N	\N
1630	2025-12-04 04:24:01.875923	2025-12-04 04:24:01.875923	Thursday	845	1445	229	\N	\N	\N	\N
1631	2025-12-04 04:24:01.876719	2025-12-04 04:24:01.876719	Friday	615	1715	229	\N	\N	\N	\N
1632	2025-12-04 04:24:01.877463	2025-12-04 04:24:01.877463	Saturday	945	1700	229	\N	\N	\N	\N
1633	2025-12-04 04:24:01.878266	2025-12-04 04:24:01.878266	Sunday	0	1200	229	\N	\N	\N	\N
1634	2025-12-04 04:24:01.879001	2025-12-04 04:24:01.879001	Sunday	1800	2045	229	\N	\N	\N	\N
1635	2025-12-04 04:24:01.89141	2025-12-04 04:24:01.89141	Monday	630	1400	230	\N	\N	\N	\N
1636	2025-12-04 04:24:01.892231	2025-12-04 04:24:01.892231	Tuesday	915	2200	230	\N	\N	\N	\N
1637	2025-12-04 04:24:01.892972	2025-12-04 04:24:01.892972	Wednesday	815	1800	230	\N	\N	\N	\N
1638	2025-12-04 04:24:01.89375	2025-12-04 04:24:01.89375	Thursday	0	300	230	\N	\N	\N	\N
1639	2025-12-04 04:24:01.894475	2025-12-04 04:24:01.894475	Thursday	1530	1830	230	\N	\N	\N	\N
1640	2025-12-04 04:24:01.89526	2025-12-04 04:24:01.89526	Sunday	645	2030	230	\N	\N	\N	\N
1641	2025-12-04 04:24:01.90158	2025-12-04 04:24:01.90158	Tuesday	815	1430	231	\N	\N	\N	\N
1642	2025-12-04 04:24:01.902383	2025-12-04 04:24:01.902383	Wednesday	715	1830	231	\N	\N	\N	\N
1643	2025-12-04 04:24:01.903228	2025-12-04 04:24:01.903228	Thursday	730	1100	231	\N	\N	\N	\N
1644	2025-12-04 04:24:01.903966	2025-12-04 04:24:01.903966	Thursday	1330	2330	231	\N	\N	\N	\N
1645	2025-12-04 04:24:01.90471	2025-12-04 04:24:01.90471	Friday	930	1445	231	\N	\N	\N	\N
1646	2025-12-04 04:24:01.905475	2025-12-04 04:24:01.905475	Saturday	600	2300	231	\N	\N	\N	\N
1647	2025-12-04 04:24:01.906281	2025-12-04 04:24:01.906281	Sunday	945	1915	231	\N	\N	\N	\N
1648	2025-12-04 04:24:01.915689	2025-12-04 04:24:01.915689	Monday	715	1115	232	\N	\N	\N	\N
1649	2025-12-04 04:24:01.916615	2025-12-04 04:24:01.916615	Monday	1700	545	232	\N	\N	\N	\N
1650	2025-12-04 04:24:01.91736	2025-12-04 04:24:01.91736	Tuesday	715	2015	232	\N	\N	\N	\N
1651	2025-12-04 04:24:01.918276	2025-12-04 04:24:01.918276	Wednesday	245	515	232	\N	\N	\N	\N
1652	2025-12-04 04:24:01.91904	2025-12-04 04:24:01.91904	Wednesday	1300	1445	232	\N	\N	\N	\N
1653	2025-12-04 04:24:01.919795	2025-12-04 04:24:01.919795	Thursday	845	1445	232	\N	\N	\N	\N
1654	2025-12-04 04:24:01.920541	2025-12-04 04:24:01.920541	Saturday	930	1915	232	\N	\N	\N	\N
1655	2025-12-04 04:24:01.921289	2025-12-04 04:24:01.921289	Sunday	1415	330	232	\N	\N	\N	\N
1656	2025-12-04 04:24:01.932353	2025-12-04 04:24:01.932353	Monday	900	1530	233	\N	\N	\N	\N
1657	2025-12-04 04:24:01.93313	2025-12-04 04:24:01.93313	Tuesday	730	1915	233	\N	\N	\N	\N
1658	2025-12-04 04:24:01.933904	2025-12-04 04:24:01.933904	Wednesday	330	1245	233	\N	\N	\N	\N
1659	2025-12-04 04:24:01.93466	2025-12-04 04:24:01.93466	Wednesday	1330	1630	233	\N	\N	\N	\N
1660	2025-12-04 04:24:01.935415	2025-12-04 04:24:01.935415	Thursday	830	2315	233	\N	\N	\N	\N
1661	2025-12-04 04:24:01.936289	2025-12-04 04:24:01.936289	Friday	600	1800	233	\N	\N	\N	\N
1662	2025-12-04 04:24:01.937051	2025-12-04 04:24:01.937051	Saturday	945	1945	233	\N	\N	\N	\N
1663	2025-12-04 04:24:01.937806	2025-12-04 04:24:01.937806	Sunday	845	1715	233	\N	\N	\N	\N
1664	2025-12-04 04:24:01.943036	2025-12-04 04:24:01.943036	Monday	45	400	234	\N	\N	\N	\N
1665	2025-12-04 04:24:01.943869	2025-12-04 04:24:01.943869	Monday	830	1245	234	\N	\N	\N	\N
1666	2025-12-04 04:24:01.944677	2025-12-04 04:24:01.944677	Tuesday	915	2400	234	\N	\N	\N	\N
1667	2025-12-04 04:24:01.945462	2025-12-04 04:24:01.945462	Wednesday	630	1530	234	\N	\N	\N	\N
1668	2025-12-04 04:24:01.946185	2025-12-04 04:24:01.946185	Thursday	815	1830	234	\N	\N	\N	\N
1669	2025-12-04 04:24:01.946968	2025-12-04 04:24:01.946968	Friday	315	645	234	\N	\N	\N	\N
1670	2025-12-04 04:24:01.947959	2025-12-04 04:24:01.947959	Friday	1700	300	234	\N	\N	\N	\N
1671	2025-12-04 04:24:01.948741	2025-12-04 04:24:01.948741	Saturday	800	1815	234	\N	\N	\N	\N
1672	2025-12-04 04:24:01.957109	2025-12-04 04:24:01.957109	Monday	345	530	235	\N	\N	\N	\N
1673	2025-12-04 04:24:01.957831	2025-12-04 04:24:01.957831	Monday	1300	1530	235	\N	\N	\N	\N
1674	2025-12-04 04:24:01.958601	2025-12-04 04:24:01.958601	Tuesday	915	1915	235	\N	\N	\N	\N
1675	2025-12-04 04:24:01.959418	2025-12-04 04:24:01.959418	Wednesday	730	2345	235	\N	\N	\N	\N
1676	2025-12-04 04:24:01.960193	2025-12-04 04:24:01.960193	Thursday	1000	1530	235	\N	\N	\N	\N
1677	2025-12-04 04:24:01.960942	2025-12-04 04:24:01.960942	Saturday	100	315	235	\N	\N	\N	\N
1678	2025-12-04 04:24:01.96164	2025-12-04 04:24:01.96164	Saturday	430	845	235	\N	\N	\N	\N
1679	2025-12-04 04:24:01.962428	2025-12-04 04:24:01.962428	Sunday	100	645	235	\N	\N	\N	\N
1680	2025-12-04 04:24:01.963147	2025-12-04 04:24:01.963147	Sunday	730	2230	235	\N	\N	\N	\N
1681	2025-12-04 04:24:01.975835	2025-12-04 04:24:01.975835	Monday	400	715	236	\N	\N	\N	\N
1682	2025-12-04 04:24:01.976742	2025-12-04 04:24:01.976742	Monday	1730	2200	236	\N	\N	\N	\N
1683	2025-12-04 04:24:01.977617	2025-12-04 04:24:01.977617	Wednesday	800	2245	236	\N	\N	\N	\N
1684	2025-12-04 04:24:01.978559	2025-12-04 04:24:01.978559	Thursday	1515	330	236	\N	\N	\N	\N
1685	2025-12-04 04:24:01.979539	2025-12-04 04:24:01.979539	Friday	1345	1945	236	\N	\N	\N	\N
1686	2025-12-04 04:24:01.980361	2025-12-04 04:24:01.980361	Friday	2115	2130	236	\N	\N	\N	\N
1687	2025-12-04 04:24:01.98116	2025-12-04 04:24:01.98116	Saturday	700	1745	236	\N	\N	\N	\N
1688	2025-12-04 04:24:01.981988	2025-12-04 04:24:01.981988	Sunday	1515	130	236	\N	\N	\N	\N
1689	2025-12-04 04:24:01.988446	2025-12-04 04:24:01.988446	Monday	1515	300	237	\N	\N	\N	\N
1690	2025-12-04 04:24:01.989331	2025-12-04 04:24:01.989331	Tuesday	330	645	237	\N	\N	\N	\N
1691	2025-12-04 04:24:01.99007	2025-12-04 04:24:01.99007	Tuesday	1145	1645	237	\N	\N	\N	\N
1692	2025-12-04 04:24:01.990842	2025-12-04 04:24:01.990842	Wednesday	900	1400	237	\N	\N	\N	\N
1693	2025-12-04 04:24:01.99173	2025-12-04 04:24:01.99173	Friday	0	1015	237	\N	\N	\N	\N
1694	2025-12-04 04:24:01.992505	2025-12-04 04:24:01.992505	Friday	1145	1445	237	\N	\N	\N	\N
1695	2025-12-04 04:24:01.993284	2025-12-04 04:24:01.993284	Saturday	700	1715	237	\N	\N	\N	\N
1696	2025-12-04 04:24:01.99408	2025-12-04 04:24:01.99408	Sunday	830	1945	237	\N	\N	\N	\N
1697	2025-12-04 04:24:02.003144	2025-12-04 04:24:02.003144	Tuesday	900	1545	238	\N	\N	\N	\N
1698	2025-12-04 04:24:02.004035	2025-12-04 04:24:02.004035	Wednesday	0	600	238	\N	\N	\N	\N
1699	2025-12-04 04:24:02.004772	2025-12-04 04:24:02.004772	Wednesday	1230	1800	238	\N	\N	\N	\N
1700	2025-12-04 04:24:02.005509	2025-12-04 04:24:02.005509	Thursday	900	1930	238	\N	\N	\N	\N
1701	2025-12-04 04:24:02.006321	2025-12-04 04:24:02.006321	Friday	430	500	238	\N	\N	\N	\N
1702	2025-12-04 04:24:02.007104	2025-12-04 04:24:02.007104	Friday	1145	1530	238	\N	\N	\N	\N
1703	2025-12-04 04:24:02.007861	2025-12-04 04:24:02.007861	Sunday	630	2345	238	\N	\N	\N	\N
1704	2025-12-04 04:24:02.020306	2025-12-04 04:24:02.020306	Monday	815	2330	239	\N	\N	\N	\N
1705	2025-12-04 04:24:02.021093	2025-12-04 04:24:02.021093	Wednesday	715	2200	239	\N	\N	\N	\N
1706	2025-12-04 04:24:02.021868	2025-12-04 04:24:02.021868	Friday	600	1445	239	\N	\N	\N	\N
1707	2025-12-04 04:24:02.022589	2025-12-04 04:24:02.022589	Saturday	715	1900	239	\N	\N	\N	\N
1708	2025-12-04 04:24:02.028808	2025-12-04 04:24:02.028808	Tuesday	715	1845	240	\N	\N	\N	\N
1709	2025-12-04 04:24:02.029612	2025-12-04 04:24:02.029612	Thursday	930	1930	240	\N	\N	\N	\N
1710	2025-12-04 04:24:02.030427	2025-12-04 04:24:02.030427	Friday	115	715	240	\N	\N	\N	\N
1711	2025-12-04 04:24:02.031168	2025-12-04 04:24:02.031168	Friday	1430	2345	240	\N	\N	\N	\N
1712	2025-12-04 04:24:02.031891	2025-12-04 04:24:02.031891	Saturday	945	2000	240	\N	\N	\N	\N
1713	2025-12-04 04:24:02.032694	2025-12-04 04:24:02.032694	Sunday	1000	2400	240	\N	\N	\N	\N
1714	2025-12-04 04:24:02.044529	2025-12-04 04:24:02.044529	Monday	1915	315	241	\N	\N	\N	\N
1715	2025-12-04 04:24:02.045289	2025-12-04 04:24:02.045289	Wednesday	900	1745	241	\N	\N	\N	\N
1716	2025-12-04 04:24:02.046025	2025-12-04 04:24:02.046025	Thursday	900	1915	241	\N	\N	\N	\N
1717	2025-12-04 04:24:02.046797	2025-12-04 04:24:02.046797	Friday	645	1945	241	\N	\N	\N	\N
1718	2025-12-04 04:24:02.047532	2025-12-04 04:24:02.047532	Saturday	945	2200	241	\N	\N	\N	\N
1719	2025-12-04 04:24:02.053702	2025-12-04 04:24:02.053702	Monday	100	815	242	\N	\N	\N	\N
1720	2025-12-04 04:24:02.056635	2025-12-04 04:24:02.056635	Monday	945	1000	242	\N	\N	\N	\N
1721	2025-12-04 04:24:02.057494	2025-12-04 04:24:02.057494	Tuesday	800	1900	242	\N	\N	\N	\N
1722	2025-12-04 04:24:02.05824	2025-12-04 04:24:02.05824	Wednesday	645	2215	242	\N	\N	\N	\N
1723	2025-12-04 04:24:02.058999	2025-12-04 04:24:02.058999	Friday	1000	1915	242	\N	\N	\N	\N
1724	2025-12-04 04:24:02.059779	2025-12-04 04:24:02.059779	Sunday	2300	300	242	\N	\N	\N	\N
1725	2025-12-04 04:24:02.069109	2025-12-04 04:24:02.069109	Monday	715	1430	243	\N	\N	\N	\N
1726	2025-12-04 04:24:02.069856	2025-12-04 04:24:02.069856	Tuesday	945	2315	243	\N	\N	\N	\N
1727	2025-12-04 04:24:02.070667	2025-12-04 04:24:02.070667	Wednesday	300	845	243	\N	\N	\N	\N
1728	2025-12-04 04:24:02.071402	2025-12-04 04:24:02.071402	Wednesday	2200	2330	243	\N	\N	\N	\N
1729	2025-12-04 04:24:02.072195	2025-12-04 04:24:02.072195	Thursday	615	1745	243	\N	\N	\N	\N
1730	2025-12-04 04:24:02.072976	2025-12-04 04:24:02.072976	Friday	730	1730	243	\N	\N	\N	\N
1731	2025-12-04 04:24:02.073741	2025-12-04 04:24:02.073741	Sunday	445	1345	243	\N	\N	\N	\N
1732	2025-12-04 04:24:02.074472	2025-12-04 04:24:02.074472	Sunday	1700	2015	243	\N	\N	\N	\N
1733	2025-12-04 04:24:02.086372	2025-12-04 04:24:02.086372	Monday	700	1400	244	\N	\N	\N	\N
1734	2025-12-04 04:24:02.087145	2025-12-04 04:24:02.087145	Tuesday	2015	300	244	\N	\N	\N	\N
1735	2025-12-04 04:24:02.087936	2025-12-04 04:24:02.087936	Wednesday	900	1600	244	\N	\N	\N	\N
1736	2025-12-04 04:24:02.088696	2025-12-04 04:24:02.088696	Thursday	945	1430	244	\N	\N	\N	\N
1737	2025-12-04 04:24:02.089768	2025-12-04 04:24:02.089768	Friday	900	1215	244	\N	\N	\N	\N
1738	2025-12-04 04:24:02.090493	2025-12-04 04:24:02.090493	Friday	1345	800	244	\N	\N	\N	\N
1739	2025-12-04 04:24:02.091294	2025-12-04 04:24:02.091294	Saturday	600	1745	244	\N	\N	\N	\N
1740	2025-12-04 04:24:02.092018	2025-12-04 04:24:02.092018	Sunday	600	2100	244	\N	\N	\N	\N
1741	2025-12-04 04:24:02.097798	2025-12-04 04:24:02.097798	Tuesday	1000	2330	245	\N	\N	\N	\N
1742	2025-12-04 04:24:02.098581	2025-12-04 04:24:02.098581	Wednesday	645	1545	245	\N	\N	\N	\N
1743	2025-12-04 04:24:02.099419	2025-12-04 04:24:02.099419	Thursday	830	2145	245	\N	\N	\N	\N
1744	2025-12-04 04:24:02.100275	2025-12-04 04:24:02.100275	Friday	615	1545	245	\N	\N	\N	\N
1745	2025-12-04 04:24:02.101089	2025-12-04 04:24:02.101089	Saturday	815	1800	245	\N	\N	\N	\N
1746	2025-12-04 04:24:02.101823	2025-12-04 04:24:02.101823	Sunday	600	2315	245	\N	\N	\N	\N
1747	2025-12-04 04:24:02.112793	2025-12-04 04:24:02.112793	Monday	845	2245	246	\N	\N	\N	\N
1748	2025-12-04 04:24:02.113597	2025-12-04 04:24:02.113597	Wednesday	100	400	246	\N	\N	\N	\N
1749	2025-12-04 04:24:02.114357	2025-12-04 04:24:02.114357	Wednesday	430	1930	246	\N	\N	\N	\N
1750	2025-12-04 04:24:02.115114	2025-12-04 04:24:02.115114	Thursday	645	1715	246	\N	\N	\N	\N
1751	2025-12-04 04:24:02.115836	2025-12-04 04:24:02.115836	Friday	845	1700	246	\N	\N	\N	\N
1752	2025-12-04 04:24:02.116564	2025-12-04 04:24:02.116564	Saturday	815	1615	246	\N	\N	\N	\N
1753	2025-12-04 04:24:02.121871	2025-12-04 04:24:02.121871	Monday	1330	1615	247	\N	\N	\N	\N
1754	2025-12-04 04:24:02.12264	2025-12-04 04:24:02.12264	Monday	2300	545	247	\N	\N	\N	\N
1755	2025-12-04 04:24:02.123406	2025-12-04 04:24:02.123406	Tuesday	245	1245	247	\N	\N	\N	\N
1756	2025-12-04 04:24:02.124191	2025-12-04 04:24:02.124191	Tuesday	2000	2245	247	\N	\N	\N	\N
1757	2025-12-04 04:24:02.124962	2025-12-04 04:24:02.124962	Thursday	915	1715	247	\N	\N	\N	\N
1758	2025-12-04 04:24:02.125767	2025-12-04 04:24:02.125767	Saturday	945	1000	247	\N	\N	\N	\N
1759	2025-12-04 04:24:02.126486	2025-12-04 04:24:02.126486	Saturday	1030	1845	247	\N	\N	\N	\N
1760	2025-12-04 04:24:02.127257	2025-12-04 04:24:02.127257	Sunday	815	1930	247	\N	\N	\N	\N
1761	2025-12-04 04:24:02.138673	2025-12-04 04:24:02.138673	Thursday	630	1630	248	\N	\N	\N	\N
1762	2025-12-04 04:24:02.139458	2025-12-04 04:24:02.139458	Friday	1000	1430	248	\N	\N	\N	\N
1763	2025-12-04 04:24:02.140266	2025-12-04 04:24:02.140266	Sunday	745	1445	248	\N	\N	\N	\N
1764	2025-12-04 04:24:02.146127	2025-12-04 04:24:02.146127	Tuesday	400	500	249	\N	\N	\N	\N
1765	2025-12-04 04:24:02.146888	2025-12-04 04:24:02.146888	Tuesday	700	2230	249	\N	\N	\N	\N
1766	2025-12-04 04:24:02.147676	2025-12-04 04:24:02.147676	Wednesday	115	145	249	\N	\N	\N	\N
1767	2025-12-04 04:24:02.148448	2025-12-04 04:24:02.148448	Wednesday	430	1230	249	\N	\N	\N	\N
1768	2025-12-04 04:24:02.149248	2025-12-04 04:24:02.149248	Thursday	545	615	249	\N	\N	\N	\N
1769	2025-12-04 04:24:02.150009	2025-12-04 04:24:02.150009	Thursday	1645	1900	249	\N	\N	\N	\N
1770	2025-12-04 04:24:02.150777	2025-12-04 04:24:02.150777	Friday	30	915	249	\N	\N	\N	\N
1771	2025-12-04 04:24:02.1515	2025-12-04 04:24:02.1515	Friday	1515	2400	249	\N	\N	\N	\N
1772	2025-12-04 04:24:02.152242	2025-12-04 04:24:02.152242	Saturday	745	2130	249	\N	\N	\N	\N
1773	2025-12-04 04:24:02.164345	2025-12-04 04:24:02.164345	Monday	730	1615	250	\N	\N	\N	\N
1774	2025-12-04 04:24:02.165135	2025-12-04 04:24:02.165135	Tuesday	745	930	250	\N	\N	\N	\N
1775	2025-12-04 04:24:02.165876	2025-12-04 04:24:02.165876	Tuesday	2015	45	250	\N	\N	\N	\N
1776	2025-12-04 04:24:02.166679	2025-12-04 04:24:02.166679	Wednesday	1645	130	250	\N	\N	\N	\N
1777	2025-12-04 04:24:02.167425	2025-12-04 04:24:02.167425	Thursday	615	1445	250	\N	\N	\N	\N
1778	2025-12-04 04:24:02.168191	2025-12-04 04:24:02.168191	Friday	1945	130	250	\N	\N	\N	\N
1779	2025-12-04 04:24:02.168935	2025-12-04 04:24:02.168935	Saturday	830	2000	250	\N	\N	\N	\N
1780	2025-12-04 04:24:02.16974	2025-12-04 04:24:02.16974	Sunday	745	1515	250	\N	\N	\N	\N
1781	2025-12-04 04:24:02.175615	2025-12-04 04:24:02.175615	Tuesday	600	1915	251	\N	\N	\N	\N
1782	2025-12-04 04:24:02.176417	2025-12-04 04:24:02.176417	Wednesday	615	2030	251	\N	\N	\N	\N
1783	2025-12-04 04:24:02.177232	2025-12-04 04:24:02.177232	Thursday	900	1545	251	\N	\N	\N	\N
1784	2025-12-04 04:24:02.178005	2025-12-04 04:24:02.178005	Friday	15	1700	251	\N	\N	\N	\N
1785	2025-12-04 04:24:02.178812	2025-12-04 04:24:02.178812	Friday	2000	2315	251	\N	\N	\N	\N
1786	2025-12-04 04:24:02.179585	2025-12-04 04:24:02.179585	Saturday	1430	1700	251	\N	\N	\N	\N
1787	2025-12-04 04:24:02.18031	2025-12-04 04:24:02.18031	Saturday	1715	2145	251	\N	\N	\N	\N
1788	2025-12-04 04:24:02.181031	2025-12-04 04:24:02.181031	Sunday	615	2345	251	\N	\N	\N	\N
1789	2025-12-04 04:24:02.190353	2025-12-04 04:24:02.190353	Monday	615	1630	252	\N	\N	\N	\N
1790	2025-12-04 04:24:02.191543	2025-12-04 04:24:02.191543	Wednesday	145	415	252	\N	\N	\N	\N
1791	2025-12-04 04:24:02.192313	2025-12-04 04:24:02.192313	Wednesday	900	2345	252	\N	\N	\N	\N
1792	2025-12-04 04:24:02.193131	2025-12-04 04:24:02.193131	Thursday	830	2115	252	\N	\N	\N	\N
1793	2025-12-04 04:24:02.193923	2025-12-04 04:24:02.193923	Friday	915	1800	252	\N	\N	\N	\N
1794	2025-12-04 04:24:02.194699	2025-12-04 04:24:02.194699	Saturday	900	2215	252	\N	\N	\N	\N
1795	2025-12-04 04:24:02.195454	2025-12-04 04:24:02.195454	Sunday	1815	2000	252	\N	\N	\N	\N
1796	2025-12-04 04:24:02.196273	2025-12-04 04:24:02.196273	Sunday	2245	1615	252	\N	\N	\N	\N
1797	2025-12-04 04:24:02.207399	2025-12-04 04:24:02.207399	Monday	500	1215	253	\N	\N	\N	\N
1798	2025-12-04 04:24:02.20816	2025-12-04 04:24:02.20816	Monday	1815	2015	253	\N	\N	\N	\N
1799	2025-12-04 04:24:02.208907	2025-12-04 04:24:02.208907	Tuesday	930	2030	253	\N	\N	\N	\N
1800	2025-12-04 04:24:02.209656	2025-12-04 04:24:02.209656	Wednesday	945	2215	253	\N	\N	\N	\N
1801	2025-12-04 04:24:02.210455	2025-12-04 04:24:02.210455	Friday	1745	215	253	\N	\N	\N	\N
1802	2025-12-04 04:24:02.21118	2025-12-04 04:24:02.21118	Saturday	915	1615	253	\N	\N	\N	\N
1803	2025-12-04 04:24:02.211918	2025-12-04 04:24:02.211918	Sunday	600	1600	253	\N	\N	\N	\N
1804	2025-12-04 04:24:02.217025	2025-12-04 04:24:02.217025	Wednesday	645	2245	254	\N	\N	\N	\N
1805	2025-12-04 04:24:02.217781	2025-12-04 04:24:02.217781	Thursday	645	1715	254	\N	\N	\N	\N
1806	2025-12-04 04:24:02.218545	2025-12-04 04:24:02.218545	Friday	415	645	254	\N	\N	\N	\N
1807	2025-12-04 04:24:02.219262	2025-12-04 04:24:02.219262	Friday	1600	2400	254	\N	\N	\N	\N
1808	2025-12-04 04:24:02.220026	2025-12-04 04:24:02.220026	Sunday	45	500	254	\N	\N	\N	\N
1809	2025-12-04 04:24:02.220746	2025-12-04 04:24:02.220746	Sunday	615	2345	254	\N	\N	\N	\N
1810	2025-12-04 04:24:02.232846	2025-12-04 04:24:02.232846	Monday	715	1800	255	\N	\N	\N	\N
1811	2025-12-04 04:24:02.233672	2025-12-04 04:24:02.233672	Tuesday	415	615	255	\N	\N	\N	\N
1812	2025-12-04 04:24:02.234409	2025-12-04 04:24:02.234409	Tuesday	645	2245	255	\N	\N	\N	\N
1813	2025-12-04 04:24:02.235219	2025-12-04 04:24:02.235219	Wednesday	245	1330	255	\N	\N	\N	\N
1814	2025-12-04 04:24:02.235977	2025-12-04 04:24:02.235977	Wednesday	1915	2100	255	\N	\N	\N	\N
1815	2025-12-04 04:24:02.236778	2025-12-04 04:24:02.236778	Thursday	645	1500	255	\N	\N	\N	\N
1816	2025-12-04 04:24:02.237477	2025-12-04 04:24:02.237477	Friday	945	1645	255	\N	\N	\N	\N
1817	2025-12-04 04:24:02.238226	2025-12-04 04:24:02.238226	Saturday	700	2315	255	\N	\N	\N	\N
1818	2025-12-04 04:24:02.244435	2025-12-04 04:24:02.244435	Monday	200	215	256	\N	\N	\N	\N
1819	2025-12-04 04:24:02.245197	2025-12-04 04:24:02.245197	Monday	1245	1745	256	\N	\N	\N	\N
1820	2025-12-04 04:24:02.245943	2025-12-04 04:24:02.245943	Tuesday	1000	2100	256	\N	\N	\N	\N
1821	2025-12-04 04:24:02.246684	2025-12-04 04:24:02.246684	Wednesday	1415	130	256	\N	\N	\N	\N
1822	2025-12-04 04:24:02.247413	2025-12-04 04:24:02.247413	Thursday	915	2330	256	\N	\N	\N	\N
1823	2025-12-04 04:24:02.248153	2025-12-04 04:24:02.248153	Friday	815	1815	256	\N	\N	\N	\N
1824	2025-12-04 04:24:02.248936	2025-12-04 04:24:02.248936	Saturday	1000	1015	256	\N	\N	\N	\N
1825	2025-12-04 04:24:02.24964	2025-12-04 04:24:02.24964	Saturday	1100	1245	256	\N	\N	\N	\N
1826	2025-12-04 04:24:02.250388	2025-12-04 04:24:02.250388	Sunday	500	600	256	\N	\N	\N	\N
1827	2025-12-04 04:24:02.251093	2025-12-04 04:24:02.251093	Sunday	815	830	256	\N	\N	\N	\N
1828	2025-12-04 04:24:02.260614	2025-12-04 04:24:02.260614	Tuesday	1000	2315	257	\N	\N	\N	\N
1829	2025-12-04 04:24:02.261395	2025-12-04 04:24:02.261395	Wednesday	600	1700	257	\N	\N	\N	\N
1830	2025-12-04 04:24:02.262136	2025-12-04 04:24:02.262136	Thursday	2100	130	257	\N	\N	\N	\N
1831	2025-12-04 04:24:02.262861	2025-12-04 04:24:02.262861	Friday	930	2330	257	\N	\N	\N	\N
1832	2025-12-04 04:24:02.263585	2025-12-04 04:24:02.263585	Saturday	1000	1600	257	\N	\N	\N	\N
1833	2025-12-04 04:24:02.264363	2025-12-04 04:24:02.264363	Sunday	1800	245	257	\N	\N	\N	\N
1834	2025-12-04 04:24:02.275975	2025-12-04 04:24:02.275975	Monday	945	1715	258	\N	\N	\N	\N
1835	2025-12-04 04:24:02.276752	2025-12-04 04:24:02.276752	Tuesday	1815	130	258	\N	\N	\N	\N
1836	2025-12-04 04:24:02.277474	2025-12-04 04:24:02.277474	Wednesday	615	2215	258	\N	\N	\N	\N
1837	2025-12-04 04:24:02.278271	2025-12-04 04:24:02.278271	Thursday	600	845	258	\N	\N	\N	\N
1838	2025-12-04 04:24:02.278978	2025-12-04 04:24:02.278978	Thursday	1415	2015	258	\N	\N	\N	\N
1839	2025-12-04 04:24:02.279778	2025-12-04 04:24:02.279778	Saturday	1000	1530	258	\N	\N	\N	\N
1840	2025-12-04 04:24:02.28049	2025-12-04 04:24:02.28049	Saturday	1800	700	258	\N	\N	\N	\N
1841	2025-12-04 04:24:02.281216	2025-12-04 04:24:02.281216	Sunday	1715	215	258	\N	\N	\N	\N
1842	2025-12-04 04:24:02.287025	2025-12-04 04:24:02.287025	Monday	1900	145	259	\N	\N	\N	\N
1843	2025-12-04 04:24:02.287807	2025-12-04 04:24:02.287807	Wednesday	730	1645	259	\N	\N	\N	\N
1844	2025-12-04 04:24:02.288584	2025-12-04 04:24:02.288584	Thursday	630	2000	259	\N	\N	\N	\N
1845	2025-12-04 04:24:02.289352	2025-12-04 04:24:02.289352	Saturday	930	2345	259	\N	\N	\N	\N
1846	2025-12-04 04:24:02.290113	2025-12-04 04:24:02.290113	Sunday	1815	300	259	\N	\N	\N	\N
1847	2025-12-04 04:24:02.299298	2025-12-04 04:24:02.299298	Tuesday	200	700	260	\N	\N	\N	\N
1848	2025-12-04 04:24:02.30011	2025-12-04 04:24:02.30011	Tuesday	1330	2345	260	\N	\N	\N	\N
1849	2025-12-04 04:24:02.300869	2025-12-04 04:24:02.300869	Wednesday	830	1630	260	\N	\N	\N	\N
1850	2025-12-04 04:24:02.301689	2025-12-04 04:24:02.301689	Thursday	830	1145	260	\N	\N	\N	\N
1851	2025-12-04 04:24:02.302398	2025-12-04 04:24:02.302398	Thursday	1645	145	260	\N	\N	\N	\N
1852	2025-12-04 04:24:02.303167	2025-12-04 04:24:02.303167	Friday	945	1615	260	\N	\N	\N	\N
1853	2025-12-04 04:24:02.314196	2025-12-04 04:24:02.314196	Monday	745	1830	261	\N	\N	\N	\N
1854	2025-12-04 04:24:02.314975	2025-12-04 04:24:02.314975	Monday	2230	345	261	\N	\N	\N	\N
1855	2025-12-04 04:24:02.315708	2025-12-04 04:24:02.315708	Tuesday	845	1900	261	\N	\N	\N	\N
1856	2025-12-04 04:24:02.316441	2025-12-04 04:24:02.316441	Wednesday	645	2345	261	\N	\N	\N	\N
1857	2025-12-04 04:24:02.317176	2025-12-04 04:24:02.317176	Thursday	1000	1515	261	\N	\N	\N	\N
1858	2025-12-04 04:24:02.317901	2025-12-04 04:24:02.317901	Friday	1945	200	261	\N	\N	\N	\N
1859	2025-12-04 04:24:02.318682	2025-12-04 04:24:02.318682	Sunday	1000	1015	261	\N	\N	\N	\N
1860	2025-12-04 04:24:02.319436	2025-12-04 04:24:02.319436	Sunday	1115	1315	261	\N	\N	\N	\N
1861	2025-12-04 04:24:02.324648	2025-12-04 04:24:02.324648	Tuesday	715	2030	262	\N	\N	\N	\N
1862	2025-12-04 04:24:02.325402	2025-12-04 04:24:02.325402	Thursday	715	1500	262	\N	\N	\N	\N
1863	2025-12-04 04:24:02.32623	2025-12-04 04:24:02.32623	Friday	245	330	262	\N	\N	\N	\N
1864	2025-12-04 04:24:02.327027	2025-12-04 04:24:02.327027	Friday	515	1115	262	\N	\N	\N	\N
1865	2025-12-04 04:24:02.327905	2025-12-04 04:24:02.327905	Saturday	215	1645	262	\N	\N	\N	\N
1866	2025-12-04 04:24:02.328684	2025-12-04 04:24:02.328684	Saturday	1700	2330	262	\N	\N	\N	\N
1867	2025-12-04 04:24:02.329495	2025-12-04 04:24:02.329495	Sunday	945	1600	262	\N	\N	\N	\N
1868	2025-12-04 04:24:02.330262	2025-12-04 04:24:02.330262	Sunday	2245	930	262	\N	\N	\N	\N
1869	2025-12-04 04:24:02.341116	2025-12-04 04:24:02.341116	Tuesday	2115	115	263	\N	\N	\N	\N
1870	2025-12-04 04:24:02.341912	2025-12-04 04:24:02.341912	Thursday	630	1730	263	\N	\N	\N	\N
1871	2025-12-04 04:24:02.34267	2025-12-04 04:24:02.34267	Saturday	1445	215	263	\N	\N	\N	\N
1872	2025-12-04 04:24:02.347829	2025-12-04 04:24:02.347829	Monday	615	930	264	\N	\N	\N	\N
1873	2025-12-04 04:24:02.348636	2025-12-04 04:24:02.348636	Monday	1345	2045	264	\N	\N	\N	\N
1874	2025-12-04 04:24:02.351466	2025-12-04 04:24:02.351466	Wednesday	915	1600	264	\N	\N	\N	\N
1875	2025-12-04 04:24:02.352308	2025-12-04 04:24:02.352308	Thursday	900	2300	264	\N	\N	\N	\N
1876	2025-12-04 04:24:02.35309	2025-12-04 04:24:02.35309	Friday	915	1300	264	\N	\N	\N	\N
1877	2025-12-04 04:24:02.353841	2025-12-04 04:24:02.353841	Friday	1330	1545	264	\N	\N	\N	\N
1878	2025-12-04 04:24:02.354661	2025-12-04 04:24:02.354661	Sunday	845	2145	264	\N	\N	\N	\N
1879	2025-12-04 04:24:02.363154	2025-12-04 04:24:02.363154	Monday	830	1445	265	\N	\N	\N	\N
1880	2025-12-04 04:24:02.363921	2025-12-04 04:24:02.363921	Tuesday	700	1915	265	\N	\N	\N	\N
1881	2025-12-04 04:24:02.364671	2025-12-04 04:24:02.364671	Friday	845	2015	265	\N	\N	\N	\N
1882	2025-12-04 04:24:02.365418	2025-12-04 04:24:02.365418	Saturday	915	1530	265	\N	\N	\N	\N
1883	2025-12-04 04:24:02.366174	2025-12-04 04:24:02.366174	Sunday	745	2300	265	\N	\N	\N	\N
1884	2025-12-04 04:24:02.377313	2025-12-04 04:24:02.377313	Monday	915	1645	266	\N	\N	\N	\N
1885	2025-12-04 04:24:02.378111	2025-12-04 04:24:02.378111	Tuesday	945	1500	266	\N	\N	\N	\N
1886	2025-12-04 04:24:02.37888	2025-12-04 04:24:02.37888	Wednesday	915	2045	266	\N	\N	\N	\N
1887	2025-12-04 04:24:02.379651	2025-12-04 04:24:02.379651	Thursday	1230	1515	266	\N	\N	\N	\N
1888	2025-12-04 04:24:02.380378	2025-12-04 04:24:02.380378	Thursday	1915	1000	266	\N	\N	\N	\N
1889	2025-12-04 04:24:02.381154	2025-12-04 04:24:02.381154	Friday	145	1415	266	\N	\N	\N	\N
1890	2025-12-04 04:24:02.381862	2025-12-04 04:24:02.381862	Friday	1430	2245	266	\N	\N	\N	\N
1891	2025-12-04 04:24:02.386927	2025-12-04 04:24:02.386927	Monday	430	1400	267	\N	\N	\N	\N
1892	2025-12-04 04:24:02.3877	2025-12-04 04:24:02.3877	Monday	1415	1500	267	\N	\N	\N	\N
1893	2025-12-04 04:24:02.388427	2025-12-04 04:24:02.388427	Tuesday	600	2145	267	\N	\N	\N	\N
1894	2025-12-04 04:24:02.389222	2025-12-04 04:24:02.389222	Wednesday	315	915	267	\N	\N	\N	\N
1895	2025-12-04 04:24:02.389951	2025-12-04 04:24:02.389951	Wednesday	1015	1445	267	\N	\N	\N	\N
1896	2025-12-04 04:24:02.39074	2025-12-04 04:24:02.39074	Thursday	1000	2330	267	\N	\N	\N	\N
1897	2025-12-04 04:24:02.391496	2025-12-04 04:24:02.391496	Friday	815	1530	267	\N	\N	\N	\N
1898	2025-12-04 04:24:02.392278	2025-12-04 04:24:02.392278	Saturday	830	1330	267	\N	\N	\N	\N
1899	2025-12-04 04:24:02.393276	2025-12-04 04:24:02.393276	Saturday	2015	2245	267	\N	\N	\N	\N
1900	2025-12-04 04:24:02.394054	2025-12-04 04:24:02.394054	Sunday	1500	1600	267	\N	\N	\N	\N
1901	2025-12-04 04:24:02.394761	2025-12-04 04:24:02.394761	Sunday	2000	2230	267	\N	\N	\N	\N
1902	2025-12-04 04:24:02.403093	2025-12-04 04:24:02.403093	Monday	1145	1515	268	\N	\N	\N	\N
1903	2025-12-04 04:24:02.403842	2025-12-04 04:24:02.403842	Monday	1700	2245	268	\N	\N	\N	\N
1904	2025-12-04 04:24:02.404582	2025-12-04 04:24:02.404582	Tuesday	800	1545	268	\N	\N	\N	\N
1905	2025-12-04 04:24:02.40538	2025-12-04 04:24:02.40538	Thursday	30	245	268	\N	\N	\N	\N
1906	2025-12-04 04:24:02.406103	2025-12-04 04:24:02.406103	Thursday	600	1930	268	\N	\N	\N	\N
1907	2025-12-04 04:24:02.406872	2025-12-04 04:24:02.406872	Friday	745	1300	268	\N	\N	\N	\N
1908	2025-12-04 04:24:02.4076	2025-12-04 04:24:02.4076	Friday	1545	1800	268	\N	\N	\N	\N
1909	2025-12-04 04:24:02.408322	2025-12-04 04:24:02.408322	Saturday	715	1830	268	\N	\N	\N	\N
1910	2025-12-04 04:24:02.40912	2025-12-04 04:24:02.40912	Sunday	1000	1230	268	\N	\N	\N	\N
1911	2025-12-04 04:24:02.409867	2025-12-04 04:24:02.409867	Sunday	2100	330	268	\N	\N	\N	\N
1912	2025-12-04 04:24:02.421793	2025-12-04 04:24:02.421793	Tuesday	1400	1515	269	\N	\N	\N	\N
1913	2025-12-04 04:24:02.422569	2025-12-04 04:24:02.422569	Tuesday	2130	15	269	\N	\N	\N	\N
1914	2025-12-04 04:24:02.423324	2025-12-04 04:24:02.423324	Wednesday	900	1900	269	\N	\N	\N	\N
1915	2025-12-04 04:24:02.424036	2025-12-04 04:24:02.424036	Thursday	600	1715	269	\N	\N	\N	\N
1916	2025-12-04 04:24:02.424801	2025-12-04 04:24:02.424801	Saturday	915	1545	269	\N	\N	\N	\N
1917	2025-12-04 04:24:02.425542	2025-12-04 04:24:02.425542	Sunday	730	2145	269	\N	\N	\N	\N
1918	2025-12-04 04:24:02.431461	2025-12-04 04:24:02.431461	Monday	615	715	270	\N	\N	\N	\N
1919	2025-12-04 04:24:02.432204	2025-12-04 04:24:02.432204	Monday	1915	2215	270	\N	\N	\N	\N
1920	2025-12-04 04:24:02.432969	2025-12-04 04:24:02.432969	Wednesday	800	1945	270	\N	\N	\N	\N
1921	2025-12-04 04:24:02.433705	2025-12-04 04:24:02.433705	Thursday	945	1730	270	\N	\N	\N	\N
1922	2025-12-04 04:24:02.43444	2025-12-04 04:24:02.43444	Friday	945	1845	270	\N	\N	\N	\N
1923	2025-12-04 04:24:02.435204	2025-12-04 04:24:02.435204	Saturday	545	1045	270	\N	\N	\N	\N
1924	2025-12-04 04:24:02.435943	2025-12-04 04:24:02.435943	Saturday	1445	1515	270	\N	\N	\N	\N
1925	2025-12-04 04:24:02.436718	2025-12-04 04:24:02.436718	Sunday	615	1900	270	\N	\N	\N	\N
1926	2025-12-04 04:24:02.445728	2025-12-04 04:24:02.445728	Monday	2215	315	271	\N	\N	\N	\N
1927	2025-12-04 04:24:02.446486	2025-12-04 04:24:02.446486	Tuesday	615	2115	271	\N	\N	\N	\N
1928	2025-12-04 04:24:02.447265	2025-12-04 04:24:02.447265	Wednesday	815	1015	271	\N	\N	\N	\N
1929	2025-12-04 04:24:02.447969	2025-12-04 04:24:02.447969	Wednesday	1315	700	271	\N	\N	\N	\N
1930	2025-12-04 04:24:02.448712	2025-12-04 04:24:02.448712	Thursday	745	2315	271	\N	\N	\N	\N
1931	2025-12-04 04:24:02.449591	2025-12-04 04:24:02.449591	Saturday	500	645	271	\N	\N	\N	\N
1932	2025-12-04 04:24:02.450331	2025-12-04 04:24:02.450331	Saturday	1530	1930	271	\N	\N	\N	\N
1933	2025-12-04 04:24:02.451061	2025-12-04 04:24:02.451061	Sunday	645	2400	271	\N	\N	\N	\N
1934	2025-12-04 04:24:02.462123	2025-12-04 04:24:02.462123	Tuesday	315	430	272	\N	\N	\N	\N
1935	2025-12-04 04:24:02.463046	2025-12-04 04:24:02.463046	Tuesday	900	930	272	\N	\N	\N	\N
1936	2025-12-04 04:24:02.463833	2025-12-04 04:24:02.463833	Thursday	815	1700	272	\N	\N	\N	\N
1937	2025-12-04 04:24:02.464578	2025-12-04 04:24:02.464578	Friday	745	2045	272	\N	\N	\N	\N
1938	2025-12-04 04:24:02.469616	2025-12-04 04:24:02.469616	Monday	815	2230	273	\N	\N	\N	\N
1939	2025-12-04 04:24:02.470448	2025-12-04 04:24:02.470448	Tuesday	1600	1700	273	\N	\N	\N	\N
1940	2025-12-04 04:24:02.471355	2025-12-04 04:24:02.471355	Tuesday	1900	1400	273	\N	\N	\N	\N
1941	2025-12-04 04:24:02.472252	2025-12-04 04:24:02.472252	Thursday	2000	330	273	\N	\N	\N	\N
1942	2025-12-04 04:24:02.473155	2025-12-04 04:24:02.473155	Friday	115	1400	273	\N	\N	\N	\N
1943	2025-12-04 04:24:02.473997	2025-12-04 04:24:02.473997	Friday	1845	2145	273	\N	\N	\N	\N
1944	2025-12-04 04:24:02.474831	2025-12-04 04:24:02.474831	Saturday	1615	400	273	\N	\N	\N	\N
1945	2025-12-04 04:24:02.475703	2025-12-04 04:24:02.475703	Sunday	15	815	273	\N	\N	\N	\N
1946	2025-12-04 04:24:02.476564	2025-12-04 04:24:02.476564	Sunday	1245	2330	273	\N	\N	\N	\N
1947	2025-12-04 04:24:02.485796	2025-12-04 04:24:02.485796	Monday	700	2045	274	\N	\N	\N	\N
1948	2025-12-04 04:24:02.486611	2025-12-04 04:24:02.486611	Tuesday	815	1500	274	\N	\N	\N	\N
1949	2025-12-04 04:24:02.487396	2025-12-04 04:24:02.487396	Wednesday	845	1945	274	\N	\N	\N	\N
1950	2025-12-04 04:24:02.488219	2025-12-04 04:24:02.488219	Thursday	1830	315	274	\N	\N	\N	\N
1951	2025-12-04 04:24:02.488947	2025-12-04 04:24:02.488947	Friday	945	1915	274	\N	\N	\N	\N
1952	2025-12-04 04:24:02.48969	2025-12-04 04:24:02.48969	Saturday	2115	100	274	\N	\N	\N	\N
1953	2025-12-04 04:24:02.501911	2025-12-04 04:24:02.501911	Monday	330	945	275	\N	\N	\N	\N
1954	2025-12-04 04:24:02.502695	2025-12-04 04:24:02.502695	Monday	1045	2400	275	\N	\N	\N	\N
1955	2025-12-04 04:24:02.503461	2025-12-04 04:24:02.503461	Tuesday	1445	200	275	\N	\N	\N	\N
1956	2025-12-04 04:24:02.504278	2025-12-04 04:24:02.504278	Wednesday	230	1015	275	\N	\N	\N	\N
1957	2025-12-04 04:24:02.505007	2025-12-04 04:24:02.505007	Wednesday	1800	2315	275	\N	\N	\N	\N
1958	2025-12-04 04:24:02.505743	2025-12-04 04:24:02.505743	Thursday	830	2100	275	\N	\N	\N	\N
1959	2025-12-04 04:24:02.506463	2025-12-04 04:24:02.506463	Saturday	815	1630	275	\N	\N	\N	\N
1960	2025-12-04 04:24:02.507253	2025-12-04 04:24:02.507253	Sunday	930	1215	275	\N	\N	\N	\N
1961	2025-12-04 04:24:02.507958	2025-12-04 04:24:02.507958	Sunday	1400	2200	275	\N	\N	\N	\N
1962	2025-12-04 04:24:02.513658	2025-12-04 04:24:02.513658	Monday	400	500	276	\N	\N	\N	\N
1963	2025-12-04 04:24:02.514434	2025-12-04 04:24:02.514434	Monday	915	1730	276	\N	\N	\N	\N
1964	2025-12-04 04:24:02.51519	2025-12-04 04:24:02.51519	Tuesday	615	1845	276	\N	\N	\N	\N
1965	2025-12-04 04:24:02.515974	2025-12-04 04:24:02.515974	Wednesday	1615	115	276	\N	\N	\N	\N
1966	2025-12-04 04:24:02.516715	2025-12-04 04:24:02.516715	Thursday	2145	300	276	\N	\N	\N	\N
1967	2025-12-04 04:24:02.517443	2025-12-04 04:24:02.517443	Friday	930	2345	276	\N	\N	\N	\N
1968	2025-12-04 04:24:02.518233	2025-12-04 04:24:02.518233	Saturday	130	200	276	\N	\N	\N	\N
1969	2025-12-04 04:24:02.518992	2025-12-04 04:24:02.518992	Saturday	1130	1800	276	\N	\N	\N	\N
1970	2025-12-04 04:24:02.519727	2025-12-04 04:24:02.519727	Sunday	930	1615	276	\N	\N	\N	\N
1971	2025-12-04 04:24:02.528641	2025-12-04 04:24:02.528641	Tuesday	130	400	277	\N	\N	\N	\N
1972	2025-12-04 04:24:02.52938	2025-12-04 04:24:02.52938	Tuesday	1245	1615	277	\N	\N	\N	\N
1973	2025-12-04 04:24:02.530136	2025-12-04 04:24:02.530136	Wednesday	615	1845	277	\N	\N	\N	\N
1974	2025-12-04 04:24:02.530894	2025-12-04 04:24:02.530894	Saturday	1015	1330	277	\N	\N	\N	\N
1975	2025-12-04 04:24:02.531598	2025-12-04 04:24:02.531598	Saturday	1515	2345	277	\N	\N	\N	\N
1976	2025-12-04 04:24:02.532611	2025-12-04 04:24:02.532611	Sunday	500	900	277	\N	\N	\N	\N
1977	2025-12-04 04:24:02.533399	2025-12-04 04:24:02.533399	Sunday	1430	1800	277	\N	\N	\N	\N
1978	2025-12-04 04:24:02.545426	2025-12-04 04:24:02.545426	Monday	730	2045	278	\N	\N	\N	\N
1979	2025-12-04 04:24:02.54621	2025-12-04 04:24:02.54621	Tuesday	830	1830	278	\N	\N	\N	\N
1980	2025-12-04 04:24:02.546992	2025-12-04 04:24:02.546992	Wednesday	845	1700	278	\N	\N	\N	\N
1981	2025-12-04 04:24:02.54772	2025-12-04 04:24:02.54772	Thursday	630	2215	278	\N	\N	\N	\N
1982	2025-12-04 04:24:02.548512	2025-12-04 04:24:02.548512	Friday	315	1045	278	\N	\N	\N	\N
1983	2025-12-04 04:24:02.549271	2025-12-04 04:24:02.549271	Friday	1300	2245	278	\N	\N	\N	\N
1984	2025-12-04 04:24:02.550032	2025-12-04 04:24:02.550032	Saturday	815	2300	278	\N	\N	\N	\N
1985	2025-12-04 04:24:02.550768	2025-12-04 04:24:02.550768	Sunday	1845	245	278	\N	\N	\N	\N
1986	2025-12-04 04:24:02.556888	2025-12-04 04:24:02.556888	Monday	230	700	279	\N	\N	\N	\N
1987	2025-12-04 04:24:02.557659	2025-12-04 04:24:02.557659	Monday	1045	1915	279	\N	\N	\N	\N
1988	2025-12-04 04:24:02.558397	2025-12-04 04:24:02.558397	Tuesday	700	2300	279	\N	\N	\N	\N
1989	2025-12-04 04:24:02.559137	2025-12-04 04:24:02.559137	Wednesday	700	1430	279	\N	\N	\N	\N
1990	2025-12-04 04:24:02.559871	2025-12-04 04:24:02.559871	Thursday	600	1800	279	\N	\N	\N	\N
1991	2025-12-04 04:24:02.560636	2025-12-04 04:24:02.560636	Friday	0	645	279	\N	\N	\N	\N
1992	2025-12-04 04:24:02.561358	2025-12-04 04:24:02.561358	Friday	1745	2230	279	\N	\N	\N	\N
1993	2025-12-04 04:24:02.562117	2025-12-04 04:24:02.562117	Saturday	1900	315	279	\N	\N	\N	\N
1994	2025-12-04 04:24:02.574296	2025-12-04 04:24:02.574296	Monday	930	2100	280	\N	\N	\N	\N
1995	2025-12-04 04:24:02.575049	2025-12-04 04:24:02.575049	Wednesday	815	2100	280	\N	\N	\N	\N
1996	2025-12-04 04:24:02.575815	2025-12-04 04:24:02.575815	Thursday	830	2215	280	\N	\N	\N	\N
1997	2025-12-04 04:24:02.576546	2025-12-04 04:24:02.576546	Friday	615	2100	280	\N	\N	\N	\N
1998	2025-12-04 04:24:02.577397	2025-12-04 04:24:02.577397	Sunday	15	1215	280	\N	\N	\N	\N
1999	2025-12-04 04:24:02.578159	2025-12-04 04:24:02.578159	Sunday	1830	2400	280	\N	\N	\N	\N
2000	2025-12-04 04:24:02.583128	2025-12-04 04:24:02.583128	Monday	945	1845	281	\N	\N	\N	\N
2001	2025-12-04 04:24:02.583904	2025-12-04 04:24:02.583904	Tuesday	1500	130	281	\N	\N	\N	\N
2002	2025-12-04 04:24:02.584659	2025-12-04 04:24:02.584659	Wednesday	815	1600	281	\N	\N	\N	\N
2003	2025-12-04 04:24:02.58541	2025-12-04 04:24:02.58541	Thursday	930	1500	281	\N	\N	\N	\N
2004	2025-12-04 04:24:02.586182	2025-12-04 04:24:02.586182	Friday	830	2200	281	\N	\N	\N	\N
2005	2025-12-04 04:24:02.59457	2025-12-04 04:24:02.59457	Monday	830	1230	282	\N	\N	\N	\N
2006	2025-12-04 04:24:02.595324	2025-12-04 04:24:02.595324	Monday	2030	2145	282	\N	\N	\N	\N
2007	2025-12-04 04:24:02.596032	2025-12-04 04:24:02.596032	Wednesday	645	2130	282	\N	\N	\N	\N
2008	2025-12-04 04:24:02.596864	2025-12-04 04:24:02.596864	Thursday	700	2100	282	\N	\N	\N	\N
2009	2025-12-04 04:24:02.597689	2025-12-04 04:24:02.597689	Friday	300	915	282	\N	\N	\N	\N
2010	2025-12-04 04:24:02.598457	2025-12-04 04:24:02.598457	Friday	2000	2145	282	\N	\N	\N	\N
2011	2025-12-04 04:24:02.59918	2025-12-04 04:24:02.59918	Saturday	845	1900	282	\N	\N	\N	\N
2012	2025-12-04 04:24:02.600195	2025-12-04 04:24:02.600195	Sunday	730	2000	282	\N	\N	\N	\N
2013	2025-12-04 04:24:02.611983	2025-12-04 04:24:02.611983	Monday	815	1500	283	\N	\N	\N	\N
2014	2025-12-04 04:24:02.612782	2025-12-04 04:24:02.612782	Tuesday	1545	130	283	\N	\N	\N	\N
2015	2025-12-04 04:24:02.613558	2025-12-04 04:24:02.613558	Wednesday	1715	130	283	\N	\N	\N	\N
2016	2025-12-04 04:24:02.614332	2025-12-04 04:24:02.614332	Friday	830	1500	283	\N	\N	\N	\N
2017	2025-12-04 04:24:02.615065	2025-12-04 04:24:02.615065	Saturday	615	2215	283	\N	\N	\N	\N
2018	2025-12-04 04:24:02.620723	2025-12-04 04:24:02.620723	Tuesday	2000	2030	284	\N	\N	\N	\N
2019	2025-12-04 04:24:02.621473	2025-12-04 04:24:02.621473	Tuesday	2400	100	284	\N	\N	\N	\N
2020	2025-12-04 04:24:02.622222	2025-12-04 04:24:02.622222	Wednesday	730	2115	284	\N	\N	\N	\N
2021	2025-12-04 04:24:02.623003	2025-12-04 04:24:02.623003	Thursday	930	2115	284	\N	\N	\N	\N
2022	2025-12-04 04:24:02.623766	2025-12-04 04:24:02.623766	Friday	700	2100	284	\N	\N	\N	\N
2023	2025-12-04 04:24:02.624509	2025-12-04 04:24:02.624509	Saturday	1715	315	284	\N	\N	\N	\N
2024	2025-12-04 04:24:02.625256	2025-12-04 04:24:02.625256	Sunday	730	1445	284	\N	\N	\N	\N
2025	2025-12-04 04:24:02.636199	2025-12-04 04:24:02.636199	Tuesday	1830	130	285	\N	\N	\N	\N
2026	2025-12-04 04:24:02.637029	2025-12-04 04:24:02.637029	Wednesday	900	1230	285	\N	\N	\N	\N
2027	2025-12-04 04:24:02.637762	2025-12-04 04:24:02.637762	Wednesday	1530	2230	285	\N	\N	\N	\N
2028	2025-12-04 04:24:02.638521	2025-12-04 04:24:02.638521	Thursday	900	1845	285	\N	\N	\N	\N
2029	2025-12-04 04:24:02.639317	2025-12-04 04:24:02.639317	Friday	915	2015	285	\N	\N	\N	\N
2030	2025-12-04 04:24:02.640064	2025-12-04 04:24:02.640064	Saturday	300	1130	285	\N	\N	\N	\N
2031	2025-12-04 04:24:02.640779	2025-12-04 04:24:02.640779	Saturday	2145	130	285	\N	\N	\N	\N
2032	2025-12-04 04:24:02.641509	2025-12-04 04:24:02.641509	Sunday	600	1930	285	\N	\N	\N	\N
2033	2025-12-04 04:24:02.648785	2025-12-04 04:24:02.648785	Monday	645	1915	286	\N	\N	\N	\N
2034	2025-12-04 04:24:02.649555	2025-12-04 04:24:02.649555	Tuesday	745	2145	286	\N	\N	\N	\N
2035	2025-12-04 04:24:02.65033	2025-12-04 04:24:02.65033	Thursday	1945	330	286	\N	\N	\N	\N
2036	2025-12-04 04:24:02.651075	2025-12-04 04:24:02.651075	Friday	815	2400	286	\N	\N	\N	\N
2037	2025-12-04 04:24:02.651849	2025-12-04 04:24:02.651849	Saturday	500	1145	286	\N	\N	\N	\N
2038	2025-12-04 04:24:02.652556	2025-12-04 04:24:02.652556	Saturday	1700	2400	286	\N	\N	\N	\N
2039	2025-12-04 04:24:02.653348	2025-12-04 04:24:02.653348	Sunday	1200	1730	286	\N	\N	\N	\N
2040	2025-12-04 04:24:02.65406	2025-12-04 04:24:02.65406	Sunday	2000	2030	286	\N	\N	\N	\N
2041	2025-12-04 04:24:02.665481	2025-12-04 04:24:02.665481	Monday	230	1000	287	\N	\N	\N	\N
2042	2025-12-04 04:24:02.666226	2025-12-04 04:24:02.666226	Monday	1245	1415	287	\N	\N	\N	\N
2043	2025-12-04 04:24:02.667145	2025-12-04 04:24:02.667145	Tuesday	800	1845	287	\N	\N	\N	\N
2044	2025-12-04 04:24:02.667899	2025-12-04 04:24:02.667899	Wednesday	715	900	287	\N	\N	\N	\N
2045	2025-12-04 04:24:02.668688	2025-12-04 04:24:02.668688	Wednesday	1515	1915	287	\N	\N	\N	\N
2046	2025-12-04 04:24:02.669541	2025-12-04 04:24:02.669541	Thursday	1415	245	287	\N	\N	\N	\N
2047	2025-12-04 04:24:02.670405	2025-12-04 04:24:02.670405	Friday	2015	115	287	\N	\N	\N	\N
2048	2025-12-04 04:24:02.671198	2025-12-04 04:24:02.671198	Saturday	745	2200	287	\N	\N	\N	\N
2049	2025-12-04 04:24:02.67194	2025-12-04 04:24:02.67194	Sunday	600	2315	287	\N	\N	\N	\N
2050	2025-12-04 04:24:02.677764	2025-12-04 04:24:02.677764	Monday	845	1000	288	\N	\N	\N	\N
2051	2025-12-04 04:24:02.678507	2025-12-04 04:24:02.678507	Monday	1245	2045	288	\N	\N	\N	\N
2052	2025-12-04 04:24:02.679291	2025-12-04 04:24:02.679291	Tuesday	845	2400	288	\N	\N	\N	\N
2053	2025-12-04 04:24:02.680049	2025-12-04 04:24:02.680049	Wednesday	2300	315	288	\N	\N	\N	\N
2054	2025-12-04 04:24:02.680797	2025-12-04 04:24:02.680797	Thursday	915	1630	288	\N	\N	\N	\N
2055	2025-12-04 04:24:02.681578	2025-12-04 04:24:02.681578	Friday	130	1530	288	\N	\N	\N	\N
2056	2025-12-04 04:24:02.682314	2025-12-04 04:24:02.682314	Friday	1630	1845	288	\N	\N	\N	\N
2057	2025-12-04 04:24:02.683069	2025-12-04 04:24:02.683069	Saturday	615	1800	288	\N	\N	\N	\N
2058	2025-12-04 04:24:02.683847	2025-12-04 04:24:02.683847	Sunday	615	2015	288	\N	\N	\N	\N
2059	2025-12-04 04:24:02.69314	2025-12-04 04:24:02.69314	Monday	315	445	289	\N	\N	\N	\N
2060	2025-12-04 04:24:02.693906	2025-12-04 04:24:02.693906	Monday	730	2045	289	\N	\N	\N	\N
2061	2025-12-04 04:24:02.694734	2025-12-04 04:24:02.694734	Tuesday	645	1815	289	\N	\N	\N	\N
2062	2025-12-04 04:24:02.695502	2025-12-04 04:24:02.695502	Wednesday	615	2215	289	\N	\N	\N	\N
2063	2025-12-04 04:24:02.69628	2025-12-04 04:24:02.69628	Thursday	0	45	289	\N	\N	\N	\N
2064	2025-12-04 04:24:02.697004	2025-12-04 04:24:02.697004	Thursday	1130	2215	289	\N	\N	\N	\N
2065	2025-12-04 04:24:02.697771	2025-12-04 04:24:02.697771	Friday	630	2015	289	\N	\N	\N	\N
2066	2025-12-04 04:24:02.698554	2025-12-04 04:24:02.698554	Saturday	1345	1430	289	\N	\N	\N	\N
2067	2025-12-04 04:24:02.699295	2025-12-04 04:24:02.699295	Saturday	1600	2300	289	\N	\N	\N	\N
2068	2025-12-04 04:24:02.700076	2025-12-04 04:24:02.700076	Sunday	945	2215	289	\N	\N	\N	\N
2069	2025-12-04 04:24:02.712929	2025-12-04 04:24:02.712929	Monday	815	2015	290	\N	\N	\N	\N
2070	2025-12-04 04:24:02.713756	2025-12-04 04:24:02.713756	Tuesday	945	2245	290	\N	\N	\N	\N
2071	2025-12-04 04:24:02.714565	2025-12-04 04:24:02.714565	Wednesday	230	1445	290	\N	\N	\N	\N
2072	2025-12-04 04:24:02.715298	2025-12-04 04:24:02.715298	Wednesday	1530	1730	290	\N	\N	\N	\N
2073	2025-12-04 04:24:02.716062	2025-12-04 04:24:02.716062	Friday	715	1830	290	\N	\N	\N	\N
2074	2025-12-04 04:24:02.716847	2025-12-04 04:24:02.716847	Saturday	15	145	290	\N	\N	\N	\N
2075	2025-12-04 04:24:02.717581	2025-12-04 04:24:02.717581	Saturday	400	2015	290	\N	\N	\N	\N
2076	2025-12-04 04:24:02.718368	2025-12-04 04:24:02.718368	Sunday	1045	1115	290	\N	\N	\N	\N
2077	2025-12-04 04:24:02.71906	2025-12-04 04:24:02.71906	Sunday	1715	1830	290	\N	\N	\N	\N
2078	2025-12-04 04:24:02.72529	2025-12-04 04:24:02.72529	Monday	1545	1615	291	\N	\N	\N	\N
2079	2025-12-04 04:24:02.726056	2025-12-04 04:24:02.726056	Monday	2315	815	291	\N	\N	\N	\N
2080	2025-12-04 04:24:02.726809	2025-12-04 04:24:02.726809	Tuesday	830	1630	291	\N	\N	\N	\N
2081	2025-12-04 04:24:02.727558	2025-12-04 04:24:02.727558	Wednesday	645	1930	291	\N	\N	\N	\N
2082	2025-12-04 04:24:02.728385	2025-12-04 04:24:02.728385	Thursday	345	445	291	\N	\N	\N	\N
2083	2025-12-04 04:24:02.72907	2025-12-04 04:24:02.72907	Thursday	945	2030	291	\N	\N	\N	\N
2084	2025-12-04 04:24:02.729822	2025-12-04 04:24:02.729822	Friday	1800	400	291	\N	\N	\N	\N
2085	2025-12-04 04:24:02.730586	2025-12-04 04:24:02.730586	Saturday	2045	245	291	\N	\N	\N	\N
2086	2025-12-04 04:24:02.731362	2025-12-04 04:24:02.731362	Sunday	915	1500	291	\N	\N	\N	\N
2087	2025-12-04 04:24:02.742887	2025-12-04 04:24:02.742887	Monday	930	2200	292	\N	\N	\N	\N
2088	2025-12-04 04:24:02.743702	2025-12-04 04:24:02.743702	Wednesday	2130	330	292	\N	\N	\N	\N
2089	2025-12-04 04:24:02.744494	2025-12-04 04:24:02.744494	Thursday	1930	345	292	\N	\N	\N	\N
2090	2025-12-04 04:24:02.749786	2025-12-04 04:24:02.749786	Tuesday	2145	345	293	\N	\N	\N	\N
2091	2025-12-04 04:24:02.750551	2025-12-04 04:24:02.750551	Wednesday	945	2045	293	\N	\N	\N	\N
2092	2025-12-04 04:24:02.751367	2025-12-04 04:24:02.751367	Thursday	500	1530	293	\N	\N	\N	\N
2093	2025-12-04 04:24:02.752117	2025-12-04 04:24:02.752117	Thursday	2100	2200	293	\N	\N	\N	\N
2094	2025-12-04 04:24:02.752893	2025-12-04 04:24:02.752893	Friday	930	1500	293	\N	\N	\N	\N
2095	2025-12-04 04:24:02.753657	2025-12-04 04:24:02.753657	Saturday	745	2045	293	\N	\N	\N	\N
2096	2025-12-04 04:24:02.754372	2025-12-04 04:24:02.754372	Sunday	745	2245	293	\N	\N	\N	\N
2097	2025-12-04 04:24:02.766603	2025-12-04 04:24:02.766603	Monday	1000	1400	294	\N	\N	\N	\N
2098	2025-12-04 04:24:02.767407	2025-12-04 04:24:02.767407	Tuesday	830	1815	294	\N	\N	\N	\N
2099	2025-12-04 04:24:02.768191	2025-12-04 04:24:02.768191	Wednesday	745	2200	294	\N	\N	\N	\N
2100	2025-12-04 04:24:02.768949	2025-12-04 04:24:02.768949	Thursday	845	1930	294	\N	\N	\N	\N
2101	2025-12-04 04:24:02.769748	2025-12-04 04:24:02.769748	Friday	830	1915	294	\N	\N	\N	\N
2102	2025-12-04 04:24:02.770499	2025-12-04 04:24:02.770499	Saturday	645	2030	294	\N	\N	\N	\N
2103	2025-12-04 04:24:02.771535	2025-12-04 04:24:02.771535	Sunday	700	1800	294	\N	\N	\N	\N
2104	2025-12-04 04:24:02.77775	2025-12-04 04:24:02.77775	Monday	630	845	295	\N	\N	\N	\N
2105	2025-12-04 04:24:02.778542	2025-12-04 04:24:02.778542	Monday	1145	1330	295	\N	\N	\N	\N
2106	2025-12-04 04:24:02.779323	2025-12-04 04:24:02.779323	Tuesday	645	1915	295	\N	\N	\N	\N
2107	2025-12-04 04:24:02.78028	2025-12-04 04:24:02.78028	Wednesday	1630	1945	295	\N	\N	\N	\N
2108	2025-12-04 04:24:02.781009	2025-12-04 04:24:02.781009	Wednesday	2130	1345	295	\N	\N	\N	\N
2109	2025-12-04 04:24:02.781792	2025-12-04 04:24:02.781792	Friday	730	1400	295	\N	\N	\N	\N
2110	2025-12-04 04:24:02.782551	2025-12-04 04:24:02.782551	Saturday	745	1745	295	\N	\N	\N	\N
2111	2025-12-04 04:24:02.783327	2025-12-04 04:24:02.783327	Sunday	145	215	295	\N	\N	\N	\N
2112	2025-12-04 04:24:02.78413	2025-12-04 04:24:02.78413	Sunday	1700	1715	295	\N	\N	\N	\N
2113	2025-12-04 04:24:02.795839	2025-12-04 04:24:02.795839	Monday	845	1700	296	\N	\N	\N	\N
2114	2025-12-04 04:24:02.796613	2025-12-04 04:24:02.796613	Tuesday	645	2130	296	\N	\N	\N	\N
2115	2025-12-04 04:24:02.797402	2025-12-04 04:24:02.797402	Wednesday	100	130	296	\N	\N	\N	\N
2116	2025-12-04 04:24:02.798195	2025-12-04 04:24:02.798195	Wednesday	600	1300	296	\N	\N	\N	\N
2117	2025-12-04 04:24:02.799101	2025-12-04 04:24:02.799101	Thursday	630	1845	296	\N	\N	\N	\N
2118	2025-12-04 04:24:02.79987	2025-12-04 04:24:02.79987	Friday	730	1830	296	\N	\N	\N	\N
2119	2025-12-04 04:24:02.800672	2025-12-04 04:24:02.800672	Saturday	630	1515	296	\N	\N	\N	\N
2120	2025-12-04 04:24:02.801435	2025-12-04 04:24:02.801435	Saturday	2015	2145	296	\N	\N	\N	\N
2121	2025-12-04 04:24:02.802253	2025-12-04 04:24:02.802253	Sunday	2130	200	296	\N	\N	\N	\N
2122	2025-12-04 04:24:02.808589	2025-12-04 04:24:02.808589	Monday	245	1115	297	\N	\N	\N	\N
2123	2025-12-04 04:24:02.809374	2025-12-04 04:24:02.809374	Monday	1245	1930	297	\N	\N	\N	\N
2124	2025-12-04 04:24:02.810123	2025-12-04 04:24:02.810123	Tuesday	645	1730	297	\N	\N	\N	\N
2125	2025-12-04 04:24:02.810881	2025-12-04 04:24:02.810881	Wednesday	800	1830	297	\N	\N	\N	\N
2126	2025-12-04 04:24:02.811649	2025-12-04 04:24:02.811649	Thursday	2000	200	297	\N	\N	\N	\N
2127	2025-12-04 04:24:02.812401	2025-12-04 04:24:02.812401	Friday	915	2245	297	\N	\N	\N	\N
2128	2025-12-04 04:24:02.813182	2025-12-04 04:24:02.813182	Saturday	700	1430	297	\N	\N	\N	\N
2129	2025-12-04 04:24:02.813962	2025-12-04 04:24:02.813962	Sunday	215	1115	297	\N	\N	\N	\N
2130	2025-12-04 04:24:02.814679	2025-12-04 04:24:02.814679	Sunday	1730	2045	297	\N	\N	\N	\N
2131	2025-12-04 04:24:02.826216	2025-12-04 04:24:02.826216	Monday	1730	200	298	\N	\N	\N	\N
2132	2025-12-04 04:24:02.826994	2025-12-04 04:24:02.826994	Tuesday	745	2315	298	\N	\N	\N	\N
2133	2025-12-04 04:24:02.827794	2025-12-04 04:24:02.827794	Wednesday	730	2030	298	\N	\N	\N	\N
2134	2025-12-04 04:24:02.828548	2025-12-04 04:24:02.828548	Thursday	615	1730	298	\N	\N	\N	\N
2135	2025-12-04 04:24:02.829337	2025-12-04 04:24:02.829337	Friday	1530	200	298	\N	\N	\N	\N
2136	2025-12-04 04:24:02.830124	2025-12-04 04:24:02.830124	Saturday	1845	400	298	\N	\N	\N	\N
2137	2025-12-04 04:24:02.830862	2025-12-04 04:24:02.830862	Sunday	945	2300	298	\N	\N	\N	\N
2138	2025-12-04 04:24:02.836596	2025-12-04 04:24:02.836596	Monday	645	1800	299	\N	\N	\N	\N
2139	2025-12-04 04:24:02.83747	2025-12-04 04:24:02.83747	Tuesday	1730	330	299	\N	\N	\N	\N
2140	2025-12-04 04:24:02.838499	2025-12-04 04:24:02.838499	Wednesday	630	2015	299	\N	\N	\N	\N
2141	2025-12-04 04:24:02.839315	2025-12-04 04:24:02.839315	Friday	1000	1445	299	\N	\N	\N	\N
2142	2025-12-04 04:24:02.840097	2025-12-04 04:24:02.840097	Saturday	600	1615	299	\N	\N	\N	\N
2143	2025-12-04 04:24:02.840831	2025-12-04 04:24:02.840831	Sunday	800	2245	299	\N	\N	\N	\N
2144	2025-12-04 04:24:02.849936	2025-12-04 04:24:02.849936	Monday	1815	245	300	\N	\N	\N	\N
2145	2025-12-04 04:24:02.850727	2025-12-04 04:24:02.850727	Tuesday	830	1400	300	\N	\N	\N	\N
2146	2025-12-04 04:24:02.851461	2025-12-04 04:24:02.851461	Wednesday	830	1645	300	\N	\N	\N	\N
2147	2025-12-04 04:24:02.852294	2025-12-04 04:24:02.852294	Thursday	1900	2215	300	\N	\N	\N	\N
2148	2025-12-04 04:24:02.853064	2025-12-04 04:24:02.853064	Thursday	2315	1000	300	\N	\N	\N	\N
2149	2025-12-04 04:24:02.853851	2025-12-04 04:24:02.853851	Friday	845	1915	300	\N	\N	\N	\N
2150	2025-12-04 04:24:02.854614	2025-12-04 04:24:02.854614	Saturday	1900	330	300	\N	\N	\N	\N
2151	2025-12-04 04:24:02.866563	2025-12-04 04:24:02.866563	Monday	830	1830	301	\N	\N	\N	\N
2152	2025-12-04 04:24:02.867345	2025-12-04 04:24:02.867345	Wednesday	930	2030	301	\N	\N	\N	\N
2153	2025-12-04 04:24:02.86808	2025-12-04 04:24:02.86808	Thursday	715	1730	301	\N	\N	\N	\N
2154	2025-12-04 04:24:02.868869	2025-12-04 04:24:02.868869	Friday	0	945	301	\N	\N	\N	\N
2155	2025-12-04 04:24:02.869619	2025-12-04 04:24:02.869619	Friday	1400	2400	301	\N	\N	\N	\N
2156	2025-12-04 04:24:02.870374	2025-12-04 04:24:02.870374	Saturday	900	2315	301	\N	\N	\N	\N
2157	2025-12-04 04:24:02.871126	2025-12-04 04:24:02.871126	Sunday	130	615	301	\N	\N	\N	\N
2158	2025-12-04 04:24:02.871866	2025-12-04 04:24:02.871866	Sunday	1230	2300	301	\N	\N	\N	\N
2159	2025-12-04 04:24:02.878387	2025-12-04 04:24:02.878387	Monday	415	1430	302	\N	\N	\N	\N
2160	2025-12-04 04:24:02.879109	2025-12-04 04:24:02.879109	Monday	1800	2030	302	\N	\N	\N	\N
2161	2025-12-04 04:24:02.879893	2025-12-04 04:24:02.879893	Tuesday	715	2015	302	\N	\N	\N	\N
2162	2025-12-04 04:24:02.880696	2025-12-04 04:24:02.880696	Wednesday	530	1500	302	\N	\N	\N	\N
2163	2025-12-04 04:24:02.881432	2025-12-04 04:24:02.881432	Wednesday	1545	1715	302	\N	\N	\N	\N
2164	2025-12-04 04:24:02.882193	2025-12-04 04:24:02.882193	Friday	715	1930	302	\N	\N	\N	\N
2165	2025-12-04 04:24:02.882934	2025-12-04 04:24:02.882934	Saturday	715	2015	302	\N	\N	\N	\N
2166	2025-12-04 04:24:02.883653	2025-12-04 04:24:02.883653	Sunday	815	1930	302	\N	\N	\N	\N
2167	2025-12-04 04:24:02.895553	2025-12-04 04:24:02.895553	Monday	915	2145	303	\N	\N	\N	\N
2168	2025-12-04 04:24:02.896311	2025-12-04 04:24:02.896311	Tuesday	915	2100	303	\N	\N	\N	\N
2169	2025-12-04 04:24:02.897112	2025-12-04 04:24:02.897112	Wednesday	330	1230	303	\N	\N	\N	\N
2170	2025-12-04 04:24:02.897887	2025-12-04 04:24:02.897887	Wednesday	1900	2345	303	\N	\N	\N	\N
2171	2025-12-04 04:24:02.898672	2025-12-04 04:24:02.898672	Thursday	700	1900	303	\N	\N	\N	\N
2172	2025-12-04 04:24:02.89944	2025-12-04 04:24:02.89944	Saturday	845	1700	303	\N	\N	\N	\N
2173	2025-12-04 04:24:02.900229	2025-12-04 04:24:02.900229	Sunday	1530	315	303	\N	\N	\N	\N
2174	2025-12-04 04:24:02.906315	2025-12-04 04:24:02.906315	Monday	900	2030	304	\N	\N	\N	\N
2175	2025-12-04 04:24:02.907263	2025-12-04 04:24:02.907263	Monday	2045	30	304	\N	\N	\N	\N
2176	2025-12-04 04:24:02.908057	2025-12-04 04:24:02.908057	Tuesday	900	1500	304	\N	\N	\N	\N
2177	2025-12-04 04:24:02.908821	2025-12-04 04:24:02.908821	Wednesday	130	915	304	\N	\N	\N	\N
2178	2025-12-04 04:24:02.909543	2025-12-04 04:24:02.909543	Wednesday	1330	1415	304	\N	\N	\N	\N
2179	2025-12-04 04:24:02.910341	2025-12-04 04:24:02.910341	Thursday	15	215	304	\N	\N	\N	\N
2180	2025-12-04 04:24:02.911084	2025-12-04 04:24:02.911084	Thursday	915	1845	304	\N	\N	\N	\N
2181	2025-12-04 04:24:02.9119	2025-12-04 04:24:02.9119	Saturday	915	1415	304	\N	\N	\N	\N
2182	2025-12-04 04:24:02.912616	2025-12-04 04:24:02.912616	Sunday	2200	400	304	\N	\N	\N	\N
2183	2025-12-04 04:24:02.92239	2025-12-04 04:24:02.92239	Monday	1915	215	305	\N	\N	\N	\N
2184	2025-12-04 04:24:02.92325	2025-12-04 04:24:02.92325	Tuesday	445	1245	305	\N	\N	\N	\N
2185	2025-12-04 04:24:02.924018	2025-12-04 04:24:02.924018	Tuesday	1345	2345	305	\N	\N	\N	\N
2186	2025-12-04 04:24:02.924783	2025-12-04 04:24:02.924783	Wednesday	715	1730	305	\N	\N	\N	\N
2187	2025-12-04 04:24:02.925548	2025-12-04 04:24:02.925548	Thursday	945	2400	305	\N	\N	\N	\N
2188	2025-12-04 04:24:02.926352	2025-12-04 04:24:02.926352	Saturday	1700	100	305	\N	\N	\N	\N
2189	2025-12-04 04:24:02.940074	2025-12-04 04:24:02.940074	Monday	915	1815	306	\N	\N	\N	\N
2190	2025-12-04 04:24:02.940972	2025-12-04 04:24:02.940972	Tuesday	630	2215	306	\N	\N	\N	\N
2191	2025-12-04 04:24:02.941753	2025-12-04 04:24:02.941753	Wednesday	700	1645	306	\N	\N	\N	\N
2192	2025-12-04 04:24:02.942515	2025-12-04 04:24:02.942515	Thursday	2130	400	306	\N	\N	\N	\N
2193	2025-12-04 04:24:02.943305	2025-12-04 04:24:02.943305	Saturday	630	2000	306	\N	\N	\N	\N
2194	2025-12-04 04:24:02.949511	2025-12-04 04:24:02.949511	Monday	1445	1630	307	\N	\N	\N	\N
2195	2025-12-04 04:24:02.950306	2025-12-04 04:24:02.950306	Monday	2045	845	307	\N	\N	\N	\N
2196	2025-12-04 04:24:02.951124	2025-12-04 04:24:02.951124	Tuesday	2030	315	307	\N	\N	\N	\N
2197	2025-12-04 04:24:02.951913	2025-12-04 04:24:02.951913	Wednesday	2000	330	307	\N	\N	\N	\N
2198	2025-12-04 04:24:02.952696	2025-12-04 04:24:02.952696	Thursday	630	845	307	\N	\N	\N	\N
2199	2025-12-04 04:24:02.953427	2025-12-04 04:24:02.953427	Thursday	1915	1945	307	\N	\N	\N	\N
2200	2025-12-04 04:24:02.954181	2025-12-04 04:24:02.954181	Friday	630	1900	307	\N	\N	\N	\N
2201	2025-12-04 04:24:02.954958	2025-12-04 04:24:02.954958	Saturday	645	830	307	\N	\N	\N	\N
2202	2025-12-04 04:24:02.955696	2025-12-04 04:24:02.955696	Saturday	900	1745	307	\N	\N	\N	\N
2203	2025-12-04 04:24:02.956441	2025-12-04 04:24:02.956441	Sunday	745	2215	307	\N	\N	\N	\N
2204	2025-12-04 04:24:02.968333	2025-12-04 04:24:02.968333	Monday	1630	2145	308	\N	\N	\N	\N
2205	2025-12-04 04:24:02.96907	2025-12-04 04:24:02.96907	Monday	2215	1445	308	\N	\N	\N	\N
2206	2025-12-04 04:24:02.969789	2025-12-04 04:24:02.969789	Tuesday	1000	1415	308	\N	\N	\N	\N
2207	2025-12-04 04:24:02.97073	2025-12-04 04:24:02.97073	Wednesday	630	2200	308	\N	\N	\N	\N
2208	2025-12-04 04:24:02.97171	2025-12-04 04:24:02.97171	Thursday	315	1245	308	\N	\N	\N	\N
2209	2025-12-04 04:24:02.972544	2025-12-04 04:24:02.972544	Thursday	1745	1945	308	\N	\N	\N	\N
2210	2025-12-04 04:24:02.973443	2025-12-04 04:24:02.973443	Saturday	900	2245	308	\N	\N	\N	\N
2211	2025-12-04 04:24:02.988588	2025-12-04 04:24:02.988588	Monday	645	1600	309	\N	\N	\N	\N
2212	2025-12-04 04:24:02.989495	2025-12-04 04:24:02.989495	Wednesday	930	2200	309	\N	\N	\N	\N
2213	2025-12-04 04:24:02.990373	2025-12-04 04:24:02.990373	Thursday	1645	1830	309	\N	\N	\N	\N
2214	2025-12-04 04:24:02.99113	2025-12-04 04:24:02.99113	Thursday	2215	2400	309	\N	\N	\N	\N
2215	2025-12-04 04:24:02.991943	2025-12-04 04:24:02.991943	Friday	1630	300	309	\N	\N	\N	\N
2216	2025-12-04 04:24:02.992698	2025-12-04 04:24:02.992698	Saturday	615	2030	309	\N	\N	\N	\N
2217	2025-12-04 04:24:02.993488	2025-12-04 04:24:02.993488	Sunday	1745	100	309	\N	\N	\N	\N
2218	2025-12-04 04:24:03.006083	2025-12-04 04:24:03.006083	Tuesday	845	1445	310	\N	\N	\N	\N
2219	2025-12-04 04:24:03.006899	2025-12-04 04:24:03.006899	Thursday	0	845	310	\N	\N	\N	\N
2220	2025-12-04 04:24:03.007679	2025-12-04 04:24:03.007679	Thursday	1345	2400	310	\N	\N	\N	\N
2221	2025-12-04 04:24:03.008467	2025-12-04 04:24:03.008467	Saturday	245	1030	310	\N	\N	\N	\N
2222	2025-12-04 04:24:03.009227	2025-12-04 04:24:03.009227	Saturday	1830	2100	310	\N	\N	\N	\N
2223	2025-12-04 04:24:03.010023	2025-12-04 04:24:03.010023	Sunday	915	2000	310	\N	\N	\N	\N
2224	2025-12-04 04:24:03.015958	2025-12-04 04:24:03.015958	Monday	1945	230	311	\N	\N	\N	\N
2225	2025-12-04 04:24:03.016741	2025-12-04 04:24:03.016741	Tuesday	800	1615	311	\N	\N	\N	\N
2226	2025-12-04 04:24:03.017528	2025-12-04 04:24:03.017528	Wednesday	530	1000	311	\N	\N	\N	\N
2227	2025-12-04 04:24:03.018363	2025-12-04 04:24:03.018363	Wednesday	1130	1945	311	\N	\N	\N	\N
2228	2025-12-04 04:24:03.019204	2025-12-04 04:24:03.019204	Thursday	845	1545	311	\N	\N	\N	\N
2229	2025-12-04 04:24:03.020074	2025-12-04 04:24:03.020074	Saturday	45	630	311	\N	\N	\N	\N
2230	2025-12-04 04:24:03.020778	2025-12-04 04:24:03.020778	Saturday	1700	1800	311	\N	\N	\N	\N
2231	2025-12-04 04:24:03.021548	2025-12-04 04:24:03.021548	Sunday	715	1515	311	\N	\N	\N	\N
2232	2025-12-04 04:24:03.031215	2025-12-04 04:24:03.031215	Monday	1015	2045	312	\N	\N	\N	\N
2233	2025-12-04 04:24:03.031988	2025-12-04 04:24:03.031988	Monday	2215	700	312	\N	\N	\N	\N
2234	2025-12-04 04:24:03.032805	2025-12-04 04:24:03.032805	Tuesday	0	1330	312	\N	\N	\N	\N
2235	2025-12-04 04:24:03.033526	2025-12-04 04:24:03.033526	Tuesday	1600	2230	312	\N	\N	\N	\N
2236	2025-12-04 04:24:03.03435	2025-12-04 04:24:03.03435	Thursday	1000	2200	312	\N	\N	\N	\N
2237	2025-12-04 04:24:03.035148	2025-12-04 04:24:03.035148	Friday	815	1400	312	\N	\N	\N	\N
2238	2025-12-04 04:24:03.035924	2025-12-04 04:24:03.035924	Saturday	1000	2030	312	\N	\N	\N	\N
2239	2025-12-04 04:24:03.036793	2025-12-04 04:24:03.036793	Sunday	815	1545	312	\N	\N	\N	\N
2240	2025-12-04 04:24:03.048736	2025-12-04 04:24:03.048736	Monday	645	1745	313	\N	\N	\N	\N
2241	2025-12-04 04:24:03.049541	2025-12-04 04:24:03.049541	Tuesday	700	1800	313	\N	\N	\N	\N
2242	2025-12-04 04:24:03.050339	2025-12-04 04:24:03.050339	Friday	800	2330	313	\N	\N	\N	\N
2243	2025-12-04 04:24:03.051122	2025-12-04 04:24:03.051122	Saturday	545	1030	313	\N	\N	\N	\N
2244	2025-12-04 04:24:03.051898	2025-12-04 04:24:03.051898	Saturday	1845	115	313	\N	\N	\N	\N
2245	2025-12-04 04:24:03.057912	2025-12-04 04:24:03.057912	Monday	715	1945	314	\N	\N	\N	\N
2246	2025-12-04 04:24:03.058764	2025-12-04 04:24:03.058764	Tuesday	430	900	314	\N	\N	\N	\N
2247	2025-12-04 04:24:03.059486	2025-12-04 04:24:03.059486	Tuesday	1545	1630	314	\N	\N	\N	\N
2248	2025-12-04 04:24:03.060282	2025-12-04 04:24:03.060282	Wednesday	930	1715	314	\N	\N	\N	\N
2249	2025-12-04 04:24:03.06105	2025-12-04 04:24:03.06105	Thursday	730	2000	314	\N	\N	\N	\N
2250	2025-12-04 04:24:03.06179	2025-12-04 04:24:03.06179	Friday	915	2300	314	\N	\N	\N	\N
2251	2025-12-04 04:24:03.073728	2025-12-04 04:24:03.073728	Monday	730	2245	315	\N	\N	\N	\N
2252	2025-12-04 04:24:03.074546	2025-12-04 04:24:03.074546	Tuesday	615	1645	315	\N	\N	\N	\N
2253	2025-12-04 04:24:03.075348	2025-12-04 04:24:03.075348	Wednesday	830	2030	315	\N	\N	\N	\N
2254	2025-12-04 04:24:03.076091	2025-12-04 04:24:03.076091	Thursday	745	1645	315	\N	\N	\N	\N
2255	2025-12-04 04:24:03.076842	2025-12-04 04:24:03.076842	Friday	800	2230	315	\N	\N	\N	\N
2256	2025-12-04 04:24:03.077624	2025-12-04 04:24:03.077624	Saturday	645	1745	315	\N	\N	\N	\N
2257	2025-12-04 04:24:03.078442	2025-12-04 04:24:03.078442	Sunday	1230	1545	315	\N	\N	\N	\N
2258	2025-12-04 04:24:03.079173	2025-12-04 04:24:03.079173	Sunday	2330	215	315	\N	\N	\N	\N
2259	2025-12-04 04:24:03.084937	2025-12-04 04:24:03.084937	Tuesday	1945	315	316	\N	\N	\N	\N
2260	2025-12-04 04:24:03.085759	2025-12-04 04:24:03.085759	Thursday	45	1045	316	\N	\N	\N	\N
2261	2025-12-04 04:24:03.086516	2025-12-04 04:24:03.086516	Thursday	1545	1945	316	\N	\N	\N	\N
2262	2025-12-04 04:24:03.087327	2025-12-04 04:24:03.087327	Friday	630	1400	316	\N	\N	\N	\N
2263	2025-12-04 04:24:03.088065	2025-12-04 04:24:03.088065	Saturday	845	1730	316	\N	\N	\N	\N
2264	2025-12-04 04:24:03.088819	2025-12-04 04:24:03.088819	Sunday	1445	245	316	\N	\N	\N	\N
2265	2025-12-04 04:24:03.101106	2025-12-04 04:24:03.101106	Wednesday	1000	1645	317	\N	\N	\N	\N
2266	2025-12-04 04:24:03.101852	2025-12-04 04:24:03.101852	Friday	830	2100	317	\N	\N	\N	\N
2267	2025-12-04 04:24:03.10264	2025-12-04 04:24:03.10264	Saturday	845	1900	317	\N	\N	\N	\N
2268	2025-12-04 04:24:03.108416	2025-12-04 04:24:03.108416	Monday	915	1415	318	\N	\N	\N	\N
2269	2025-12-04 04:24:03.109193	2025-12-04 04:24:03.109193	Tuesday	815	1400	318	\N	\N	\N	\N
2270	2025-12-04 04:24:03.109978	2025-12-04 04:24:03.109978	Wednesday	0	315	318	\N	\N	\N	\N
2271	2025-12-04 04:24:03.110723	2025-12-04 04:24:03.110723	Wednesday	1615	2400	318	\N	\N	\N	\N
2272	2025-12-04 04:24:03.111495	2025-12-04 04:24:03.111495	Thursday	945	2330	318	\N	\N	\N	\N
2273	2025-12-04 04:24:03.112242	2025-12-04 04:24:03.112242	Friday	600	2300	318	\N	\N	\N	\N
2274	2025-12-04 04:24:03.112967	2025-12-04 04:24:03.112967	Saturday	945	1830	318	\N	\N	\N	\N
2275	2025-12-04 04:24:03.113785	2025-12-04 04:24:03.113785	Sunday	845	1115	318	\N	\N	\N	\N
2276	2025-12-04 04:24:03.114531	2025-12-04 04:24:03.114531	Sunday	1345	145	318	\N	\N	\N	\N
2277	2025-12-04 04:24:03.128911	2025-12-04 04:24:03.128911	Monday	945	2030	319	\N	\N	\N	\N
2278	2025-12-04 04:24:03.129771	2025-12-04 04:24:03.129771	Tuesday	745	2130	319	\N	\N	\N	\N
2279	2025-12-04 04:24:03.130569	2025-12-04 04:24:03.130569	Wednesday	100	1000	319	\N	\N	\N	\N
2280	2025-12-04 04:24:03.1313	2025-12-04 04:24:03.1313	Wednesday	1030	2330	319	\N	\N	\N	\N
2281	2025-12-04 04:24:03.132087	2025-12-04 04:24:03.132087	Friday	2015	400	319	\N	\N	\N	\N
2282	2025-12-04 04:24:03.13284	2025-12-04 04:24:03.13284	Saturday	930	2315	319	\N	\N	\N	\N
2283	2025-12-04 04:24:03.133623	2025-12-04 04:24:03.133623	Sunday	1600	145	319	\N	\N	\N	\N
2284	2025-12-04 04:24:03.13944	2025-12-04 04:24:03.13944	Tuesday	615	1415	320	\N	\N	\N	\N
2285	2025-12-04 04:24:03.140208	2025-12-04 04:24:03.140208	Friday	700	1630	320	\N	\N	\N	\N
2286	2025-12-04 04:24:03.140943	2025-12-04 04:24:03.140943	Saturday	845	2145	320	\N	\N	\N	\N
2287	2025-12-04 04:24:03.152524	2025-12-04 04:24:03.152524	Monday	630	1230	321	\N	\N	\N	\N
2288	2025-12-04 04:24:03.153306	2025-12-04 04:24:03.153306	Monday	2115	15	321	\N	\N	\N	\N
2289	2025-12-04 04:24:03.154181	2025-12-04 04:24:03.154181	Thursday	845	1430	321	\N	\N	\N	\N
2290	2025-12-04 04:24:03.155109	2025-12-04 04:24:03.155109	Sunday	645	1715	321	\N	\N	\N	\N
2291	2025-12-04 04:24:03.161254	2025-12-04 04:24:03.161254	Monday	730	1830	322	\N	\N	\N	\N
2292	2025-12-04 04:24:03.162015	2025-12-04 04:24:03.162015	Tuesday	615	1815	322	\N	\N	\N	\N
2293	2025-12-04 04:24:03.162785	2025-12-04 04:24:03.162785	Wednesday	915	1630	322	\N	\N	\N	\N
2294	2025-12-04 04:24:03.163549	2025-12-04 04:24:03.163549	Thursday	600	1800	322	\N	\N	\N	\N
2295	2025-12-04 04:24:03.16432	2025-12-04 04:24:03.16432	Friday	1645	230	322	\N	\N	\N	\N
2296	2025-12-04 04:24:03.16508	2025-12-04 04:24:03.16508	Saturday	945	1400	322	\N	\N	\N	\N
2297	2025-12-04 04:24:03.165825	2025-12-04 04:24:03.165825	Sunday	900	1400	322	\N	\N	\N	\N
2298	2025-12-04 04:24:03.177671	2025-12-04 04:24:03.177671	Monday	915	1430	323	\N	\N	\N	\N
2299	2025-12-04 04:24:03.178453	2025-12-04 04:24:03.178453	Tuesday	630	2330	323	\N	\N	\N	\N
2300	2025-12-04 04:24:03.179203	2025-12-04 04:24:03.179203	Wednesday	1400	130	323	\N	\N	\N	\N
2301	2025-12-04 04:24:03.179982	2025-12-04 04:24:03.179982	Thursday	900	1845	323	\N	\N	\N	\N
2302	2025-12-04 04:24:03.180729	2025-12-04 04:24:03.180729	Friday	1000	1400	323	\N	\N	\N	\N
2303	2025-12-04 04:24:03.18152	2025-12-04 04:24:03.18152	Saturday	2130	130	323	\N	\N	\N	\N
2304	2025-12-04 04:24:03.182292	2025-12-04 04:24:03.182292	Sunday	1430	200	323	\N	\N	\N	\N
2305	2025-12-04 04:24:03.188062	2025-12-04 04:24:03.188062	Tuesday	800	1745	324	\N	\N	\N	\N
2306	2025-12-04 04:24:03.188878	2025-12-04 04:24:03.188878	Thursday	930	2115	324	\N	\N	\N	\N
2307	2025-12-04 04:24:03.189676	2025-12-04 04:24:03.189676	Sunday	1500	115	324	\N	\N	\N	\N
2308	2025-12-04 04:24:03.202035	2025-12-04 04:24:03.202035	Tuesday	900	1315	325	\N	\N	\N	\N
2309	2025-12-04 04:24:03.203016	2025-12-04 04:24:03.203016	Tuesday	1430	2315	325	\N	\N	\N	\N
2310	2025-12-04 04:24:03.203931	2025-12-04 04:24:03.203931	Wednesday	915	2345	325	\N	\N	\N	\N
2311	2025-12-04 04:24:03.204836	2025-12-04 04:24:03.204836	Thursday	615	2045	325	\N	\N	\N	\N
2312	2025-12-04 04:24:03.205778	2025-12-04 04:24:03.205778	Friday	100	1215	325	\N	\N	\N	\N
2313	2025-12-04 04:24:03.206719	2025-12-04 04:24:03.206719	Friday	1730	2400	325	\N	\N	\N	\N
2314	2025-12-04 04:24:03.207661	2025-12-04 04:24:03.207661	Saturday	1400	1715	325	\N	\N	\N	\N
2315	2025-12-04 04:24:03.208435	2025-12-04 04:24:03.208435	Saturday	2245	315	325	\N	\N	\N	\N
2316	2025-12-04 04:24:03.209271	2025-12-04 04:24:03.209271	Sunday	2100	145	325	\N	\N	\N	\N
2317	2025-12-04 04:24:03.215448	2025-12-04 04:24:03.215448	Monday	300	330	326	\N	\N	\N	\N
2318	2025-12-04 04:24:03.216184	2025-12-04 04:24:03.216184	Monday	930	1715	326	\N	\N	\N	\N
2319	2025-12-04 04:24:03.216973	2025-12-04 04:24:03.216973	Tuesday	745	1400	326	\N	\N	\N	\N
2320	2025-12-04 04:24:03.217743	2025-12-04 04:24:03.217743	Wednesday	1000	1915	326	\N	\N	\N	\N
2321	2025-12-04 04:24:03.218546	2025-12-04 04:24:03.218546	Thursday	730	1615	326	\N	\N	\N	\N
2322	2025-12-04 04:24:03.219384	2025-12-04 04:24:03.219384	Friday	830	2015	326	\N	\N	\N	\N
2323	2025-12-04 04:24:03.220116	2025-12-04 04:24:03.220116	Saturday	2100	200	326	\N	\N	\N	\N
2324	2025-12-04 04:24:03.220862	2025-12-04 04:24:03.220862	Sunday	1000	2100	326	\N	\N	\N	\N
2325	2025-12-04 04:24:03.233967	2025-12-04 04:24:03.233967	Monday	2230	115	327	\N	\N	\N	\N
2326	2025-12-04 04:24:03.23481	2025-12-04 04:24:03.23481	Tuesday	400	1400	327	\N	\N	\N	\N
2327	2025-12-04 04:24:03.235563	2025-12-04 04:24:03.235563	Tuesday	1430	1715	327	\N	\N	\N	\N
2328	2025-12-04 04:24:03.236339	2025-12-04 04:24:03.236339	Wednesday	815	2130	327	\N	\N	\N	\N
2329	2025-12-04 04:24:03.237126	2025-12-04 04:24:03.237126	Thursday	2000	245	327	\N	\N	\N	\N
2330	2025-12-04 04:24:03.23789	2025-12-04 04:24:03.23789	Friday	800	2145	327	\N	\N	\N	\N
2331	2025-12-04 04:24:03.238669	2025-12-04 04:24:03.238669	Saturday	630	2230	327	\N	\N	\N	\N
2332	2025-12-04 04:24:03.239426	2025-12-04 04:24:03.239426	Sunday	715	2100	327	\N	\N	\N	\N
2333	2025-12-04 04:24:03.245419	2025-12-04 04:24:03.245419	Monday	600	1545	328	\N	\N	\N	\N
2334	2025-12-04 04:24:03.248466	2025-12-04 04:24:03.248466	Tuesday	800	1430	328	\N	\N	\N	\N
2335	2025-12-04 04:24:03.24938	2025-12-04 04:24:03.24938	Thursday	900	1445	328	\N	\N	\N	\N
2336	2025-12-04 04:24:03.250214	2025-12-04 04:24:03.250214	Saturday	915	1600	328	\N	\N	\N	\N
2337	2025-12-04 04:24:03.25099	2025-12-04 04:24:03.25099	Saturday	1930	2215	328	\N	\N	\N	\N
2338	2025-12-04 04:24:03.251822	2025-12-04 04:24:03.251822	Sunday	730	1015	328	\N	\N	\N	\N
2339	2025-12-04 04:24:03.252605	2025-12-04 04:24:03.252605	Sunday	1230	1300	328	\N	\N	\N	\N
2340	2025-12-04 04:24:03.261693	2025-12-04 04:24:03.261693	Monday	1445	1900	329	\N	\N	\N	\N
2341	2025-12-04 04:24:03.262462	2025-12-04 04:24:03.262462	Monday	2015	645	329	\N	\N	\N	\N
2342	2025-12-04 04:24:03.263263	2025-12-04 04:24:03.263263	Wednesday	730	1400	329	\N	\N	\N	\N
2343	2025-12-04 04:24:03.264057	2025-12-04 04:24:03.264057	Thursday	1230	1600	329	\N	\N	\N	\N
2344	2025-12-04 04:24:03.264788	2025-12-04 04:24:03.264788	Thursday	1645	2015	329	\N	\N	\N	\N
2345	2025-12-04 04:24:03.26558	2025-12-04 04:24:03.26558	Sunday	845	1545	329	\N	\N	\N	\N
2346	2025-12-04 04:24:03.27775	2025-12-04 04:24:03.27775	Monday	330	1015	330	\N	\N	\N	\N
2347	2025-12-04 04:24:03.27852	2025-12-04 04:24:03.27852	Monday	1045	2230	330	\N	\N	\N	\N
2348	2025-12-04 04:24:03.279325	2025-12-04 04:24:03.279325	Friday	1845	345	330	\N	\N	\N	\N
2349	2025-12-04 04:24:03.280108	2025-12-04 04:24:03.280108	Saturday	845	1515	330	\N	\N	\N	\N
2350	2025-12-04 04:24:03.280892	2025-12-04 04:24:03.280892	Sunday	600	615	330	\N	\N	\N	\N
2351	2025-12-04 04:24:03.281649	2025-12-04 04:24:03.281649	Sunday	1915	30	330	\N	\N	\N	\N
2352	2025-12-04 04:24:03.287425	2025-12-04 04:24:03.287425	Monday	845	2115	331	\N	\N	\N	\N
2353	2025-12-04 04:24:03.288219	2025-12-04 04:24:03.288219	Tuesday	1000	2315	331	\N	\N	\N	\N
2354	2025-12-04 04:24:03.288981	2025-12-04 04:24:03.288981	Wednesday	815	1500	331	\N	\N	\N	\N
2355	2025-12-04 04:24:03.289782	2025-12-04 04:24:03.289782	Thursday	1045	1215	331	\N	\N	\N	\N
2356	2025-12-04 04:24:03.290526	2025-12-04 04:24:03.290526	Thursday	1345	445	331	\N	\N	\N	\N
2357	2025-12-04 04:24:03.291279	2025-12-04 04:24:03.291279	Friday	700	1845	331	\N	\N	\N	\N
2358	2025-12-04 04:24:03.292	2025-12-04 04:24:03.292	Saturday	730	1515	331	\N	\N	\N	\N
2359	2025-12-04 04:24:03.301086	2025-12-04 04:24:03.301086	Monday	815	2045	332	\N	\N	\N	\N
2360	2025-12-04 04:24:03.301831	2025-12-04 04:24:03.301831	Wednesday	915	1845	332	\N	\N	\N	\N
2361	2025-12-04 04:24:03.302829	2025-12-04 04:24:03.302829	Thursday	515	1230	332	\N	\N	\N	\N
2362	2025-12-04 04:24:03.303534	2025-12-04 04:24:03.303534	Thursday	1445	215	332	\N	\N	\N	\N
2363	2025-12-04 04:24:03.304309	2025-12-04 04:24:03.304309	Friday	330	400	332	\N	\N	\N	\N
2364	2025-12-04 04:24:03.305041	2025-12-04 04:24:03.305041	Friday	615	2115	332	\N	\N	\N	\N
2365	2025-12-04 04:24:03.305794	2025-12-04 04:24:03.305794	Saturday	745	2030	332	\N	\N	\N	\N
2366	2025-12-04 04:24:03.306537	2025-12-04 04:24:03.306537	Sunday	945	1430	332	\N	\N	\N	\N
2367	2025-12-04 04:24:03.318168	2025-12-04 04:24:03.318168	Monday	1000	2030	333	\N	\N	\N	\N
2368	2025-12-04 04:24:03.319003	2025-12-04 04:24:03.319003	Tuesday	500	1415	333	\N	\N	\N	\N
2369	2025-12-04 04:24:03.319772	2025-12-04 04:24:03.319772	Tuesday	1600	2245	333	\N	\N	\N	\N
2370	2025-12-04 04:24:03.320533	2025-12-04 04:24:03.320533	Wednesday	945	1945	333	\N	\N	\N	\N
2371	2025-12-04 04:24:03.321272	2025-12-04 04:24:03.321272	Thursday	600	1915	333	\N	\N	\N	\N
2372	2025-12-04 04:24:03.322022	2025-12-04 04:24:03.322022	Friday	900	1730	333	\N	\N	\N	\N
2373	2025-12-04 04:24:03.322776	2025-12-04 04:24:03.322776	Saturday	800	1545	333	\N	\N	\N	\N
2374	2025-12-04 04:24:03.323511	2025-12-04 04:24:03.323511	Sunday	800	2115	333	\N	\N	\N	\N
2375	2025-12-04 04:24:03.32956	2025-12-04 04:24:03.32956	Monday	2115	315	334	\N	\N	\N	\N
2376	2025-12-04 04:24:03.33041	2025-12-04 04:24:03.33041	Tuesday	800	2100	334	\N	\N	\N	\N
2377	2025-12-04 04:24:03.331253	2025-12-04 04:24:03.331253	Wednesday	245	615	334	\N	\N	\N	\N
2378	2025-12-04 04:24:03.332016	2025-12-04 04:24:03.332016	Wednesday	945	2030	334	\N	\N	\N	\N
2379	2025-12-04 04:24:03.332832	2025-12-04 04:24:03.332832	Friday	400	1430	334	\N	\N	\N	\N
2380	2025-12-04 04:24:03.333584	2025-12-04 04:24:03.333584	Friday	1930	2230	334	\N	\N	\N	\N
2381	2025-12-04 04:24:03.334346	2025-12-04 04:24:03.334346	Saturday	715	2115	334	\N	\N	\N	\N
2382	2025-12-04 04:24:03.335108	2025-12-04 04:24:03.335108	Sunday	700	2000	334	\N	\N	\N	\N
2383	2025-12-04 04:24:03.34442	2025-12-04 04:24:03.34442	Monday	815	2315	335	\N	\N	\N	\N
2384	2025-12-04 04:24:03.3452	2025-12-04 04:24:03.3452	Tuesday	745	2100	335	\N	\N	\N	\N
2385	2025-12-04 04:24:03.345957	2025-12-04 04:24:03.345957	Wednesday	815	1815	335	\N	\N	\N	\N
2386	2025-12-04 04:24:03.346725	2025-12-04 04:24:03.346725	Thursday	930	2200	335	\N	\N	\N	\N
2387	2025-12-04 04:24:03.347482	2025-12-04 04:24:03.347482	Friday	2230	400	335	\N	\N	\N	\N
2388	2025-12-04 04:24:03.348224	2025-12-04 04:24:03.348224	Saturday	745	1800	335	\N	\N	\N	\N
2389	2025-12-04 04:24:03.348994	2025-12-04 04:24:03.348994	Sunday	845	1330	335	\N	\N	\N	\N
2390	2025-12-04 04:24:03.349773	2025-12-04 04:24:03.349773	Sunday	1815	2300	335	\N	\N	\N	\N
2391	2025-12-04 04:24:03.36178	2025-12-04 04:24:03.36178	Monday	415	1115	336	\N	\N	\N	\N
2392	2025-12-04 04:24:03.362568	2025-12-04 04:24:03.362568	Monday	1930	2130	336	\N	\N	\N	\N
2393	2025-12-04 04:24:03.363323	2025-12-04 04:24:03.363323	Tuesday	1845	200	336	\N	\N	\N	\N
2394	2025-12-04 04:24:03.364081	2025-12-04 04:24:03.364081	Wednesday	615	2115	336	\N	\N	\N	\N
2395	2025-12-04 04:24:03.364905	2025-12-04 04:24:03.364905	Friday	715	1300	336	\N	\N	\N	\N
2396	2025-12-04 04:24:03.365712	2025-12-04 04:24:03.365712	Friday	1330	1715	336	\N	\N	\N	\N
2397	2025-12-04 04:24:03.366454	2025-12-04 04:24:03.366454	Sunday	815	1845	336	\N	\N	\N	\N
2398	2025-12-04 04:24:03.372332	2025-12-04 04:24:03.372332	Monday	630	1945	337	\N	\N	\N	\N
2399	2025-12-04 04:24:03.373131	2025-12-04 04:24:03.373131	Thursday	945	1415	337	\N	\N	\N	\N
2400	2025-12-04 04:24:03.373879	2025-12-04 04:24:03.373879	Friday	915	2145	337	\N	\N	\N	\N
2401	2025-12-04 04:24:03.374643	2025-12-04 04:24:03.374643	Saturday	2015	330	337	\N	\N	\N	\N
2402	2025-12-04 04:24:03.3754	2025-12-04 04:24:03.3754	Sunday	945	1715	337	\N	\N	\N	\N
2403	2025-12-04 04:24:03.38802	2025-12-04 04:24:03.38802	Monday	600	1545	338	\N	\N	\N	\N
2404	2025-12-04 04:24:03.388909	2025-12-04 04:24:03.388909	Tuesday	115	1500	338	\N	\N	\N	\N
2405	2025-12-04 04:24:03.389676	2025-12-04 04:24:03.389676	Tuesday	1545	1930	338	\N	\N	\N	\N
2406	2025-12-04 04:24:03.390445	2025-12-04 04:24:03.390445	Wednesday	630	2345	338	\N	\N	\N	\N
2407	2025-12-04 04:24:03.391202	2025-12-04 04:24:03.391202	Thursday	2215	145	338	\N	\N	\N	\N
2408	2025-12-04 04:24:03.39196	2025-12-04 04:24:03.39196	Friday	700	1530	338	\N	\N	\N	\N
2409	2025-12-04 04:24:03.392715	2025-12-04 04:24:03.392715	Saturday	1000	1945	338	\N	\N	\N	\N
2410	2025-12-04 04:24:03.39358	2025-12-04 04:24:03.39358	Sunday	330	415	338	\N	\N	\N	\N
2411	2025-12-04 04:24:03.394387	2025-12-04 04:24:03.394387	Sunday	1430	2000	338	\N	\N	\N	\N
2412	2025-12-04 04:24:03.400145	2025-12-04 04:24:03.400145	Monday	915	2300	339	\N	\N	\N	\N
2413	2025-12-04 04:24:03.40093	2025-12-04 04:24:03.40093	Tuesday	945	1630	339	\N	\N	\N	\N
2414	2025-12-04 04:24:03.401719	2025-12-04 04:24:03.401719	Wednesday	1500	145	339	\N	\N	\N	\N
2415	2025-12-04 04:24:03.402445	2025-12-04 04:24:03.402445	Thursday	730	2015	339	\N	\N	\N	\N
2416	2025-12-04 04:24:03.403227	2025-12-04 04:24:03.403227	Friday	230	445	339	\N	\N	\N	\N
2417	2025-12-04 04:24:03.403944	2025-12-04 04:24:03.403944	Friday	545	1415	339	\N	\N	\N	\N
2418	2025-12-04 04:24:03.404721	2025-12-04 04:24:03.404721	Saturday	915	1900	339	\N	\N	\N	\N
2419	2025-12-04 04:24:03.405464	2025-12-04 04:24:03.405464	Sunday	1745	230	339	\N	\N	\N	\N
2420	2025-12-04 04:24:03.414735	2025-12-04 04:24:03.414735	Monday	715	2015	340	\N	\N	\N	\N
2421	2025-12-04 04:24:03.415522	2025-12-04 04:24:03.415522	Tuesday	745	2400	340	\N	\N	\N	\N
2422	2025-12-04 04:24:03.416306	2025-12-04 04:24:03.416306	Wednesday	430	1045	340	\N	\N	\N	\N
2423	2025-12-04 04:24:03.417055	2025-12-04 04:24:03.417055	Wednesday	1615	1645	340	\N	\N	\N	\N
2424	2025-12-04 04:24:03.41785	2025-12-04 04:24:03.41785	Thursday	1830	245	340	\N	\N	\N	\N
2425	2025-12-04 04:24:03.418616	2025-12-04 04:24:03.418616	Saturday	1530	300	340	\N	\N	\N	\N
2426	2025-12-04 04:24:03.430174	2025-12-04 04:24:03.430174	Monday	745	2200	341	\N	\N	\N	\N
2427	2025-12-04 04:24:03.430961	2025-12-04 04:24:03.430961	Tuesday	730	2015	341	\N	\N	\N	\N
2428	2025-12-04 04:24:03.431764	2025-12-04 04:24:03.431764	Wednesday	15	700	341	\N	\N	\N	\N
2429	2025-12-04 04:24:03.432517	2025-12-04 04:24:03.432517	Wednesday	900	2215	341	\N	\N	\N	\N
2430	2025-12-04 04:24:03.433347	2025-12-04 04:24:03.433347	Thursday	15	600	341	\N	\N	\N	\N
2431	2025-12-04 04:24:03.4341	2025-12-04 04:24:03.4341	Thursday	1215	1415	341	\N	\N	\N	\N
2432	2025-12-04 04:24:03.434822	2025-12-04 04:24:03.434822	Friday	915	1530	341	\N	\N	\N	\N
2433	2025-12-04 04:24:03.43562	2025-12-04 04:24:03.43562	Saturday	45	130	341	\N	\N	\N	\N
2434	2025-12-04 04:24:03.436371	2025-12-04 04:24:03.436371	Saturday	1445	1800	341	\N	\N	\N	\N
2435	2025-12-04 04:24:03.442253	2025-12-04 04:24:03.442253	Monday	715	1630	342	\N	\N	\N	\N
2436	2025-12-04 04:24:03.44312	2025-12-04 04:24:03.44312	Tuesday	615	630	342	\N	\N	\N	\N
2437	2025-12-04 04:24:03.443864	2025-12-04 04:24:03.443864	Tuesday	1100	1715	342	\N	\N	\N	\N
2438	2025-12-04 04:24:03.44461	2025-12-04 04:24:03.44461	Friday	800	1815	342	\N	\N	\N	\N
2439	2025-12-04 04:24:03.445403	2025-12-04 04:24:03.445403	Saturday	830	945	342	\N	\N	\N	\N
2440	2025-12-04 04:24:03.44614	2025-12-04 04:24:03.44614	Saturday	1145	1530	342	\N	\N	\N	\N
2441	2025-12-04 04:24:03.446855	2025-12-04 04:24:03.446855	Sunday	915	2330	342	\N	\N	\N	\N
2442	2025-12-04 04:24:03.458649	2025-12-04 04:24:03.458649	Tuesday	915	1730	343	\N	\N	\N	\N
2443	2025-12-04 04:24:03.459467	2025-12-04 04:24:03.459467	Wednesday	615	730	343	\N	\N	\N	\N
2444	2025-12-04 04:24:03.460207	2025-12-04 04:24:03.460207	Wednesday	2215	2345	343	\N	\N	\N	\N
2445	2025-12-04 04:24:03.460988	2025-12-04 04:24:03.460988	Friday	730	2400	343	\N	\N	\N	\N
2446	2025-12-04 04:24:03.461781	2025-12-04 04:24:03.461781	Saturday	115	745	343	\N	\N	\N	\N
2447	2025-12-04 04:24:03.462514	2025-12-04 04:24:03.462514	Saturday	1200	1815	343	\N	\N	\N	\N
2448	2025-12-04 04:24:03.468281	2025-12-04 04:24:03.468281	Monday	600	1415	344	\N	\N	\N	\N
2449	2025-12-04 04:24:03.469039	2025-12-04 04:24:03.469039	Tuesday	900	1415	344	\N	\N	\N	\N
2450	2025-12-04 04:24:03.469809	2025-12-04 04:24:03.469809	Wednesday	1445	400	344	\N	\N	\N	\N
2451	2025-12-04 04:24:03.470604	2025-12-04 04:24:03.470604	Thursday	1000	2015	344	\N	\N	\N	\N
2452	2025-12-04 04:24:03.471744	2025-12-04 04:24:03.471744	Friday	615	2030	344	\N	\N	\N	\N
2453	2025-12-04 04:24:03.472597	2025-12-04 04:24:03.472597	Sunday	715	1500	344	\N	\N	\N	\N
2454	2025-12-04 04:24:03.482779	2025-12-04 04:24:03.482779	Monday	815	2200	345	\N	\N	\N	\N
2455	2025-12-04 04:24:03.483537	2025-12-04 04:24:03.483537	Thursday	900	2100	345	\N	\N	\N	\N
2456	2025-12-04 04:24:03.484349	2025-12-04 04:24:03.484349	Friday	45	1800	345	\N	\N	\N	\N
2457	2025-12-04 04:24:03.485075	2025-12-04 04:24:03.485075	Friday	2245	15	345	\N	\N	\N	\N
2458	2025-12-04 04:24:03.485856	2025-12-04 04:24:03.485856	Saturday	745	2245	345	\N	\N	\N	\N
2459	2025-12-04 04:24:03.486652	2025-12-04 04:24:03.486652	Sunday	2300	145	345	\N	\N	\N	\N
2460	2025-12-04 04:24:03.498297	2025-12-04 04:24:03.498297	Monday	600	1845	346	\N	\N	\N	\N
2461	2025-12-04 04:24:03.499178	2025-12-04 04:24:03.499178	Tuesday	2200	330	346	\N	\N	\N	\N
2462	2025-12-04 04:24:03.499966	2025-12-04 04:24:03.499966	Wednesday	1145	1345	346	\N	\N	\N	\N
2463	2025-12-04 04:24:03.500756	2025-12-04 04:24:03.500756	Wednesday	1515	2245	346	\N	\N	\N	\N
2464	2025-12-04 04:24:03.501541	2025-12-04 04:24:03.501541	Thursday	630	1730	346	\N	\N	\N	\N
2465	2025-12-04 04:24:03.502312	2025-12-04 04:24:03.502312	Friday	1430	330	346	\N	\N	\N	\N
2466	2025-12-04 04:24:03.503039	2025-12-04 04:24:03.503039	Saturday	630	1400	346	\N	\N	\N	\N
2467	2025-12-04 04:24:03.508985	2025-12-04 04:24:03.508985	Monday	930	2245	347	\N	\N	\N	\N
2468	2025-12-04 04:24:03.509784	2025-12-04 04:24:03.509784	Tuesday	245	845	347	\N	\N	\N	\N
2469	2025-12-04 04:24:03.510514	2025-12-04 04:24:03.510514	Tuesday	915	930	347	\N	\N	\N	\N
2470	2025-12-04 04:24:03.511301	2025-12-04 04:24:03.511301	Thursday	615	2400	347	\N	\N	\N	\N
2471	2025-12-04 04:24:03.512061	2025-12-04 04:24:03.512061	Friday	715	2015	347	\N	\N	\N	\N
2472	2025-12-04 04:24:03.512838	2025-12-04 04:24:03.512838	Saturday	1530	115	347	\N	\N	\N	\N
2473	2025-12-04 04:24:03.513557	2025-12-04 04:24:03.513557	Sunday	930	2030	347	\N	\N	\N	\N
2474	2025-12-04 04:24:03.526004	2025-12-04 04:24:03.526004	Monday	915	1630	348	\N	\N	\N	\N
2475	2025-12-04 04:24:03.526771	2025-12-04 04:24:03.526771	Tuesday	815	2000	348	\N	\N	\N	\N
2476	2025-12-04 04:24:03.527539	2025-12-04 04:24:03.527539	Wednesday	930	2230	348	\N	\N	\N	\N
2477	2025-12-04 04:24:03.528304	2025-12-04 04:24:03.528304	Thursday	830	900	348	\N	\N	\N	\N
2478	2025-12-04 04:24:03.529093	2025-12-04 04:24:03.529093	Thursday	1145	1915	348	\N	\N	\N	\N
2479	2025-12-04 04:24:03.529892	2025-12-04 04:24:03.529892	Friday	830	2100	348	\N	\N	\N	\N
2480	2025-12-04 04:24:03.530741	2025-12-04 04:24:03.530741	Saturday	315	815	348	\N	\N	\N	\N
2481	2025-12-04 04:24:03.531468	2025-12-04 04:24:03.531468	Saturday	1100	1345	348	\N	\N	\N	\N
2482	2025-12-04 04:24:03.532243	2025-12-04 04:24:03.532243	Sunday	745	2345	348	\N	\N	\N	\N
2483	2025-12-04 04:24:03.538404	2025-12-04 04:24:03.538404	Monday	945	1700	349	\N	\N	\N	\N
2484	2025-12-04 04:24:03.539156	2025-12-04 04:24:03.539156	Tuesday	700	1615	349	\N	\N	\N	\N
2485	2025-12-04 04:24:03.53992	2025-12-04 04:24:03.53992	Thursday	900	1700	349	\N	\N	\N	\N
2486	2025-12-04 04:24:03.540665	2025-12-04 04:24:03.540665	Friday	2130	230	349	\N	\N	\N	\N
2487	2025-12-04 04:24:03.543552	2025-12-04 04:24:03.543552	Sunday	615	1630	349	\N	\N	\N	\N
2488	2025-12-04 04:24:03.552816	2025-12-04 04:24:03.552816	Monday	945	2145	350	\N	\N	\N	\N
2489	2025-12-04 04:24:03.553566	2025-12-04 04:24:03.553566	Tuesday	930	1900	350	\N	\N	\N	\N
2490	2025-12-04 04:24:03.554368	2025-12-04 04:24:03.554368	Thursday	630	1845	350	\N	\N	\N	\N
2491	2025-12-04 04:24:03.555089	2025-12-04 04:24:03.555089	Friday	800	1645	350	\N	\N	\N	\N
2492	2025-12-04 04:24:03.555915	2025-12-04 04:24:03.555915	Saturday	1015	1300	350	\N	\N	\N	\N
2493	2025-12-04 04:24:03.556677	2025-12-04 04:24:03.556677	Saturday	1730	545	350	\N	\N	\N	\N
2494	2025-12-04 04:24:03.557417	2025-12-04 04:24:03.557417	Sunday	645	2200	350	\N	\N	\N	\N
2495	2025-12-04 04:24:03.569162	2025-12-04 04:24:03.569162	Monday	830	1815	351	\N	\N	\N	\N
2496	2025-12-04 04:24:03.569936	2025-12-04 04:24:03.569936	Tuesday	630	2030	351	\N	\N	\N	\N
2497	2025-12-04 04:24:03.570721	2025-12-04 04:24:03.570721	Wednesday	645	2015	351	\N	\N	\N	\N
2498	2025-12-04 04:24:03.571459	2025-12-04 04:24:03.571459	Thursday	745	1930	351	\N	\N	\N	\N
2499	2025-12-04 04:24:03.572586	2025-12-04 04:24:03.572586	Friday	1430	115	351	\N	\N	\N	\N
2500	2025-12-04 04:24:03.574088	2025-12-04 04:24:03.574088	Saturday	845	1545	351	\N	\N	\N	\N
2501	2025-12-04 04:24:03.57502	2025-12-04 04:24:03.57502	Sunday	200	645	351	\N	\N	\N	\N
2502	2025-12-04 04:24:03.575774	2025-12-04 04:24:03.575774	Sunday	2245	2315	351	\N	\N	\N	\N
2503	2025-12-04 04:24:03.581641	2025-12-04 04:24:03.581641	Monday	900	1300	352	\N	\N	\N	\N
2504	2025-12-04 04:24:03.582435	2025-12-04 04:24:03.582435	Monday	1730	2400	352	\N	\N	\N	\N
2505	2025-12-04 04:24:03.583237	2025-12-04 04:24:03.583237	Wednesday	545	715	352	\N	\N	\N	\N
2506	2025-12-04 04:24:03.583925	2025-12-04 04:24:03.583925	Wednesday	1845	2045	352	\N	\N	\N	\N
2507	2025-12-04 04:24:03.584708	2025-12-04 04:24:03.584708	Friday	845	1515	352	\N	\N	\N	\N
2508	2025-12-04 04:24:03.585493	2025-12-04 04:24:03.585493	Saturday	900	2030	352	\N	\N	\N	\N
2509	2025-12-04 04:24:03.586312	2025-12-04 04:24:03.586312	Sunday	800	1645	352	\N	\N	\N	\N
2510	2025-12-04 04:24:03.597665	2025-12-04 04:24:03.597665	Monday	1500	330	353	\N	\N	\N	\N
2511	2025-12-04 04:24:03.598505	2025-12-04 04:24:03.598505	Tuesday	1000	2300	353	\N	\N	\N	\N
2512	2025-12-04 04:24:03.599387	2025-12-04 04:24:03.599387	Wednesday	200	230	353	\N	\N	\N	\N
2513	2025-12-04 04:24:03.600169	2025-12-04 04:24:03.600169	Wednesday	2115	2145	353	\N	\N	\N	\N
2514	2025-12-04 04:24:03.600905	2025-12-04 04:24:03.600905	Friday	830	2045	353	\N	\N	\N	\N
2515	2025-12-04 04:24:03.60168	2025-12-04 04:24:03.60168	Saturday	915	1915	353	\N	\N	\N	\N
2516	2025-12-04 04:24:03.60241	2025-12-04 04:24:03.60241	Sunday	645	1500	353	\N	\N	\N	\N
2517	2025-12-04 04:24:03.608515	2025-12-04 04:24:03.608515	Tuesday	2145	100	354	\N	\N	\N	\N
2518	2025-12-04 04:24:03.609292	2025-12-04 04:24:03.609292	Thursday	1000	1800	354	\N	\N	\N	\N
2519	2025-12-04 04:24:03.610041	2025-12-04 04:24:03.610041	Friday	745	1915	354	\N	\N	\N	\N
2520	2025-12-04 04:24:03.610835	2025-12-04 04:24:03.610835	Saturday	630	1400	354	\N	\N	\N	\N
2521	2025-12-04 04:24:03.611686	2025-12-04 04:24:03.611686	Sunday	1645	1730	354	\N	\N	\N	\N
2522	2025-12-04 04:24:03.612374	2025-12-04 04:24:03.612374	Sunday	1845	815	354	\N	\N	\N	\N
2523	2025-12-04 04:24:03.621402	2025-12-04 04:24:03.621402	Wednesday	615	1100	355	\N	\N	\N	\N
2524	2025-12-04 04:24:03.622172	2025-12-04 04:24:03.622172	Wednesday	1400	1745	355	\N	\N	\N	\N
2525	2025-12-04 04:24:03.622962	2025-12-04 04:24:03.622962	Thursday	1745	115	355	\N	\N	\N	\N
2526	2025-12-04 04:24:03.62373	2025-12-04 04:24:03.62373	Friday	900	1045	355	\N	\N	\N	\N
2527	2025-12-04 04:24:03.624508	2025-12-04 04:24:03.624508	Friday	1245	1400	355	\N	\N	\N	\N
2528	2025-12-04 04:24:03.625281	2025-12-04 04:24:03.625281	Saturday	745	2230	355	\N	\N	\N	\N
2529	2025-12-04 04:24:03.626025	2025-12-04 04:24:03.626025	Sunday	645	2200	355	\N	\N	\N	\N
2530	2025-12-04 04:24:03.637458	2025-12-04 04:24:03.637458	Monday	245	515	356	\N	\N	\N	\N
2531	2025-12-04 04:24:03.638269	2025-12-04 04:24:03.638269	Monday	1030	145	356	\N	\N	\N	\N
2532	2025-12-04 04:24:03.639054	2025-12-04 04:24:03.639054	Tuesday	730	2030	356	\N	\N	\N	\N
2533	2025-12-04 04:24:03.639801	2025-12-04 04:24:03.639801	Friday	645	1515	356	\N	\N	\N	\N
2534	2025-12-04 04:24:03.640522	2025-12-04 04:24:03.640522	Saturday	915	1445	356	\N	\N	\N	\N
2535	2025-12-04 04:24:03.64131	2025-12-04 04:24:03.64131	Sunday	915	2215	356	\N	\N	\N	\N
2536	2025-12-04 04:24:03.647504	2025-12-04 04:24:03.647504	Monday	115	1100	357	\N	\N	\N	\N
2537	2025-12-04 04:24:03.648282	2025-12-04 04:24:03.648282	Monday	1545	1730	357	\N	\N	\N	\N
2538	2025-12-04 04:24:03.649036	2025-12-04 04:24:03.649036	Tuesday	715	1700	357	\N	\N	\N	\N
2539	2025-12-04 04:24:03.649821	2025-12-04 04:24:03.649821	Wednesday	1530	400	357	\N	\N	\N	\N
2540	2025-12-04 04:24:03.650566	2025-12-04 04:24:03.650566	Saturday	630	1945	357	\N	\N	\N	\N
2541	2025-12-04 04:24:03.651311	2025-12-04 04:24:03.651311	Sunday	2300	115	357	\N	\N	\N	\N
2542	2025-12-04 04:24:03.664426	2025-12-04 04:24:03.664426	Monday	630	1930	358	\N	\N	\N	\N
2543	2025-12-04 04:24:03.665206	2025-12-04 04:24:03.665206	Tuesday	815	1815	358	\N	\N	\N	\N
2544	2025-12-04 04:24:03.665937	2025-12-04 04:24:03.665937	Thursday	915	2330	358	\N	\N	\N	\N
2545	2025-12-04 04:24:03.666702	2025-12-04 04:24:03.666702	Sunday	900	2245	358	\N	\N	\N	\N
2546	2025-12-04 04:24:03.672503	2025-12-04 04:24:03.672503	Monday	930	1945	359	\N	\N	\N	\N
2547	2025-12-04 04:24:03.673311	2025-12-04 04:24:03.673311	Tuesday	2000	245	359	\N	\N	\N	\N
2548	2025-12-04 04:24:03.674072	2025-12-04 04:24:03.674072	Wednesday	930	2230	359	\N	\N	\N	\N
2549	2025-12-04 04:24:03.674854	2025-12-04 04:24:03.674854	Thursday	1000	1400	359	\N	\N	\N	\N
2550	2025-12-04 04:24:03.675605	2025-12-04 04:24:03.675605	Saturday	1645	330	359	\N	\N	\N	\N
2551	2025-12-04 04:24:03.676674	2025-12-04 04:24:03.676674	Sunday	1700	300	359	\N	\N	\N	\N
2552	2025-12-04 04:24:04.021376	2025-12-04 04:24:04.021376	Wednesday	645	2245	360	\N	\N	\N	\N
2553	2025-12-04 04:24:04.022244	2025-12-04 04:24:04.022244	Friday	915	2215	360	\N	\N	\N	\N
2554	2025-12-04 04:24:04.023087	2025-12-04 04:24:04.023087	Sunday	1000	2130	360	\N	\N	\N	\N
2555	2025-12-04 04:24:04.029069	2025-12-04 04:24:04.029069	Monday	900	1445	361	\N	\N	\N	\N
2556	2025-12-04 04:24:04.029858	2025-12-04 04:24:04.029858	Tuesday	830	1745	361	\N	\N	\N	\N
2557	2025-12-04 04:24:04.030698	2025-12-04 04:24:04.030698	Wednesday	900	1945	361	\N	\N	\N	\N
2558	2025-12-04 04:24:04.03146	2025-12-04 04:24:04.03146	Thursday	1815	330	361	\N	\N	\N	\N
2559	2025-12-04 04:24:04.032276	2025-12-04 04:24:04.032276	Friday	715	1845	361	\N	\N	\N	\N
2560	2025-12-04 04:24:04.033001	2025-12-04 04:24:04.033001	Saturday	745	1530	361	\N	\N	\N	\N
2561	2025-12-04 04:24:04.033783	2025-12-04 04:24:04.033783	Sunday	800	1845	361	\N	\N	\N	\N
2562	2025-12-04 04:24:04.041899	2025-12-04 04:24:04.041899	Tuesday	1930	115	362	\N	\N	\N	\N
2563	2025-12-04 04:24:04.042747	2025-12-04 04:24:04.042747	Wednesday	830	1730	362	\N	\N	\N	\N
2564	2025-12-04 04:24:04.043505	2025-12-04 04:24:04.043505	Friday	615	1800	362	\N	\N	\N	\N
2565	2025-12-04 04:24:04.04458	2025-12-04 04:24:04.04458	Sunday	815	845	362	\N	\N	\N	\N
2566	2025-12-04 04:24:04.045368	2025-12-04 04:24:04.045368	Sunday	1500	1600	362	\N	\N	\N	\N
2567	2025-12-04 04:24:04.051173	2025-12-04 04:24:04.051173	Monday	815	1715	363	\N	\N	\N	\N
2568	2025-12-04 04:24:04.051994	2025-12-04 04:24:04.051994	Tuesday	945	2000	363	\N	\N	\N	\N
2569	2025-12-04 04:24:04.052796	2025-12-04 04:24:04.052796	Thursday	2130	400	363	\N	\N	\N	\N
2570	2025-12-04 04:24:04.053645	2025-12-04 04:24:04.053645	Friday	700	2230	363	\N	\N	\N	\N
2571	2025-12-04 04:24:04.054433	2025-12-04 04:24:04.054433	Saturday	845	1630	363	\N	\N	\N	\N
2572	2025-12-04 04:24:04.06257	2025-12-04 04:24:04.06257	Monday	2045	145	364	\N	\N	\N	\N
2573	2025-12-04 04:24:04.06334	2025-12-04 04:24:04.06334	Tuesday	615	1645	364	\N	\N	\N	\N
2574	2025-12-04 04:24:04.064138	2025-12-04 04:24:04.064138	Wednesday	845	1800	364	\N	\N	\N	\N
2575	2025-12-04 04:24:04.064941	2025-12-04 04:24:04.064941	Thursday	1615	400	364	\N	\N	\N	\N
2576	2025-12-04 04:24:04.065716	2025-12-04 04:24:04.065716	Friday	715	2130	364	\N	\N	\N	\N
2577	2025-12-04 04:24:04.066493	2025-12-04 04:24:04.066493	Saturday	1715	2315	364	\N	\N	\N	\N
2578	2025-12-04 04:24:04.067276	2025-12-04 04:24:04.067276	Saturday	2345	230	364	\N	\N	\N	\N
2579	2025-12-04 04:24:04.068018	2025-12-04 04:24:04.068018	Sunday	615	1900	364	\N	\N	\N	\N
2580	2025-12-04 04:24:04.073799	2025-12-04 04:24:04.073799	Monday	445	715	365	\N	\N	\N	\N
2581	2025-12-04 04:24:04.074583	2025-12-04 04:24:04.074583	Monday	1300	1800	365	\N	\N	\N	\N
2582	2025-12-04 04:24:04.075901	2025-12-04 04:24:04.075901	Tuesday	1630	245	365	\N	\N	\N	\N
2583	2025-12-04 04:24:04.077267	2025-12-04 04:24:04.077267	Wednesday	815	1445	365	\N	\N	\N	\N
2584	2025-12-04 04:24:04.079069	2025-12-04 04:24:04.079069	Thursday	1530	100	365	\N	\N	\N	\N
2585	2025-12-04 04:24:04.080372	2025-12-04 04:24:04.080372	Friday	345	800	365	\N	\N	\N	\N
2586	2025-12-04 04:24:04.08121	2025-12-04 04:24:04.08121	Friday	900	1800	365	\N	\N	\N	\N
2587	2025-12-04 04:24:04.082164	2025-12-04 04:24:04.082164	Saturday	45	415	365	\N	\N	\N	\N
2588	2025-12-04 04:24:04.083051	2025-12-04 04:24:04.083051	Saturday	1915	2200	365	\N	\N	\N	\N
2589	2025-12-04 04:24:04.099059	2025-12-04 04:24:04.099059	Monday	730	2400	366	\N	\N	\N	\N
2590	2025-12-04 04:24:04.099934	2025-12-04 04:24:04.099934	Tuesday	600	1600	366	\N	\N	\N	\N
2591	2025-12-04 04:24:04.100813	2025-12-04 04:24:04.100813	Wednesday	1000	1400	366	\N	\N	\N	\N
2592	2025-12-04 04:24:04.101679	2025-12-04 04:24:04.101679	Thursday	615	2200	366	\N	\N	\N	\N
2593	2025-12-04 04:24:04.102638	2025-12-04 04:24:04.102638	Friday	1245	2100	366	\N	\N	\N	\N
2594	2025-12-04 04:24:04.103542	2025-12-04 04:24:04.103542	Friday	2300	830	366	\N	\N	\N	\N
2595	2025-12-04 04:24:04.104546	2025-12-04 04:24:04.104546	Saturday	900	2400	366	\N	\N	\N	\N
2596	2025-12-04 04:24:04.105506	2025-12-04 04:24:04.105506	Sunday	830	2145	366	\N	\N	\N	\N
2597	2025-12-04 04:24:04.114048	2025-12-04 04:24:04.114048	Monday	330	400	367	\N	\N	\N	\N
2598	2025-12-04 04:24:04.115005	2025-12-04 04:24:04.115005	Monday	945	1130	367	\N	\N	\N	\N
2599	2025-12-04 04:24:04.115979	2025-12-04 04:24:04.115979	Tuesday	745	2215	367	\N	\N	\N	\N
2600	2025-12-04 04:24:04.116879	2025-12-04 04:24:04.116879	Wednesday	1600	200	367	\N	\N	\N	\N
2601	2025-12-04 04:24:04.117814	2025-12-04 04:24:04.117814	Thursday	630	2300	367	\N	\N	\N	\N
2602	2025-12-04 04:24:04.11871	2025-12-04 04:24:04.11871	Saturday	830	1800	367	\N	\N	\N	\N
2603	2025-12-04 04:24:04.119571	2025-12-04 04:24:04.119571	Sunday	2200	100	367	\N	\N	\N	\N
2604	2025-12-04 04:24:04.130189	2025-12-04 04:24:04.130189	Monday	600	1100	368	\N	\N	\N	\N
2605	2025-12-04 04:24:04.131033	2025-12-04 04:24:04.131033	Monday	1415	1700	368	\N	\N	\N	\N
2606	2025-12-04 04:24:04.131841	2025-12-04 04:24:04.131841	Tuesday	330	800	368	\N	\N	\N	\N
2607	2025-12-04 04:24:04.132589	2025-12-04 04:24:04.132589	Tuesday	830	130	368	\N	\N	\N	\N
2608	2025-12-04 04:24:04.133405	2025-12-04 04:24:04.133405	Wednesday	1845	2245	368	\N	\N	\N	\N
2609	2025-12-04 04:24:04.134203	2025-12-04 04:24:04.134203	Wednesday	2345	815	368	\N	\N	\N	\N
2610	2025-12-04 04:24:04.134974	2025-12-04 04:24:04.134974	Friday	745	1900	368	\N	\N	\N	\N
2611	2025-12-04 04:24:04.135811	2025-12-04 04:24:04.135811	Saturday	715	730	368	\N	\N	\N	\N
2612	2025-12-04 04:24:04.136644	2025-12-04 04:24:04.136644	Saturday	1400	15	368	\N	\N	\N	\N
2613	2025-12-04 04:24:04.137418	2025-12-04 04:24:04.137418	Sunday	645	1530	368	\N	\N	\N	\N
2614	2025-12-04 04:24:04.143536	2025-12-04 04:24:04.143536	Monday	800	2245	369	\N	\N	\N	\N
2615	2025-12-04 04:24:04.144346	2025-12-04 04:24:04.144346	Tuesday	1000	1430	369	\N	\N	\N	\N
2616	2025-12-04 04:24:04.145161	2025-12-04 04:24:04.145161	Wednesday	715	1745	369	\N	\N	\N	\N
2617	2025-12-04 04:24:04.145945	2025-12-04 04:24:04.145945	Wednesday	2145	545	369	\N	\N	\N	\N
2618	2025-12-04 04:24:04.164729	2025-12-04 04:24:04.164729	Monday	745	2200	370	\N	\N	\N	\N
2619	2025-12-04 04:24:04.165618	2025-12-04 04:24:04.165618	Wednesday	430	2030	370	\N	\N	\N	\N
2620	2025-12-04 04:24:04.166412	2025-12-04 04:24:04.166412	Wednesday	2145	2215	370	\N	\N	\N	\N
2621	2025-12-04 04:24:04.167217	2025-12-04 04:24:04.167217	Thursday	645	1445	370	\N	\N	\N	\N
2622	2025-12-04 04:24:04.16805	2025-12-04 04:24:04.16805	Friday	2015	330	370	\N	\N	\N	\N
2623	2025-12-04 04:24:04.168789	2025-12-04 04:24:04.168789	Saturday	700	2215	370	\N	\N	\N	\N
2624	2025-12-04 04:24:04.16956	2025-12-04 04:24:04.16956	Sunday	630	2200	370	\N	\N	\N	\N
2625	2025-12-04 04:24:04.175779	2025-12-04 04:24:04.175779	Monday	500	730	371	\N	\N	\N	\N
2626	2025-12-04 04:24:04.176535	2025-12-04 04:24:04.176535	Monday	1230	1300	371	\N	\N	\N	\N
2627	2025-12-04 04:24:04.177323	2025-12-04 04:24:04.177323	Wednesday	830	1430	371	\N	\N	\N	\N
2628	2025-12-04 04:24:04.17812	2025-12-04 04:24:04.17812	Friday	1700	330	371	\N	\N	\N	\N
2629	2025-12-04 04:24:04.178844	2025-12-04 04:24:04.178844	Saturday	830	1815	371	\N	\N	\N	\N
2630	2025-12-04 04:24:04.187934	2025-12-04 04:24:04.187934	Tuesday	1815	330	372	\N	\N	\N	\N
2631	2025-12-04 04:24:04.188802	2025-12-04 04:24:04.188802	Wednesday	1000	1415	372	\N	\N	\N	\N
2632	2025-12-04 04:24:04.189618	2025-12-04 04:24:04.189618	Thursday	1515	130	372	\N	\N	\N	\N
2633	2025-12-04 04:24:04.190396	2025-12-04 04:24:04.190396	Friday	145	830	372	\N	\N	\N	\N
2634	2025-12-04 04:24:04.191161	2025-12-04 04:24:04.191161	Friday	1515	2245	372	\N	\N	\N	\N
2635	2025-12-04 04:24:04.191933	2025-12-04 04:24:04.191933	Saturday	0	800	372	\N	\N	\N	\N
2636	2025-12-04 04:24:04.19264	2025-12-04 04:24:04.19264	Saturday	815	2400	372	\N	\N	\N	\N
2637	2025-12-04 04:24:04.193439	2025-12-04 04:24:04.193439	Sunday	915	2215	372	\N	\N	\N	\N
2638	2025-12-04 04:24:04.194184	2025-12-04 04:24:04.194184	Sunday	2300	800	372	\N	\N	\N	\N
2639	2025-12-04 04:24:04.200055	2025-12-04 04:24:04.200055	Monday	945	1430	373	\N	\N	\N	\N
2640	2025-12-04 04:24:04.200867	2025-12-04 04:24:04.200867	Wednesday	500	1015	373	\N	\N	\N	\N
2641	2025-12-04 04:24:04.201624	2025-12-04 04:24:04.201624	Wednesday	1030	2130	373	\N	\N	\N	\N
2642	2025-12-04 04:24:04.202389	2025-12-04 04:24:04.202389	Thursday	700	1600	373	\N	\N	\N	\N
2643	2025-12-04 04:24:04.203525	2025-12-04 04:24:04.203525	Sunday	330	900	373	\N	\N	\N	\N
2644	2025-12-04 04:24:04.204229	2025-12-04 04:24:04.204229	Sunday	1145	2100	373	\N	\N	\N	\N
2645	2025-12-04 04:24:04.213991	2025-12-04 04:24:04.213991	Monday	830	2315	374	\N	\N	\N	\N
2646	2025-12-04 04:24:04.214832	2025-12-04 04:24:04.214832	Wednesday	30	2130	374	\N	\N	\N	\N
2647	2025-12-04 04:24:04.215658	2025-12-04 04:24:04.215658	Wednesday	2230	2330	374	\N	\N	\N	\N
2648	2025-12-04 04:24:04.216514	2025-12-04 04:24:04.216514	Thursday	315	345	374	\N	\N	\N	\N
2649	2025-12-04 04:24:04.217367	2025-12-04 04:24:04.217367	Thursday	645	2015	374	\N	\N	\N	\N
2650	2025-12-04 04:24:04.218187	2025-12-04 04:24:04.218187	Saturday	800	1900	374	\N	\N	\N	\N
2651	2025-12-04 04:24:04.224118	2025-12-04 04:24:04.224118	Monday	745	1730	375	\N	\N	\N	\N
2652	2025-12-04 04:24:04.224934	2025-12-04 04:24:04.224934	Wednesday	630	1730	375	\N	\N	\N	\N
2653	2025-12-04 04:24:04.225717	2025-12-04 04:24:04.225717	Thursday	1800	315	375	\N	\N	\N	\N
2654	2025-12-04 04:24:04.226562	2025-12-04 04:24:04.226562	Friday	930	2200	375	\N	\N	\N	\N
2655	2025-12-04 04:24:04.227306	2025-12-04 04:24:04.227306	Friday	2345	815	375	\N	\N	\N	\N
2656	2025-12-04 04:24:04.228098	2025-12-04 04:24:04.228098	Saturday	45	415	375	\N	\N	\N	\N
2657	2025-12-04 04:24:04.22882	2025-12-04 04:24:04.22882	Saturday	2000	2015	375	\N	\N	\N	\N
2658	2025-12-04 04:24:04.229577	2025-12-04 04:24:04.229577	Sunday	945	1645	375	\N	\N	\N	\N
2659	2025-12-04 04:24:04.238782	2025-12-04 04:24:04.238782	Monday	300	545	376	\N	\N	\N	\N
2660	2025-12-04 04:24:04.239552	2025-12-04 04:24:04.239552	Monday	615	2230	376	\N	\N	\N	\N
2661	2025-12-04 04:24:04.240333	2025-12-04 04:24:04.240333	Tuesday	1445	345	376	\N	\N	\N	\N
2662	2025-12-04 04:24:04.241113	2025-12-04 04:24:04.241113	Wednesday	745	1945	376	\N	\N	\N	\N
2663	2025-12-04 04:24:04.241907	2025-12-04 04:24:04.241907	Thursday	45	915	376	\N	\N	\N	\N
2664	2025-12-04 04:24:04.242668	2025-12-04 04:24:04.242668	Thursday	1030	2130	376	\N	\N	\N	\N
2665	2025-12-04 04:24:04.243421	2025-12-04 04:24:04.243421	Friday	930	2230	376	\N	\N	\N	\N
2666	2025-12-04 04:24:04.249079	2025-12-04 04:24:04.249079	Wednesday	600	2000	377	\N	\N	\N	\N
2667	2025-12-04 04:24:04.249844	2025-12-04 04:24:04.249844	Thursday	715	2215	377	\N	\N	\N	\N
2668	2025-12-04 04:24:04.250609	2025-12-04 04:24:04.250609	Friday	615	1530	377	\N	\N	\N	\N
2669	2025-12-04 04:24:04.251387	2025-12-04 04:24:04.251387	Saturday	115	500	377	\N	\N	\N	\N
2670	2025-12-04 04:24:04.252134	2025-12-04 04:24:04.252134	Saturday	745	2145	377	\N	\N	\N	\N
2671	2025-12-04 04:24:04.253011	2025-12-04 04:24:04.253011	Sunday	0	315	377	\N	\N	\N	\N
2672	2025-12-04 04:24:04.253761	2025-12-04 04:24:04.253761	Sunday	1200	1400	377	\N	\N	\N	\N
2673	2025-12-04 04:24:04.262851	2025-12-04 04:24:04.262851	Monday	1230	1330	378	\N	\N	\N	\N
2674	2025-12-04 04:24:04.263689	2025-12-04 04:24:04.263689	Monday	1730	730	378	\N	\N	\N	\N
2675	2025-12-04 04:24:04.264462	2025-12-04 04:24:04.264462	Wednesday	915	1545	378	\N	\N	\N	\N
2676	2025-12-04 04:24:04.265225	2025-12-04 04:24:04.265225	Thursday	715	1930	378	\N	\N	\N	\N
2677	2025-12-04 04:24:04.265949	2025-12-04 04:24:04.265949	Friday	900	2400	378	\N	\N	\N	\N
2678	2025-12-04 04:24:04.266715	2025-12-04 04:24:04.266715	Saturday	900	1900	378	\N	\N	\N	\N
2679	2025-12-04 04:24:04.267468	2025-12-04 04:24:04.267468	Sunday	630	2045	378	\N	\N	\N	\N
2680	2025-12-04 04:24:04.273494	2025-12-04 04:24:04.273494	Tuesday	815	2300	379	\N	\N	\N	\N
2681	2025-12-04 04:24:04.274375	2025-12-04 04:24:04.274375	Wednesday	730	1500	379	\N	\N	\N	\N
2682	2025-12-04 04:24:04.275162	2025-12-04 04:24:04.275162	Thursday	830	1745	379	\N	\N	\N	\N
2683	2025-12-04 04:24:04.28493	2025-12-04 04:24:04.28493	Monday	800	1615	380	\N	\N	\N	\N
2684	2025-12-04 04:24:04.285857	2025-12-04 04:24:04.285857	Wednesday	530	600	380	\N	\N	\N	\N
2685	2025-12-04 04:24:04.286579	2025-12-04 04:24:04.286579	Wednesday	830	430	380	\N	\N	\N	\N
2686	2025-12-04 04:24:04.287377	2025-12-04 04:24:04.287377	Thursday	1045	1330	380	\N	\N	\N	\N
2687	2025-12-04 04:24:04.288157	2025-12-04 04:24:04.288157	Thursday	1445	2345	380	\N	\N	\N	\N
2688	2025-12-04 04:24:04.288965	2025-12-04 04:24:04.288965	Friday	1745	115	380	\N	\N	\N	\N
2689	2025-12-04 04:24:04.289747	2025-12-04 04:24:04.289747	Sunday	530	900	380	\N	\N	\N	\N
2690	2025-12-04 04:24:04.29048	2025-12-04 04:24:04.29048	Sunday	1200	1300	380	\N	\N	\N	\N
2691	2025-12-04 04:24:04.296241	2025-12-04 04:24:04.296241	Monday	615	2030	381	\N	\N	\N	\N
2692	2025-12-04 04:24:04.296983	2025-12-04 04:24:04.296983	Tuesday	830	2245	381	\N	\N	\N	\N
2693	2025-12-04 04:24:04.297756	2025-12-04 04:24:04.297756	Wednesday	2230	315	381	\N	\N	\N	\N
2694	2025-12-04 04:24:04.298533	2025-12-04 04:24:04.298533	Thursday	900	2330	381	\N	\N	\N	\N
2695	2025-12-04 04:24:04.299278	2025-12-04 04:24:04.299278	Friday	1000	1715	381	\N	\N	\N	\N
2696	2025-12-04 04:24:04.300089	2025-12-04 04:24:04.300089	Saturday	945	2400	381	\N	\N	\N	\N
2697	2025-12-04 04:24:04.300903	2025-12-04 04:24:04.300903	Sunday	1445	145	381	\N	\N	\N	\N
2698	2025-12-04 04:24:04.31058	2025-12-04 04:24:04.31058	Monday	915	1600	382	\N	\N	\N	\N
2699	2025-12-04 04:24:04.311405	2025-12-04 04:24:04.311405	Tuesday	115	215	382	\N	\N	\N	\N
2700	2025-12-04 04:24:04.312193	2025-12-04 04:24:04.312193	Tuesday	645	1830	382	\N	\N	\N	\N
2701	2025-12-04 04:24:04.313008	2025-12-04 04:24:04.313008	Wednesday	445	1245	382	\N	\N	\N	\N
2702	2025-12-04 04:24:04.313777	2025-12-04 04:24:04.313777	Wednesday	2400	100	382	\N	\N	\N	\N
2703	2025-12-04 04:24:04.314555	2025-12-04 04:24:04.314555	Thursday	1600	400	382	\N	\N	\N	\N
2704	2025-12-04 04:24:04.315313	2025-12-04 04:24:04.315313	Friday	915	2145	382	\N	\N	\N	\N
2705	2025-12-04 04:24:04.316063	2025-12-04 04:24:04.316063	Saturday	1000	2215	382	\N	\N	\N	\N
2706	2025-12-04 04:24:04.316887	2025-12-04 04:24:04.316887	Sunday	915	1300	382	\N	\N	\N	\N
2707	2025-12-04 04:24:04.317609	2025-12-04 04:24:04.317609	Sunday	1345	2300	382	\N	\N	\N	\N
2708	2025-12-04 04:24:04.32346	2025-12-04 04:24:04.32346	Monday	730	1645	383	\N	\N	\N	\N
2709	2025-12-04 04:24:04.324254	2025-12-04 04:24:04.324254	Thursday	1715	400	383	\N	\N	\N	\N
2710	2025-12-04 04:24:04.325011	2025-12-04 04:24:04.325011	Friday	930	2115	383	\N	\N	\N	\N
2711	2025-12-04 04:24:04.325818	2025-12-04 04:24:04.325818	Saturday	500	1045	383	\N	\N	\N	\N
2712	2025-12-04 04:24:04.326552	2025-12-04 04:24:04.326552	Saturday	1515	1615	383	\N	\N	\N	\N
2713	2025-12-04 04:24:04.327309	2025-12-04 04:24:04.327309	Sunday	600	2345	383	\N	\N	\N	\N
2714	2025-12-04 04:24:04.336567	2025-12-04 04:24:04.336567	Monday	1845	100	384	\N	\N	\N	\N
2715	2025-12-04 04:24:04.337367	2025-12-04 04:24:04.337367	Tuesday	915	1815	384	\N	\N	\N	\N
2716	2025-12-04 04:24:04.338168	2025-12-04 04:24:04.338168	Wednesday	715	1915	384	\N	\N	\N	\N
2717	2025-12-04 04:24:04.338895	2025-12-04 04:24:04.338895	Wednesday	2115	2330	384	\N	\N	\N	\N
2718	2025-12-04 04:24:04.339653	2025-12-04 04:24:04.339653	Thursday	845	2200	384	\N	\N	\N	\N
2719	2025-12-04 04:24:04.340404	2025-12-04 04:24:04.340404	Saturday	700	2245	384	\N	\N	\N	\N
2720	2025-12-04 04:24:04.341177	2025-12-04 04:24:04.341177	Sunday	700	915	384	\N	\N	\N	\N
2721	2025-12-04 04:24:04.341932	2025-12-04 04:24:04.341932	Sunday	1700	2045	384	\N	\N	\N	\N
2722	2025-12-04 04:24:04.347708	2025-12-04 04:24:04.347708	Tuesday	615	1445	385	\N	\N	\N	\N
2723	2025-12-04 04:24:04.348496	2025-12-04 04:24:04.348496	Wednesday	45	215	385	\N	\N	\N	\N
2724	2025-12-04 04:24:04.349299	2025-12-04 04:24:04.349299	Wednesday	1630	2030	385	\N	\N	\N	\N
2725	2025-12-04 04:24:04.350138	2025-12-04 04:24:04.350138	Thursday	615	1230	385	\N	\N	\N	\N
2726	2025-12-04 04:24:04.350872	2025-12-04 04:24:04.350872	Thursday	1745	2200	385	\N	\N	\N	\N
2727	2025-12-04 04:24:04.351696	2025-12-04 04:24:04.351696	Friday	800	1845	385	\N	\N	\N	\N
2728	2025-12-04 04:24:04.352423	2025-12-04 04:24:04.352423	Saturday	830	2330	385	\N	\N	\N	\N
2729	2025-12-04 04:24:04.353279	2025-12-04 04:24:04.353279	Sunday	245	745	385	\N	\N	\N	\N
2730	2025-12-04 04:24:04.354042	2025-12-04 04:24:04.354042	Sunday	1300	2315	385	\N	\N	\N	\N
2731	2025-12-04 04:24:04.363194	2025-12-04 04:24:04.363194	Monday	2230	330	386	\N	\N	\N	\N
2732	2025-12-04 04:24:04.363995	2025-12-04 04:24:04.363995	Tuesday	1000	1900	386	\N	\N	\N	\N
2733	2025-12-04 04:24:04.364773	2025-12-04 04:24:04.364773	Wednesday	600	2245	386	\N	\N	\N	\N
2734	2025-12-04 04:24:04.365557	2025-12-04 04:24:04.365557	Thursday	730	2015	386	\N	\N	\N	\N
2735	2025-12-04 04:24:04.366331	2025-12-04 04:24:04.366331	Saturday	930	1900	386	\N	\N	\N	\N
2736	2025-12-04 04:24:04.367107	2025-12-04 04:24:04.367107	Sunday	630	1445	386	\N	\N	\N	\N
2737	2025-12-04 04:24:04.373316	2025-12-04 04:24:04.373316	Monday	1430	345	387	\N	\N	\N	\N
2738	2025-12-04 04:24:04.374156	2025-12-04 04:24:04.374156	Tuesday	130	1730	387	\N	\N	\N	\N
2739	2025-12-04 04:24:04.374916	2025-12-04 04:24:04.374916	Tuesday	2330	0	387	\N	\N	\N	\N
2740	2025-12-04 04:24:04.375698	2025-12-04 04:24:04.375698	Wednesday	900	1315	387	\N	\N	\N	\N
2741	2025-12-04 04:24:04.376453	2025-12-04 04:24:04.376453	Wednesday	1500	1630	387	\N	\N	\N	\N
2742	2025-12-04 04:24:04.377235	2025-12-04 04:24:04.377235	Thursday	630	1945	387	\N	\N	\N	\N
2743	2025-12-04 04:24:04.377997	2025-12-04 04:24:04.377997	Friday	245	745	387	\N	\N	\N	\N
2744	2025-12-04 04:24:04.378767	2025-12-04 04:24:04.378767	Friday	1000	2400	387	\N	\N	\N	\N
2745	2025-12-04 04:24:04.379557	2025-12-04 04:24:04.379557	Sunday	1000	1545	387	\N	\N	\N	\N
2746	2025-12-04 04:24:04.38925	2025-12-04 04:24:04.38925	Tuesday	930	1100	388	\N	\N	\N	\N
2747	2025-12-04 04:24:04.390021	2025-12-04 04:24:04.390021	Tuesday	1815	1900	388	\N	\N	\N	\N
2748	2025-12-04 04:24:04.390812	2025-12-04 04:24:04.390812	Wednesday	15	230	388	\N	\N	\N	\N
2749	2025-12-04 04:24:04.391568	2025-12-04 04:24:04.391568	Wednesday	530	1215	388	\N	\N	\N	\N
2750	2025-12-04 04:24:04.392338	2025-12-04 04:24:04.392338	Thursday	800	1430	388	\N	\N	\N	\N
2751	2025-12-04 04:24:04.39309	2025-12-04 04:24:04.39309	Friday	1545	245	388	\N	\N	\N	\N
2752	2025-12-04 04:24:04.393902	2025-12-04 04:24:04.393902	Saturday	830	1945	388	\N	\N	\N	\N
2753	2025-12-04 04:24:04.394612	2025-12-04 04:24:04.394612	Saturday	2330	100	388	\N	\N	\N	\N
2754	2025-12-04 04:24:04.395388	2025-12-04 04:24:04.395388	Sunday	815	2000	388	\N	\N	\N	\N
2755	2025-12-04 04:24:04.401187	2025-12-04 04:24:04.401187	Tuesday	715	2400	389	\N	\N	\N	\N
2756	2025-12-04 04:24:04.40193	2025-12-04 04:24:04.40193	Wednesday	2115	345	389	\N	\N	\N	\N
2757	2025-12-04 04:24:04.402703	2025-12-04 04:24:04.402703	Friday	645	2115	389	\N	\N	\N	\N
2758	2025-12-04 04:24:04.403421	2025-12-04 04:24:04.403421	Saturday	615	2200	389	\N	\N	\N	\N
2759	2025-12-04 04:24:04.404377	2025-12-04 04:24:04.404377	Sunday	700	1730	389	\N	\N	\N	\N
2760	2025-12-04 04:24:04.413938	2025-12-04 04:24:04.413938	Monday	830	2000	390	\N	\N	\N	\N
2761	2025-12-04 04:24:04.414739	2025-12-04 04:24:04.414739	Tuesday	845	2045	390	\N	\N	\N	\N
2762	2025-12-04 04:24:04.415492	2025-12-04 04:24:04.415492	Wednesday	815	2145	390	\N	\N	\N	\N
2763	2025-12-04 04:24:04.416246	2025-12-04 04:24:04.416246	Thursday	715	1830	390	\N	\N	\N	\N
2764	2025-12-04 04:24:04.417025	2025-12-04 04:24:04.417025	Friday	700	1715	390	\N	\N	\N	\N
2765	2025-12-04 04:24:04.417806	2025-12-04 04:24:04.417806	Saturday	800	1800	390	\N	\N	\N	\N
2766	2025-12-04 04:24:04.423612	2025-12-04 04:24:04.423612	Monday	345	600	391	\N	\N	\N	\N
2767	2025-12-04 04:24:04.424445	2025-12-04 04:24:04.424445	Monday	2115	2200	391	\N	\N	\N	\N
2768	2025-12-04 04:24:04.425227	2025-12-04 04:24:04.425227	Wednesday	1845	115	391	\N	\N	\N	\N
2769	2025-12-04 04:24:04.425968	2025-12-04 04:24:04.425968	Thursday	700	2130	391	\N	\N	\N	\N
2770	2025-12-04 04:24:04.426775	2025-12-04 04:24:04.426775	Friday	1930	100	391	\N	\N	\N	\N
2771	2025-12-04 04:24:04.427557	2025-12-04 04:24:04.427557	Saturday	645	1645	391	\N	\N	\N	\N
2772	2025-12-04 04:24:04.428352	2025-12-04 04:24:04.428352	Sunday	800	1845	391	\N	\N	\N	\N
2773	2025-12-04 04:24:04.440167	2025-12-04 04:24:04.440167	Tuesday	630	1430	392	\N	\N	\N	\N
2774	2025-12-04 04:24:04.440937	2025-12-04 04:24:04.440937	Wednesday	900	2130	392	\N	\N	\N	\N
2775	2025-12-04 04:24:04.441991	2025-12-04 04:24:04.441991	Friday	745	1615	392	\N	\N	\N	\N
2776	2025-12-04 04:24:04.442763	2025-12-04 04:24:04.442763	Saturday	200	245	392	\N	\N	\N	\N
2777	2025-12-04 04:24:04.443507	2025-12-04 04:24:04.443507	Saturday	1715	1930	392	\N	\N	\N	\N
2778	2025-12-04 04:24:04.444294	2025-12-04 04:24:04.444294	Sunday	845	1930	392	\N	\N	\N	\N
2779	2025-12-04 04:24:04.445052	2025-12-04 04:24:04.445052	Sunday	2000	2200	392	\N	\N	\N	\N
2780	2025-12-04 04:24:04.450822	2025-12-04 04:24:04.450822	Monday	1245	1345	393	\N	\N	\N	\N
2781	2025-12-04 04:24:04.451555	2025-12-04 04:24:04.451555	Monday	1500	1645	393	\N	\N	\N	\N
2782	2025-12-04 04:24:04.452328	2025-12-04 04:24:04.452328	Wednesday	1700	100	393	\N	\N	\N	\N
2783	2025-12-04 04:24:04.453115	2025-12-04 04:24:04.453115	Friday	215	445	393	\N	\N	\N	\N
2784	2025-12-04 04:24:04.453839	2025-12-04 04:24:04.453839	Friday	1245	1400	393	\N	\N	\N	\N
2785	2025-12-04 04:24:04.454623	2025-12-04 04:24:04.454623	Saturday	1015	1430	393	\N	\N	\N	\N
2786	2025-12-04 04:24:04.455343	2025-12-04 04:24:04.455343	Saturday	2100	2200	393	\N	\N	\N	\N
2787	2025-12-04 04:24:04.456128	2025-12-04 04:24:04.456128	Sunday	630	1830	393	\N	\N	\N	\N
2788	2025-12-04 04:24:04.464867	2025-12-04 04:24:04.464867	Monday	630	1500	394	\N	\N	\N	\N
2789	2025-12-04 04:24:04.465686	2025-12-04 04:24:04.465686	Tuesday	645	1815	394	\N	\N	\N	\N
2790	2025-12-04 04:24:04.466437	2025-12-04 04:24:04.466437	Wednesday	830	1500	394	\N	\N	\N	\N
2791	2025-12-04 04:24:04.467205	2025-12-04 04:24:04.467205	Friday	915	1900	394	\N	\N	\N	\N
2792	2025-12-04 04:24:04.473266	2025-12-04 04:24:04.473266	Monday	645	2230	395	\N	\N	\N	\N
2793	2025-12-04 04:24:04.474489	2025-12-04 04:24:04.474489	Thursday	2100	230	395	\N	\N	\N	\N
2794	2025-12-04 04:24:04.475339	2025-12-04 04:24:04.475339	Friday	700	2230	395	\N	\N	\N	\N
2795	2025-12-04 04:24:04.476293	2025-12-04 04:24:04.476293	Saturday	530	1200	395	\N	\N	\N	\N
2796	2025-12-04 04:24:04.477301	2025-12-04 04:24:04.477301	Saturday	1645	1815	395	\N	\N	\N	\N
2797	2025-12-04 04:24:04.478306	2025-12-04 04:24:04.478306	Sunday	230	245	395	\N	\N	\N	\N
2798	2025-12-04 04:24:04.479187	2025-12-04 04:24:04.479187	Sunday	815	1500	395	\N	\N	\N	\N
2799	2025-12-04 04:24:04.489476	2025-12-04 04:24:04.489476	Monday	2245	145	396	\N	\N	\N	\N
2800	2025-12-04 04:24:04.490281	2025-12-04 04:24:04.490281	Tuesday	1830	245	396	\N	\N	\N	\N
2801	2025-12-04 04:24:04.491047	2025-12-04 04:24:04.491047	Wednesday	45	630	396	\N	\N	\N	\N
2802	2025-12-04 04:24:04.491789	2025-12-04 04:24:04.491789	Wednesday	1415	2200	396	\N	\N	\N	\N
2803	2025-12-04 04:24:04.49257	2025-12-04 04:24:04.49257	Saturday	1900	245	396	\N	\N	\N	\N
2804	2025-12-04 04:24:04.493381	2025-12-04 04:24:04.493381	Sunday	445	545	396	\N	\N	\N	\N
2805	2025-12-04 04:24:04.494158	2025-12-04 04:24:04.494158	Sunday	1145	1800	396	\N	\N	\N	\N
2806	2025-12-04 04:24:04.499921	2025-12-04 04:24:04.499921	Tuesday	215	345	397	\N	\N	\N	\N
2807	2025-12-04 04:24:04.500696	2025-12-04 04:24:04.500696	Tuesday	1915	2215	397	\N	\N	\N	\N
2808	2025-12-04 04:24:04.501487	2025-12-04 04:24:04.501487	Wednesday	1000	1500	397	\N	\N	\N	\N
2809	2025-12-04 04:24:04.502209	2025-12-04 04:24:04.502209	Thursday	1000	1630	397	\N	\N	\N	\N
2810	2025-12-04 04:24:04.50296	2025-12-04 04:24:04.50296	Friday	930	1800	397	\N	\N	\N	\N
2811	2025-12-04 04:24:04.503766	2025-12-04 04:24:04.503766	Saturday	1045	1600	397	\N	\N	\N	\N
2812	2025-12-04 04:24:04.504499	2025-12-04 04:24:04.504499	Saturday	1900	2215	397	\N	\N	\N	\N
2813	2025-12-04 04:24:04.505324	2025-12-04 04:24:04.505324	Sunday	200	230	397	\N	\N	\N	\N
2814	2025-12-04 04:24:04.506068	2025-12-04 04:24:04.506068	Sunday	1000	2145	397	\N	\N	\N	\N
2815	2025-12-04 04:24:04.515512	2025-12-04 04:24:04.515512	Monday	315	800	398	\N	\N	\N	\N
2816	2025-12-04 04:24:04.516321	2025-12-04 04:24:04.516321	Monday	2045	2315	398	\N	\N	\N	\N
2817	2025-12-04 04:24:04.517136	2025-12-04 04:24:04.517136	Tuesday	115	1030	398	\N	\N	\N	\N
2818	2025-12-04 04:24:04.517888	2025-12-04 04:24:04.517888	Tuesday	1530	1915	398	\N	\N	\N	\N
2819	2025-12-04 04:24:04.518693	2025-12-04 04:24:04.518693	Wednesday	730	1430	398	\N	\N	\N	\N
2820	2025-12-04 04:24:04.519403	2025-12-04 04:24:04.519403	Thursday	615	1700	398	\N	\N	\N	\N
2821	2025-12-04 04:24:04.520188	2025-12-04 04:24:04.520188	Friday	1730	1800	398	\N	\N	\N	\N
2822	2025-12-04 04:24:04.520903	2025-12-04 04:24:04.520903	Friday	2015	2215	398	\N	\N	\N	\N
2823	2025-12-04 04:24:04.521677	2025-12-04 04:24:04.521677	Saturday	845	2145	398	\N	\N	\N	\N
2824	2025-12-04 04:24:04.522461	2025-12-04 04:24:04.522461	Sunday	1230	1545	398	\N	\N	\N	\N
2825	2025-12-04 04:24:04.523154	2025-12-04 04:24:04.523154	Sunday	2145	2315	398	\N	\N	\N	\N
2826	2025-12-04 04:24:04.528965	2025-12-04 04:24:04.528965	Wednesday	300	1430	399	\N	\N	\N	\N
2827	2025-12-04 04:24:04.529771	2025-12-04 04:24:04.529771	Wednesday	1600	45	399	\N	\N	\N	\N
2828	2025-12-04 04:24:04.530566	2025-12-04 04:24:04.530566	Thursday	900	1900	399	\N	\N	\N	\N
2829	2025-12-04 04:24:04.531355	2025-12-04 04:24:04.531355	Friday	1000	2145	399	\N	\N	\N	\N
2830	2025-12-04 04:24:04.532059	2025-12-04 04:24:04.532059	Saturday	915	1530	399	\N	\N	\N	\N
2831	2025-12-04 04:24:04.532814	2025-12-04 04:24:04.532814	Sunday	745	1615	399	\N	\N	\N	\N
2832	2025-12-04 04:24:04.541946	2025-12-04 04:24:04.541946	Tuesday	745	1900	400	\N	\N	\N	\N
2833	2025-12-04 04:24:04.54276	2025-12-04 04:24:04.54276	Wednesday	800	2315	400	\N	\N	\N	\N
2834	2025-12-04 04:24:04.543563	2025-12-04 04:24:04.543563	Thursday	245	430	400	\N	\N	\N	\N
2835	2025-12-04 04:24:04.54428	2025-12-04 04:24:04.54428	Thursday	845	1030	400	\N	\N	\N	\N
2836	2025-12-04 04:24:04.545046	2025-12-04 04:24:04.545046	Friday	900	1600	400	\N	\N	\N	\N
2837	2025-12-04 04:24:04.54578	2025-12-04 04:24:04.54578	Sunday	615	2015	400	\N	\N	\N	\N
2838	2025-12-04 04:24:04.551594	2025-12-04 04:24:04.551594	Monday	700	815	401	\N	\N	\N	\N
2839	2025-12-04 04:24:04.552387	2025-12-04 04:24:04.552387	Monday	1315	1845	401	\N	\N	\N	\N
2840	2025-12-04 04:24:04.553138	2025-12-04 04:24:04.553138	Thursday	815	1615	401	\N	\N	\N	\N
2841	2025-12-04 04:24:04.553872	2025-12-04 04:24:04.553872	Friday	630	1915	401	\N	\N	\N	\N
2842	2025-12-04 04:24:04.554609	2025-12-04 04:24:04.554609	Saturday	945	2015	401	\N	\N	\N	\N
2843	2025-12-04 04:24:04.555392	2025-12-04 04:24:04.555392	Sunday	1000	2315	401	\N	\N	\N	\N
2844	2025-12-04 04:24:04.564383	2025-12-04 04:24:04.564383	Monday	645	1430	402	\N	\N	\N	\N
2845	2025-12-04 04:24:04.56516	2025-12-04 04:24:04.56516	Tuesday	1930	215	402	\N	\N	\N	\N
2846	2025-12-04 04:24:04.565908	2025-12-04 04:24:04.565908	Wednesday	800	1700	402	\N	\N	\N	\N
2847	2025-12-04 04:24:04.566699	2025-12-04 04:24:04.566699	Thursday	2015	130	402	\N	\N	\N	\N
2848	2025-12-04 04:24:04.5675	2025-12-04 04:24:04.5675	Friday	500	1100	402	\N	\N	\N	\N
2849	2025-12-04 04:24:04.568231	2025-12-04 04:24:04.568231	Friday	1845	1915	402	\N	\N	\N	\N
2850	2025-12-04 04:24:04.569038	2025-12-04 04:24:04.569038	Saturday	815	2115	402	\N	\N	\N	\N
2851	2025-12-04 04:24:04.575104	2025-12-04 04:24:04.575104	Monday	645	1845	403	\N	\N	\N	\N
2852	2025-12-04 04:24:04.575905	2025-12-04 04:24:04.575905	Tuesday	845	2200	403	\N	\N	\N	\N
2853	2025-12-04 04:24:04.576695	2025-12-04 04:24:04.576695	Thursday	345	645	403	\N	\N	\N	\N
2854	2025-12-04 04:24:04.577434	2025-12-04 04:24:04.577434	Thursday	1245	1800	403	\N	\N	\N	\N
2855	2025-12-04 04:24:04.578169	2025-12-04 04:24:04.578169	Friday	800	1830	403	\N	\N	\N	\N
2856	2025-12-04 04:24:04.578934	2025-12-04 04:24:04.578934	Saturday	745	2345	403	\N	\N	\N	\N
2857	2025-12-04 04:24:04.579762	2025-12-04 04:24:04.579762	Sunday	800	815	403	\N	\N	\N	\N
2858	2025-12-04 04:24:04.580528	2025-12-04 04:24:04.580528	Sunday	1100	115	403	\N	\N	\N	\N
2859	2025-12-04 04:24:04.589645	2025-12-04 04:24:04.589645	Monday	930	1715	404	\N	\N	\N	\N
2860	2025-12-04 04:24:04.590421	2025-12-04 04:24:04.590421	Wednesday	700	2245	404	\N	\N	\N	\N
2861	2025-12-04 04:24:04.591185	2025-12-04 04:24:04.591185	Thursday	915	1630	404	\N	\N	\N	\N
2862	2025-12-04 04:24:04.591976	2025-12-04 04:24:04.591976	Saturday	200	1930	404	\N	\N	\N	\N
2863	2025-12-04 04:24:04.592733	2025-12-04 04:24:04.592733	Saturday	2145	2400	404	\N	\N	\N	\N
2864	2025-12-04 04:24:04.593514	2025-12-04 04:24:04.593514	Sunday	515	830	404	\N	\N	\N	\N
2865	2025-12-04 04:24:04.594279	2025-12-04 04:24:04.594279	Sunday	1930	0	404	\N	\N	\N	\N
2866	2025-12-04 04:24:04.600077	2025-12-04 04:24:04.600077	Tuesday	1400	330	405	\N	\N	\N	\N
2867	2025-12-04 04:24:04.600864	2025-12-04 04:24:04.600864	Wednesday	800	1630	405	\N	\N	\N	\N
2868	2025-12-04 04:24:04.601668	2025-12-04 04:24:04.601668	Thursday	630	1915	405	\N	\N	\N	\N
2869	2025-12-04 04:24:04.602418	2025-12-04 04:24:04.602418	Friday	615	1400	405	\N	\N	\N	\N
2870	2025-12-04 04:24:04.603234	2025-12-04 04:24:04.603234	Saturday	0	430	405	\N	\N	\N	\N
2871	2025-12-04 04:24:04.603944	2025-12-04 04:24:04.603944	Saturday	1130	2130	405	\N	\N	\N	\N
2872	2025-12-04 04:24:04.604772	2025-12-04 04:24:04.604772	Sunday	230	715	405	\N	\N	\N	\N
2873	2025-12-04 04:24:04.60548	2025-12-04 04:24:04.60548	Sunday	1115	2400	405	\N	\N	\N	\N
2874	2025-12-04 04:24:04.615336	2025-12-04 04:24:04.615336	Thursday	715	1400	406	\N	\N	\N	\N
2875	2025-12-04 04:24:04.616121	2025-12-04 04:24:04.616121	Friday	730	1630	406	\N	\N	\N	\N
2876	2025-12-04 04:24:04.616868	2025-12-04 04:24:04.616868	Friday	1800	100	406	\N	\N	\N	\N
2877	2025-12-04 04:24:04.617653	2025-12-04 04:24:04.617653	Saturday	945	1515	406	\N	\N	\N	\N
2878	2025-12-04 04:24:04.618436	2025-12-04 04:24:04.618436	Sunday	230	700	406	\N	\N	\N	\N
2879	2025-12-04 04:24:04.619167	2025-12-04 04:24:04.619167	Sunday	1830	2100	406	\N	\N	\N	\N
2880	2025-12-04 04:24:04.624889	2025-12-04 04:24:04.624889	Monday	630	1630	407	\N	\N	\N	\N
2881	2025-12-04 04:24:04.625761	2025-12-04 04:24:04.625761	Tuesday	445	1300	407	\N	\N	\N	\N
2882	2025-12-04 04:24:04.626538	2025-12-04 04:24:04.626538	Tuesday	1600	2115	407	\N	\N	\N	\N
2883	2025-12-04 04:24:04.627323	2025-12-04 04:24:04.627323	Wednesday	1430	200	407	\N	\N	\N	\N
2884	2025-12-04 04:24:04.628068	2025-12-04 04:24:04.628068	Thursday	745	1515	407	\N	\N	\N	\N
2885	2025-12-04 04:24:04.628853	2025-12-04 04:24:04.628853	Saturday	0	115	407	\N	\N	\N	\N
2886	2025-12-04 04:24:04.629582	2025-12-04 04:24:04.629582	Saturday	545	1600	407	\N	\N	\N	\N
2887	2025-12-04 04:24:04.630345	2025-12-04 04:24:04.630345	Sunday	915	1845	407	\N	\N	\N	\N
2888	2025-12-04 04:24:04.63974	2025-12-04 04:24:04.63974	Monday	715	1715	408	\N	\N	\N	\N
2889	2025-12-04 04:24:04.640554	2025-12-04 04:24:04.640554	Tuesday	815	2315	408	\N	\N	\N	\N
2890	2025-12-04 04:24:04.641325	2025-12-04 04:24:04.641325	Wednesday	1615	345	408	\N	\N	\N	\N
2891	2025-12-04 04:24:04.642321	2025-12-04 04:24:04.642321	Thursday	515	830	408	\N	\N	\N	\N
2892	2025-12-04 04:24:04.643056	2025-12-04 04:24:04.643056	Thursday	2230	200	408	\N	\N	\N	\N
2893	2025-12-04 04:24:04.643798	2025-12-04 04:24:04.643798	Friday	715	1515	408	\N	\N	\N	\N
2894	2025-12-04 04:24:04.644531	2025-12-04 04:24:04.644531	Saturday	700	1615	408	\N	\N	\N	\N
2895	2025-12-04 04:24:04.645295	2025-12-04 04:24:04.645295	Sunday	730	1700	408	\N	\N	\N	\N
2896	2025-12-04 04:24:04.651138	2025-12-04 04:24:04.651138	Monday	700	1915	409	\N	\N	\N	\N
2897	2025-12-04 04:24:04.651936	2025-12-04 04:24:04.651936	Tuesday	800	2115	409	\N	\N	\N	\N
2898	2025-12-04 04:24:04.652742	2025-12-04 04:24:04.652742	Wednesday	800	2215	409	\N	\N	\N	\N
2899	2025-12-04 04:24:04.65354	2025-12-04 04:24:04.65354	Thursday	145	615	409	\N	\N	\N	\N
2900	2025-12-04 04:24:04.654348	2025-12-04 04:24:04.654348	Thursday	1000	1445	409	\N	\N	\N	\N
2901	2025-12-04 04:24:04.655145	2025-12-04 04:24:04.655145	Friday	945	1845	409	\N	\N	\N	\N
2902	2025-12-04 04:24:04.655916	2025-12-04 04:24:04.655916	Saturday	830	1700	409	\N	\N	\N	\N
2903	2025-12-04 04:24:04.65665	2025-12-04 04:24:04.65665	Sunday	900	1845	409	\N	\N	\N	\N
2904	2025-12-04 04:24:04.665575	2025-12-04 04:24:04.665575	Tuesday	800	945	410	\N	\N	\N	\N
2905	2025-12-04 04:24:04.666318	2025-12-04 04:24:04.666318	Tuesday	2045	2130	410	\N	\N	\N	\N
2906	2025-12-04 04:24:04.667044	2025-12-04 04:24:04.667044	Sunday	645	2315	410	\N	\N	\N	\N
2907	2025-12-04 04:24:04.672813	2025-12-04 04:24:04.672813	Monday	715	1700	411	\N	\N	\N	\N
2908	2025-12-04 04:24:04.673796	2025-12-04 04:24:04.673796	Tuesday	715	1800	411	\N	\N	\N	\N
2909	2025-12-04 04:24:04.674546	2025-12-04 04:24:04.674546	Wednesday	930	2300	411	\N	\N	\N	\N
2910	2025-12-04 04:24:04.675345	2025-12-04 04:24:04.675345	Friday	830	1800	411	\N	\N	\N	\N
2911	2025-12-04 04:24:04.676095	2025-12-04 04:24:04.676095	Saturday	900	2330	411	\N	\N	\N	\N
2912	2025-12-04 04:24:04.676848	2025-12-04 04:24:04.676848	Sunday	615	1945	411	\N	\N	\N	\N
2913	2025-12-04 04:24:04.685978	2025-12-04 04:24:04.685978	Monday	645	715	412	\N	\N	\N	\N
2914	2025-12-04 04:24:04.686743	2025-12-04 04:24:04.686743	Monday	815	345	412	\N	\N	\N	\N
2915	2025-12-04 04:24:04.687514	2025-12-04 04:24:04.687514	Tuesday	2245	145	412	\N	\N	\N	\N
2916	2025-12-04 04:24:04.688309	2025-12-04 04:24:04.688309	Wednesday	600	2345	412	\N	\N	\N	\N
2917	2025-12-04 04:24:04.689094	2025-12-04 04:24:04.689094	Thursday	600	1030	412	\N	\N	\N	\N
2918	2025-12-04 04:24:04.689857	2025-12-04 04:24:04.689857	Thursday	1915	30	412	\N	\N	\N	\N
2919	2025-12-04 04:24:04.690612	2025-12-04 04:24:04.690612	Saturday	700	2330	412	\N	\N	\N	\N
2920	2025-12-04 04:24:04.696445	2025-12-04 04:24:04.696445	Monday	1645	115	413	\N	\N	\N	\N
2921	2025-12-04 04:24:04.69721	2025-12-04 04:24:04.69721	Tuesday	745	1945	413	\N	\N	\N	\N
2922	2025-12-04 04:24:04.697985	2025-12-04 04:24:04.697985	Thursday	600	1615	413	\N	\N	\N	\N
2923	2025-12-04 04:24:04.698758	2025-12-04 04:24:04.698758	Friday	815	1445	413	\N	\N	\N	\N
2924	2025-12-04 04:24:04.699591	2025-12-04 04:24:04.699591	Saturday	915	2145	413	\N	\N	\N	\N
2925	2025-12-04 04:24:04.700358	2025-12-04 04:24:04.700358	Sunday	700	1630	413	\N	\N	\N	\N
2926	2025-12-04 04:24:04.712665	2025-12-04 04:24:04.712665	Tuesday	815	2115	414	\N	\N	\N	\N
2927	2025-12-04 04:24:04.713418	2025-12-04 04:24:04.713418	Wednesday	815	1500	414	\N	\N	\N	\N
2928	2025-12-04 04:24:04.71421	2025-12-04 04:24:04.71421	Thursday	615	2130	414	\N	\N	\N	\N
2929	2025-12-04 04:24:04.714965	2025-12-04 04:24:04.714965	Friday	1645	315	414	\N	\N	\N	\N
2930	2025-12-04 04:24:04.715733	2025-12-04 04:24:04.715733	Saturday	1500	230	414	\N	\N	\N	\N
2931	2025-12-04 04:24:04.716511	2025-12-04 04:24:04.716511	Sunday	1945	115	414	\N	\N	\N	\N
2932	2025-12-04 04:24:04.722237	2025-12-04 04:24:04.722237	Monday	930	2200	415	\N	\N	\N	\N
2933	2025-12-04 04:24:04.723046	2025-12-04 04:24:04.723046	Tuesday	1830	330	415	\N	\N	\N	\N
2934	2025-12-04 04:24:04.723851	2025-12-04 04:24:04.723851	Wednesday	530	1445	415	\N	\N	\N	\N
2935	2025-12-04 04:24:04.72457	2025-12-04 04:24:04.72457	Wednesday	1930	2045	415	\N	\N	\N	\N
2936	2025-12-04 04:24:04.725362	2025-12-04 04:24:04.725362	Thursday	1400	1615	415	\N	\N	\N	\N
2937	2025-12-04 04:24:04.726093	2025-12-04 04:24:04.726093	Thursday	1930	1115	415	\N	\N	\N	\N
2938	2025-12-04 04:24:04.726861	2025-12-04 04:24:04.726861	Friday	730	2300	415	\N	\N	\N	\N
2939	2025-12-04 04:24:04.727647	2025-12-04 04:24:04.727647	Saturday	1000	2300	415	\N	\N	\N	\N
2940	2025-12-04 04:24:04.728407	2025-12-04 04:24:04.728407	Sunday	600	1845	415	\N	\N	\N	\N
2941	2025-12-04 04:24:04.737667	2025-12-04 04:24:04.737667	Monday	830	1430	416	\N	\N	\N	\N
2942	2025-12-04 04:24:04.738518	2025-12-04 04:24:04.738518	Wednesday	945	2115	416	\N	\N	\N	\N
2943	2025-12-04 04:24:04.73933	2025-12-04 04:24:04.73933	Friday	845	2045	416	\N	\N	\N	\N
2944	2025-12-04 04:24:04.740123	2025-12-04 04:24:04.740123	Saturday	415	630	416	\N	\N	\N	\N
2945	2025-12-04 04:24:04.740907	2025-12-04 04:24:04.740907	Saturday	1745	2400	416	\N	\N	\N	\N
2946	2025-12-04 04:24:04.746797	2025-12-04 04:24:04.746797	Monday	930	1815	417	\N	\N	\N	\N
2947	2025-12-04 04:24:04.747585	2025-12-04 04:24:04.747585	Tuesday	745	1545	417	\N	\N	\N	\N
2948	2025-12-04 04:24:04.748387	2025-12-04 04:24:04.748387	Wednesday	615	700	417	\N	\N	\N	\N
2949	2025-12-04 04:24:04.749121	2025-12-04 04:24:04.749121	Wednesday	1045	1745	417	\N	\N	\N	\N
2950	2025-12-04 04:24:04.749866	2025-12-04 04:24:04.749866	Friday	815	2130	417	\N	\N	\N	\N
2951	2025-12-04 04:24:04.750576	2025-12-04 04:24:04.750576	Saturday	615	2230	417	\N	\N	\N	\N
2952	2025-12-04 04:24:04.75947	2025-12-04 04:24:04.75947	Tuesday	830	1815	418	\N	\N	\N	\N
2953	2025-12-04 04:24:04.760252	2025-12-04 04:24:04.760252	Wednesday	700	2215	418	\N	\N	\N	\N
2954	2025-12-04 04:24:04.761099	2025-12-04 04:24:04.761099	Thursday	2115	400	418	\N	\N	\N	\N
2955	2025-12-04 04:24:04.761862	2025-12-04 04:24:04.761862	Friday	1145	1630	418	\N	\N	\N	\N
2956	2025-12-04 04:24:04.762598	2025-12-04 04:24:04.762598	Friday	2100	2345	418	\N	\N	\N	\N
2957	2025-12-04 04:24:04.763321	2025-12-04 04:24:04.763321	Saturday	730	1645	418	\N	\N	\N	\N
2958	2025-12-04 04:24:04.764061	2025-12-04 04:24:04.764061	Sunday	830	1530	418	\N	\N	\N	\N
2959	2025-12-04 04:24:04.769738	2025-12-04 04:24:04.769738	Monday	1115	1630	419	\N	\N	\N	\N
2960	2025-12-04 04:24:04.7705	2025-12-04 04:24:04.7705	Monday	1800	2100	419	\N	\N	\N	\N
2961	2025-12-04 04:24:04.771274	2025-12-04 04:24:04.771274	Wednesday	600	2200	419	\N	\N	\N	\N
2962	2025-12-04 04:24:04.77203	2025-12-04 04:24:04.77203	Thursday	730	2045	419	\N	\N	\N	\N
2963	2025-12-04 04:24:04.772782	2025-12-04 04:24:04.772782	Saturday	1000	2345	419	\N	\N	\N	\N
2964	2025-12-04 04:24:04.773532	2025-12-04 04:24:04.773532	Sunday	615	1630	419	\N	\N	\N	\N
2965	2025-12-04 04:24:04.783196	2025-12-04 04:24:04.783196	Monday	1000	1545	420	\N	\N	\N	\N
2966	2025-12-04 04:24:04.784059	2025-12-04 04:24:04.784059	Tuesday	630	2030	420	\N	\N	\N	\N
2967	2025-12-04 04:24:04.784826	2025-12-04 04:24:04.784826	Wednesday	630	1915	420	\N	\N	\N	\N
2968	2025-12-04 04:24:04.785591	2025-12-04 04:24:04.785591	Thursday	930	1515	420	\N	\N	\N	\N
2969	2025-12-04 04:24:04.786323	2025-12-04 04:24:04.786323	Saturday	715	1600	420	\N	\N	\N	\N
2970	2025-12-04 04:24:04.78703	2025-12-04 04:24:04.78703	Sunday	1000	1600	420	\N	\N	\N	\N
2971	2025-12-04 04:24:04.79276	2025-12-04 04:24:04.79276	Monday	1400	245	421	\N	\N	\N	\N
2972	2025-12-04 04:24:04.793514	2025-12-04 04:24:04.793514	Tuesday	715	1945	421	\N	\N	\N	\N
2973	2025-12-04 04:24:04.794283	2025-12-04 04:24:04.794283	Thursday	2100	400	421	\N	\N	\N	\N
2974	2025-12-04 04:24:04.795022	2025-12-04 04:24:04.795022	Friday	830	1745	421	\N	\N	\N	\N
2975	2025-12-04 04:24:04.795795	2025-12-04 04:24:04.795795	Saturday	900	1915	421	\N	\N	\N	\N
2976	2025-12-04 04:24:04.796526	2025-12-04 04:24:04.796526	Sunday	815	1500	421	\N	\N	\N	\N
2977	2025-12-04 04:24:04.806066	2025-12-04 04:24:04.806066	Monday	715	2330	422	\N	\N	\N	\N
2978	2025-12-04 04:24:04.806818	2025-12-04 04:24:04.806818	Tuesday	930	1930	422	\N	\N	\N	\N
2979	2025-12-04 04:24:04.807581	2025-12-04 04:24:04.807581	Wednesday	345	830	422	\N	\N	\N	\N
2980	2025-12-04 04:24:04.808324	2025-12-04 04:24:04.808324	Wednesday	845	300	422	\N	\N	\N	\N
2981	2025-12-04 04:24:04.809242	2025-12-04 04:24:04.809242	Thursday	630	2015	422	\N	\N	\N	\N
2982	2025-12-04 04:24:04.809973	2025-12-04 04:24:04.809973	Saturday	815	1830	422	\N	\N	\N	\N
2983	2025-12-04 04:24:04.810742	2025-12-04 04:24:04.810742	Sunday	1845	145	422	\N	\N	\N	\N
2984	2025-12-04 04:24:04.816384	2025-12-04 04:24:04.816384	Monday	2215	145	423	\N	\N	\N	\N
2985	2025-12-04 04:24:04.817161	2025-12-04 04:24:04.817161	Tuesday	1445	215	423	\N	\N	\N	\N
2986	2025-12-04 04:24:04.817997	2025-12-04 04:24:04.817997	Thursday	400	830	423	\N	\N	\N	\N
2987	2025-12-04 04:24:04.818811	2025-12-04 04:24:04.818811	Thursday	900	1715	423	\N	\N	\N	\N
2988	2025-12-04 04:24:04.819665	2025-12-04 04:24:04.819665	Friday	915	1545	423	\N	\N	\N	\N
2989	2025-12-04 04:24:04.820504	2025-12-04 04:24:04.820504	Sunday	1815	215	423	\N	\N	\N	\N
2990	2025-12-04 04:24:04.8311	2025-12-04 04:24:04.8311	Monday	615	1900	424	\N	\N	\N	\N
2991	2025-12-04 04:24:04.83197	2025-12-04 04:24:04.83197	Tuesday	830	2145	424	\N	\N	\N	\N
2992	2025-12-04 04:24:04.832799	2025-12-04 04:24:04.832799	Wednesday	1000	1930	424	\N	\N	\N	\N
2993	2025-12-04 04:24:04.83368	2025-12-04 04:24:04.83368	Thursday	700	1445	424	\N	\N	\N	\N
2994	2025-12-04 04:24:04.834544	2025-12-04 04:24:04.834544	Friday	730	1915	424	\N	\N	\N	\N
2995	2025-12-04 04:24:04.835423	2025-12-04 04:24:04.835423	Sunday	1400	330	424	\N	\N	\N	\N
2996	2025-12-04 04:24:04.841666	2025-12-04 04:24:04.841666	Monday	600	2315	425	\N	\N	\N	\N
2997	2025-12-04 04:24:04.842514	2025-12-04 04:24:04.842514	Tuesday	845	2400	425	\N	\N	\N	\N
2998	2025-12-04 04:24:04.843371	2025-12-04 04:24:04.843371	Wednesday	730	2215	425	\N	\N	\N	\N
2999	2025-12-04 04:24:04.844427	2025-12-04 04:24:04.844427	Friday	2000	200	425	\N	\N	\N	\N
3000	2025-12-04 04:24:04.845248	2025-12-04 04:24:04.845248	Sunday	930	2015	425	\N	\N	\N	\N
3001	2025-12-04 04:24:04.854599	2025-12-04 04:24:04.854599	Monday	315	1230	426	\N	\N	\N	\N
3002	2025-12-04 04:24:04.855368	2025-12-04 04:24:04.855368	Monday	1845	2400	426	\N	\N	\N	\N
3003	2025-12-04 04:24:04.856154	2025-12-04 04:24:04.856154	Tuesday	2030	330	426	\N	\N	\N	\N
3004	2025-12-04 04:24:04.856923	2025-12-04 04:24:04.856923	Wednesday	430	945	426	\N	\N	\N	\N
3005	2025-12-04 04:24:04.857662	2025-12-04 04:24:04.857662	Wednesday	1000	1545	426	\N	\N	\N	\N
3006	2025-12-04 04:24:04.858404	2025-12-04 04:24:04.858404	Thursday	915	1615	426	\N	\N	\N	\N
3007	2025-12-04 04:24:04.859173	2025-12-04 04:24:04.859173	Friday	645	1700	426	\N	\N	\N	\N
3008	2025-12-04 04:24:04.859906	2025-12-04 04:24:04.859906	Saturday	615	2215	426	\N	\N	\N	\N
3009	2025-12-04 04:24:04.860677	2025-12-04 04:24:04.860677	Sunday	800	1715	426	\N	\N	\N	\N
3010	2025-12-04 04:24:04.866347	2025-12-04 04:24:04.866347	Monday	845	2000	427	\N	\N	\N	\N
3011	2025-12-04 04:24:04.867143	2025-12-04 04:24:04.867143	Tuesday	1230	1715	427	\N	\N	\N	\N
3012	2025-12-04 04:24:04.867876	2025-12-04 04:24:04.867876	Tuesday	2230	645	427	\N	\N	\N	\N
3013	2025-12-04 04:24:04.86861	2025-12-04 04:24:04.86861	Wednesday	1000	1500	427	\N	\N	\N	\N
3014	2025-12-04 04:24:04.86939	2025-12-04 04:24:04.86939	Thursday	1000	2000	427	\N	\N	\N	\N
3015	2025-12-04 04:24:04.87013	2025-12-04 04:24:04.87013	Friday	1000	1845	427	\N	\N	\N	\N
3016	2025-12-04 04:24:04.870897	2025-12-04 04:24:04.870897	Saturday	1400	115	427	\N	\N	\N	\N
3017	2025-12-04 04:24:04.871699	2025-12-04 04:24:04.871699	Sunday	900	2000	427	\N	\N	\N	\N
3018	2025-12-04 04:24:04.880558	2025-12-04 04:24:04.880558	Monday	715	2045	428	\N	\N	\N	\N
3019	2025-12-04 04:24:04.881342	2025-12-04 04:24:04.881342	Wednesday	800	2130	428	\N	\N	\N	\N
3020	2025-12-04 04:24:04.882081	2025-12-04 04:24:04.882081	Thursday	945	1700	428	\N	\N	\N	\N
3021	2025-12-04 04:24:04.882864	2025-12-04 04:24:04.882864	Friday	15	200	428	\N	\N	\N	\N
3022	2025-12-04 04:24:04.883622	2025-12-04 04:24:04.883622	Friday	415	830	428	\N	\N	\N	\N
3023	2025-12-04 04:24:04.88448	2025-12-04 04:24:04.88448	Saturday	30	600	428	\N	\N	\N	\N
3024	2025-12-04 04:24:04.885205	2025-12-04 04:24:04.885205	Saturday	1015	1245	428	\N	\N	\N	\N
3025	2025-12-04 04:24:04.885983	2025-12-04 04:24:04.885983	Sunday	730	1345	428	\N	\N	\N	\N
3026	2025-12-04 04:24:04.8867	2025-12-04 04:24:04.8867	Sunday	1500	1515	428	\N	\N	\N	\N
3027	2025-12-04 04:24:04.892528	2025-12-04 04:24:04.892528	Monday	830	1700	429	\N	\N	\N	\N
3028	2025-12-04 04:24:04.893318	2025-12-04 04:24:04.893318	Wednesday	800	2145	429	\N	\N	\N	\N
3029	2025-12-04 04:24:04.894068	2025-12-04 04:24:04.894068	Saturday	830	2215	429	\N	\N	\N	\N
3030	2025-12-04 04:24:04.894868	2025-12-04 04:24:04.894868	Sunday	0	200	429	\N	\N	\N	\N
3031	2025-12-04 04:24:04.895578	2025-12-04 04:24:04.895578	Sunday	1830	2345	429	\N	\N	\N	\N
3032	2025-12-04 04:24:04.905543	2025-12-04 04:24:04.905543	Monday	1000	2130	430	\N	\N	\N	\N
3033	2025-12-04 04:24:04.906317	2025-12-04 04:24:04.906317	Tuesday	815	1730	430	\N	\N	\N	\N
3034	2025-12-04 04:24:04.907033	2025-12-04 04:24:04.907033	Wednesday	600	2015	430	\N	\N	\N	\N
3035	2025-12-04 04:24:04.907789	2025-12-04 04:24:04.907789	Thursday	800	1815	430	\N	\N	\N	\N
3036	2025-12-04 04:24:04.908934	2025-12-04 04:24:04.908934	Friday	1000	2400	430	\N	\N	\N	\N
3037	2025-12-04 04:24:04.909688	2025-12-04 04:24:04.909688	Saturday	630	2030	430	\N	\N	\N	\N
3038	2025-12-04 04:24:04.915384	2025-12-04 04:24:04.915384	Monday	1930	345	431	\N	\N	\N	\N
3039	2025-12-04 04:24:04.916137	2025-12-04 04:24:04.916137	Tuesday	830	2230	431	\N	\N	\N	\N
3040	2025-12-04 04:24:04.91691	2025-12-04 04:24:04.91691	Thursday	45	145	431	\N	\N	\N	\N
3041	2025-12-04 04:24:04.917651	2025-12-04 04:24:04.917651	Thursday	1345	2400	431	\N	\N	\N	\N
3042	2025-12-04 04:24:04.918386	2025-12-04 04:24:04.918386	Friday	930	1415	431	\N	\N	\N	\N
3043	2025-12-04 04:24:04.919168	2025-12-04 04:24:04.919168	Saturday	1215	1400	431	\N	\N	\N	\N
3044	2025-12-04 04:24:04.919887	2025-12-04 04:24:04.919887	Saturday	2200	130	431	\N	\N	\N	\N
3045	2025-12-04 04:24:04.920651	2025-12-04 04:24:04.920651	Sunday	930	1645	431	\N	\N	\N	\N
3046	2025-12-04 04:24:04.92995	2025-12-04 04:24:04.92995	Monday	115	245	432	\N	\N	\N	\N
3047	2025-12-04 04:24:04.930716	2025-12-04 04:24:04.930716	Monday	630	1315	432	\N	\N	\N	\N
3048	2025-12-04 04:24:04.931475	2025-12-04 04:24:04.931475	Tuesday	715	1730	432	\N	\N	\N	\N
3049	2025-12-04 04:24:04.932223	2025-12-04 04:24:04.932223	Wednesday	1000	2000	432	\N	\N	\N	\N
3050	2025-12-04 04:24:04.932962	2025-12-04 04:24:04.932962	Thursday	1730	215	432	\N	\N	\N	\N
3051	2025-12-04 04:24:04.933734	2025-12-04 04:24:04.933734	Sunday	45	1930	432	\N	\N	\N	\N
3052	2025-12-04 04:24:04.934464	2025-12-04 04:24:04.934464	Sunday	2115	2315	432	\N	\N	\N	\N
3053	2025-12-04 04:24:04.940282	2025-12-04 04:24:04.940282	Monday	815	1845	433	\N	\N	\N	\N
3054	2025-12-04 04:24:04.941055	2025-12-04 04:24:04.941055	Tuesday	615	1915	433	\N	\N	\N	\N
3055	2025-12-04 04:24:04.941829	2025-12-04 04:24:04.941829	Wednesday	545	600	433	\N	\N	\N	\N
3056	2025-12-04 04:24:04.942559	2025-12-04 04:24:04.942559	Wednesday	1245	1845	433	\N	\N	\N	\N
3057	2025-12-04 04:24:04.943347	2025-12-04 04:24:04.943347	Thursday	615	715	433	\N	\N	\N	\N
3058	2025-12-04 04:24:04.944072	2025-12-04 04:24:04.944072	Thursday	730	1615	433	\N	\N	\N	\N
3059	2025-12-04 04:24:04.944788	2025-12-04 04:24:04.944788	Friday	800	1900	433	\N	\N	\N	\N
3060	2025-12-04 04:24:04.945538	2025-12-04 04:24:04.945538	Saturday	615	730	433	\N	\N	\N	\N
3061	2025-12-04 04:24:04.946244	2025-12-04 04:24:04.946244	Saturday	900	2215	433	\N	\N	\N	\N
3062	2025-12-04 04:24:04.946965	2025-12-04 04:24:04.946965	Sunday	730	2215	433	\N	\N	\N	\N
3063	2025-12-04 04:24:04.955845	2025-12-04 04:24:04.955845	Monday	115	745	434	\N	\N	\N	\N
3064	2025-12-04 04:24:04.956591	2025-12-04 04:24:04.956591	Monday	900	1930	434	\N	\N	\N	\N
3065	2025-12-04 04:24:04.957349	2025-12-04 04:24:04.957349	Tuesday	645	1715	434	\N	\N	\N	\N
3066	2025-12-04 04:24:04.958131	2025-12-04 04:24:04.958131	Wednesday	1830	130	434	\N	\N	\N	\N
3067	2025-12-04 04:24:04.958864	2025-12-04 04:24:04.958864	Thursday	900	2330	434	\N	\N	\N	\N
3068	2025-12-04 04:24:04.95962	2025-12-04 04:24:04.95962	Friday	845	1815	434	\N	\N	\N	\N
3069	2025-12-04 04:24:04.960389	2025-12-04 04:24:04.960389	Saturday	630	2145	434	\N	\N	\N	\N
3070	2025-12-04 04:24:04.96604	2025-12-04 04:24:04.96604	Tuesday	830	1400	435	\N	\N	\N	\N
3071	2025-12-04 04:24:04.966831	2025-12-04 04:24:04.966831	Wednesday	830	1530	435	\N	\N	\N	\N
3072	2025-12-04 04:24:04.96761	2025-12-04 04:24:04.96761	Thursday	715	730	435	\N	\N	\N	\N
3073	2025-12-04 04:24:04.968343	2025-12-04 04:24:04.968343	Thursday	945	1000	435	\N	\N	\N	\N
3074	2025-12-04 04:24:04.969078	2025-12-04 04:24:04.969078	Friday	1000	1845	435	\N	\N	\N	\N
3075	2025-12-04 04:24:04.969811	2025-12-04 04:24:04.969811	Sunday	1645	345	435	\N	\N	\N	\N
\.


--
-- Data for Name: schedules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedules (id, created_at, updated_at, resource_id, service_id, hours_known) FROM stdin;
1	2025-12-04 04:23:58.706982	2025-12-04 04:23:58.706982	1	\N	t
2	2025-12-04 04:23:58.742449	2025-12-04 04:23:58.742449	\N	1	t
3	2025-12-04 04:23:58.776403	2025-12-04 04:23:58.776403	2	\N	t
4	2025-12-04 04:23:58.789909	2025-12-04 04:23:58.789909	\N	2	t
5	2025-12-04 04:23:58.806833	2025-12-04 04:23:58.806833	\N	3	t
6	2025-12-04 04:23:58.824772	2025-12-04 04:23:58.824772	3	\N	t
7	2025-12-04 04:23:58.833194	2025-12-04 04:23:58.833194	\N	4	t
8	2025-12-04 04:23:58.846074	2025-12-04 04:23:58.846074	\N	5	t
9	2025-12-04 04:23:58.859712	2025-12-04 04:23:58.859712	4	\N	t
10	2025-12-04 04:23:58.869093	2025-12-04 04:23:58.869093	\N	6	t
11	2025-12-04 04:23:58.884163	2025-12-04 04:23:58.884163	5	\N	t
12	2025-12-04 04:23:58.894931	2025-12-04 04:23:58.894931	\N	7	t
13	2025-12-04 04:23:58.90817	2025-12-04 04:23:58.90817	6	\N	t
14	2025-12-04 04:23:58.918762	2025-12-04 04:23:58.918762	\N	8	t
15	2025-12-04 04:23:58.936311	2025-12-04 04:23:58.936311	7	\N	t
16	2025-12-04 04:23:58.947695	2025-12-04 04:23:58.947695	\N	9	t
17	2025-12-04 04:23:58.963771	2025-12-04 04:23:58.963771	8	\N	t
18	2025-12-04 04:23:58.974366	2025-12-04 04:23:58.974366	\N	10	t
19	2025-12-04 04:23:58.989321	2025-12-04 04:23:58.989321	9	\N	t
20	2025-12-04 04:23:59.000395	2025-12-04 04:23:59.000395	\N	11	t
21	2025-12-04 04:23:59.013226	2025-12-04 04:23:59.013226	10	\N	t
22	2025-12-04 04:23:59.02389	2025-12-04 04:23:59.02389	\N	12	t
23	2025-12-04 04:23:59.041813	2025-12-04 04:23:59.041813	11	\N	t
24	2025-12-04 04:23:59.050205	2025-12-04 04:23:59.050205	\N	13	t
25	2025-12-04 04:23:59.062101	2025-12-04 04:23:59.062101	\N	14	t
26	2025-12-04 04:23:59.076517	2025-12-04 04:23:59.076517	12	\N	t
27	2025-12-04 04:23:59.08568	2025-12-04 04:23:59.08568	\N	15	t
28	2025-12-04 04:23:59.098779	2025-12-04 04:23:59.098779	13	\N	t
29	2025-12-04 04:23:59.108671	2025-12-04 04:23:59.108671	\N	16	t
30	2025-12-04 04:23:59.122126	2025-12-04 04:23:59.122126	\N	17	t
31	2025-12-04 04:23:59.135795	2025-12-04 04:23:59.135795	14	\N	t
32	2025-12-04 04:23:59.144117	2025-12-04 04:23:59.144117	\N	18	t
33	2025-12-04 04:23:59.159941	2025-12-04 04:23:59.159941	15	\N	t
34	2025-12-04 04:23:59.170638	2025-12-04 04:23:59.170638	\N	19	t
35	2025-12-04 04:23:59.183611	2025-12-04 04:23:59.183611	16	\N	t
36	2025-12-04 04:23:59.194837	2025-12-04 04:23:59.194837	\N	20	t
37	2025-12-04 04:23:59.210094	2025-12-04 04:23:59.210094	17	\N	t
38	2025-12-04 04:23:59.221826	2025-12-04 04:23:59.221826	\N	21	t
39	2025-12-04 04:23:59.236908	2025-12-04 04:23:59.236908	18	\N	t
40	2025-12-04 04:23:59.249827	2025-12-04 04:23:59.249827	\N	22	t
41	2025-12-04 04:23:59.26485	2025-12-04 04:23:59.26485	\N	23	t
42	2025-12-04 04:23:59.2804	2025-12-04 04:23:59.2804	19	\N	t
43	2025-12-04 04:23:59.289947	2025-12-04 04:23:59.289947	\N	24	t
44	2025-12-04 04:23:59.303754	2025-12-04 04:23:59.303754	\N	25	t
45	2025-12-04 04:23:59.318929	2025-12-04 04:23:59.318929	20	\N	t
46	2025-12-04 04:23:59.333948	2025-12-04 04:23:59.333948	\N	26	t
47	2025-12-04 04:23:59.347387	2025-12-04 04:23:59.347387	\N	27	t
48	2025-12-04 04:23:59.364451	2025-12-04 04:23:59.364451	21	\N	t
49	2025-12-04 04:23:59.376022	2025-12-04 04:23:59.376022	\N	28	t
50	2025-12-04 04:23:59.390099	2025-12-04 04:23:59.390099	\N	29	t
51	2025-12-04 04:23:59.40483	2025-12-04 04:23:59.40483	22	\N	t
52	2025-12-04 04:23:59.415387	2025-12-04 04:23:59.415387	\N	30	t
53	2025-12-04 04:23:59.432764	2025-12-04 04:23:59.432764	23	\N	t
54	2025-12-04 04:23:59.44598	2025-12-04 04:23:59.44598	\N	31	t
55	2025-12-04 04:23:59.460643	2025-12-04 04:23:59.460643	24	\N	t
56	2025-12-04 04:23:59.472669	2025-12-04 04:23:59.472669	\N	32	t
57	2025-12-04 04:23:59.491484	2025-12-04 04:23:59.491484	25	\N	t
58	2025-12-04 04:23:59.504333	2025-12-04 04:23:59.504333	\N	33	t
59	2025-12-04 04:23:59.521632	2025-12-04 04:23:59.521632	26	\N	t
60	2025-12-04 04:23:59.53285	2025-12-04 04:23:59.53285	\N	34	t
61	2025-12-04 04:23:59.549808	2025-12-04 04:23:59.549808	27	\N	t
62	2025-12-04 04:23:59.558861	2025-12-04 04:23:59.558861	\N	35	t
63	2025-12-04 04:23:59.577373	2025-12-04 04:23:59.577373	28	\N	t
64	2025-12-04 04:23:59.585078	2025-12-04 04:23:59.585078	\N	36	t
65	2025-12-04 04:23:59.59845	2025-12-04 04:23:59.59845	\N	37	t
66	2025-12-04 04:23:59.614767	2025-12-04 04:23:59.614767	29	\N	t
67	2025-12-04 04:23:59.62504	2025-12-04 04:23:59.62504	\N	38	t
68	2025-12-04 04:23:59.641405	2025-12-04 04:23:59.641405	\N	39	t
69	2025-12-04 04:23:59.655643	2025-12-04 04:23:59.655643	30	\N	t
70	2025-12-04 04:23:59.666785	2025-12-04 04:23:59.666785	\N	40	t
71	2025-12-04 04:23:59.683219	2025-12-04 04:23:59.683219	31	\N	t
72	2025-12-04 04:23:59.693608	2025-12-04 04:23:59.693608	\N	41	t
73	2025-12-04 04:23:59.70922	2025-12-04 04:23:59.70922	\N	42	t
74	2025-12-04 04:23:59.72305	2025-12-04 04:23:59.72305	32	\N	t
75	2025-12-04 04:23:59.733194	2025-12-04 04:23:59.733194	\N	43	t
76	2025-12-04 04:23:59.746031	2025-12-04 04:23:59.746031	\N	44	t
77	2025-12-04 04:23:59.758947	2025-12-04 04:23:59.758947	33	\N	t
78	2025-12-04 04:23:59.77056	2025-12-04 04:23:59.77056	\N	45	t
79	2025-12-04 04:23:59.785045	2025-12-04 04:23:59.785045	\N	46	t
80	2025-12-04 04:23:59.79884	2025-12-04 04:23:59.79884	34	\N	t
81	2025-12-04 04:23:59.809029	2025-12-04 04:23:59.809029	\N	47	t
82	2025-12-04 04:23:59.824736	2025-12-04 04:23:59.824736	35	\N	t
83	2025-12-04 04:23:59.8371	2025-12-04 04:23:59.8371	\N	48	t
84	2025-12-04 04:23:59.853635	2025-12-04 04:23:59.853635	36	\N	t
85	2025-12-04 04:23:59.865081	2025-12-04 04:23:59.865081	\N	49	t
86	2025-12-04 04:23:59.882439	2025-12-04 04:23:59.882439	37	\N	t
87	2025-12-04 04:23:59.893095	2025-12-04 04:23:59.893095	\N	50	t
88	2025-12-04 04:23:59.912704	2025-12-04 04:23:59.912704	38	\N	t
89	2025-12-04 04:23:59.921976	2025-12-04 04:23:59.921976	\N	51	t
90	2025-12-04 04:23:59.939437	2025-12-04 04:23:59.939437	39	\N	t
91	2025-12-04 04:23:59.951479	2025-12-04 04:23:59.951479	\N	52	t
92	2025-12-04 04:23:59.964478	2025-12-04 04:23:59.964478	\N	53	t
93	2025-12-04 04:23:59.991173	2025-12-04 04:23:59.991173	40	\N	t
94	2025-12-04 04:24:00.00275	2025-12-04 04:24:00.00275	\N	54	t
95	2025-12-04 04:24:00.018719	2025-12-04 04:24:00.018719	41	\N	t
96	2025-12-04 04:24:00.029539	2025-12-04 04:24:00.029539	\N	55	t
97	2025-12-04 04:24:00.046958	2025-12-04 04:24:00.046958	42	\N	t
98	2025-12-04 04:24:00.055827	2025-12-04 04:24:00.055827	\N	56	t
99	2025-12-04 04:24:00.072082	2025-12-04 04:24:00.072082	43	\N	t
100	2025-12-04 04:24:00.08498	2025-12-04 04:24:00.08498	\N	57	t
101	2025-12-04 04:24:00.098149	2025-12-04 04:24:00.098149	\N	58	t
102	2025-12-04 04:24:00.114378	2025-12-04 04:24:00.114378	44	\N	t
103	2025-12-04 04:24:00.125425	2025-12-04 04:24:00.125425	\N	59	t
104	2025-12-04 04:24:00.142372	2025-12-04 04:24:00.142372	45	\N	t
105	2025-12-04 04:24:00.153409	2025-12-04 04:24:00.153409	\N	60	t
106	2025-12-04 04:24:00.164265	2025-12-04 04:24:00.164265	\N	61	t
107	2025-12-04 04:24:00.180758	2025-12-04 04:24:00.180758	46	\N	t
108	2025-12-04 04:24:00.191148	2025-12-04 04:24:00.191148	\N	62	t
109	2025-12-04 04:24:00.209964	2025-12-04 04:24:00.209964	47	\N	t
110	2025-12-04 04:24:00.221987	2025-12-04 04:24:00.221987	\N	63	t
111	2025-12-04 04:24:00.237334	2025-12-04 04:24:00.237334	48	\N	t
112	2025-12-04 04:24:00.250671	2025-12-04 04:24:00.250671	\N	64	t
113	2025-12-04 04:24:00.266233	2025-12-04 04:24:00.266233	49	\N	t
114	2025-12-04 04:24:00.274676	2025-12-04 04:24:00.274676	\N	65	t
115	2025-12-04 04:24:00.290294	2025-12-04 04:24:00.290294	\N	66	t
116	2025-12-04 04:24:00.306342	2025-12-04 04:24:00.306342	50	\N	t
117	2025-12-04 04:24:00.315648	2025-12-04 04:24:00.315648	\N	67	t
118	2025-12-04 04:24:00.330429	2025-12-04 04:24:00.330429	51	\N	t
119	2025-12-04 04:24:00.341981	2025-12-04 04:24:00.341981	\N	68	t
120	2025-12-04 04:24:00.355743	2025-12-04 04:24:00.355743	\N	69	t
121	2025-12-04 04:24:00.372633	2025-12-04 04:24:00.372633	52	\N	t
122	2025-12-04 04:24:00.382313	2025-12-04 04:24:00.382313	\N	70	t
123	2025-12-04 04:24:00.396653	2025-12-04 04:24:00.396653	\N	71	t
124	2025-12-04 04:24:00.411901	2025-12-04 04:24:00.411901	53	\N	t
125	2025-12-04 04:24:00.422393	2025-12-04 04:24:00.422393	\N	72	t
126	2025-12-04 04:24:00.435373	2025-12-04 04:24:00.435373	\N	73	t
127	2025-12-04 04:24:00.45001	2025-12-04 04:24:00.45001	54	\N	t
128	2025-12-04 04:24:00.460925	2025-12-04 04:24:00.460925	\N	74	t
129	2025-12-04 04:24:00.47832	2025-12-04 04:24:00.47832	55	\N	t
130	2025-12-04 04:24:00.491365	2025-12-04 04:24:00.491365	\N	75	t
131	2025-12-04 04:24:00.507472	2025-12-04 04:24:00.507472	56	\N	t
132	2025-12-04 04:24:00.519527	2025-12-04 04:24:00.519527	\N	76	t
133	2025-12-04 04:24:00.534667	2025-12-04 04:24:00.534667	57	\N	t
134	2025-12-04 04:24:00.545781	2025-12-04 04:24:00.545781	\N	77	t
135	2025-12-04 04:24:00.56058	2025-12-04 04:24:00.56058	\N	78	t
136	2025-12-04 04:24:00.576322	2025-12-04 04:24:00.576322	58	\N	t
137	2025-12-04 04:24:00.586304	2025-12-04 04:24:00.586304	\N	79	t
138	2025-12-04 04:24:00.605337	2025-12-04 04:24:00.605337	59	\N	t
139	2025-12-04 04:24:00.618069	2025-12-04 04:24:00.618069	\N	80	t
140	2025-12-04 04:24:00.635362	2025-12-04 04:24:00.635362	60	\N	t
141	2025-12-04 04:24:00.64707	2025-12-04 04:24:00.64707	\N	81	t
142	2025-12-04 04:24:00.663442	2025-12-04 04:24:00.663442	61	\N	t
143	2025-12-04 04:24:00.674815	2025-12-04 04:24:00.674815	\N	82	t
144	2025-12-04 04:24:00.690633	2025-12-04 04:24:00.690633	\N	83	t
145	2025-12-04 04:24:00.706707	2025-12-04 04:24:00.706707	62	\N	t
146	2025-12-04 04:24:00.716799	2025-12-04 04:24:00.716799	\N	84	t
147	2025-12-04 04:24:00.734166	2025-12-04 04:24:00.734166	63	\N	t
148	2025-12-04 04:24:00.743845	2025-12-04 04:24:00.743845	\N	85	t
149	2025-12-04 04:24:00.761571	2025-12-04 04:24:00.761571	64	\N	t
150	2025-12-04 04:24:00.771559	2025-12-04 04:24:00.771559	\N	86	t
151	2025-12-04 04:24:00.7903	2025-12-04 04:24:00.7903	65	\N	t
152	2025-12-04 04:24:00.801625	2025-12-04 04:24:00.801625	\N	87	t
153	2025-12-04 04:24:00.818858	2025-12-04 04:24:00.818858	\N	88	t
154	2025-12-04 04:24:00.834375	2025-12-04 04:24:00.834375	66	\N	t
155	2025-12-04 04:24:00.843407	2025-12-04 04:24:00.843407	\N	89	t
156	2025-12-04 04:24:00.864477	2025-12-04 04:24:00.864477	67	\N	t
157	2025-12-04 04:24:00.876076	2025-12-04 04:24:00.876076	\N	90	t
158	2025-12-04 04:24:00.89163	2025-12-04 04:24:00.89163	\N	91	t
159	2025-12-04 04:24:00.907213	2025-12-04 04:24:00.907213	68	\N	t
160	2025-12-04 04:24:00.916963	2025-12-04 04:24:00.916963	\N	92	t
161	2025-12-04 04:24:00.932262	2025-12-04 04:24:00.932262	69	\N	t
162	2025-12-04 04:24:00.944094	2025-12-04 04:24:00.944094	\N	93	t
163	2025-12-04 04:24:00.959889	2025-12-04 04:24:00.959889	70	\N	t
164	2025-12-04 04:24:00.968354	2025-12-04 04:24:00.968354	\N	94	t
165	2025-12-04 04:24:00.983997	2025-12-04 04:24:00.983997	71	\N	t
166	2025-12-04 04:24:00.993844	2025-12-04 04:24:00.993844	\N	95	t
167	2025-12-04 04:24:01.008358	2025-12-04 04:24:01.008358	\N	96	t
168	2025-12-04 04:24:01.026792	2025-12-04 04:24:01.026792	72	\N	t
169	2025-12-04 04:24:01.037473	2025-12-04 04:24:01.037473	\N	97	t
170	2025-12-04 04:24:01.052752	2025-12-04 04:24:01.052752	73	\N	t
171	2025-12-04 04:24:01.062102	2025-12-04 04:24:01.062102	\N	98	t
172	2025-12-04 04:24:01.074559	2025-12-04 04:24:01.074559	\N	99	t
173	2025-12-04 04:24:01.091468	2025-12-04 04:24:01.091468	74	\N	t
174	2025-12-04 04:24:01.101398	2025-12-04 04:24:01.101398	\N	100	t
175	2025-12-04 04:24:01.114844	2025-12-04 04:24:01.114844	\N	101	t
176	2025-12-04 04:24:01.129135	2025-12-04 04:24:01.129135	75	\N	t
177	2025-12-04 04:24:01.139182	2025-12-04 04:24:01.139182	\N	102	t
178	2025-12-04 04:24:01.158615	2025-12-04 04:24:01.158615	76	\N	t
179	2025-12-04 04:24:01.16852	2025-12-04 04:24:01.16852	\N	103	t
180	2025-12-04 04:24:01.181606	2025-12-04 04:24:01.181606	\N	104	t
181	2025-12-04 04:24:01.198589	2025-12-04 04:24:01.198589	77	\N	t
182	2025-12-04 04:24:01.210841	2025-12-04 04:24:01.210841	\N	105	t
183	2025-12-04 04:24:01.226583	2025-12-04 04:24:01.226583	78	\N	t
184	2025-12-04 04:24:01.235874	2025-12-04 04:24:01.235874	\N	106	t
185	2025-12-04 04:24:01.24926	2025-12-04 04:24:01.24926	\N	107	t
186	2025-12-04 04:24:01.268106	2025-12-04 04:24:01.268106	79	\N	t
187	2025-12-04 04:24:01.279128	2025-12-04 04:24:01.279128	\N	108	t
188	2025-12-04 04:24:01.291785	2025-12-04 04:24:01.291785	\N	109	t
189	2025-12-04 04:24:01.308517	2025-12-04 04:24:01.308517	80	\N	t
190	2025-12-04 04:24:01.31959	2025-12-04 04:24:01.31959	\N	110	t
191	2025-12-04 04:24:01.335787	2025-12-04 04:24:01.335787	\N	111	t
192	2025-12-04 04:24:01.351668	2025-12-04 04:24:01.351668	81	\N	t
193	2025-12-04 04:24:01.362059	2025-12-04 04:24:01.362059	\N	112	t
194	2025-12-04 04:24:01.375841	2025-12-04 04:24:01.375841	82	\N	t
195	2025-12-04 04:24:01.388139	2025-12-04 04:24:01.388139	\N	113	t
196	2025-12-04 04:24:01.403645	2025-12-04 04:24:01.403645	\N	114	t
197	2025-12-04 04:24:01.422073	2025-12-04 04:24:01.422073	83	\N	t
198	2025-12-04 04:24:01.432371	2025-12-04 04:24:01.432371	\N	115	t
199	2025-12-04 04:24:01.443929	2025-12-04 04:24:01.443929	\N	116	t
200	2025-12-04 04:24:01.464412	2025-12-04 04:24:01.464412	84	\N	t
201	2025-12-04 04:24:01.475922	2025-12-04 04:24:01.475922	\N	117	t
202	2025-12-04 04:24:01.492905	2025-12-04 04:24:01.492905	85	\N	t
203	2025-12-04 04:24:01.504257	2025-12-04 04:24:01.504257	\N	118	t
204	2025-12-04 04:24:01.520612	2025-12-04 04:24:01.520612	86	\N	t
205	2025-12-04 04:24:01.532645	2025-12-04 04:24:01.532645	\N	119	t
206	2025-12-04 04:24:01.548081	2025-12-04 04:24:01.548081	\N	120	t
207	2025-12-04 04:24:01.571644	2025-12-04 04:24:01.571644	87	\N	t
208	2025-12-04 04:24:01.583434	2025-12-04 04:24:01.583434	\N	121	t
209	2025-12-04 04:24:01.596422	2025-12-04 04:24:01.596422	\N	122	t
210	2025-12-04 04:24:01.612987	2025-12-04 04:24:01.612987	88	\N	t
211	2025-12-04 04:24:01.626608	2025-12-04 04:24:01.626608	\N	123	t
212	2025-12-04 04:24:01.639736	2025-12-04 04:24:01.639736	\N	124	t
213	2025-12-04 04:24:01.656039	2025-12-04 04:24:01.656039	89	\N	t
214	2025-12-04 04:24:01.666105	2025-12-04 04:24:01.666105	\N	125	t
215	2025-12-04 04:24:01.683644	2025-12-04 04:24:01.683644	90	\N	t
216	2025-12-04 04:24:01.692983	2025-12-04 04:24:01.692983	\N	126	t
217	2025-12-04 04:24:01.709868	2025-12-04 04:24:01.709868	91	\N	t
218	2025-12-04 04:24:01.721128	2025-12-04 04:24:01.721128	\N	127	t
219	2025-12-04 04:24:01.737324	2025-12-04 04:24:01.737324	92	\N	t
220	2025-12-04 04:24:01.750114	2025-12-04 04:24:01.750114	\N	128	t
221	2025-12-04 04:24:01.764373	2025-12-04 04:24:01.764373	\N	129	t
222	2025-12-04 04:24:01.780349	2025-12-04 04:24:01.780349	93	\N	t
223	2025-12-04 04:24:01.793003	2025-12-04 04:24:01.793003	\N	130	t
224	2025-12-04 04:24:01.810004	2025-12-04 04:24:01.810004	94	\N	t
225	2025-12-04 04:24:01.821255	2025-12-04 04:24:01.821255	\N	131	t
226	2025-12-04 04:24:01.836543	2025-12-04 04:24:01.836543	95	\N	t
227	2025-12-04 04:24:01.845681	2025-12-04 04:24:01.845681	\N	132	t
228	2025-12-04 04:24:01.860125	2025-12-04 04:24:01.860125	96	\N	t
229	2025-12-04 04:24:01.87113	2025-12-04 04:24:01.87113	\N	133	t
230	2025-12-04 04:24:01.890232	2025-12-04 04:24:01.890232	97	\N	t
231	2025-12-04 04:24:01.900769	2025-12-04 04:24:01.900769	\N	134	t
232	2025-12-04 04:24:01.914812	2025-12-04 04:24:01.914812	\N	135	t
233	2025-12-04 04:24:01.931229	2025-12-04 04:24:01.931229	98	\N	t
234	2025-12-04 04:24:01.942161	2025-12-04 04:24:01.942161	\N	136	t
235	2025-12-04 04:24:01.95625	2025-12-04 04:24:01.95625	\N	137	t
236	2025-12-04 04:24:01.974377	2025-12-04 04:24:01.974377	99	\N	t
237	2025-12-04 04:24:01.98759	2025-12-04 04:24:01.98759	\N	138	t
238	2025-12-04 04:24:02.002327	2025-12-04 04:24:02.002327	\N	139	t
239	2025-12-04 04:24:02.018992	2025-12-04 04:24:02.018992	100	\N	t
240	2025-12-04 04:24:02.027991	2025-12-04 04:24:02.027991	\N	140	t
241	2025-12-04 04:24:02.043339	2025-12-04 04:24:02.043339	101	\N	t
242	2025-12-04 04:24:02.052859	2025-12-04 04:24:02.052859	\N	141	t
243	2025-12-04 04:24:02.068296	2025-12-04 04:24:02.068296	\N	142	t
244	2025-12-04 04:24:02.085302	2025-12-04 04:24:02.085302	102	\N	t
245	2025-12-04 04:24:02.096958	2025-12-04 04:24:02.096958	\N	143	t
246	2025-12-04 04:24:02.111645	2025-12-04 04:24:02.111645	103	\N	t
247	2025-12-04 04:24:02.120868	2025-12-04 04:24:02.120868	\N	144	t
248	2025-12-04 04:24:02.137511	2025-12-04 04:24:02.137511	104	\N	t
249	2025-12-04 04:24:02.145267	2025-12-04 04:24:02.145267	\N	145	t
250	2025-12-04 04:24:02.163249	2025-12-04 04:24:02.163249	105	\N	t
251	2025-12-04 04:24:02.174743	2025-12-04 04:24:02.174743	\N	146	t
252	2025-12-04 04:24:02.189512	2025-12-04 04:24:02.189512	\N	147	t
253	2025-12-04 04:24:02.20628	2025-12-04 04:24:02.20628	106	\N	t
254	2025-12-04 04:24:02.21619	2025-12-04 04:24:02.21619	\N	148	t
255	2025-12-04 04:24:02.231736	2025-12-04 04:24:02.231736	107	\N	t
256	2025-12-04 04:24:02.243572	2025-12-04 04:24:02.243572	\N	149	t
257	2025-12-04 04:24:02.259775	2025-12-04 04:24:02.259775	\N	150	t
258	2025-12-04 04:24:02.274884	2025-12-04 04:24:02.274884	108	\N	t
259	2025-12-04 04:24:02.286194	2025-12-04 04:24:02.286194	\N	151	t
260	2025-12-04 04:24:02.298445	2025-12-04 04:24:02.298445	\N	152	t
261	2025-12-04 04:24:02.31305	2025-12-04 04:24:02.31305	109	\N	t
262	2025-12-04 04:24:02.323862	2025-12-04 04:24:02.323862	\N	153	t
263	2025-12-04 04:24:02.340027	2025-12-04 04:24:02.340027	110	\N	t
264	2025-12-04 04:24:02.347013	2025-12-04 04:24:02.347013	\N	154	t
265	2025-12-04 04:24:02.362337	2025-12-04 04:24:02.362337	\N	155	t
266	2025-12-04 04:24:02.376213	2025-12-04 04:24:02.376213	111	\N	t
267	2025-12-04 04:24:02.386085	2025-12-04 04:24:02.386085	\N	156	t
268	2025-12-04 04:24:02.402216	2025-12-04 04:24:02.402216	\N	157	t
269	2025-12-04 04:24:02.420589	2025-12-04 04:24:02.420589	112	\N	t
270	2025-12-04 04:24:02.430622	2025-12-04 04:24:02.430622	\N	158	t
271	2025-12-04 04:24:02.444884	2025-12-04 04:24:02.444884	\N	159	t
272	2025-12-04 04:24:02.461026	2025-12-04 04:24:02.461026	113	\N	t
273	2025-12-04 04:24:02.468827	2025-12-04 04:24:02.468827	\N	160	t
274	2025-12-04 04:24:02.484921	2025-12-04 04:24:02.484921	\N	161	t
275	2025-12-04 04:24:02.500685	2025-12-04 04:24:02.500685	114	\N	t
276	2025-12-04 04:24:02.51284	2025-12-04 04:24:02.51284	\N	162	t
277	2025-12-04 04:24:02.527778	2025-12-04 04:24:02.527778	\N	163	t
278	2025-12-04 04:24:02.544299	2025-12-04 04:24:02.544299	115	\N	t
279	2025-12-04 04:24:02.556051	2025-12-04 04:24:02.556051	\N	164	t
280	2025-12-04 04:24:02.573179	2025-12-04 04:24:02.573179	116	\N	t
281	2025-12-04 04:24:02.582351	2025-12-04 04:24:02.582351	\N	165	t
282	2025-12-04 04:24:02.593774	2025-12-04 04:24:02.593774	\N	166	t
283	2025-12-04 04:24:02.610816	2025-12-04 04:24:02.610816	117	\N	t
284	2025-12-04 04:24:02.619905	2025-12-04 04:24:02.619905	\N	167	t
285	2025-12-04 04:24:02.635043	2025-12-04 04:24:02.635043	118	\N	t
286	2025-12-04 04:24:02.647961	2025-12-04 04:24:02.647961	\N	168	t
287	2025-12-04 04:24:02.664378	2025-12-04 04:24:02.664378	119	\N	t
288	2025-12-04 04:24:02.676948	2025-12-04 04:24:02.676948	\N	169	t
289	2025-12-04 04:24:02.69228	2025-12-04 04:24:02.69228	\N	170	t
290	2025-12-04 04:24:02.711729	2025-12-04 04:24:02.711729	120	\N	t
291	2025-12-04 04:24:02.724437	2025-12-04 04:24:02.724437	\N	171	t
292	2025-12-04 04:24:02.741655	2025-12-04 04:24:02.741655	121	\N	t
293	2025-12-04 04:24:02.748891	2025-12-04 04:24:02.748891	\N	172	t
294	2025-12-04 04:24:02.765507	2025-12-04 04:24:02.765507	122	\N	t
295	2025-12-04 04:24:02.776892	2025-12-04 04:24:02.776892	\N	173	t
296	2025-12-04 04:24:02.794664	2025-12-04 04:24:02.794664	123	\N	t
297	2025-12-04 04:24:02.80768	2025-12-04 04:24:02.80768	\N	174	t
298	2025-12-04 04:24:02.825063	2025-12-04 04:24:02.825063	124	\N	t
299	2025-12-04 04:24:02.835772	2025-12-04 04:24:02.835772	\N	175	t
300	2025-12-04 04:24:02.84913	2025-12-04 04:24:02.84913	\N	176	t
301	2025-12-04 04:24:02.865442	2025-12-04 04:24:02.865442	125	\N	t
302	2025-12-04 04:24:02.877497	2025-12-04 04:24:02.877497	\N	177	t
303	2025-12-04 04:24:02.894459	2025-12-04 04:24:02.894459	126	\N	t
304	2025-12-04 04:24:02.905442	2025-12-04 04:24:02.905442	\N	178	t
305	2025-12-04 04:24:02.921511	2025-12-04 04:24:02.921511	\N	179	t
306	2025-12-04 04:24:02.936811	2025-12-04 04:24:02.936811	127	\N	t
307	2025-12-04 04:24:02.948662	2025-12-04 04:24:02.948662	\N	180	t
308	2025-12-04 04:24:02.96714	2025-12-04 04:24:02.96714	128	\N	t
309	2025-12-04 04:24:02.987696	2025-12-04 04:24:02.987696	\N	181	t
310	2025-12-04 04:24:03.004892	2025-12-04 04:24:03.004892	129	\N	t
311	2025-12-04 04:24:03.015142	2025-12-04 04:24:03.015142	\N	182	t
312	2025-12-04 04:24:03.030293	2025-12-04 04:24:03.030293	\N	183	t
313	2025-12-04 04:24:03.047567	2025-12-04 04:24:03.047567	130	\N	t
314	2025-12-04 04:24:03.05709	2025-12-04 04:24:03.05709	\N	184	t
315	2025-12-04 04:24:03.072545	2025-12-04 04:24:03.072545	131	\N	t
316	2025-12-04 04:24:03.084089	2025-12-04 04:24:03.084089	\N	185	t
317	2025-12-04 04:24:03.099979	2025-12-04 04:24:03.099979	132	\N	t
318	2025-12-04 04:24:03.107651	2025-12-04 04:24:03.107651	\N	186	t
319	2025-12-04 04:24:03.127732	2025-12-04 04:24:03.127732	133	\N	t
320	2025-12-04 04:24:03.138673	2025-12-04 04:24:03.138673	\N	187	t
321	2025-12-04 04:24:03.151345	2025-12-04 04:24:03.151345	134	\N	t
322	2025-12-04 04:24:03.160462	2025-12-04 04:24:03.160462	\N	188	t
323	2025-12-04 04:24:03.176516	2025-12-04 04:24:03.176516	135	\N	t
324	2025-12-04 04:24:03.187283	2025-12-04 04:24:03.187283	\N	189	t
325	2025-12-04 04:24:03.200748	2025-12-04 04:24:03.200748	136	\N	t
326	2025-12-04 04:24:03.214588	2025-12-04 04:24:03.214588	\N	190	t
327	2025-12-04 04:24:03.232614	2025-12-04 04:24:03.232614	137	\N	t
328	2025-12-04 04:24:03.244566	2025-12-04 04:24:03.244566	\N	191	t
329	2025-12-04 04:24:03.260834	2025-12-04 04:24:03.260834	\N	192	t
330	2025-12-04 04:24:03.27653	2025-12-04 04:24:03.27653	138	\N	t
331	2025-12-04 04:24:03.286613	2025-12-04 04:24:03.286613	\N	193	t
332	2025-12-04 04:24:03.300256	2025-12-04 04:24:03.300256	\N	194	t
333	2025-12-04 04:24:03.317058	2025-12-04 04:24:03.317058	139	\N	t
334	2025-12-04 04:24:03.32859	2025-12-04 04:24:03.32859	\N	195	t
335	2025-12-04 04:24:03.3436	2025-12-04 04:24:03.3436	\N	196	t
336	2025-12-04 04:24:03.360595	2025-12-04 04:24:03.360595	140	\N	t
337	2025-12-04 04:24:03.371312	2025-12-04 04:24:03.371312	\N	197	t
338	2025-12-04 04:24:03.386913	2025-12-04 04:24:03.386913	141	\N	t
339	2025-12-04 04:24:03.399336	2025-12-04 04:24:03.399336	\N	198	t
340	2025-12-04 04:24:03.413919	2025-12-04 04:24:03.413919	\N	199	t
341	2025-12-04 04:24:03.428973	2025-12-04 04:24:03.428973	142	\N	t
342	2025-12-04 04:24:03.441441	2025-12-04 04:24:03.441441	\N	200	t
343	2025-12-04 04:24:03.457508	2025-12-04 04:24:03.457508	143	\N	t
344	2025-12-04 04:24:03.467482	2025-12-04 04:24:03.467482	\N	201	t
345	2025-12-04 04:24:03.481893	2025-12-04 04:24:03.481893	\N	202	t
346	2025-12-04 04:24:03.497177	2025-12-04 04:24:03.497177	144	\N	t
347	2025-12-04 04:24:03.508188	2025-12-04 04:24:03.508188	\N	203	t
348	2025-12-04 04:24:03.524902	2025-12-04 04:24:03.524902	145	\N	t
349	2025-12-04 04:24:03.537315	2025-12-04 04:24:03.537315	\N	204	t
350	2025-12-04 04:24:03.551982	2025-12-04 04:24:03.551982	\N	205	t
351	2025-12-04 04:24:03.568035	2025-12-04 04:24:03.568035	146	\N	t
352	2025-12-04 04:24:03.580783	2025-12-04 04:24:03.580783	\N	206	t
353	2025-12-04 04:24:03.596548	2025-12-04 04:24:03.596548	147	\N	t
354	2025-12-04 04:24:03.607719	2025-12-04 04:24:03.607719	\N	207	t
355	2025-12-04 04:24:03.620538	2025-12-04 04:24:03.620538	\N	208	t
356	2025-12-04 04:24:03.636287	2025-12-04 04:24:03.636287	148	\N	t
357	2025-12-04 04:24:03.646624	2025-12-04 04:24:03.646624	\N	209	t
358	2025-12-04 04:24:03.663277	2025-12-04 04:24:03.663277	149	\N	t
359	2025-12-04 04:24:03.671639	2025-12-04 04:24:03.671639	\N	210	t
360	2025-12-04 04:24:04.020159	2025-12-04 04:24:04.020159	150	\N	t
361	2025-12-04 04:24:04.028172	2025-12-04 04:24:04.028172	\N	211	t
362	2025-12-04 04:24:04.040799	2025-12-04 04:24:04.040799	151	\N	t
363	2025-12-04 04:24:04.050383	2025-12-04 04:24:04.050383	\N	212	t
364	2025-12-04 04:24:04.061409	2025-12-04 04:24:04.061409	152	\N	t
365	2025-12-04 04:24:04.072952	2025-12-04 04:24:04.072952	\N	213	t
366	2025-12-04 04:24:04.097819	2025-12-04 04:24:04.097819	153	\N	t
367	2025-12-04 04:24:04.112817	2025-12-04 04:24:04.112817	\N	214	t
368	2025-12-04 04:24:04.128935	2025-12-04 04:24:04.128935	154	\N	t
369	2025-12-04 04:24:04.142641	2025-12-04 04:24:04.142641	\N	215	t
370	2025-12-04 04:24:04.163435	2025-12-04 04:24:04.163435	155	\N	t
371	2025-12-04 04:24:04.174896	2025-12-04 04:24:04.174896	\N	216	t
372	2025-12-04 04:24:04.186776	2025-12-04 04:24:04.186776	156	\N	t
373	2025-12-04 04:24:04.199229	2025-12-04 04:24:04.199229	\N	217	t
374	2025-12-04 04:24:04.21285	2025-12-04 04:24:04.21285	157	\N	t
375	2025-12-04 04:24:04.223312	2025-12-04 04:24:04.223312	\N	218	t
376	2025-12-04 04:24:04.237321	2025-12-04 04:24:04.237321	158	\N	t
377	2025-12-04 04:24:04.24826	2025-12-04 04:24:04.24826	\N	219	t
378	2025-12-04 04:24:04.261637	2025-12-04 04:24:04.261637	159	\N	t
379	2025-12-04 04:24:04.272656	2025-12-04 04:24:04.272656	\N	220	t
380	2025-12-04 04:24:04.283781	2025-12-04 04:24:04.283781	160	\N	t
381	2025-12-04 04:24:04.295435	2025-12-04 04:24:04.295435	\N	221	t
382	2025-12-04 04:24:04.309449	2025-12-04 04:24:04.309449	161	\N	t
383	2025-12-04 04:24:04.322626	2025-12-04 04:24:04.322626	\N	222	t
384	2025-12-04 04:24:04.335139	2025-12-04 04:24:04.335139	162	\N	t
385	2025-12-04 04:24:04.346882	2025-12-04 04:24:04.346882	\N	223	t
386	2025-12-04 04:24:04.36206	2025-12-04 04:24:04.36206	163	\N	t
387	2025-12-04 04:24:04.372503	2025-12-04 04:24:04.372503	\N	224	t
388	2025-12-04 04:24:04.388076	2025-12-04 04:24:04.388076	164	\N	t
389	2025-12-04 04:24:04.400332	2025-12-04 04:24:04.400332	\N	225	t
390	2025-12-04 04:24:04.412807	2025-12-04 04:24:04.412807	165	\N	t
391	2025-12-04 04:24:04.42277	2025-12-04 04:24:04.42277	\N	226	t
392	2025-12-04 04:24:04.439029	2025-12-04 04:24:04.439029	166	\N	t
393	2025-12-04 04:24:04.449956	2025-12-04 04:24:04.449956	\N	227	t
394	2025-12-04 04:24:04.463727	2025-12-04 04:24:04.463727	167	\N	t
395	2025-12-04 04:24:04.472324	2025-12-04 04:24:04.472324	\N	228	t
396	2025-12-04 04:24:04.4883	2025-12-04 04:24:04.4883	168	\N	t
397	2025-12-04 04:24:04.49912	2025-12-04 04:24:04.49912	\N	229	t
398	2025-12-04 04:24:04.514352	2025-12-04 04:24:04.514352	169	\N	t
399	2025-12-04 04:24:04.528119	2025-12-04 04:24:04.528119	\N	230	t
400	2025-12-04 04:24:04.540656	2025-12-04 04:24:04.540656	170	\N	t
401	2025-12-04 04:24:04.550735	2025-12-04 04:24:04.550735	\N	231	t
402	2025-12-04 04:24:04.563217	2025-12-04 04:24:04.563217	171	\N	t
403	2025-12-04 04:24:04.574162	2025-12-04 04:24:04.574162	\N	232	t
404	2025-12-04 04:24:04.588535	2025-12-04 04:24:04.588535	172	\N	t
405	2025-12-04 04:24:04.599297	2025-12-04 04:24:04.599297	\N	233	t
406	2025-12-04 04:24:04.614201	2025-12-04 04:24:04.614201	173	\N	t
407	2025-12-04 04:24:04.624087	2025-12-04 04:24:04.624087	\N	234	t
408	2025-12-04 04:24:04.638522	2025-12-04 04:24:04.638522	174	\N	t
409	2025-12-04 04:24:04.650326	2025-12-04 04:24:04.650326	\N	235	t
410	2025-12-04 04:24:04.664413	2025-12-04 04:24:04.664413	175	\N	t
411	2025-12-04 04:24:04.672004	2025-12-04 04:24:04.672004	\N	236	t
412	2025-12-04 04:24:04.684846	2025-12-04 04:24:04.684846	176	\N	t
413	2025-12-04 04:24:04.695635	2025-12-04 04:24:04.695635	\N	237	t
414	2025-12-04 04:24:04.711527	2025-12-04 04:24:04.711527	177	\N	t
415	2025-12-04 04:24:04.721389	2025-12-04 04:24:04.721389	\N	238	t
416	2025-12-04 04:24:04.736497	2025-12-04 04:24:04.736497	178	\N	t
417	2025-12-04 04:24:04.745998	2025-12-04 04:24:04.745998	\N	239	t
418	2025-12-04 04:24:04.758352	2025-12-04 04:24:04.758352	179	\N	t
419	2025-12-04 04:24:04.768931	2025-12-04 04:24:04.768931	\N	240	t
420	2025-12-04 04:24:04.782082	2025-12-04 04:24:04.782082	180	\N	t
421	2025-12-04 04:24:04.791941	2025-12-04 04:24:04.791941	\N	241	t
422	2025-12-04 04:24:04.804966	2025-12-04 04:24:04.804966	181	\N	t
423	2025-12-04 04:24:04.815522	2025-12-04 04:24:04.815522	\N	242	t
424	2025-12-04 04:24:04.829881	2025-12-04 04:24:04.829881	182	\N	t
425	2025-12-04 04:24:04.840782	2025-12-04 04:24:04.840782	\N	243	t
426	2025-12-04 04:24:04.853444	2025-12-04 04:24:04.853444	183	\N	t
427	2025-12-04 04:24:04.865545	2025-12-04 04:24:04.865545	\N	244	t
428	2025-12-04 04:24:04.879501	2025-12-04 04:24:04.879501	184	\N	t
429	2025-12-04 04:24:04.891728	2025-12-04 04:24:04.891728	\N	245	t
430	2025-12-04 04:24:04.904406	2025-12-04 04:24:04.904406	185	\N	t
431	2025-12-04 04:24:04.914529	2025-12-04 04:24:04.914529	\N	246	t
432	2025-12-04 04:24:04.928735	2025-12-04 04:24:04.928735	186	\N	t
433	2025-12-04 04:24:04.939492	2025-12-04 04:24:04.939492	\N	247	t
434	2025-12-04 04:24:04.954692	2025-12-04 04:24:04.954692	187	\N	t
435	2025-12-04 04:24:04.965261	2025-12-04 04:24:04.965261	\N	248	t
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version) FROM stdin;
20250226165117
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
20230427235835
20230428011849
20230428215550
20230530212320
20230530212331
20230531183601
20230609201040
20230718212101
20230907215706
20231130010537
20231130013439
20231130030827
20231201213722
20240404025212
20240404032142
20240501005404
20240606002826
20240610165140
20240702155441
20240804222349
20240819053931
20241003020742
20241017030157
20250130044205
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.services (id, created_at, updated_at, name, long_description, eligibility, required_documents, fee, application_process, resource_id, verified_at, email, status, certified, program_id, interpretation_services, url, wait_time, contact_id, funding_id, alternate_name, certified_at, featured, source_attribution, internal_note, short_description, boosted_category_id) FROM stdin;
1	2025-12-04 04:23:58.738434	2025-12-04 04:23:58.738434	Mertz LLC	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	\N	\N	\N	\N	1	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
2	2025-12-04 04:23:58.787171	2025-12-04 04:23:58.787171	Legros, Boehm and Nolan	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	\N	\N	\N	\N	2	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
3	2025-12-04 04:23:58.804205	2025-12-04 04:23:58.804205	Little Inc	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	2	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
4	2025-12-04 04:23:58.830811	2025-12-04 04:23:58.830811	Goodwin-Lueilwitz	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	\N	\N	\N	\N	3	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
5	2025-12-04 04:23:58.84374	2025-12-04 04:23:58.84374	Crooks LLC	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	\N	\N	\N	\N	3	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
6	2025-12-04 04:23:58.86683	2025-12-04 04:23:58.86683	Bauch, Armstrong and Rutherford	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	4	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
7	2025-12-04 04:23:58.892693	2025-12-04 04:23:58.892693	McCullough, Bergnaum and McDermott	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	\N	\N	\N	\N	5	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
8	2025-12-04 04:23:58.916885	2025-12-04 04:23:58.916885	Labadie Inc	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	\N	\N	\N	\N	6	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
9	2025-12-04 04:23:58.945306	2025-12-04 04:23:58.945306	Lang LLC	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	\N	\N	\N	\N	7	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
10	2025-12-04 04:23:58.971583	2025-12-04 04:23:58.971583	Crona Inc	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	8	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
11	2025-12-04 04:23:58.998169	2025-12-04 04:23:58.998169	Auer LLC	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	\N	\N	\N	\N	9	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
12	2025-12-04 04:23:59.021635	2025-12-04 04:23:59.021635	Johns-Rodriguez	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	\N	\N	\N	\N	10	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
13	2025-12-04 04:23:59.048242	2025-12-04 04:23:59.048242	Murray Group	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	\N	\N	\N	\N	11	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
14	2025-12-04 04:23:59.060189	2025-12-04 04:23:59.060189	Langworth LLC	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	\N	\N	\N	\N	11	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
15	2025-12-04 04:23:59.083621	2025-12-04 04:23:59.083621	Champlin-Bahringer	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	\N	\N	\N	\N	12	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
16	2025-12-04 04:23:59.106316	2025-12-04 04:23:59.106316	Nienow, Okuneva and Will	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	\N	\N	\N	\N	13	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
17	2025-12-04 04:23:59.119712	2025-12-04 04:23:59.119712	Friesen, Dooley and Collier	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	\N	\N	\N	\N	13	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
18	2025-12-04 04:23:59.14198	2025-12-04 04:23:59.14198	Miller, Kuphal and Thiel	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	14	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
19	2025-12-04 04:23:59.168607	2025-12-04 04:23:59.168607	Reynolds, Volkman and Kris	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	15	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
20	2025-12-04 04:23:59.192527	2025-12-04 04:23:59.192527	Toy and Sons	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	16	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
21	2025-12-04 04:23:59.218347	2025-12-04 04:23:59.218347	Kautzer, Towne and Kertzmann	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	17	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
22	2025-12-04 04:23:59.247609	2025-12-04 04:23:59.247609	Heathcote Inc	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	\N	\N	\N	\N	18	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
23	2025-12-04 04:23:59.262675	2025-12-04 04:23:59.262675	Schuster, Rohan and Schamberger	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	\N	\N	\N	\N	18	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
24	2025-12-04 04:23:59.287397	2025-12-04 04:23:59.287397	Boyer Group	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	\N	\N	\N	\N	19	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
25	2025-12-04 04:23:59.301169	2025-12-04 04:23:59.301169	Stokes, Bailey and Deckow	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	\N	\N	\N	\N	19	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
26	2025-12-04 04:23:59.33107	2025-12-04 04:23:59.33107	Reinger Inc	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	20	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
27	2025-12-04 04:23:59.344616	2025-12-04 04:23:59.344616	Nicolas Inc	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	20	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
28	2025-12-04 04:23:59.373584	2025-12-04 04:23:59.373584	Christiansen-Lind	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	\N	\N	\N	\N	21	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
29	2025-12-04 04:23:59.38736	2025-12-04 04:23:59.38736	Jenkins, Lindgren and Howell	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	21	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
30	2025-12-04 04:23:59.413215	2025-12-04 04:23:59.413215	Herman-Sawayn	Serves lunch Monday and Wednesday. Dinner available all days.\n	\N	\N	\N	\N	22	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
31	2025-12-04 04:23:59.443545	2025-12-04 04:23:59.443545	Morissette Group	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	\N	\N	\N	\N	23	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
32	2025-12-04 04:23:59.470179	2025-12-04 04:23:59.470179	Balistreri and Sons	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	\N	\N	\N	\N	24	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
33	2025-12-04 04:23:59.501894	2025-12-04 04:23:59.501894	Auer, Barrows and Terry	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	25	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
34	2025-12-04 04:23:59.530322	2025-12-04 04:23:59.530322	Blick-Abshire	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	\N	\N	\N	\N	26	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
35	2025-12-04 04:23:59.556475	2025-12-04 04:23:59.556475	Renner-Reinger	Serves lunch Monday and Wednesday. Dinner available all days.\n	\N	\N	\N	\N	27	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
36	2025-12-04 04:23:59.582975	2025-12-04 04:23:59.582975	Greenfelder-Kessler	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	\N	\N	\N	\N	28	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
37	2025-12-04 04:23:59.596204	2025-12-04 04:23:59.596204	Rohan-Will	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	\N	\N	\N	\N	28	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
38	2025-12-04 04:23:59.622552	2025-12-04 04:23:59.622552	Lowe-Mraz	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	29	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
39	2025-12-04 04:23:59.638917	2025-12-04 04:23:59.638917	Smitham-Stiedemann	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	\N	\N	\N	\N	29	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
40	2025-12-04 04:23:59.664043	2025-12-04 04:23:59.664043	Powlowski, Gleason and Wehner	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	\N	\N	\N	\N	30	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
41	2025-12-04 04:23:59.690951	2025-12-04 04:23:59.690951	Trantow, Gusikowski and Cummerata	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	\N	\N	\N	\N	31	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
42	2025-12-04 04:23:59.706396	2025-12-04 04:23:59.706396	Ward, Hettinger and Kling	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	\N	\N	\N	\N	31	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
43	2025-12-04 04:23:59.730545	2025-12-04 04:23:59.730545	Rath-Farrell	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	\N	\N	\N	\N	32	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
44	2025-12-04 04:23:59.74357	2025-12-04 04:23:59.74357	Hilpert-Morissette	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	\N	\N	\N	\N	32	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
45	2025-12-04 04:23:59.768127	2025-12-04 04:23:59.768127	Bradtke Inc	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	\N	\N	\N	\N	33	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
46	2025-12-04 04:23:59.782609	2025-12-04 04:23:59.782609	Kilback LLC	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	33	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
47	2025-12-04 04:23:59.806572	2025-12-04 04:23:59.806572	Spencer-Schmitt	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	\N	\N	\N	\N	34	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
48	2025-12-04 04:23:59.83466	2025-12-04 04:23:59.83466	Wuckert, Toy and Wisozk	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	35	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
49	2025-12-04 04:23:59.862668	2025-12-04 04:23:59.862668	Ziemann, Crooks and Schulist	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	\N	\N	\N	\N	36	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
50	2025-12-04 04:23:59.890642	2025-12-04 04:23:59.890642	Bruen, Metz and White	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	37	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
51	2025-12-04 04:23:59.919433	2025-12-04 04:23:59.919433	Lesch LLC	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	38	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
52	2025-12-04 04:23:59.949437	2025-12-04 04:23:59.949437	Jacobson-Rau	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	39	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
104	2025-12-04 04:24:01.179092	2025-12-04 04:24:01.179092	Carroll LLC	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	\N	\N	\N	\N	76	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
53	2025-12-04 04:23:59.962345	2025-12-04 04:23:59.962345	Wisoky LLC	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	\N	\N	\N	\N	39	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
54	2025-12-04 04:23:59.999877	2025-12-04 04:23:59.999877	Schaefer LLC	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	\N	\N	\N	\N	40	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
55	2025-12-04 04:24:00.027043	2025-12-04 04:24:00.027043	Corkery-Marks	Serves lunch Monday and Wednesday. Dinner available all days.\n	\N	\N	\N	\N	41	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
56	2025-12-04 04:24:00.053765	2025-12-04 04:24:00.053765	Treutel, McLaughlin and Boyle	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	\N	\N	\N	\N	42	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
57	2025-12-04 04:24:00.082569	2025-12-04 04:24:00.082569	Labadie, Harber and Stanton	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	\N	\N	\N	\N	43	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
58	2025-12-04 04:24:00.095954	2025-12-04 04:24:00.095954	Murray, Conn and Mills	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	43	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
59	2025-12-04 04:24:00.122907	2025-12-04 04:24:00.122907	Howe, Fay and Ferry	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	\N	\N	\N	\N	44	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
60	2025-12-04 04:24:00.151105	2025-12-04 04:24:00.151105	Schiller and Sons	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	\N	\N	\N	\N	45	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
61	2025-12-04 04:24:00.162112	2025-12-04 04:24:00.162112	Parisian and Sons	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	\N	\N	\N	\N	45	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
62	2025-12-04 04:24:00.188914	2025-12-04 04:24:00.188914	Langosh-Bednar	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	\N	\N	\N	\N	46	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
63	2025-12-04 04:24:00.219527	2025-12-04 04:24:00.219527	Lebsack LLC	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	\N	\N	\N	\N	47	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
64	2025-12-04 04:24:00.248161	2025-12-04 04:24:00.248161	Ernser, Botsford and Johnson	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	48	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
65	2025-12-04 04:24:00.272228	2025-12-04 04:24:00.272228	O'Kon Inc	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	49	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
66	2025-12-04 04:24:00.287556	2025-12-04 04:24:00.287556	West LLC	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	\N	\N	\N	\N	49	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
67	2025-12-04 04:24:00.313201	2025-12-04 04:24:00.313201	Torp-Homenick	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	50	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
68	2025-12-04 04:24:00.339532	2025-12-04 04:24:00.339532	Kohler Group	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	51	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
69	2025-12-04 04:24:00.353311	2025-12-04 04:24:00.353311	McClure, Ledner and Lindgren	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	51	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
70	2025-12-04 04:24:00.379523	2025-12-04 04:24:00.379523	Wolf-Quitzon	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	52	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
71	2025-12-04 04:24:00.393869	2025-12-04 04:24:00.393869	Ward, Mueller and Schiller	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	52	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
72	2025-12-04 04:24:00.419632	2025-12-04 04:24:00.419632	Wolff Inc	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	\N	\N	\N	\N	53	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
73	2025-12-04 04:24:00.432618	2025-12-04 04:24:00.432618	Anderson-Kuhic	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	\N	\N	\N	\N	53	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
74	2025-12-04 04:24:00.458289	2025-12-04 04:24:00.458289	Runolfsdottir Inc	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	54	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
75	2025-12-04 04:24:00.48858	2025-12-04 04:24:00.48858	Gutmann, Kutch and Wisoky	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	\N	\N	\N	\N	55	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
76	2025-12-04 04:24:00.516814	2025-12-04 04:24:00.516814	Hahn and Sons	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	\N	\N	\N	\N	56	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
77	2025-12-04 04:24:00.54364	2025-12-04 04:24:00.54364	Grant, Fisher and Berge	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	\N	\N	\N	\N	57	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
78	2025-12-04 04:24:00.558313	2025-12-04 04:24:00.558313	Pacocha-Bashirian	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	57	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
79	2025-12-04 04:24:00.583853	2025-12-04 04:24:00.583853	Doyle and Sons	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	58	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
80	2025-12-04 04:24:00.615303	2025-12-04 04:24:00.615303	Batz, Hagenes and Labadie	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	\N	\N	\N	\N	59	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
81	2025-12-04 04:24:00.644593	2025-12-04 04:24:00.644593	Graham Inc	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	\N	\N	\N	\N	60	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
82	2025-12-04 04:24:00.672125	2025-12-04 04:24:00.672125	Adams Inc	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	\N	\N	\N	\N	61	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
83	2025-12-04 04:24:00.687834	2025-12-04 04:24:00.687834	Mertz-Jast	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	\N	\N	\N	\N	61	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
84	2025-12-04 04:24:00.714312	2025-12-04 04:24:00.714312	Langosh LLC	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	\N	\N	\N	\N	62	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
85	2025-12-04 04:24:00.741679	2025-12-04 04:24:00.741679	Mayer, Ratke and Schumm	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	63	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
86	2025-12-04 04:24:00.76912	2025-12-04 04:24:00.76912	Kreiger Group	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	\N	\N	\N	\N	64	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
87	2025-12-04 04:24:00.799479	2025-12-04 04:24:00.799479	Gleason-Mills	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	\N	\N	\N	\N	65	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
88	2025-12-04 04:24:00.816669	2025-12-04 04:24:00.816669	Mertz and Sons	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	\N	\N	\N	\N	65	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
89	2025-12-04 04:24:00.841242	2025-12-04 04:24:00.841242	Greenfelder Group	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	\N	\N	\N	\N	66	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
90	2025-12-04 04:24:00.873562	2025-12-04 04:24:00.873562	Ankunding Group	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	67	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
91	2025-12-04 04:24:00.889137	2025-12-04 04:24:00.889137	Kuvalis LLC	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	\N	\N	\N	\N	67	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
92	2025-12-04 04:24:00.914273	2025-12-04 04:24:00.914273	Hahn Group	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	68	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
93	2025-12-04 04:24:00.941953	2025-12-04 04:24:00.941953	Macejkovic, Cartwright and Toy	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	\N	\N	\N	\N	69	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
94	2025-12-04 04:24:00.96624	2025-12-04 04:24:00.96624	Mueller-Smitham	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	\N	\N	\N	\N	70	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
95	2025-12-04 04:24:00.991418	2025-12-04 04:24:00.991418	Quitzon-Zemlak	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	71	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
96	2025-12-04 04:24:01.005834	2025-12-04 04:24:01.005834	Graham, Grimes and Toy	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	\N	\N	\N	\N	71	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
97	2025-12-04 04:24:01.03508	2025-12-04 04:24:01.03508	Nikolaus, Heidenreich and Gulgowski	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	72	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
98	2025-12-04 04:24:01.059917	2025-12-04 04:24:01.059917	Marks, Okuneva and Wolf	Meals, groceries and nutrition education for people living with serious illnesses, including cancer, diabetes, heart disease, HIV/AIDS.\n	\N	\N	\N	\N	73	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
99	2025-12-04 04:24:01.072316	2025-12-04 04:24:01.072316	Krajcik, Kerluke and O'Connell	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	\N	\N	\N	\N	73	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
100	2025-12-04 04:24:01.098987	2025-12-04 04:24:01.098987	Lueilwitz, Erdman and Hudson	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	74	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
101	2025-12-04 04:24:01.112332	2025-12-04 04:24:01.112332	Bogisich, Reinger and Shanahan	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	74	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
102	2025-12-04 04:24:01.137048	2025-12-04 04:24:01.137048	White Inc	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	75	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
103	2025-12-04 04:24:01.166079	2025-12-04 04:24:01.166079	Bartoletti-Macejkovic	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	\N	\N	\N	\N	76	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
105	2025-12-04 04:24:01.208354	2025-12-04 04:24:01.208354	Nolan Group	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	77	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
106	2025-12-04 04:24:01.232965	2025-12-04 04:24:01.232965	Watsica-Barrows	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	78	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
107	2025-12-04 04:24:01.246507	2025-12-04 04:24:01.246507	Marks and Sons	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	78	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
108	2025-12-04 04:24:01.276591	2025-12-04 04:24:01.276591	Oberbrunner-Barton	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	\N	\N	\N	\N	79	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
109	2025-12-04 04:24:01.289077	2025-12-04 04:24:01.289077	Medhurst-Bosco	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	\N	\N	\N	\N	79	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
110	2025-12-04 04:24:01.316875	2025-12-04 04:24:01.316875	Kilback Group	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	\N	\N	\N	\N	80	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
111	2025-12-04 04:24:01.333	2025-12-04 04:24:01.333	Parker-Schmidt	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	\N	\N	\N	\N	80	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
112	2025-12-04 04:24:01.359595	2025-12-04 04:24:01.359595	Rohan Inc	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	\N	\N	\N	\N	81	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
113	2025-12-04 04:24:01.385725	2025-12-04 04:24:01.385725	Rempel, Walter and Haley	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	82	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
114	2025-12-04 04:24:01.401215	2025-12-04 04:24:01.401215	Bashirian LLC	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	\N	\N	\N	\N	82	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
115	2025-12-04 04:24:01.430184	2025-12-04 04:24:01.430184	Botsford-Hessel	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	83	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
116	2025-12-04 04:24:01.441772	2025-12-04 04:24:01.441772	Smith, Beer and Abbott	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	\N	\N	\N	\N	83	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
117	2025-12-04 04:24:01.473515	2025-12-04 04:24:01.473515	Rosenbaum, Stehr and Leffler	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	84	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
118	2025-12-04 04:24:01.501535	2025-12-04 04:24:01.501535	Hermiston Group	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	\N	\N	\N	\N	85	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
119	2025-12-04 04:24:01.529749	2025-12-04 04:24:01.529749	Mante-Thiel	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	86	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
120	2025-12-04 04:24:01.545307	2025-12-04 04:24:01.545307	Buckridge, Dicki and Harvey	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	\N	\N	\N	\N	86	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
121	2025-12-04 04:24:01.580863	2025-12-04 04:24:01.580863	Christiansen, Becker and Kuphal	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	87	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
122	2025-12-04 04:24:01.593817	2025-12-04 04:24:01.593817	Durgan, Walsh and Leannon	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	87	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
123	2025-12-04 04:24:01.624038	2025-12-04 04:24:01.624038	Hodkiewicz-Kessler	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	\N	\N	\N	\N	88	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
124	2025-12-04 04:24:01.637215	2025-12-04 04:24:01.637215	Price-Macejkovic	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	88	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
125	2025-12-04 04:24:01.663956	2025-12-04 04:24:01.663956	Moore, Schoen and McKenzie	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	89	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
126	2025-12-04 04:24:01.690939	2025-12-04 04:24:01.690939	Kihn-Prosacco	Serves lunch Monday and Wednesday. Dinner available all days.\n	\N	\N	\N	\N	90	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
127	2025-12-04 04:24:01.718453	2025-12-04 04:24:01.718453	Schaden LLC	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	\N	\N	\N	\N	91	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
128	2025-12-04 04:24:01.747408	2025-12-04 04:24:01.747408	Rippin and Sons	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	\N	\N	\N	\N	92	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
129	2025-12-04 04:24:01.761437	2025-12-04 04:24:01.761437	Osinski Inc	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	\N	\N	\N	\N	92	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
130	2025-12-04 04:24:01.790062	2025-12-04 04:24:01.790062	Veum-Heidenreich	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	\N	\N	\N	\N	93	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
131	2025-12-04 04:24:01.818465	2025-12-04 04:24:01.818465	Rau and Sons	A place to shower on Tuesday through Saturday.\n	\N	\N	\N	\N	94	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
132	2025-12-04 04:24:01.843624	2025-12-04 04:24:01.843624	Abshire-Keebler	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	\N	\N	\N	\N	95	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
133	2025-12-04 04:24:01.868981	2025-12-04 04:24:01.868981	Baumbach-Pfannerstill	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	\N	\N	\N	\N	96	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
134	2025-12-04 04:24:01.898016	2025-12-04 04:24:01.898016	Lang, Wintheiser and Gusikowski	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	\N	\N	\N	\N	97	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
135	2025-12-04 04:24:01.912089	2025-12-04 04:24:01.912089	Rau, Doyle and Runolfsson	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	\N	\N	\N	\N	97	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
136	2025-12-04 04:24:01.940047	2025-12-04 04:24:01.940047	Flatley, Kuphal and Jakubowski	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	98	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
137	2025-12-04 04:24:01.954064	2025-12-04 04:24:01.954064	Macejkovic-Pacocha	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	\N	\N	\N	\N	98	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
138	2025-12-04 04:24:01.984772	2025-12-04 04:24:01.984772	Rodriguez, Bode and Dicki	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	99	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
139	2025-12-04 04:24:01.999826	2025-12-04 04:24:01.999826	Marvin-Murray	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	99	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
140	2025-12-04 04:24:02.02524	2025-12-04 04:24:02.02524	Turcotte-Kassulke	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	\N	\N	\N	\N	100	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
141	2025-12-04 04:24:02.050031	2025-12-04 04:24:02.050031	VonRueden LLC	Serves lunch Monday and Wednesday. Dinner available all days.\n	\N	\N	\N	\N	101	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
142	2025-12-04 04:24:02.065752	2025-12-04 04:24:02.065752	Metz-Daniel	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	101	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
143	2025-12-04 04:24:02.094409	2025-12-04 04:24:02.094409	Stiedemann-Lowe	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	\N	\N	\N	\N	102	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
144	2025-12-04 04:24:02.118829	2025-12-04 04:24:02.118829	Haley LLC	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	\N	\N	\N	\N	103	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
145	2025-12-04 04:24:02.142851	2025-12-04 04:24:02.142851	Kilback, Rosenbaum and Dickinson	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	\N	\N	\N	\N	104	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
146	2025-12-04 04:24:02.172204	2025-12-04 04:24:02.172204	Bahringer-Wolff	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	\N	\N	\N	\N	105	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
147	2025-12-04 04:24:02.186971	2025-12-04 04:24:02.186971	Ledner, Tromp and Davis	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	\N	\N	\N	\N	105	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
148	2025-12-04 04:24:02.214075	2025-12-04 04:24:02.214075	Will-Watsica	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	106	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
149	2025-12-04 04:24:02.240823	2025-12-04 04:24:02.240823	Yundt and Sons	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	\N	\N	\N	\N	107	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
150	2025-12-04 04:24:02.256813	2025-12-04 04:24:02.256813	Leannon Inc	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	107	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
151	2025-12-04 04:24:02.283606	2025-12-04 04:24:02.283606	Baumbach-Tremblay	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	\N	\N	\N	\N	108	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
152	2025-12-04 04:24:02.295987	2025-12-04 04:24:02.295987	Ullrich, Conroy and Hagenes	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	\N	\N	\N	\N	108	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
153	2025-12-04 04:24:02.321601	2025-12-04 04:24:02.321601	Heller LLC	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	\N	\N	\N	\N	109	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
154	2025-12-04 04:24:02.344916	2025-12-04 04:24:02.344916	Wunsch, Harris and Crist	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	110	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
155	2025-12-04 04:24:02.360219	2025-12-04 04:24:02.360219	Kassulke, Sauer and Stiedemann	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	\N	\N	\N	\N	110	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
156	2025-12-04 04:24:02.384022	2025-12-04 04:24:02.384022	Dach and Sons	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	111	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
157	2025-12-04 04:24:02.400045	2025-12-04 04:24:02.400045	Hartmann, Gottlieb and Kuhic	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	\N	\N	\N	\N	111	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
158	2025-12-04 04:24:02.428025	2025-12-04 04:24:02.428025	Schimmel-Harris	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	\N	\N	\N	\N	112	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
159	2025-12-04 04:24:02.442268	2025-12-04 04:24:02.442268	Ritchie Inc	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	\N	\N	\N	\N	112	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
160	2025-12-04 04:24:02.46677	2025-12-04 04:24:02.46677	Ondricka Inc	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	\N	\N	\N	\N	113	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
161	2025-12-04 04:24:02.48267	2025-12-04 04:24:02.48267	Breitenberg, Kuhlman and Roberts	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	113	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
162	2025-12-04 04:24:02.510436	2025-12-04 04:24:02.510436	Hansen, Farrell and Hodkiewicz	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	114	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
163	2025-12-04 04:24:02.525336	2025-12-04 04:24:02.525336	Murphy and Sons	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	114	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
164	2025-12-04 04:24:02.553306	2025-12-04 04:24:02.553306	Gorczany-Monahan	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	\N	\N	\N	\N	115	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
165	2025-12-04 04:24:02.580277	2025-12-04 04:24:02.580277	Simonis-Vandervort	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	116	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
166	2025-12-04 04:24:02.591581	2025-12-04 04:24:02.591581	Sporer-Brakus	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	\N	\N	\N	\N	116	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
167	2025-12-04 04:24:02.61749	2025-12-04 04:24:02.61749	Parker LLC	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	117	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
168	2025-12-04 04:24:02.643682	2025-12-04 04:24:02.643682	Dibbert and Sons	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	\N	\N	\N	\N	118	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
169	2025-12-04 04:24:02.674472	2025-12-04 04:24:02.674472	Cummerata-O'Kon	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	\N	\N	\N	\N	119	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
170	2025-12-04 04:24:02.689592	2025-12-04 04:24:02.689592	Treutel, Swift and Muller	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	\N	\N	\N	\N	119	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
171	2025-12-04 04:24:02.721676	2025-12-04 04:24:02.721676	Homenick Group	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	120	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
172	2025-12-04 04:24:02.746643	2025-12-04 04:24:02.746643	Harris LLC	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	\N	\N	\N	\N	121	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
173	2025-12-04 04:24:02.774147	2025-12-04 04:24:02.774147	Mayert-Rice	Call for an appt. M-F 8am-4:30pm for psychiatric services, medical triage, support groups, informational classes, medical and HIV primary care, podiatry, substance abuse treatment & housing referrals. Drop-in for primary care M-F 8am. Drop-in social work clinic M-F 8am-12pm. Sobriety Support group MWF 9:30am. Harm Reduction Group Tu 9:30-10am. AA meetings Th 6:30-7:30pm. Call for schedule of free shuttle to Ft. Miley.\n	\N	\N	\N	\N	122	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
174	2025-12-04 04:24:02.804939	2025-12-04 04:24:02.804939	Zemlak, Thiel and Herman	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	123	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
175	2025-12-04 04:24:02.83334	2025-12-04 04:24:02.83334	Bartell, Schoen and Pollich	Serves lunch Monday and Wednesday. Dinner available all days.\n	\N	\N	\N	\N	124	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
176	2025-12-04 04:24:02.846654	2025-12-04 04:24:02.846654	Kihn Group	Serves lunch Monday and Wednesday. Dinner available all days.\n	\N	\N	\N	\N	124	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
177	2025-12-04 04:24:02.874745	2025-12-04 04:24:02.874745	Stroman LLC	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	125	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
178	2025-12-04 04:24:02.902794	2025-12-04 04:24:02.902794	Anderson Group	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	\N	\N	\N	\N	126	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
179	2025-12-04 04:24:02.918672	2025-12-04 04:24:02.918672	Runolfsson Group	Computer lab and resources to help with job search. Free Job Search Assistance, Computer and Job Search Skills Workshops, Employer Spotlights, and Job Search Strategy Groups. Use of computer lab to improve your typing speed and computer skills with self-paced tutorials. Resume and cover letter assistance. Assistance studying for GED, NCLEX-PN, and NCLEX-RN.\n	\N	\N	\N	\N	126	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
180	2025-12-04 04:24:02.946147	2025-12-04 04:24:02.946147	Mayert-Kirlin	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	\N	\N	\N	\N	127	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
181	2025-12-04 04:24:02.983849	2025-12-04 04:24:02.983849	Kutch, Gislason and Cassin	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	\N	\N	\N	\N	128	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
182	2025-12-04 04:24:03.012643	2025-12-04 04:24:03.012643	Batz, Quitzon and Friesen	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	\N	\N	\N	\N	129	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
183	2025-12-04 04:24:03.027808	2025-12-04 04:24:03.027808	Trantow Inc	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	129	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
184	2025-12-04 04:24:03.05445	2025-12-04 04:24:03.05445	Jacobi Inc	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	\N	\N	\N	\N	130	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
185	2025-12-04 04:24:03.081613	2025-12-04 04:24:03.081613	Greenholt Group	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	\N	\N	\N	\N	131	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
186	2025-12-04 04:24:03.105136	2025-12-04 04:24:03.105136	Bernier and Sons	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	\N	\N	\N	\N	132	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
187	2025-12-04 04:24:03.136189	2025-12-04 04:24:03.136189	O'Conner Group	Serves lunch Monday and Wednesday. Dinner available all days.\n	\N	\N	\N	\N	133	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
188	2025-12-04 04:24:03.157685	2025-12-04 04:24:03.157685	Stehr, Zieme and Hirthe	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	\N	\N	\N	\N	134	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
189	2025-12-04 04:24:03.184774	2025-12-04 04:24:03.184774	Bode LLC	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	\N	\N	\N	\N	135	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
190	2025-12-04 04:24:03.211951	2025-12-04 04:24:03.211951	Satterfield-Bashirian	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	\N	\N	\N	\N	136	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
191	2025-12-04 04:24:03.242087	2025-12-04 04:24:03.242087	Wunsch Group	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	\N	\N	\N	\N	137	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
192	2025-12-04 04:24:03.258337	2025-12-04 04:24:03.258337	Robel, Senger and Hermiston	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	\N	\N	\N	\N	137	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
193	2025-12-04 04:24:03.28414	2025-12-04 04:24:03.28414	Lebsack LLC	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	\N	\N	\N	\N	138	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
194	2025-12-04 04:24:03.297722	2025-12-04 04:24:03.297722	Davis-Pacocha	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	138	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
195	2025-12-04 04:24:03.32612	2025-12-04 04:24:03.32612	Terry-Lynch	Case management, social services, individual counseling, employment, legal assistance, substance abuse support, information & referrals, emergency & transitional housing, move-in assistance, eviction prevention, benefits advocacy (SS, VA, military discharge upgrade), mail and message services.\n	\N	\N	\N	\N	139	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
196	2025-12-04 04:24:03.341121	2025-12-04 04:24:03.341121	Rempel, Ward and Carter	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	\N	\N	\N	\N	139	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
197	2025-12-04 04:24:03.368936	2025-12-04 04:24:03.368936	Roberts-Bernhard	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	\N	\N	\N	\N	140	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
198	2025-12-04 04:24:03.396948	2025-12-04 04:24:03.396948	Metz and Sons	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	\N	\N	\N	\N	141	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
199	2025-12-04 04:24:03.411452	2025-12-04 04:24:03.411452	Ruecker, Shanahan and Nader	Serves three free, nutritious meals a day, 364 days a year (New Years Day Closed; on many holidays a bag meal is given out after breakfast & there is no lunch or dinner serving).\n	\N	\N	\N	\N	141	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
200	2025-12-04 04:24:03.439035	2025-12-04 04:24:03.439035	Schimmel LLC	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	\N	\N	\N	\N	142	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
201	2025-12-04 04:24:03.465036	2025-12-04 04:24:03.465036	Pollich Group	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	\N	\N	\N	\N	143	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
202	2025-12-04 04:24:03.479142	2025-12-04 04:24:03.479142	Walsh Inc	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	143	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
203	2025-12-04 04:24:03.505769	2025-12-04 04:24:03.505769	Jaskolski, Luettgen and Rosenbaum	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	144	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
204	2025-12-04 04:24:03.534814	2025-12-04 04:24:03.534814	Graham, Kuhic and Cole	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	\N	\N	\N	\N	145	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
205	2025-12-04 04:24:03.549488	2025-12-04 04:24:03.549488	Schulist-Shanahan	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	\N	\N	\N	\N	145	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
206	2025-12-04 04:24:03.578339	2025-12-04 04:24:03.578339	Davis, Medhurst and Gleichner	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	146	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
207	2025-12-04 04:24:03.604899	2025-12-04 04:24:03.604899	Schmitt-Mann	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	147	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
208	2025-12-04 04:24:03.618076	2025-12-04 04:24:03.618076	Gleichner, Boyle and Shields	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	\N	\N	\N	\N	147	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
209	2025-12-04 04:24:03.644156	2025-12-04 04:24:03.644156	Ledner, O'Conner and Orn	1-night bed and 24 hour drop-in showers and support services available. Doctors on site.\n	\N	\N	\N	\N	148	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
210	2025-12-04 04:24:03.669089	2025-12-04 04:24:03.669089	A Test Service	I am a long description of a service.	\N	\N	\N	\N	149	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	I am a short description of a service.	\N
211	2025-12-04 04:24:04.025621	2025-12-04 04:24:04.025621	Auer and Sons	Operates on a drop-in basis. Members sign in between 12:30 and 1pm. People aree seen on a first-come, first-served basis. If you have them, bring ID, letter of diagnosis and proof of income. At this time, AHASF is unable to provide phone counseling, or e-mail counseling or to set up special appointments for intakes. During drop-in, they will perform an intake assessment and create an Individualized Housing Plan.\n	\N	\N	\N	\N	150	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
212	2025-12-04 04:24:04.047934	2025-12-04 04:24:04.047934	Jaskolski-Johnston	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	151	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
213	2025-12-04 04:24:04.070507	2025-12-04 04:24:04.070507	Dach Group	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	\N	\N	\N	\N	152	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
214	2025-12-04 04:24:04.109044	2025-12-04 04:24:04.109044	Larkin-Lindgren	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	\N	\N	\N	\N	153	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
215	2025-12-04 04:24:04.140046	2025-12-04 04:24:04.140046	Durgan, Ledner and Deckow	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	154	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
216	2025-12-04 04:24:04.172378	2025-12-04 04:24:04.172378	Veum, Jerde and Labadie	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	\N	\N	\N	\N	155	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
217	2025-12-04 04:24:04.196717	2025-12-04 04:24:04.196717	Gorczany, Wuckert and Luettgen	Six (6) services per week in San Francisco.\nTue:\n8:30am - 2pm\nWed:\n8:30am - 12pm, 2pm - 5pm\nThu - Fri:\n8:30am - 2pm\nSat:\n7am - 1pm\n	\N	\N	\N	\N	156	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
218	2025-12-04 04:24:04.22082	2025-12-04 04:24:04.22082	Prosacco Group	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	\N	\N	\N	\N	157	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
219	2025-12-04 04:24:04.245854	2025-12-04 04:24:04.245854	Boyle Inc	Portable toilet at the corner of Golden Gate and Jones Tues-Fri 2pm - 9pm.\n	\N	\N	\N	\N	158	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
220	2025-12-04 04:24:04.269962	2025-12-04 04:24:04.269962	Ondricka-Bartoletti	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	\N	\N	\N	\N	159	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
221	2025-12-04 04:24:04.292979	2025-12-04 04:24:04.292979	Wisoky and Sons	Urgent and Primary Care, Dental, Podiatry, TB, STD, HIV, and Pregnancy testing, Health for Women, Family Planning, Prenatal Care, and Immunizations. Sliding scale (outpatient medical services free to homeless). Call for appt. Pediatrics & optometry available.\n	\N	\N	\N	\N	160	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
222	2025-12-04 04:24:04.320089	2025-12-04 04:24:04.320089	Hoeger and Sons	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	\N	\N	\N	\N	161	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
223	2025-12-04 04:24:04.344449	2025-12-04 04:24:04.344449	Torp-Marvin	Storage for personal belongings. Only one bag stored. Clothing and Shoes only. No suitcases - only plastic bags , duffle bags, back packs and acceptable containers.\n	\N	\N	\N	\N	162	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
224	2025-12-04 04:24:04.369672	2025-12-04 04:24:04.369672	Orn Group	Urgent and Primary Care, Mental Health, TB and HIV testing, Transgender Services and Immunizations. Insurance only. For San Francisco residents 18 or over. Call for appt.\n	\N	\N	\N	\N	163	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
225	2025-12-04 04:24:04.397926	2025-12-04 04:24:04.397926	Padberg-Price	The Adult Education Center offers morning and afternoon classes in literacy, basic education, GED preparation and high school diploma completion. Students attend small classes and can receive one-on-one instruction. Classes are open-enrollment; students can sign up anytime and be placed in a class right away.\n	\N	\N	\N	\N	164	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
226	2025-12-04 04:24:04.420318	2025-12-04 04:24:04.420318	Krajcik, Rogahn and Russel	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	\N	\N	\N	\N	165	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
227	2025-12-04 04:24:04.447491	2025-12-04 04:24:04.447491	Stark-Kemmer	A place to shower on Tuesday through Saturday.\n	\N	\N	\N	\N	166	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
228	2025-12-04 04:24:04.469667	2025-12-04 04:24:04.469667	Legros and Sons	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	\N	\N	\N	\N	167	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
229	2025-12-04 04:24:04.496717	2025-12-04 04:24:04.496717	Franecki LLC	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	168	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
230	2025-12-04 04:24:04.525601	2025-12-04 04:24:04.525601	McLaughlin, Towne and Olson	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	\N	\N	\N	\N	169	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
231	2025-12-04 04:24:04.548238	2025-12-04 04:24:04.548238	Padberg, Mayert and Kemmer	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	\N	\N	\N	\N	170	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
232	2025-12-04 04:24:04.571523	2025-12-04 04:24:04.571523	Koch, Konopelski and Barrows	Outreach wing of St. Mark’s ministry. Lunch and Dinner served, with to-go portions available as available. Families and singles accepted.\n	\N	\N	\N	\N	171	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
233	2025-12-04 04:24:04.596782	2025-12-04 04:24:04.596782	Tromp and Sons	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	172	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
234	2025-12-04 04:24:04.621616	2025-12-04 04:24:04.621616	Stoltenberg Group	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	173	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
235	2025-12-04 04:24:04.647874	2025-12-04 04:24:04.647874	Abernathy-Zemlak	Offers computer access and training to seniors (age 60+). Assistance can be provided in Vietnamese.\n	\N	\N	\N	\N	174	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
236	2025-12-04 04:24:04.669507	2025-12-04 04:24:04.669507	Friesen, Adams and Torphy	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	175	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
237	2025-12-04 04:24:04.693169	2025-12-04 04:24:04.693169	Stracke Group	Weekly food pantry (Thursday).\n	\N	\N	\N	\N	176	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
238	2025-12-04 04:24:04.719005	2025-12-04 04:24:04.719005	Harber Group	First-come, first-serve; no reservations required but identification mandatory. No pets, no families. 1 day beds only.\n	\N	\N	\N	\N	177	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
239	2025-12-04 04:24:04.743316	2025-12-04 04:24:04.743316	Schmidt-Swaniawski	Affiliated with John Muir Elementary School. Services for Families with children only. Black and white printer, scanner, wireless internet, and assistive technology available.\n	\N	\N	\N	\N	178	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
240	2025-12-04 04:24:04.766483	2025-12-04 04:24:04.766483	Dicki, Kerluke and Haley	Serves one hot meal a day. Anyone willing to stand in line will be served. Can return to line for more servings. Separate dining section for families with children. Families and seniors are served up to two trays at the table, without returning to the line. Wheelchair accessible. Families & folks age 60+ or unable to carry a tray: 10-11:30am. All others: 11:30am-1:30pm. When you arrive you will be given a number for a meal.\n	\N	\N	\N	\N	179	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
241	2025-12-04 04:24:04.789513	2025-12-04 04:24:04.789513	Mills, Mayer and Welch	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	\N	\N	\N	\N	180	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
242	2025-12-04 04:24:04.813136	2025-12-04 04:24:04.813136	Stoltenberg-Crooks	A place to shower on Tuesday through Saturday.\n	\N	\N	\N	\N	181	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
243	2025-12-04 04:24:04.838141	2025-12-04 04:24:04.838141	Kulas LLC	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	182	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
244	2025-12-04 04:24:04.863144	2025-12-04 04:24:04.863144	Bauch-Zulauf	Through a partnership with the San Francisco Department of Public Health, physicians and nurse practitioners provide care to senior patients (55+) by appointment from Monday through Friday (9 am to 5 pm), and on a drop-in basis for urgent care on Tuesdays (1 pm to 2 pm) and Fridays (9 am to 11 am). Podiatrist, clinic for women, and pharmacist also available.\n	\N	\N	\N	\N	183	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
245	2025-12-04 04:24:04.889188	2025-12-04 04:24:04.889188	Tromp, Marquardt and Rohan	Shelter for 1 or 2 parent families, expectant couples (with proof), and pregnant women in 7th month or 5th month with proof. Same-sex couples accepted. 1 night or 60 day beds.\n	\N	\N	\N	\N	184	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
246	2025-12-04 04:24:04.912127	2025-12-04 04:24:04.912127	Kreiger LLC	Serves lunch Monday and Wednesday. Dinner available all days.\n	\N	\N	\N	\N	185	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
247	2025-12-04 04:24:04.93693	2025-12-04 04:24:04.93693	Toy, Haag and Stamm	Job Search Assistance, Career Planning and Exploration, Job Preparation Workshops, Training Opportunities, Access to Resource Room with Computers, Fax and Copy machines, Unemployment Information (link to EDD), Availability of Supportive Services (including childcare and transportation). All services are free of charge.\n	\N	\N	\N	\N	186	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
248	2025-12-04 04:24:04.962848	2025-12-04 04:24:04.962848	McClure Inc	5 beds for women in crisis (rape or domestic violence); stay up to 7 days. 16 shelter beds; stay varies. 16 beds in supportive housing (5 for HIV+ women); stay up to 18 months. 8-bed substance abuse program for any woman 18+; stay 1-4 months.\n	\N	\N	\N	\N	187	\N	\N	1	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
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

COPY public.textings (id, texting_recipient_id, service_id, created_at, updated_at, resource_id) FROM stdin;
\.


--
-- Data for Name: user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_groups (user_id, group_id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, organization, user_external_id, email) FROM stdin;
1	Test User	Test Organization	test_user_external_id	test@test.com
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

SELECT pg_catalog.setval('public.change_requests_id_seq', 210, true);


--
-- Name: contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contacts_id_seq', 1, false);


--
-- Name: documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.documents_id_seq', 209, true);


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

SELECT pg_catalog.setval('public.field_changes_id_seq', 420, true);


--
-- Name: folders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.folders_id_seq', 1, false);


--
-- Name: fundings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fundings_id_seq', 1, false);


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.groups_id_seq', 1, false);


--
-- Name: instructions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instructions_id_seq', 209, true);


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

SELECT pg_catalog.setval('public.notes_id_seq', 435, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permissions_id_seq', 1, false);


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
-- Name: saved_searches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.saved_searches_id_seq', 1, false);


--
-- Name: schedule_days_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schedule_days_id_seq', 3075, true);


--
-- Name: schedules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schedules_id_seq', 435, true);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.services_id_seq', 248, true);


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

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


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
-- Name: folders folders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folders
    ADD CONSTRAINT folders_pkey PRIMARY KEY (id);


--
-- Name: fundings fundings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fundings
    ADD CONSTRAINT fundings_pkey PRIMARY KEY (id);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


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
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


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
-- Name: saved_searches saved_searches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_searches
    ADD CONSTRAINT saved_searches_pkey PRIMARY KEY (id);


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
-- Name: index_bookmarks_on_folder_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_bookmarks_on_folder_id ON public.bookmarks USING btree (folder_id);


--
-- Name: index_bookmarks_on_resource_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_bookmarks_on_resource_id ON public.bookmarks USING btree (resource_id);


--
-- Name: index_bookmarks_on_service_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_bookmarks_on_service_id ON public.bookmarks USING btree (service_id);


--
-- Name: index_bookmarks_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_bookmarks_on_user_id ON public.bookmarks USING btree (user_id);


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
-- Name: index_categories_sites_on_category_id_and_site_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_categories_sites_on_category_id_and_site_id ON public.categories_sites USING btree (category_id, site_id);


--
-- Name: index_categories_sites_on_site_id_and_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_categories_sites_on_site_id_and_category_id ON public.categories_sites USING btree (site_id, category_id);


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
-- Name: index_folders_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_folders_on_user_id ON public.folders USING btree (user_id);


--
-- Name: index_group_permissions_on_group_id_and_permission_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_group_permissions_on_group_id_and_permission_id ON public.group_permissions USING btree (group_id, permission_id);


--
-- Name: index_group_permissions_on_permission_id_and_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_group_permissions_on_permission_id_and_group_id ON public.group_permissions USING btree (permission_id, group_id);


--
-- Name: index_groups_on_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_groups_on_name ON public.groups USING btree (name);


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
-- Name: index_permissions_on_resource_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_permissions_on_resource_id ON public.permissions USING btree (resource_id);


--
-- Name: index_permissions_on_resource_id_and_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_permissions_on_resource_id_and_action ON public.permissions USING btree (resource_id, action);


--
-- Name: index_permissions_on_service_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_permissions_on_service_id ON public.permissions USING btree (service_id);


--
-- Name: index_permissions_on_service_id_and_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_permissions_on_service_id_and_action ON public.permissions USING btree (service_id, action);


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
-- Name: index_resources_sites_on_resource_id_and_site_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_resources_sites_on_resource_id_and_site_id ON public.resources_sites USING btree (resource_id, site_id);


--
-- Name: index_resources_sites_on_site_id_and_resource_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_resources_sites_on_site_id_and_resource_id ON public.resources_sites USING btree (site_id, resource_id);


--
-- Name: index_reviews_on_feedback_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_reviews_on_feedback_id ON public.reviews USING btree (feedback_id);


--
-- Name: index_saved_searches_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_saved_searches_on_user_id ON public.saved_searches USING btree (user_id);


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
-- Name: index_services_on_boosted_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_services_on_boosted_category_id ON public.services USING btree (boosted_category_id);


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
-- Name: index_textings_on_resource_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_textings_on_resource_id ON public.textings USING btree (resource_id);


--
-- Name: index_textings_on_service_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_textings_on_service_id ON public.textings USING btree (service_id);


--
-- Name: index_textings_on_texting_recipient_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_textings_on_texting_recipient_id ON public.textings USING btree (texting_recipient_id);


--
-- Name: index_user_groups_on_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_user_groups_on_group_id ON public.user_groups USING btree (group_id);


--
-- Name: index_user_groups_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_user_groups_on_user_id ON public.user_groups USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


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
-- Name: folders fk_rails_2a04d378cf; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folders
    ADD CONSTRAINT fk_rails_2a04d378cf FOREIGN KEY (user_id) REFERENCES public.users(id);


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
-- Name: bookmarks fk_rails_40466079a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookmarks
    ADD CONSTRAINT fk_rails_40466079a6 FOREIGN KEY (service_id) REFERENCES public.services(id);


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
-- Name: bookmarks fk_rails_5d776ed021; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookmarks
    ADD CONSTRAINT fk_rails_5d776ed021 FOREIGN KEY (resource_id) REFERENCES public.resources(id);


--
-- Name: saved_searches fk_rails_63c5382842; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_searches
    ADD CONSTRAINT fk_rails_63c5382842 FOREIGN KEY (user_id) REFERENCES public.users(id);


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
-- Name: eligibilities fk_rails_8b66d3ba15; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eligibilities
    ADD CONSTRAINT fk_rails_8b66d3ba15 FOREIGN KEY (parent_id) REFERENCES public.eligibilities(id);


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
-- Name: permissions fk_rails_9d3f95f3b7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT fk_rails_9d3f95f3b7 FOREIGN KEY (resource_id) REFERENCES public.resources(id);


--
-- Name: notes fk_rails_9dd4d623bc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT fk_rails_9dd4d623bc FOREIGN KEY (resource_id) REFERENCES public.resources(id);


--
-- Name: textings fk_rails_acd2396034; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.textings
    ADD CONSTRAINT fk_rails_acd2396034 FOREIGN KEY (resource_id) REFERENCES public.resources(id);


--
-- Name: resources_sites fk_rails_b2ab196031; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources_sites
    ADD CONSTRAINT fk_rails_b2ab196031 FOREIGN KEY (site_id) REFERENCES public.sites(id);


--
-- Name: services fk_rails_b635aca7c4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT fk_rails_b635aca7c4 FOREIGN KEY (boosted_category_id) REFERENCES public.categories(id);


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
-- Name: bookmarks fk_rails_c1ff6fa4ac; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookmarks
    ADD CONSTRAINT fk_rails_c1ff6fa4ac FOREIGN KEY (user_id) REFERENCES public.users(id);


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
-- Name: bookmarks fk_rails_d1abddda85; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookmarks
    ADD CONSTRAINT fk_rails_d1abddda85 FOREIGN KEY (folder_id) REFERENCES public.folders(id);


--
-- Name: permissions fk_rails_d938fab63c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT fk_rails_d938fab63c FOREIGN KEY (service_id) REFERENCES public.services(id);


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
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

