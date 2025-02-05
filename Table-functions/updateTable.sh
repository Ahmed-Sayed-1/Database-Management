#! /bin/bash

function update_records() {
    local TBName=$1
    local metadata_file="./DataBase/$dbname/.$TBName-metadata"
    local data_file="./DataBase/$dbname/$TBName"
    local temp_file="./DataBase/$dbname/.temp"

    if [[ ! -f "$data_file" ]]; then
        echo "Table '$TBName' does not exist."
        return 1
    fi

    columns=($(awk -F: '{print $1}' "$metadata_file"))
    data_types=($(awk -F: '{print $2}' "$metadata_file"))
    primary_key_index=$(awk -F: '{if ($3 == "pk") print NR-1}' "$metadata_file")

    if [[ -z "$primary_key_index" ]]; then
        echo "Error: No primary key column found in the table metadata."
        return 1
    fi

    read -p "Enter the value of the primary key for the record to update: " update_id

    record_found=false
    > "$temp_file" 

    while IFS=: read -r -a record; do
        if [[ "${record[$primary_key_index]}" == "$update_id" ]]; then
            record_found=true
            echo "Current values:"
            for i in "${!columns[@]}"; do
                echo "$((i+1))) ${columns[$i]}: ${record[$i]}"
            done

            echo -e "\nSelect columns to update (enter numbers separated by spaces):"
            read -r selection </dev/tty

            if [[ -z "$selection" ]]; then
                echo "No columns selected. No changes will be made."
                return 1
            fi

            selected_cols=()
            for col in $selection; do
                if [[ "$col" =~ ^[0-9]+$ ]]; then
                    selected_cols+=("$((col-1))")
                else
                    echo "Invalid input: '$col' is not a valid column number."
                    return 1
                fi
            done

            new_record=("${record[@]}")
            for index in "${selected_cols[@]}"; do
                while true; do
                    read -p "Enter new value for ${columns[$index]}: " value </dev/tty

                    if [[ -z "$value" ]]; then
                        echo "Empty value is not valid."
                        continue
                    fi

                    case "${data_types[$index]}" in
                        "integer")
                            if [[ ! "$value" =~ ^-?[0-9]+$ ]]; then
                                echo "Invalid input. Expected data type: integer."
                                continue
                            fi
                            ;;
                        "boolean")
                            if [[ ! "$value" =~ ^(true|false)$ ]]; then
                                echo "Invalid input. Expected data type: boolean (true/false)."
                                continue
                            fi
                            ;;
                    esac

                    if [[ "$index" -eq "$primary_key_index" ]]; then
                        pk_exists=false
                        while IFS=: read -r -a existing_record; do
                            if [[ "${existing_record[$primary_key_index]}" == "$value" ]]; then
                                pk_exists=true
                                break
                            fi
                        done < "$data_file"

                        if $pk_exists; then
                            echo "Primary key must be unique. The value '$value' already exists."
                            continue
                        fi
                    fi

                    new_record[$index]="$value"
                    break
                done
            done

            echo "${new_record[*]}" | tr ' ' ':' >> "$temp_file"
        else
            echo "${record[*]}" | tr ' ' ':' >> "$temp_file"
        fi
    done < "$data_file"

    if ! $record_found; then
        echo "Record with primary key '$update_id' not found."
        rm "$temp_file"
        return 1
    fi

    mv "$temp_file" "$data_file"
    echo "Record updated successfully."
}

read -p "Please Enter Table Name: " TBName
update_records "$TBName"
tableMenu