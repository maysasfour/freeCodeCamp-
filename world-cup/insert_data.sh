#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
export PSQLRC=/dev/null
PSQL="${PSQL/psql /psql -X -q }"

# Rebuild the dataset so this import can be run repeatedly.
$PSQL "TRUNCATE TABLE games, teams RESTART IDENTITY" >/dev/null
declare -A TEAM_IDS
while IFS=, read -r YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  [[ $YEAR == "year" ]] && continue
  for TEAM in "$WINNER" "$OPPONENT"
  do
    if [[ -z ${TEAM_IDS[$TEAM]+present} ]]; then
      SAFE_TEAM=${TEAM//\'/\'\'}
      TEAM_IDS["$TEAM"]=$($PSQL "INSERT INTO teams(name) VALUES ('$SAFE_TEAM') RETURNING team_id")
    fi
  done
  $PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', ${TEAM_IDS[$WINNER]}, ${TEAM_IDS[$OPPONENT]}, $WINNER_GOALS, $OPPONENT_GOALS)" >/dev/null
done < games.csv
