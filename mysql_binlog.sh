#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the value of Binlog cache disk use
get_binlog_cache_disk_use() {
    # Query MySQL for the value of Binlog cache disk use and extract the value
    binlog_cache_disk_use=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Binlog_cache_disk_use'" 2>/dev/null | awk 'NR==2{print $2}')
    echo "{\"Binlog_cache_disk_use\": $binlog_cache_disk_use}"
}

# Get the value of Binlog cache disk use
binlog_cache_disk_use=$(get_binlog_cache_disk_use)

# Print the output
echo "$binlog_cache_disk_use"
