#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Query MySQL for queries per second and extract numeric value
queries_per_second=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -s -N -e "SHOW GLOBAL STATUS LIKE 'Queries';" 2>/dev/null | awk '{print $2}')

# Format the output as JSON
echo "{\"Queries\": $queries_per_second}"
