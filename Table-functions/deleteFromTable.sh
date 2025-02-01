#! /bin/bash

function delete_records() {
    local TBName=$1
    local metadata_file="./DataBase/$dbname/.$TBName-metadata"
    local data_file="./DataBase/$dbname/$TBName"

    if [[ ! -f "$data_file" ]]; then
        echo "Table '$TBName' does not exist."
        return 1
    fi

    columns=($(awk -F: '{print $1}' "$metadata_file"))
    data_types=($(awk -F: '{print $2}' "$metadata_file"))

    

}

read -p "Please Enter Table Name: " TBName
delete_records "$TBName"
