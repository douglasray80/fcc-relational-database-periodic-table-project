#!/bin/bash

# Program that provides information about any element in the periodic table based on user input.

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
  # print message and exit if no arguments provided.
  echo "Please provide an element as an argument."
elif [[ $1 =~ ^[1-9]$|^10$ ]]
then
  # if argument is a number between 1 - 10
  echo "Argument provided is valid"
  ELEMENT_RESULT=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) WHERE atomic_number = $1")
elif [[ $1 =~ ^[A-Z][a-z]?$ ]]
then
  # if argument is two letters starting with an uppercase and ending with a lowercase 
  ELEMENT_RESULT=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) WHERE symbol = '$1'")
else
  echo "Invalid argument"
fi

if [[ -z $ELEMENT_RESULT ]]
then
  echo "I could not find that element in the database."
else
  echo "$ELEMENT_RESULT"
fi
