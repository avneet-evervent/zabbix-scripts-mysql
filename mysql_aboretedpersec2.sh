#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Sleep interval in seconds
SLEEP_INTERVAL=1

# Function to retrieve the rate of aborted connections per second
get_aborted_connections_rate() {
    # Get the initial number of aborted connections
    initial_aborted_connections=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Aborted_connects'" 2>/dev/null | awk 'NR==2{print $2}')
    sleep $SLEEP_INTERVAL # Wait for a short time to ensure accurate measurement
    # Get the final number of aborted connections
    final_aborted_connections=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Aborted_connects'" 2>/dev/null | awk 'NR==2{print $2}')
    # Calculate the rate per second
    aborted_connections_rate=$((final_aborted_connections - initial_aborted_connections))
    echo "{\"Aborted_connects\": $aborted_connections_rate}"
}

# Get the rate of aborted connections per second
aborted_connections_rate=$(get_aborted_connections_rate)

# Print the output
echo "$aborted_connections_rate"
