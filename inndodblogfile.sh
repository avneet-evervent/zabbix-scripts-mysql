#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to execute MySQL query
execute_mysql_query() {
    local query="$1"
    mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -N -s -e "$query" 2>/dev/null
}

# Function to retrieve the calculated value of innodb_log_file_size
get_innodb_log_file_size() {
    local query="SELECT @@innodb_log_file_size;"
    local log_file_size=$(execute_mysql_query "$query")
    echo "$log_file_size"
}

# Get the calculated value of innodb_log_file_size
innodb_log_file_size=$(get_innodb_log_file_size)

# Print the output
echo "$innodb_log_file_size"
