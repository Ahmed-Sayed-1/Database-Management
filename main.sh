#! /bin/bash

PS1="DBMS> "

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
    ls -d */
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
    break
    ;;
*)
    echo "Unknown choice"
    ;;
esac
done
}

DB-menu


