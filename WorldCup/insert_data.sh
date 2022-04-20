#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE games, teams")
echo "Status truncate $?"

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]]
  then
    # get WINNER_ID
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    # existe?
    if [[ -z $WINNER_ID ]]
    then
      # NO EXISTE EL EQUIPO, introducimos
      INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")

      if [[ $INSERT_WINNER_RESULT == "INSERT 0 1" ]]
      then
          echo Inserted into teams, $WINNER
      fi

        # get new WINNER_ID
        WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    fi
    
    # get OPPONENT_ID
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    if [[ -z $OPPONENT_ID ]]
    then
      # NO EXISTE EL EQUIPO, introducimos
        INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")

        if [[ $INSERT_OPPONENT_RESULT == "INSERT 0 1" ]]
        then
          echo Inserted into teams, $OPPONENT
        fi

        # get OPPONENT_ID
        OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    fi
    
    echo "$WINNER vs $OPPONENT  [$WINNER_ID vs $OPPONENT_ID ]"

    # equipo metido
    #existe el partido?
    GAME_ID=$($PSQL "SELECT game_id FROM games WHERE winner_id=$WINNER_ID AND opponent_id=$OPPONENT_ID")
    if [[ -z $GAME_ID ]]
    then
      echo "NO EXISTE EL PARTIDO"
      INSERT_GAME_RESUTL=$($PSQL "INSERT INTO games (year,round, winner_id,opponent_id, winner_goals, opponent_goals) VALUES ('$YEAR','$ROUND', $WINNER_ID,$OPPONENT_ID,$WINNER_GOALS,$OPPONENT_GOALS);")
      if [[ $INSERT_GAME_RESUTL == "INSERT 0 1" ]]
        then
          echo "Inserted into games, $WINNER vs $OPPONENT"
      fi
    fi

    

  fi
done

echo $($PSQL "SELECT * FROM teams;")
echo $($PSQL "SELECT * FROM games;")

