#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve slow queries per second
get_slow_queries_per_second() {
    # Query MySQL for slow queries per second and extract the value
    slow_queries=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Slow_queries'" 2>/dev/null | awk 'NR==2{print $2}')
    echo "{\"Slow_queries\": $slow_queries}"
}

# Get slow queries per second
slow_queries=$(get_slow_queries_per_second)

# Print the output
echo "$slow_queries"
