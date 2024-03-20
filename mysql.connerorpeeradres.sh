#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the rate of connection errors caused by peer address per second
get_mysql_peer_address_connection_errors() {
    # Query MySQL for the value of connection errors caused by peer address
    peer_errors_output=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Connection_errors_peer_address'" 2>/dev/null)
    
    # Extract the value of connection errors caused by peer address
    peer_errors=$(echo "$peer_errors_output" | awk '$1 == "Connection_errors_peer_address" {print $2}')

    # Check if the output is empty
    if [ -z "$peer_errors" ]; then
        peer_errors=0
    fi

    # Print the final output in JSON format
    echo "{\"Connection_errors_peer_address\": $peer_errors}"
}

# Get the rate of connection errors caused by peer address per second
peer_address_errors=$(get_mysql_peer_address_connection_errors)

# Print the output
echo "$peer_address_errors"
