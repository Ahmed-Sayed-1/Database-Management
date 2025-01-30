#! /bin/bash

shopt -s extglob 

DB-menu(){
 select Choice in CreateDatabase ListDatabases ConnectDB DropDatabase Exit

do

case $Choice in 

CreateDatabase)
    . DB-functions/createDatabase.sh
    DB-menu
    ;;
ListDatabases)
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
    echo "Enter the name of the database"
    read dbname
    rm -r $dbname
    echo "Database deleted successfully"
    DB-menu
    ;;
ConnectDB)
    . DB-functions/connectDatabase.sh
    DB-menu
    ;;
Exit)
    exit
    ;;
*)
    echo "Unknown choice"
    ;;
esac
done
}

DB-menu


