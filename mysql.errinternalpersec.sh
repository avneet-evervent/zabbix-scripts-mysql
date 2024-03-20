#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the rate of internal connection errors per second
get_mysql_internal_connection_errors_per_second() {
    # Query MySQL for the value of internal connection errors
    internal_errors_output=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Connection_errors_internal'" 2>/dev/null)
    
    # Extract the value of internal connection errors
    internal_errors=$(echo "$internal_errors_output" | awk '$1 == "Connection_errors_internal" {print $2}')

    # Check if the output is empty
    if [ -z "$internal_errors" ]; then
        internal_errors=0
    fi

    # Print the output in JSON format
    echo "{\"Connection_errors_internal\": $internal_errors}"
}

# Get the rate of internal connection errors per second
internal_errors_per_second=$(get_mysql_internal_connection_errors_per_second)

# Print the output
echo "$internal_errors_per_second"
