#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve MySQL status
get_mysql_status() {
    # Query MySQL for status variables and extract the desired variables
    mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS" 2>/dev/null | awk '{printf "%-30s %s\n", $1, $2}'
}

# Get MySQL status
status=$(get_mysql_status)

# Print the output
echo "MySQL is Running:"
echo "$status"
