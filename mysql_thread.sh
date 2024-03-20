#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the number of threads
get_mysql_threads() {
    # Query MySQL for the number of threads and extract the value
    mysql_threads=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Threads_connected'" 2>/dev/null | awk 'NR==2{print $2}')
    # Check if the value is empty, if so, set it to 0
    if [ -z "$mysql_threads" ]; then
        mysql_threads=0
    fi
    echo "{\"Threads_running\": $mysql_threads}"
}

# Get number of threads
threads=$(get_mysql_threads)

# Print the output
echo "$threads"
