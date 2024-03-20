#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the number of InnoDB buffer pool read requests
get_innodb_buffer_pool_read_requests() {
    # Query MySQL for the number of InnoDB buffer pool read requests and extract the value
    innodb_buffer_pool_read_requests=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_read_requests'" 2>/dev/null | awk 'NR==2{print $2}')
    echo "{\"Innodb_buffer_pool_read_requests\": $innodb_buffer_pool_read_requests}"
}

# Get the number of InnoDB buffer pool read requests
innodb_buffer_pool_read_requests=$(get_innodb_buffer_pool_read_requests)

# Print the output
echo "$innodb_buffer_pool_read_requests"
