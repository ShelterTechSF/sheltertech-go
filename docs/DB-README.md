# Database Architecture

This doc essentially captures all the tables present in the backend. Some junction tables have been ommited for brevity others because limits have been reached.
This DB essentially represent the postgres backed ruby on rails app that we are migrating away from.
[🔗 The Full Database ERD (Entity-Relationship Diagram) on Lucidchart here](https://lucid.app/lucidchart/b166b5fe-dff4-4ece-b252-04afbdd22973/edit?viewport_loc=-1454%2C0_0&invitationId=inv_40d82f1f-b1ec-4af6-8e57-b04bf71b7ca4)

## Resource and Service Management
### Core Resource Entities
1. Resources
2. Services
### Associated Documentation, Notes and instructions for Resources and services
1. Documents
2. Notes
3. Instructions


### Resource Metadata and Classification
1. Categories
2. Keywords
3. Category Relationships
4. Categories Resources(JT)
5. Categories Services(JT)

## Administrative Management
1. Change Requests
2. Field Changes

## Contact and Communication
### Contact Information
1. Contacts
2. Phones
3. Addresses

## Textings
### Tables related to a feature that allows a user to have a particular resource or service's URL texted to them.
1. Texting Recipients
2. Textings

## Operational Details
### Scheduling and Availability
1. Schedules
2. Schedule Days

### Eligibility and Access
1. Eligibilities
2. Eligibilities Services (JT)
3. Eligibility Relationships

## Informational Resources
1. News Articles

## Algolia support tables 
(Linguistic and Semantic Support)
1. Synonym Groups
2. Synonyms

## WhiteLabel sites support 
1. Sites
2. Resources Sites

## Bookmarking and Organization
### User Organization Tools
1. Bookmarks
2. Folders
3. Saved Searches

## User Management and Access Control
### User Accounts and Authentication
1. Users
2. Admins
3. Groups
4. User Groups (JT)
5. Permissions
6. Group Permissions

## Deprecated Tables
Legacy Tables that are not actively being used or hold no data.
### Resource related Entities
1. Programs
2. Volunteers

### Meta
### Resource Metadata and Classification
1. Keywords Resources
2. Keywords Services

### User Feedback Mechanisms
~~1. Feedbacks~~
2. Reviews ( Never Used)

### Language and Synonym Management
~~1. Languages~~

### Organizational Metadata
~~1. Fundings~~

### FAQ
#### 1. What are Schedules and Schedule days ?
Schedules function as container objects to which individual schedule days are attached, with each schedule day defining specific open and close times for a particular day of the week. The system employs an unusual time encoding where hours and minutes are represented by a single integer, creating a pseudo-string format that requires careful interpretation. For instance, 6:30 AM is encoded as 630, while 7:00 AM becomes 700, with a critical constraint that any integer ending in 60-99 is considered invalid

#### 2. What exactly does textings do or represent ? 
These represent text messages (a.k.a. SMS) sent through the third party provider we use named Textellent. There's a feature on our website where a user can view a service and then click a button to have the URL for that service sent to them via text message. Many people who are experiencing homelessness are either not tech savvy (due to being older) or do not have constant access to the internet, but most have phones and can receive SMS messages anywhere, so it is often better for them to be sent things via SMS than via email

Striked out tables  means they are intended to be deleted. 
Tables marked with (JT) indiicate that they are join tables

## TABLE DEFINITIONS
This is not runnable sql but does give an idea as to how the tables look like with their constraints
``` SQL
-- Disable foreign key checks to allow creation in any order
SET session_replication_role = 'replica';

-- Independent Tables (No Foreign Keys)
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
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT admins_pkey PRIMARY KEY (id)
);
-- erd done
CREATE TABLE public.categories (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    vocabulary character varying,
    featured boolean DEFAULT false,
    CONSTRAINT categories_pkey PRIMARY KEY (id)
);
-- erd done
CREATE TABLE public.documents (
    id bigint NOT NULL,
    name character varying,
    url character varying,
    description character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    CONSTRAINT documents_pkey PRIMARY KEY (id)
);
-- erd done
CREATE TABLE public.fundings (
    id integer NOT NULL,
    source character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT fundings_pkey PRIMARY KEY (id)
);
-- erd done
CREATE TABLE public.groups (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    CONSTRAINT groups_pkey PRIMARY KEY (id)
);
-- erd done
CREATE TABLE public.keywords (
    id integer NOT NULL,
    name character varying,
    CONSTRAINT keywords_pkey PRIMARY KEY (id)
);
-- erd done
CREATE TABLE public.languages (
    id integer NOT NULL,
    language character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT languages_pkey PRIMARY KEY (id)
);
-- erd done
CREATE TABLE public.news_articles (
    id bigint NOT NULL,
    headline character varying,
    effective_date timestamp without time zone,
    body character varying,
    priority integer,
    expiration_date timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    url character varying,
    CONSTRAINT news_articles_pkey PRIMARY KEY (id);

);
-- erd done
CREATE TABLE public.sites (
    id bigint NOT NULL,
    site_code character varying DEFAULT 'sfsg'::character varying,
    CONSTRAINT sites_pkey PRIMARY KEY (id)
);
-- erd done
CREATE TABLE public.synonym_groups (
    id bigint NOT NULL,
    group_type integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT synonym_groups_pkey PRIMARY KEY (id)
);
-- erd done
CREATE TABLE public.texting_recipients (
    id bigint NOT NULL,
    recipient_name character varying,
    phone_number character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT texting_recipients_pkey PRIMARY KEY (id)
);
-- erd done
CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying,
    organization character varying,
    user_external_id character varying,
    email character varying,
    CONSTRAINT users_pkey PRIMARY KEY (id)
);
-- Tables with Self-Referential Foreign Keys
-- erd done
CREATE TABLE public.eligibilities (
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    feature_rank integer,
    is_parent boolean DEFAULT false,
    parent_id integer,
    CONSTRAINT eligibilities_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_8b66d3ba15 FOREIGN KEY (parent_id) REFERENCES public.eligibilities(id)
);
----
-- erd done 
CREATE TABLE public.accessibilities (
    id integer NOT NULL,
    accessibility character varying,
    details character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT accessibilities_pkey PRIMARY KEY (id)
);
-- erd done
CREATE TABLE public.addresses (
    id integer NOT NULL,
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
    transportation text,
    CONSTRAINT addresses_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_55362d1ad2 FOREIGN KEY (resource_id) REFERENCES public.resources(id)
);

CREATE TABLE public.bookmarks (
    id bigint NOT NULL,
    "order" integer,
    folder_id bigint,
    service_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    resource_id bigint,
    user_id bigint,
    name character varying,
    CONSTRAINT bookmarks_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_40466079a6 FOREIGN KEY (service_id) REFERENCES public.services(id),
    CONSTRAINT fk_rails_5d776ed021 FOREIGN KEY (resource_id) REFERENCES public.resources(id),
    CONSTRAINT fk_rails_c1ff6fa4ac FOREIGN KEY (user_id) REFERENCES public.users(id),
    CONSTRAINT fk_rails_d1abddda85 FOREIGN KEY (folder_id) REFERENCES public.folders(id)
);
-- erd done
CREATE TABLE public.change_requests (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    type character varying,
    object_id integer,
    status integer DEFAULT 0,
    action integer DEFAULT 1,
    resource_id integer,
    CONSTRAINT change_requests_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_ddab69079b FOREIGN KEY (resource_id) REFERENCES public.resources(id)
);
-- erd done
CREATE TABLE public.contacts (
    id integer NOT NULL,
    name character varying,
    title character varying,
    email character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    resource_id integer,
    service_id integer,
    CONSTRAINT contacts_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_e5fbe64e2e FOREIGN KEY (service_id) REFERENCES public.services(id),
    CONSTRAINT fk_rails_fb619aa824 FOREIGN KEY (resource_id) REFERENCES public.resources(id)
);
-- erd done
CREATE TABLE public.feedbacks (
    id bigint NOT NULL,
    rating character varying NOT NULL,
    resource_id bigint,
    service_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT feedbacks_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_ba1e97eb0b FOREIGN KEY (service_id) REFERENCES public.services(id),
    CONSTRAINT fk_rails_e5a70b6b87 FOREIGN KEY (resource_id) REFERENCES public.resources(id)
);
-- erd done
CREATE TABLE public.field_changes (
    id integer NOT NULL,
    field_name character varying,
    field_value character varying,
    change_request_id integer NOT NULL,
    CONSTRAINT field_changes_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_ed91fd9e31 FOREIGN KEY (change_request_id) REFERENCES public.change_requests(id)
);
-- erd done
CREATE TABLE public.folders (
    id bigint NOT NULL,
    name character varying,
    "order" integer,
    user_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    CONSTRAINT folders_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_2a04d378cf FOREIGN KEY (user_id) REFERENCES public.users(id)
);
-- erd done
CREATE TABLE public.instructions (
    id bigint NOT NULL,
    instruction character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    service_id bigint,
    CONSTRAINT instructions_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_36cfbe63f1 FOREIGN KEY (service_id) REFERENCES public.services(id)
);

-- erd done
CREATE TABLE public.notes (
    id integer NOT NULL,
    note text,
    resource_id integer,
    service_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT notes_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_64d648111b FOREIGN KEY (service_id) REFERENCES public.services(id),
    CONSTRAINT fk_rails_9dd4d623bc FOREIGN KEY (resource_id) REFERENCES public.resources(id)
);
CREATE TABLE public.permissions (
    id bigint NOT NULL,
    action integer,
    resource_id bigint,
    service_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    CONSTRAINT permissions_pkey PRIMARY KEY (id),
    CONSTRAINT resource_xor_service CHECK ((((resource_id IS NOT NULL) AND (service_id IS NULL)) OR ((resource_id IS NULL) AND (service_id IS NOT NULL)))),
    CONSTRAINT fk_rails_9d3f95f3b7 FOREIGN KEY (resource_id) REFERENCES public.resources(id),
    CONSTRAINT fk_rails_d938fab63c FOREIGN KEY (service_id) REFERENCES public.services(id)
);
-- erd done 
CREATE TABLE public.phones (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    number character varying NOT NULL,
    service_type character varying NOT NULL,
    resource_id integer NOT NULL,
    description character varying,
    service_id integer,
    contact_id integer,
    language_id integer,
    CONSTRAINT phones_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_0c8c68a120 FOREIGN KEY (contact_id) REFERENCES public.contacts(id),
    CONSTRAINT fk_rails_57049cfb09 FOREIGN KEY (language_id) REFERENCES public.languages(id),
    CONSTRAINT fk_rails_8af4287405 FOREIGN KEY (service_id) REFERENCES public.services(id),
    CONSTRAINT fk_rails_924e6c87a8 FOREIGN KEY (resource_id) REFERENCES public.resources(id)
);
-- erd done
CREATE TABLE public.programs (
    id integer NOT NULL,
    name character varying,
    alternate_name character varying,
    description character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    resource_id integer,
    CONSTRAINT programs_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_2de31db625 FOREIGN KEY (resource_id) REFERENCES public.resources(id)
);
-- erd done
CREATE TABLE public.resources (
    id integer NOT NULL,
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
    internal_note text,
    CONSTRAINT resources_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_c3c5410abb FOREIGN KEY (contact_id) REFERENCES public.contacts(id),
    CONSTRAINT fk_rails_e042c299b0 FOREIGN KEY (funding_id) REFERENCES public.fundings(id)
);
CREATE TABLE public.reviews (
    id bigint NOT NULL,
    review text,
    tags text[] DEFAULT '{}'::text[],
    feedback_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT reviews_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_ba3bc4eba4 FOREIGN KEY (feedback_id) REFERENCES public.feedbacks(id)
);
CREATE TABLE public.saved_searches (
    id bigint NOT NULL,
    user_id bigint,
    name character varying,
    search jsonb DEFAULT '"{}"'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    CONSTRAINT saved_searches_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_63c5382842 FOREIGN KEY (user_id) REFERENCES public.users(id)
);
CREATE TABLE public.schedule_days (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    day character varying NOT NULL,
    opens_at integer,
    closes_at integer,
    schedule_id integer NOT NULL,
    open_time time without time zone,
    open_day character varying,
    close_time time without time zone,
    close_day character varying,
    CONSTRAINT schedule_days_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_29f8ca6b88 FOREIGN KEY (schedule_id) REFERENCES public.schedules(id)
);
CREATE TABLE public.schedules (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    resource_id integer,
    service_id integer,
    hours_known boolean DEFAULT true,
    CONSTRAINT schedules_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_766e5034a8 FOREIGN KEY (service_id) REFERENCES public.services(id),
    CONSTRAINT fk_rails_c5d9a6dd50 FOREIGN KEY (resource_id) REFERENCES public.resources(id)
);
-- erd done
CREATE TABLE public.services (
    id integer NOT NULL,
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
    short_description character varying,
    boosted_category_id bigint,
    CONSTRAINT services_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_2633b2a805 FOREIGN KEY (program_id) REFERENCES public.programs(id),
    CONSTRAINT fk_rails_73c21d485f FOREIGN KEY (contact_id) REFERENCES public.contacts(id),
    CONSTRAINT fk_rails_b635aca7c4 FOREIGN KEY (boosted_category_id) REFERENCES public.categories(id),
    CONSTRAINT fk_rails_e4aecbda0b FOREIGN KEY (funding_id) REFERENCES public.fundings(id),
    CONSTRAINT fk_rails_f45d7dd368 FOREIGN KEY (resource_id) REFERENCES public.resources(id)
);
-- erd done
CREATE TABLE public.synonyms (
    id bigint NOT NULL,
    word character varying,
    synonym_group_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT synonyms_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_ec216edb57 FOREIGN KEY (synonym_group_id) REFERENCES public.synonym_groups(id)
);

CREATE TABLE public.textings (
    id bigint NOT NULL,
    texting_recipient_id bigint NOT NULL,
    service_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    resource_id bigint,
    CONSTRAINT textings_pkey PRIMARY KEY (id),
    CONSTRAINT resource_xor_service CHECK ((((resource_id IS NOT NULL) AND (service_id IS NULL)) OR ((resource_id IS NULL) AND (service_id IS NOT NULL)))),
    CONSTRAINT fk_rails_8c41a435e9 FOREIGN KEY (service_id) REFERENCES public.services(id),
    CONSTRAINT fk_rails_976379f94a FOREIGN KEY (texting_recipient_id) REFERENCES public.texting_recipients(id),
    CONSTRAINT fk_rails_acd2396034 FOREIGN KEY (resource_id) REFERENCES public.resources(id)
);
-- erd done
CREATE TABLE public.volunteers (
    id integer NOT NULL,
    description character varying,
    url character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    resource_id integer,
    CONSTRAINT volunteers_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_97f9ec98e4 FOREIGN KEY (resource_id) REFERENCES public.resources(id)
);
-- Many-to-Many and Junction Tables (Primary Key Constraints not explicitly named)
CREATE TABLE public.addresses_services (
    service_id integer NOT NULL,
    address_id integer NOT NULL
);
-- erd done 
CREATE TABLE public.categories_keywords (
    category_id integer NOT NULL,
    keyword_id integer NOT NULL
);
-- erd done
CREATE TABLE public.categories_resources (
    category_id integer NOT NULL,
    resource_id integer NOT NULL
);
-- erd done
CREATE TABLE public.categories_services (
    service_id integer NOT NULL,
    category_id integer NOT NULL,
    feature_rank integer
);
-- erd done
CREATE TABLE public.categories_sites (
    category_id bigint NOT NULL,
    site_id bigint NOT NULL,
    CONSTRAINT fk_rails_77373afc24 FOREIGN KEY (site_id) REFERENCES public.sites(id),
    CONSTRAINT fk_rails_915b8c61e8 FOREIGN KEY (category_id) REFERENCES public.categories(id)
);
CREATE TABLE public.category_relationships (
    parent_id integer NOT NULL,
    child_id integer NOT NULL,
    child_priority_rank integer
);
CREATE TABLE public.documents_services (
    service_id integer,
    document_id integer
);
CREATE TABLE public.eligibilities_services (
    service_id integer NOT NULL,
    eligibility_id integer NOT NULL
); 
CREATE TABLE public.eligibility_relationships (
    parent_id integer NOT NULL,
    child_id integer NOT NULL
);
CREATE TABLE public.group_permissions (
    group_id bigint NOT NULL,
    permission_id bigint NOT NULL
);
CREATE TABLE public.keywords_resources (
    resource_id integer NOT NULL,
    keyword_id integer NOT NULL
);
CREATE TABLE public.keywords_services (
    service_id integer NOT NULL,
    keyword_id integer NOT NULL
);
-- erd done
CREATE TABLE public.resources_sites (
    resource_id bigint NOT NULL,
    site_id bigint NOT NULL,
    CONSTRAINT fk_rails_101ffc8ff0 FOREIGN KEY (resource_id) REFERENCES public.resources(id),
    CONSTRAINT fk_rails_b2ab196031 FOREIGN KEY (site_id) REFERENCES public.sites(id)
);
CREATE TABLE public.user_groups (
    user_id bigint NOT NULL,
    group_id bigint NOT NULL
);




