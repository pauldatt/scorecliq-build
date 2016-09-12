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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying,
    scoreboard_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: charges; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE charges (
    id integer NOT NULL,
    user_id integer,
    amount integer,
    card_last4 character varying,
    stripe_charge_id character varying,
    success boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: charges_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE charges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: charges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE charges_id_seq OWNED BY charges.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE comments (
    id integer NOT NULL,
    body text,
    reply text,
    user_id integer,
    topic_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    ancestry character varying
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: conversations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE conversations (
    id integer NOT NULL,
    subject character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE conversations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE conversations_id_seq OWNED BY conversations.id;


--
-- Name: documents; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE documents (
    id integer NOT NULL,
    file_name character varying,
    file character varying,
    category_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE documents_id_seq OWNED BY documents.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    event_name character varying,
    event_date date,
    event_time time without time zone,
    notes character varying,
    location character varying,
    scoreboard_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: favourites; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE favourites (
    id integer NOT NULL,
    user_id integer,
    scoreboard_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: favourites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE favourites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: favourites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE favourites_id_seq OWNED BY favourites.id;


--
-- Name: invitations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE invitations (
    id integer NOT NULL,
    recipient_name character varying,
    recipient_email character varying,
    scoreboard_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: invitations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE invitations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: invitations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE invitations_id_seq OWNED BY invitations.id;


--
-- Name: managers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE managers (
    id integer NOT NULL,
    user_id integer,
    scoreboard_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: managers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE managers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: managers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE managers_id_seq OWNED BY managers.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE messages (
    id integer NOT NULL,
    user_id integer,
    conversation_id integer,
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE messages_id_seq OWNED BY messages.id;


--
-- Name: pg_search_documents; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pg_search_documents (
    id integer NOT NULL,
    content text,
    searchable_id integer,
    searchable_type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pg_search_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pg_search_documents_id_seq OWNED BY pg_search_documents.id;


--
-- Name: pictures; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pictures (
    id integer NOT NULL,
    picture character varying,
    pictureable_id integer,
    pictureable_type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pictures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pictures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pictures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pictures_id_seq OWNED BY pictures.id;


--
-- Name: requests; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE requests (
    id integer NOT NULL,
    user_id integer,
    scoreboard_id integer,
    approved boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: requests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE requests_id_seq OWNED BY requests.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: scoreboards; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE scoreboards (
    id integer NOT NULL,
    name_of_scoreboard character varying,
    name_of_organization character varying,
    name_of_activity character varying,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tsv tsvector,
    privatization boolean DEFAULT false,
    location character varying
);


--
-- Name: scoreboards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE scoreboards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: scoreboards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE scoreboards_id_seq OWNED BY scoreboards.id;


--
-- Name: statuses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE statuses (
    id integer NOT NULL,
    content text,
    scoreboard_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE statuses_id_seq OWNED BY statuses.id;


--
-- Name: team_matches; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE team_matches (
    id integer NOT NULL,
    team_a_id integer,
    team_b_id integer,
    match_date date,
    match_time time without time zone,
    location character varying,
    score character varying,
    scoreboard_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: team_matches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE team_matches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: team_matches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE team_matches_id_seq OWNED BY team_matches.id;


--
-- Name: team_members; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE team_members (
    id integer NOT NULL,
    team_id integer,
    user_id integer,
    captain boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: team_members_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE team_members_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: team_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE team_members_id_seq OWNED BY team_members.id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE teams (
    id integer NOT NULL,
    name character varying,
    win integer,
    loss integer,
    tie integer,
    scoreboard_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE teams_id_seq OWNED BY teams.id;


--
-- Name: topics; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE topics (
    id integer NOT NULL,
    subject character varying,
    user_id integer,
    scoreboard_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: topics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE topics_id_seq OWNED BY topics.id;


--
-- Name: user_conversations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_conversations (
    id integer NOT NULL,
    user_id integer,
    conversation_id integer,
    deleted boolean,
    read boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: user_conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_conversations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_conversations_id_seq OWNED BY user_conversations.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying,
    email character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    password_digest character varying,
    remember_digest character varying,
    admin boolean DEFAULT false,
    activation_digest character varying,
    activated boolean DEFAULT false,
    activated_at timestamp without time zone,
    reset_digest character varying,
    reset_sent_at timestamp without time zone,
    stripe_id character varying,
    stripe_subscription_id character varying,
    card_last4 character varying,
    card_exp_month integer,
    card_exp_year integer,
    premium boolean DEFAULT false
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY charges ALTER COLUMN id SET DEFAULT nextval('charges_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY conversations ALTER COLUMN id SET DEFAULT nextval('conversations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY documents ALTER COLUMN id SET DEFAULT nextval('documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY favourites ALTER COLUMN id SET DEFAULT nextval('favourites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY invitations ALTER COLUMN id SET DEFAULT nextval('invitations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY managers ALTER COLUMN id SET DEFAULT nextval('managers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages ALTER COLUMN id SET DEFAULT nextval('messages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pg_search_documents ALTER COLUMN id SET DEFAULT nextval('pg_search_documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pictures ALTER COLUMN id SET DEFAULT nextval('pictures_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY requests ALTER COLUMN id SET DEFAULT nextval('requests_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY scoreboards ALTER COLUMN id SET DEFAULT nextval('scoreboards_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY statuses ALTER COLUMN id SET DEFAULT nextval('statuses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY team_matches ALTER COLUMN id SET DEFAULT nextval('team_matches_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY team_members ALTER COLUMN id SET DEFAULT nextval('team_members_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY teams ALTER COLUMN id SET DEFAULT nextval('teams_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY topics ALTER COLUMN id SET DEFAULT nextval('topics_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_conversations ALTER COLUMN id SET DEFAULT nextval('user_conversations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: charges_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY charges
    ADD CONSTRAINT charges_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);


--
-- Name: documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: favourites_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY favourites
    ADD CONSTRAINT favourites_pkey PRIMARY KEY (id);


--
-- Name: invitations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY invitations
    ADD CONSTRAINT invitations_pkey PRIMARY KEY (id);


--
-- Name: managers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY managers
    ADD CONSTRAINT managers_pkey PRIMARY KEY (id);


--
-- Name: messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: pg_search_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pg_search_documents
    ADD CONSTRAINT pg_search_documents_pkey PRIMARY KEY (id);


--
-- Name: pictures_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pictures
    ADD CONSTRAINT pictures_pkey PRIMARY KEY (id);


--
-- Name: requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY requests
    ADD CONSTRAINT requests_pkey PRIMARY KEY (id);


--
-- Name: scoreboards_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY scoreboards
    ADD CONSTRAINT scoreboards_pkey PRIMARY KEY (id);


--
-- Name: statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY statuses
    ADD CONSTRAINT statuses_pkey PRIMARY KEY (id);


--
-- Name: team_matches_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY team_matches
    ADD CONSTRAINT team_matches_pkey PRIMARY KEY (id);


--
-- Name: team_members_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY team_members
    ADD CONSTRAINT team_members_pkey PRIMARY KEY (id);


--
-- Name: teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: topics_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (id);


--
-- Name: user_conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_conversations
    ADD CONSTRAINT user_conversations_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_categories_on_scoreboard_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_categories_on_scoreboard_id ON categories USING btree (scoreboard_id);


--
-- Name: index_charges_on_stripe_charge_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_charges_on_stripe_charge_id ON charges USING btree (stripe_charge_id);


--
-- Name: index_comments_on_ancestry; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_ancestry ON comments USING btree (ancestry);


--
-- Name: index_comments_on_topic_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_topic_id ON comments USING btree (topic_id);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_user_id ON comments USING btree (user_id);


--
-- Name: index_documents_on_category_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_documents_on_category_id ON documents USING btree (category_id);


--
-- Name: index_events_on_scoreboard_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_events_on_scoreboard_id ON events USING btree (scoreboard_id);


--
-- Name: index_favourites_on_scoreboard_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_favourites_on_scoreboard_id ON favourites USING btree (scoreboard_id);


--
-- Name: index_favourites_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_favourites_on_user_id ON favourites USING btree (user_id);


--
-- Name: index_favourites_on_user_id_and_scoreboard_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_favourites_on_user_id_and_scoreboard_id ON favourites USING btree (user_id, scoreboard_id);


--
-- Name: index_invitations_on_scoreboard_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_invitations_on_scoreboard_id ON invitations USING btree (scoreboard_id);


--
-- Name: index_managers_on_scoreboard_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_managers_on_scoreboard_id ON managers USING btree (scoreboard_id);


--
-- Name: index_managers_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_managers_on_user_id ON managers USING btree (user_id);


--
-- Name: index_messages_on_conversation_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_messages_on_conversation_id ON messages USING btree (conversation_id);


--
-- Name: index_messages_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_messages_on_user_id ON messages USING btree (user_id);


--
-- Name: index_pg_search_documents_on_searchable_type_and_searchable_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_pg_search_documents_on_searchable_type_and_searchable_id ON pg_search_documents USING btree (searchable_type, searchable_id);


--
-- Name: index_pictures_on_pictureable_id_and_pictureable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_pictures_on_pictureable_id_and_pictureable_type ON pictures USING btree (pictureable_id, pictureable_type);


--
-- Name: index_requests_on_scoreboard_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_requests_on_scoreboard_id ON requests USING btree (scoreboard_id);


--
-- Name: index_requests_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_requests_on_user_id ON requests USING btree (user_id);


--
-- Name: index_scoreboards_on_tsv; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_scoreboards_on_tsv ON scoreboards USING gin (tsv);


--
-- Name: index_scoreboards_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_scoreboards_on_user_id ON scoreboards USING btree (user_id);


--
-- Name: index_scoreboards_on_user_id_and_created_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_scoreboards_on_user_id_and_created_at ON scoreboards USING btree (user_id, created_at);


--
-- Name: index_statuses_on_scoreboard_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_statuses_on_scoreboard_id ON statuses USING btree (scoreboard_id);


--
-- Name: index_team_matches_on_scoreboard_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_team_matches_on_scoreboard_id ON team_matches USING btree (scoreboard_id);


--
-- Name: index_team_matches_on_team_a_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_team_matches_on_team_a_id ON team_matches USING btree (team_a_id);


--
-- Name: index_team_matches_on_team_b_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_team_matches_on_team_b_id ON team_matches USING btree (team_b_id);


--
-- Name: index_team_members_on_team_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_team_members_on_team_id ON team_members USING btree (team_id);


--
-- Name: index_team_members_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_team_members_on_user_id ON team_members USING btree (user_id);


--
-- Name: index_teams_on_scoreboard_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_teams_on_scoreboard_id ON teams USING btree (scoreboard_id);


--
-- Name: index_topics_on_scoreboard_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_topics_on_scoreboard_id ON topics USING btree (scoreboard_id);


--
-- Name: index_topics_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_topics_on_user_id ON topics USING btree (user_id);


--
-- Name: index_user_conversations_on_conversation_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_conversations_on_conversation_id ON user_conversations USING btree (conversation_id);


--
-- Name: index_user_conversations_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_conversations_on_user_id ON user_conversations USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_stripe_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_stripe_id ON users USING btree (stripe_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: tsvectorupdate; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE ON scoreboards FOR EACH ROW EXECUTE PROCEDURE tsvector_update_trigger('tsv', 'pg_catalog.english', 'name_of_scoreboard', 'name_of_organization', 'name_of_activity', 'location');


--
-- Name: fk_rails_1bd619fd58; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY scoreboards
    ADD CONSTRAINT fk_rails_1bd619fd58 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_2552fd2038; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invitations
    ADD CONSTRAINT fk_rails_2552fd2038 FOREIGN KEY (scoreboard_id) REFERENCES scoreboards(id);


--
-- Name: fk_rails_304480446a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY events
    ADD CONSTRAINT fk_rails_304480446a FOREIGN KEY (scoreboard_id) REFERENCES scoreboards(id);


--
-- Name: fk_rails_42aa6bf0fa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT fk_rails_42aa6bf0fa FOREIGN KEY (topic_id) REFERENCES topics(id);


--
-- Name: fk_rails_64e088bcbb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT fk_rails_64e088bcbb FOREIGN KEY (category_id) REFERENCES categories(id);


--
-- Name: fk_rails_6ec2bf9044; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT fk_rails_6ec2bf9044 FOREIGN KEY (conversation_id) REFERENCES conversations(id);


--
-- Name: fk_rails_73979e89a7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY topics
    ADD CONSTRAINT fk_rails_73979e89a7 FOREIGN KEY (scoreboard_id) REFERENCES scoreboards(id);


--
-- Name: fk_rails_9802f785fb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT fk_rails_9802f785fb FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_a060af0e11; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT fk_rails_a060af0e11 FOREIGN KEY (scoreboard_id) REFERENCES scoreboards(id);


--
-- Name: fk_rails_ada804747c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT fk_rails_ada804747c FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_ce112f16ec; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY statuses
    ADD CONSTRAINT fk_rails_ce112f16ec FOREIGN KEY (scoreboard_id) REFERENCES scoreboards(id);


--
-- Name: fk_rails_cfb0304e59; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT fk_rails_cfb0304e59 FOREIGN KEY (scoreboard_id) REFERENCES scoreboards(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20150614200131');

INSERT INTO schema_migrations (version) VALUES ('20150615001945');

INSERT INTO schema_migrations (version) VALUES ('20150615004307');

INSERT INTO schema_migrations (version) VALUES ('20150620180234');

INSERT INTO schema_migrations (version) VALUES ('20150625050444');

INSERT INTO schema_migrations (version) VALUES ('20150625144938');

INSERT INTO schema_migrations (version) VALUES ('20150626002132');

INSERT INTO schema_migrations (version) VALUES ('20150701225546');

INSERT INTO schema_migrations (version) VALUES ('20150927064023');

INSERT INTO schema_migrations (version) VALUES ('20151015143455');

INSERT INTO schema_migrations (version) VALUES ('20151102170716');

INSERT INTO schema_migrations (version) VALUES ('20151209160720');

INSERT INTO schema_migrations (version) VALUES ('20151220193756');

INSERT INTO schema_migrations (version) VALUES ('20160128031906');

INSERT INTO schema_migrations (version) VALUES ('20160307212202');

INSERT INTO schema_migrations (version) VALUES ('20160313172147');

INSERT INTO schema_migrations (version) VALUES ('20160414223901');

INSERT INTO schema_migrations (version) VALUES ('20160414230714');

INSERT INTO schema_migrations (version) VALUES ('20160414233457');

INSERT INTO schema_migrations (version) VALUES ('20160415000346');

INSERT INTO schema_migrations (version) VALUES ('20160415011705');

INSERT INTO schema_migrations (version) VALUES ('20160426134550');

INSERT INTO schema_migrations (version) VALUES ('20160519013903');

INSERT INTO schema_migrations (version) VALUES ('20160519021310');

INSERT INTO schema_migrations (version) VALUES ('20160531021059');

INSERT INTO schema_migrations (version) VALUES ('20160612031547');

INSERT INTO schema_migrations (version) VALUES ('20160612032104');

INSERT INTO schema_migrations (version) VALUES ('20160619194756');

INSERT INTO schema_migrations (version) VALUES ('20160619195246');

INSERT INTO schema_migrations (version) VALUES ('20160619200009');

INSERT INTO schema_migrations (version) VALUES ('20160709225638');

INSERT INTO schema_migrations (version) VALUES ('20160804081128');

INSERT INTO schema_migrations (version) VALUES ('20160806085512');

INSERT INTO schema_migrations (version) VALUES ('20160910193421');

