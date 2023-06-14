/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

-- create table animals
CREATE TABLE animals (
    id int,
    name varchar(100),
    date_of_birth date,
    escape_attempts int,
    neutered boolean,
    weight_kg decimal(5,2)
);

-- Add a column species of type string to your animals table. Modify your schema.sql file.
ALTER TABLE animals ADD COLUMN species varchar(100);

-- Create a table named owners with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- full_name: string
-- age: integer

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name varchar(100),
    age int
);

-- Create a table named species with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name varchar(100)
);

-- Modify animals table set id as primary key and serial.:
-- Make sure that id is set as SERIAL PRIMARY KEY
-- Remove column species
-- Add column species_id which is a foreign key referencing species table
-- Add column owner_id which is a foreign key referencing the owners table

ALTER TABLE animals DROP COLUMN id;
ALTER TABLE animals ADD COLUMN id SERIAL PRIMARY KEY;
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id int;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id int;
ALTER TABLE animals ADD CONSTRAINT fk_owner FOREIGN KEY(owner_id) REFERENCES owners(id);

-- REVIEWER PLEASE IGNORE THIS COMMENT-----------------------------------
-- THESE CODES ARE FOR MOVING COLUMN TO BEGINNING OF TABLE:
    -- ALTER TABLE animals ADD COLUMN name1 varchar(100), ADD COLUMN dob DATE, ADD COLUMN escape int, ADD COLUMN neut boolean, ADD COLUMN wk decimal(5,2);
    -- UPDATE animals SET name1 = name, dob = date_of_birth, escape = escape_attempts, neut = neutered, wk = weight_kg;
    -- ALTER TABLE animals DROP COLUMN name, DROP COLUMN date_of_birth, DROP COLUMN escape_attempts, DROP COLUMN neutered, DROP COLUMN weight_kg;
    -- ALTER TABLE animals RENAME COLUMN name1 TO name;
    -- ALTER TABLE animals RENAME COLUMN dob TO date_of_birth;
    -- ALTER TABLE animals RENAME COLUMN escape TO escape_attempts;
    -- ALTER TABLE animals RENAME COLUMN neut TO neutered;
    -- ALTER TABLE animals RENAME COLUMN wk TO weight_kg;
