#!/bin/bash


PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
COUNT=$(echo "$1" | wc -m)-1
 # echo "cantidad $COUNT ($1)"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  # Es un numero
  if [[ $1 =~ ^[0-9]+$ ]]
  then
      #  echo "1 y $1"

    ELEMENT_RESPONSE=$($PSQL "select atomic_number, symbol, name, atomic_mass,melting_point_celsius,boiling_point_celsius, type from elements inner join properties using (atomic_number) inner join types using(type_id) WHERE elements.atomic_number=$1;")
    if [[ -z $ELEMENT_RESPONSE ]]
    then
      echo "I could not find that element in the database."
    else
      TRANSPONSE=$(echo $ELEMENT_RESPONSE | sed 's/ | /:/g' )
      ATOMIC_NUMBER=$(echo $TRANSPONSE | cut -d ":" -f 1)
      SYMBOL=$(echo $TRANSPONSE | cut -d ":" -f 2)
      NAME=$(echo $TRANSPONSE | cut -d ":" -f 3)
      MASS=$(echo $TRANSPONSE | cut -d ":" -f 4)
      MELTING_POINT=$(echo $TRANSPONSE | cut -d ":" -f 5)
      BOILING_POINT=$(echo $TRANSPONSE | cut -d ":" -f 6)
      TYPE=$(echo $TRANSPONSE | cut -d ":" -f 7)
     
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi
  elif [[ $COUNT -le 2 ]]
  then
    #echo "2 y $1"
    ELEMENT_RESPONSE=$($PSQL "select atomic_number, symbol, name, atomic_mass,melting_point_celsius,boiling_point_celsius, type from elements inner join properties using (atomic_number) inner join types using(type_id) WHERE symbol='$1';")
    if [[ -z $ELEMENT_RESPONSE ]]
    then
      echo "I could not find that element in the database."
    else
      TRANSPONSE=$(echo $ELEMENT_RESPONSE | sed 's/ | /:/g' )
      ATOMIC_NUMBER=$(echo $TRANSPONSE | cut -d ":" -f 1)
      SYMBOL=$(echo $TRANSPONSE | cut -d ":" -f 2)
      NAME=$(echo $TRANSPONSE | cut -d ":" -f 3)
      MASS=$(echo $TRANSPONSE | cut -d ":" -f 4)
      MELTING_POINT=$(echo $TRANSPONSE | cut -d ":" -f 5)
      BOILING_POINT=$(echo $TRANSPONSE | cut -d ":" -f 6)
      TYPE=$(echo $TRANSPONSE | cut -d ":" -f 7)
     
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi
  else
     #  echo "3 y $1"

    ELEMENT_RESPONSE=$($PSQL "select atomic_number, symbol, name, atomic_mass,melting_point_celsius,boiling_point_celsius, type from elements inner join properties using (atomic_number) inner join types using(type_id) WHERE name='$1';")
    if [[ -z $ELEMENT_RESPONSE ]]
    then
      echo "I could not find that element in the database."
    else
      TRANSPONSE=$(echo $ELEMENT_RESPONSE | sed 's/ | /:/g' )
      ATOMIC_NUMBER=$(echo $TRANSPONSE | cut -d ":" -f 1)
      SYMBOL=$(echo $TRANSPONSE | cut -d ":" -f 2)
      NAME=$(echo $TRANSPONSE | cut -d ":" -f 3)
      MASS=$(echo $TRANSPONSE | cut -d ":" -f 4)
      MELTING_POINT=$(echo $TRANSPONSE | cut -d ":" -f 5)
      BOILING_POINT=$(echo $TRANSPONSE | cut -d ":" -f 6)
      TYPE=$(echo $TRANSPONSE | cut -d ":" -f 7)
     
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi
  fi
  
fi