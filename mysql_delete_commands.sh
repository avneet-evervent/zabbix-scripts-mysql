#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the rate of DELETE commands per second
get_mysql_delete_commands_rate() {
    # Get the initial number of DELETE commands executed
    initial_delete_count=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Com_delete'" 2>/dev/null | awk 'NR==2{print $2}')
    sleep 1 # Wait for a short time to ensure accurate measurement
    # Get the final number of DELETE commands executed
    final_delete_count=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Com_delete'" 2>/dev/null | awk 'NR==2{print $2}')
    # Calculate the rate per second
    delete_rate=$((final_delete_count - initial_delete_count))
    echo "{\"Com_delete\": $delete_rate}"
}

# Get the rate of DELETE commands per second
delete_commands_rate=$(get_mysql_delete_commands_rate)

# Print the output
echo "$delete_commands_rate"
