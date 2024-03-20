#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Query MySQL for the value of connection errors caused by SELECT queries
select_errors_output=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Connection_errors_select'" 2>/dev/null)

# Extract the value of connection errors caused by SELECT queries
select_errors=$(echo "$select_errors_output" | awk '$1 == "Connection_errors_select" {print $2}')

# Check if the output is empty
if [ -z "$select_errors" ]; then
    select_errors=0
fi

# Print the final output in JSON format
echo "{\"Connection_errors_select\": $select_errors}"
