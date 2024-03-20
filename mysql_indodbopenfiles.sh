#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the value of InnoDB number of open files
get_innodb_open_files() {
    # Query MySQL for the value of InnoDB number of open files and extract the value
    innodb_open_files=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Innodb_num_open_files'" 2>/dev/null | awk 'NR==2{print $2}')
    echo "{\"Innodb_num_open_files\": $innodb_open_files}"
}

# Get the value of InnoDB number of open files
innodb_open_files=$(get_innodb_open_files)

# Print the output
echo "$innodb_open_files"
