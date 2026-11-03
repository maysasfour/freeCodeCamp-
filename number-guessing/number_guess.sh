#!/bin/bash
PSQL="psql -X -q -U freecodecamp -d number_guess --tuples-only --no-align -c"
echo "Enter your username:"
read -r USERNAME || exit 0
SAFE_USERNAME=${USERNAME//\'/\'\'}
USER_ROW=$($PSQL "SELECT user_id,games_played,COALESCE(best_game,0) FROM users WHERE username='$SAFE_USERNAME'")
if [[ -z $USER_ROW ]]; then
  USER_ID=$($PSQL "INSERT INTO users(username) VALUES ('$SAFE_USERNAME') RETURNING user_id")
  echo "Welcome, $USERNAME! It looks like this is your first time here."
else
  IFS='|' read -r USER_ID GAMES_PLAYED BEST_GAME <<< "$USER_ROW"
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi
SECRET_NUMBER=$((RANDOM % 1000 + 1))
NUMBER_OF_GUESSES=0
echo "Guess the secret number between 1 and 1000:"
while read -r GUESS
do
  ((NUMBER_OF_GUESSES++))
  if [[ ! $GUESS =~ ^-?[0-9]+$ ]]; then
    echo "That is not an integer, guess again:"
  elif [ "$GUESS" -gt "$SECRET_NUMBER" ]; then
    echo "It's lower than that, guess again:"
  elif [ "$GUESS" -lt "$SECRET_NUMBER" ]; then
    echo "It's higher than that, guess again:"
  else
    break
  fi
done
[[ -z $GUESS ]] && exit 0
$PSQL "BEGIN; INSERT INTO games(user_id,guesses) VALUES ($USER_ID,$NUMBER_OF_GUESSES); UPDATE users SET games_played=games_played+1,best_game=LEAST(COALESCE(best_game,$NUMBER_OF_GUESSES),$NUMBER_OF_GUESSES) WHERE user_id=$USER_ID; COMMIT;" >/dev/null
echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
