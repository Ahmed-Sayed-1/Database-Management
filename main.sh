#! /bin/bash

shopt -s extglob 

DB-menu(){
    select Choice in CreateDatabase ListDatabases ConnectDB DropDatabase Exit

    do

    case $Choice in 

    CreateDatabase)
        clear
        . DB-functions/createDatabase.sh
        DB-menu
        ;;
    ListDatabases)
        clear
        count=$(ls DataBase | wc -l)
        if [[ $count -eq 0 ]]
        then
            echo "No databases found"
        else
            echo "List of databases:"
            ls DataBase
        fi
        DB-menu
        ;;
    DropDatabase)
        clear
        echo "Enter the name of the database"
        read dbname
        rm -rfI DataBase/$dbname
        echo "Database deleted successfully"
        DB-menu
        ;;
    ConnectDB)
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
        ;;
    esac
    done
}

DB-menu
