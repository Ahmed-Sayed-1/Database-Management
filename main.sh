#! /bin/bash

shopt -s extglob 

DB-menu(){
    select Choice in CreateDatabase ListDatabase ConnectDatabase DropDatabase Exit

    do

    case $Choice in 

    CreateDatabase)
        clear
        . DB-functions/createDatabase.sh
        DB-menu
        ;;
    ListDatabase)
        clear
        count=$(ls DataBase | wc -l)
        if [[ $count -eq 0 ]]
        then
            echo "No database found"
        else
            echo "List of databases:"
            ls DataBase
        fi
        DB-menu
        ;;
    DropDatabase)
        clear 
        read -p "Enter the name of the database: " dbname

        if [ -z "$dbname" ] || [ ! -d "DataBase/$dbname" ]; then
            echo "Database does not exist."
        else
            rm -rfI DataBase/"$dbname"
            if [ -d "DataBase/$dbname" ]; then
                echo "Deletion was canceled or failed."
            else
                echo "Database successfully deleted."
            fi
        fi
        DB-menu
        ;;
    ConnectDatabase)
        clear
        . DB-functions/connectDatabase.sh
        DB-menu
        ;;
    Exit)
        clear
        exit
        ;;
    *)
        clear
        echo "Unknown choice"
        DB-menu
        ;;
    esac
    done
}

DB-menu
