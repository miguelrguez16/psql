#!/bin/sh
#exportar BBDD de students
pg_dump -cC --inserts -U freecodecamp students > students.sql
echo $?

#   50  pg_dump --clean --create --inserts --username=freecodecamp students > students.sql

