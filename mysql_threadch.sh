#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the number of cached threads
get_mysql_thread_cached() {
    # Query MySQL for the number of cached threads and extract the value
    mysql_thread_cached=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Threads_cached'" 2>/dev/null | awk 'NR==2{print $2}')
    # Check if the value is empty, if so, set it to 0
    if [ -z "$mysql_thread_cached" ]; then
        mysql_thread_cached=0
    fi
    echo "{\"Threads_cached\": $mysql_thread_cached}"
}

# Get the number of cached threads
threads_cached=$(get_mysql_thread_cached)

# Print the output
echo "$threads_cached"
