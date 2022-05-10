#/bin/bash


NUMBER=$(( RANDOM % 1000 + 1))

echo $NUMBER

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"


ALL=$($PSQL "select * from users inner join games using (user_id);")
echo $ALL
