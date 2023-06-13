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