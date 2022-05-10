#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"


echo "Enter your username:"
read USER_NAME

SEARCH_USER_ID=$($PSQL "SELECT user_id FROM users WHERE name='$USER_NAME';")
NUMBER=$(( RANDOM % 75 + 1))

#echo $NUMBER
#está vacio
if [[ -z $SEARCH_USER_ID ]]
then
    # se registra
    INSERT_NEW_USER=$($PSQL "INSERT INTO users (name) VALUES ('$USER_NAME');")
    SEARCH_USER_ID=$($PSQL "SELECT user_id FROM users WHERE name='$USER_NAME';")

    echo "Welcome, $USER_NAME! It looks like this is your first time here."

else
    GAMES_PLAYED=$($PSQL "SELECT count(*) FROM games WHERE user_id=$SEARCH_USER_ID;")
    BEST_GAME=$($PSQL "SELECT MIN(number_attemps) FROM games WHERE user_id=$SEARCH_USER_ID;")
    echo "Welcome back, $USER_NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi



INPUT=0
NUMBER_ATTEMPS=0
echo "Guess the secret number between 1 and 1000:"
while [[ $INPUT -ne $NUMBER ]]
do
    read INPUT

    if [[ $INPUT =~ ^[0-9]+$ ]]
    then
        if [[ $INPUT -eq $NUMBER ]]
        then
            (( NUMBER_ATTEMPS++ ))
            echo "You guessed it in $NUMBER_ATTEMPS tries. The secret number was $NUMBER. Nice job!"
        elif [[ $INPUT -gt $NUMBER ]]
        then
            echo "It's lower than that, guess again:"
            (( NUMBER_ATTEMPS++ ))

        else
            echo "It's higher than that, guess again:"
            (( NUMBER_ATTEMPS++ ))

        fi
    else
      (( NUMBER_ATTEMPS++ ))
      echo "That is not an integer, guess again:"
    fi
    

done

INSERT_GAME=$($PSQL "INSERT INTO games (user_id, number_attemps, guessing_number) VALUES ($SEARCH_USER_ID,$NUMBER_ATTEMPS,$NUMBER);")
#echo $INSERT_GAME