#! /bin/bash

read -p "Please Enter Table Name: " TBName
    
if [[ ! -f "./DataBase/$dbname/$TBName" ]]; then
        echo "Table does not exist."
        tableMenu
fi
    
metadata_file="./DataBase/$dbname/.$TBName-metadata"

columns=($(awk -F: '{print $1}' "$metadata_file"))
data_types=($(awk -F: '{print $2}' "$metadata_file"))
primary_key_index=$(awk -F: '{if ($3 == "pk") print NR-1}' "$metadata_file")

row=""
for ((i=0; i<${#columns[@]}; i++)); do
    while true; do
        read -p "Enter value for ${columns[$i]} (${data_types[$i]}): " value
            
        if [[ "${data_types[$i]}" == "integer" && ! "$value" =~ ^-?[0-9]+$ ]]; then
            echo "Invalid input. Expected an integer."
            continue
        elif [[ "${data_types[$i]}" == "boolean" && ! ("$value" == "true" || "$value" == "false") ]]; then
            echo "Invalid input. Expected 'true' or 'false'."
            continue
        fi
            
        if [[ "$primary_key_index" != "" && "$i" -eq "$primary_key_index" ]]; then
            
            if [[ -s "./DataBase/$dbname/$TBName" ]]; then
                while IFS= read -r line; do
                   IFS=":" read -r -a record <<< "$line"
                   if [[ "${record[$i]}" == "$value" ]]; then
                       echo "Primary key must be unique. Value already exists."
                       continue 2
                   fi
                done < "./DataBase/$dbname/$TBName"
            fi
        fi
        row+="$value:"
        break
    done
done
    
echo "${row%:}" >> "./DataBase/$dbname/$TBName"
echo "Record inserted successfully."