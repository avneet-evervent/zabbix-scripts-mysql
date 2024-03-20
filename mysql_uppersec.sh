#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the rate of UPDATE commands per second
get_mysql_update_commands_rate() {
    # Get the UPDATE commands count
    update_count=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Com_update'" 2>/dev/null | awk 'NR==2{print $2}')
    
    # Check if the update_count is not empty
    if [ -n "$update_count" ]; then
        # Print the output
        echo "{\"Com_update\": $update_count}"
    else
        # Print a default value
        echo "{\"Com_update\": 0}"
    fi
}

# Get the rate of UPDATE commands per second
update_commands_rate=$(get_mysql_update_commands_rate)

# Print the output
echo "$update_commands_rate"
