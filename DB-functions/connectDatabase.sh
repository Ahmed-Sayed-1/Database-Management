#! /bin/bash


 show(){
        select TableChoice in CreateTable ListTables DropTable InsertIntoTable SelectFromTable DeleteFromTable UpdateTable RetrunToMainMenu
        do
        case $TableChoice in        
        CreateTable)
            clear
            . ./Table-functions/createTable.sh
            show
            ;;
        ListTables)
            clear
            ls ./DataBase/$dbname
            clear
            show
            ;;
        DropTable)
            clear
            . ./Table-functions/dropTable.sh
            show
            ;;
        InsertIntoTable)
            clear
            . Table-functions/./InsertIntoTable.sh
            show
            ;;
        SelectFromTable)
            clear
            . ./Table-functions/selectFromTable.sh
            ;;
        DeleteFromTable)
            echo "Enter the name of the database"
            read dbname
            echo "Enter the name of the table"
            read tablename
            echo "Enter the data to delete"
            read data
            sed -i "/$data/d" $dbname/$tablename
            echo "Data deleted successfully"
            ;;
        RetrunToMainMenu)
            clear
            . ./main.sh
            ;;
            esac
            done
    }

    
    read -p "Enter the name of the database: " dbname
    if [ -d ./DataBase/$dbname ]
    then
        clear
       echo "Database selected successfully"
       show 
    else
        echo "Database does not exist"
    fi