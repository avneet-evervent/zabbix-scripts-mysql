#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve the rate of created temporary tables on memory per second
get_mysql_tmp_tables_created_on_memory_per_second() {
    # Attempt to get the value of created tmp tables on memory
    tmp_tables_created_on_memory=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Created_tmp_tables'" 2>/dev/null | awk '$1 == "Created_tmp_tables" {print $2}')

    # Check if tmp_tables_created_on_memory value is retrieved
    if [ -z "$tmp_tables_created_on_memory" ]; then
        tmp_tables_created_on_memory=0
    fi

    # Print the output with the correct key
    echo "{\"Created_tmp_tables\": $tmp_tables_created_on_memory}"
}

# Get the rate of created temporary tables on memory per second
tmp_tables_created_on_memory_per_second=$(get_mysql_tmp_tables_created_on_memory_per_second)

# Print the output
echo "$tmp_tables_created_on_memory_per_second"
