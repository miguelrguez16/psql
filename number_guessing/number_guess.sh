#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"


echo -e "\nEnter your username:"
read USER_NAME

SEARCH_USER_ID=$($PSQL "SELECT user_id FROM users WHERE name='$USER_NAME';")
NUMBER=$(( RANDOM % 75 + 1))

echo $NUMBER

#está vacio
if [[ -z $SEARCH_USER_ID ]]
then
    # se registra
    echo $SEARCH_USER_ID 
    echo vacio
    INSERT_NEW_USER=$($PSQL "INSERT INTO users (name) VALUES ('$USER_NAME');")
    SEARCH_USER_ID=$($PSQL "SELECT user_id FROM users WHERE name='$USER_NAME';")

    echo -e "\nWelcome, $USER_NAME! It looks like this is your first time here.:"

else
    GAMES_PLAYED=$($PSQL "SELECT count(*) FROM games WHERE user_id=$SEARCH_USER_ID;")
    BEST_GAME=$($PSQL "SELECT MIN(number_attemps) FROM games WHERE user_id=$SEARCH_USER_ID;")
    echo -e "\nWelcome back, $USER_NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi


INPUT_NUMER=0
NUMBER_ATTEMPS=0
echo -e "\nGuess the secret number between 1 and 1000:"
while [[ $INPUT_NUMER -ne $NUMBER ]]
do
    read INPUT_NUMER
    if [[ $1 =~ ^[0-9]+$ ]]
    then
        echo -e "\nThat is not an integer, guess again:"
    else
        if [[ $INPUT_NUMER -eq $NUMBER ]]
        then
            echo
        elif [[ $INPUT_NUMER -lt $NUMBER ]]
        then
            echo -e "\nIt's lower than that, guess again:"
        else
            echo -e "\nIt's higher than that, guess again:"
        fi
    fi

    (( NUMBER_ATTEMPS++ ))
    sleep 1
done

echo -e "\nYou guessed it in $NUMBER_ATTEMPS tries. The secret number was $NUMBER. Nice job!"

INSERT_GAME=$($PSQL "INSERT INTO games (user_id, number_attemps, guessing_number) VALUES ($SEARCH_USER_ID,$NUMBER_ATTEMPS,$NUMBER);")
echo $INSERT_GAME