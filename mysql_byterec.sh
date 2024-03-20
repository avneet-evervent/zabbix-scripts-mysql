#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the number of bytes received
get_mysql_bytes_received() {
    # Query MySQL for the number of bytes received and extract the value
    mysql_bytes_received=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Bytes_received'" 2>/dev/null | awk 'NR==2{print $2}')
    # Check if the value is empty, if so, set it to 0
    if [ -z "$mysql_bytes_received" ]; then
        mysql_bytes_received=0
    fi
    echo "{\"Bytes_received\": $mysql_bytes_received}"
}

# Get the number of bytes received
bytes_received=$(get_mysql_bytes_received)

# Print the output
echo "$bytes_received"
