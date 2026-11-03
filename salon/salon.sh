#! /bin/bash
PSQL="psql -X -q --username=freecodecamp --dbname=salon --tuples-only --no-align -c"
escape_sql() { printf '%s' "${1//\'/\'\'}"; }
echo -e "\n~~~~~ SALON ~~~~~\n"
echo "Welcome to the salon. Which service would you like?"
while true
do
  while IFS='|' read -r SERVICE_ID SERVICE_NAME
  do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done < <($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
  read SERVICE_ID_SELECTED || exit 0
  if [[ $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]; then
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
    [[ -n $SERVICE_NAME ]] && break
  fi
  echo "I could not find that service. Please choose from this list:"
done
echo "What's your phone number?"
read CUSTOMER_PHONE || exit 0
SAFE_PHONE=$(escape_sql "$CUSTOMER_PHONE")
CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$SAFE_PHONE'")
if [[ -z $CUSTOMER_NAME ]]; then
  echo "I don't have a record for that phone number. What's your name?"
  read CUSTOMER_NAME || exit 0
  SAFE_NAME=$(escape_sql "$CUSTOMER_NAME")
  $PSQL "INSERT INTO customers(phone, name) VALUES ('$SAFE_PHONE', '$SAFE_NAME')" >/dev/null
fi
CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$SAFE_PHONE'")
echo "What time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
read SERVICE_TIME || exit 0
SAFE_TIME=$(escape_sql "$SERVICE_TIME")
$PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SAFE_TIME')" >/dev/null
echo "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
