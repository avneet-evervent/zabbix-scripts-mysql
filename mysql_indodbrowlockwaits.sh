#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the value of InnoDB row lock waits
get_innodb_row_lock_waits() {
    # Query MySQL for the value of InnoDB row lock waits and extract the value
    innodb_row_lock_waits=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Innodb_row_lock_waits'" 2>/dev/null | awk 'NR==2{print $2}')
    echo "{\"Innodb_row_lock_waits\": $innodb_row_lock_waits}"
}

# Get the value of InnoDB row lock waits
innodb_row_lock_waits=$(get_innodb_row_lock_waits)

# Print the output
echo "$innodb_row_lock_waits"
