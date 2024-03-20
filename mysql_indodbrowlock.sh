#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the value of InnoDB row lock time
get_innodb_row_lock_time() {
    # Query MySQL for the value of InnoDB row lock time and extract the value
    innodb_row_lock_time=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Innodb_row_lock_time'" 2>/dev/null | awk 'NR==2{print $2}')
    echo "{\"Innodb_row_lock_time\": $innodb_row_lock_time}"
}

# Get the value of InnoDB row lock time
innodb_row_lock_time=$(get_innodb_row_lock_time)

# Print the output
echo "$innodb_row_lock_time"
