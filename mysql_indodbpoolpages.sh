#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the total number of InnoDB buffer pool pages
get_innodb_buffer_pool_pages_total() {
    # Query MySQL for the total number of InnoDB buffer pool pages and extract the value
    innodb_buffer_pool_pages_total=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_pages_total'" 2>/dev/null | awk 'NR==2{print $2}')
    echo "{\"Innodb_buffer_pool_pages_total\": $innodb_buffer_pool_pages_total}"
}

# Get the total number of InnoDB buffer pool pages
innodb_buffer_pool_pages_total=$(get_innodb_buffer_pool_pages_total)

# Print the output
echo "$innodb_buffer_pool_pages_total"
