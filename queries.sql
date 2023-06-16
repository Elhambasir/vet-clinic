
/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name = 'Luna';

-- Find all animals whose name ends in "mon".
SELECT * from animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name from animals WHERE neutered = true AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth from animals WHERE name = 'Agumon' OR name = 'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name from animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * from animals WHERE neutered = true;

-- Find all animals not named Gabumon.
SELECT * from animals WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * from animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Inside a transaction update the animals table by setting the species column to unspecified.
-- Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.
BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT * from animals;
ROLLBACK;
SELECT * from animals;

-- Inside a transaction:
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
-- Verify that changes were made.
-- Commit the transaction.
-- Verify that changes persist after commit.
BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * from animals;
COMMIT;
SELECT * from animals;

-- Inside a transaction delete all records in the animals table, then roll back the transaction.
-- After the rollback verify if all records in the animals table still exists.
BEGIN TRANSACTION;
DELETE FROM animals;
ROLLBACK;
SELECT * from animals;

-- Inside a transaction:
-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction

BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT savepoint1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO savepoint1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- Write queries to answer the following questions:
-- How many animals are there?
SELECT COUNT(*) from animals;
-- How many animals have never tried to escape?
SELECT COUNT(*) from animals WHERE escape_attempts = 0;
-- What is the average weight of animals?
SELECT AVG(weight_kg) from animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, COUNT(escape_attempts) from animals GROUP BY neutered;
-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) from animals GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) from animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;


-- DAY 3 : JOINS --

-- Write queries (using JOIN) to answer the following questions:
-- What animals belong to Melody Pond?
-- List of all animals that are pokemon (their type is Pokemon).
-- List all owners and their animals, remember to include those that don't own any animal.
-- How many animals are there per species?
-- List all Digimon owned by Jennifer Orwell.
-- List all animals owned by Dean Winchester that haven't tried to escape.
-- Who owns the most animals?

SELECT name as 
animal_name, full_name as 
owner_name FROM 
animals JOIN 
owners ON 
animals.owner_id = owners.id WHERE 
owners.full_name = 'Melody Pond';

SELECT name as 
animal_name, species FROM
animals JOIN 
species ON 
animals.species_id = species.id WHERE
species.name = 'Pokemon';

SELECT full_name as 
owner_name, name as 
animal_name FROM 
owners LEFT JOIN
animals ON 
owners.id = animals.owner_id;

SELECT species.name as 
species_name, COUNT(animals.id) as 
number_of_animals FROM 
animals JOIN 
species ON 
animals.species_id = species.id GROUP BY 
species.name;

SELECT animals.name as 
animal_name FROM 
animals JOIN 
owners ON 
animals.owner_id = owners.id WHERE 
owners.full_name = 'Jennifer Orwell' AND 
animals.species_id = 1;

SELECT animals.name as 
animal_name FROM 
animals JOIN 
owners ON 
animals.owner_id = owners.id WHERE 
owners.full_name = 'Dean Winchester' AND 
animals.escape_attempts = 0;

SELECT owners.full_name as 
owner_name, COUNT(animals.id) as 
number_of_animals FROM 
animals JOIN 
owners ON 
animals.owner_id = owners.id GROUP BY 
owners.full_name ORDER BY 
number_of_animals DESC LIMIT 1;

-- DAY 4 : ADVANCED QUERIES --


-- Write queries to answer the following:
-- Who was the last animal seen by William Tatcher?
    SELECT animals.name,visits.date_of_visit FROM
    animals JOIN 
    visits ON 
    animals.id = visits.animal_id JOIN 
    vets ON 
    visits.vet_id = vets.id WHERE 
    vets.name = 'William Tatcher' ORDER BY 
    visits.date_of_visit DESC LIMIT 1;
    
-- How many different animals did Stephanie Mendez see?   
    SELECT COUNT(animal_id) FROM 
    visits JOIN 
    vets ON 
    visits.vet_id = vets.id WHERE 
    vets.name = 'Stephanie Mendez'; 
    
-- List all vets and their specialties, including vets with no specialties.
    SELECT vets.name, species.name FROM 
    vets LEFT JOIN 
    specializations ON 
    vets.id = specializations.vet_id LEFT JOIN
    species ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
    SELECT animals.name, visits.date_of_visit FROM 
    animals JOIN 
    visits ON 
    animals.id = visits.animal_id JOIN 
    vets ON 
    visits.vet_id = vets.id WHERE 
    vets.name = 'Stephanie Mendez' AND 
    visits.date_of_visit BETWEEN 
    '2020-04-01' AND 
    '2020-08-30';

-- What animal has the most visits to vets?
    SELECT animals.name, COUNT(visits.animal_id) FROM 
    animals JOIN 
    visits ON 
    animals.id = visits.animal_id GROUP BY 
    animals.name ORDER BY 
    COUNT(visits.animal_id) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
    SELECT animals.name, visits.date_of_visit FROM 
    animals JOIN 
    visits ON 
    animals.id = visits.animal_id JOIN
    vets ON 
    visits.vet_id = vets.id WHERE 
    vets.name = 'Maisy Smith' ORDER BY 
    visits.date_of_visit ASC LIMIT 1 ;

-- Details for most recent visit: animal information, vet information, and date of visit.
    SELECT animals.name as animal_name, vets.name as vet_name, visits.date_of_visit FROM 
    animals JOIN 
    visits ON 
    animals.id = visits.animal_id JOIN
    vets ON 
    visits.vet_id = vets.id ORDER BY 
    visits.date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
    SELECT COUNT(visits.date_of_visit) FROM 
    visits JOIN 
    vets ON 
    visits.vet_id = vets.id WHERE 
    vets.id NOT IN (SELECT specializations.vet_id FROM specializations);

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
    SELECT COUNT(visits.date_of_visit) as
     c, (SELECT 
     name FROM 
     species WHERE 
     id = (SELECT 
     species_id FROM 
     animals WHERE 
     id = animal_id)) FROM 
     visits WHERE 
     vet_id = (select 
     id from 
     vets WHERE 
     name = 'Maisy Smith') GROUP BY 
     animal_id ORDER BY 
     c DESC LIMIT 1 ; 
