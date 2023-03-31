#!/bin/bash

# Program that provides information about any element in the periodic table based on user input.

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

# save query to variable to avoid repetition in if elif statement
QUERY="SELECT atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id)"

# assign query search filter based on arguments provided
if [[ -z $1 ]]
then
  # print message and exit if no arg
  echo "Please provide an element as an argument."
  exit
elif [[ $1 =~ ^[1-9]$|^10$ ]]
then
  # if argument is a number between 1 - 10
  SEARCH_FILTER="WHERE atomic_number = $1"
elif [[ $1 =~ ^[A-Z][a-z]?$ ]]
then
  # if argument is two letters starting with an uppercase and ending with a lowercase 
  SEARCH_FILTER="WHERE symbol = '$1'"
else
  # filter using element name
  SEARCH_FILTER="WHERE name = '$1'"
fi

# query the database
ELEMENT_SEARCH_RESULT=$($PSQL "$QUERY $SEARCH_FILTER")

# if there is no valid result
if [[ -z $ELEMENT_SEARCH_RESULT ]]
then
  echo "I could not find that element in the database."
else
  # if there is a result, print the data as formatted output
  echo "$ELEMENT_SEARCH_RESULT" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE
  do
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
fi
