#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the total number of InnoDB buffer pool reads
get_innodb_buffer_pool_reads() {
    # Query MySQL for the total number of InnoDB buffer pool reads and extract the value
    innodb_buffer_pool_reads=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_reads'" 2>/dev/null | awk 'NR==2{print $2}')
    echo "{\"Innodb_buffer_pool_reads\": $innodb_buffer_pool_reads}"
}

# Get the total number of InnoDB buffer pool reads
innodb_buffer_pool_reads=$(get_innodb_buffer_pool_reads)

# Print the output
echo "$innodb_buffer_pool_reads"
