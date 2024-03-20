#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the value of Open table definitions
get_open_table_definitions() {
    # Query MySQL for the value of Open table definitions and extract the value
    open_table_definitions=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Open_table_definitions'" 2>/dev/null | awk 'NR==2{print $2}')
    echo "{\"Open_table_definitions\": $open_table_definitions}"
}

# Get the value of Open table definitions
open_table_definitions=$(get_open_table_definitions)

# Print the output
echo "$open_table_definitions"

