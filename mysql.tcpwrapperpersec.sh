#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the rate of connection errors caused by TCP wrapper per second
get_mysql_tcpwrap_connection_errors_per_second() {
    # Query MySQL for the value of connection errors caused by TCP wrapper and extract the value
    tcpwrap_errors=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Connection_errors_tcpwrap'" 2>/dev/null | awk 'NR==2{print $2}')
    echo "{\"Connection_errors_tcpwrap\": $tcpwrap_errors}"
}

# Get the rate of connection errors caused by TCP wrapper per second
tcpwrap_errors_per_second=$(get_mysql_tcpwrap_connection_errors_per_second)

# Print the output
echo "$tcpwrap_errors_per_second"
