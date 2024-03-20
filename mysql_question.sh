#!/bin/bash

# MySQL credentials
MYSQL_USER="zbx_monitor"
MYSQL_PASSWORD="Password@123"
MYSQL_HOST="localhost"

# Function to retrieve questions per second
get_questions_per_second() {
    # Query MySQL for questions per second and extract the value
    questions_per_second=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW GLOBAL STATUS LIKE 'Questions'" 2>/dev/null | awk 'NR==2{print $2}')
    # Check if the value is empty, if so, set it to 0
    if [ -z "$questions_per_second" ]; then
        questions_per_second=0
    fi
    echo "{\"Questions\": $questions_per_second}"
}

# Get questions per second
questions_per_second=$(get_questions_per_second)

# Print the output
echo "$questions_per_second"
