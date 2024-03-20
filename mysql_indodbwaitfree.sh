#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the value of Innodb buffer pool wait free
get_innodb_buffer_pool_wait_free() {
    # Query MySQL for the value of Innodb buffer pool wait free and extract the value
    innodb_buffer_pool_wait_free=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_wait_free'" 2>/dev/null | awk 'NR==2{print $2}')
    echo "{\"Innodb_buffer_pool_wait_free\": $innodb_buffer_pool_wait_free}"
}

# Get the value of Innodb buffer pool wait free
innodb_buffer_pool_wait_free=$(get_innodb_buffer_pool_wait_free)

# Print the output
echo "$innodb_buffer_pool_wait_free"
