-- creating re_sales_dw datawarehouse

-- Drop existing tables and sequences if they exist
DROP TABLE IF EXISTS public.fact_sales;
DROP TABLE IF EXISTS public.dim_list_year;
DROP TABLE IF EXISTS public.dim_location;
DROP TABLE IF EXISTS public.dim_non_use_code;
DROP TABLE IF EXISTS public.dim_property_type;
DROP TABLE IF EXISTS public.dim_sale_date;

DROP SEQUENCE IF EXISTS public.dim_location_id_seq;
DROP SEQUENCE IF EXISTS public.dim_non_use_code_id_seq;
DROP SEQUENCE IF EXISTS public.dim_property_type_id_property_type_seq;
DROP SEQUENCE IF EXISTS public.dim_sale_date_id_sale_date_seq;

-- Create Sequences for Auto-increment

-- Sequence for dim_location
CREATE SEQUENCE public.dim_location_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

-- Sequence for dim_non_use_code
CREATE SEQUENCE public.dim_non_use_code_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

-- Sequence for dim_property_type
CREATE SEQUENCE public.dim_property_type_id_property_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

-- Sequence for dim_sale_date
CREATE SEQUENCE public.dim_sale_date_id_sale_date_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

-- Create Dimension Tables

-- Dimension Table: dim_list_year
CREATE TABLE public.dim_list_year (
    year integer NOT NULL,
    CONSTRAINT dim_list_year_pkey PRIMARY KEY (year)
);

-- Dimension Table: dim_location
CREATE TABLE public.dim_location (
    id integer NOT NULL DEFAULT nextval('public.dim_location_id_seq'::regclass),
    city character varying(255) NOT NULL,
    street_address character varying(255) NOT NULL,
    CONSTRAINT dim_location_pkey PRIMARY KEY (id),
    CONSTRAINT dim_location_city_street_address_key UNIQUE (city, street_address)
);

-- Dimension Table: dim_non_use_code
CREATE TABLE public.dim_non_use_code (
    id integer NOT NULL DEFAULT nextval('public.dim_non_use_code_id_seq'::regclass),
    title character varying(255) NOT NULL,
    description text,
    CONSTRAINT dim_non_use_code_pkey PRIMARY KEY (id)
);

-- Dimension Table: dim_property_type
CREATE TABLE public.dim_property_type (
    id_property_type integer NOT NULL DEFAULT nextval('public.dim_property_type_id_property_type_seq'::regclass),
    property_type character varying(255) NOT NULL,
    residential_type character varying(255),
    CONSTRAINT dim_property_type_pkey PRIMARY KEY (id_property_type),
    CONSTRAINT dim_property_type_property_type_residential_type_key UNIQUE (property_type, residential_type)
);

-- Dimension Table: dim_sale_date
CREATE TABLE public.dim_sale_date (
    id_sale_date integer NOT NULL DEFAULT nextval('public.dim_sale_date_id_sale_date_seq'::regclass),
    day integer,
    month integer,
    year integer NOT NULL,
    quarter integer,
    sale_date date,
    CONSTRAINT dim_sale_date_pkey PRIMARY KEY (id_sale_date),
    CONSTRAINT dim_sale_date_day_check CHECK (((day >= 1) AND (day <= 31))),
    CONSTRAINT dim_sale_date_month_check CHECK (((month >= 1) AND (month <= 12))),
    CONSTRAINT dim_sale_date_quarter_check CHECK (((quarter >= 1) AND (quarter <= 4))),
    CONSTRAINT dim_sale_date_day_month_year_quarter_key UNIQUE (day, month, year, quarter)
);

-- Create Fact Table: fact_sales
CREATE TABLE public.fact_sales (
    id_list_year integer,
    id_location integer,
    id_property_type integer,
    id_non_use_code integer,
    id_sale_date integer,
    assessed_value numeric(15,4),
    sale_amount numeric(15,4),
    sales_ratio numeric(15,4),
    CONSTRAINT unique_fact_sales UNIQUE (id_list_year, id_location, id_property_type, id_non_use_code, id_sale_date),
    CONSTRAINT fact_sales_id_list_year_fkey FOREIGN KEY (id_list_year) REFERENCES public.dim_list_year(year),
    CONSTRAINT fact_sales_id_location_fkey FOREIGN KEY (id_location) REFERENCES public.dim_location(id),
    CONSTRAINT fact_sales_id_non_use_code_fkey FOREIGN KEY (id_non_use_code) REFERENCES public.dim_non_use_code(id),
    CONSTRAINT fact_sales_id_property_type_fkey FOREIGN KEY (id_property_type) REFERENCES public.dim_property_type(id_property_type),
    CONSTRAINT fact_sales_id_sale_date_fkey FOREIGN KEY (id_sale_date) REFERENCES public.dim_sale_date(id_sale_date)
);

-- Set Default Values for Sequences (to ensure the default value works correctly)
ALTER TABLE ONLY public.dim_location ALTER COLUMN id SET DEFAULT nextval('public.dim_location_id_seq'::regclass);
ALTER TABLE ONLY public.dim_non_use_code ALTER COLUMN id SET DEFAULT nextval('public.dim_non_use_code_id_seq'::regclass);
ALTER TABLE ONLY public.dim_property_type ALTER COLUMN id_property_type SET DEFAULT nextval('public.dim_property_type_id_property_type_seq'::regclass);
ALTER TABLE ONLY public.dim_sale_date ALTER COLUMN id_sale_date SET DEFAULT nextval('public.dim_sale_date_id_sale_date_seq'::regclass);