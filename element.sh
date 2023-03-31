#!/bin/bash

# Program that provides information about any element in the periodic table based on user input.

if [[ -z $1 ]]
then
  # print message and exit if no arguments provided.
  echo "Please provide an element as an argument."
fi
