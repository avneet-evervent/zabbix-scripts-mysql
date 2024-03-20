#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the rate of INSERT commands per second
get_mysql_insert_commands_rate() {
    # Get the initial number of INSERT commands executed
    initial_insert_count=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Com_insert'" 2>/dev/null | awk 'NR==2{print $2}')
    sleep 1 # Wait for a short time to ensure accurate measurement
    # Get the final number of INSERT commands executed
    final_insert_count=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Com_insert'" 2>/dev/null | awk 'NR==2{print $2}')
    # Calculate the rate per second
    insert_rate=$((final_insert_count - initial_insert_count))
    echo "{\"Com_insert\": $insert_rate}"
}

# Get the rate of INSERT commands per second
insert_commands_rate=$(get_mysql_insert_commands_rate)

# Print the output
echo "$insert_commands_rate"
