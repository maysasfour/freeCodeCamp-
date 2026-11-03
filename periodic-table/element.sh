#! /bin/bash
if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
  exit 0
fi
PSQL="psql -X -q -U freecodecamp -d periodic_table --tuples-only --no-align -c"
ARG=${1//\'/\'\'}
if [[ $1 =~ ^[0-9]+$ ]]; then
  CONDITION="e.atomic_number=$1"
else
  CONDITION="e.symbol='$ARG' OR e.name='$ARG'"
fi
ELEMENT=$($PSQL "SELECT e.atomic_number,e.name,e.symbol,t.type,p.atomic_mass,p.melting_point_celsius,p.boiling_point_celsius FROM elements e JOIN properties p USING(atomic_number) JOIN types t USING(type_id) WHERE $CONDITION")
if [[ -z $ELEMENT ]]; then
  echo "I could not find that element in the database."
  exit 0
fi
IFS='|' read -r NUMBER NAME SYMBOL TYPE MASS MELTING BOILING <<< "$ELEMENT"
echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
