#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals+opponent_goals) FROM games")"


echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"


echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals),2) FROM games")"


echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT (AVG(winner_goals+opponent_goals)) AS AVG FROM games")"


echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(winner_goals) FROM games")"


echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT count(*) FROM games WHERE winner_goals>2")"


echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT name FROM teams where team_id=(SELECT winner_id FROM games where round ilike 'final' AND year='2018')")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT t.name FROM games as g full join teams as t on g.winner_id = t.team_id where g.year='2014' AND g.round ilike 'eighth-final' UNION SELECT t.name from games as g inner join teams as t on g.opponent_id=t.team_id where g.round ilike 'eighth-final' and g.year='2014'")"


echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT DISTINCT(t.name) FROM games as g inner join teams as t on g.winner_id = t.team_id ORDER BY t.name ASC")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT g.year, t.name FROM games as g inner join teams as t on g.winner_id = t.team_id WHERE g.round like 'Final' ORDER BY g.year ASC")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT t.name FROM games as g full join teams as t on g.winner_id = t.team_id where t.name like 'Co%' UNION SELECT t.name from games as g inner join teams as t on g.opponent_id=t.team_id where t.name like 'Co%'")"

