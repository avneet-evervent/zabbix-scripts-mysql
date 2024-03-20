#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Retrieve MySQL version
mysql_version=$(mysql -sN -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT VERSION();" 2>/dev/null)

# Print the output in JSON format
echo "{\"mysql.version\": \"$mysql_version\"}"
