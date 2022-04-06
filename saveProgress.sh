#/bin/sh

echo "saving progress .."

pg_dump -cC --inserts -U freecodecamp universe > universe.sql
