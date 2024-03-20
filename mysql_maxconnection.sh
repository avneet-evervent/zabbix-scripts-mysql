#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Execute MySQL query directly and extract the value of Max_used_connections
max_used_connections=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Max_used_connections';" 2>/dev/null | awk 'NR==2{print $2}')

# Format the output as JSON
output="{\"Max_used_connections\": $max_used_connections}"

# Output the formatted JSON
echo "$output"
