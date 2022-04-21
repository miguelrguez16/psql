#!/bin/sh
#exportar BBDD de worldcup
pg_dump -cC --inserts -U freecodecamp worldcup > worldcup.sql
echo $?


