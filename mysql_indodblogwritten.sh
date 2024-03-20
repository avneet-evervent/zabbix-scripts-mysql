#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the value of Innodb log written
get_innodb_log_written() {
    # Query MySQL for the value of Innodb log written and extract the value
    innodb_log_written=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Innodb_os_log_written'" 2>/dev/null | awk 'NR==2{print $2}')
    echo "{\"Innodb_os_log_written\": $innodb_log_written}"
}

# Get the value of Innodb log written
innodb_log_written=$(get_innodb_log_written)

# Print the output
echo "$innodb_log_written"

