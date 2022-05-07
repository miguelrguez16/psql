#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
ELEMENT_RESPONSE=$($PSQL "select atomic_number, symbol, name, atomic_mass,melting_point_celsius,boiling_point_celsius, type from elements inner join properties using (atomic_number) inner join types using(type_id) WHERE elements.atomic_number=1;")

echo $ELEMENT_RESPONSE
TRANSPONSE=$(echo $ELEMENT_RESPONSE | sed 's/ | /:/g' )
echo $TRANSPONSE
ATOMIC_NUMBER=$(echo $ELEMENT_RESPONSE | cut -d "|" -f 1)
echo $ATOMIC_NUMBER


MAN=3
if [[ $MAN -le 2 ]]
then
  echo ATOMIC_NUMBER
else
  echo NON_ATOMIC_NUMBER
fi



DOS=$($PSQL "select * from elements where symbol='he'")
echo $DOS