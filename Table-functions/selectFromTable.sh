#! /bin/bash

function select_records() {
    local TBName=$1
    local metadata_file="./DataBase/$dbname/.$TBName-metadata"
    local data_file="./DataBase/$dbname/$TBName"

    if [[ ! -f "$data_file" ]]; then
        echo "Table '$TBName' does not exist."
        return 1
    fi

    columns=($(awk -F: '{print $1}' "$metadata_file"))
    data_types=($(awk -F: '{print $2}' "$metadata_file"))

    echo "Select columns (enter numbers separated by spaces, or * for all):"
    for i in "${!columns[@]}"; do
        echo "$((i+1))) ${columns[$i]}"
    done

    read -p "Enter your selection: " selection

    if [[ "$selection" == "*" ]]; then
        selected_cols=("${!columns[@]}")
    else
        selected_cols=($(echo "$selection" | tr ' ' '\n' | awk '{print $1-1}'))
    fi

    read -p "Add WHERE clause? (y/n): " use_where
    if [[ "$use_where" == "y" ]]; then
        echo "Select column for condition:"
        for i in "${!columns[@]}"; do
            echo "$((i+1))) ${columns[$i]}"
        done
        read -p "Column number: " where_col
        where_col=$((where_col-1))
        
        read -p "Enter condition value: " where_value
    fi

    echo -e "\nResults:"
    for i in "${selected_cols[@]}"; do
        printf "%-15s" "${columns[$i]}"
    done
    echo -e "\n$(printf '%.0s-' {1..60})"

    while IFS=: read -r -a record; do
        if [[ "$use_where" == "y" ]]; then
            if [[ "${record[$where_col]}" != "$where_value" ]]; then
                continue
            fi
        fi
        
        for i in "${selected_cols[@]}"; do
            printf "%-15s" "${record[$i]}"
        done
        echo
    done < "$data_file"
}

read -p "Please Enter Table Name: " TBName
select_records "$TBName"
show