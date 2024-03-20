#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the number of threads connected
get_mysql_threads_connected() {
    # Query MySQL for the number of threads connected and extract the value
    mysql_threads_connected=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Threads_connected'" 2>/dev/null | awk 'NR==2{print $2}')
    # Check if the value is empty, if so, set it to 0
    if [ -z "$mysql_threads_connected" ]; then
        mysql_threads_connected=0
    fi
    echo "{\"Threads_connected\": $mysql_threads_connected}"
}

# Get number of threads connected
threads_connected=$(get_mysql_threads_connected)

# Print the output
echo "$threads_connected"
