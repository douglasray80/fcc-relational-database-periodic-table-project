#!/bin/bash

# Program that provides information about any element in the periodic table based on user input.

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
  # print message and exit if no arguments provided.
  echo "Please provide an element as an argument."
  exit
elif [[ $1 =~ ^[1-9]$|^10$ ]]
then
  # if argument is a number between 1 - 10
  echo "Argument provided is valid"
  ELEMENT_RESULT=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number = $1")
elif [[ $1 =~ ^[A-Z][a-z]?$ ]]
then
  # if argument is two letters starting with an uppercase and ending with a lowercase 
  ELEMENT_RESULT=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol = '$1'")
else
  # query the db using element name
  ELEMENT_RESULT=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE name = '$1'")
fi

# if there is no valid result
if [[ -z $ELEMENT_RESULT ]]
then
  echo "I could not find that element in the database."
else
  echo $ELEMENT_RESULT
fi
