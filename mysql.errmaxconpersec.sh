#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the rate of connection errors caused by max connections per second
get_mysql_max_connections_errors_per_second() {
    # Query MySQL for the value of connection errors caused by max connections
    max_connections_errors_output=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Max_used_connections'" 2>/dev/null)

    # Extract the value of max used connections
    max_connections_errors=$(echo "$max_connections_errors_output" | awk '$1 == "Max_used_connections" {print $2}')

    # Check if the output is empty or not
    if [ -z "$max_connections_errors" ]; then
        max_connections_errors=0
    fi

    # Print the final output in JSON format with the correct key
    echo "{\"Connection_errors_max_connections\": $max_connections_errors}"
}

# Get the rate of connection errors caused by max connections per second
max_connections_errors_per_sec=$(get_mysql_max_connections_errors_per_second)

# Print the output
echo "$max_connections_errors_per_sec"
