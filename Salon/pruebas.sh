#!/bin/bash


PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

SERVICES_INFO=$($PSQL "select services.name, time, customers.name from appointments inner join customers using (customer_id) inner join services using (service_id) WHERE customer_id=6 AND service_id=1 AND time='11:30'")
men=$(echo $SERVICES_INFO | cut -d "|")
echo $men
echo $SERVICES_INFO 
men1=$(echo $SERVICES_INFO | cut -d "|" -f 2)
echo $men1

