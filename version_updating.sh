#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <directory> <search_string> <replace_string>"
    exit 1
fi

# Assign arguments to variables
DIRECTORY=$1
SEARCH_STRING=$2
REPLACE_STRING=$3

# Find and replace the string in each file, skipping binary files
find "$DIRECTORY" -type f | while read -r file; do
    if file "$file" | grep -q text; then
        sed -i.bak "s/${SEARCH_STRING}/${REPLACE_STRING}/g" "$file"
        # Remove backup file created by sed
        rm "${file}.bak"
    fi
done

echo "Replacement complete."