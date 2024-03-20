#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the rate of connections per second
get_mysql_connections_per_second() {
    # Attempt to get the value of connections
    connections=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Connections'" 2>/dev/null | awk '$1 == "Connections" {print $2}')

    # Check if connections value is retrieved
    if [ -z "$connections" ]; then
        connections=0
    fi

    # Print the output
    echo "{\"Connections\": $connections}"
}

# Get the connections per second
connections_per_second=$(get_mysql_connections_per_second)

# Print the output
echo "$connections_per_second"
