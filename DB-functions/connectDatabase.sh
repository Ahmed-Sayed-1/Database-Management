#! /bin/bash

 tableMenu(){
        select TableChoice in CreateTable ListTables DropTable InsertIntoTable SelectFromTable DeleteFromTable RetrunToMainMenu
        do
        case $TableChoice in        
        CreateTable)
            clear
            . ./Table-functions/createTable.sh
            tableMenu
            ;;
        ListTables)
            clear
            count=$(ls ./DataBase/$dbname | wc -l)
            if [[ $count -eq 0 ]]
            then
                echo "No table created"
            else
                echo "List of tables:"
                ls ./DataBase/$dbname
            fi
            tableMenu
            ;;
        DropTable)
            clear
            . ./Table-functions/dropTable.sh $dbname
            tableMenu
            ;;
        InsertIntoTable)
            clear
            . Table-functions/./InsertIntoTable.sh
            tableMenu
            ;;
        SelectFromTable)
            clear
            . ./Table-functions/selectFromTable.sh
            ;;
        DeleteFromTable)
            clear
            . ./Table-functions/deleteFromTable.sh
            ;;
        RetrunToMainMenu)
            clear
            . ./main.sh
            ;;
        *)
            clear
            echo "Unknown choice"
            tableMenu
            ;;
            esac
            done
    }

    read -p "Enter the name of the database: " dbname
    if [ -d ./DataBase/$dbname ]
    then
        clear
        echo "Database connected successfully"
        tableMenu 
    else
        echo "Database does not exist"
    fi