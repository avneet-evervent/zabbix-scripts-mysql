#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to execute MySQL query
execute_mysql_query() {
    local query="$1"
    mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "$query" 2>/dev/null
}

# Function to retrieve a single MySQL value
get_mysql_value() {
    local query="$1"
    local value=$(execute_mysql_query "$query" | awk 'NR==2{print $2}')
    echo "$value"
}

# Function to retrieve InnoDB buffer pool read requests per second
get_innodb_buffer_pool_read_requests_per_sec() {
    local query="SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_read_requests'"
    local read_requests=$(get_mysql_value "$query")
    echo "$read_requests"
}

# Get InnoDB buffer pool read requests per second
innodb_buffer_pool_read_requests_per_sec=$(get_innodb_buffer_pool_read_requests_per_sec)

# Print the output
echo "{\"Innodb_buffer_pool_read_requests\": $innodb_buffer_pool_read_requests_per_sec}"
