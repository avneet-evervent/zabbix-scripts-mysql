#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the number of free InnoDB buffer pool pages
get_innodb_buffer_pool_pages_free() {
    # Query MySQL for the number of free InnoDB buffer pool pages and extract the value
    innodb_buffer_pool_pages_free=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_pages_free'" 2>/dev/null | awk 'NR==2{print $2}')
    # Check if the value is empty, if so, set it to 0
    if [ -z "$innodb_buffer_pool_pages_free" ]; then
        innodb_buffer_pool_pages_free=0
    fi
    echo "{\"Innodb_buffer_pool_pages_free\": $innodb_buffer_pool_pages_free}"
}

# Get the number of free InnoDB buffer pool pages
innodb_buffer_pool_pages_free=$(get_innodb_buffer_pool_pages_free)

# Print the output
echo "$innodb_buffer_pool_pages_free"
