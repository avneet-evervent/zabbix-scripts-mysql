#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the rate of connection errors caused by accept errors per second
get_mysql_accept_errors_per_second() {
    # Query MySQL for the value of connection errors caused by accept errors
    accept_errors_output=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Connection_errors_accept'" 2>/dev/null)
    
    # Extract the value of connection errors caused by accept errors
    accept_errors=$(echo "$accept_errors_output" | awk '$1 == "Connection_errors_accept" {print $2}')

    # Check if the output is empty
    if [ -z "$accept_errors" ]; then
        accept_errors=0
    fi

    # Print the output in JSON format
    echo "{\"Connection_errors_accept\": $accept_errors}"
}

# Get the rate of connection errors caused by accept errors per second
accept_errors_per_second=$(get_mysql_accept_errors_per_second)

# Print the output
echo "$accept_errors_per_second"
