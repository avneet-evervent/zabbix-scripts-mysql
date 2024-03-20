#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the rate of SELECT commands per second
get_mysql_select_commands_rate() {
    # Get the SELECT commands count
    select_count=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Com_select'" 2>/dev/null | awk 'NR==2{print $2}')
    
    # Check if the select_count is not empty
    if [ -n "$select_count" ]; then
        # Print the output
        echo "{\"Com_select\": $select_count}"
    else
        # Print a default value
        echo "{\"Com_select\": 0}"
    fi
}

# Get the rate of SELECT commands per second
select_commands_rate=$(get_mysql_select_commands_rate)

# Print the output
echo "$select_commands_rate"
