#! /bin/bash

 tableMenu(){
        select TableChoice in CreateTable ListTables DropTable InsertIntoTable SelectFromTable DeleteFromTable UpdateTable RetrunToMainMenu
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
        UpdateTable)
            clear
            . ./Table-functions/updateTable.sh
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
    
    if [ -z "$dbname" ] || [ ! -d "DataBase/$dbname" ]; 
    then
        echo "Database does not exist."
    else
        clear
        echo "Database connected successfully"
        tableMenu 
    fi