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





