#! /bin/bash

function delete_records() {
    local TBName=$1
    local metadata_file="./DataBase/$dbname/.$TBName-metadata"
    local data_file="./DataBase/$dbname/$TBName"
    local temp_file="./DataBase/$dbname/.temp"

    if [[ ! -f "$data_file" ]]; then
        echo "Table '$TBName' does not exist."
        return 1
    fi

    columns=($(awk -F: '{print $1}' "$metadata_file"))
    
    while true; do
        read -p "Delete all records? (y/n): " delete_all

        if [[ "$delete_all" == "y" || "$delete_all" == "n" ]]; then
            break  
        else
            echo "Invalid input. Please enter 'y' or 'n'."
        fi
    done
    
    if [[ "$delete_all" == "y" ]]; then
        > "$data_file"
        echo "All records deleted successfully"
        return 0
    fi

    echo "Select column for delete condition:"
    for i in "${!columns[@]}"; do
        echo "$((i+1))) ${columns[$i]}"
    done
    
    read -p "Column number: " where_col
    where_col=$((where_col-1))
    
    read -p "Enter value to delete: " where_value

    while IFS=: read -r -a record; do
        if [[ "${record[$where_col]}" != "$where_value" ]]; then
            echo "${record[*]}" | tr ' ' ':'
        fi
    done < "$data_file" > "$temp_file"

    mv "$temp_file" "$data_file"
    
    echo "Records deleted successfully"
}

read -r -p "Please Enter Table Name: " TBName
delete_records "$TBName"
tableMenu