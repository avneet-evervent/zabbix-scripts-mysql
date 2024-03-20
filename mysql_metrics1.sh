#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve MySQL uptime
get_mysql_uptime() {
    local uptime=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" --password="$MYSQL_PASSWORD" -sN -e "SHOW STATUS LIKE 'Uptime'" 2>&1 | grep -oP '\d+')
    if [[ "$uptime" =~ ^[0-9]+$ ]]; then
        echo "{\"Uptime\":$uptime}"
    else
        echo "Failed to retrieve MySQL uptime: $uptime"
    fi
}

# Execute the function to get MySQL uptime
get_mysql_uptime
