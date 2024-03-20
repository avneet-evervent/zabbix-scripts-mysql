#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the value of Open tables
get_open_tables() {
    # Query MySQL for the value of Open tables and extract the value
    open_tables=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Open_tables'" 2>/dev/null | awk 'NR==2{print $2}')
    echo "{\"Open_tables\": $open_tables}"
}

# Get the value of Open tables
open_tables=$(get_open_tables)

# Print the output
echo "$open_tables"
