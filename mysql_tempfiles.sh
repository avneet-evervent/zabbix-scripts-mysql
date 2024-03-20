#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the rate of created temporary files on disk per second
get_mysql_tmp_files_created_per_second() {
    # Attempt to get the value of created tmp files on disk
    tmp_files_created=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Created_tmp_files'" 2>/dev/null | awk '$1 == "Created_tmp_files" {print $2}')

    # Check if tmp_files_created value is retrieved
    if [ -z "$tmp_files_created" ]; then
        tmp_files_created=0
    fi

    # Print the output with the expected key
    echo "{\"Created_tmp_files\": $tmp_files_created}"
}

# Get the rate of created temporary files on disk per second
tmp_files_created_per_second=$(get_mysql_tmp_files_created_per_second)

# Print the output
echo "$tmp_files_created_per_second"
