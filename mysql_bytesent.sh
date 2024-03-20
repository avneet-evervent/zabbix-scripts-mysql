#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the number of bytes sent
get_mysql_bytes_sent() {
    # Query MySQL for the number of bytes sent and extract the value
    mysql_bytes_sent=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Bytes_sent'" 2>/dev/null | awk 'NR==2{print $2}')
    # Check if the value is empty, if so, set it to 0
    if [ -z "$mysql_bytes_sent" ]; then
        mysql_bytes_sent=0
    fi
    echo "{\"Bytes_sent\": $mysql_bytes_sent}"
}

# Get the number of bytes sent
bytes_sent=$(get_mysql_bytes_sent)

# Print the output
echo "$bytes_sent"
