#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the value of InnoDB row lock time max
get_innodb_row_lock_time_max() {
    # Query MySQL for the value of InnoDB row lock time max and extract the value
    innodb_row_lock_time_max=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Innodb_row_lock_time_max'" 2>/dev/null | awk 'NR==2{print $2}')
    echo "{\"Innodb_row_lock_time_max\": $innodb_row_lock_time_max}"
}

# Get the value of InnoDB row lock time max
innodb_row_lock_time_max=$(get_innodb_row_lock_time_max)

# Print the output
echo "$innodb_row_lock_time_max"
