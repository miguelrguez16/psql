#!/bin/bash


PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Bike Rental Shop ~~~~~\n"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo "Our Services:" 
  SERVICES=$($PSQL "select * from services ")
  echo "$SERVICES" | while read SERVICE_ID BAR NAME_SERVICE
  do
    echo "$SERVICE_ID) $NAME_SERVICE"
  done

  echo -e "\nWhich service would you take?"
  read SERVICE_ID_SELECTED

  #check if input is a number
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
  then
    #is NOT A NUMBER
    MAIN_MENU "That is not a valid services number."
  else
    # is a number
    # existe el servicio
    SERVICE_AVAILABLE==$($PSQL "select * from services where service_id=$SERVICE_ID_SELECTED")

     # if not available
    if [[ -z $SERVICE_AVAILABLE ]]
    then
      # send to main menu
      MAIN_MENU "That service is not available."
    else
      # get  info
      echo -e "\nWhat's your phone number?"
      read CUSTOMER_PHONE

      CUSTOMER_NAME=$($PSQL  "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")

       # if customer doesn't exist
      if [[ -z $CUSTOMER_NAME ]]
      then
        # get new customer name
        echo -e "\nWhat's your name?"
        read CUSTOMER_NAME

        # insert new customer
        INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')") 
      fi

      # get customer_id
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

      echo -e "\nTime for yor service?"
      read SERVICE_TIME

      INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

      SERVICES_INFO=$($PSQL "select services.name from appointments inner join customers using (customer_id) inner join services using (service_id) WHERE customer_id=$CUSTOMER_ID AND service_id=$SERVICE_ID_SELECTED AND time='$SERVICE_TIME'") 
      echo "I have put you down for a $SERVICES_INFO at $SERVICE_TIME, $CUSTOMER_NAME."
    fi
  fi
}

MAIN_MENU 
