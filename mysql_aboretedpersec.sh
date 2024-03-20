#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Sleep interval in seconds
SLEEP_INTERVAL=1

# Function to retrieve the rate of aborted clients per second
get_aborted_clients_rate() {
    # Get the initial number of aborted clients
    initial_aborted_clients=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Aborted_clients'" 2>/dev/null | awk 'NR==2{print $2}')
    sleep $SLEEP_INTERVAL # Wait for a short time to ensure accurate measurement
    # Get the final number of aborted clients
    final_aborted_clients=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Aborted_clients'" 2>/dev/null | awk 'NR==2{print $2}')
    # Calculate the rate per second
    aborted_clients_rate=$((final_aborted_clients - initial_aborted_clients))
    echo "{\"Aborted_clients\": $aborted_clients_rate}"
}

# Get the rate of aborted clients per second
aborted_clients_rate=$(get_aborted_clients_rate)

# Print the output
echo "$aborted_clients_rate"
