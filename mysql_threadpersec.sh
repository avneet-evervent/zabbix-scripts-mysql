#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor1"
MYSQL_PASSWORD="password"
MYSQL_HOST="localhost"

# Function to retrieve the number of threads created per second
get_mysql_threads_created_per_sec() {
    # Get the initial number of threads created
    initial_threads=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Threads_created'" 2>/dev/null | awk 'NR==2{print $2}')
    sleep 1  # Wait for a short interval to ensure accurate measurement
    # Get the number of threads created again
    final_threads=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Threads_created'" 2>/dev/null | awk 'NR==2{print $2}')
    # Calculate the difference
    threads_created=$((final_threads - initial_threads))
    # Calculate the rate per second
    threads_created_per_sec=$(bc <<< "scale=2; $threads_created / 1")
    echo "{\"Threads_created\": $threads_created_per_sec}"
}

# Get threads created per second
threads_created_per_sec=$(get_mysql_threads_created_per_sec)

# Print the output
echo "$threads_created_per_sec"
